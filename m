Received: from eggs.gnu.org ([2001:4830:134:3::10]:48594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpaYv-0005ua-02
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpaYt-0004AJ-Ux
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:44:45 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 15:44:28 +0100
Message-Id: <20180814144436.679-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/8] arm/raspi: Make fb handle virtual viewport
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

The raspi framebuffer supports a virtual viewport which can
be set up so that the virtual framebuffer size is larger than
the physical screen size, and the displayed area is at some
offset within this virtual framebuffer area. This patchset
implements that support.

To do that I had to do a fair amount of refactoring, because
getting the viewport code to work correctly and prevent the
guest from making it fall over by specifying silly offsets
or sizes requires that we properly validate and clip the
config that the guest sends us.

Note that the documentation in places like
https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface
has various errors in it. The behaviour implemented here
corresponds to how a hardware raspi2 I tested seems to behave,
using test programs based on the code from
http://www.valvers.com/open-software/raspberry-pi/step05-bare-metal-programming-in-c-pt5/

(I was a little bit hampered because I couldn't get the rpi
to actually *display* anything to the HDMI port, so mostly
I was testing the edge case behaviour of attempting to set
and read back various config values.)

This series fixes this bug:
https://bugs.launchpad.net/qemu/+bug/1777672

thanks
-- PMM

Peter Maydell (8):
  hw/misc/bcm2835_fb: Move config fields to their own struct
  hw/misc/bcm2835_property: Track fb settings using BCM2835FBConfig
  hw/display/bcm2835_fb: Drop unused size and pitch fields
  hw/display/bcm2835_fb: Reset resolution, etc correctly
  hw/display/bcm2835_fb: Abstract out calculation of pitch, size
  hw/display/bcm2835_fb: Fix handling of virtual framebuffer
  hw/display/bcm2835_fb: Validate config settings
  hw/display/bcm2835_fb: Validate bcm2835_fb_mbox_push() config

 include/hw/display/bcm2835_fb.h |  59 +++++++--
 hw/display/bcm2835_fb.c         | 218 +++++++++++++++++++-------------
 hw/misc/bcm2835_property.c      | 123 +++++++++---------
 3 files changed, 240 insertions(+), 160 deletions(-)

-- 
2.18.0
