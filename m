Received: from eggs.gnu.org ([2001:4830:134:3::10]:43238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cWwHM-0006kp-Mc
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 21:28:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cWwHJ-0000w2-FG
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 21:28:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1cWwHJ-0000tY-60
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 21:28:41 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0R2Jc8b010435
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 21:28:34 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0a-001b2d01.pphosted.com with ESMTP id 287va9j2xv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 21:28:34 -0500
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Fri, 27 Jan 2017 12:28:31 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 138C32BB0055
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 13:28:30 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v0R2SLkb31064252
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 13:28:29 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v0R2RvYD016378
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 13:27:57 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Fri, 27 Jan 2017 13:27:32 +1100
Message-Id: <5331047f1ac2abf4d44f7454497b66772426584c.1485484048.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] update-linux-headers: change SRCARCH to
 ARCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com

Currently, update-linux-headers.sh will crash when run with a clean
checkout of a recent version of the linux kernel source (e.g. 4.10-rc1):

scripts/Makefile.headersinst:62: *** Missing generated UAPI file
./arch/arm/include/generated/uapi/asm/unistd-common.h.  Stop.

This seems to be due to the script setting "SRCARCH" rather than
"ARCH" when invoking the kernel's "headers_install" target, which
prevents dependencies from being applied correctly.  (The kernel's
Documentation/kbuild/headers_install.txt refers only to "ARCH".)

So, change SRCARCH to ARCH, which corrects the problem.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---

 scripts/update-linux-headers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 72cf1fbf0a..ef11a8ab42 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -75,7 +75,7 @@ for arch in $ARCHLIST; do
         continue
     fi
 
-    make -C "$linux" INSTALL_HDR_PATH="$tmpdir" SRCARCH=$arch headers_install
+    make -C "$linux" INSTALL_HDR_PATH="$tmpdir" ARCH=$arch headers_install
 
     rm -rf "$output/linux-headers/asm-$arch"
     mkdir -p "$output/linux-headers/asm-$arch"
-- 
2.11.0
