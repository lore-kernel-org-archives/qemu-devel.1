Received: from eggs.gnu.org ([2001:4830:134:3::10]:34760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d2cZY-0006A1-Sv
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 07:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d2cZX-0008Sf-Oo
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 07:54:28 -0400
MIME-Version: 1.0
In-Reply-To: <CAOGPPbc44H-oaY2Smm5kgNNbaP44C3rksi9_=0ocAXAnGdWdCg@mail.gmail.com>
References: <1492050868-16200-1-git-send-email-lidongchen@tencent.com>
	<20170414060015.GA12191@lemon>
	<CAOGPPbeUkBskJfFX9=Of62pDrt6U-KAjbFZ-r=yVNNeb+ceAuA@mail.gmail.com>
	<20170417034925.GC6717@lemon.lan>
	<CAOGPPbd_Y6m42EpuedngTWfGzt+MDvOwbPSmwp-OG5hVpMNBkA@mail.gmail.com>
	<CAOGPPbc44H-oaY2Smm5kgNNbaP44C3rksi9_=0ocAXAnGdWdCg@mail.gmail.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Mon, 24 Apr 2017 19:54:23 +0800
Message-ID: <CAOGPPbfx_FoOwHMa96w_EioAApDs08_=saFRGr-5XdOrj60HNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v6] migration/block: use blk_pwrite_zeroes
 for each zero cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>, Dave Gilbert <dgilbert@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Lidong Chen <lidongchen@tencent.com>

On Mon, Apr 24, 2017 at 3:40 PM, 858585 jemmy <jemmy858585@gmail.com> wrote:
> On Mon, Apr 17, 2017 at 12:00 PM, 858585 jemmy <jemmy858585@gmail.com> wrote:
>> On Mon, Apr 17, 2017 at 11:49 AM, Fam Zheng <famz@redhat.com> wrote:
>>> On Fri, 04/14 14:30, 858585 jemmy wrote:
>>>> Do you know some other format which have very small cluster size?
>>>
>>> 64k is the default cluster size for qcow2 but it can be configured at image
>>> creation time, as 512 bytes, for example:
>>>
>>>     $ qemu-img create -f qcow2 test.qcow2 -o cluster_size=512 1G
>>
>> Thanks, i will test the performance again.
>
> I find the performance reduce when cluster size is 512.
> I will optimize the performance and submit a patch later.
> Thanks.

after optimize the code, i find the destination qemu process still have very
bad performance when cluster_size is 512. the reason is cause by
qcow2_check_metadata_overlap.

if cluster_size is 512, the destination qemu process reach 100% cpu usage.
and the perf top result is below:

Samples: 32K of event 'cycles', Event count (approx.): 20105269445
 91.68%  qemu-system-x86_64       [.] qcow2_check_metadata_overlap
  3.33%  qemu-system-x86_64       [.] range_get_last
  2.76%  qemu-system-x86_64       [.] ranges_overlap
  0.61%  qemu-system-x86_64       [.] qcow2_cache_do_get

very large l1_size.
(gdb) p s->l1_size
$3 = 1310720

(gdb) p s->max_refcount_table_index
$5 = 21905

the backtrace:

Breakpoint 1, qcow2_check_metadata_overlap (bs=0x16feb00, ign=0,
offset=440329728, size=4096) at block/qcow2-refcount.c:2344
2344    {
(gdb) bt
#0  qcow2_check_metadata_overlap (bs=0x16feb00, ign=0,
offset=440329728, size=4096) at block/qcow2-refcount.c:2344
#1  0x0000000000878d9f in qcow2_pre_write_overlap_check (bs=0x16feb00,
ign=0, offset=440329728, size=4096) at block/qcow2-refcount.c:2473
#2  0x000000000086e382 in qcow2_co_pwritev (bs=0x16feb00,
offset=771047424, bytes=704512, qiov=0x7fd026bfdb90, flags=0) at
block/qcow2.c:1653
#3  0x00000000008aeace in bdrv_driver_pwritev (bs=0x16feb00,
offset=770703360, bytes=1048576, qiov=0x7fd026bfdb90, flags=0) at
block/io.c:871
#4  0x00000000008b015c in bdrv_aligned_pwritev (child=0x171b630,
req=0x7fd026bfd980, offset=770703360, bytes=1048576, align=1,
qiov=0x7fd026bfdb90, flags=0) at block/io.c:1371
#5  0x00000000008b0d77 in bdrv_co_pwritev (child=0x171b630,
offset=770703360, bytes=1048576, qiov=0x7fd026bfdb90, flags=0) at
block/io.c:1622
#6  0x000000000089a76d in blk_co_pwritev (blk=0x16fe920,
offset=770703360, bytes=1048576, qiov=0x7fd026bfdb90, flags=0) at
block/block-backend.c:992
#7  0x000000000089a878 in blk_write_entry (opaque=0x7fd026bfdb70) at
block/block-backend.c:1017
#8  0x000000000089a95d in blk_prw (blk=0x16fe920, offset=770703360,
buf=0x362b050 "", bytes=1048576, co_entry=0x89a81a <blk_write_entry>,
flags=0) at block/block-backend.c:1045
#9  0x000000000089b222 in blk_pwrite (blk=0x16fe920, offset=770703360,
buf=0x362b050, count=1048576, flags=0) at block/block-backend.c:1208
#10 0x00000000007d480d in block_load (f=0x1784fa0, opaque=0xfd46a0,
version_id=1) at migration/block.c:992
#11 0x000000000049dc58 in vmstate_load (f=0x1784fa0, se=0x16fbdc0,
version_id=1) at /data/qemu/migration/savevm.c:730
#12 0x00000000004a0752 in qemu_loadvm_section_part_end (f=0x1784fa0,
mis=0xfd4160) at /data/qemu/migration/savevm.c:1923
#13 0x00000000004a0842 in qemu_loadvm_state_main (f=0x1784fa0,
mis=0xfd4160) at /data/qemu/migration/savevm.c:1954
#14 0x00000000004a0a33 in qemu_loadvm_state (f=0x1784fa0) at
/data/qemu/migration/savevm.c:2020
#15 0x00000000007c2d33 in process_incoming_migration_co
(opaque=0x1784fa0) at migration/migration.c:404
#16 0x0000000000966593 in coroutine_trampoline (i0=27108400, i1=0) at
util/coroutine-ucontext.c:79
#17 0x00007fd03946b8f0 in ?? () from /lib64/libc.so.6
#18 0x00007fff869c87e0 in ?? ()
#19 0x0000000000000000 in ?? ()

when the cluster_size is too small, the write performance is very bad.
How to solve this problem? Any suggestion?
1. when the cluster_size is too small, not invoke qcow2_pre_write_overlap_check.
2.limit the qcow2 cluster_size range, don't allow set the cluster_size
too small.
which way is better?

>
>>>
>>> Fam
