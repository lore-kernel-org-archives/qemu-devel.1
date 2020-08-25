Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC06C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:02:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2515E20715
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGvztryY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2515E20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAdH6-000436-Cd
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 14:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kAdE4-0000Vg-OP
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 13:59:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45221)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kAdE2-0003Tr-CT
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 13:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598378353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Yht4X/+ViXbgjzJlQR/gjv+vQ6cj6WUvGJ0e7LvyYw=;
 b=dGvztryYVqi+WnbkYA4OfiFoANQlGOdYsDOrgKDrpHMChvydeOH/ELY3DMeG0Bw0Ysqj9A
 R+m1GFHlpKjECL0FOnTcc86/7GNtiNXU951vPBdAv/M/Ik3Z2hQyYIA3UxwO6OHh/Nkop5
 RaDq5Dc1SGPpD+jLyyyBrMrvJd334BU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-mVcP5CXUNDSF1TXhXeoDSA-1; Tue, 25 Aug 2020 13:59:09 -0400
X-MC-Unique: mVcP5CXUNDSF1TXhXeoDSA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDB9D10082E7;
 Tue, 25 Aug 2020 17:59:08 +0000 (UTC)
Received: from localhost (unknown [10.36.110.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9918A1002D48;
 Tue, 25 Aug 2020 17:59:07 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/5] meson: add NSIS building
Date: Tue, 25 Aug 2020 21:58:27 +0400
Message-Id: <20200825175827.355940-6-marcandre.lureau@redhat.com>
In-Reply-To: <20200825175827.355940-1-marcandre.lureau@redhat.com>
References: <20200825175827.355940-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:03:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
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
Cc: sw@weilnetz.de, berrange@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 Makefile        | 56 -----------------------------------
 meson.build     | 25 ++++++++++++++++
 scripts/nsis.py | 78 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+), 56 deletions(-)
 create mode 100644 scripts/nsis.py

diff --git a/Makefile b/Makefile
index 81794d5c34..3ebd6929b4 100644
--- a/Makefile
+++ b/Makefile
@@ -294,62 +294,6 @@ endif
 		"$(DESTDIR)$(qemu_desktopdir)/qemu.desktop"
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/keymaps"
 
