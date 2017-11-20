Received: from eggs.gnu.org ([2001:4830:134:3::10]:38263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eGli9-0002ox-O0
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:02:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eGli3-0005RB-Nr
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:02:05 -0500
References: <20171120123525.147663-1-borntraeger@de.ibm.com>
	<20171120123525.147663-2-borntraeger@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3cf122b0-b258-136c-a33d-770ca51638f4@redhat.com>
Date: Mon, 20 Nov 2017 14:01:29 +0100
MIME-Version: 1.0
In-Reply-To: <20171120123525.147663-2-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] s390x/migration: use zero flag
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Jens Freimann <jfreimann@redhat.com>

On 20.11.2017 13:35, Christian Borntraeger wrote:
> valgrind pointed out that we call KVM_S390_GET_IRQ_STATE with an
> undefined value for flags. Right now this is unused, but we
> better play safe.
>=20
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/kvm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 343fcec..b0439a1 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -2069,7 +2069,10 @@ int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t=
 cpu_state)
> =20
>  void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu)
>  {
> -    struct kvm_s390_irq_state irq_state;
> +    struct kvm_s390_irq_state irq_state =3D {
> +        .buf =3D (uint64_t) cpu->irqstate,
> +        .len =3D VCPU_IRQ_BUF_SIZE,
> +    };
>      CPUState *cs =3D CPU(cpu);
>      int32_t bytes;
> =20
> @@ -2077,9 +2080,6 @@ void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cp=
u)
>          return;
>      }
> =20
> -    irq_state.buf =3D (uint64_t) cpu->irqstate;
> -    irq_state.len =3D VCPU_IRQ_BUF_SIZE;
> -
>      bytes =3D kvm_vcpu_ioctl(cs, KVM_S390_GET_IRQ_STATE, &irq_state);
>      if (bytes < 0) {
>          cpu->irqstate_saved_size =3D 0;
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>

BTW, should we have a check in the kernel that flags is properly set to
zero?

 Thomas
