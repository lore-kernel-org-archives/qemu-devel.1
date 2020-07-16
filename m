Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FE8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:12:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ED16207DD
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1m+GI/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED16207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw4cD-0002aT-N8
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 10:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jw4bV-0001pB-RD
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:11:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31494
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jw4bT-0002uo-69
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594908673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Cj/ZwXO30nCzdzQIaVw1/gDL65Xcwz653+gyjrcG7Bw=;
 b=D1m+GI/JSzpileGgG4HfxdCQ3wfsKstIBRFL5dVOEIy/ciDxNGukb31ZJTNwZ9nINpDNNc
 9eI9R05XjDo2VyBs2hdCAhH+Pw8L9Gmjcg30URaxJEtPY7C356rdwOO2/8SKEkR1jQxN7Y
 tOUCKQFlVKFjbXlSUYRlouIDd31VU6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251--HZ8ONe0N6e9WcWWTooP0w-1; Thu, 16 Jul 2020 10:11:11 -0400
X-MC-Unique: -HZ8ONe0N6e9WcWWTooP0w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F125100A633;
 Thu, 16 Jul 2020 14:11:10 +0000 (UTC)
Received: from localhost (unknown [10.36.110.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B4C356FDD1;
 Thu, 16 Jul 2020 14:11:03 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] os-posix: fix regression for install-less datadir location
Date: Thu, 16 Jul 2020 18:11:00 +0400
Message-Id: <20200716141100.398296-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=marcandre.lureau@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:25:38
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 joe.slater@windriver.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

os_find_datadir() used to check the ../share/qemu location (regardless
of CONFIG_QEMU_DATADIR). It turns out that people rely on that location
for running qemu in an arbitrary "install-less/portable" fashion. Change
the logic to return that directory as a last resort.

(this is an alternative to the patch "[PATCH 1/1] os_find_datadir: search
as in version 4.2" from Joe Slater)

Fixes: 6dd2dacedd83d12328 ("os-posix: simplify os_find_datadir")
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 os-posix.c            | 15 ++++++++++++---
 scripts/create_config |  2 +-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/os-posix.c b/os-posix.c
index b674b20b1b1..bd0ed0c14d1 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -82,8 +82,13 @@ void os_setup_signal_handling(void)
 
 /*
  * Find a likely location for support files using the location of the binary.
- * When running from the build tree this will be "$bindir/../pc-bios".
- * Otherwise, this is CONFIG_QEMU_DATADIR.
+ *
+ * If running from the install location (CONFIG_BINDIR), this will be
+ * CONFIG_QEMU_DATADIR.
+ *
+ * Otherwise, fallback on "$execdir/../pc-bios" if it exists (the build tree
+ * location), else on "$execdir/../share/qemu" (for the install-less/"portable"
+ * version).
  */
 char *os_find_datadir(void)
 {
@@ -93,12 +98,16 @@ char *os_find_datadir(void)
     exec_dir = qemu_get_exec_dir();
     g_return_val_if_fail(exec_dir != NULL, NULL);
 
+    if (g_str_has_prefix(exec_dir, CONFIG_BINDIR)) {
+        return g_strdup(CONFIG_QEMU_DATADIR);
+    }
+
     dir = g_build_filename(exec_dir, "..", "pc-bios", NULL);
     if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
         return g_steal_pointer(&dir);
     }
 
-    return g_strdup(CONFIG_QEMU_DATADIR);
+    return g_build_filename(exec_dir, "..", "share", "qemu", NULL);
 }
 
 void os_set_proc_name(const char *s)
diff --git a/scripts/create_config b/scripts/create_config
index 6d8f08b39da..03f8cb1dc10 100755
--- a/scripts/create_config
+++ b/scripts/create_config
@@ -15,7 +15,7 @@ case $line in
     echo "#define QEMU_VERSION_MINOR $minor"
     echo "#define QEMU_VERSION_MICRO $micro"
     ;;
- qemu_*dir=* | qemu_*path=*) # qemu-specific directory configuration
+ bindir=* | qemu_*dir=* | qemu_*path=*) # qemu-specific directory configuration
     name=${line%=*}
     value=${line#*=}
     define_name=$(echo $name | LC_ALL=C tr '[a-z]' '[A-Z]')
-- 
2.27.0.221.ga08a83db2b


