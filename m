Received: from eggs.gnu.org ([2001:4830:134:3::10]:43229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cMz0M-0002Gg-RC
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cMz0L-0000Cy-So
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:02 -0500
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:35401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1cMz0L-0000CW-MK
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:01 -0500
Received: by mail-pg0-x22a.google.com with SMTP id i5so113619419pgh.2
	for <qemu-devel@nongnu.org>; Fri, 30 Dec 2016 07:22:01 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Fri, 30 Dec 2016 09:21:31 -0600
Message-Id: <1483111310-24808-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 01/18] Patch set to get full IPMI over SMBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: minyard@acm.org

I've had this working for a while, primarily for my own testing
capability, but I guess I should put it out there for other people
as this interface is starting to show up in ARM64 devices and maybe
it's useful to others.

It's actually a few sets of patches that each accomplish a different
things, but all required for full function of the device.

[PATCH 01/19] i2c: Allow I2C devices to NAK start events
[PATCH 02/19] i2c-smbus: Use a int for return

The above two are more general bug fixes.  The first has already
been sent out, it's required for the SMBus alert device and for
IPMI to be able to NAK when they have no data.  The second is just
a little bug fix, and may not be strictly necessary.

[PATCH 03/19] i2c:pm_smbus: Clean up some style issues
[PATCH 04/19] i2c:pm_smbus: Fix the semantics of block I2C transfers
[PATCH 05/19] i2c:pm_smbus: Make the I2C block read command read-only
[PATCH 06/19] i2c:pm_smbus: Add block transfer capability
[PATCH 07/19] i2c:pm_smbus: Fix state transfer
[PATCH 08/19] i2c:pm_smbus: Add interrupt handling
[PATCH 09/19] i2c:pm_smbus: Add the ability to force block transfer

The above changes fix the pm_smbus device so it works properly and so
it can do block transfers, which are required by IPMI.

[PATCH 10/19] ipmi: Add an SMBus IPMI interface
[PATCH 11/19] acpi: Add i2c serial bus CRS handling
[PATCH 12/19] ipmi: Fix SSIF ACPI handling to use the right CRS
[PATCH 13/19] pc: Add _enabled to the end of some boolean flags
[PATCH 14/19] pc: Add an SMB0 ACPI device to q35

The above add the IPMI on SMBus device itself and then add the ACPI
handling for it.

[PATCH 15/19] hw: Add an IRQ interface
[PATCH 16/19] isa: Add an irq device.

I'm not sure about the above patches.  They add a generic "interrupt"
device then add an ISA version of them.  The SMBus alert device
requires an interrupt of some type.  It seemed like having a generic
interrupt that could be tied to a device was a nice feature, it would
keep from having to have a separate isa/pci/whatever version of
the alert device for something that was on an I2C bus.  But I'm not
really sure this is the best way.

[PATCH 17/19] i2c: Allow SMBus device to NAK start events
[PATCH 18/19] i2c: Add an SMBus alert device.
[PATCH 19/19] ipmi_smbus: Add alert capability to the IPMI SSIF code

The above add an SMBus alert device.  It's basically something that
muxes "interrupt" signals from I2C device onto a single interrupt and
allows the I2C master to fetch which I2C device in sending the
interrupt.  This allows the IPMI device to tell the host that it has
something ready for it, thus really speeding things up.

-corey
