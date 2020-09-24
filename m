Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20B7C2D0E2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:43:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FB912388A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BbgWzpUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB912388A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLNmU-00026I-6r
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTn-00014m-Fu
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:23:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27480)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTl-000646-2I
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gGviLxAw+vrWTwDuFaNJGcXznT4SMxFyivIgoPBHBAc=;
 b=BbgWzpUNLEhvB/gIoTnASzfId9KJz621H5atTEvBFnHcQlZCvEPlu6kenvkEjqBu632eDr
 +szzTqjLdF4YniQLO3aCeDLxvL9E9+A8Yfevb5rXGH4bMj8yeyPW0N6LCOrcnwoVkrAl4z
 LRNAefoefSUJEcBa+YyCAwl5PekDl6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-kdCJo4FZNTScJxVvZhEbDA-1; Thu, 24 Sep 2020 05:23:50 -0400
X-MC-Unique: kdCJo4FZNTScJxVvZhEbDA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7770805EE5
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:23:49 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A43F860C15
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:23:49 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 41/92] oslib-posix: default exec_dir to bindir
Date: Thu, 24 Sep 2020 05:22:23 -0400
Message-Id: <20200924092314.1722645-42-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the exec_dir cannot be retrieved, just assume it's the installation
directory that was specified at configure time.  This makes it simpler
to reason about what the callers will do if they get back an empty
path.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build        |  2 +-
 util/oslib-posix.c | 23 ++++++++---------------
 util/oslib-win32.c |  4 +++-
 3 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/meson.build b/meson.build
index fedf44ed79..9a4ade7f98 100644
--- a/meson.build
+++ b/meson.build
@@ -560,7 +560,7 @@ config_host_data.set('QEMU_VERSION_MINOR', meson.project_version().split('.')[1]
 config_host_data.set('QEMU_VERSION_MICRO', meson.project_version().split('.')[2])
 
 arrays = ['CONFIG_AUDIO_DRIVERS', 'CONFIG_BDRV_RW_WHITELIST', 'CONFIG_BDRV_RO_WHITELIST']
-strings = ['HOST_DSOSUF', 'CONFIG_IASL', 'qemu_confdir', 'qemu_datadir',
+strings = ['HOST_DSOSUF', 'CONFIG_IASL', 'bindir', 'qemu_confdir', 'qemu_datadir',
            'qemu_moddir', 'qemu_localstatedir', 'qemu_helperdir', 'qemu_localedir',
            'qemu_icondir', 'qemu_desktopdir', 'qemu_firmwarepath']
 foreach k, v: config_host
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 18531fc859..1739930e65 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -358,15 +358,14 @@ void qemu_set_tty_echo(int fd, bool echo)
     tcsetattr(fd, TCSANOW, &tty);
 }
 
-static char exec_dir[PATH_MAX];
+static const char *exec_dir;
 
 void qemu_init_exec_dir(const char *argv0)
 {
-    char *dir;
     char *p = NULL;
     char buf[PATH_MAX];
 
-    if (exec_dir[0]) {
+    if (exec_dir) {
         return;
     }
 
@@ -425,20 +424,14 @@ void qemu_init_exec_dir(const char *argv0)
 #endif
     /* If we don't have any way of figuring out the actual executable
        location then try argv[0].  */
-    if (!p) {
-        if (!argv0) {
-            return;
-        }
+    if (!p && argv0) {
         p = realpath(argv0, buf);
-        if (!p) {
-            return;
-        }
     }
-    dir = g_path_get_dirname(p);
-
-    pstrcpy(exec_dir, sizeof(exec_dir), dir);
-
-    g_free(dir);
+    if (p) {
+        exec_dir = g_path_get_dirname(p);
+    } else {
+        exec_dir = CONFIG_BINDIR;
+    }
 }
 
 const char *qemu_get_exec_dir(void)
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 1a33912944..051afb217b 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -315,7 +315,7 @@ void qemu_set_tty_echo(int fd, bool echo)
     }
 }
 
-static char *exec_dir;
+static const char *exec_dir;
 
 void qemu_init_exec_dir(const char *argv0)
 {
@@ -341,6 +341,8 @@ void qemu_init_exec_dir(const char *argv0)
     *p = 0;
     if (access(buf, R_OK) == 0) {
         exec_dir = g_strdup(buf);
+    } else {
+        exec_dir = CONFIG_BINDIR;
     }
 }
 
-- 
2.26.2



