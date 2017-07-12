Received: from eggs.gnu.org ([2001:4830:134:3::10]:54111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVL07-0000bc-1y
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVL03-0007qg-6w
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:00:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dVL03-0007qX-11
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:00:31 -0400
References: <1499850727-50728-1-git-send-email-peng.hao2@zte.com.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7cdaad86-333a-4b7b-1c91-09ad6e036ecd@redhat.com>
Date: Wed, 12 Jul 2017 19:00:26 +0200
MIME-Version: 1.0
In-Reply-To: <1499850727-50728-1-git-send-email-peng.hao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target-i386:kvm_get/put_vcpu_events don't
 handle sipi_vector
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>, rth@twiddle.net, ehabkost@redhat.com, kvm@vger.kernel.org, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, "J. Kiszka" <jan.kiszka@siemens.com>

On 12/07/2017 11:12, Peng Hao wrote:
> qemu call kvm_get_vcpu_events, and kernel return sipi_vector always 0,
> never valid when reporting to user space. But qemu call kvm_put_vcpu_ev=
ents
> will make sipi_vector in kernel be 0. This will accidently modify sipi_=
vector
> when sipi_vector in kernel is not 0.
>=20
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> Reviewed-by: Wang Yechao <wang.yechao255@zte.com.cn>
> ---
>  target/i386/kvm.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index f84a49d..bbbd696 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -2417,7 +2417,6 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int l=
evel)
>      events.nmi.masked =3D !!(env->hflags2 & HF2_NMI_MASK);
>      events.nmi.pad =3D 0;
> =20
> -    events.sipi_vector =3D env->sipi_vector;
>      events.flags =3D 0;
> =20
>      if (has_msr_smbase) {

This should clear KVM_VCPUEVENT_VALID_SIPI_VECTOR in the "if" statement
below.  Otherwise, you're passing a random value to the kernel.

> @@ -2506,8 +2505,6 @@ static int kvm_get_vcpu_events(X86CPU *cpu)
>          }
>      }
> =20
> -    env->sipi_vector =3D events.sipi_vector;
> -
>      return 0;
>  }
> =20
>=20

I think what you're seeing is a race like this:

	VCPU 0					VCPU 1
	[qemu] kvm_get_mp_state
	  [kvm] kvm_apic_accept_events
						__apic_accept_irq
						  set KVM_APIC_SIPI
	[qemu] kvm_get_vcpu_events

If this is what happens happen, the fix is to call the functions in this
order:

- first kvm_get_vcpu_events

- then kvm_get_mp_state

- then all the others.

This way you have:

	VCPU 0					VCPU 1
	[qemu] kvm_get_vcpu_events
						__apic_accept_irq
						  set KVM_APIC_SIPI
	[qemu] kvm_get_mp_state
	  [kvm] kvm_apic_accept_events
	     [kvm] kvm_vcpu_deliver_sipi_vector
	        // this modifies CS and RIP!!!
	[qemu] kvm_getput_regs
	  // reads RIP
	...
	[qemu] kvm_getput_sregs
	  // reads CS
	...

and the sipi_vector is never lost.

Paolo
