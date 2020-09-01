Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0488C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:19:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82CD9206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTQ/I+w6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CD9206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2RR-0000vq-KW
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kD2Ka-0003oh-E9
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:11:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27680
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kD2KY-0006sf-DW
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598951513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N2tDKhwKMD31mzcJvpyGf7i3OTOQs+IVoyp/Lpwz2/E=;
 b=LTQ/I+w6xgrQewhx14UduUb++ozhHVrnA4fAuJ+hO4ygI6mGZP6b/qhrncl+zl/47T0wg5
 22Le8d6wKuK1/A46qAkGzsQl4juQV+7QU5/BWMczmOu8Iv0AeGtzNCoqQ70p5I+6lkEtbK
 kQBRD0RvkIJ+JLRVuStp0vwyAd7A1gA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-GOLQunEnMzCzXxNlVtD5ZQ-1; Tue, 01 Sep 2020 05:11:44 -0400
X-MC-Unique: GOLQunEnMzCzXxNlVtD5ZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCC1D800C60
 for <qemu-devel@nongnu.org>; Tue,  1 Sep 2020 09:11:43 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7ABF1672C6;
 Tue,  1 Sep 2020 09:11:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/24] meson: add NSIS building
Date: Tue,  1 Sep 2020 05:11:26 -0400
Message-Id: <20200901091132.29601-19-pbonzini@redhat.com>
In-Reply-To: <20200901091132.29601-1-pbonzini@redhat.com>
References: <20200901091132.29601-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 05:11:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200826110419.528931-9-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile        | 56 -----------------------------------
 meson.build     | 25 ++++++++++++++++
 scripts/nsis.py | 78 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+), 56 deletions(-)
 create mode 100644 scripts/nsis.py

diff --git a/Makefile b/Makefile
index 75db8be52e..f187ddf47a 100644
--- a/Makefile
+++ b/Makefile
@@ -232,62 +232,6 @@ distclean: clean ninja-distclean
 # Needed by "meson install"
 export DESTDIR
 
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
index a71b199c5e..78ac86f3a1 100644
--- a/meson.build
+++ b/meson.build
@@ -1230,6 +1230,31 @@ if build_docs
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



