Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C752C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:34:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936F320C09
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fkMJZ3Cz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936F320C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFFQA-0002d7-H6
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 07:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF32-0003th-Q9
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:10:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20815)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF30-0008GI-CN
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599477053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/yQ7QSI1AfkPwN00Qa4u7oW1HjhsKBPwHb36qg1a30o=;
 b=fkMJZ3CzAdMYGivFUp5YV9Qn6qDpLkjna807om5AbzNasQ0OgMcjNLDCK8qa/Fy5pec2Zu
 H0dZ/V/QGkE0Q/N/WqdW3B8c6B/lCboIzeiFApX59AJxQwbuBVzxDMQXXFCJrjh3YHRks+
 exQpBuglKNKEYTMrtQG6mtSe+odMPVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-lYTA0T_4OHiRtRW9Y0Ir_g-1; Mon, 07 Sep 2020 07:10:51 -0400
X-MC-Unique: lYTA0T_4OHiRtRW9Y0Ir_g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9094B802B49;
 Mon,  7 Sep 2020 11:10:50 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-154.ams2.redhat.com
 [10.36.114.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 98DB57E435;
 Mon,  7 Sep 2020 11:10:49 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 51/64] blockdev: Fix active commit choice
Date: Mon,  7 Sep 2020 13:09:23 +0200
Message-Id: <20200907110936.261684-52-kwolf@redhat.com>
In-Reply-To: <20200907110936.261684-1-kwolf@redhat.com>
References: <20200907110936.261684-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:52:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Max Reitz <mreitz@redhat.com>

We have to perform an active commit whenever the top node has a parent
that has taken the WRITE permission on it.

This means that block-commit's @backing-file parameter is no longer
allowed for such nodes, and that users will have to issue a
block-job-complete command.  Neither should pose a problem in practice,
because this case was basically just broken until now.

(Since this commit already touches block-commit's documentation, it also
moves up the chunk explaining general block-commit behavior that for
some reason was situated under @backing-file.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json | 39 ++++++++++++++++++++-------------------
 blockdev.c           | 35 ++++++++++++++++++++++++++++++-----
 2 files changed, 50 insertions(+), 24 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index e34796d98f..0345f6f2d2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1569,6 +1569,18 @@
 # Live commit of data from overlay image nodes into backing nodes - i.e.,
 # writes data between 'top' and 'base' into 'base'.
 #
+# If top == base, that is an error.
+# If top has no overlays on top of it, or if it is in use by a writer,
+# the job will not be completed by itself.  The user needs to complete
+# the job with the block-job-complete command after getting the ready
+# event. (Since 2.0)
+#
+# If the base image is smaller than top, then the base image will be
+# resized to be the same size as top.  If top is smaller than the base
+# image, the base will not be truncated.  If you want the base image
+# size to match the size of the smaller top, you can safely truncate
+# it yourself once the commit operation successfully completes.
+#
 # @job-id: identifier for the newly-created block job. If
 #          omitted, the device name will be used. (Since 2.7)
 #
@@ -1593,14 +1605,15 @@
 #       accepted
 #
 # @backing-file: The backing file string to write into the overlay
-#                image of 'top'.  If 'top' is the active layer,
-#                specifying a backing file string is an error. This
-#                filename is not validated.
+#                image of 'top'.  If 'top' does not have an overlay
+#                image, or if 'top' is in use by a writer, specifying
+#                a backing file string is an error.
 #
-#                If a pathname string is such that it cannot be
-#                resolved by QEMU, that means that subsequent QMP or
-#                HMP commands must use node-names for the image in
-#                question, as filename lookup methods will fail.
+#                This filename is not validated.  If a pathname string
+#                is such that it cannot be resolved by QEMU, that
+#                means that subsequent QMP or HMP commands must use
+#                node-names for the image in question, as filename
+#                lookup methods will fail.
 #
 #                If not specified, QEMU will automatically determine
 #                the backing file string to use, or error out if
@@ -1609,18 +1622,6 @@
 #                filename or protocol.
 #                (Since 2.1)
 #
-#                If top == base, that is an error.
-#                If top == active, the job will not be completed by itself,
-#                user needs to complete the job with the block-job-complete
-#                command after getting the ready event. (Since 2.0)
-#
-#                If the base image is smaller than top, then the base image
-#                will be resized to be the same size as top.  If top is
-#                smaller than the base image, the base will not be
-#                truncated.  If you want the base image size to match the
-#                size of the smaller top, you can safely truncate it
-#                yourself once the commit operation successfully completes.
-#
 # @speed: the maximum speed, in bytes per second
 #
 # @on-error: the action to take on an error. 'ignore' means that the request
diff --git a/blockdev.c b/blockdev.c
index f308adc9aa..7f2561081e 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2602,6 +2602,7 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
     AioContext *aio_context;
     Error *local_err = NULL;
     int job_flags = JOB_DEFAULT;
+    uint64_t top_perm, top_shared;
 
     if (!has_speed) {
         speed = 0;
@@ -2717,14 +2718,38 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
         goto out;
     }
 
-    if (top_bs == bs) {
+    /*
+     * Active commit is required if and only if someone has taken a
+     * WRITE permission on the top node.  Historically, we have always
+     * used active commit for top nodes, so continue that practice
+     * lest we possibly break clients that rely on this behavior, e.g.
+     * to later attach this node to a writing parent.
+     * (Active commit is never really wrong.)
+     */
+    bdrv_get_cumulative_perm(top_bs, &top_perm, &top_shared);
+    if (top_perm & BLK_PERM_WRITE ||
+        bdrv_skip_filters(top_bs) == bdrv_skip_filters(bs))
+    {
         if (has_backing_file) {
-            error_setg(errp, "'backing-file' specified,"
-                             " but 'top' is the active layer");
+            if (bdrv_skip_filters(top_bs) == bdrv_skip_filters(bs)) {
+                error_setg(errp, "'backing-file' specified,"
+                                 " but 'top' is the active layer");
+            } else {
+                error_setg(errp, "'backing-file' specified, but 'top' has a "
+                                 "writer on it");
+            }
             goto out;
         }
-        commit_active_start(has_job_id ? job_id : NULL, bs, base_bs,
-                            job_flags, speed, on_error,
+        if (!has_job_id) {
+            /*
+             * Emulate here what block_job_create() does, because it
+             * is possible that @bs != @top_bs (the block job should
+             * be named after @bs, even if @top_bs is the actual
+             * source)
+             */
+            job_id = bdrv_get_device_name(bs);
+        }
+        commit_active_start(job_id, top_bs, base_bs, job_flags, speed, on_error,
                             filter_node_name, NULL, NULL, false, &local_err);
     } else {
         BlockDriverState *overlay_bs = bdrv_find_overlay(bs, top_bs);
-- 
2.25.4


