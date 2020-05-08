Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1634FC47247
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBC7D24953
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XhVQPmoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC7D24953
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX2UY-0000lf-2D
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 08:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jX2KM-000083-3U
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:42:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23048
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jX2KI-00080X-7Z
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588941721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YII/7YCspEoufipwIctEVSVRNXgMRSC7i540qqG7Ik0=;
 b=XhVQPmoh0E8rx98J00+jhh1YPSH62hZWiicvtTGk14biWMFYvere14wbdyk/zN3Z7AQkh0
 GEXl5oYRHVz9MU3YA9c542sLf+3smtnAD6aJSReTJaNL/fWXtF+aJsv+1IRFMB9JvuCFWQ
 dS1UMev2O1lfuJ1UZGXAY69LVFmUkS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-NZjAPy-NNquO-73I3iuLgA-1; Fri, 08 May 2020 08:41:59 -0400
X-MC-Unique: NZjAPy-NNquO-73I3iuLgA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19C9980183C;
 Fri,  8 May 2020 12:41:58 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-190.ams2.redhat.com
 [10.36.113.190])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 190D119167;
 Fri,  8 May 2020 12:41:56 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 12/30] vmdk: Fix partial overwrite of zero cluster
Date: Fri,  8 May 2020 14:41:17 +0200
Message-Id: <20200508124135.252565-13-kwolf@redhat.com>
In-Reply-To: <20200508124135.252565-1-kwolf@redhat.com>
References: <20200508124135.252565-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 01:34:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When overwriting a zero cluster, we must not perform copy-on-write from
the backing file, but from a zeroed buffer.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200430133007.170335-4-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vmdk.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index fcd6b38d64..ab8eec1f27 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1340,7 +1340,9 @@ static void vmdk_refresh_limits(BlockDriverState *bs,=
 Error **errp)
  * get_whole_cluster
  *
  * Copy backing file's cluster that covers @sector_num, otherwise write ze=
ro,
- * to the cluster at @cluster_sector_num.
+ * to the cluster at @cluster_sector_num. If @zeroed is true, we're overwr=
iting
+ * a zeroed cluster in the current layer and must not copy data from the
+ * backing file.
  *
  * If @skip_start_sector < @skip_end_sector, the relative range
  * [@skip_start_sector, @skip_end_sector) is not copied or written, and le=
ave
@@ -1351,18 +1353,21 @@ static int get_whole_cluster(BlockDriverState *bs,
                              uint64_t cluster_offset,
                              uint64_t offset,
                              uint64_t skip_start_bytes,
-                             uint64_t skip_end_bytes)
+                             uint64_t skip_end_bytes,
+                             bool zeroed)
 {
     int ret =3D VMDK_OK;
     int64_t cluster_bytes;
     uint8_t *whole_grain;
+    bool copy_from_backing;
=20
     /* For COW, align request sector_num to cluster start */
     cluster_bytes =3D extent->cluster_sectors << BDRV_SECTOR_BITS;
     offset =3D QEMU_ALIGN_DOWN(offset, cluster_bytes);
     whole_grain =3D qemu_blockalign(bs, cluster_bytes);
+    copy_from_backing =3D bs->backing && !zeroed;
=20
-    if (!bs->backing) {
+    if (!copy_from_backing) {
         memset(whole_grain, 0, skip_start_bytes);
         memset(whole_grain + skip_end_bytes, 0, cluster_bytes - skip_end_b=
ytes);
     }
@@ -1377,7 +1382,7 @@ static int get_whole_cluster(BlockDriverState *bs,
=20
     /* Read backing data before skip range */
     if (skip_start_bytes > 0) {
-        if (bs->backing) {
+        if (copy_from_backing) {
             /* qcow2 emits this on bs->file instead of bs->backing */
             BLKDBG_EVENT(extent->file, BLKDBG_COW_READ);
             ret =3D bdrv_pread(bs->backing, offset, whole_grain,
@@ -1397,7 +1402,7 @@ static int get_whole_cluster(BlockDriverState *bs,
     }
     /* Read backing data after skip range */
     if (skip_end_bytes < cluster_bytes) {
-        if (bs->backing) {
+        if (copy_from_backing) {
             /* qcow2 emits this on bs->file instead of bs->backing */
             BLKDBG_EVENT(extent->file, BLKDBG_COW_READ);
             ret =3D bdrv_pread(bs->backing, offset + skip_end_bytes,
@@ -1631,7 +1636,8 @@ static int get_cluster_offset(BlockDriverState *bs,
          * or inappropriate VM shutdown.
          */
         ret =3D get_whole_cluster(bs, extent, cluster_sector * BDRV_SECTOR=
_SIZE,
-                                offset, skip_start_bytes, skip_end_bytes);
+                                offset, skip_start_bytes, skip_end_bytes,
+                                zeroed);
         if (ret) {
             return ret;
         }
--=20
2.25.3


