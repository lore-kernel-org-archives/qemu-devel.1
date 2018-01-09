Received: from eggs.gnu.org ([2001:4830:134:3::10]:34445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eYuTg-00079w-P3
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:02:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eYuTc-0001AT-Sl
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:02:08 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  9 Jan 2018 14:01:49 +0000
Message-Id: <1515506513-31961-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/4] Reset SD cards attached to legacy-API
 controllers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, qemu-stable@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

It turns out that we don't reset the SD card model if it's
attached to a legacy-API controller. For new-style controllers
where the SD card object is attached to an SD_BUS, the generic
qbus infrastructure takes care of ensuring that the card's
DeviceState::reset method gets called. But for the legacy
API where the card is created by calling sd_init(), the card
object has no SD_BUS to plug into, and so the reset function
must be called manually.

This mostly had no ill effects because a guest OS will typically
perform an SD reset command as part of its device driver init
sequence. However it does mean that migration won't work, because
it's in sd_reset() that we set up the wpgrps_size field, and
without that the migration struct on reload won't match.

This patchset fixes up the four legacy controllers to call
reset on the SD card device in their controller reset functions.
The first 3 are cc:stable as migration bugfixes.

This fixes https://bugs.launchpad.net/qemu/+bug/1739378

Philippe: this probably clashes slightly with your sdcard
patchsets (and where you've updated devices to the new APIs
it becomes irrelevant), but I think we should apply these
first so we can have a simple patch to backport to the stable
tree.

Notes:
 * OMAP doesn't migrate anyway, so isn't cc:stable
 * for vexpress-a15, you also need "-machine secure=off":
   a config with trustzone emulation enabled doesn't
   successfully migrate (haven't yet debugged why)

thanks
-- PMM

Peter Maydell (4):
  hw/sd/pl181: Reset SD card on controller reset
  hw/sd/milkymist-memcard: Reset SD card on controller reset
  hw/sd/ssi-sd: Reset SD card on controller reset
  hw/sd/omap_mmc: Reset SD card on controller reset

 hw/sd/milkymist-memcard.c |  4 ++++
 hw/sd/omap_mmc.c          | 14 ++++++++++----
 hw/sd/pl181.c             |  4 ++++
 hw/sd/ssi-sd.c            | 24 +++++++++++++++++++++++-
 4 files changed, 41 insertions(+), 5 deletions(-)

-- 
2.7.4
