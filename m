Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA3CC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71EF320815
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71EF320815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFSW8-0001xW-4N
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 20:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsB-0001Zg-Cx
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRs9-00024A-DU
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35808)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRs6-0001Ta-DD; Tue, 01 Oct 2019 19:48:00 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlQK3086511; Tue, 1 Oct 2019 19:47:36 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vccat80t9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:35 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NlZJn086765;
 Tue, 1 Oct 2019 19:47:35 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vccat80sm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:35 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91Njocu031648;
 Tue, 1 Oct 2019 23:47:34 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma02wdc.us.ibm.com with ESMTP id 2v9y587fbd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:34 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NlXNQ4129440
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:33 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BDC712805A;
 Tue,  1 Oct 2019 23:47:33 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A22EB28058;
 Tue,  1 Oct 2019 23:47:33 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:33 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/97] qcow2: Fix full preallocation with external data file
Date: Tue,  1 Oct 2019 18:44:42 -0500
Message-Id: <20191001234616.7825-4-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
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

preallocate_co() already gave the data file the full size without
forwarding the requested preallocation mode to the protocol. When
bdrv_co_truncate() was called later with the preallocation mode, the
file didn't actually grow any more, so the data file stayed unallocated
even if full preallocation was requested.

Pass the right preallocation mode to preallocate_co() and remove the
second bdrv_co_truncate() to fix this. As a side effect, the ugly
one-byte write in preallocate_co() is replaced with a truncate call,
now leaving the last block unallocated on the protocol level as it
should be.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit 718c0fce2f56755a8d8f737607779a98aa6e7cc4)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/qcow2.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index b4f9f5a240..7fbef97aab 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2721,11 +2721,13 @@ static int qcow2_set_up_encryption(BlockDriverState *bs,
  * Returns: 0 on success, -errno on failure.
  */
 static int coroutine_fn preallocate_co(BlockDriverState *bs, uint64_t offset,
-                                       uint64_t new_length, Error **errp)
+                                       uint64_t new_length, PreallocMode mode,
+                                       Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t bytes;
     uint64_t host_offset = 0;
+    int64_t file_length;
     unsigned int cur_bytes;
     int ret;
     QCowL2Meta *meta;
@@ -2772,12 +2774,19 @@ static int coroutine_fn preallocate_co(BlockDriverState *bs, uint64_t offset,
      * all of the allocated clusters (otherwise we get failing reads after
      * EOF). Extend the image to the last allocated sector.
      */
-    if (host_offset != 0) {
-        uint8_t data = 0;
-        ret = bdrv_pwrite(s->data_file, (host_offset + cur_bytes) - 1,
-                          &data, 1);
+    file_length = bdrv_getlength(s->data_file->bs);
+    if (file_length < 0) {
+        error_setg_errno(errp, -file_length, "Could not get file size");
+        return file_length;
+    }
+
+    if (host_offset + cur_bytes > file_length) {
+        if (mode == PREALLOC_MODE_METADATA) {
+            mode = PREALLOC_MODE_OFF;
+        }
+        ret = bdrv_co_truncate(s->data_file, host_offset + cur_bytes, mode,
+                               errp);
         if (ret < 0) {
-            error_setg_errno(errp, -ret, "Writing to EOF failed");
             return ret;
         }
     }
@@ -3748,10 +3757,16 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
 
     switch (prealloc) {
     case PREALLOC_MODE_OFF:
+        if (has_data_file(bs)) {
+            ret = bdrv_co_truncate(s->data_file, offset, prealloc, errp);
+            if (ret < 0) {
+                goto fail;
+            }
+        }
         break;
 
     case PREALLOC_MODE_METADATA:
-        ret = preallocate_co(bs, old_length, offset, errp);
+        ret = preallocate_co(bs, old_length, offset, prealloc, errp);
         if (ret < 0) {
             goto fail;
         }
@@ -3768,7 +3783,7 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
         /* With a data file, preallocation means just allocating the metadata
          * and forwarding the truncate request to the data file */
         if (has_data_file(bs)) {
-            ret = preallocate_co(bs, old_length, offset, errp);
+            ret = preallocate_co(bs, old_length, offset, prealloc, errp);
             if (ret < 0) {
                 goto fail;
             }
@@ -3883,16 +3898,6 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
 
     bs->total_sectors = offset / BDRV_SECTOR_SIZE;
 
-    if (has_data_file(bs)) {
-        if (prealloc == PREALLOC_MODE_METADATA) {
-            prealloc = PREALLOC_MODE_OFF;
-        }
-        ret = bdrv_co_truncate(s->data_file, offset, prealloc, errp);
-        if (ret < 0) {
-            goto fail;
-        }
-    }
-
     /* write updated header.size */
     offset = cpu_to_be64(offset);
     ret = bdrv_pwrite_sync(bs->file, offsetof(QCowHeader, size),
-- 
2.17.1


