Received: from eggs.gnu.org ([2001:4830:134:3::10]:57309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cZwCF-0002Rj-1D
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 03:59:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cZwCB-0006EK-UE
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 03:59:51 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:36780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cZwCB-0006DV-On
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 03:59:47 -0500
Received: by mail-pg0-x244.google.com with SMTP id 75so4096696pgf.3
	for <qemu-devel@nongnu.org>; Sat, 04 Feb 2017 00:59:47 -0800 (PST)
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Sat,  4 Feb 2017 14:29:44 +0530
Message-Id: <1486198784-31523-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v2] migrate: Introduce a 'dc->vmsd' check to
 avoid segfault for --only-migratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com
Cc: quintela@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, Ashijeet Acharya <ashijeetacharya@gmail.com>

Commit a3a3d8c7 introduced a segfault bug while checking for
'dc->vmsd->unmigratable' which caused QEMU to crash when trying to add
devices which do no set their 'dc->vmsd' yet while initialization.
Place a 'dc->vmsd' check prior to it so that we do not segfault for
such devices.

NOTE: This doesn't compromise the functioning of --only-migratable
option as all the unmigratable devices do set their 'dc->vmsd'.

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
Changes in v2:
- place dc->vmsd check in hw/usb/bus.c as well
---
 hw/usb/bus.c   | 2 +-
 qdev-monitor.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 1dcc35c..1e39b2c 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -731,7 +731,7 @@ USBDevice *usbdevice_create(const char *cmdline)
 
     dc = DEVICE_CLASS(klass);
 
-    if (only_migratable) {
+    if (only_migratable && dc->vmsd) {
         if (dc->vmsd->unmigratable) {
             error_report("Device %s is not migratable, but --only-migratable "
                          "was specified", f->name);
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 549f45f..b72e5a4 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -579,7 +579,7 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
         return NULL;
     }
 
-    if (only_migratable) {
+    if (only_migratable && dc->vmsd) {
         if (dc->vmsd->unmigratable) {
             error_setg(errp, "Device %s is not migratable, but "
                        "--only-migratable was specified", driver);
-- 
2.6.2
