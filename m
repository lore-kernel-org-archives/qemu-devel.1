Received: from eggs.gnu.org ([209.51.188.92]:37244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h1OY8-000235-Kg
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 23:53:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h1OY7-0005Xy-Hr
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 23:53:00 -0500
Received: from smtp.lg.ehu.es ([158.227.0.66]:27791 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h1OY4-0005U7-Gk
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 23:52:59 -0500
Date: Wed, 6 Mar 2019 04:52:52 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
Message-ID: <20190306045252.GG75@03612eec87fc>
References: <20190306031221.GA53@03612eec87fc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306031221.GA53@03612eec87fc>
Subject: [Qemu-devel] [PATCH v3 7/10] qemu-binfmt-conf.sh: add option
 --reset <ARCHS>
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

This is a partial implementation.

Allows to remove a single or a list of already registered binfmt
interpreters. If <ARCHS> is a list, it must be comma-separated.
Valid values are those in qemu_target_list. If <ARCHS> is 'ALL', all
the existing 'qemu-*' interpreters are removed.

This is partial because 'debian' and 'systemd' configurations are not
removed. If option 'reset' is provided before any of those, reset is
executed first and the configuration proceeds. However, if 'reset' is
provided after any of them, the script will exit with error 'option
reset not implemented for this mode yet'.

Removal is done by printing '-1' as explained at:
https://www.kernel.org/doc/Documentation/admin-guide/binfmt-misc.rst

Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
---
 scripts/qemu-binfmt-conf.sh | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 2751363089..824e3c4c34 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -197,8 +197,8 @@ qemu_get_family() {

 usage() {
     cat <<EOF
-Usage: qemu-binfmt-conf.sh [--path PATH][--debian][--systemd]
-                           [--help][--credential][--exportdir PATH]
+Usage: qemu-binfmt-conf.sh [--help][--path PATH][--debian][--systemd]
+                           [--reset ARCHS][--credential][--exportdir PATH]
                            [--persistent][--suffix SUFFIX][CPUS]

        Configure binfmt_misc to use qemu interpreter for the given CPUS.
@@ -219,6 +219,9 @@ Usage: qemu-binfmt-conf.sh [--path PATH][--debian][--systemd]
                       architecture than the current one.
        --exportdir:   define where to write configuration files
                       (default: $SYSTEMDDIR or $DEBIANDIR)
+       --reset:       remove registered interpreter for target ARCHS (comma
+                      separated list). If ARCHS is 'ALL', remove all registered
+                      'qemu-*' interpreters.
        --credential:  if present, credential and security tokens are
                       calculated according to the binary to interpret
                       ($QEMU_CREDENTIAL=yes)
@@ -353,8 +356,28 @@ qemu_set_binfmts() {
     done
 }

+qemu_remove_notimplemented() {
+    echo "ERROR: option reset not implemented for this mode yet" 1>&2
+    usage
+    exit 1
+}
+
+qemu_remove_interpreter() {
+    names='qemu-*'
+    if [ "x$1" != "xALL" ] ; then
+        qemu_check_target_list $1
+        unset names pre
+        for t in $checked_target_list ; do
+            names="${names}${pre}qemu-$t"
+            pre=' -o -name '
+        done
+    fi
+    find /proc/sys/fs/binfmt_misc/ -type f -name $names -exec sh -c 'printf %s -1 > {}' \;
+}
+
 CHECK=qemu_check_bintfmt_misc
 BINFMT_SET=qemu_register_interpreter
+BINFMT_REMOVE=qemu_remove_interpreter

 SYSTEMDDIR="/etc/binfmt.d"
 DEBIANDIR="/usr/share/binfmts"
@@ -364,19 +387,26 @@ QEMU_SUFFIX="${QEMU_SUFFIX:-}"
 QEMU_CREDENTIAL="${QEMU_CREDENTIAL:-no}"
 QEMU_PERSISTENT="${QEMU_PERSISTENT:-no}"

-options=$(getopt -o :dsQ:S:e:hcp -l debian,systemd,path:,suffix:,exportdir:,help,credential,persistent -- "$@")
+options=$(getopt -o r:dsQ:S:e:hcp -l reset:,debian,systemd,path:,suffix:,exportdir:,help,credential,persistent -- "$@")
 eval set -- "$options"

 while true ; do
     case "$1" in
+    -r|--reset)
+        shift
+        $CHECK
+        qemu_remove_interpreter $1
+        ;;
     -d|--debian)
         CHECK=qemu_check_debian
         BINFMT_SET=qemu_generate_debian
+        BINFMT_REMOVE=qemu_remove_notimplemented
         EXPORTDIR=${EXPORTDIR:-$DEBIANDIR}
         ;;
     -s|--systemd)
         CHECK=qemu_check_systemd
         BINFMT_SET=qemu_generate_systemd
+        BINFMT_REMOVE=qemu_remove_notimplemented
         EXPORTDIR=${EXPORTDIR:-$SYSTEMDDIR}
         ;;
     -Q|--path)
--
2.20.1
