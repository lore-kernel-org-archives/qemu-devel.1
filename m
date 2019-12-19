Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94D4C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:51:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0EFD2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5xIQHof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EFD2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvGo-0000bP-8d
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihurt-0000RU-7W
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihurr-0002KJ-EP
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:25 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52167
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihurq-0002Em-LC
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6vJv+3RorrvWn+cJmBlppbndFpDtm/N3rUqEtwJZ7Wg=;
 b=R5xIQHofTi8Gb+MT2/V/BTGFe/Z5DU8vRBLrQ9Pc/QSCPgFoplRmtBBIOUoRcBIqnM1sx1
 IOdUu/Iq4M5WBxoIiouiVsB56kv88mYaH6z12kelF/NCW1V0aWbIvD+dmIuQN4REkJFpcs
 W4vQHxjyYj2otoRwOIRpCmWIl4bp2Fw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-AmuHFdzxNwaCa9qX9pS_bw-1; Thu, 19 Dec 2019 07:25:16 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20773800EBF
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:25:16 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E87B260C18;
 Thu, 19 Dec 2019 12:25:14 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 119/132] meson: add NSIS building
Date: Thu, 19 Dec 2019 13:23:39 +0100
Message-Id: <1576758232-12439-28-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: AmuHFdzxNwaCa9qX9pS_bw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile        | 57 -----------------------------------------------------=
---
 meson.build     | 23 +++++++++++++++++++++++
 scripts/nsis.sh | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 81 insertions(+), 57 deletions(-)
 create mode 100755 scripts/nsis.sh

diff --git a/Makefile b/Makefile
index ac21e14..710659b 100644
--- a/Makefile
+++ b/Makefile
@@ -335,62 +335,6 @@ cscope:
 =09find "$(SRC_PATH)/" -name "*.[chsS]" -print | sed 's,^\./,,' > "$(SRC_P=
ATH)/cscope.files"
 =09cscope -b -i"$(SRC_PATH)/cscope.files"
=20
-ifdef CONFIG_WIN32
-
-INSTALLER =3D qemu-setup-$(VERSION)$(EXESUF)
-
-nsisflags =3D -V2 -NOCD
-
-ifneq ($(wildcard $(SRC_PATH)/dll),)
-ifeq ($(ARCH),x86_64)
-# 64 bit executables
-DLL_PATH =3D $(SRC_PATH)/dll/w64
-nsisflags +=3D -DW64
-else
-# 32 bit executables
-DLL_PATH =3D $(SRC_PATH)/dll/w32
-endif
-endif
-
-.PHONY: installer
-installer: $(INSTALLER)
-
-INSTDIR=3D/tmp/qemu-nsis
-
-$(INSTALLER): $(SRC_PATH)/qemu.nsi
-=09$(MAKE) install prefix=3D${INSTDIR}
-ifdef SIGNCODE
-=09(cd ${INSTDIR}; \
-         for i in *.exe; do \
-           $(SIGNCODE) $${i}; \
-         done \
-        )
-endif # SIGNCODE
-=09(cd ${INSTDIR}; \
-         for i in qemu-system-*.exe; do \
-           arch=3D$${i%.exe}; \
-           arch=3D$${arch#qemu-system-}; \
-           echo Section \"$$arch\" Section_$$arch; \
-           echo SetOutPath \"\$$INSTDIR\"; \
-           echo File \"\$${BINDIR}\\$$i\"; \
-           echo SectionEnd; \
-         done \
-        ) >${INSTDIR}/system-emulations.nsh
-=09makensis $(nsisflags) \
-                $(if $(BUILD_DOCS),-DCONFIG_DOCUMENTATION=3D"y") \
-                $(if $(CONFIG_GTK),-DCONFIG_GTK=3D"y") \
-                -DBINDIR=3D"${INSTDIR}" \
-                $(if $(DLL_PATH),-DDLLDIR=3D"$(DLL_PATH)") \
-                -DSRCDIR=3D"$(SRC_PATH)" \
-                -DOUTFILE=3D"$(INSTALLER)" \
-                -DDISPLAYVERSION=3D"$(VERSION)" \
-                $(SRC_PATH)/qemu.nsi
-=09rm -r ${INSTDIR}
-ifdef SIGNCODE
-=09$(SIGNCODE) $(INSTALLER)
-endif # SIGNCODE
-endif # CONFIG_WIN
-
 # Add a dependency on the generated files, so that they are always
 # rebuilt before other object files
 ifneq ($(wildcard config-host.mak),)
@@ -430,7 +374,6 @@ endif
 =09@echo  ''
 ifdef CONFIG_WIN32
 =09@echo  'Windows targets:'
-=09@echo  '  installer       - Build NSIS-based installer for QEMU'
 ifdef QEMU_GA_MSI_ENABLED
 =09@echo  '  msi             - Build MSI-based installer for qemu-ga'
 endif
diff --git a/meson.build b/meson.build
index 40ba735..ce67e4c 100644
--- a/meson.build
+++ b/meson.build
@@ -1040,3 +1040,26 @@ if pod2man.found() and build_docs
                                   '--release=3D" "', '@INPUT@'])
   endforeach
 endif
