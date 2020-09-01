Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267E4C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:22:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E23072071B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvMm+F0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23072071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCzh2-0002Vc-2B
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 02:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCzef-00062H-Oc
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 02:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27665)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCzed-0000me-PV
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 02:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598941226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VFTSKgbtfOAZ0MhoeAhMnWBNPjjt3/Q0xsLFhvDTcA8=;
 b=MvMm+F0g+V96wFaazpJgyNSRryIhzy0D0nqHbjyOtFGzP4bCK5l+t99SoIVBfqRb45UMPt
 asxecdxloS9+e5aFFnLSNEI06ly5bmEuHs3Nfgfxy/QDKEieJcENpSflzAYGab2TruGC+6
 Hkz+8kQ5Je/o4sa4RjXnTB8pC7AM6gw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-ftj5EehnPvqSuh8ElIiUSA-1; Tue, 01 Sep 2020 02:20:23 -0400
X-MC-Unique: ftj5EehnPvqSuh8ElIiUSA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B9FD801AC5;
 Tue,  1 Sep 2020 06:20:22 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 184401002D4E;
 Tue,  1 Sep 2020 06:20:22 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/13] oslib-posix: default exec_dir to bindir
Date: Tue,  1 Sep 2020 02:20:10 -0400
Message-Id: <20200901062020.26660-4-pbonzini@redhat.com>
In-Reply-To: <20200901062020.26660-1-pbonzini@redhat.com>
References: <20200901062020.26660-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 01:27:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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
 util/oslib-win32.c |  2 ++
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/meson.build b/meson.build
index 93182d36e3..10ab189bc5 100644
--- a/meson.build
+++ b/meson.build
@@ -415,7 +415,7 @@ config_host_data.set('QEMU_VERSION_MINOR', meson.project_version().split('.')[1]
 config_host_data.set('QEMU_VERSION_MICRO', meson.project_version().split('.')[2])
 
 arrays = ['CONFIG_AUDIO_DRIVERS', 'CONFIG_BDRV_RW_WHITELIST', 'CONFIG_BDRV_RO_WHITELIST']
-strings = ['HOST_DSOSUF', 'CONFIG_IASL', 'qemu_confdir', 'qemu_datadir',
+strings = ['HOST_DSOSUF', 'CONFIG_IASL', 'bindir', 'qemu_confdir', 'qemu_datadir',
            'qemu_moddir', 'qemu_localstatedir', 'qemu_helperdir', 'qemu_localedir',
            'qemu_icondir', 'qemu_desktopdir', 'qemu_firmwarepath']
 foreach k, v: config_host
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 0dd8d24076..a68fccb52d 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -358,15 +358,14 @@ void qemu_set_tty_echo(int fd, bool echo)
     tcsetattr(fd, TCSANOW, &tty);
 }
 
-static char exec_dir[PATH_MAX];
+static char *exec_dir;
 
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
+        exec_dir = g_strdup(CONFIG_BINDIR);
+    }
 }
 
 const char *qemu_get_exec_dir(void)
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 1a33912944..8d3f940a54 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -341,6 +341,8 @@ void qemu_init_exec_dir(const char *argv0)
     *p = 0;
     if (access(buf, R_OK) == 0) {
         exec_dir = g_strdup(buf);
+    } else {
+        exec_dir = g_strdup(CONFIG_BINDIR);
     }
 }
 
-- 
2.26.2



