Received: from eggs.gnu.org ([209.51.188.92]:35260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goXdq-0003l6-72
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 12:57:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goXdo-0001ny-Q7
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 12:57:46 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 29 Jan 2019 18:53:55 +0100
Message-Id: <20190129175403.18017-11-philmd@redhat.com>
In-Reply-To: <20190129175403.18017-1-philmd@redhat.com>
References: <20190129175403.18017-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 10/18] qemu-iotests: Ensure GNU sed is
 used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

Various sed regexp from common.filter use sed GNU extensions.
Instead of spending time to write these regex to be POSIX compliant,
verify the GNU sed is available and use it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
I think the test isn't well placed in common.filter and should be in
common.rc, but couldn't get that working.
---
 tests/qemu-iotests/common.filter | 36 ++++++++++++++++----------------
 tests/qemu-iotests/common.rc     | 12 +++++++++++
 2 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common=
.filter
index 17eb3402a7..47a5ed77ee 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -23,37 +23,37 @@
 #
 _filter_date()
 {
-    sed \
+    ${SED} \
         -e 's/[A-Z][a-z][a-z] [A-z][a-z][a-z]  *[0-9][0-9]* [0-9][0-9]:[=
0-9][0-9]:[0-9][0-9] [0-9][0-9][0-9][0-9]$/DATE/'
 }
=20
 _filter_generated_node_ids()
 {
-     sed -re 's/\#block[0-9]{3,}/NODE_NAME/'
+    ${SED} -re 's/\#block[0-9]{3,}/NODE_NAME/'
 }
=20
 _filter_qom_path()
 {
-    sed -e 's#\(Attached to: *\) /.*#\1 PATH#'
+    ${SED} -e 's#\(Attached to: *\) /.*#\1 PATH#'
 }
=20
 # replace occurrences of the actual TEST_DIR value with TEST_DIR
 _filter_testdir()
 {
-    sed -e "s#$TEST_DIR/#TEST_DIR/#g"
+    ${SED} -e "s#$TEST_DIR/#TEST_DIR/#g"
 }
=20
 # replace occurrences of the actual IMGFMT value with IMGFMT
 _filter_imgfmt()
 {
-    sed -e "s#$IMGFMT#IMGFMT#g"
+    ${SED} -e "s#$IMGFMT#IMGFMT#g"
 }
=20
 # Replace error message when the format is not supported and delete
 # the output lines after the first one
 _filter_qemu_img_check()
 {
-    sed -e '/allocated.*fragmented.*compressed clusters/d' \
+    ${SED} -e '/allocated.*fragmented.*compressed clusters/d' \
         -e 's/qemu-img: This image format does not support checks/No err=
ors were found on the image./' \
         -e '/Image end offset: [0-9]\+/d'
 }
@@ -61,13 +61,13 @@ _filter_qemu_img_check()
 # Removes \r from messages
 _filter_win32()
 {
-    sed -e 's/\r//g'
+    ${SED} -e 's/\r//g'
 }
=20
 # sanitize qemu-io output
 _filter_qemu_io()
 {
-    _filter_win32 | sed -e "s/[0-9]* ops\; [0-9/:. sec]* ([0-9/.inf]* [E=
PTGMKiBbytes]*\/sec and [0-9/.inf]* ops\/sec)/X ops\; XX:XX:XX.X (XXX YYY=
\/sec and XXX ops\/sec)/" \
+    _filter_win32 | ${SED} -e "s/[0-9]* ops\; [0-9/:. sec]* ([0-9/.inf]*=
 [EPTGMKiBbytes]*\/sec and [0-9/.inf]* ops\/sec)/X ops\; XX:XX:XX.X (XXX =
YYY\/sec and XXX ops\/sec)/" \
         -e "s/: line [0-9][0-9]*:  *[0-9][0-9]*\( Aborted\| Killed\)/:\1=
/" \
         -e "s/qemu-io> //g"
 }
@@ -75,7 +75,7 @@ _filter_qemu_io()
 # replace occurrences of QEMU_PROG with "qemu"
 _filter_qemu()
 {
-    sed -e "s#\\(^\\|(qemu) \\)$(basename $QEMU_PROG):#\1QEMU_PROG:#" \
+    ${SED} -e "s#\\(^\\|(qemu) \\)$(basename $QEMU_PROG):#\1QEMU_PROG:#"=
 \
         -e 's#^QEMU [0-9]\+\.[0-9]\+\.[0-9]\+ monitor#QEMU X.Y.Z monitor=
#' \
         -e $'s#\r##' # QEMU monitor uses \r\n line endings
 }
