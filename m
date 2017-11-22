Received: from eggs.gnu.org ([2001:4830:134:3::10]:45446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHWFE-0007GA-Jv
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:43:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHWFA-0003qP-Ki
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:43:20 -0500
Date: Wed, 22 Nov 2017 15:43:09 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171122154309.27027346.cohuck@redhat.com>
In-Reply-To: <20171122142627.73170-2-borntraeger@de.ibm.com>
References: <20171122142627.73170-1-borntraeger@de.ibm.com>
	<20171122142627.73170-2-borntraeger@de.ibm.com>
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

On Wed, 22 Nov 2017 15:26:26 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> valgrind pointed out that we call KVM_S390_GET_IRQ_STATE with an
> undefined value for flags. Right now this is unused, but we
> better play safe.
> The same is true for SET_IRQ_STATE. While QEMU is now fixed in
> that regard, we should make sure to not use the flag and pad
> fields in the kernel. A corresponding kernel documentation patch
> will be submitted later.

I'd reword this a bit; it is confusing to read changelogs describing a
then-future change which already happened. (I assume that we will do
the kernel sanitizing for 4.15?)

"valgrind pointed out that we call KVM_S390_GET_IRQ_STATE with an
undefined value for flags. Kernels prior to 4.15 did not use that
field, and later kernels ignore it for compatibility reasons, but we
better play safe.

The same is true for SET_IRQ_STATE. We should make sure to not use the
flag field, either."

[I do not see a 'pad' field in the structure; that is a bug in the
kernel documentation.]

> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/kvm.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 343fcec..76065ec 100644
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
> @@ -2093,7 +2093,10 @@ void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu)
>  int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu)
>  {
>      CPUState *cs = CPU(cpu);
> -    struct kvm_s390_irq_state irq_state;
> +    struct kvm_s390_irq_state irq_state = {
> +        .buf = (uint64_t) cpu->irqstate,
> +        .len = cpu->irqstate_saved_size,
> +    };
>      int r;
>  
>      if (cpu->irqstate_saved_size == 0) {
> @@ -2104,9 +2107,6 @@ int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu)
>          return -ENOSYS;
>      }
>  
> -    irq_state.buf = (uint64_t) cpu->irqstate;
> -    irq_state.len = cpu->irqstate_saved_size;
> -
>      r = kvm_vcpu_ioctl(cs, KVM_S390_SET_IRQ_STATE, &irq_state);
>      if (r) {
>          error_report("Setting interrupt state failed %d", r);

Patch looks good.
