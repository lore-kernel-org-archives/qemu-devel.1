Received: from eggs.gnu.org ([209.51.188.92]:38448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gn5Zd-0002W7-EY
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 12:47:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gn5Zc-0006qA-Fm
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 12:47:25 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 25 Jan 2019 18:46:53 +0100
Message-Id: <20190125174653.4604-4-kwolf@redhat.com>
In-Reply-To: <20190125174653.4604-1-kwolf@redhat.com>
References: <20190125174653.4604-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] scsi-disk: Deprecate device_id fallback to
 BlockBackend name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, pbonzini@redhat.com, pkrempa@redhat.com, berrange@redhat.com, eblake@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org

We should never have exposed BlockBackend names to the guest, it's a
host detail. Deprecate this behaviour. Users who need to maintain the
guest ABI can explicitly set the value with the device_id property.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/scsi/scsi-disk.c  |  5 +++++
 qemu-deprecated.texi | 22 +++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index e74e1e7c48..38f1fe2570 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2366,6 +2366,11 @@ static void scsi_realize(SCSIDevice *dev, Error **=
errp)
             const char *str =3D blk_name(s->qdev.conf.blk);
             if (str && *str) {
                 s->device_id =3D g_strdup(str);
+                warn_report("Using the backend drive ID for the Device "
+                            "Identification VPD page is deprecated. "
+                            "Please specify the serial or device_id opti=
ons "
+                            "explicitly to avoid guest-visible changes i=
n "
+                            "future QEMU versions.");
             }
         }
     }
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 219206a836..a426d8245d 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -146,7 +146,7 @@ This machine type uses an unmaintained firmware, brok=
en in lots of ways,
 and unable to start post-2004 operating systems. 40p machine type should=
 be
 used instead.
=20
-@section Device options
+@section Devices
=20
 @subsection Block device options
=20
@@ -170,6 +170,26 @@ The above, converted to the current supported format=
:
=20
 @code{json:@{"file.driver":"rbd", "file.pool":"rbd", "file.image":"name"=
@}}
=20
+@subsection scsi-disk device identification (since 4.0.0)
+
+The Device Identification VPD page of ``scsi-disk'' devices contains a v=
endor
+specific designator that can be explicitly specified using the ``device_=
id''
+property since 4.0.0.
+
+If ``device_id'' is not given, the implementation falls back to reusing =
any
+specified serial number for this field. If the serial number is not give=
n
+either and ``drive=3DX'' was used where ``X'' is a drive ID, this drive =
ID is
+given to the guest instead. This is backend information that should not
+to be exposed to guests.
+
+Therefore, this behaviour is deprecated and future versions will change =
the
+guest-visible behaviour (e.g. by leaving out the vendor specific designa=
tor)
+for the case that neither ``device_id'' nor a serial number are given, b=
ut a
+drive ID is used to create the device.
+
+If you need the guest-visible information to stay unchanged, add an expl=
icit
+``device_id'' option to your QEMU invocation.
+
 @subsection vio-spapr-device device options
=20
 @subsubsection "irq": "" (since 3.0.0)
--=20
2.20.1
