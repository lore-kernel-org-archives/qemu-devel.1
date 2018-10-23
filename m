Received: from eggs.gnu.org ([2001:4830:134:3::10]:42808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gEumk-0001qp-JH
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gEumf-0007gt-I2
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1gEumb-0007Yz-St
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id d10-v6so1269440wrs.5
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 04:23:30 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Tue, 23 Oct 2018 13:23:12 +0200
Message-Id: <0c23b5d49b0f355197b94eaf8685ccca2b46eb06.1540293795.git.tgolembi@redhat.com>
In-Reply-To: <cover.1540293795.git.tgolembi@redhat.com>
References: <cover.1540293795.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 03/14] qga: linux: return disk device in
 guest-get-fsinfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Sameeh Jubran <sjubran@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Olga Krishtal <okrishtal@virtuozzo.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

Report device node of the disk on Linux (e.g. "/dev/sda2").
Requirs libudev.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 qga/commands-posix.c | 7 ++++++-
 qga/qapi-schema.json | 3 ++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index d08719ba68..0c04937a13 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -950,7 +950,12 @@ static void build_guest_fsinfo_for_real_device(char const *syspath,
     if (udev == NULL || udevice == NULL) {
         g_debug("failed to query udev");
     } else {
-        const char *serial;
+        const char *devnode, *serial;
+        devnode = udev_device_get_devnode(udevice);
+        if (devnode != NULL) {
+            disk->dev = g_strdup(devnode);
+            disk->has_dev = true;
+        }
         serial = udev_device_get_property_value(udevice, "ID_SERIAL");
         if (serial != NULL && *serial != 0) {
             disk->serial = g_strdup(serial);
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 3bcda6257e..c6725b3ec8 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -835,6 +835,7 @@
 # @target: target id
 # @unit: unit id
 # @serial: serial number (since: 3.1)
+# @dev: device node (POSIX) or device UNC (Windows) (since: 3.1)
 #
 # Since: 2.2
 ##
@@ -842,7 +843,7 @@
   'data': {'pci-controller': 'GuestPCIAddress',
            'bus-type': 'GuestDiskBusType',
            'bus': 'int', 'target': 'int', 'unit': 'int',
-           '*serial': 'str'} }
+           '*serial': 'str', '*dev': 'str'} }
 
 ##
 # @GuestFilesystemInfo:
-- 
2.19.0
