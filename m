Received: from eggs.gnu.org ([2001:4830:134:3::10]:59248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebR6A-00039s-GT
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:16:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebR65-0006qC-Ip
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:16:18 -0500
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:39544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebR65-0006pe-Dl
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:16:13 -0500
Received: by mail-qt0-x231.google.com with SMTP id k19so18147608qtj.6
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 05:16:13 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 16 Jan 2018 10:15:44 -0300
Message-Id: <20180116131555.14242-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/11] qdev: remove DeviceClass::init/exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>, Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

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

Philippe Mathieu-Daudé (11):
  smbus: add a NULL check for SMBusDeviceClass::init callbacks
  smbus_eeprom: replace SMBusDeviceClass::init by DeviceClass::reset
  hw/i2c: convert I2CSlaveClass::init -> realize
  usb-ccid: convert CCIDCardClass::init -> realize
  virtio-ccw: convert VirtIOCCWDeviceClass::init -> realize
  sysbus: add realize() and unrealize()
  qdev: simplify the SysBusDeviceClass::init path
  qdev: remove DeviceClass::init
  qdev: remove DeviceClass::exit
  qdev: remove empty realize/unrealize stubs
  qdev: rename typedef qdev_resetfn() -> DeviceReset()

 hw/s390x/virtio-ccw.h         |  2 +-
 hw/usb/ccid.h                 |  9 +++++--
 include/hw/i2c/i2c.h          |  2 +-
 include/hw/i2c/smbus.h        |  2 +-
 include/hw/qdev-core.h        |  8 ++----
 include/hw/sysbus.h           |  4 +++
 hw/audio/wm8750.c             |  8 +++---
 hw/core/qdev.c                | 28 ---------------------
 hw/core/sysbus.c              | 30 +++++++++++++++++++----
 hw/display/ssd0303.c          |  5 ++--
 hw/gpio/max7310.c             |  6 ++---
 hw/i2c/core.c                 | 10 +++-----
 hw/i2c/smbus.c                |  8 +++---
 hw/i2c/smbus_eeprom.c         |  5 ++--
 hw/input/lm832x.c             |  5 ++--
 hw/misc/tmp105.c              |  6 ++---
 hw/misc/tmp421.c              |  6 ++---
 hw/nvram/eeprom_at24c.c       | 24 +++++++++---------
 hw/s390x/virtio-ccw.c         | 35 +++++++++++++-------------
 hw/timer/twl92230.c           | 12 ++++-----
 hw/usb/ccid-card-emulated.c   | 42 ++++++++++++++++---------------
 hw/usb/ccid-card-passthru.c   | 10 ++++----
 hw/usb/dev-smartcard-reader.c | 57 +++++++++++++++----------------------------
 23 files changed, 145 insertions(+), 179 deletions(-)

-- 
2.15.1
