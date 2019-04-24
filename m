Received: from eggs.gnu.org ([209.51.188.92]:42233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mkletzan@redhat.com>) id 1hJDrU-0003DM-Kh
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mkletzan@redhat.com>) id 1hJDpD-0004FI-FK
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:04:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mkletzan@redhat.com>) id 1hJDp9-0004BY-Qm
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:04:19 -0400
Date: Wed, 24 Apr 2019 11:04:04 +0200
From: Martin Kletzander <mkletzan@redhat.com>
Message-ID: <20190424090404.GA7640@wheatley>
References: <20190423113028.GD30014@wheatley>
	<20190423121218.GF9041@localhost.localdomain>
	<20190423142648.GA2967@wheatley>
	<20190423150845.GG9041@localhost.localdomain>
	<aeb62174-5aad-676e-792d-e71d694dbd1e@virtuozzo.com>
	<20190424071917.GA15891@linux.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <20190424071917.GA15891@linux.fritz.box>
Subject: Re: [Qemu-devel] Possibly incorrect data sparsification by qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Jones <rjones@redhat.com>


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Apr 24, 2019 at 09:19:17AM +0200, Kevin Wolf wrote:
>Am 24.04.2019 um 08:40 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 23.04.2019 18:08, Kevin Wolf wrote:
>> > Am 23.04.2019 um 16:26 hat Martin Kletzander geschrieben:
>> >> On Tue, Apr 23, 2019 at 02:12:18PM +0200, Kevin Wolf wrote:
>> >>> Am 23.04.2019 um 13:30 hat Martin Kletzander geschrieben:
>> >>>> Hi,
>> >>>>
>> >>>> I am using qemu-img with nbdkit to transfer a disk image and the update it with
>> >>>> extra data from newer snapshots.  The end image cannot be transferred because
>> >>>> the snapshots will be created later than the first transfer and we want to save
>> >>>> some time up front.  You might think of it as a continuous synchronisation.  It
>> >>>> looks something like this:
>> >>>>
>> >>>> I first transfer the whole image:
>> >>>>
>> >>>>   qemu-img convert -p $nbd disk.raw
>> >>>>
>> >>>> Where `$nbd` is something along the lines of `nbd+unix:///?socket=nbdkit.sock`
>> >>>>
>> >>>> Then, after the next snapshot is created, I can update it thanks to the `-n`
>> >>>> parameter (the $nbd now points to the newer snapshot with unchanged data looking
>> >>>> like holes in the file):
>> >>>>
>> >>>>   qemu-img convert -p -n $nbd disk.raw
>> >>>>
>> >>>> This is fast and efficient as it uses block status nbd extension, so it only
>> >>>> transfers new data.
>> >>>
>> >>> This is an implementation detail. Don't rely on it. What you're doing is
>> >>> abusing 'qemu-img convert', so problems like what you describe are to be
>> >>> expected.
>> >>>
>> >>>> This can be done over and over again to keep the local
>> >>>> `disk.raw` image up to date with the latest remote snapshot.
>> >>>>
>> >>>> However, when the guest OS zeroes some of the data and it gets written into the
>> >>>> snapshot, qemu-img scans for those zeros and does not write them to the
>> >>>> destination image.  Checking the output of `qemu-img map --output=json $nbd`
>> >>>> shows that the zeroed data is properly marked as `data: true`.
>> >>>>
>> >>>> Using `-S 0` would write zeros even where the holes are, effectively overwriting
>> >>>> the data from the last snapshot even though they should not be changed.
>> >>>>
>> >>>> Having gone through some workarounds I would like there to be another way.  I
>> >>>> know this is far from the typical usage of qemu-img, but is this really the
>> >>>> expected behaviour or is this just something nobody really needed before?  If it
>> >>>> is the former, would it be possible to have a parameter that would control this
>> >>>> behaviour?  If the latter is the case, can that behaviour be changed so that it
>> >>>> properly replicates the data when `-n` parameter is used?
>> >>>>
>> >>>> Basically the only thing we need is to either:
>> >>>>
>> >>>> 1) write zeros where they actually are or
>> >>>>
>> >>>> 2) turn off explicit sparsification without requesting dense image (basically
>> >>>>     sparsify only the par that is reported as hole on the source) or
>> >>>>
>> >>>> 3) ideally, just FALLOC_FL_PUNCH_HOLE in places where source did report data,
>> >>>>     but qemu-img found they are all zeros (or source reported HOLE+ZERO which, I
>> >>>>     believe, is effectively the same)
>> >>>>
>> >>>> If you want to try this out, I found the easiest reproducible way is using
>> >>>> nbdkit's data plugin, which can simulate whatever source image you like.
>> >>>
>> >>> I think what you _really_ want is a commit block job. The problem is
>> >>> just that you don't have a proper backing file chain, but just a bunch
>> >>> of NBD connections.
>> >>>
>> >>> Can't you get an NBD connection that already provides the condensed form
>> >>> of the whole snapshot chain directly at the source? If the NBD server
>> >>> was QEMU, this would actually be easier than providing each snapshot
>> >>> individually.
>> >>>
>> >>> If this isn't possible, I think you need to replicate the backing chain
>> >>> on the destination instead of converting into the same image again and
>> >>> again so that qemu-img knows that it must take existing data of the
>> >>> backing file into consideration:
>> >>>
>> >>>     qemu-img convert -O qcow2 nbd://... base.qcow2
>> >>>     qemu-img convert -O qcow2 -F qcow2 -B base.qcow2 nbd://... overlay1.qcow2
>> >>>     qemu-img convert -O qcow2 -F qcow2 -B overlay1.qcow2 nbd://... overlay2.qcow2
>> >>>     ...
>>
>> Is it safe in general?
>>
>> Qemu often consider rounding-up allocated ranges to be safe, or just
>> consider unknown area as allocated.  And if this happen, we'll convert
>> unallocated hole to allocated zeroes on target, which will break
>> backing chain.
>>
>> This way would be correct if on source under nbd server we have valid
>> backing chain too, so in case of "rounding-up" we'll just read valid
>> data from backing. But it is not the case (or sorry, if I
>> misunderstood).
>
>As I said, it depends on the NBD server providing the right block
>allocation status - and this includes alignment etc. as well.
>
>It's not a very nice solution because NBD doesn't actually do backing
>fields, so we're relying on things that the spec doesn't talk about. But

