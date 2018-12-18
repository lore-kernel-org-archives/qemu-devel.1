Received: from eggs.gnu.org ([2001:4830:134:3::10]:51397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gZDb7-0002XB-Rj
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:31:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gZDb2-0004TQ-1c
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:31:37 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <mailman.30045.1545053429.1282.qemu-devel@nongnu.org>
Date: Tue, 18 Dec 2018 06:31:28 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <CB38AD4F-062E-4E35-82E7-4C53063B1F9E@gmail.com>
References: <mailman.30045.1545053429.1282.qemu-devel@nongnu.org>
Subject: Re: [Qemu-devel] [PATCH 2/3] mac_newworld: enable access to EDID
 data for the VGA device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-ppc <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>


> On 12/12/2018 13:38, Gerd Hoffmann wrote:
>=20
>> On Wed, Dec 12, 2018 at 08:54:37AM +0000, Mark Cave-Ayland wrote:
>>> On 12/12/2018 08:32, Gerd Hoffmann wrote:
>>>=20
>>>> On Fri, Dec 07, 2018 at 04:08:05PM +0000, Mark Cave-Ayland wrote:
>>>>> This is in preparation for some upcoming QEMU NDRV driver changes =
that pass
>>>>> display information from the host to the guest.
>>>>=20
>>>>> -    pci_vga_init(pci_bus);
>>>>> +    dev =3D qdev_create(BUS(pci_bus), "VGA");
>>>>> +    qdev_prop_set_int32(dev, "addr", -1);
>>>>> +    qdev_prop_set_bit(dev, "edid", true);
>>>>> +    qdev_init_nofail(dev);
>>>>=20
>>>> Hmm.  IMO you should not overwrite the device defaults here.
>>>>=20
>>>> edid is off by default only because it is new and I'm conservative.
>>>> I want a release (or two) with it being available for user testing.
>>>> If no issues pop up flip it to default on.
>>>=20
>>> Oh, okay. I already have some unreleased guest code that makes use =
of this, so my
>>> questions would be: how can EDID be enabled from the command line =
for in-built VGA
>>> devices,
>>=20
>> "-global VGA.edid=3Don" should do.
>>=20
>>> and how do I detect whether EDID support is present from the guest?
>>=20
>> Check whenever the header is present.  The edid blob has a fixed 8 =
byte
>> header (00 FF FF FF FF FF FF 00).  The linux kernel driver is lazy =
and
>> checks the first two bytes only.
>>=20
>>> Otherwise a guest driver that assumes it is always present and tries
>>> to read from that area of memory will crash.
>>=20
>> Oh, reading should work no matter what.  You just don't find valid =
edid
>> data there if it is turned off.
>=20
> Thanks for the info. My current use case for this is passing a set of =
possible guest
> display resolutions from the host to the guest driver, rather than =
using an internal
> hard-coded list. I guess that over time QEMU could become "smarter" =
about building
> the list of supported resolutions depending upon the capabilities of =
the host?

Would could have both a hard-coded list and resolutions supported by the =
host.=20
