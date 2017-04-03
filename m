Received: from eggs.gnu.org ([2001:4830:134:3::10]:58710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cv1ek-00074N-Tj
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cv1ej-00024s-U2
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:04:26 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:49057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cv1ej-0001yW-OB
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:04:25 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  3 Apr 2017 14:04:15 +0100
Message-Id: <1491224655-5776-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.9] configure: on Windows minimum glib
 version must be 2.30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Stefan Weil <sw@weilnetz.de>

In the 2.7 release we stated in the ChangeLog that the
minimum glib version for Windows hosts was 2.30, but we
didn't update configure to enforce this because we were
very close to the release at the point where we noticed
the issue, and it only affected building the test suite.
We then forgot that we needed to do it. Fix the omission.

(The reason for the 2.30 requirement is use of
g_dir_make_tmp() -- our fallback implementation uses
mkdtemp(), which isn't available on Windows.)

Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 4b3b5cd..be4d326 100755
--- a/configure
+++ b/configure
@@ -3073,7 +3073,11 @@ fi
 ##########################################
 # glib support probe
 
-glib_req_ver=2.22
+if test "$mingw32" = yes; then
+    glib_req_ver=2.30
+else
+    glib_req_ver=2.22
+fi
 glib_modules=gthread-2.0
 if test "$modules" = yes; then
     glib_modules="$glib_modules gmodule-2.0"
-- 
2.7.4
