Received: from eggs.gnu.org ([209.51.188.92]:38017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gx5oU-0006XO-0C
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:04:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gx5oS-0001JG-8i
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:04:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gx5oR-0001Ao-L4
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:04:04 -0500
References: <B9D713FC-5896-4923-9788-AF7EAA9B462D@oberlin.edu>
	<ab1a67c0-8872-6e22-fc70-946bbcabb8a1@redhat.com>
	<BD5AEBD4-0B91-4756-B8D6-C0E643CF1F42@oberlin.edu>
	<87ftsl2clg.fsf@dusky.pond.sub.org>
	<91720BD9-D5A6-4457-BC99-D2132550BEDA@oberlin.edu>
	<87ef84z4v6.fsf@dusky.pond.sub.org>
	<62E7EC09-CB88-4802-9D28-45B06C020614@oberlin.edu>
	<87imxfssq1.fsf@dusky.pond.sub.org>
	<E3178A67-9CFC-4CD5-921F-4EE5CCB46F62@oberlin.edu>
	<87y36boe78.fsf@dusky.pond.sub.org>
	<fdec6838-6051-427d-6192-f68a76171915@redhat.com>
	<FBD3F2EA-638A-4B52-826B-7307B1D821C9@oberlin.edu>
	<877edsqnfx.fsf@dusky.pond.sub.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a68c1b31-2e40-d69d-4f01-9b7a004070b9@redhat.com>
Date: Fri, 22 Feb 2019 09:03:45 +0100
MIME-Version: 1.0
In-Reply-To: <877edsqnfx.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Testing sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Stephen Checkoway <stephen.checkoway@oberlin.edu>
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org

On 02/22/19 08:42, Markus Armbruster wrote:
> Stephen Checkoway <stephen.checkoway@oberlin.edu> writes:
>=20
>>> On Feb 20, 2019, at 03:55, Laszlo Ersek <lersek@redhat.com> wrote:
>>>
>>> I would strongly prefer if the guest-side view wouldn't change at all=
.
>>
>> It sounds like sector protection isn't something you want and it's not
>=20
> L=C3=A1szl=C3=B3 is content with the status quo, but I'm not.

I think that's an accurate description. It means that I don't personally
pursue cleaning up this stuff. Obviously I'm also not trying to prevent
a cleanup! The only things I'd like to prevent are (a) regressions, (b)
introducing a version dependency between QEMU and OVMF in this area.

In the past we've dealt with similar issues via feature negotiation, as
long as the feature can be dynamically configured in the guest.
Unfortunately, pflash size / structure are one set of things that the
firmware can't configure dynamically.

>> something I currently need so unless that changes, I probably won't do
>> anything with it.
>=20
> Pity.
>=20
>> My goal is merely to implement some missing flash functionality that I
>> need to emulate some hardware that I have. My plan for doing this is
>> to not change any defaults (except for a few bug fixes) while doing
>> so. I'm happy for the qemu community to take as much or as little as
>> it finds useful.
>=20
> Understand.
>=20
>> I'll send a patch series for review in the normal fashion, but if
>> anyone wants to see my in-progress work, including tests, the diff is
>> available here
>> <https://github.com/qemu/qemu/compare/master...stevecheckoway:pflash02=
>.
>>
>> For my own edification, I'm curious how you're currently dealing with
>> some regions of flash that are protected. I believe Markus mentioned
>> using multiple flash devices. Are you overlapping the address ranges?
>=20
> UEFI wants to store some persistent state in flash memory.  Real PCs
> have a single flash chip with a suitable part configured to be writable
> for firmware.
>=20
> Since our flash device models can't do that (yet?), we worked around th=
e
> missing functionality by exposing two separate flash chips to guests,
> one read-only, one writable for firmware.  The two are adjacent, no gap=
,
> with the boundary aligned to 4KiB (page size).
>=20
> Our track record for doing whatever real hardware does has been okay.
> The track record for our own good-enough inventions less so.  I'm not
> claiming this one is about to explode into our faces.  Still, I'd like
> to clean it up if practical.  If not for PCs (say because complications
> for OVMF render that less than practical), then at least for other, les=
s
> encumbered machines.
>=20
> Would be nice if you could pitch in a bit.
>=20
> Way, way more than you ever wanted to know on configuring flash for PCs=
:
>=20
>     Subject: Configuring pflash devices for OVMF firmware
>     Message-ID: <87y378n5iy.fsf@dusky.pond.sub.org>
>     https://lists.nongnu.org/archive/html/qemu-devel/2019-01/msg06606.h=
tml
>=20
>> The current pflash_cfi02.c code assumes, but doesn't check that both
>> the total size of the chip as well as the size of each sector is a
>> power of two. If you wanted say 7 MB of read/write flash and 1 MB of
>> read-only flash, qemu might be willing to create a device with say 7
>> MB of storage, but it will definitely misbehave. (I added a check for
>> that here
>> <https://github.com/qemu/qemu/compare/master...stevecheckoway:pflash02=
#diff-d33881bd0ef099e2f46ebd4797c653bcR738>.)
>=20
> Awesome.  The magic setup code in hw/i386/pc_sysfw.c will happily creat=
e
> any size that's a multiple of 4KiB.  The current sizes are 128KiB
> writable (power of two, good) and 2MiB - 128KiB for read-only (very muc=
h
> not a power of two, possibly bad).

Correct, wrt. the images shipped in Fedora. The upstream edk2/OVMF
default (also used in RHEL) is 528KB + 3568KB =3D 4MB. Upstream also
supports building for 128KB + 896KB =3D 1MB.

Thanks!
Laszlo

>=20
> Can you tell us a bit more about what exactly can go wrong?
>=20
