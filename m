Received: from eggs.gnu.org ([209.51.188.92]:34985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gogP3-0005IY-NQ
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:19:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gogP1-0006kA-Ox
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:19:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gogOy-0006iu-1a
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:19:01 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 30 Jan 2019 11:18:14 +0800
Message-Id: <20190130031817.27780-4-stefanha@redhat.com>
In-Reply-To: <20190130031817.27780-1-stefanha@redhat.com>
References: <20190130031817.27780-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/6] trace: forbid use of %m in trace event
 format strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

The '%m' format instructs glibc's printf()/syslog() implementation to
insert the contents of strerror(errno). Since this is a glibc extension
it should generally be avoided in QEMU due to need for portability to a
variety of platforms.

Even though vfio is Linux-only code that could otherwise use "%m", it
must still be avoided in trace-events files because several of the
backends do not use the format string and so this error information is
invisible to them.

The errno string value should be given as an explicit trace argument
instead, making it accessible to all backends. This also allows it to
work correctly with future patches that use the format string with
systemtap's simple printf code.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 20190123120016.4538-4-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/vfio/pci.c                 | 2 +-
 hw/vfio/trace-events          | 2 +-
 scripts/tracetool/__init__.py | 4 ++++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c0cb1ec289..dd12f36391 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2581,7 +2581,7 @@ static void vfio_populate_device(VFIOPCIDevice *vde=
v, Error **errp)
     ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info=
);
     if (ret) {
         /* This can fail for an old kernel or legacy PCI dev */
-        trace_vfio_populate_device_get_irq_info_failure();
+        trace_vfio_populate_device_get_irq_info_failure(strerror(errno))=
;
     } else if (irq_info.count =3D=3D 1) {
         vdev->pci_aer =3D true;
     } else {
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index a85e8662ea..f41ca96160 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -37,7 +37,7 @@ vfio_pci_hot_reset_has_dep_devices(const char *name) "%=
s: hot reset dependent de
 vfio_pci_hot_reset_dep_devices(int domain, int bus, int slot, int functi=
on, int group_id) "\t%04x:%02x:%02x.%x group %d"
 vfio_pci_hot_reset_result(const char *name, const char *result) "%s hot =
reset: %s"
 vfio_populate_device_config(const char *name, unsigned long size, unsign=
ed long offset, unsigned long flags) "Device %s config:\n  size: 0x%lx, o=
ffset: 0x%lx, flags: 0x%lx"
-vfio_populate_device_get_irq_info_failure(void) "VFIO_DEVICE_GET_IRQ_INF=
O failure: %m"
+vfio_populate_device_get_irq_info_failure(const char *errstr) "VFIO_DEVI=
CE_GET_IRQ_INFO failure: %s"
 vfio_realize(const char *name, int group_id) " (%s) group %d"
 vfio_mdev(const char *name, bool is_mdev) " (%s) is_mdev %d"
 vfio_add_ext_cap_dropped(const char *name, uint16_t cap, uint16_t offset=
) "%s 0x%x@0x%x"
diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.p=
y
index 3478ac93ab..6fca674936 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -274,6 +274,10 @@ class Event(object):
         props =3D groups["props"].split()
         fmt =3D groups["fmt"]
         fmt_trans =3D groups["fmt_trans"]
+        if fmt.find("%m") !=3D -1 or fmt_trans.find("%m") !=3D -1:
+            raise ValueError("Event format '%m' is forbidden, pass the e=
rror "
+                             "as an explicit trace argument")
+
         if len(fmt_trans) > 0:
             fmt =3D [fmt_trans, fmt]
         args =3D Arguments.build(groups["args"])
--=20
2.20.1
