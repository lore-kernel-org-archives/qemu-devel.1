Received: from eggs.gnu.org ([2001:4830:134:3::10]:53722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gRN81-0001lR-Ek
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:05:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gRN7y-0001Kj-By
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:05:09 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gRN7x-0001GL-7F
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:05:06 -0500
Received: by mail-ot1-x342.google.com with SMTP id e12so13562635otl.5
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 12:04:50 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 26 Nov 2018 14:04:19 -0600
Message-Id: <20181126200435.23408-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/16] Fix/add vmstate handling in some I2C
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <minyard@acm.org>

I believe I've fixed all the issues pointed out by everyone, and I've
tested migration between 2.12 and 3.0 and back on q35 and piix4
(with the fix I posted earlier for piix4).

Changes since v2:

Added proper license headers for the newly created files.

Added myself as a maintainer of the i2c core files.

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
