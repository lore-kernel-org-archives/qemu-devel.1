Received: from eggs.gnu.org ([2001:4830:134:3::10]:56868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <c.pinto@virtualopensystems.com>) id 1ciNN3-0001ME-R3
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:37:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <c.pinto@virtualopensystems.com>) id 1ciNN0-0005CT-P6
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:37:53 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:34533)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <c.pinto@virtualopensystems.com>)
	id 1ciNN0-0005CE-Ga
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:37:50 -0500
Received: by mail-wm0-x229.google.com with SMTP id 196so18933120wmm.1
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 07:37:48 -0800 (PST)
References: <1452169208-840-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<CAN9JPjHxb1RgtG=3f9+HWz80gwARymEKgX0N+OLGTi5Svgy6qw@mail.gmail.com>
	<577B1238.7040605@huawei.com>
	<CAN9JPjH_AQjHGbMMdSZofRp8nxcfgtkzpK6LZsd7bWyfGhJkCQ@mail.gmail.com>
	<577B8BA7.6010001@huawei.com>
	<20160818155636.l46t4ha65eybnnhe@redhat.com>
	<57B7F948.9040701@huawei.com>
From: Christian Pinto <c.pinto@virtualopensystems.com>
Message-ID: <cc27b58b-8751-f720-1370-d30c20c8d76a@virtualopensystems.com>
Date: Mon, 27 Feb 2017 16:37:44 +0100
MIME-Version: 1.0
In-Reply-To: <57B7F948.9040701@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>, Andrea Arcangeli <aarcange@redhat.com>, Juan Quintela <quintela@redhat.com>, dgilbert@redhat.com, Amit Shah <amit.shah@redhat.com>
Cc: peter.huangpeng@huawei.com, Baptiste Reynal <b.reynal@virtualopensystems.com>, qemu list <qemu-devel@nongnu.org>, hanweidong@huawei.com, colo-ft@hotmail.com

Hello Hailiang,

are there any updates on this patch series? Are you planning to release 
a new version?

You say there are some issues with the current snapshot-v2 version, 
which issues were you referring to? On my side the only problem I have 
seen was that the live snapshot was not working on ARMv8, but I have 
fixed that and managed to successfully snapshot and restore a QEMU ARMv8 
tcg machine on an ARMv8 host. I will gladly contribute with these fixes 
once you will release a new version of the patches.


Thanks a lot,

Christian

On 20/08/2016 08:31, Hailiang Zhang wrote:
> Hi,
>
> I updated this series, but didn't post it, because there are some 
> problems while i tested the snapshot function.
> I didn't know if it is the userfaultfd issue or not.
> I don't have time to investigate it this month. I have put them in github
> https://github.com/coloft/qemu/tree/snapshot-v2
>
> Anyone who want to test and modify it are welcomed!
>
> Besides, will you join the linuxcon or KVM forum in Canada ?
> I wish to see you there if you join the conference ;)
>
> Thanks,
> Hailiang
>
>
>
> On 2016/8/18 23:56, Andrea Arcangeli wrote:
>> Hello everyone,
>>
>> I've an aa.git tree uptodate on the master & userfault branch (master
>> includes other pending VM stuff, userfault branch only contains
>> userfault enhancements):
>>
>> https://git.kernel.org/cgit/linux/kernel/git/andrea/aa.git/log/?h=userfault 
>>
>>
>> I didn't have time to test KVM live memory snapshot on it yet as I'm
>> still working to improve it. Did anybody test it? However I'd be happy
>> to take any bugreports and quickly solve anything that isn't working
>> right with the shadow MMU.
>>
>> I got positive report already for another usage of the uffd WP support:
>>
>> https://medium.com/@MartinCracauer/generational-garbage-collection-write-barriers-write-protection-and-userfaultfd-2-8b0e796b8f7f 
>>
>>
>> The last few things I'm working on to finish the WP support are:
>>
>> 1) pte_swp_mkuffd_wp equivalent of pte_swp_mksoft_dirty to mark in a
>>     vma->vm_flags with VM_UFFD_WP set, which swap entries were
>>     generated while the pte was wrprotected.
>>
>> 2) to avoid all false positives the equivalent of pte_mksoft_dirty is
>>     needed too... and that requires spare software bits on the pte
>>     which are available on x86. I considered also taking over the
>>     soft_dirty bit but then you couldn't do checkpoint restore of a
>>     JIT/to-native compiler that uses uffd WP support so it wasn't
>>     ideal. Perhaps it would be ok as an incremental patch to make the
>>     two options mutually exclusive to defer the arch changes that
>>     pte_mkuffd_wp would require for later.
>>
>> 3) prevent UFFDIO_ZEROPAGE if registering WP|MISSING or trigger a
>>     cow in userfaultfd_writeprotect.
>>
>> 4) WP selftest
>>
>> In theory things should work ok already if the userland code is
>> tolerant against false positives through swap and after fork() and
>> KSM. For an usage like snapshotting false positives shouldn't be an
>> issue (it'll just run slower if you swap in the worst case), and point
>> 3) above also isn't an issue because it's going to register into uffd
>> with WP only.
>>
>> The current status includes:
>>
>> 1) WP support for anon (with false positives.. work in progress)
>>
>> 2) MISSING support for tmpfs and hugetlbfs
>>
>> 3) non cooperative support
>>
>> Thanks,
>> Andrea
>>
>> .
>>
>
