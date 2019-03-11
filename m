Received: from eggs.gnu.org ([209.51.188.92]:45576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3RPR-0003Iq-K2
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3RNn-0000bf-J5
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:18:48 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:26109 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h3RNn-0000Y1-8e
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:18:47 -0400
Date: Mon, 11 Mar 2019 20:18:48 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
Message-ID: <20190311201848.GB9@59ca1d9b7985>
References: <20190311201532.GA6@59ca1d9b7985>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311201532.GA6@59ca1d9b7985>
Subject: [Qemu-devel] [PATCH v5 2/9] qemu-binfmt-conf.sh: make opts -p and
 -c boolean
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, eblake@redhat.com

This patch breaks backward compatibility.

Both '--persistent' and '--credential' default to 'no'. Hence, '-p no'
or '-c no' are reduntant. Overall, accepting an argument might be
misleading because options are, indeed, boolean. This patch makes both
options boolean in getopt, so if any of them is provided the corresponding
variable is set to true.

Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 scripts/qemu-binfmt-conf.sh | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 0009385be2..ca15ff8092 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -168,8 +168,8 @@ qemu_get_family() {
 usage() {
     cat <<EOF
 Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
-                           [--help][--credential yes|no][--exportdir PATH]
-                           [--persistent yes|no][--qemu-suffix SUFFIX]
+                           [--help][--credential][--exportdir PATH]
+                           [--persistent][--qemu-suffix SUFFIX]

        Configure binfmt_misc to use qemu interpreter

@@ -184,9 +184,9 @@ Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
                       file for all known cpus
        --exportdir:   define where to write configuration files
                       (default: $SYSTEMDDIR or $DEBIANDIR)
-       --credential:  if yes, credential and security tokens are
+       --credential:  if present, credential and security tokens are
                       calculated according to the binary to interpret
-       --persistent:  if yes, the interpreter is loaded when binfmt is
+       --persistent:  if present, the interpreter is loaded when binfmt is
                       configured and remains in memory. All future uses
                       are cloned from the open file.

@@ -324,7 +324,7 @@ CREDENTIAL=no
 PERSISTENT=no
 QEMU_SUFFIX=""

-options=$(getopt -o ds:Q:S:e:hc:p: -l debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,credential:,persistent: -- "$@")
+options=$(getopt -o ds:Q:S:e:hcp -l debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,credential,persistent -- "$@")
 eval set -- "$options"

 while true ; do
@@ -373,12 +373,10 @@ while true ; do
         exit 1
         ;;
     -c|--credential)
-        shift
-        CREDENTIAL="$1"
+        CREDENTIAL="yes"
         ;;
     -p|--persistent)
-        shift
-        PERSISTENT="$1"
+        PERSISTENT="yes"
         ;;
     *)
         break
--
2.21.0
