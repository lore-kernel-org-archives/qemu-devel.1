Received: from eggs.gnu.org ([2001:4830:134:3::10]:50155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1du0EY-0005x6-Nx
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 13:53:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1du0EW-0007hf-HC
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 13:53:26 -0400
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-18-mreitz@redhat.com>
	<20170918064613.GG15551@lemon.lan>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <87b2b2f4-ecc0-3436-a5af-6d2c9d858b8f@redhat.com>
Date: Mon, 18 Sep 2017 19:53:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170918064613.GG15551@lemon.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wWMLUEKf2aFSjjf26TuTIJvGb24A3g4sv"
Subject: Re: [Qemu-devel] [PATCH 17/18] qemu-io: Add background write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wWMLUEKf2aFSjjf26TuTIJvGb24A3g4sv
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <87b2b2f4-ecc0-3436-a5af-6d2c9d858b8f@redhat.com>
Subject: Re: [PATCH 17/18] qemu-io: Add background write
References: <20170913181910.29688-1-mreitz@redhat.com>
 <20170913181910.29688-18-mreitz@redhat.com>
 <20170918064613.GG15551@lemon.lan>
In-Reply-To: <20170918064613.GG15551@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-18 08:46, Fam Zheng wrote:
> On Wed, 09/13 20:19, Max Reitz wrote:
>> Add a new parameter -B to qemu-io's write command.  When used, qemu-io=

>> will not wait for the result of the operation and instead execute it i=
n
>> the background.
>=20
> Cannot aio_write be used for this purpose?

Depends.  I have been trained to dislike *_aio_*, so that's probably the
initial reason why I didn't use it.

Second, I'd have to fix aio_write before it can be used.  Currently,
this aborts:

echo 'qemu-io drv0 "aio_write -P 0x11 0 64M"' \
    | x86_64-softmmu/qemu-system-x86_64 -monitor stdio \
          -blockdev node-name=3Ddrv0,driver=3Dnull-co

because aio_write_done thinks it's a good idea to use qemu-io's
BlockBackend -- but when qemu-io is executed through the HMP, the
BlockBackend is only created for the duration of the qemu-io command
(unless there already is a BB).  So what I'd have to do is add a
blk_ref()/blk_unref() there, but for some reason I really don't like that=
=2E

So I'd probably have to give up on using -blockdev in the new iotest and
would have to use -drive again.
(Note: With if=3Dnone, it still aborts while doing the block accounting,
and I have looked long enough into it to just decide I'd go with
if=3Dvirtio instead.)

So, yes, it appears I can use aio_write, together with -drive if=3Dvirtio=

instead of -blockdev.

The remaining difference is the following: With aio_write, all writes
come from the same BlockBackend, and they are really asynchronous.
That's nice because it's like a guest behaves.

With write -B, they come from different BBs and the BB is usually
already gone when the write is completed -- or maybe destroying the BB
means that everything is flushed and thus the writes are not necessarily
asynchronous.  That doesn't seem so nice, but this behavior made me
write patch 13, so maybe it actually is a good idea to test this.

So I'm a bit torn.  On one hand it seems to be a good idea to use
aio_write because that's already there and it's good enough to simulate
a guest.  But on the other hand, write -B gives a bit more funny
behavior which in my opinion is always good for a test...

Max


--wWMLUEKf2aFSjjf26TuTIJvGb24A3g4sv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnACAISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ApBMH/jpLFJMkCkm9UZRQBd0ntoMjO645TCmz
7EJUKrKiCmblmrmYSOVVAlyA2PKKwARaPQvXiplLX3Q0MoP1u9hEyb1nwjK/dRed
ukE5tdoYDe67kDTpaXUoCGvExauNgmKnH6MfrdfHW/t9xrU9WAsjlzsAf3HFc6Hc
NUaa1Ijnw6VMQKp9uEK5xN+P3x0fkX5QRsdv+rgLrBwS17UiR/C3f6C40jjUGzhB
kKu7zAPlrxP8J9aKJGivIMJNXwl5aHOvFdKMSYnjMQnxjVsQVG05rg5zEZbOEIXa
aGH6NELl2q5AH1G1X8rtzOBtb4f2ka7LCiBmDllWHk60hak1W6HfR2o=
=4Bu5
-----END PGP SIGNATURE-----

--wWMLUEKf2aFSjjf26TuTIJvGb24A3g4sv--
