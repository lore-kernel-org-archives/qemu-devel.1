Received: from eggs.gnu.org ([2001:4830:134:3::10]:36192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cU8gH-0002tP-TH
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:06:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cU8gH-0000H6-4b
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:06:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cU8gG-0000G5-UH
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:06:53 -0500
Message-ID: <1484816807.15364.26.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 19 Jan 2017 10:06:47 +0100
In-Reply-To: <1484749850-87206-1-git-send-email-phil@philjordan.eu>
References: <1484749850-87206-1-git-send-email-phil@philjordan.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] hw/usb/dev-hid: add a Mac guest
 compatibility option to usb-tablet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org

On Mi, 2017-01-18 at 15:30 +0100, Phil Dennis-Jordan wrote:
> Darwin/OS X/macOS's HID driver stack does not correctly drive Qemu's
> simulated USB Tablet. This adds a boolean option "mac_compat" which
> subtly changes the device so it behaves in a way that Mac guests can
> handle.
>=20
> The specific incompatibilities with the regular Qemu USB tablet are:
>=20
>  1. Absolute pointing devices with HID Report Descriptor usage page of
> 0x01 (pointing) are handled by the macOS HID driver as analog sticks,
> so the movement of the cursor ends up being the cumulative deviance
> from the centre position.
>  2. The bInterfaceProtocol of 0x02 enables a particular macOS HID
> driver mode which only works properly with mice (relative motion) not
> absolute pointing devices, so spurious events with relative
> coordinates are generated in addition to absolute ones. This manifests
> as a very jittery cursor.
>=20
> The workaround is to report a usage page of 0x02 (mouse) and a
> bInterfaceProtocol value of 0x00.

Waded through the specs.  Setting bInterfaceProtocol to 0x00 should be
done anyway.  Only boot protocol devices (which the tablet isn't) should
set this to 1 (kbd) or 2 (mouse).  No need to hide that behind a macos
option, we can do that for everybody.

The other one is more tricky.  Declaring the device as "mouse" is
clearly wrong according to the specs.  There is no explicit "tablet"
device.  "pointing" comes closest.

Does the issue still show up with bInterfaceProtocol being fixed?

cheers,
  Gerd