+
+if host_machine.system() =3D=3D 'windows'
+  nsis_cmd =3D [
+    find_program('scripts/nsis.sh'),
+    '@OUTPUT@',
+    get_option('prefix'),
+    meson.current_source_dir(),
+    host_machine.cpu_family(),
+    '-DDISPLAYVERSION=3D@0@'.format(config_host['VERSION']),
+  ]
+  if build_docs
+    nsis_cmd +=3D '-DCONFIG_DOCUMENTATION=3Dy'
+  endif
+  if 'CONFIG_GTK' in config_host
+    nsis_cmd +=3D '-DCONFIG_GTK=3Dy'
+  endif
+
+  custom_target('nsis',
+                output: 'qemu-setup-' + config_host['VERSION'] + '.exe',
+                input: files('qemu.nsi'),
+                build_always_stale: true,
+                command: nsis_cmd + ['@INPUT@'])
+endif
diff --git a/scripts/nsis.sh b/scripts/nsis.sh
new file mode 100755
index 0000000..ad23708
--- /dev/null
+++ b/scripts/nsis.sh
@@ -0,0 +1,58 @@
+#!/bin/bash
+
+OUTFILE=3D"$1"
+shift
+PREFIX=3D"$1"
+shift
+SRCDIR=3D"$1"
+shift
+CPU=3D"$1"
+shift
+
+DESTDIR=3D$(mktemp -d)
+trap "rm -rf $DESTDIR" EXIT
+make DESTDIR=3D"$DESTDIR" install
+
+signcode() {
+    if [ -z "$SIGNCODE" ]; then
+        return
+    fi
+    "$SIGNCODE" "$@"
+}
+
+shopt -s nullglob
+
+(
+    cd "$DESTDIR$PREFIX"
+    for i in qemu-system-*.exe; do
+        arch=3D${i%.exe}
+        arch=3D${arch#qemu-system-}
+        echo Section \"$arch\" Section_$arch
+        echo SetOutPath \"\$INSTDIR\"
+        echo File \"\${BINDIR}\\$i\"
+        echo SectionEnd
+    done
+) > "$DESTDIR$PREFIX/system-emulations.nsh"
+
+(
+    cd "$DESTDIR$PREFIX"
+    for i in *.exe; do
+        signcode "$i"
+    done
+)
+
+if [ "$CPU" =3D "x86_64" ]; then
+    CPUARG=3D"-DW64"
+    DLLDIR=3D"w64"
+else
+    DLLDIR=3D"w32"
+fi
+
+if [ -d "$SRCDIR/dll" ]; then
+   DLLARG=3D"-DDLLDIR=3D$SRCDIR/dll/$DLLDIR"
+fi
+
+makensis -V2 -NOCD -DSRCDIR=3D"$SRCDIR" -DBINDIR=3D"$DESTDIR$PREFIX" \
+         $CPUARG $DLLARG -DOUTFILE=3D"$OUTFILE" "$@"
+
+signcode "$OUTFILE"
--=20
1.8.3.1