@@ -84,7 +84,7 @@ _filter_qemu()
 _filter_qmp()
 {
     _filter_win32 | \
-    sed -e 's#\("\(micro\)\?seconds": \)[0-9]\+#\1 TIMESTAMP#g' \
+    ${SED} -e 's#\("\(micro\)\?seconds": \)[0-9]\+#\1 TIMESTAMP#g' \
         -e 's#^{"QMP":.*}$#QMP_VERSION#' \
         -e '/^    "QMP": {\s*$/, /^    }\s*$/ c\' \
         -e '    QMP_VERSION'
@@ -93,32 +93,32 @@ _filter_qmp()
 # readline makes HMP command strings so long that git complains
 _filter_hmp()
 {
-    sed -e $'s/^\\((qemu) \\)\\?.*\e\\[D/\\1/g' \
+    ${SED} -e $'s/^\\((qemu) \\)\\?.*\e\\[D/\\1/g' \
         -e $'s/\e\\[K//g'
 }
=20
 # replace block job offset
 _filter_block_job_offset()
 {
-    sed -e 's/, "offset": [0-9]\+,/, "offset": OFFSET,/'
+    ${SED} -e 's/, "offset": [0-9]\+,/, "offset": OFFSET,/'
 }
=20
 # replace block job len
 _filter_block_job_len()
 {
-    sed -e 's/, "len": [0-9]\+,/, "len": LEN,/g'
+    ${SED} -e 's/, "len": [0-9]\+,/, "len": LEN,/g'
 }
=20
 # replace actual image size (depends on the host filesystem)
 _filter_actual_image_size()
 {
-    sed -s 's/\("actual-size":\s*\)[0-9]\+/\1SIZE/g'
+    ${SED} -s 's/\("actual-size":\s*\)[0-9]\+/\1SIZE/g'
 }
=20
 # replace driver-specific options in the "Formatting..." line
 _filter_img_create()
 {
-    sed -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
+    ${SED} -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
         -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
         -e "s#$TEST_DIR#TEST_DIR#g" \
         -e "s#$IMGFMT#IMGFMT#g" \
@@ -154,7 +154,7 @@ _filter_img_info()
=20
     discard=3D0
     regex_json_spec_start=3D'^ *"format-specific": \{'
-    sed -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
+    ${SED} -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
         -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
         -e "s#$TEST_DIR#TEST_DIR#g" \
         -e "s#$IMGFMT#IMGFMT#g" \
@@ -200,7 +200,7 @@ _filter_img_info()
 # human and json output
 _filter_qemu_img_map()
 {
-    sed -e 's/\([0-9a-fx]* *[0-9a-fx]* *\)[0-9a-fx]* */\1/g' \
+    ${SED} -e 's/\([0-9a-fx]* *[0-9a-fx]* *\)[0-9a-fx]* */\1/g' \
         -e 's/"offset": [0-9]\+/"offset": OFFSET/g' \
         -e 's/Mapped to *//' | _filter_testdir | _filter_imgfmt
 }
@@ -212,7 +212,7 @@ _filter_nbd()
     # receive callbacks sometimes, making them unreliable.
     #
     # Filter out the TCP port number since this changes between runs.
-    sed -e '/nbd\/.*\.c:/d' \
+    ${SED} -e '/nbd\/.*\.c:/d' \
         -e 's#127\.0\.0\.1:[0-9]*#127.0.0.1:PORT#g' \
         -e "s#?socket=3D$TEST_DIR#?socket=3DTEST_DIR#g" \
         -e 's#\(foo\|PORT/\?\|.sock\): Failed to .*$#\1#'
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 0c4f0a5987..9eb94d73d5 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -17,6 +17,18 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
=20
+for sed in sed gsed; do
+    (command $sed --version | grep 'GNU sed') > /dev/null 2>&1
+    if [ "$?" -eq 0 ]; then
+        SED=3D$sed
+        break
+    fi
+done
+if [ -z "$SED" ]; then
+    echo "$0: GNU sed not found"
+    exit 1
+fi
+
 dd()
 {
    if [ "$HOSTOS" =3D=3D "Linux" ]
--=20
2.20.1
