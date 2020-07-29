Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B5CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:15:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68E020656
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4z/j33M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68E020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0uMc-0005Nt-TT
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 18:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1k0uLV-0003eB-7x
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 18:14:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25758
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1k0uLS-0001B0-9l
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 18:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596060880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yWt3zKX5kSTo4Po7yflNFrC7QnaOp+4ZYcdeS58v6Ig=;
 b=T4z/j33MlJOfxnjvYxOLRhkSEOy+DEO1DrcbK1iWKP+rdTikxS8F/iTa+3D0VK8cBqAJAZ
 tt/XTk3k8LIRgEVwdBMkXqBLZGQtrH882INfSsi5SkNOTHcjw4oWYUZ+5Q4kdlxMT3G45u
 K4l680OjrLCAXpXPgHS+mWeS3IyHBR0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-qRVLW7a7OxGu3VEwcyv9Aw-1; Wed, 29 Jul 2020 18:14:38 -0400
X-MC-Unique: qRVLW7a7OxGu3VEwcyv9Aw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D84FD102C7EC
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 22:14:37 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-149.rdu2.redhat.com [10.10.116.149])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41EF775559;
 Wed, 29 Jul 2020 22:14:32 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id C8210223D05; Wed, 29 Jul 2020 18:14:31 -0400 (EDT)
From: Vivek Goyal <vgoyal@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] virtiofsd: create lock/pid file in per user cache dir
Date: Wed, 29 Jul 2020 18:14:07 -0400
Message-Id: <20200729221410.147556-3-vgoyal@redhat.com>
In-Reply-To: <20200729221410.147556-1-vgoyal@redhat.com>
References: <20200729221410.147556-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:18:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: berrange@redhat.com, vromanso@redhat.com, dgilbert@redhat.com,
 virtio-fs@redhat.com, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Right now we create lock/pid file in /usr/local/var/... and unprivliged
user does not have access to create files there.

So create this file in per user cache dir as queried as specified
by environment variable XDG_RUNTIME_DIR.

Note: "su $USER" does not update XDG_RUNTIME_DIR and it still points to
root user's director. So for now I create a directory /tmp/$UID to save
lock/pid file. Dan pointed out that it can be a problem if a malicious
app already has /tmp/$UID created. So we probably need to get rid of this.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 tools/virtiofsd/fuse_virtio.c | 40 ++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index 6b21a93841..f763a70ba5 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -972,13 +972,43 @@ static bool fv_socket_lock(struct fuse_session *se)
     g_autofree gchar *pidfile = NULL;
     g_autofree gchar *dir = NULL;
     Error *local_err = NULL;
+    gboolean unprivileged = false;
 
-    dir = qemu_get_local_state_pathname("run/virtiofsd");
+    if (geteuid() != 0)
+        unprivileged = true;
 
-    if (g_mkdir_with_parents(dir, S_IRWXU) < 0) {
-        fuse_log(FUSE_LOG_ERR, "%s: Failed to create directory %s: %s",
-                 __func__, dir, strerror(errno));
-        return false;
+    /*
+     * Unpriviliged users don't have access to /usr/local/var. Hence
+     * store lock/pid file in per user directory. Use environment
+     * variable XDG_RUNTIME_DIR.
+     * If one logs into the system as root and then does "su" then
+     * XDG_RUNTIME_DIR still points to root user directory. In that
+     * case create a directory for user in /tmp/$UID
+     */
+    if (unprivileged) {
+        gchar *user_dir = NULL;
+        gboolean create_dir = false;
+        user_dir = g_strdup(g_get_user_runtime_dir());
+        if (!user_dir || g_str_has_suffix(user_dir, "/0")) {
+            user_dir = g_strdup_printf("/tmp/%d", geteuid());
+            create_dir = true;
+        }
+
+        if (create_dir && g_mkdir_with_parents(user_dir, S_IRWXU) < 0) {
+            fuse_log(FUSE_LOG_ERR, "%s: Failed to create directory %s: %s",
+                     __func__, user_dir, strerror(errno));
+            g_free(user_dir);
+            return false;
+        }
+        dir = g_strdup(user_dir);
+        g_free(user_dir);
+    } else {
+        dir = qemu_get_local_state_pathname("run/virtiofsd");
+        if (g_mkdir_with_parents(dir, S_IRWXU) < 0) {
+            fuse_log(FUSE_LOG_ERR, "%s: Failed to create directory %s: %s",
+                     __func__, dir, strerror(errno));
+            return false;
+        }
     }
 
     sk_name = g_strdup(se->vu_socket_path);
-- 
2.25.4