That is what I was concerned about, if I understand correctly there is no
concept of backing chains in the NBD protocol.

>as I understand, we don't have control over the server side, so it's
>probably the best we can do under these conditions.
>
>If the NBD server already took the backing chain into consideration, it
>would indeed be much more reliable.
>

We *kind of* have control over the server.  The nbd server is nbdkit in which we
can make sure does the right thing, however making it open the local file as
backing is something that does not really fit in the design, or at least not
yet.

But we can make sure the provided data is correct even for unallocated areas
because the backing chain we replicated is present on the source.  Reading
couple more blocks is still a major improvement over reading all the data.

I tried your solution and it works nicely, even though it consumes more data
then needed.  I'm guessing this could be at least partially avoided by using
internal snapshots, if that was supported with `convert`, but that's not really
needed.  This is more than enough and, as more of us said, this usage is kind of
an abuse of what qemu-img is designed to do.

Thanks everyone for all the help!

Martin

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiXAnXDYdKAaCyvS1CB/CnyQXht0FAlzAJoQACgkQCB/CnyQX
ht0lwBAAkX8QsOHk0+6sKg6PSyHn8zsrllP0CatzgMfjKCfBCoXrY1ayq0lp+SNY
lFxMUHhwB9FU8qagSyhozTncCH12F9N3uvwFvihGSDFZOZlD1MjbPVUTncXlDKj3
jnKuZWC2kvDXdlKkrw/ZZyVmyK8oJp0w0YP0WIifK9YQim6yhQ7/B4MqjqOba/2z
BXsQAE1JzQQ7gRU93CVAXijABkd+8iZX4r+TfCJLo8M+/IMNZPVnzUbomI62H6nR
a9l5reQdReanwX9TliksUehg7Uh4JXYjCAFgftdCFyet+4Sr58CbNiMALogChGK1
Kk+GKaHPgh5br1tJ4/m8e8u+R2QZKc/uUKkxD5acE3IMgTjyURArRtOBDMOwM39H
fxLOkgHgDgZl53KHRFWvLY30PxwYZsnDhbFRgHXAFRGArhXI1gydc7REfLm43d7D
DuxcQQhJeuFVSOIlCuPhqgmnUsdlbJwOe0dLWjV371GZaQ6o1YFiY3tUEaRF6y4C
L5cblavs/9AdoB68qHVF8nzl5kzRmEHv1wWdWXnHXb769KS1A0gSoAK9+nWvODpO
3nom501msOVXuPJ00c86LdlvAJU3xY4UFexYi3ay1PjgVCiDRKKOWayJXkw/6Rxb
MlvDzMsjSWCaMCZewJVI05C9tcjiK0e87GA5KsEamZ1beMPQnNg=
=pN/c
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
