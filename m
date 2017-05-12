Received: from eggs.gnu.org ([2001:4830:134:3::10]:45477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d969o-00072V-P0
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d969l-0002ky-Kp
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:42:40 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d969l-0002fj-0x
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:42:37 -0400
References: <830bfc39-56c7-a901-9ebb-77d6e7a5614c@huawei.com>
	<874lxeovrg.fsf@secure.mitica>
	<7cd332ec-48d4-1feb-12e2-97b50b04e028@huawei.com>
	<20170424164244.GJ2362@work-vm>
	<B2D15215269B544CADD246097EACE747395AD759@dggeml511-mbx.china.huawei.com>
	<85e3a0dd-20c8-8ff2-37ce-bfdf543e7787@redhat.com>
	<a35ce92b-d10b-646b-34d0-d7f075fc46d4@gmail.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <5915755E.8080806@huawei.com>
Date: Fri, 12 May 2017 16:42:06 +0800
MIME-Version: 1.0
In-Reply-To: <a35ce92b-d10b-646b-34d0-d7f075fc46d4@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
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
To: Xiao Guangrong <guangrong.xiao@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "Dr.
	David Alan Gilbert" <dgilbert@redhat.com>, yanghongyang <yanghongyang@huawei.com>
Cc: Wanpeng Li <kernellwp@gmail.com>, "quintela@redhat.com" <quintela@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, Xiao
	Guangrong <xiaoguangrong@tencent.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, Huangzhichao <huangzhichao@huawei.com>, "Herongguang (Stephen)" <herongguang.he@huawei.com>

On 2017/5/12 16:09, Xiao Guangrong wrote:
>
> On 05/11/2017 08:24 PM, Paolo Bonzini wrote:
>>
>> On 11/05/2017 14:07, Zhoujian (jay) wrote:
>>> -        * Scan sptes if dirty logging has been stopped, dropping those
>>> -        * which can be collapsed into a single large-page spte.  Later
>>> -        * page faults will create the large-page sptes.
>>> +        * Reset each vcpu's mmu, then page faults will create the large-page
>>> +        * sptes later.
>>>            */
>>>           if ((change != KVM_MR_DELETE) &&
>>>                   (old->flags & KVM_MEM_LOG_DIRTY_PAGES) &&
>>> -               !(new->flags & KVM_MEM_LOG_DIRTY_PAGES))
>>> -               kvm_mmu_zap_collapsible_sptes(kvm, new);
>>> +               !(new->flags & KVM_MEM_LOG_DIRTY_PAGES)) {
>>> +               kvm_for_each_vcpu(i, vcpu, kvm)
>>> +                       kvm_mmu_reset_context(vcpu);
>> This should be "kvm_make_all_cpus_request(kvm, KVM_REQ_MMU_RELOAD);" but
>> I am not sure it is enough.  I think that if you do not zap the SPTEs,
>> the page faults will use 4K SPTEs, not large ones (though I'd have to
>> check better; CCing Xiao and Wanpeng).
> Yes, Paolo is right. kvm_mmu_reset_context() just reloads vCPU's
> root page table, 4k mappings are still kept.
>
> There are two issues reported:
> - one is kvm_mmu_slot_apply_flags(), when enable dirty log tracking.
>
>     Its root cause is kvm_mmu_slot_remove_write_access() takes too much
>     time.
>
>     We can make the code adaptive to use the new fast-write-protect faculty
>     introduced by my patchset, i.e, if the number of pages contained in this
>     memslot is more than > TOTAL * FAST_WRITE_PROTECT_PAGE_PERCENTAGE, then
>     we use fast-write-protect instead.
>
> - another one is kvm_mmu_zap_collapsible_sptes() when disable dirty
>     log tracking.
>
>     collapsible_sptes zaps 4k mappings to make memory-read happy, it is not
>     required by the semanteme of KVM_SET_USER_MEMORY_REGION and it is not
>     urgent for vCPU's running, it could be done in a separate thread and use
>     lock-break technology.

How about move the action of stopping dirty log into migrate_fd_cleanup() directly,
which is processed in main thread as BH after migration is completed?  It will not
has any side-effect even migration is failed, Or users cancel migration, No ?

> Thanks!
>
>
> .
>
