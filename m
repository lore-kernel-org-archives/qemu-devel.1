Received: from eggs.gnu.org ([2001:4830:134:3::10]:37106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eQ07M-0004Fm-Dq
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 19:14:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eQ07K-0003MJ-Rh
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 19:14:16 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171213232025.24503-1-f4bug@amsat.org>
References: <20171213232025.24503-1-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 15 Dec 2017 16:13:42 -0800
Message-ID: <CAKmqyKNR4ECfJL7ymgyBdVSJKPcxFVJ2=svAE0aUQCW5=qHvSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/26] SDCard housekeeping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Prasad J Pandit <pjp@fedoraproject.org>, Clement Deschamps <clement.deschamps@antfield.fr>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Fam Zheng <famz@redhat.com>, Isaac Lozano <109lozanoi@gmail.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Andrey Yurovsky <yurovsky@gmail.com>

On Wed, Dec 13, 2017 at 3:19 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Now that we have a way to write qtest in Python, lets start with a simple=
 test
> to perform basic card identification, covering many functions of the sd/s=
d.c
> file.
>
> [patch 1]
> When a device is not MMIO-connected but rather plugged into a Bus, it is =
easier
> to write tests using QMP.
> So we add a 'sdbus-command' entry to directly operate on a SD Bus.
> (Note this method should also work with all other QBus).
>
> [patch 2]
> We write a simple pyqtest, which
>   - resolve the SDBus QOM path in the test setup()
>   - verify default values for SD Spec v2.
>
> Since have a test, lets run after each patch, so we are sure we don't bre=
ak things.
>
> [patch 4-14,20-23]
> Add a bunch of trace events
> [patch 3,11,15-18]
> Aesthetic changes mostly
> [other patches]
> Trivial changes
>
> Once this series applied, booting some Linux on a vexpress-a9 with few
> sd*command traces enabled result in this outputs (which result useful to
> understand/fix the different SD implementations):
>
> 48.687227:sdcard_normal_command         IO_RW_DIRECT/ CMD52 arg 0x00000c0=
0 (state idle)
> 48.687233:sdcard_command_response (no response) (state idle)
> 48.689237:sdcard_normal_command         IO_RW_DIRECT/ CMD52 arg 0x80000c0=
8 (state idle)
> 48.689244:sdcard_command_response (no response) (state idle)
> 48.690877:sdcard_normal_command        GO_IDLE_STATE/ CMD00 arg 0x0000000=
0 (state idle)
> 48.690890:sdcard_command_response (no response) (state idle)
> 48.723486:sdcard_normal_command         SEND_IF_COND/ CMD08 arg 0x000001a=
a (state idle)
> 48.723507:sdcard_command_response 00 00 01 aa  (state idle)
> 48.723886:sdcard_normal_command      IO_SEND_OP_COND/ CMD05 arg 0x0000000=
0 (state idle)
> 48.723892:sdcard_command_response (no response) (state idle)
> 48.724019:sdcard_normal_command      IO_SEND_OP_COND/ CMD05 arg 0x0000000=
0 (state idle)
> 48.724023:sdcard_command_response (no response) (state idle)
> 48.724110:sdcard_normal_command      IO_SEND_OP_COND/ CMD05 arg 0x0000000=
0 (state idle)
> 48.724115:sdcard_command_response (no response) (state idle)
> 48.724178:sdcard_normal_command      IO_SEND_OP_COND/ CMD05 arg 0x0000000=
0 (state idle)
> 48.724181:sdcard_command_response (no response) (state idle)
> 48.724999:sdcard_command_response 00 40 01 20  (state idle)
> 48.725214:sdcard_app_command         SD_SEND_OP_COND/ACMD41 arg 0x0000000=
0 (state idle)
> 48.725225:sdcard_command_response 40 ff ff 00  (state idle)
> 48.727113:sdcard_normal_command        GO_IDLE_STATE/ CMD00 arg 0x0000000=
0 (state idle)
> 48.727125:sdcard_command_response (no response) (state idle)
> 48.729206:sdcard_normal_command         SEND_IF_COND/ CMD08 arg 0x000001a=
a (state idle)
> 48.729213:sdcard_command_response 00 00 01 aa  (state idle)
> 48.729339:sdcard_command_response 00 00 01 20  (state idle)
> 48.729412:sdcard_app_command         SD_SEND_OP_COND/ACMD41 arg 0x4030000=
0 (state idle)
> 48.729419:sdcard_command_response c0 ff ff 00  (state ready)
> 48.729786:sdcard_normal_command         ALL_SEND_CID/ CMD02 arg 0x0000000=
0 (state ready)
> 48.729797:sdcard_command_response aa 58 59 51 45 4d 55 21 01 de ad be ef =
00 62 19  (state identification)
> 48.730825:sdcard_normal_command   SEND_RELATIVE_ADDR/ CMD03 arg 0x0000000=
0 (state identification)
> 48.730835:sdcard_command_response 45 67 05 00  (state standby)
> 48.731221:sdcard_normal_command             SEND_CSD/ CMD09 arg 0x4567000=
0 (state standby)
> 48.731228:sdcard_command_response 40 0e 00 32 5b 59 00 00 0d 47 7f 80 0a =
40 00 00  (state standby)
> 48.732012:sdcard_normal_command SELECT/DESELECT_CARD/ CMD07 arg 0x4567000=
0 (state standby)
> 48.732021:sdcard_command_response 00 00 07 00  (state transfer)
> 48.732419:sdcard_command_response 00 00 09 20  (state transfer)
> 48.764983:sdcard_app_command                SEND_SCR/ACMD51 arg 0x0000000=
0 (state transfer)
> 48.765000:sdcard_command_response 00 00 09 20  (state sendingdata)
> 48.766951:sdcard_command_response 00 00 09 20  (state transfer)
> 48.767159:sdcard_app_command               SD_STATUS/ACMD13 arg 0x0000000=
0 (state transfer)
> 48.767168:sdcard_command_response 00 00 09 20  (state sendingdata)
> 48.966731:sdcard_normal_command  READ_MULTIPLE_BLOCK/ CMD18 arg 0x0000000=
0 (state transfer)
> 48.966763:sdcard_command_response 00 00 09 00  (state sendingdata)
> 48.974869:sdcard_normal_command    STOP_TRANSMISSION/ CMD12 arg 0x0000000=
0 (state sendingdata)
> 48.974877:sdcard_command_response 00 00 0b 00  (state transfer)
> 50.044308:sdcard_normal_command          SEND_STATUS/ CMD13 arg 0x4567000=
0 (state transfer)
> 50.044330:sdcard_command_response 00 00 09 00  (state transfer)
> [...]
>
> Regards,
>
> Phil.
>
> Based-on: 20171213213557.26561-7-f4bug@amsat.org
>           (QTests: use Python to run complex tests)

