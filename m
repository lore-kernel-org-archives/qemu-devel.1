Received: from eggs.gnu.org ([2001:4830:134:3::10]:60581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpAwq-0000Yj-RI
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 07:23:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpAwp-0001Qy-1u
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 07:23:44 -0400
Date: Mon, 13 Aug 2018 13:23:33 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180813112333.GD4323@localhost.localdomain>
References: <20180810062647.23211-1-lbloch@janustech.com>
	<20180810062647.23211-7-lbloch@janustech.com>
	<w5136vm8m8u.fsf@maestria.local.igalia.com>
	<ca79bbff-163b-f50e-e17b-54d6597e6bfe@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <ca79bbff-163b-f50e-e17b-54d6597e6bfe@redhat.com>
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
To: Max Reitz <mreitz@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 13.08.2018 um 03:39 hat Max Reitz geschrieben:
> On 2018-08-10 14:00, Alberto Garcia wrote:
> > On Fri 10 Aug 2018 08:26:44 AM CEST, Leonid Bloch wrote:
> >> The upper limit on the L2 cache size is increased from 1 MB to 32 MB.
> >> This is done in order to allow default full coverage with the L2 cache
> >> for images of up to 256 GB in size (was 8 GB). Note, that only the
> >> needed amount to cover the full image is allocated. The value which is
> >> changed here is just the upper limit on the L2 cache size, beyond which
> >> it will not grow, even if the size of the image will require it to.
> >>
> >> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
> >=20
> > Reviewed-by: Alberto Garcia <berto@igalia.com>
> >=20
> >> -#define DEFAULT_L2_CACHE_MAX_SIZE (1 * MiB)
> >> +#define DEFAULT_L2_CACHE_MAX_SIZE (32 * MiB)
> >=20
> > The patch looks perfect to me now and I'm fine with this change, but
> > this is quite an increase from the previous default value. If anyone
> > thinks that this is too aggressive (or too little :)) I'm all ears.
>=20
> This is just noise from the sidelines (so nothing too serious), but
> anyway, I don't like it very much.
>=20
> My first point is that the old limit doesn't mean you can only use 8 GB
> qcow2 images.  You can use more, you just can't access more than 8 GB
> randomly.  I know I'm naive, but I think that the number of use cases
> where you need random IOPS spread out over more than 8 GB of an image
> are limited.

I think I can see use cases for databases that are spead across more
than 8 GB. But you're right, it's a tradeoff and users can always
increase the cache size in theory if they need more performance. But
then, they can also decrease the cache size if they need more memory.

Let's be honest: While qcow2 does have some room for functional
improvements, it mostly has an image problem, which comes from the fact
that there are cases where performance drops drastically. Benchmarks are
a very important use case and they do random I/O over more than 8 GB.

Not properly supporting such cases out-of-the-box is the reason why
people are requesting that we add features to raw images even if they
require on-disk metadata. If we want to avoid this kind of nonsense, we
need to improve the out-of-the-box experience with qcow2.

> My second point is that qemu still allocated 128 MB of RAM by default.
> Using 1/4th of that for every qcow2 image you attach to the VM seems a
> bit much.

Well, that's more because 128 MB is ridiculously low today and you won't
be able to run any recent guest without overriding the default.

> Now it gets a bit complicated.  This series makes cache-clean-interval
> default to 10 minutes, so it shouldn't be an issue in practice.  But one
> thing to note is that this is a Linux-specific feature, so on every
> other system, this really means 32 MB per image.

That's a bit inaccurate in this generality: On non-Linux, it means 32 MB
per fully accessed image with a size >=3D 256 GB.

> (Also, 10 minutes means that whenever I boot up my VM with a couple of
> disks with random accesses all over the images during boot, I might
> end up using 32 MB per image again (for 10 min), even though I don't
> really need that performance.)

If your system files are fragmented in a way that a boot will access
every 512 MB chunk in a 256 GB disk, you should seriously think about
fixing that...

This is a pathological case that shouldn't define our defaults. Random
I/O over 256 GB is really a pathological case, too, but people are
likely to actually test it. They aren't going to systematically test a
horribly fragmented system that wouldn't happen in reality.

> Now if we really rely on that cache-clean-interval, why not make it
> always cover the whole image by default?  I don't really see why we
> should now say "256 GB seems reasonable, and 32 MB doesn't sound like
> too much, let's go there".  (Well, OK, I do see how you end up using 32
> MB as basically a safety margin, where you'd say that anything above it
> is just unreasonable.)
>=20
> Do we update the limit in a couple of years again because people have
> more RAM and larger disks then?  (Maybe we do?)

Possibly. I see those defaults as values that we can adjust to reality
whenever we think the old values don't reflect the important cases well
enough any more.

> My personal opinion is this: Most users should be fine with 8 GB of
> randomly accessible image space (this may be wrong).  Whenever a user
> does have an application that uses more than 8 GB, they are probably in
> an area where they want to do some performance tuning anyway.  Requiring
> them to set l2-cache-full in that case seems reasonable to me.

