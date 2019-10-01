Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC529C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 02:12:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A92092086A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 02:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92092086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFU7d-0000rp-Oe
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 22:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRtL-0002mE-Cf
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRtJ-0003hk-Dw
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:49:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61154)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRtJ-0003Eh-4X; Tue, 01 Oct 2019 19:49:13 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NmmVE005032; Tue, 1 Oct 2019 19:48:52 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vcdfxweuf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:48:51 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NmpuQ005573;
 Tue, 1 Oct 2019 19:48:51 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vcdfxweh2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:48:51 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjmR2032160;
 Tue, 1 Oct 2019 23:47:52 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma01wdc.us.ibm.com with ESMTP id 2v9y57fgc8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:52 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91Nlo9449742282
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:50 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B38E28058;
 Tue,  1 Oct 2019 23:47:50 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F45A2805C;
 Tue,  1 Oct 2019 23:47:50 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:50 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/97] block: Fix AioContext switch for bs->drv == NULL
Date: Tue,  1 Oct 2019 18:44:45 -0500
Message-Id: <20191001234616.7825-7-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010203
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

Even for block nodes with bs->drv == NULL, we can't just ignore a
bdrv_set_aio_context() call. Leaving the node in its old context can
mean that it's still in an iothread context in bdrv_close_all() during
shutdown, resulting in an attempted unlock of the AioContext lock which
we don't hold.

This is an example stack trace of a related crash:

 #0  0x00007ffff59da57f in raise () at /lib64/libc.so.6
 #1  0x00007ffff59c4895 in abort () at /lib64/libc.so.6
 #2  0x0000555555b97b1e in error_exit (err=<optimized out>, msg=msg@entry=0x555555d386d0 <__func__.19059> "qemu_mutex_unlock_impl") at util/qemu-thread-posix.c:36
 #3  0x0000555555b97f7f in qemu_mutex_unlock_impl (mutex=mutex@entry=0x5555568002f0, file=file@entry=0x555555d378df "util/async.c", line=line@entry=507) at util/qemu-thread-posix.c:97
 #4  0x0000555555b92f55 in aio_context_release (ctx=ctx@entry=0x555556800290) at util/async.c:507
 #5  0x0000555555b05cf8 in bdrv_prwv_co (child=child@entry=0x7fffc80012f0, offset=offset@entry=131072, qiov=qiov@entry=0x7fffffffd4f0, is_write=is_write@entry=true, flags=flags@entry=0)
         at block/io.c:833
 #6  0x0000555555b060a9 in bdrv_pwritev (qiov=0x7fffffffd4f0, offset=131072, child=0x7fffc80012f0) at block/io.c:990
 #7  0x0000555555b060a9 in bdrv_pwrite (child=0x7fffc80012f0, offset=131072, buf=<optimized out>, bytes=<optimized out>) at block/io.c:990
 #8  0x0000555555ae172b in qcow2_cache_entry_flush (bs=bs@entry=0x555556810680, c=c@entry=0x5555568cc740, i=i@entry=0) at block/qcow2-cache.c:51
 #9  0x0000555555ae18dd in qcow2_cache_write (bs=bs@entry=0x555556810680, c=0x5555568cc740) at block/qcow2-cache.c:248
 #10 0x0000555555ae15de in qcow2_cache_flush (bs=0x555556810680, c=<optimized out>) at block/qcow2-cache.c:259
 #11 0x0000555555ae16b1 in qcow2_cache_flush_dependency (c=0x5555568a1700, c=0x5555568a1700, bs=0x555556810680) at block/qcow2-cache.c:194
 #12 0x0000555555ae16b1 in qcow2_cache_entry_flush (bs=bs@entry=0x555556810680, c=c@entry=0x5555568a1700, i=i@entry=0) at block/qcow2-cache.c:194
 #13 0x0000555555ae18dd in qcow2_cache_write (bs=bs@entry=0x555556810680, c=0x5555568a1700) at block/qcow2-cache.c:248
 #14 0x0000555555ae15de in qcow2_cache_flush (bs=bs@entry=0x555556810680, c=<optimized out>) at block/qcow2-cache.c:259
 #15 0x0000555555ad242c in qcow2_inactivate (bs=bs@entry=0x555556810680) at block/qcow2.c:2124
 #16 0x0000555555ad2590 in qcow2_close (bs=0x555556810680) at block/qcow2.c:2153
 #17 0x0000555555ab0c62 in bdrv_close (bs=0x555556810680) at block.c:3358
 #18 0x0000555555ab0c62 in bdrv_delete (bs=0x555556810680) at block.c:3542
 #19 0x0000555555ab0c62 in bdrv_unref (bs=0x555556810680) at block.c:4598
 #20 0x0000555555af4d72 in blk_remove_bs (blk=blk@entry=0x5555568103d0) at block/block-backend.c:785
 #21 0x0000555555af4dbb in blk_remove_all_bs () at block/block-backend.c:483
 #22 0x0000555555aae02f in bdrv_close_all () at block.c:3412
 #23 0x00005555557f9796 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at vl.c:4776

The reproducer I used is a qcow2 image on gluster volume, where the
virtual disk size (4 GB) is larger than the gluster volume size (64M),
so we can easily trigger an ENOSPC. This backend is assigned to a
virtio-blk device using an iothread, and then from the guest a
'dd if=/dev/zero of=/dev/vda bs=1G count=1' causes the VM to stop
because of an I/O error. qemu_gluster_co_flush_to_disk() sets
bs->drv = NULL on error, so when virtio-blk stops the dataplane, the
block nodes stay in the iothread AioContext. A 'quit' monitor command
issued from this paused state crashes the process.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1631227
Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
(cherry picked from commit 1bffe1ae7a7b707c3a14ea2ccd00d3609d3ce4d8)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/block.c b/block.c
index 16615bc876..9ae5c0ed2f 100644
--- a/block.c
+++ b/block.c
@@ -5672,10 +5672,6 @@ void bdrv_detach_aio_context(BlockDriverState *bs)
     BdrvAioNotifier *baf, *baf_tmp;
     BdrvChild *child;
 
-    if (!bs->drv) {
-        return;
-    }
-
     assert(!bs->walking_aio_notifiers);
     bs->walking_aio_notifiers = true;
     QLIST_FOREACH_SAFE(baf, &bs->aio_notifiers, list, baf_tmp) {
@@ -5690,7 +5686,7 @@ void bdrv_detach_aio_context(BlockDriverState *bs)
      */
     bs->walking_aio_notifiers = false;
 
-    if (bs->drv->bdrv_detach_aio_context) {
+    if (bs->drv && bs->drv->bdrv_detach_aio_context) {
         bs->drv->bdrv_detach_aio_context(bs);
     }
     QLIST_FOREACH(child, &bs->children, next) {
@@ -5709,10 +5705,6 @@ void bdrv_attach_aio_context(BlockDriverState *bs,
     BdrvAioNotifier *ban, *ban_tmp;
     BdrvChild *child;
 
-    if (!bs->drv) {
-        return;
-    }
-
     if (bs->quiesce_counter) {
         aio_disable_external(new_context);
     }
@@ -5722,7 +5714,7 @@ void bdrv_attach_aio_context(BlockDriverState *bs,
     QLIST_FOREACH(child, &bs->children, next) {
         bdrv_attach_aio_context(child->bs, new_context);
     }
-    if (bs->drv->bdrv_attach_aio_context) {
+    if (bs->drv && bs->drv->bdrv_attach_aio_context) {
         bs->drv->bdrv_attach_aio_context(bs, new_context);
     }
 
-- 
2.17.1


