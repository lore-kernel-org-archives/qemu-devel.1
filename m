Received: from eggs.gnu.org ([2001:4830:134:3::10]:40087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cUYL7-0007RA-Ja
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:30:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cUYL4-0007Zg-Dl
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:30:45 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:34837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <phil@philjordan.eu>) id 1cUYL4-0007ZV-15
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:30:42 -0500
Received: by mail-wm0-x22a.google.com with SMTP id r126so35218650wmr.0
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 04:30:41 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Fri, 20 Jan 2017 13:30:15 +0100
Message-Id: <1484915417-10499-1-git-send-email-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/2] hw/usb/dev-hid: Make usb-tablet work
 with OS X/macOS guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>

This series makes the Qemu usb-tablet work correctly with OS X/macOS guests without the need for a special guest driver.

 * The usb-tablet should not have a boot protocol of 2. Other OSes seem to ignore this, but the IOHIDFamily driver stack chokes on it for anything but conventional (relative motion) mice.
 * A "mac_compat" boolean option is added to the usb-tablet, which changes its report descriptor to specify a usage of 0x02 (mouse) instead of 0x01 (pointer). This is required for correct operation in the Mac HID driver stack.

Changelog
=========

v1 -> v2:
 * v1 Thread was "[PATCH] hw/usb/dev-hid: add a Mac guest compatibility option to usb-tablet"
 * Always apply the boot protocol (bInterfaceProtocol) change to usb-tablet, not just when the Mac compatibility option is active. The original value of 0x02 was determined to be incorrect according to the spec anyway.
 * As the boot protocol change is permanent, separate interface and device descriptor constants for the Mac/non-Mac variants of the tablet are no longer required, and have been removed.

Phil Dennis-Jordan (2):
  hw/usb/dev-hid: set bInterfaceProtocol to 0x00 for usb-tablet
  hw/usb/dev-hid: add a usb-tablet Mac guest compatibility option

 hw/usb/dev-hid.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.3.2 (Apple Git-55)
