Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3197AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:03:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E6A20748
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4BtTF5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E6A20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqh5J-0004iL-6y
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 14:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqh4f-00045w-Hj
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 14:03:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41996
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqh4d-0000Ml-5V
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 14:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593626586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=rZjV98Q4tintM65GVVrOAXnUsfXFn5cWwaXEhXfiDPU=;
 b=H4BtTF5YympgwmiqT0U3KPmSvslEECt0DJMbgxY7+0o+vOikYYP4mAeCTxDpOrmdhA1c/C
 mi2wGb5v3Ur8p3bzEOMKrfm+RCm43WSU9uOJoR3R1Vzu8Eg98EhKz298LwP+kRYky9zZMt
 UzFRBvT1nM6/iSAp+S+7bpDBz0jQYZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-8hKQFJUcMF2sylEGNTvk4A-1; Wed, 01 Jul 2020 14:03:04 -0400
X-MC-Unique: 8hKQFJUcMF2sylEGNTvk4A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E9DA107B7C5
 for <qemu-devel@nongnu.org>; Wed,  1 Jul 2020 18:03:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5338E5C220;
 Wed,  1 Jul 2020 18:03:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7B1CC16E16; Wed,  1 Jul 2020 20:03:02 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] util/drm: make portable
Date: Wed,  1 Jul 2020 20:03:02 +0200
Message-Id: <20200701180302.14821-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:29:47
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Given this isn't perforance critical at all lets avoid the non-portable
d_type and use fstat instead to check whenever the file is a chardev.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 util/drm.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/util/drm.c b/util/drm.c
index a23ff2453826..6ba87f34f4ee 100644
--- a/util/drm.c
+++ b/util/drm.c
@@ -24,7 +24,8 @@ int qemu_drm_rendernode_open(const char *rendernode)
 {
     DIR *dir;
     struct dirent *e;
-    int r, fd;
+    struct stat st;
+    int r, fd, ret;
     char *p;
 
     if (rendernode) {
@@ -38,10 +39,6 @@ int qemu_drm_rendernode_open(const char *rendernode)
 
     fd = -1;
     while ((e = readdir(dir))) {
-        if (e->d_type != DT_CHR) {
-            continue;
-        }
-
         if (strncmp(e->d_name, "renderD", 7)) {
             continue;
         }
@@ -53,6 +50,16 @@ int qemu_drm_rendernode_open(const char *rendernode)
             g_free(p);
             continue;
         }
+
+        /* prefer fstat() over checking e->d_type == DT_CHR for
+         * portability reasons */
+        ret = fstat(r, &st);
+        if (ret < 0 || (st.st_mode & S_IFMT) != S_IFCHR) {
+            close(r);
+            g_free(p);
+            continue;
+        }
+
         fd = r;
         g_free(p);
         break;
-- 
2.18.4


