Received: from eggs.gnu.org ([2001:4830:134:3::10]:34593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1clR8r-0007I6-Ej
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 21:15:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1clR8m-0005D0-Q7
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 21:15:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1clR8m-0005CG-Ib
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 21:15:48 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2829bIZ029507
	for <qemu-devel@nongnu.org>; Tue, 7 Mar 2017 21:15:46 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2927jjkh4n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 21:15:46 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 7 Mar 2017 21:15:45 -0500
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Wed,  8 Mar 2017 03:15:32 +0100
Message-Id: <20170308021533.78292-1-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH RFC 0/1] block: Handle NULL options correctly
 in raw_open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-devel@nongnu.org, bjsdjshi@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, pasic@linux.vnet.ibm.com

Trying to restore rbd image on ceph cluster from snapshot with
qemu-img could trigger a calling to raw_open with a NULL @options
after a calling to raw_close, and that will lead to a failure of
the snapshot applying.

[root@s8345007 ~]# gdb --args qemu-img snapshot -a snap1 rbd:test_pool/dj_image
... ...
Program received signal SIGSEGV, Segmentation fault.
0x00000000801395a8 in qdict_next_entry (qdict=0x0, first_bucket=0) at qobject/qdict.c:327
327	        if (!QLIST_EMPTY(&qdict->table[i])) {
(gdb) bt
#0  0x00000000801395a8 in qdict_next_entry (qdict=0x0, first_bucket=0) at qobject/qdict.c:327
#1  0x0000000080139626 in qdict_first (qdict=0x0) at qobject/qdict.c:340
#2  0x000000008013a00c in qdict_extract_subqdict (src=0x0, dst=0x3ffffffec50, start=0x80698260 "file.")
    at qobject/qdict.c:576
#3  0x0000000080019c26 in bdrv_open_child_bs (filename=0x0, options=0x0, bdref_key=0x8017ab38 "file", 
    parent=0x80630300, child_role=0x80176108 <child_file>, allow_none=false, errp=0x0) at block.c:2018
#4  0x0000000080019dfa in bdrv_open_child (filename=0x0, options=0x0, bdref_key=0x8017ab38 "file", 
    parent=0x80630300, child_role=0x80176108 <child_file>, allow_none=false, errp=0x0) at block.c:2065
#5  0x000000008002b9a0 in raw_open (bs=0x80630300, options=0x0, flags=8194, errp=0x0) at block/raw-format.c:387
#6  0x0000000080087516 in bdrv_snapshot_goto (bs=0x80630300, snapshot_id=0x3fffffff75c "snap1")
    at block/snapshot.c:194
#7  0x0000000080010b8c in img_snapshot (argc=4, argv=0x3fffffff4c0) at qemu-img.c:2937
#8  0x00000000800140e4 in main (argc=4, argv=0x3fffffff4c0) at qemu-img.c:4373

The problematic caller of raw_open is block/snapshot.c:194:
178 int bdrv_snapshot_goto(BlockDriverState *bs,
179                        const char *snapshot_id)
180 {
181     BlockDriver *drv = bs->drv;
182     int ret, open_ret;
183 
184     if (!drv) {
185         return -ENOMEDIUM;
186     }
187     if (drv->bdrv_snapshot_goto) {
188         return drv->bdrv_snapshot_goto(bs, snapshot_id);
189     }
190 
191     if (bs->file) {
192         drv->bdrv_close(bs);
193         ret = bdrv_snapshot_goto(bs->file->bs, snapshot_id);
194         open_ret = drv->bdrv_open(bs, NULL, bs->open_flags, NULL);
195         if (open_ret < 0) {
196             bdrv_unref(bs->file->bs);
197             bs->drv = NULL;
198             return open_ret;
199         }
200         return ret;
201     }
202 
203     return -ENOTSUP;
204 }

AFAIU, that's because raw_open does not take NULL @options as a
legal parameter. @options should have a "file" key-value pair to
ensure a success open.

I'm not familiar with these code, but after reading them for a
while, I think that raw_close always does nothing, so it seems to
me that a raw_open after a raw_close probably should also do nothing
as well.

I admit that there may be more than one way to detect whether
raw_open is called after raw_close. E.g. introducing a flag to
indicate whether the current BDS is closed, or try to reuse some
existing fields in BDS. But taking NULL @options as a sign of
trying to open again could be the simplest working method jumped
into my mind.

I'd like to send this as a RFC here for more advice, in case I
walked along a wrong way to far. Comments are welcome.

Dong Jia Shi (1):
  block: Handle NULL options correctly in raw_open

 block/raw-format.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.8.4
