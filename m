Received: from eggs.gnu.org ([2001:4830:134:3::10]:44886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dAtcY-0001cs-EL
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:43:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dAtcU-00038B-Fk
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:43:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dAtcU-00037q-6b
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:43:42 -0400
Date: Wed, 17 May 2017 03:43:39 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1280755991.8446336.1495007019282.JavaMail.zimbra@redhat.com>
In-Reply-To: <B2D15215269B544CADD246097EACE747395C283F@dggeml511-mbx.china.huawei.com>
References: <830bfc39-56c7-a901-9ebb-77d6e7a5614c@huawei.com>
	<874lxeovrg.fsf@secure.mitica>
	<7cd332ec-48d4-1feb-12e2-97b50b04e028@huawei.com>
	<20170424164244.GJ2362@work-vm>
	<B2D15215269B544CADD246097EACE747395AD759@dggeml511-mbx.china.huawei.com>
	<85e3a0dd-20c8-8ff2-37ce-bfdf543e7787@redhat.com>
	<CANRm+CzvNpLGqH5KuqqO7Wh7UabSkMBbxuTymbM0CZPgpQOwCg@mail.gmail.com>
	<B2D15215269B544CADD246097EACE747395C283F@dggeml511-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] About QEMU BQL and dirty log switch in Migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Cc: Wanpeng Li <kernellwp@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, yanghongyang <yanghongyang@huawei.com>, quintela@redhat.com, "wangxin (U)" <wangxinxin.wang@huawei.com>, qemu-devel@nongnu.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>, Huangzhichao <huangzhichao@huawei.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "Herongguang (Stephen)" <herongguang.he@huawei.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, "Huangweidong (C)" <weidong.huang@huawei.com>

> Recently, I have tested the performance before migration and after migration failure
> using spec cpu2006 https://www.spec.org/cpu2006/, which is a standard performance
> evaluation tool.
>
> These are the steps:
> ======
>  (1) the version of kmod is 4.4.11(with slightly modified) and the version of
>  qemu is 2.6.0
>     (with slightly modified), the kmod is applied with the following patch
> 
> diff --git a/source/x86/x86.c b/source/x86/x86.c
> index 054a7d3..75a4bb3 100644
> --- a/source/x86/x86.c
> +++ b/source/x86/x86.c
> @@ -8550,8 +8550,10 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>          */
>         if ((change != KVM_MR_DELETE) &&
>                 (old->flags & KVM_MEM_LOG_DIRTY_PAGES) &&
> -               !(new->flags & KVM_MEM_LOG_DIRTY_PAGES))
> -               kvm_mmu_zap_collapsible_sptes(kvm, new);
> +               !(new->flags & KVM_MEM_LOG_DIRTY_PAGES)) {
> +               printk(KERN_ERR "zj make KVM_REQ_MMU_RELOAD request\n");
> +               kvm_make_all_cpus_request(kvm, KVM_REQ_MMU_RELOAD);
> +       }
>  
>         /*
>          * Set up write protection and/or dirty logging for the new slot.

Try these modifications to the setup:

1) set up 1G hugetlbfs hugepages and use those for the guest's memory

2) test both without and with the above patch.

Thanks,

Paolo
