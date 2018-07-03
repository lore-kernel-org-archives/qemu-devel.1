Received: from eggs.gnu.org ([2001:4830:134:3::10]:41336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1faSJ1-0008Qu-S1
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1faSIy-00010s-Lx
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1faSIy-00010C-Dv
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:44 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w63KnAuE013156
	for <qemu-devel@nongnu.org>; Tue, 3 Jul 2018 16:53:43 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k0dpd6jnp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 16:53:43 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 3 Jul 2018 14:53:42 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  3 Jul 2018 15:52:15 -0500
In-Reply-To: <20180703205221.24788-1-mdroth@linux.vnet.ibm.com>
References: <20180703205221.24788-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180703205221.24788-9-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/14] qemu-ga: make get-fsinfo work over pci
 bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Iterate over the PCI bridges to lookup the PCI device associated with
the block device.

This allows to lookup the driver under the following syspath:
/sys/devices/pci0000:00/0000:00:02.2/0000:03:00.0/virtio2/block/vda/vda3

It also works with an "old-style" Q35 libvirt hierarchy: root complex
-> DMI-PCI bridge -> PCI-PCI bridge -> virtio controller, ex:
/sys/devices/pci0000:00/0000:00:03.0/0000:01:01.0/0000:02:01.0/virtio1/bl=
ock/vda/vda3

The setup can be reproduced with the following qemu command line
(Thanks Marcel for help):

qemu-system-x86_64 -M q35 \
  -device i82801b11-bridge,id=3Ddmi2pci_bridge,bus=3Dpcie.0
  -device pci-bridge,id=3Dpci_bridge,bus=3Ddmi2pci_bridge,addr=3D0x1,chas=
sis_nr=3D1
  -device virtio-blk-pci,scsi=3Doff,drive=3Ddrive-virtio-disk0,id=3Dvirti=
o-disk0,bootindex=3D1,bus=3Dpci_bridge,addr=3D0x1

For consistency with other syspath-related debug messages, replace a
\"%s\" in the message with '%s'.

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1567041

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-posix.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index ae8535e497..7b7c78d85a 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -876,13 +876,28 @@ static void build_guest_fsinfo_for_real_device(char=
 const *syspath,
     p =3D strstr(syspath, "/devices/pci");
     if (!p || sscanf(p + 12, "%*x:%*x/%x:%x:%x.%x%n",
                      pci, pci + 1, pci + 2, pci + 3, &pcilen) < 4) {
-        g_debug("only pci device is supported: sysfs path \"%s\"", syspa=
th);
+        g_debug("only pci device is supported: sysfs path '%s'", syspath=
);
         return;
     }
=20
-    driver =3D get_pci_driver(syspath, (p + 12 + pcilen) - syspath, errp=
);
-    if (!driver) {
-        goto cleanup;
+    p +=3D 12 + pcilen;
+    while (true) {
+        driver =3D get_pci_driver(syspath, p - syspath, errp);
+        if (driver && (g_str_equal(driver, "ata_piix") ||
+                       g_str_equal(driver, "sym53c8xx") ||
+                       g_str_equal(driver, "virtio-pci") ||
+                       g_str_equal(driver, "ahci"))) {
+            break;
+        }
+
+        if (sscanf(p, "/%x:%x:%x.%x%n",
+                          pci, pci + 1, pci + 2, pci + 3, &pcilen) =3D=3D=
 4) {
+            p +=3D pcilen;
+            continue;
+        }
+
+        g_debug("unsupported driver or sysfs path '%s'", syspath);
+        return;
     }
=20
     p =3D strstr(syspath, "/target");
--=20
2.11.0
