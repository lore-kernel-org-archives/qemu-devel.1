Received: from eggs.gnu.org ([2001:4830:134:3::10]:34438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dBdLF-0006Ox-9B
	for qemu-devel@nongnu.org; Fri, 19 May 2017 04:32:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dBdLC-0005JI-50
	for qemu-devel@nongnu.org; Fri, 19 May 2017 04:32:57 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:33377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1dBdLB-0005Io-W2
	for qemu-devel@nongnu.org; Fri, 19 May 2017 04:32:54 -0400
Received: by mail-pf0-x242.google.com with SMTP id f27so8824534pfe.0
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 01:32:53 -0700 (PDT)
From: Xiao Guangrong <guangrong.xiao@gmail.com>
References: <830bfc39-56c7-a901-9ebb-77d6e7a5614c@huawei.com>
	<874lxeovrg.fsf@secure.mitica>
	<7cd332ec-48d4-1feb-12e2-97b50b04e028@huawei.com>
	<20170424164244.GJ2362@work-vm>
	<B2D15215269B544CADD246097EACE747395AD759@dggeml511-mbx.china.huawei.com>
	<85e3a0dd-20c8-8ff2-37ce-bfdf543e7787@redhat.com>
	<CANRm+CzvNpLGqH5KuqqO7Wh7UabSkMBbxuTymbM0CZPgpQOwCg@mail.gmail.com>
	<B2D15215269B544CADD246097EACE747395C283F@dggeml511-mbx.china.huawei.com>
	<1280755991.8446336.1495007019282.JavaMail.zimbra@redhat.com>
	<CANRm+CwbTaoxq35zyfNF1BP3d5GqRmtq0sY+aRKRaOsFwGB1Mw@mail.gmail.com>
	<591EA84D.1030800@huawei.com>
Message-ID: <32e3c2ed-2a41-0c20-2cc8-eb51e9de236b@gmail.com>
Date: Fri, 19 May 2017 16:32:54 +0800
MIME-Version: 1.0
In-Reply-To: <591EA84D.1030800@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: Jay Zhou <jianjay.zhou@huawei.com>, Wanpeng Li <kernellwp@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, yanghongyang <yanghongyang@huawei.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, Huangzhichao <huangzhichao@huawei.com>, "Herongguang (Stephen)" <herongguang.he@huawei.com>


I do not know why i was removed from the list.


On 05/19/2017 04:09 PM, Jay Zhou wrote:
> Hi Paolo and Wanpeng,
> 
> On 2017/5/17 16:38, Wanpeng Li wrote:
>> 2017-05-17 15:43 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
>>>> Recently, I have tested the performance before migration and after migration failure
>>>> using spec cpu2006 https://www.spec.org/cpu2006/, which is a standard performance
>>>> evaluation tool.
>>>>
>>>> These are the steps:
>>>> ======
>>>>   (1) the version of kmod is 4.4.11(with slightly modified) and the version of
>>>>   qemu is 2.6.0
>>>>      (with slightly modified), the kmod is applied with the following patch
>>>>
>>>> diff --git a/source/x86/x86.c b/source/x86/x86.c
>>>> index 054a7d3..75a4bb3 100644
>>>> --- a/source/x86/x86.c
>>>> +++ b/source/x86/x86.c
>>>> @@ -8550,8 +8550,10 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>>>>           */
>>>>          if ((change != KVM_MR_DELETE) &&
>>>>                  (old->flags & KVM_MEM_LOG_DIRTY_PAGES) &&
>>>> -               !(new->flags & KVM_MEM_LOG_DIRTY_PAGES))
>>>> -               kvm_mmu_zap_collapsible_sptes(kvm, new);
>>>> +               !(new->flags & KVM_MEM_LOG_DIRTY_PAGES)) {
>>>> +               printk(KERN_ERR "zj make KVM_REQ_MMU_RELOAD request\n");
>>>> +               kvm_make_all_cpus_request(kvm, KVM_REQ_MMU_RELOAD);
>>>> +       }
>>>>
>>>>          /*
>>>>           * Set up write protection and/or dirty logging for the new slot.
>>>
>>> Try these modifications to the setup:
>>>
>>> 1) set up 1G hugetlbfs hugepages and use those for the guest's memory
>>>
>>> 2) test both without and with the above patch.
>>>
> 
> In order to avoid random memory allocation issues, I reran the test cases:
> (1) setup: start a 4U10G VM with memory preoccupied, each vcpu is pinned to a pcpu respectively, these resources(memory and pcpu) allocated to VM are all from NUMA node 0
> (2) sequence: firstly, I run the 429.mcf of spec cpu2006 before migration, and get a result. And then, migration failure is constructed. At last, I run the test case again, and get an another result.

I guess this case purely writes the memory, that means the readonly mappings will
always be dropped by #PF, then huge mappings are established.

If benchmark memory read, you show observe its difference.

Thanks!
