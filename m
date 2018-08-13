Received: from eggs.gnu.org ([2001:4830:134:3::10]:48374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp1pj-0003h3-TD
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 21:39:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp1pi-0004Bg-KK
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 21:39:47 -0400
References: <20180810062647.23211-1-lbloch@janustech.com>
	<20180810062647.23211-7-lbloch@janustech.com>
	<w5136vm8m8u.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ca79bbff-163b-f50e-e17b-54d6597e6bfe@redhat.com>
Date: Mon, 13 Aug 2018 03:39:35 +0200
MIME-Version: 1.0
In-Reply-To: <w5136vm8m8u.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7sUzTq00pd3AHYR8qJHSNw7sTvxR7nGAB"
Subject: Re: [Qemu-devel] [PATCH v7 6/9] qcow2: Increase the default upper
 limit on the L2 cache size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7sUzTq00pd3AHYR8qJHSNw7sTvxR7nGAB
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, Leonid Bloch <lbloch@janustech.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <ca79bbff-163b-f50e-e17b-54d6597e6bfe@redhat.com>
Subject: Re: [PATCH v7 6/9] qcow2: Increase the default upper limit on the L2
 cache size
References: <20180810062647.23211-1-lbloch@janustech.com>
 <20180810062647.23211-7-lbloch@janustech.com>
 <w5136vm8m8u.fsf@maestria.local.igalia.com>
In-Reply-To: <w5136vm8m8u.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-10 14:00, Alberto Garcia wrote:
> On Fri 10 Aug 2018 08:26:44 AM CEST, Leonid Bloch wrote:
>> The upper limit on the L2 cache size is increased from 1 MB to 32 MB.
>> This is done in order to allow default full coverage with the L2 cache=

>> for images of up to 256 GB in size (was 8 GB). Note, that only the
>> needed amount to cover the full image is allocated. The value which is=

>> changed here is just the upper limit on the L2 cache size, beyond whic=
h
>> it will not grow, even if the size of the image will require it to.
>>
>> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
>=20
> Reviewed-by: Alberto Garcia <berto@igalia.com>
>=20
>> -#define DEFAULT_L2_CACHE_MAX_SIZE (1 * MiB)
>> +#define DEFAULT_L2_CACHE_MAX_SIZE (32 * MiB)
>=20
> The patch looks perfect to me now and I'm fine with this change, but
> this is quite an increase from the previous default value. If anyone
> thinks that this is too aggressive (or too little :)) I'm all ears.

This is just noise from the sidelines (so nothing too serious), but
anyway, I don't like it very much.

My first point is that the old limit doesn't mean you can only use 8 GB
qcow2 images.  You can use more, you just can't access more than 8 GB
randomly.  I know I'm naive, but I think that the number of use cases
where you need random IOPS spread out over more than 8 GB of an image
are limited.

My second point is that qemu still allocated 128 MB of RAM by default.
Using 1/4th of that for every qcow2 image you attach to the VM seems a
bit much.

Now it gets a bit complicated.  This series makes cache-clean-interval
default to 10 minutes, so it shouldn't be an issue in practice.  But one
thing to note is that this is a Linux-specific feature, so on every
other system, this really means 32 MB per image.  (Also, 10 minutes
means that whenever I boot up my VM with a couple of disks with random
accesses all over the images during boot, I might end up using 32 MB per
image again (for 10 min), even though I don't really need that performanc=
e.)

Now if we really rely on that cache-clean-interval, why not make it
always cover the whole image by default?  I don't really see why we
should now say "256 GB seems reasonable, and 32 MB doesn't sound like
too much, let's go there".  (Well, OK, I do see how you end up using 32
MB as basically a safety margin, where you'd say that anything above it
is just unreasonable.)

Do we update the limit in a couple of years again because people have
more RAM and larger disks then?  (Maybe we do?)

My personal opinion is this: Most users should be fine with 8 GB of
randomly accessible image space (this may be wrong).  Whenever a user
does have an application that uses more than 8 GB, they are probably in
an area where they want to do some performance tuning anyway.  Requiring
them to set l2-cache-full in that case seems reasonable to me.  Pushing
the default to 256 GB to me looks a bit like just letting them run into
the problem later.  It doesn't solve the issue that you need to do some
performance tuning if you have a bit of a special use case (but maybe
I'm wrong and accessing more than 8 GB randomly is what everybody does
with their VMs).

(Maybe it's even a good thing to limit it to a smaller number so users
run into the issue sooner than later...)

OTOH, this change means that everyone on a non-Linux system will have to
use 32 MB of their RAM per qcow2 image, and everyone on a Linux system
will potentially use it e.g. during boot when you do access a lot
randomly (even though the performance usually is not of utmost
importance then (important, but not extremely so)).  But then again,
this will probably only affect a single disk (the one with the OS on
it), so it won't be too bad.

So my stance is:

(1) Is it really worth pushing the default to 256 GB if you probably
have to do a bit of performance tuning anyway when you get past 8 GB
random IOPS?  I think it's reasonable to ask users to use l2-cache-full
or adjust the cache to their needs.

(2) For non-Linux systems, this seems to really mean 32 MB of RAM per
qcow2 image.  That's 1/4th of default VM RAM.  Is that worth it?

(3) For Linux, I don't like it much either, but that's because I'm
stupid.  The fact that if you don't need this much random I/O only your
boot disk may cause a RAM usage spike, and even then it's going to go
down after 10 minutes, is probably enough to justify this change.


I suppose my moaning would subside if we only increased the default on
systems that actually support cache-clean-interval...?

Max


PS: I also don't quite like how you got to the default of 10 minutes of
the cache-clean-interval.  You can't justify using 32 MB as the default
cache size by virtue of "We have a cache-clean-interval now", and then
justify a CCI of 10 min by "It's just for VMs which sit idle".

No.  If you rely on CCI to be there to make the cache size reasonable by
default for whatever the user is doing with their images, you have to
consider that fact when choosing a CCI.

Ideally we'd probably want a soft and a hard cache limit, but I don't
know...

(Like, a soft cache limit of 1 MB with a CCI of 10 min, and a hard cache
limit of 32 MB with a CCI of 1 min by default.  So whenever your cache
uses more than 1 MB of RAM, your CCI is 1 min, and whenever it's below,
your CCI is 10 min.)


--7sUzTq00pd3AHYR8qJHSNw7sTvxR7nGAB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAltw4VcACgkQ9AfbAGHV
z0AKhwgAnZ3LEG22BpY2jB8oBx3JZPerVh+ZZnOw3GRXw7Rpcb7CHGzfUzEHFSJh
iCDP5KImWfp3gwcHsLlHMVHaLjTplRNObKLpiiGtdx6a8lfJbUwvuHAfiPZuKrw1
xjcI1EX0cGxH2ODf+i0ifateVdig98EvSR3JT0niynL9gg55FgkMdKPyyYd1xojT
x6ssLy/jPuVLaqPwxbW3eJ6/OQKCIGxGuAvzRv+WI0M43AOmzesSN4is1s6fs8z5
7bx2qibkYWxD7J8tfS00taP9mKDKxit4RQEUh7WP3OwLNRbGCUumLxpB5U5v5E1S
9Spob2ai3H4lQhPLOyTstBVP9LWMrg==
=V2AT
-----END PGP SIGNATURE-----

--7sUzTq00pd3AHYR8qJHSNw7sTvxR7nGAB--
