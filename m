Received: from eggs.gnu.org ([2001:4830:134:3::10]:58685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cWlgd-0006io-FG
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 10:10:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cWlgZ-0004vK-FA
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 10:10:07 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 26 Jan 2017 16:09:48 +0100
Message-Id: <1485443388-27253-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1485443388-27253-1-git-send-email-armbru@redhat.com>
References: <1485443388-27253-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 8/8] hw: Drop superfluous special checks for
 orphaned -drive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

We've traditionally rejected orphans here and there, but not
systematically.  For instance, the sun4m machines have an onboard SCSI
HBA (bus=3D0), and have always rejected bus>0.  Other machines with an
onboard SCSI HBA don't.

Commit a66c9dc made all orphans trigger a warning, and the previous
commit turned this into an error.  The checks "here and there" are now
redundant.  Drop them.

Note that the one in mips_jazz.c was wrong: it rejected bus > MAX_FD,
but MAX_FD is the number of floppy drives per bus.

Error messages change from

    $ qemu-system-x86_64 -drive if=3Dide,bus=3D2
    qemu-system-x86_64: Too many IDE buses defined (3 > 2)
    $ qemu-system-mips64 -M magnum,accel=3Dqtest -drive if=3Dfloppy,bus=3D=
2,id=3Dfd1
    qemu: too many floppy drives
    $ qemu-system-sparc -M LX -drive if=3Dscsi,bus=3D1
    qemu: too many SCSI bus

to

    $ qemu-system-x86_64 -drive if=3Dide,bus=3D2
    qemu-system-x86_64: -drive if=3Dide,bus=3D2: machine type does not su=
pport this drive
    $ qemu-system-mips64 -M magnum,accel=3Dqtest -drive if=3Dfloppy,bus=3D=
2,id=3Dfd1
    qemu-system-mips64: -drive if=3Dfloppy,bus=3D2,id=3Dfd1: machine type=
 does not support this drive
    $ qemu-system-sparc -M LX -drive if=3Dscsi,bus=3D1
    qemu-system-sparc: -drive if=3Dscsi,bus=3D1: machine type does not su=
pport this drive

Cc: John Snow <jsnow@redhat.com>
Cc: "Herv=C3=A9 Poussineau" <hpoussin@reactos.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/ide/core.c       | 17 -----------------
 hw/mips/mips_jazz.c |  4 ----
 hw/sparc/sun4m.c    |  5 -----
 3 files changed, 26 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 43709e5..cfa5de6 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2840,23 +2840,6 @@ const VMStateDescription vmstate_ide_bus =3D {
 void ide_drive_get(DriveInfo **hd, int n)
 {
     int i;
-    int highest_bus =3D drive_get_max_bus(IF_IDE) + 1;
-    int max_devs =3D drive_get_max_devs(IF_IDE);
-    int n_buses =3D max_devs ? (n / max_devs) : n;
-
-    /*
-     * Note: The number of actual buses available is not known.
-     * We compute this based on the size of the DriveInfo* array, n.
-     * If it is less than max_devs * <num_real_buses>,
-     * We will stop looking for drives prematurely instead of overfillin=
g
-     * the array.
-     */
-
-    if (highest_bus > n_buses) {
-        error_report("Too many IDE buses defined (%d > %d)",
-                     highest_bus, n_buses);
-        exit(1);
-    }
=20
     for (i =3D 0; i < n; i++) {
         hd[i] =3D drive_get_by_index(IF_IDE, i);
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 73f6c9f..1cef581 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -291,10 +291,6 @@ static void mips_jazz_init(MachineState *machine,
              qdev_get_gpio_in(rc4030, 5), &esp_reset, &dma_enable);
=20
     /* Floppy */
-    if (drive_get_max_bus(IF_FLOPPY) >=3D MAX_FD) {
-        fprintf(stderr, "qemu: too many floppy drives\n");
-        exit(1);
-    }
     for (n =3D 0; n < MAX_FD; n++) {
         fds[n] =3D drive_get(IF_FLOPPY, 0, n);
     }
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index f5b6efd..61416a6 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -989,11 +989,6 @@ static void sun4m_hw_init(const struct sun4m_hwdef *=
hwdef,
     slavio_misc_init(hwdef->slavio_base, hwdef->aux1_base, hwdef->aux2_b=
ase,
                      slavio_irq[30], fdc_tc);
=20
-    if (drive_get_max_bus(IF_SCSI) > 0) {
-        fprintf(stderr, "qemu: too many SCSI bus\n");
-        exit(1);
-    }
-
     esp_init(hwdef->esp_base, 2,
              espdma_memory_read, espdma_memory_write,
              espdma, espdma_irq, &esp_reset, &dma_enable);
--=20
2.7.4
