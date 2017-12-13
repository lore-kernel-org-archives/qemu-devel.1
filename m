Received: from eggs.gnu.org ([2001:4830:134:3::10]:59758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGKc-0004bF-Hz
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:20:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGKX-00062B-9o
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:20:54 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 20:19:59 -0300
Message-Id: <20171213232025.24503-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/26] SDCard housekeeping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Prasad J Pandit <pjp@fedoraproject.org>, Clement Deschamps <clement.deschamps@antfield.fr>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, Isaac Lozano <109lozanoi@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Now that we have a way to write qtest in Python, lets start with a simple test
to perform basic card identification, covering many functions of the sd/sd.c
file.

[patch 1]
When a device is not MMIO-connected but rather plugged into a Bus, it is easier
to write tests using QMP.
So we add a 'sdbus-command' entry to directly operate on a SD Bus.
(Note this method should also work with all other QBus).

[patch 2]
We write a simple pyqtest, which
  - resolve the SDBus QOM path in the test setup()
  - verify default values for SD Spec v2.

Since have a test, lets run after each patch, so we are sure we don't break things.

[patch 4-14,20-23]
Add a bunch of trace events
[patch 3,11,15-18]
Aesthetic changes mostly
[other patches]
Trivial changes

Once this series applied, booting some Linux on a vexpress-a9 with few
sd*command traces enabled result in this outputs (which result useful to
understand/fix the different SD implementations):

48.687227:sdcard_normal_command         IO_RW_DIRECT/ CMD52 arg 0x00000c00 (state idle)
48.687233:sdcard_command_response (no response) (state idle)
48.689237:sdcard_normal_command         IO_RW_DIRECT/ CMD52 arg 0x80000c08 (state idle)
48.689244:sdcard_command_response (no response) (state idle)
48.690877:sdcard_normal_command        GO_IDLE_STATE/ CMD00 arg 0x00000000 (state idle)
48.690890:sdcard_command_response (no response) (state idle)
48.723486:sdcard_normal_command         SEND_IF_COND/ CMD08 arg 0x000001aa (state idle)
48.723507:sdcard_command_response 00 00 01 aa  (state idle)
48.723886:sdcard_normal_command      IO_SEND_OP_COND/ CMD05 arg 0x00000000 (state idle)
48.723892:sdcard_command_response (no response) (state idle)
48.724019:sdcard_normal_command      IO_SEND_OP_COND/ CMD05 arg 0x00000000 (state idle)
48.724023:sdcard_command_response (no response) (state idle)
48.724110:sdcard_normal_command      IO_SEND_OP_COND/ CMD05 arg 0x00000000 (state idle)
48.724115:sdcard_command_response (no response) (state idle)
48.724178:sdcard_normal_command      IO_SEND_OP_COND/ CMD05 arg 0x00000000 (state idle)
48.724181:sdcard_command_response (no response) (state idle)
48.724999:sdcard_command_response 00 40 01 20  (state idle)
48.725214:sdcard_app_command         SD_SEND_OP_COND/ACMD41 arg 0x00000000 (state idle)
48.725225:sdcard_command_response 40 ff ff 00  (state idle)
48.727113:sdcard_normal_command        GO_IDLE_STATE/ CMD00 arg 0x00000000 (state idle)
48.727125:sdcard_command_response (no response) (state idle)
48.729206:sdcard_normal_command         SEND_IF_COND/ CMD08 arg 0x000001aa (state idle)
48.729213:sdcard_command_response 00 00 01 aa  (state idle)
48.729339:sdcard_command_response 00 00 01 20  (state idle)
48.729412:sdcard_app_command         SD_SEND_OP_COND/ACMD41 arg 0x40300000 (state idle)
48.729419:sdcard_command_response c0 ff ff 00  (state ready)
48.729786:sdcard_normal_command         ALL_SEND_CID/ CMD02 arg 0x00000000 (state ready)
48.729797:sdcard_command_response aa 58 59 51 45 4d 55 21 01 de ad be ef 00 62 19  (state identification)
48.730825:sdcard_normal_command   SEND_RELATIVE_ADDR/ CMD03 arg 0x00000000 (state identification)
48.730835:sdcard_command_response 45 67 05 00  (state standby)
48.731221:sdcard_normal_command             SEND_CSD/ CMD09 arg 0x45670000 (state standby)
48.731228:sdcard_command_response 40 0e 00 32 5b 59 00 00 0d 47 7f 80 0a 40 00 00  (state standby)
48.732012:sdcard_normal_command SELECT/DESELECT_CARD/ CMD07 arg 0x45670000 (state standby)
48.732021:sdcard_command_response 00 00 07 00  (state transfer)
48.732419:sdcard_command_response 00 00 09 20  (state transfer)
48.764983:sdcard_app_command                SEND_SCR/ACMD51 arg 0x00000000 (state transfer)
48.765000:sdcard_command_response 00 00 09 20  (state sendingdata)
48.766951:sdcard_command_response 00 00 09 20  (state transfer)
48.767159:sdcard_app_command               SD_STATUS/ACMD13 arg 0x00000000 (state transfer)
48.767168:sdcard_command_response 00 00 09 20  (state sendingdata)
48.966731:sdcard_normal_command  READ_MULTIPLE_BLOCK/ CMD18 arg 0x00000000 (state transfer)
48.966763:sdcard_command_response 00 00 09 00  (state sendingdata)
48.974869:sdcard_normal_command    STOP_TRANSMISSION/ CMD12 arg 0x00000000 (state sendingdata)
48.974877:sdcard_command_response 00 00 0b 00  (state transfer)
50.044308:sdcard_normal_command          SEND_STATUS/ CMD13 arg 0x45670000 (state transfer)
50.044330:sdcard_command_response 00 00 09 00  (state transfer)
[...]

