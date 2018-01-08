Received: from eggs.gnu.org ([2001:4830:134:3::10]:55308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eYawp-00015V-6w
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eYawo-0002aK-90
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:10:55 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eYawo-0002XE-1o
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:10:54 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  8 Jan 2018 17:10:42 +0000
Message-Id: <1515431442-23795-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] configure: Fix incorrect string comparison
 operator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>

In commit c97d6d2cdf97ed we accidentally added code to configure
that uses '==' for string equality testing. This is a bashism --
the portable way to write this is '='.

This fixes the "Unexpected operator error" complaint produced
if the system /bin/sh is dash.

Fixes: c97d6d2cdf97ed
Reported-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
As an aside, it's annoying that this doesn't make configure fail;
otherwise it wouldn't have got through my build tests.
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 56f9716..6a04082 100755
--- a/configure
+++ b/configure
@@ -5076,7 +5076,7 @@ fi
 
 #################################################
 # Check to see if we have the Hypervisor framework
-if [ "$darwin" == "yes" ] ; then
+if [ "$darwin" = "yes" ] ; then
   cat > $TMPC << EOF
 #include <Hypervisor/hv.h>
 int main() { return 0;}
-- 
2.7.4
