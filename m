Received: from eggs.gnu.org ([209.51.188.92]:55524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gx5Tf-0004cq-Jl
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:42:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gx5Te-0001Ul-9s
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:42:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gx5Td-0001Dy-Tf
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:42:34 -0500
From: Markus Armbruster <armbru@redhat.com>
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
Date: Fri, 22 Feb 2019 08:42:10 +0100
In-Reply-To: <FBD3F2EA-638A-4B52-826B-7307B1D821C9@oberlin.edu> (Stephen
	Checkoway's message of "Thu, 21 Feb 2019 14:57:38 -0500")
Message-ID: <877edsqnfx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Cc: Laszlo Ersek <lersek@redhat.com>, Thomas Huth <thuth@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org

Stephen Checkoway <stephen.checkoway@oberlin.edu> writes:

>> On Feb 20, 2019, at 03:55, Laszlo Ersek <lersek@redhat.com> wrote:
>>=20
>> I would strongly prefer if the guest-side view wouldn't change at all.
>
> It sounds like sector protection isn't something you want and it's not

L=C3=A1szl=C3=B3 is content with the status quo, but I'm not.

> something I currently need so unless that changes, I probably won't do
> anything with it.

Pity.

> My goal is merely to implement some missing flash functionality that I
> need to emulate some hardware that I have. My plan for doing this is
> to not change any defaults (except for a few bug fixes) while doing
> so. I'm happy for the qemu community to take as much or as little as
> it finds useful.

Understand.

> I'll send a patch series for review in the normal fashion, but if
> anyone wants to see my in-progress work, including tests, the diff is
> available here
> <https://github.com/qemu/qemu/compare/master...stevecheckoway:pflash02>.
>
> For my own edification, I'm curious how you're currently dealing with
> some regions of flash that are protected. I believe Markus mentioned
> using multiple flash devices. Are you overlapping the address ranges?

UEFI wants to store some persistent state in flash memory.  Real PCs
have a single flash chip with a suitable part configured to be writable
for firmware.

Since our flash device models can't do that (yet?), we worked around the
missing functionality by exposing two separate flash chips to guests,
one read-only, one writable for firmware.  The two are adjacent, no gap,
with the boundary aligned to 4KiB (page size).

Our track record for doing whatever real hardware does has been okay.
The track record for our own good-enough inventions less so.  I'm not
claiming this one is about to explode into our faces.  Still, I'd like
to clean it up if practical.  If not for PCs (say because complications
for OVMF render that less than practical), then at least for other, less
encumbered machines.

Would be nice if you could pitch in a bit.

Way, way more than you ever wanted to know on configuring flash for PCs:

    Subject: Configuring pflash devices for OVMF firmware
    Message-ID: <87y378n5iy.fsf@dusky.pond.sub.org>
    https://lists.nongnu.org/archive/html/qemu-devel/2019-01/msg06606.html

> The current pflash_cfi02.c code assumes, but doesn't check that both
> the total size of the chip as well as the size of each sector is a
> power of two. If you wanted say 7 MB of read/write flash and 1 MB of
> read-only flash, qemu might be willing to create a device with say 7
> MB of storage, but it will definitely misbehave. (I added a check for
> that here
> <https://github.com/qemu/qemu/compare/master...stevecheckoway:pflash02#di=
ff-d33881bd0ef099e2f46ebd4797c653bcR738>.)

Awesome.  The magic setup code in hw/i386/pc_sysfw.c will happily create
any size that's a multiple of 4KiB.  The current sizes are 128KiB
writable (power of two, good) and 2MiB - 128KiB for read-only (very much
not a power of two, possibly bad).

Can you tell us a bit more about what exactly can go wrong?
