Received: from eggs.gnu.org ([2001:4830:134:3::10]:45893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQzJF-0001we-P3
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:06:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQzJC-0004Jq-I6
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:06:53 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  7 Jun 2018 15:06:34 -0300
Message-Id: <20180607180641.874-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/7] sdcard: cleanup the SD_SPEC version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paul Brook <paul@codesourcery.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>

Since v2:
- heavy documentation improvements
- squashed previous 3+4 "add spec_version property default to v2" for atomicity
- SSI/SD patch downgraded to RFC
- added Alistair R-b tags

v1: http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg00388.html

Hi,

This series adds a 'spec_version' property to the SD Card device,
to allow to limit some commands to specific spec version range
(some firmwares use this feature to detect which spec version the
card implements).

This [v2: does NOT] restore the SSI/SD support of the Stellaris LM3S6965EVB
board, which allow to stress the SD Card code with a nice integration test
(waiting for another series to get merged to add the Avocado test):

    $ qemu-system-arm -M lm3s6965evb -serial stdio \
      -kernel sd_card.bin -sd sdcard.img

    SD Card Example Program
    Type 'help' for help.

    /> ls
    Open
    listing

    ----A 2012/04/25 17:44        12  README.TXT

       1 File(s),        12 bytes total
       0 Dir(s),      61182K bytes free

    /> cat README.TXT
    Hello World

See:
http://lists.nongnu.org/archive/html/qemu-devel/2012-04/msg03790.html
http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg00353.html

Regards,

Phil.

[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/8:[----] [--] 'sdcard: Update the Configuration Register (SCR) to Spec Version 1.10'
002/8:[----] [--] 'sdcard: Allow commands valid in SPI mode'
003/8:[0017] [FC] 'sdcard: Add a 'spec_version' property'
004/8:[down] 'sdcard: Set Spec v2.00 as default'
005/8:[----] [--] 'hw/sd/ssi-sd: Force cards connected in SPI mode to use Spec v1.10'
006/8:[----] [--] 'sdcard: Disable SEND_IF_COND (CMD8) for Spec v1'
007/8:[----] [--] 'sdcard: Reflect when the Spec v3 is supported in the Config Register (SCR)'
008/8:[----] [--] 'sdcard: Disable CMD19/CMD23 for Spec v2'

Philippe Mathieu-Daudé (7):
  sdcard: Update the Configuration Register (SCR) to Spec Version 1.10
  sdcard: Allow commands valid in SPI mode
  sdcard: Add a 'spec_version' property, default to Spec v2.00
  sdcard: Disable SEND_IF_COND (CMD8) for Spec v1
  sdcard: Reflect when the Spec v3 is supported in the Config Register (SCR)
  sdcard: Disable CMD19/CMD23 for Spec v2
  hw/sd/ssi-sd: Force cards connected in SPI mode to use Spec v1.10

 include/hw/sd/sd.h |  6 ++++++
 hw/sd/sd.c         | 50 +++++++++++++++++++++++++++++-----------------
 hw/sd/ssi-sd.c     |  2 ++
 3 files changed, 40 insertions(+), 18 deletions(-)

-- 
2.17.1
