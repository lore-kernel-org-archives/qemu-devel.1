Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDF4C3A5A6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 00:19:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824DE217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 00:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824DE217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB6e8-0000RC-GT
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 20:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iB6d5-00083X-US
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 20:18:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iB6d4-0006T4-J7
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 20:18:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44114)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1iB6d4-0006Sk-BY
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 20:18:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A72C23D962;
 Fri, 20 Sep 2019 00:18:29 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-38.bos.redhat.com [10.18.17.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C4E515D9CD;
 Fri, 20 Sep 2019 00:18:23 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC] docker: automatic dependencies for dockerfiles
Date: Thu, 19 Sep 2019 20:18:23 -0400
Message-Id: <20190920001823.23279-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 20 Sep 2019 00:18:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a demo for using makefile dependencies for image requisites.
Honestly, I don't like it -- Makefile sorcery is a bit beyond my
comprehension.

This is as near as I could stab, and it has the unfortunate requisite
that it will generate all of the *.d files at first run and not in an
on-demand way. Boo.

But, I wanted to raise the point that manually managing the variables
is not long-term viable -- we should manage them automatically if we
can.

As far as "partial" images vs "full" images, we should manage this
too; perhaps by subdirectory on the dockerfiles -- that way these
won't get out of date, either.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/docker/Makefile.include | 37 ++++++++-------------------------
 tests/docker/deputil.py       | 39 +++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 28 deletions(-)
 create mode 100755 tests/docker/deputil.py

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
index 50a400b573..266395d927 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -21,6 +21,7 @@ DOCKER_TOOLS :=3D travis
 ENGINE :=3D auto
=20
 DOCKER_SCRIPT=3D$(SRC_PATH)/tests/docker/docker.py --engine $(ENGINE)
+DEPTOOL=3D$(SRC_PATH)/tests/docker/deputil.py
=20
 TESTS ?=3D %
 IMAGES ?=3D %
@@ -47,12 +48,12 @@ docker-image: ${DOCKER_TARGETS}
 # invoked with SKIP_DOCKER_BUILD we still check the image is up to date
 # though
 ifdef SKIP_DOCKER_BUILD
-docker-image-%: $(DOCKER_FILES_DIR)/%.docker
+docker-image-%: $(DOCKER_FILES_DIR)/%.docker %.d
 	$(call quiet-command, \
 		$(DOCKER_SCRIPT) check --quiet qemu:$* $<, \
 		"CHECK", "$*")
 else
-docker-image-%: $(DOCKER_FILES_DIR)/%.docker
+docker-image-%: $(DOCKER_FILES_DIR)/%.docker %.d
 	$(call quiet-command,\
 		$(DOCKER_SCRIPT) build qemu:$* $< \
 		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
@@ -88,23 +89,17 @@ docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/deb=
ian-bootstrap.docker
 endif
=20
 # Enforce dependencies for composite images
-docker-image-debian9-mxe: docker-image-debian9
+%.d: $(DOCKER_FILES_DIR)/%.docker
+	$(call quiet-command, $(DEPTOOL) $(DOCKER_FILES_DIR)/$*.docker > $@)
+
+DEPFILES :=3D $(DOCKER_IMAGES:%=3D%.d)
+include $(DEPFILES)
+
 ifeq ($(ARCH),x86_64)
-docker-image-debian-amd64: docker-image-debian9
 DOCKER_PARTIAL_IMAGES +=3D debian-amd64-cross
 else
-docker-image-debian-amd64-cross: docker-image-debian10
 DOCKER_PARTIAL_IMAGES +=3D debian-amd64
 endif
-docker-image-debian-armel-cross: docker-image-debian9
-docker-image-debian-armhf-cross: docker-image-debian9
-docker-image-debian-mips-cross: docker-image-debian9
-docker-image-debian-mipsel-cross: docker-image-debian9
-docker-image-debian-mips64el-cross: docker-image-debian9
-docker-image-debian-ppc64el-cross: docker-image-debian9
-docker-image-debian-s390x-cross: docker-image-debian9
-docker-image-debian-win32-cross: docker-image-debian9-mxe
-docker-image-debian-win64-cross: docker-image-debian9-mxe
=20
 # For non-x86 hosts not all cross-compilers have been packaged
 ifneq ($(ARCH),x86_64)
@@ -115,22 +110,8 @@ DOCKER_PARTIAL_IMAGES +=3D debian-win32-cross debian=
-win64-cross
 DOCKER_PARTIAL_IMAGES +=3D fedora travis
 endif
=20
-docker-image-debian-alpha-cross: docker-image-debian10
-docker-image-debian-arm64-cross: docker-image-debian10
-docker-image-debian-hppa-cross: docker-image-debian10
-docker-image-debian-m68k-cross: docker-image-debian10
-docker-image-debian-mips64-cross: docker-image-debian10
-docker-image-debian-powerpc-cross: docker-image-debian10
-docker-image-debian-ppc64-cross: docker-image-debian10
-docker-image-debian-riscv64-cross: docker-image-debian10
-docker-image-debian-sh4-cross: docker-image-debian10
-docker-image-debian-sparc64-cross: docker-image-debian10
-
 docker-image-travis: NOUSER=3D1
=20
-# Specialist build images, sometimes very limited tools
-docker-image-tricore-cross: docker-image-debian9
-
 # These images may be good enough for building tests but not for test bu=
ilds
 DOCKER_PARTIAL_IMAGES +=3D debian-alpha-cross
 DOCKER_PARTIAL_IMAGES +=3D debian-hppa-cross
diff --git a/tests/docker/deputil.py b/tests/docker/deputil.py
new file mode 100755
index 0000000000..69711cf85e
--- /dev/null
+++ b/tests/docker/deputil.py
@@ -0,0 +1,39 @@
+#!/usr/bin/env python3
+import os
+import re
+import sys
+from typing import IO, Optional
+
+def get_dep(infile: IO[str]) -> Optional[str]:
+    """Get a dependency as a string from a dockerfile."""
+    for line in infile:
+        match =3D re.match(r'FROM (.+)', line)
+        if match:
+            return match[1]
+    return None
+
+def get_qemu_dep(infile: IO[str]) -> Optional[str]:
+    """Get a dependency on the qemu: namespace from a dockerfile."""
+    dep =3D get_dep(infile) or ''
+    match =3D re.match(r'qemu:(.+)', dep)
+    return match[1] if match else None
+
+def main() -> None:
+    filename =3D sys.argv[1]
+    basefile =3D os.path.basename(filename)
+    base =3D os.path.splitext(basefile)[0]
+    depfile =3D f"{base}.d"
+    deps =3D [filename]
+
+    print(f"{depfile}: {filename}")
+    with open(filename, "r") as infile:
+        match =3D get_qemu_dep(infile) or ''
+        if match:
+            deps.append(f"docker-image-{match}")
+    print("{}: {}".format(
+        f"docker-image-{base}",
+        " ".join(deps)
+    ))
+
+if __name__ =3D=3D '__main__':
+    main()
--=20
2.21.0


