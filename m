Received: from eggs.gnu.org ([2001:4830:134:3::10]:35481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFihI-0004WK-MD
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFihF-00042I-IT
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:04:36 -0400
Received: from 6.mo5.mail-out.ovh.net ([178.32.119.138]:54452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dFihF-000425-Bl
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:04:33 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id C343510018C
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 17:04:27 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 30 May 2017 17:04:14 +0200
Message-ID: <149615665491.28067.17765793725374594694.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] pc-bios/s390-ccw: use STRIP variable in
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
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-trivial@nongnu.org, Fam Zheng <famz@redhat.com>, Alexander Graf <agraf@suse.de>

The docker-run-test-build@debian-s390x-cross target fails with:

strip --strip-unneeded s390-ccw.elf -o s390-ccw.img
strip: Unable to recognise the format of the input file `s390-ccw.elf'

The configure script defines a STRIP makefile variable whose default
value is ${cross_prefix}strip. Let's use it.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 pc-bios/s390-ccw/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 79a46b67356f..7af57dad109c 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -22,7 +22,7 @@ s390-ccw.elf: $(OBJECTS)
 	$(call quiet-command,$(CC) $(LDFLAGS) -o $@ $(OBJECTS),"BUILD","$(TARGET_DIR)$@")
 
 s390-ccw.img: s390-ccw.elf
-	$(call quiet-command,strip --strip-unneeded $< -o $@,"STRIP","$(TARGET_DIR)$@")
+	$(call quiet-command,$(STRIP) --strip-unneeded $< -o $@,"STRIP","$(TARGET_DIR)$@")
 
 $(OBJECTS): Makefile
 
