Received: from eggs.gnu.org ([2001:4830:134:3::10]:53930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elzA3-0008Ia-Fg
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:39:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elzA0-00075a-8L
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:39:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40564 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1elz9z-00074X-VL
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:39:52 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 14 Feb 2018 15:39:29 +0000
Message-Id: <20180214153938.5410-2-dgilbert@redhat.com>
In-Reply-To: <20180214153938.5410-1-dgilbert@redhat.com>
References: <20180214153938.5410-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 01/10] migration/xen: Check return value of
 qemu_fclose
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, groug@kaod.org, ross.lagerwall@citrix.com

From: Ross Lagerwall <ross.lagerwall@citrix.com>

QEMUFile uses buffered IO so when writing small amounts (such as the Xen
device state file), the actual write call and any errors that may occur
only happen as part of qemu_fclose(). Therefore, report IO errors when
saving the device state under Xen by checking the return value of
qemu_fclose().

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Message-Id: <20180206163039.23661-1-ross.lagerwall@citrix.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/savevm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 3f611c02e8..68b652ff76 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2284,8 +2284,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
     f = qemu_fopen_channel_output(QIO_CHANNEL(ioc));
     object_unref(OBJECT(ioc));
     ret = qemu_save_device_state(f);
-    qemu_fclose(f);
-    if (ret < 0) {
+    if (ret < 0 || qemu_fclose(f) < 0) {
         error_setg(errp, QERR_IO_ERROR);
     } else {
         /* libxl calls the QMP command "stop" before calling
-- 
2.14.3
