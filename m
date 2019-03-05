Received: from eggs.gnu.org ([209.51.188.92]:49182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1CwI-0006nY-LJ
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:29:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1CwH-0002kK-Jv
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:29:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1CwH-0002jT-Ce
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:29:09 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue,  5 Mar 2019 17:28:28 +0100
Message-Id: <20190305162829.20079-5-philmd@redhat.com>
In-Reply-To: <20190305162829.20079-1-philmd@redhat.com>
References: <20190305162829.20079-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/5] hw/mips/malta: Only accept 'monitor'
 pflash of 4MiB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

The Malta 'mother' board can use various 'daughter' core cards [1].
QEMU only models the CoreLV card.

The CoreLV card provides [2] a Galileo GT64120 as North bridge,
connecting the CPU via the 'CBUS'. The CBUS also connects a 'Monitor
flash' memory and maps it to the CPU RESET vector.
The Monitor flash size is exactly 4 MiB.
Refuse Monitor pflash of different size.

[1] https://www.linux-mips.org/wiki/MIPS_Malta#Core_cards
[2] "Malta User's Manual"  rev. 01.05 (MIPS Technologies doc number: MD00=
048)

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/mips/mips_malta.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 396645b1a9..04788ff50a 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1267,6 +1267,11 @@ void mips_malta_init(MachineState *machine)
     dinfo =3D drive_get(IF_PFLASH, 0, fl_idx);
     if (dinfo) {
         pflash_blk =3D blk_by_legacy_dinfo(dinfo);
+
+        if (blk_getlength(pflash_blk) !=3D FLASH_SIZE) {
+                error_report("Malta CoreLV card expects a bios of 4MB");
+                exit(1);
+        }
 #ifdef DEBUG_BOARD_INIT
         printf("Register parallel flash %d size " TARGET_FMT_lx " at "
                "addr %08llx '%s'\n",
--=20
2.20.1
