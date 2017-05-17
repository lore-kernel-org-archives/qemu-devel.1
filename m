Received: from eggs.gnu.org ([2001:4830:134:3::10]:56763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1dAuTX-0007E1-0K
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:38:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1dAuTV-0002yE-Uc
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:38:31 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:35193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1dAuTV-0002y9-O8
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:38:29 -0400
Received: by mail-oi0-x242.google.com with SMTP id m17so958565oik.2
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 01:38:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1280755991.8446336.1495007019282.JavaMail.zimbra@redhat.com>
References: <830bfc39-56c7-a901-9ebb-77d6e7a5614c@huawei.com>
	<874lxeovrg.fsf@secure.mitica>
	<7cd332ec-48d4-1feb-12e2-97b50b04e028@huawei.com>
	<20170424164244.GJ2362@work-vm>
	<B2D15215269B544CADD246097EACE747395AD759@dggeml511-mbx.china.huawei.com>
	<85e3a0dd-20c8-8ff2-37ce-bfdf543e7787@redhat.com>
	<CANRm+CzvNpLGqH5KuqqO7Wh7UabSkMBbxuTymbM0CZPgpQOwCg@mail.gmail.com>
	<B2D15215269B544CADD246097EACE747395C283F@dggeml511-mbx.china.huawei.com>
	<1280755991.8446336.1495007019282.JavaMail.zimbra@redhat.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Wed, 17 May 2017 16:38:28 +0800
Message-ID: <CANRm+CwbTaoxq35zyfNF1BP3d5GqRmtq0sY+aRKRaOsFwGB1Mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] About QEMU BQL and dirty log switch in Migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, yanghongyang <yanghongyang@huawei.com>, Juan Quintela <quintela@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, Huangzhichao <huangzhichao@huawei.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "Herongguang (Stephen)" <herongguang.he@huawei.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, "Huangweidong (C)" <weidong.huang@huawei.com>

2017-05-17 15:43 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
>> Recently, I have tested the performance before migration and after migration failure
>> using spec cpu2006 https://www.spec.org/cpu2006/, which is a standard performance
>> evaluation tool.
>>
>> These are the steps:
>> ======
>>  (1) the version of kmod is 4.4.11(with slightly modified) and the version of
>>  qemu is 2.6.0
>>     (with slightly modified), the kmod is applied with the following patch
>>
>> diff --git a/source/x86/x86.c b/source/x86/x86.c
>> index 054a7d3..75a4bb3 100644
>> --- a/source/x86/x86.c
>> +++ b/source/x86/x86.c
>> @@ -8550,8 +8550,10 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>>          */
>>         if ((change != KVM_MR_DELETE) &&
>>                 (old->flags & KVM_MEM_LOG_DIRTY_PAGES) &&
>> -               !(new->flags & KVM_MEM_LOG_DIRTY_PAGES))
>> -               kvm_mmu_zap_collapsible_sptes(kvm, new);
>> +               !(new->flags & KVM_MEM_LOG_DIRTY_PAGES)) {
>> +               printk(KERN_ERR "zj make KVM_REQ_MMU_RELOAD request\n");
>> +               kvm_make_all_cpus_request(kvm, KVM_REQ_MMU_RELOAD);
>> +       }
>>
>>         /*
>>          * Set up write protection and/or dirty logging for the new slot.
>
> Try these modifications to the setup:
>
> 1) set up 1G hugetlbfs hugepages and use those for the guest's memory
>
> 2) test both without and with the above patch.
>

In addition, we can compare /sys/kernel/debug/kvm/largepages w/ and
w/o the patch. IIRC, /sys/kernel/debug/kvm/largepages will drop during
live migration, it will keep a small value if live migration fails and
w/o "lazy collapse small sptes into large sptes" codes, however, it
will increase gradually if w/ the "lazy collapse small sptes into
large sptes" codes.

Regards,
Wanpeng Li
