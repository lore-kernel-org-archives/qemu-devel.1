Received: from eggs.gnu.org ([2001:4830:134:3::10]:37587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dGMxc-00075n-I7
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 06:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dGMxZ-0006v0-EI
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 06:04:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dGMxZ-0006uq-8l
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 06:04:05 -0400
References: <1495865408-13848-1-git-send-email-arei.gonglei@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bdb80431-8046-2e2d-4645-6ff23676ceab@redhat.com>
Date: Thu, 1 Jun 2017 12:04:01 +0200
MIME-Version: 1.0
In-Reply-To: <1495865408-13848-1-git-send-email-arei.gonglei@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] kvm: don't register smram_listener when
 smm is off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org
Cc: yechuan@huawei.com



On 27/05/2017 08:10, Gonglei wrote:
> If the user set disable smm by '-machine smm=off', we
> should not register smram_listener so that we can
> avoid waster memory in kvm since the added sencond
> address space.
> 
> Meanwhile we should assign value of the global kvm_state
> before invoking the kvm_arch_init(), because
> pc_machine_is_smm_enabled() may use it by kvm_has_mm().
> 
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> ---
>  kvm-all.c         | 4 ++--
>  target/i386/kvm.c | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kvm-all.c b/kvm-all.c
> index 90b8573..92bdf2c 100644
> --- a/kvm-all.c
> +++ b/kvm-all.c
> @@ -1746,6 +1746,8 @@ static int kvm_init(MachineState *ms)
>      kvm_ioeventfd_any_length_allowed =
>          (kvm_check_extension(s, KVM_CAP_IOEVENTFD_ANY_LENGTH) > 0);
>  
> +    kvm_state = s;
> +
>      ret = kvm_arch_init(ms, s);
>      if (ret < 0) {
>          goto err;
> @@ -1755,8 +1757,6 @@ static int kvm_init(MachineState *ms)
>          kvm_irqchip_create(ms, s);
>      }
>  
> -    kvm_state = s;
> -
>      if (kvm_eventfds_allowed) {
>          s->memory_listener.listener.eventfd_add = kvm_mem_ioeventfd_add;
>          s->memory_listener.listener.eventfd_del = kvm_mem_ioeventfd_del;
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 011d4a5..cb5b47e 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1254,7 +1254,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>          }
>      }
>  
> -    if (kvm_check_extension(s, KVM_CAP_X86_SMM)) {
> +    if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
> +            pc_machine_is_smm_enabled(PC_MACHINE(ms))) {
>          smram_machine_done.notify = register_smram_listener;
>          qemu_add_machine_init_done_notifier(&smram_machine_done);
>      }
> 

I think this breaks

    x86_64-softmmu/qemu-system-x86_64 -M none -S --enable-kvm

You need to do a object_dynamic_cast before invoking PC_MACHINE(ms).

Thanks,

Paolo