Regards,

Phil.

Based-on: 20171213213557.26561-7-f4bug@amsat.org
          (QTests: use Python to run complex tests)

Philippe Mathieu-Daudé (26):
  sdbus: add a QMP command to access a SDBus
  sdcard: add Python qtests
  sdcard: use ldst API
  sdcard: replace fprintf() -> qemu_log_mask()
  sdcard: rename sd_set_mode() -> sd_update_mode()
  sdcard: add sd_set_mode()
  sdcard: add sdcard_set_mode() trace event
  sdcard: add sd_set_state()
  sdcard: add a sdcard_set_state() trace event
  sdcard: use more detailled state/mode trace events
  sdcard: use warn_report() instead of fprintf()
  sdcard: replace DPRINTF() by trace events
  sdcard: add more trace events
  sdcard: use qemu_hexbuf_strdup() to trace command response
  sdcard: use PW_LEN define instead of '16' magic
  sdcard: let cmd_valid_while_locked() returns a bool
  sdcard: rename sd_set_REG() functions called by sd_reset() as sd_reset_REG()
  sdcard: move Memory Card registers together
  sdcard: add DSR register
  sdcard: add/use SD_CMD_MAX to check valid SD commands
  sdcard: add sd_cmd_abbreviation() to resolve the SD command id
  sdcard: reduce sd_cmd traces
  sdcard: add ACMD trace events
  sdcard: use a 16-bit type for the 16-bit RCA register
  sdcard: add/use a SDCardCommandClass enum instead of magic numbers
  sdcard: add/use a ccc_spi enum for the commands supported in SPI mode

 qapi-schema.json       |  41 ++++
 hw/sd/core.c           |  43 ++++
 hw/sd/sd.c             | 519 +++++++++++++++++++++++++++++++------------------
 stubs/qmp_sdbus.c      |  11 ++
 hw/sd/trace-events     |  17 ++
 stubs/Makefile.objs    |   1 +
 tests/Makefile.include |   2 +
 tests/sdcard_tests.py  | 172 ++++++++++++++++
 8 files changed, 617 insertions(+), 189 deletions(-)
 create mode 100644 stubs/qmp_sdbus.c
 create mode 100755 tests/sdcard_tests.py

-- 
2.15.1
