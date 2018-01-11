Received: from eggs.gnu.org ([2001:4830:134:3::10]:52135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd40-0007R0-Ly
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd3z-00005U-NI
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:36 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eZd3z-0008UD-ES
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:35 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd3t-0005dU-It
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:38:29 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 13:38:02 +0000
Message-Id: <1515677902-23436-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
References: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 06/26] linux-user: Separate binfmt arm CPU
 families
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Michael Weiser <michael.weiser@gmx.de>

Give big-endian arm and aarch64 CPUs their own family in
qemu-binfmt-conf.sh to make sure we register qemu-user for binaries of
the opposite endianness on arm and aarch64. Apart from the family
assignments of the magic values, qemu_get_family() needs to be able to
distinguish the two and recognise aarch64{,_be} as well.

Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-id: 20171220212308.12614-7-michael.weiser@gmx.de
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/qemu-binfmt-conf.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index d699535..597efdb 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -24,7 +24,7 @@ arm_family=arm
 
 armeb_magic='\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28'
 armeb_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
-armeb_family=arm
+armeb_family=armeb
 
 sparc_magic='\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x02'
 sparc_mask='\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
@@ -94,7 +94,7 @@ aarch64_family=arm
 
 aarch64_be_magic='\x7fELF\x02\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xb7'
 aarch64_be_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
-aarch64_be_family=arm
+aarch64_be_family=armeb
 
 hppa_magic='\x7f\x45\x4c\x46\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x0f'
 hppa_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
@@ -115,9 +115,12 @@ qemu_get_family() {
     ppc64el|ppc64le)
         echo "ppcle"
         ;;
-    arm|armel|armhf|arm64|armv[4-9]*)
+    arm|armel|armhf|arm64|armv[4-9]*l|aarch64)
         echo "arm"
         ;;
+    armeb|armv[4-9]*b|aarch64_be)
+        echo "armeb"
+        ;;
     sparc*)
         echo "sparc"
         ;;
-- 
2.7.4
