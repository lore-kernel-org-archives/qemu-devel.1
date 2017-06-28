Received: from eggs.gnu.org ([2001:4830:134:3::10]:49585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dQCWt-0001us-NS
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dQCWs-0005Wi-7c
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:57:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dQCWr-0005WF-Uo
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:57:10 -0400
References: <1498652927-10554-1-git-send-email-wanpeng.li@hotmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2a7b199e-311c-2939-eb8c-2504dd483451@redhat.com>
Date: Wed, 28 Jun 2017 14:57:05 +0200
MIME-Version: 1.0
In-Reply-To: <1498652927-10554-1-git-send-email-wanpeng.li@hotmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] KVM: Add async pf flag to
 KVM_GET/SET_VCPU_EVENTS interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wanpeng Li <kernellwp@gmail.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Wanpeng Li <wanpeng.li@hotmail.com>



On 28/06/2017 14:28, Wanpeng Li wrote:
> From: Wanpeng Li <wanpeng.li@hotmail.com>
>=20
> This patch adds async page fault flag to KVM_GET/SET_VCPU_EVENTS interf=
ace.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
> ---
> v2 -> v3:
>  * nested_apf for vcpu events
> v1 -> v2:
>  * reuse the pad for async_page_fault
>  * cleanup coding style
>=20
>  linux-headers/asm-x86/kvm.h | 3 ++-
>  target/i386/cpu.h           | 1 +
>  target/i386/kvm.c           | 8 ++++++--
>  3 files changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
> index c2824d0..27b368b 100644
> --- a/linux-headers/asm-x86/kvm.h
> +++ b/linux-headers/asm-x86/kvm.h
> @@ -287,6 +287,7 @@ struct kvm_reinject_control {
>  #define KVM_VCPUEVENT_VALID_SIPI_VECTOR	0x00000002
>  #define KVM_VCPUEVENT_VALID_SHADOW	0x00000004
>  #define KVM_VCPUEVENT_VALID_SMM		0x00000008
> +#define KVM_VCPUEVENT_VALID_ASYNC_PF 0x00000010
> =20
>  /* Interrupt shadow states */
>  #define KVM_X86_SHADOW_INT_MOV_SS	0x01
> @@ -298,7 +299,7 @@ struct kvm_vcpu_events {
>  		__u8 injected;
>  		__u8 nr;
>  		__u8 has_error_code;
> -		__u8 pad;
> +		__u8 nested_apf;
>  		__u32 error_code;
>  	} exception;
>  	struct {
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index cfe825f..90cb692 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1105,6 +1105,7 @@ typedef struct CPUX86State {
> =20
>      /* exception/interrupt handling */
>      int error_code;
> +    uint8_t async_page_fault;
>      int exception_is_int;
>      target_ulong exception_next_eip;
>      target_ulong dr[8]; /* debug registers; note dr4 and dr5 are unuse=
d */
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 49b6115..b2405ec 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -2491,8 +2491,8 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int l=
evel)
>      events.exception.injected =3D (env->exception_injected >=3D 0);
>      events.exception.nr =3D env->exception_injected;
>      events.exception.has_error_code =3D env->has_error_code;
> +    events.exception.nested_apf =3D env->async_page_fault;
>      events.exception.error_code =3D env->error_code;
> -    events.exception.pad =3D 0;
> =20
>      events.interrupt.injected =3D (env->interrupt_injected >=3D 0);
>      events.interrupt.nr =3D env->interrupt_injected;
> @@ -2531,7 +2531,8 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int l=
evel)
> =20
>      if (level >=3D KVM_PUT_RESET_STATE) {
>          events.flags |=3D
> -            KVM_VCPUEVENT_VALID_NMI_PENDING | KVM_VCPUEVENT_VALID_SIPI=
_VECTOR;
> +            KVM_VCPUEVENT_VALID_NMI_PENDING | KVM_VCPUEVENT_VALID_SIPI=
_VECTOR |
> +                    KVM_VCPUEVENT_VALID_ASYNC_PF;
>      }
> =20
>      return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU_EVENTS, &events);
> @@ -2555,6 +2556,9 @@ static int kvm_get_vcpu_events(X86CPU *cpu)
>      env->exception_injected =3D
>         events.exception.injected ? events.exception.nr : -1;
>      env->has_error_code =3D events.exception.has_error_code;
> +    if (events.flags & KVM_VCPUEVENT_VALID_ASYNC_PF) {
> +        env->async_page_fault =3D events.exception.nested_apf;
> +    }
>      env->error_code =3D events.exception.error_code;
> =20
>      env->interrupt_injected =3D
>=20

You are missing the code in machine.c to transmit this (in a new
subsection).  But let's iron out the KVM parts first of all.

Paolo
