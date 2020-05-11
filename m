Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BEDC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:00:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B45FD206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FesSOAO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45FD206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8yV-0002Y0-Jm
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 10:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jY8xL-0000zA-Na
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:58:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27141
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jY8xK-0000Ky-Rr
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589205534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4KTX/ER0DbYtzsbZSMSFIARnMnJVhcXBD9HR1WnPVJ4=;
 b=FesSOAO0NyMRDx+bqZwcTaXkXd11TX/Tcjc0Z002UR1ouNU2QQtTfOHpJxs5HUkHvdWTFg
 /DnOb3BCoz5KT7M84788PZeJKdOciRSnnDid50D/vkxrrVRwxB/z01EmIDRZkeECoa1XO0
 G99h2ZHNqw+wRTBRMe7XNv3SK+CGX8k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-xNTWHv7VMr6dU8J9q-G5eg-1; Mon, 11 May 2020 09:58:52 -0400
X-MC-Unique: xNTWHv7VMr6dU8J9q-G5eg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 398E98014C0;
 Mon, 11 May 2020 13:58:51 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-142.ams2.redhat.com
 [10.36.114.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 973BA1002382;
 Mon, 11 May 2020 13:58:49 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 3/4] mirror: Make sure that source and target size match
Date: Mon, 11 May 2020 15:58:24 +0200
Message-Id: <20200511135825.219437-4-kwolf@redhat.com>
In-Reply-To: <20200511135825.219437-1-kwolf@redhat.com>
References: <20200511135825.219437-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 00:05:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the target is shorter than the source, mirror would copy data until
it reaches the end of the target and then fail with an I/O error when
trying to write past the end.

If the target is longer than the source, the mirror job would complete
successfully, but the target wouldn't actually be an accurate copy of
the source image (it would contain some additional garbage at the end).

Fix this by checking that both images have the same size when the job
starts.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200507145228.323412-3-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/mirror.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index aca95c9bc9..201ffa26f9 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -872,6 +872,7 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
     BlockDriverState *target_bs = blk_bs(s->target);
     bool need_drain = true;
     int64_t length;
+    int64_t target_length;
     BlockDriverInfo bdi;
     char backing_filename[2]; /* we only need 2 characters because we are only
                                  checking for a NULL string */
@@ -887,24 +888,26 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
         goto immediate_exit;
     }
 
+    target_length = blk_getlength(s->target);
+    if (target_length < 0) {
+        ret = target_length;
+        goto immediate_exit;
+    }
+
     /* Active commit must resize the base image if its size differs from the
      * active layer. */
     if (s->base == blk_bs(s->target)) {
-        int64_t base_length;
-
-        base_length = blk_getlength(s->target);
-        if (base_length < 0) {
-            ret = base_length;
-            goto immediate_exit;
-        }
-
-        if (s->bdev_length > base_length) {
+        if (s->bdev_length > target_length) {
             ret = blk_truncate(s->target, s->bdev_length, false,
                                PREALLOC_MODE_OFF, 0, NULL);
             if (ret < 0) {
                 goto immediate_exit;
             }
         }
+    } else if (s->bdev_length != target_length) {
+        error_setg(errp, "Source and target image have different sizes");
+        ret = -EINVAL;
+        goto immediate_exit;
     }
 
     if (s->bdev_length == 0) {
-- 
2.25.3


