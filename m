Received: from eggs.gnu.org ([2001:4830:134:3::10]:52528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edapW-0003tF-FR
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:04:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edapT-0000Bg-8z
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:04:02 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:44722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edapT-0000BZ-5u
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:03:59 -0500
Received: by mail-qt0-x243.google.com with SMTP id l20so18686127qtj.11
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 04:03:59 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 22 Jan 2018 09:03:44 -0300
Message-Id: <20180122120351.22369-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/7] qdev: remove DeviceClass::init/exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

since v1:
  - fix format string on 32-bit host (patchew)
  - do not add smbus_eeprom_reset() (Eduardo)
  - directly use DeviceClass::realize (Eduardo)
  - squashed 2 patches (Eduardo)

Hi,

This series finalize the qdev QOMification.

We first convert the I2CSlave/SMBusDevice,
then the usb-ccid and virtio-ccw,
and finally the SysBusDevice.

At the end we get one less TODO :)

    /* TODO remove, once users are converted to unrealize */

There is still one standing in SysBusDeviceClass::init().

Regards,

Phil.

Philippe Mathieu-Daudé (7):
  hw/i2c/smbus: use DeviceClass::realize instead of SMBusDeviceClass::init
  hw/i2c: use DeviceClass::realize instead of I2CSlaveClass::init
  usb-ccid: convert CCIDCardClass::init -> realize
  virtio-ccw: convert VirtIOCCWDeviceClass::exit -> unrealize
  qdev: simplify the SysBusDeviceClass::init path
  qdev: remove DeviceClass::exit
  qdev: rename typedef qdev_resetfn() -> DeviceReset()

 include/hw/i2c/i2c.h          |  3 ---
 include/hw/i2c/smbus.h        |  1 -
 include/hw/qdev-core.h        |  8 ++----
 hw/s390x/virtio-ccw.h         |  2 +-
 hw/usb/ccid.h                 |  9 +++++--
 hw/audio/wm8750.c             |  8 +++---
 hw/core/qdev.c                | 28 ---------------------
 hw/core/sysbus.c              | 15 ++++++++----
 hw/display/ssd0303.c          |  9 +++----
 hw/gpio/max7310.c             |  9 +++----
 hw/i2c/core.c                 | 13 ----------
 hw/i2c/smbus.c                |  9 -------
 hw/i2c/smbus_eeprom.c         |  5 ++--
 hw/input/lm832x.c             |  9 +++----
 hw/misc/tmp105.c              |  7 +++---
 hw/misc/tmp421.c              |  8 +++---
 hw/nvram/eeprom_at24c.c       | 24 +++++++++---------
 hw/s390x/virtio-ccw.c         | 35 +++++++++++++-------------
 hw/timer/twl92230.c           | 11 +++------
 hw/usb/ccid-card-emulated.c   | 45 ++++++++++++++++++----------------
 hw/usb/ccid-card-passthru.c   | 10 ++++----
 hw/usb/dev-smartcard-reader.c | 57 +++++++++++++++----------------------------
 22 files changed, 124 insertions(+), 201 deletions(-)

-- 
2.15.1
