Received: from eggs.gnu.org ([2001:4830:134:3::10]:56435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=568286362=ross.lagerwall@citrix.com>)
	id 1ej69E-0008V8-JL
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 11:31:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=568286362=ross.lagerwall@citrix.com>)
	id 1ej69C-0007mB-0H
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 11:31:08 -0500
Received: from smtp.citrix.com ([66.165.176.89]:54381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=568286362=ross.lagerwall@citrix.com>)
	id 1ej69B-0007jy-PE
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 11:31:05 -0500
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Date: Tue, 6 Feb 2018 16:30:39 +0000
Message-ID: <20180206163039.23661-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] migration/xen: Check return value of
 qemu_fclose
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>

QEMUFile uses buffered IO so when writing small amounts (such as the Xen
device state file), the actual write call and any errors that may occur
only happen as part of qemu_fclose(). Therefore, report IO errors when
saving the device state under Xen by checking the return value of
qemu_fclose().

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---
 migration/savevm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index b7908f6..4b9d5be 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2267,8 +2267,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
     qio_channel_set_name(QIO_CHANNEL(ioc), "migration-xen-save-state");
     f = qemu_fopen_channel_output(QIO_CHANNEL(ioc));
     ret = qemu_save_device_state(f);
-    qemu_fclose(f);
-    if (ret < 0) {
+    if (ret < 0 || qemu_fclose(f) < 0) {
         error_setg(errp, QERR_IO_ERROR);
     } else {
         /* libxl calls the QMP command "stop" before calling
-- 
2.9.5
