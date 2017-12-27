Received: from eggs.gnu.org ([2001:4830:134:3::10]:49763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eU2mV-0005nE-9E
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 22:53:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eU2mR-0005zR-AD
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 22:53:27 -0500
References: <cover.1511731946.git.mdavidsaver@gmail.com>
	<15378780eee5dc9ebc68361463a0fd6acea55556.1511731946.git.mdavidsaver@gmail.com>
	<20171205065304.GK3057@umbus.fritz.box>
	<9f529ae2-9f89-b542-5933-9f57c451aae0@gmail.com>
	<20171206111157.GE3057@umbus.fritz.box>
From: Michael Davidsaver <mdavidsaver@gmail.com>
Message-ID: <45c0ecae-80bc-cc54-ec3d-66ddd69b6abc@gmail.com>
Date: Tue, 26 Dec 2017 21:53:03 -0600
MIME-Version: 1.0
In-Reply-To: <20171206111157.GE3057@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="693Agu127LQxDIOQ3QIksqBWSNhJmlALO"
Subject: Re: [Qemu-devel] [PATCH 13/17] e500: move PCI host bridge into CCSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--693Agu127LQxDIOQ3QIksqBWSNhJmlALO
From: Michael Davidsaver <mdavidsaver@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Message-ID: <45c0ecae-80bc-cc54-ec3d-66ddd69b6abc@gmail.com>
Subject: Re: [PATCH 13/17] e500: move PCI host bridge into CCSR
References: <cover.1511731946.git.mdavidsaver@gmail.com>
 <15378780eee5dc9ebc68361463a0fd6acea55556.1511731946.git.mdavidsaver@gmail.com>
 <20171205065304.GK3057@umbus.fritz.box>
 <9f529ae2-9f89-b542-5933-9f57c451aae0@gmail.com>
 <20171206111157.GE3057@umbus.fritz.box>
In-Reply-To: <20171206111157.GE3057@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 12/06/2017 05:11 AM, David Gibson wrote:
> On Tue, Dec 05, 2017 at 10:42:25PM -0500, Michael Davidsaver wrote:
>> On 12/05/2017 01:53 AM, David Gibson wrote:
>>> On Sun, Nov 26, 2017 at 03:59:11PM -0600, Michael Davidsaver wrote:
>>>> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
>>>
>>> Hmm.  Is there anything you're *not* planning to move under the CCSR.=

>>
>> Well, the decrementer/timebase initialization for one as this has
>> nothing to do with the CCSR registers.
>=20
> Right, but no actual devices, even small ones?

Well, there is the GPIO controller ("mpc8xxx_gpio") as I have frankly
have no idea where it comes from.  Neither MPC8540 nor 8544 define
anything at CCSR offset 0xFF000.  The registers modeled differ
from the GPIO controller which is defined at 0xE0030.

So I'm considering this to be specific to the existing boards.

>> I haven't added the TSEC/eTSEC instances either.
>> Partly this is because the existing boards, for reasons I don't unders=
tand,
>> use virtio NICs.
>>
>> Further, the mpc8540 has TSEC instances 1 and 2, while the mpc8544
>> has instances 1 and 3.  So I decided to leave NIC setup to the Machine=

>> rather then add the extra code to parameterize this under the CCSR dev=
ice.
>>
>>> If not, I'm really wondering if the CCSR ought to be a device in its
>>> own right, rather than just a container memory region used within the=

>>> machine.
>>
>> I don't think I follow what you mean by "device" in this context?
>> The CCSR object is a SysBusDevice in the qom tree ("/machine/e500-ccsr=
").
>> What device-like characteristics could it have?
>=20
> Sorry, I wasn't clear.  the CCSR definitely *is* a device in the
> current scheme, but I'm wondering if that was a good idea.

I think I see what you're getting at.  You're right that CCSR
isn't a "device" in the same sense as eg. a UART.  In my mind
it's more like a PCI host bridge, having a few registers itself,
though serving mainly to route to the devices behind it.

I see the CCSR "device" as the bridge onto the system bus.
In some ways it might be considered to be the only device
on the system bus apart from the CPU(s).  This "device"
handles first level routing of physical addresses to
RAM, PCI, or local bus via the LAWBAR* registers (unmodeled).
Or to the I/O devices in the CCSR range via CCSRBAR.

I don't have plans to model that LAWBAR* registers,
as it hasn't proved necessary for RTEMS or Linux guests.
I have considered how this could be done as Linux does
touch these registers, but doesn't readback/check the
values it has written.  I think having a CCSR "device"
would make it simpler to model the local windows
should this become desirable.  eg. if Linux starts
validating LAWBAR* or to run unmodified u-boot.


--693Agu127LQxDIOQ3QIksqBWSNhJmlALO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEYyRdrpxuENu06SOrlAHmyz1/GOoFAlpDGR8ACgkQlAHmyz1/
GOpktg//an6+45iHW9LS2wOfUOcVvCY7JRYPhBBC3asKtdZ3mef2nY4TuzEKIG3P
zf7bDFD4zdIn27jjomzccxf1UosVE8/LI0ZlbhpNRvrYxMV+rG4VQV6lXsZBQDhE
+SQbu1FV1+mnJPE+bWM7mAsQL8x7VY4aGtbIWUDK4gOQ8yc5AfUpTQF6KqGVM6Nf
ftD5PvaA6RGWGgp8PXk0nEb8a7Z/2Nh3y3eFeBxk4pgLX83i7CSF74lFqKjflf42
tgOT+tAB+TB+yffQ30XUmA+hxSAm9Z007zbz4sDHEWhf8BnmO3BlJe6z+7Q/bUWi
02AoX1SU/iacb/+C5C8rphu4fBpELm6JGcA1vWgh3Ar2RlFiDs060lui7PiOZHGj
mXxLe/pAwBOnD1tz2SABuMsYp8E9B6dJPhDjOdHbXMfrue19e9hU3FpLoYU8eyXJ
FzE+u+96FFUX82LdTP+w76HqEH3GVLugNTtZSF9OyIhEPjkTaDpU611w4Rfrwe7v
zNVkn+RhHjNT/xClpYLzKfI/n1dFaWAYdRUaZlulFyZxqG4XAONL9GUJ6vFlCAB3
3lYSsgnW3P/wNdrMBO7UkvXEQ9qCz7KUXqShli55yoiHXrEj1h+yPQ788veDly7x
7T4ccQIKEzp1q71LyHwuE/cezNLS/OZMgrEK90wQr6sQqTr2RVk=
=gPPI
-----END PGP SIGNATURE-----

--693Agu127LQxDIOQ3QIksqBWSNhJmlALO--
