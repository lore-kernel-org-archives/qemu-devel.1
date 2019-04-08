Received: from eggs.gnu.org ([209.51.188.92]:32962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDXEu-00058E-Ue
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDXEu-00061M-2H
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:35:20 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  8 Apr 2019 18:34:39 +0200
Message-Id: <20190408163439.18818-3-kwolf@redhat.com>
In-Reply-To: <20190408163439.18818-1-kwolf@redhat.com>
References: <20190408163439.18818-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] hmp: Fix drive_add ... format=help crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Markus Armbruster <armbru@redhat.com>

drive_new() returns null without setting an error when it provided
help.  add_init_drive() assumes null means failure, and crashes trying
to report a null error.

Fixes: c4f26c9f37ce511e5fe629c21c180dc6eb7c5a25
Cc: qemu-stable@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 device-hotplug.c | 2 +-
 tests/test-hmp.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/device-hotplug.c b/device-hotplug.c
index 6090d5f1e9..6153259d71 100644
--- a/device-hotplug.c
+++ b/device-hotplug.c
@@ -48,7 +48,7 @@ static DriveInfo *add_init_drive(const char *optstr)
=20
     mc =3D MACHINE_GET_CLASS(current_machine);
     dinfo =3D drive_new(opts, mc->block_default_type, &err);
-    if (!dinfo) {
+    if (err) {
         error_report_err(err);
         qemu_opts_del(opts);
         return NULL;
diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index 8c49d2fdf1..54a01824dc 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -31,6 +31,7 @@ static const char *hmp_cmds[] =3D {
     "cpu 0",
     "device_add ?",
     "device_add usb-mouse,id=3Dmouse1",
+    "drive_add ignored format=3Dhelp",
     "mouse_button 7",
     "mouse_move 10 10",
     "mouse_button 0",
--=20
2.20.1
