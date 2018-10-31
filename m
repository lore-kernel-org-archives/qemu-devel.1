Received: from eggs.gnu.org ([2001:4830:134:3::10]:33732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHrNS-0001X6-Nh
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHrNQ-0007cy-VK
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:21:46 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gHrNO-0007QA-RU
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:21:43 -0400
Received: by mail-ot1-x341.google.com with SMTP id k9so14659673otl.10
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 07:21:16 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 31 Oct 2018 09:19:07 -0500
Message-Id: <20181031141925.30026-7-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181031141925.30026-1-mdroth@linux.vnet.ibm.com>
References: <20181031141925.30026-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 06/24] qga: linux: return disk device in
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
Cc: peter.maydell@linaro.org, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

From: Tomáš Golembiovský <tgolembi@redhat.com>

Report device node of the disk on Linux (e.g. "/dev/sda2").
Requirs libudev.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-posix.c | 7 ++++++-
 qga/qapi-schema.json | 3 ++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 41bd11b2b5..1877976522 100644
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
2.17.1