-ifdef CONFIG_WIN32
-
-INSTALLER = qemu-setup-$(VERSION)$(EXESUF)
-
-nsisflags = -V2 -NOCD
-
-ifneq ($(wildcard $(SRC_PATH)/dll),)
-ifeq ($(ARCH),x86_64)
-# 64 bit executables
-DLL_PATH = $(SRC_PATH)/dll/w64
-nsisflags += -DW64
-else
-# 32 bit executables
-DLL_PATH = $(SRC_PATH)/dll/w32
-endif
-endif
-
-.PHONY: installer
-installer: $(INSTALLER)
-
-INSTDIR=/tmp/qemu-nsis
-
-$(INSTALLER): $(SRC_PATH)/qemu.nsi
-	$(MAKE) install DESTDIR=${INSTDIR}
-ifdef SIGNCODE
-	(cd ${INSTDIR}/${bindir}; \
-         for i in *.exe; do \
-           $(SIGNCODE) $${i}; \
-         done \
-        )
-endif # SIGNCODE
-	(cd ${INSTDIR}/${bindir}; \
-         for i in qemu-system-*.exe; do \
-           arch=$${i%.exe}; \
-           arch=$${arch#qemu-system-}; \
-           echo Section \"$$arch\" Section_$$arch; \
-           echo SetOutPath \"\$$INSTDIR\"; \
-           echo File \"\$${BINDIR}\\$$i\"; \
-           echo SectionEnd; \
-         done \
-        ) >${INSTDIR}/${bindir}/system-emulations.nsh
-	makensis $(nsisflags) \
-                $(if $(BUILD_DOCS),-DCONFIG_DOCUMENTATION="y") \
-                $(if $(CONFIG_GTK),-DCONFIG_GTK="y") \
-                -DBINDIR="${INSTDIR}/${bindir}" \
-                $(if $(DLL_PATH),-DDLLDIR="$(DLL_PATH)") \
-                -DSRCDIR="$(SRC_PATH)" \
-                -DOUTFILE="$(INSTALLER)" \
-                -DDISPLAYVERSION="$(VERSION)" \
-                $(SRC_PATH)/qemu.nsi
-	rm -r ${INSTDIR}
-ifdef SIGNCODE
-	$(SIGNCODE) $(INSTALLER)
-endif # SIGNCODE
-endif # CONFIG_WIN
-
 # Add a dependency on the generated files, so that they are always
 # rebuilt before other object files
 ifneq ($(wildcard config-host.mak),)
diff --git a/meson.build b/meson.build
index 0720a7d684..bc2bea23b2 100644
--- a/meson.build
+++ b/meson.build
@@ -1217,6 +1217,31 @@ if build_docs
   endif
 endif
 
+if host_machine.system() == 'windows'
+  nsis_cmd = [
+    find_program('scripts/nsis.py'),
+    '@OUTPUT@',
+    get_option('prefix'),
+    meson.current_source_dir(),
+    host_machine.cpu_family(),
+    '--',
+    '-DDISPLAYVERSION=' + meson.project_version(),
+  ]
+  if build_docs
+    nsis_cmd += '-DCONFIG_DOCUMENTATION=y'
+  endif
+  if 'CONFIG_GTK' in config_host
+    nsis_cmd += '-DCONFIG_GTK=y'
+  endif
+
+  nsis = custom_target('nsis',
+                       output: 'qemu-setup-' + meson.project_version() + '.exe',
+                       input: files('qemu.nsi'),
+                       build_always_stale: true,
+                       command: nsis_cmd + ['@INPUT@'])
+  alias_target('installer', nsis)
+endif
+
 summary_info = {}
 summary_info += {'Install prefix':    config_host['prefix']}
 summary_info += {'BIOS directory':    config_host['qemu_datadir']}
diff --git a/scripts/nsis.py b/scripts/nsis.py
new file mode 100644
index 0000000000..e1c409344e
--- /dev/null
+++ b/scripts/nsis.py
@@ -0,0 +1,78 @@
+#!/usr/bin/env python3
+#
+# Copyright (C) 2020 Red Hat, Inc.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import argparse
+import glob
+import os
+import shutil
+import subprocess
+import tempfile
+
+
+def signcode(path):
+    cmd = os.environ.get("SIGNCODE")
+    if not cmd:
+        return
+    subprocess.run([cmd, path])
+
+
+def main():
+    parser = argparse.ArgumentParser(description="QEMU NSIS build helper.")
+    parser.add_argument("outfile")
+    parser.add_argument("prefix")
+    parser.add_argument("srcdir")
+    parser.add_argument("cpu")
+    parser.add_argument("nsisargs", nargs="*")
+    args = parser.parse_args()
+
+    destdir = tempfile.mkdtemp()
+    try:
+        subprocess.run(["make", "install", "DESTDIR=" + destdir + os.path.sep])
+        with open(
+            os.path.join(destdir + args.prefix, "system-emulations.nsh"), "w"
+        ) as nsh:
+            for exe in glob.glob(
+                os.path.join(destdir + args.prefix, "qemu-system-*.exe")
+            ):
+                exe = os.path.basename(exe)
+                arch = exe[12:-4]
+                nsh.write(
+                    """
+                Section "{0}" Section_{0}
+                SetOutPath "$INSTDIR"
+                File "${{BINDIR}}\\{1}"
+                SectionEnd
+                """.format(
+                        arch, exe
+                    )
+                )
+
+        for exe in glob.glob(os.path.join(destdir + args.prefix, "*.exe")):
+            signcode(exe)
+
+        makensis = [
+            "makensis",
+            "-V2",
+            "-NOCD",
+            "-DSRCDIR=" + args.srcdir,
+            "-DBINDIR=" + destdir + args.prefix,
+        ]
+        dlldir = "w32"
+        if args.cpu == "x86_64":
+            dlldir = "w64"
+            makensis += ["-DW64"]
+        if os.path.exists(os.path.join(args.srcdir, "dll")):
+            makensis += "-DDLLDIR={0}/dll/{1}".format(args.srcdir, dlldir)
+
+        makensis += ["-DOUTFILE=" + args.outfile] + args.nsisargs
+        subprocess.run(makensis)
+        signcode(args.outfile)
+    finally:
+        shutil.rmtree(destdir)
+
+
+if __name__ == "__main__":
+    main()
-- 
2.26.2


