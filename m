Received: from eggs.gnu.org ([209.51.188.92]:37283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goBEI-0003b9-SP
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:01:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goB7r-0005Vv-E9
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:55:16 -0500
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29]:44816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1goB7r-0005Ud-8A
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:55:15 -0500
Received: by mail-io1-xd29.google.com with SMTP id r200so14205829iod.11
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 09:55:13 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 28 Jan 2019 11:54:39 -0600
Message-Id: <20190128175458.27255-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 00/19] Fix/add vmstate handling in some I2C
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <minyard@acm.org>, Peter Maydell <peter.maydell@linaro.org>

I've forced some time open to work on this, it's been too long.

Changes since v3:

Change I2C to "I2C and SMBus" in the MAINTAINERS file.

Added a comment to the smbus_eeprom reset to make the reasoning for
the choice clear.

Fix a logic error introduced in "i2c: Don't check return value from
i2c_recv()".

Fix a debug problem in "i2c: Simplify and correct the SMBus state machine",
a removed variable was still being used in a debug statement.

Split up "i2c: Simplify and correct the SMBus state machine" into
smaller logical chunks.

Updated "boards.h: Ignore migration for SMBus devices on older machines"
to ignore migration for 4.0 and earlier.

No other comments received on "i2c:smbus_eeprom: Add vmstate handling
to the smbus eeprom", not sure what to make of that.  I think that
Dave's response to my question was that it could be modified to
support different sizes in the future without issue.

Dropped "hw/i2c/smbus_eeprom: Create at most SMBUS_EEPROM_MAX EEPROMs
on a SMBus and instead added a patch to assert if the number of
eeproms is > 8.

Changes since v2:

Added proper license headers for the newly created files.

Removed unneeded code in several places pointed out by Peter Maydell
since i2c_recv() returns a uint8_t instead of an int.  These are
in two separate patches.
Added a patch from Philippe Mathieu-Daudé <philmd@redhat.com> to
replace a magic number with a constant in the smbus_eeprom code and
verify the count so there is no overflow.

Updated the pm_smbus migration to not update the version numbers
in the existing vmstate structures.  The needed field didn't
accomplish what was needed because it is only called on the save
side, not the load side of the migration.  So I'm using
VMSTATE_STRUCT_TEST() to transfer the pm_smbus data now, that
should be all that is required for backwards compatibility, and
will be safer for falling back to an older version.

I found the problem with the SMBus being broken on piix4 after a
migration, but I sent it out as a separate patch since it has
nothing to do with this series, and should probably go into the
current release being worked on.
