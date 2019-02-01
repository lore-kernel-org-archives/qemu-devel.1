Received: from eggs.gnu.org ([209.51.188.92]:39551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpboO-00085C-5L
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpboL-0000Iv-LL
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:37:03 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  1 Feb 2019 17:35:17 +0100
Message-Id: <20190201163518.31157-27-kwolf@redhat.com>
In-Reply-To: <20190201163518.31157-1-kwolf@redhat.com>
References: <20190201163518.31157-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 26/27] scsi-disk: Don't use empty string as
 device id
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

scsi-disk includes in the Device Identification VPD page, depending on
configuration amongst others, a vendor specific designator that consists
either of the serial number if given or the BlockBackend name (which is
a host detail that better shouldn't have been leaked to the guest, but
now we have to maintain it for compatibility).

With anonymous BlockBackends, i.e. scsi-disk devices constructed with
drive=3D<node-name>, and no serial number explicitly specified, this ends
up as an empty string. If this happens to more than one disk, we have
accidentally signalled to the OS that this is a multipath setup, which
is obviously not what was intended.

Instead of using an empty string for the vendor specific designator,
simply leave out that designator, which makes Linux detect such setups
as separate disks again.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/scsi/scsi-disk.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index b049026219..11392a8db8 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -652,12 +652,14 @@ static int scsi_disk_emulate_vpd_page(SCSIRequest *=
req, uint8_t *outbuf)
         DPRINTF("Inquiry EVPD[Device identification] "
                 "buffer size %zd\n", req->cmd.xfer);
=20
-        outbuf[buflen++] =3D 0x2; /* ASCII */
-        outbuf[buflen++] =3D 0;   /* not officially assigned */
-        outbuf[buflen++] =3D 0;   /* reserved */
-        outbuf[buflen++] =3D id_len; /* length of data following */
-        memcpy(outbuf + buflen, str, id_len);
-        buflen +=3D id_len;
+        if (id_len) {
+            outbuf[buflen++] =3D 0x2; /* ASCII */
+            outbuf[buflen++] =3D 0;   /* not officially assigned */
+            outbuf[buflen++] =3D 0;   /* reserved */
+            outbuf[buflen++] =3D id_len; /* length of data following */
+            memcpy(outbuf + buflen, str, id_len);
+            buflen +=3D id_len;
+        }
=20
         if (s->qdev.wwn) {
             outbuf[buflen++] =3D 0x1; /* Binary */
--=20
2.20.1
