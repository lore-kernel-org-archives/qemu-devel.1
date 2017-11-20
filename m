Received: from eggs.gnu.org ([2001:4830:134:3::10]:36049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eGldw-0000Xv-AI
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 07:57:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eGldt-0003La-9U
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 07:57:44 -0500
Date: Mon, 20 Nov 2017 13:57:34 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171120135734.23a4e4a1.cohuck@redhat.com>
In-Reply-To: <20171120123525.147663-2-borntraeger@de.ibm.com>
References: <20171120123525.147663-1-borntraeger@de.ibm.com>
	<20171120123525.147663-2-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>

On Mon, 20 Nov 2017 13:35:24 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> valgrind pointed out that we call KVM_S390_GET_IRQ_STATE with an
> undefined value for flags. Right now this is unused, but we
> better play safe.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/kvm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 343fcec..b0439a1 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -2069,7 +2069,10 @@ int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state)
>  
>  void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu)
>  {
> -    struct kvm_s390_irq_state irq_state;
> +    struct kvm_s390_irq_state irq_state = {
> +        .buf = (uint64_t) cpu->irqstate,
> +        .len = VCPU_IRQ_BUF_SIZE,
> +    };
>      CPUState *cs = CPU(cpu);
>      int32_t bytes;
>  
> @@ -2077,9 +2080,6 @@ void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu)
>          return;
>      }
>  
> -    irq_state.buf = (uint64_t) cpu->irqstate;
> -    irq_state.len = VCPU_IRQ_BUF_SIZE;
> -
>      bytes = kvm_vcpu_ioctl(cs, KVM_S390_GET_IRQ_STATE, &irq_state);
>      if (bytes < 0) {
>          cpu->irqstate_saved_size = 0;

I'm wondering why it does not also complain for KVM_S390_SET_IRQ_STATE?
It would make sense to use a struct initializer there as well.