As this series can't be merged until the Python for Qtest series is
merged I'm not going to go over this now. Let's wait and see how that
discussion goes first.

Alistair

>
> Philippe Mathieu-Daud=C3=A9 (26):
>   sdbus: add a QMP command to access a SDBus
>   sdcard: add Python qtests
>   sdcard: use ldst API
>   sdcard: replace fprintf() -> qemu_log_mask()
>   sdcard: rename sd_set_mode() -> sd_update_mode()
>   sdcard: add sd_set_mode()
>   sdcard: add sdcard_set_mode() trace event
>   sdcard: add sd_set_state()
>   sdcard: add a sdcard_set_state() trace event
>   sdcard: use more detailled state/mode trace events
>   sdcard: use warn_report() instead of fprintf()
>   sdcard: replace DPRINTF() by trace events
>   sdcard: add more trace events
>   sdcard: use qemu_hexbuf_strdup() to trace command response
>   sdcard: use PW_LEN define instead of '16' magic
>   sdcard: let cmd_valid_while_locked() returns a bool
>   sdcard: rename sd_set_REG() functions called by sd_reset() as sd_reset_=
REG()
>   sdcard: move Memory Card registers together
>   sdcard: add DSR register
>   sdcard: add/use SD_CMD_MAX to check valid SD commands
>   sdcard: add sd_cmd_abbreviation() to resolve the SD command id
>   sdcard: reduce sd_cmd traces
>   sdcard: add ACMD trace events
>   sdcard: use a 16-bit type for the 16-bit RCA register
>   sdcard: add/use a SDCardCommandClass enum instead of magic numbers
>   sdcard: add/use a ccc_spi enum for the commands supported in SPI mode
>
>  qapi-schema.json       |  41 ++++
>  hw/sd/core.c           |  43 ++++
>  hw/sd/sd.c             | 519 +++++++++++++++++++++++++++++++------------=
------
>  stubs/qmp_sdbus.c      |  11 ++
>  hw/sd/trace-events     |  17 ++
>  stubs/Makefile.objs    |   1 +
>  tests/Makefile.include |   2 +
>  tests/sdcard_tests.py  | 172 ++++++++++++++++
>  8 files changed, 617 insertions(+), 189 deletions(-)
>  create mode 100644 stubs/qmp_sdbus.c
>  create mode 100755 tests/sdcard_tests.py
>
> --
> 2.15.1
>
>
