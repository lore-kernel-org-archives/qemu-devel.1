Received: from eggs.gnu.org ([2001:4830:134:3::10]:41443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dIxMK-0007JS-Pm
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:20:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dIxMG-00040a-28
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:20:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dIxMF-0003UF-PU
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:20:16 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v58DJ1lw013880
	for <qemu-devel@nongnu.org>; Thu, 8 Jun 2017 09:19:13 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ay3vmhubs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 09:19:12 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 8 Jun 2017 14:19:09 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu,  8 Jun 2017 15:18:58 +0200
In-Reply-To: <1496927940-13301-1-git-send-email-borntraeger@de.ibm.com>
References: <1496927940-13301-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1496927940-13301-4-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 3/5] pc-bios/s390-ccw: use STRIP variable in
 Makefile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cornelia.huck@de.ibm.com>, Stefan Hajnoczi <stefanha@gmail.com>, Greg Kurz <groug@kaod.org>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Greg Kurz <groug@kaod.org>

The docker-run-test-build@debian-s390x-cross target fails with:

strip --strip-unneeded s390-ccw.elf -o s390-ccw.img
strip: Unable to recognise the format of the input file `s390-ccw.elf'

The configure script defines a STRIP makefile variable whose default
value is ${cross_prefix}strip. Let's use it.

We default to using the non-prefixed strip command in case --enable-debug
or --disable-strip was passed to configure during a regular build.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <149623617700.4947.12490877660892961664.stgit@bahia.lan>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 pc-bios/s390-ccw/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 79a46b6..fb88c13 100644
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
 
-- 
2.7.4
