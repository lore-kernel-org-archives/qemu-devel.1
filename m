Received: from eggs.gnu.org ([2001:4830:134:3::10]:44180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cEy4p-0005C8-KO
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 07:45:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cEy4m-0002rT-Gf
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 07:45:31 -0500
Received: from szxga02-in.huawei.com ([119.145.14.65]:58067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cEy4l-0002nQ-JH
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 07:45:28 -0500
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
References: <1452169208-840-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<CAN9JPjHxb1RgtG=3f9+HWz80gwARymEKgX0N+OLGTi5Svgy6qw@mail.gmail.com>
	<577B1238.7040605@huawei.com>
	<CAN9JPjH_AQjHGbMMdSZofRp8nxcfgtkzpK6LZsd7bWyfGhJkCQ@mail.gmail.com>
	<577B8BA7.6010001@huawei.com>
	<20160818155636.l46t4ha65eybnnhe@redhat.com>
	<57CE3A7D.3030404@huawei.com> <57DDF87C.1070506@huawei.com>
Message-ID: <584955D1.6080003@huawei.com>
Date: Thu, 8 Dec 2016 20:45:05 +0800
MIME-Version: 1.0
In-Reply-To: <57DDF87C.1070506@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 00/13] Live memory snapshot based on
 userfaultfd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Arcangeli <aarcange@redhat.com>
Cc: peter.huangpeng@huawei.com, Baptiste Reynal <b.reynal@virtualopensystems.com>, qemu list <qemu-devel@nongnu.org>, hanweidong@huawei.com, Juan Quintela <quintela@redhat.com>, dgilbert@redhat.com, Amit Shah <amit.shah@redhat.com>, Christian Pinto <c.pinto@virtualopensystems.com>, xuquan8@huawei.com

Hi Andrea,

I noticed that, you call change_protection() helper in mprotect to realize
write protect capability for userfault. But i doubted mprotect can't work
properly with KVM. If shadow page table (spte) which used by VM is already
established in EPT,change_protection() does not remove its write authority
but only invalid its Host page-table and shadow page table ( kvm registers
invalidate_page/invalidate_range_start).

I investigated ksm, Since it can merge the pages which are used by VM,
and it need to remove the write authority of these pages too.
Its process is not same with mprotect. It has a helper write_protect_page(),
and it finally calls hook function change_pte in KVM. It will remove the page's
write authority in EPT page table.

The code path is:
write_protect_page
     -> set_pte_at_notify
        -> mmu_notifier_change_pte
           -> mn->ops->change_pte
              -> kvm_mmu_notifier_change_pte

(If I'm wrong, please let me know :) ).

So IMHO, we can realize userfault supporting KVM by refer to ksm,
I will investigate it deeply and try to implement it,
but I'm not quite familiar with memory system in kernel,
so it will takes me some time to study it firstly ...
I'd like to know if you have any plan about supporting KVM for userfault ?

Thanks,
Hailiang

On 2016/9/18 10:14, Hailiang Zhang wrote:
> Hi Andrea,
>
> Any comments ?
>
> Thanks.
>
> On 2016/9/6 11:39, Hailiang Zhang wrote:
>> Hi Andrea，
>>
>> I tested it with the new live memory snapshot with --enable-kvm, it doesn't work.
>>
>> To make things simple, I simplified the codes, only left the codes that can tested
>> the write-protect capability. You can find the codes from
>> https://github.com/coloft/qemu/tree/test-userfault-write-protect.
>> You can reproduce the problem easily with it.
>>
>> Tested result as follow,
>> [root@localhost qemu]# x86_64-softmmu/qemu-system-x86_64 --enable-kvm -drive file=/mnt/sdb/win7/win7.qcow2,if=none,id=drive-ide0-0-1,format=qcow2,cache=none  -device ide-hd,bus=ide.0,unit=1,drive=drive-ide0-0-1,id=ide0-0-1  -vnc :7 -m 8192 -smp 1 -netdev tap,id=bn0 -device virtio-net-pci,id=net-pci0,netdev=bn0  --monitor stdio
>> QEMU 2.6.95 monitor - type 'help' for more information
>> (qemu) migrate file:/home/xxx
>> qemu-system-x86_64: postcopy_ram_fault_thread: 7f07fb92a000 fault and remove write protect!
>> qemu-system-x86_64: postcopy_ram_fault_thread: 7f07fb92a000 fault and remove write protect!
>> qemu-system-x86_64: postcopy_ram_fault_thread: 7f07fb92a000 fault and remove write protect!
>> qemu-system-x86_64: postcopy_ram_fault_thread: 7f07fb92a000 fault and remove write protect!
>> qemu-system-x86_64: postcopy_ram_fault_thread: 7f07fb92a000 fault and remove write protect!
>> qemu-system-x86_64: postcopy_ram_fault_thread: 7f07fb92a000 fault and remove write protect!
>> qemu-system-x86_64: postcopy_ram_fault_thread: 7f07fb92a000 fault and remove write protect!
>> qemu-system-x86_64: postcopy_ram_fault_thread: 7f07fb92a000 fault and remove write protect!
>> qemu-system-x86_64: postcopy_ram_fault_thread: 7f07fb92a000 fault and remove write protect!
>> qemu-system-x86_64: postcopy_ram_fault_thread: 7f07fb92a000 fault and remove write protect!
>> qemu-system-x86_64: postcopy_ram_fault_thread: 7f07fb92a000 fault and remove write protect!
>> qemu-system-x86_64: postcopy_ram_fault_thread: 7f07fb92a000 fault and remove write protect!
>> qemu-system-x86_64: postcopy_ram_fault_thread: 7f07fb92a000 fault and remove write protect!
>> qemu-system-x86_64: postcopy_ram_fault_thread: 7f07fb92a000 fault and remove write protect!
>> qemu-system-x86_64: postcopy_ram_fault_thread: 7f07fb92a000 fault and remove write protect!
>> qemu-system-x86_64: postcopy_ram_fault_thread: 7f07fb92a000 fault and remove write protect!
>> qemu-system-x86_64: postcopy_ram_fault_thread: 7f07fb92a000 fault and remove write protect!
>> error: kvm run failed Bad address
>> EAX=00000004 EBX=00000000 ECX=83b2ac20 EDX=0000c022
>> ESI=85fe33f4 EDI=0000c020 EBP=83b2abcc ESP=83b2abc0
>> EIP=8bd2ff0c EFL=00010293 [--S-A-C] CPL=0 II=0 A20=1 SMM=0 HLT=0
>> ES =0023 00000000 ffffffff 00c0f300 DPL=3 DS   [-WA]
>> CS =0008 00000000 ffffffff 00c09b00 DPL=0 CS32 [-RA]
>> SS =0010 00000000 ffffffff 00c09300 DPL=0 DS   [-WA]
>> DS =0023 00000000 ffffffff 00c0f300 DPL=3 DS   [-WA]
>> FS =0030 83b2dc00 00003748 00409300 DPL=0 DS   [-WA]
>> GS =0000 00000000 ffffffff 00000000
>> LDT=0000 00000000 ffffffff 00000000
>> TR =0028 801e2000 000020ab 00008b00 DPL=0 TSS32-busy
>> GDT=     80b95000 000003ff
>> IDT=     80b95400 000007ff
>> CR0=8001003b CR2=030b5000 CR3=00185000 CR4=000006f8
>> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000
>> DR6=00000000ffff0ff0 DR7=0000000000000400
>> EFER=0000000000000800
>> Code=8b ff 55 8b ec 53 56 8b 75 08 57 8b 7e 34 56 e8 30 f7 ff ff <6a> 00 57 8a d8 e8 96 14 00 00 6a 04 83 c7 02 57 e8 8b 14 00 00 5f c6 46 5b 00 5e 8a c3 5b
>>
>> I investigated kvm and userfault codes. we use MMU Notifier to integrating KVM with the Linux
>> Memory Management.
>>
>> Here for userfault write-protect, the function calling paths are:
>> userfaultfd_ioctl
>>      -> userfaultfd_writeprotect
>>        -> mwriteprotect_range
>>          -> change_protection (Directly call mprotect helper here)
>>            -> change_protection_range
>>              -> change_pud_range
>>                -> change_pmd_range
>>                   -> mmu_notifier_invalidate_range_start(mm, mni_start, end);
>>                      -> kvm_mmu_notifier_invalidate_range_start (KVM module)
>> OK, here, we remove the item from spte. (If we use EPT hardware, we remove
>> the page table entry for it).
>> That's why we can get fault notifying for VM.
>> And It seems that we can't fix the userfault (remove the page's write-protect authority)
>> by this function calling paths.
>>
>> Here my question is, for userfault write-protect capability, why we remove the page table
>> entry instead of marking it as read-only.
>> Actually, for KVM, we have a mmu notifier (kvm_mmu_notifier_change_pte) to do this,
>> We can use it to remove the writable authority for KVM page table, just like KVM dirty log tracking
>> does. Please see function __rmap_write_protect() in KVM.
>>
>> Another question, is mprotect() works normally with KVM ? (I didn't test it.), I think
>> KSM and swap can work with KVM properly.
>>
>> Besides, there seems to be a bug for userfault write-protect.
>> We use UFFDIO_COPY_MODE_DONTWAKE in userfaultfd_writeprotect, should it be
>> UFFDIO_WRITEPROTECT_MODE_DONTWAKE there ?
>>
>> static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
>> 				    unsigned long arg)
>> {
>>           ... ...
>>
>> 	if (!(uffdio_wp.mode & UFFDIO_COPY_MODE_DONTWAKE)) {
>> 		range.start = uffdio_wp.range.start;
>> 		range.len = uffdio_wp.range.len;
>> 		wake_userfault(ctx, &range);
>> 	}
>> 	return ret;
>> }
>>
>> Thanks.
>> Hailiang
>>
>> On 2016/8/18 23:56, Andrea Arcangeli wrote:
>>> Hello everyone,
>>>
>>> I've an aa.git tree uptodate on the master & userfault branch (master
>>> includes other pending VM stuff, userfault branch only contains
>>> userfault enhancements):
>>>
>>> https://git.kernel.org/cgit/linux/kernel/git/andrea/aa.git/log/?h=userfault
>>>
>>> I didn't have time to test KVM live memory snapshot on it yet as I'm
>>> still working to improve it. Did anybody test it? However I'd be happy
>>> to take any bugreports and quickly solve anything that isn't working
>>> right with the shadow MMU.
>>>
>>> I got positive report already for another usage of the uffd WP support:
>>>
>>> https://medium.com/@MartinCracauer/generational-garbage-collection-write-barriers-write-protection-and-userfaultfd-2-8b0e796b8f7f
>>>
>>> The last few things I'm working on to finish the WP support are:
>>>
>>> 1) pte_swp_mkuffd_wp equivalent of pte_swp_mksoft_dirty to mark in a
>>>       vma->vm_flags with VM_UFFD_WP set, which swap entries were
>>>       generated while the pte was wrprotected.
>>>
>>> 2) to avoid all false positives the equivalent of pte_mksoft_dirty is
>>>       needed too... and that requires spare software bits on the pte
>>>       which are available on x86. I considered also taking over the
>>>       soft_dirty bit but then you couldn't do checkpoint restore of a
>>>       JIT/to-native compiler that uses uffd WP support so it wasn't
>>>       ideal. Perhaps it would be ok as an incremental patch to make the
>>>       two options mutually exclusive to defer the arch changes that
>>>       pte_mkuffd_wp would require for later.
>>>
>>> 3) prevent UFFDIO_ZEROPAGE if registering WP|MISSING or trigger a
>>>       cow in userfaultfd_writeprotect.
>>>
>>> 4) WP selftest
>>>
>>> In theory things should work ok already if the userland code is
>>> tolerant against false positives through swap and after fork() and
>>> KSM. For an usage like snapshotting false positives shouldn't be an
>>> issue (it'll just run slower if you swap in the worst case), and point
>>> 3) above also isn't an issue because it's going to register into uffd
>>> with WP only.
>>>
>>> The current status includes:
>>>
>>> 1) WP support for anon (with false positives.. work in progress)
>>>
>>> 2) MISSING support for tmpfs and hugetlbfs
>>>
>>> 3) non cooperative support
>>>
>>> Thanks,
>>> Andrea
>>>
>>> .
>>>
