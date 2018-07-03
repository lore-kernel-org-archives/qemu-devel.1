Received: from eggs.gnu.org ([2001:4830:134:3::10]:40287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faNjG-0005K0-Q4
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:00:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faNjD-00063j-KL
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:00:34 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:38016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1faNjD-00061H-3m
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:00:31 -0400
Received: by mail-wm0-x22d.google.com with SMTP id 69-v6so2844285wmf.3
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 09:00:30 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  3 Jul 2018 17:00:22 +0100
Message-Id: <20180703160022.10705-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] scripts/qemu-binfmt-conf.sh: allow clearing of
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

Currently running the script twice will fail with "sh: echo: I/O
error" as the registration is already complete. Add a new option
--clear to reset the entries to save the user doing it by hand.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/qemu-binfmt-conf.sh | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index d7eefda0b8..13ef4713e6 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -160,7 +160,7 @@ qemu_get_family() {
 usage() {
     cat <<EOF
 Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
-                           [--help][--credential yes|no][--exportdir PATH]
+                           [--help][--clear][--credential yes|no][--exportdir PATH]
 
        Configure binfmt_misc to use qemu interpreter
 
@@ -176,6 +176,7 @@ Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
                      (default: $SYSTEMDDIR or $DEBIANDIR)
        --credential: if yes, credential and security tokens are
                      calculated according to the binary to interpret
+       --clear:      clear existing qemu binfmt registrations
 
     To import templates with update-binfmts, use :
 
@@ -249,6 +250,13 @@ qemu_register_interpreter() {
     qemu_generate_register > /proc/sys/fs/binfmt_misc/register
 }
 
+qemu_clear_interpreter() {
+    if [ -e /proc/sys/fs/binfmt_misc/qemu-$cpu ]; then
+        echo "Removing qemu-$cpu as binfmt interpreter for $cpu"
+        echo -1 > /proc/sys/fs/binfmt_misc/qemu-$cpu
+    fi
+}
+
 qemu_generate_systemd() {
     echo "Setting $qemu as binfmt interpreter for $cpu for systemd-binfmt.service"
     qemu_generate_register > "$EXPORTDIR/qemu-$cpu.conf"
@@ -302,7 +310,7 @@ DEBIANDIR="/usr/share/binfmts"
 QEMU_PATH=/usr/local/bin
 FLAGS=""
 
-options=$(getopt -o ds:Q:e:hc: -l debian,systemd:,qemu-path:,exportdir:,help,credential: -- "$@")
+options=$(getopt -o ds:Q:e:hc: -l debian,systemd:,qemu-path:,exportdir:,help,clear,credential: -- "$@")
 eval set -- "$options"
 
 while true ; do
@@ -354,6 +362,10 @@ while true ; do
             FLAGS=""
         fi
         ;;
+    --clear)
+        shift
+        BINFMT_SET=qemu_clear_interpreter
+        ;;
     *)
         break
         ;;
-- 
2.17.1
