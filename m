Received: from eggs.gnu.org ([2001:4830:134:3::10]:37349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dG3Nl-0008UN-S0
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:09:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dG3Nj-000489-5b
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:09:49 -0400
Received: from 15.mo5.mail-out.ovh.net ([178.33.107.29]:51350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dG3Ni-00046a-Ux
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:09:47 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 87C27FF77D
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 15:09:44 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 31 May 2017 15:09:37 +0200
Message-ID: <149623617700.4947.12490877660892961664.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2] pc-bios/s390-ccw: use STRIP variable in
 Makefile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Alexander Graf <agraf@suse.de>, Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The docker-run-test-build@debian-s390x-cross target fails with:

strip --strip-unneeded s390-ccw.elf -o s390-ccw.img
strip: Unable to recognise the format of the input file `s390-ccw.elf'

The configure script defines a STRIP makefile variable whose default
value is ${cross_prefix}strip. Let's use it.

We default to using the non-prefixed strip command in case --enable-debug
or --disable-strip was passed to configure during a regular build.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
v2: - added default value
    - no longer Cc: qemu-trivial as it turned out to be not that trivial

Philippe,

Please give your Reviewed-by again if you're okay with this change.
---
 pc-bios/s390-ccw/Makefile |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 79a46b67356f..fb88c13bc742 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -21,8 +21,10 @@ build-all: s390-ccw.img
 s390-ccw.elf: $(OBJECTS)
 	$(call quiet-command,$(CC) $(LDFLAGS) -o $@ $(OBJECTS),"BUILD","$(TARGET_DIR)$@")
 
+STRIP ?= strip
+
 s390-ccw.img: s390-ccw.elf
-	$(call quiet-command,strip --strip-unneeded $< -o $@,"STRIP","$(TARGET_DIR)$@")
+	$(call quiet-command,$(STRIP) --strip-unneeded $< -o $@,"STRIP","$(TARGET_DIR)$@")
 
 $(OBJECTS): Makefile
 
