Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3167BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:49:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A2320663
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhQ70DEo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A2320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsY32-0007Uu-8T
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 16:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jsXvI-0004q2-QS
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:41:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57343
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jsXvG-0002pR-ST
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594068066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=22w9bqoh9blgr1V8ekiMp2Bt49QGN95HBKT0H75JChk=;
 b=bhQ70DEoyUZtjafwzq3xtSaSDD1s/gSMbusLSqI5uWrTXmYDbwaqdvJ4wShiELGEMw36Tu
 UQFXoEKe6caM61uQ+nrVRlNUq7UOokWiZhMlsG+IS7A7eY6UwFn1g19U6Wl5QFRejziHNu
 j4oErcS5n0w/RKexIiUItGDlFFulkCs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-EKI-Gt3IMfK0fciX4YyFjQ-1; Mon, 06 Jul 2020 16:40:27 -0400
X-MC-Unique: EKI-Gt3IMfK0fciX4YyFjQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29D8F3640D;
 Mon,  6 Jul 2020 20:40:26 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-97.phx2.redhat.com [10.3.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5AA2F7B400;
 Mon,  6 Jul 2020 20:40:25 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 09/10] block: Add support to warn on backing file change
 without format
Date: Mon,  6 Jul 2020 15:39:53 -0500
Message-Id: <20200706203954.341758-10-eblake@redhat.com>
In-Reply-To: <20200706203954.341758-1-eblake@redhat.com>
References: <20200706203954.341758-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 15:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, pkrempa@redhat.com,
 =?UTF-8?q?J=C3=A1n=20Tomko?= <jtomko@redhat.com>, qemu-block@nongnu.org,
 kchamart@redhat.com, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, mreitz@redhat.com,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For now, this is a mechanical addition; all callers pass false. But
the next patch will use it to improve 'qemu-img rebase -u' when
selecting a backing file with no format.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Peter Krempa <pkrempa@redhat.com>
Reviewed-by: Ján Tomko <jtomko@redhat.com>
---
 include/block/block.h |  4 ++--
 block.c               | 13 ++++++++++---
 block/qcow2.c         |  2 +-
 block/stream.c        |  2 +-
 blockdev.c            |  3 ++-
 qemu-img.c            |  4 ++--
 6 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index e8fc8149967f..b57a3806a592 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -410,8 +410,8 @@ void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr);
 void bdrv_refresh_limits(BlockDriverState *bs, Error **errp);
 int bdrv_commit(BlockDriverState *bs);
 int bdrv_make_empty(BdrvChild *c, Error **errp);
-int bdrv_change_backing_file(BlockDriverState *bs,
-    const char *backing_file, const char *backing_fmt);
+int bdrv_change_backing_file(BlockDriverState *bs, const char *backing_file,
+                             const char *backing_fmt, bool warn);
 void bdrv_register(BlockDriver *bdrv);
 int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
                            const char *backing_file_str);
diff --git a/block.c b/block.c
index 983b9bd29af5..5cfd10f6b45e 100644
--- a/block.c
+++ b/block.c
@@ -1206,7 +1206,8 @@ static int bdrv_backing_update_filename(BdrvChild *c, BlockDriverState *base,
     }

     ret = bdrv_change_backing_file(parent, filename,
-                                   base->drv ? base->drv->format_name : "");
+                                   base->drv ? base->drv->format_name : "",
+                                   false);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not update backing file link");
     }
@@ -4684,8 +4685,8 @@ int bdrv_check(BlockDriverState *bs,
  *            image file header
  * -ENOTSUP - format driver doesn't support changing the backing file
  */
-int bdrv_change_backing_file(BlockDriverState *bs,
-    const char *backing_file, const char *backing_fmt)
+int bdrv_change_backing_file(BlockDriverState *bs, const char *backing_file,
+                             const char *backing_fmt, bool warn)
 {
     BlockDriver *drv = bs->drv;
     int ret;
@@ -4699,6 +4700,12 @@ int bdrv_change_backing_file(BlockDriverState *bs,
         return -EINVAL;
     }

+    if (warn && backing_file && !backing_fmt) {
+        warn_report("Deprecated use of backing file without explicit "
+                    "backing format, use of this image requires "
+                    "potentially unsafe format probing");
+    }
+
     if (drv->bdrv_change_backing_file != NULL) {
         ret = drv->bdrv_change_backing_file(bs, backing_file, backing_fmt);
     } else {
diff --git a/block/qcow2.c b/block/qcow2.c
index 99aedb8eede6..36793e3bb0c7 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3630,7 +3630,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         }

         ret = bdrv_change_backing_file(blk_bs(blk), qcow2_opts->backing_file,
-                                       backing_format);
+                                       backing_format, false);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Could not assign backing file '%s' "
                              "with format '%s'", qcow2_opts->backing_file,
diff --git a/block/stream.c b/block/stream.c
index aa2e7af98e37..310ccbaa4cfd 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -78,7 +78,7 @@ static int stream_prepare(Job *job)
             }
         }
         bdrv_set_backing_hd(bs, base, &local_err);
-        ret = bdrv_change_backing_file(bs, base_id, base_fmt);
+        ret = bdrv_change_backing_file(bs, base_id, base_fmt, false);
         if (local_err) {
             error_report_err(local_err);
             return -EPERM;
diff --git a/blockdev.c b/blockdev.c
index 31d5eaf6bf08..db0fbcd21499 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3429,7 +3429,8 @@ void qmp_change_backing_file(const char *device,
     }

     ret = bdrv_change_backing_file(image_bs, backing_file,
-                               image_bs->drv ? image_bs->drv->format_name : "");
+                                   image_bs->drv ? image_bs->drv->format_name : "",
+                                   false);

     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not change backing file to '%s'",
diff --git a/qemu-img.c b/qemu-img.c
index 9efe1f13482b..71a919d73676 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3807,9 +3807,9 @@ static int img_rebase(int argc, char **argv)
      * doesn't change when we switch the backing file.
      */
     if (out_baseimg && *out_baseimg) {
-        ret = bdrv_change_backing_file(bs, out_baseimg, out_basefmt);
+        ret = bdrv_change_backing_file(bs, out_baseimg, out_basefmt, false);
     } else {
-        ret = bdrv_change_backing_file(bs, NULL, NULL);
+        ret = bdrv_change_backing_file(bs, NULL, NULL, false);
     }

     if (ret == -ENOSPC) {
-- 
2.27.0