In principle, I'd agree. I'd even say that management tools should
always explicitly set those options instead of relying on our defaults.
But management tools have been ignoring these options for a long time
and keep doing so.

And honestly, if you can't spend a few megabytes for the caches, it's
just as reasonable that you should set l2-cache to a lower value. You'll
need some more tweaking anyway to reduce the memory footprint.

> Pushing the default to 256 GB to me looks a bit like just letting them
> run into the problem later.  It doesn't solve the issue that you need
> to do some performance tuning if you have a bit of a special use case
> (but maybe I'm wrong and accessing more than 8 GB randomly is what
> everybody does with their VMs).
>=20
> (Maybe it's even a good thing to limit it to a smaller number so users
> run into the issue sooner than later...)

Definitely not when their management tool doesn't give them the option
of changing the value.

Being slow makes qcow2 look really bad. In contrast, I don't think I've
ever heard anyone complain about memory usage of qcow2. Our choice of a
default should reflect that, especially considering that we only use
the memory on demand. If your image is only 32 GB, you'll never use more
than 4 MB of cache. And if your image is huge, but only access part of
it, we also won't use the full 32 MB.

> OTOH, this change means that everyone on a non-Linux system will have to
> use 32 MB of their RAM per qcow2 image, and everyone on a Linux system
> will potentially use it e.g. during boot when you do access a lot
> randomly (even though the performance usually is not of utmost
> importance then (important, but not extremely so)).  But then again,
> this will probably only affect a single disk (the one with the OS on
> it), so it won't be too bad.
>=20
> So my stance is:
>=20
> (1) Is it really worth pushing the default to 256 GB if you probably
> have to do a bit of performance tuning anyway when you get past 8 GB
> random IOPS?  I think it's reasonable to ask users to use l2-cache-full
> or adjust the cache to their needs.
>=20
> (2) For non-Linux systems, this seems to really mean 32 MB of RAM per
> qcow2 image.  That's 1/4th of default VM RAM.  Is that worth it?
>=20
> (3) For Linux, I don't like it much either, but that's because I'm
> stupid.  The fact that if you don't need this much random I/O only your
> boot disk may cause a RAM usage spike, and even then it's going to go
> down after 10 minutes, is probably enough to justify this change.
>=20
>=20
> I suppose my moaning would subside if we only increased the default on
> systems that actually support cache-clean-interval...?
>=20
> Max
>=20
>=20
> PS: I also don't quite like how you got to the default of 10 minutes of
> the cache-clean-interval.  You can't justify using 32 MB as the default
> cache size by virtue of "We have a cache-clean-interval now", and then
> justify a CCI of 10 min by "It's just for VMs which sit idle".
>=20
> No.  If you rely on CCI to be there to make the cache size reasonable by
> default for whatever the user is doing with their images, you have to
> consider that fact when choosing a CCI.
>=20
> Ideally we'd probably want a soft and a hard cache limit, but I don't
> know...
>=20
> (Like, a soft cache limit of 1 MB with a CCI of 10 min, and a hard cache
> limit of 32 MB with a CCI of 1 min by default.  So whenever your cache
> uses more than 1 MB of RAM, your CCI is 1 min, and whenever it's below,
> your CCI is 10 min.)

I've actually thought of something like this before, too. Maybe we
should do that. But that can be done on top of this series.

Kevin

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbcWo1AAoJEH8JsnLIjy/WAikP/0CJSSs3QOH5L0pLsDqx+nI5
vvz9X+q1hH32TOS/HaZzxXJcIDRDLANWvb2IB75y3EiQrDfauuuWFHvuvmqE/5+d
OarTU5OCPoXOhATkenduiOzbw09OLH3IiS9jF5W/fsXMOILAu3igE+aq/2K9oMZF
4jJfs8pTKUORd6uJRfMPasN4jv/u3DRyOxwNDKelhD7ZF+V3VGLqINku1JuRph6V
ITHZk5LxIKTU3Z5WZBTBq7z++WxWbSiXj0IJ831fyeJvxYulmg9bulYdAFPqtBeF
g/mRrHyMmgiOC2Tqyejxrj/CC32Jc621C4WF+c3zJKyhoFyasP/7v/DZz4lwVC2J
x4gEu0X6PR6rHe1k0h5/gckdU6H7OFj6IPgfyDsPfWZTuBuEq1n1fmzYdrB99+Vl
OfXPisAbgvKZsdksGbdcYRUJPY0+mhT6x9Ott7YSq7kJwhIw72sst15Qar5a8VN8
0tCl1hI4D1zcxlQDjclYPM1Vr3ztfohF4EUT9Vhn9mpReX9G/mZ2pkv4agTz8AXW
PEyysojl00emQ5VpkWWxN6Tc4GHLmFoTuUArqe6X6DrZNyu6LRObosjx1Oo/YSJV
HyWM9rTzr8wn4YuRU7zcaHPeekzbSwCGRUnxVBZxI6CTs51pL5d3GMZV645DBuoy
bf8kFSV5YEElTEmx38iz
=l8gM
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
