Received: from eggs.gnu.org ([2001:4830:134:3::10]:50896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er851-0007rw-4Z
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:12:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er84z-00077k-Av
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:11:59 -0500
From: Max Reitz <mreitz@redhat.com>
References: <20180226170313.8178-1-mreitz@redhat.com>
	<20180227161743.GC32480@stefanha-x1.localdomain>
	<f0f0f6a0-bf09-8561-5c81-87d38ebef168@redhat.com>
Message-ID: <2fddac03-cde4-8d83-7651-a3928398e909@redhat.com>
Date: Wed, 28 Feb 2018 21:11:32 +0100
MIME-Version: 1.0
In-Reply-To: <f0f0f6a0-bf09-8561-5c81-87d38ebef168@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Yrgk8fZGhp84PuX2QbrsdyuVoaIbIL4bs"
Subject: Re: [Qemu-devel] [RFC] qemu-img: Drop BLK_ZERO from convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Yrgk8fZGhp84PuX2QbrsdyuVoaIbIL4bs
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <2fddac03-cde4-8d83-7651-a3928398e909@redhat.com>
Subject: Re: [Qemu-devel] [RFC] qemu-img: Drop BLK_ZERO from convert
References: <20180226170313.8178-1-mreitz@redhat.com>
 <20180227161743.GC32480@stefanha-x1.localdomain>
 <f0f0f6a0-bf09-8561-5c81-87d38ebef168@redhat.com>
In-Reply-To: <f0f0f6a0-bf09-8561-5c81-87d38ebef168@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------7247C0B743E008DCC56B803C"

--------------7247C0B743E008DCC56B803C
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-02-28 19:08, Max Reitz wrote:
> On 2018-02-27 17:17, Stefan Hajnoczi wrote:
>> On Mon, Feb 26, 2018 at 06:03:13PM +0100, Max Reitz wrote:
>>> There are filesystems (among which is tmpfs) that have a hard time
>>> reporting allocation status.  That is definitely a bug in them.
>>>
>>> However, there is no good reason why qemu-img convert should query th=
e
>>> allocation status in the first place.  It does zero detection by itse=
lf
>>> anyway, so we can detect unallocated areas ourselves.
>>>
>>> Furthermore, if a filesystem driver has any sense, reading unallocate=
d
>>> data should take just as much time as lseek(SEEK_DATA) + memset().  S=
o
>>> the only overhead we introduce by dropping the manual lseek() call is=
 a
>>> memset() in the driver and a buffer_is_zero() in qemu-img, both of wh=
ich
>>> should be relatively quick.
>>
>> This makes sense.  Which file systems did you test this patch on?
>=20
> On tmpfs and xfs, so far.
>=20
>> XFS, ext4, and tmpfs would be a good minimal test set to prove the
>> patch.  Perhaps with two input files:
>> 1. A file that is mostly filled with data.
>> 2. A file that is only sparsely populated with data.
>=20
> And probably with vmdk, which (by default) forbids querying any areas
> larger than 64 kB.
>=20
>> The time taken should be comparable with the time before this patch.
>=20
> Yep, I'll do some benchmarks.

And the results are in.  I've created 2 GB images on various filesystems
in various formats, then I've either written 64 kB every 32 MB to them
("sparse"), or left out 64 kB every 32 MB ("full").  Then I've converted
them to null-co:// and took the (real) time through "time". (Script is
attached.)

I've attached the raw results before and after this patch.  Usually, I
did six runs for each case and dropped the most extreme outlier --
except for full vmdk images, where I've only done one run for each case
because creating these images can take a very long time.

Here are the differences from before to after:

sparse raw on tmpfs:    + 19 % (436 ms to 520 ms)
sparse qcow2 on tmpfs:  - 31 % (435 ms to 301 ms)
sparse vmdk on tmpfs:   + 37 % (214 ms to 294 ms)

sparse raw on xfs:      + 69 % (452 ms to 762 ms)
sparse qcow2 on xfs:    - 34 % (462 ms to 304 ms)
sparse vmdk on xfs:     + 42 % (210 ms to 298 ms)

sparse raw on ext4:     +360 % (144 ms to 655 ms)
sparse qcow2 on ext4:   +120 % (147 ms to 330 ms)
sparse vmdk on ext4:    + 16 % (253 ms to 293 ms)


full raw on tmpfs:      -  9 % (437 ms to 398 ms)
full qcow2 on tmpfs:    - 75 % (1.63 s to 403 ms)
full vmdk on tmpfs:     -100 % (10 min to 767 ms)

full raw on xfs:        -  1 % (407 ms to 404 ms, insignificant)
full qcow2 on xfs:      -  1 % (410 ms to 404 ms, insignificant)
full vmdk on xfs:       - 33 % (1.05 s to 695 ms)




full raw on ext4:       -  2 % (308 ms to 301 ms, insignificant)
full qcow2 on ext4:     +  2 % (307 ms to 312 ms, insignificant)
full vmdk on ext4:      - 74 % (3.53 s to 839 ms)


So...  It's more extreme than I had hoped, that's for sure.  What I
conclude from this is:

(1) This patch is generally good for nearly fully allocated images.  In
the worst case (on well-behaving filesystems with well-optimized image
formats) it changes nothing.  In the best case, conversion time is
reduced drastically.

(2) For sparse raw images, this is absolutely devastating.  Reading them
now takes more than (ext4) or nearly (xfs) twice as much time as reading
a fully allocated image.  So much for "if a filesystem driver has any
sense".

(2a) It might be worth noting that on xfs, reading the sparse file took
longer even before this patch...

(3) qcow2 is different: It benefits from this patch on tmpfs and xfs
(note that reading a sparse qcow2 file took longer than reading a full
qcow2 file before this patch!), but it gets pretty much destroyed on
ext4, too.

(4) As for sparse vmdk images...  Reading them takes longer, but it's
still fasster than reading full vmdk images, so that's not horrible.


So there we are.  I was wrong about filesystem drivers having any sense,
so this patch can indeed have a hugely negative impact.

I would argue that conversion time for full images is more important,
because that's probably the main use case; but the thing is that here
this patch only helps for tmpfs and vmdk.  We don't care too much about
vmdk, and the fact that tmpfs takes so long simply is a bug.

I guess the xfs/tmpfs results would still be in a range where they are
barely acceptable (because it's mainly a qcow2 vs. raw tradeoff), but
the ext4 horrors probably make this patch a no-go in its current form.

In any case it's interesting to see that even the current qemu-img
convert takes longer to read sparsely allocated qcow2/raw files from xfs
than fully allocated images...


So I guess I'll re-send this patch where the change is done only for
-S 0.

Max

--------------7247C0B743E008DCC56B803C
Content-Type: application/x-shellscript;
 name="test.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="test.sh"

IyEvYmluL3NoCgpmb3JtYXQ9JDEKcGxhY2U9JDIKYWxsb2M9JDMKCi4vcWVtdS1pbWcgY3Jl
YXRlIC1mICRmb3JtYXQgIiRwbGFjZS90ZXN0LiRmb3JtYXQiIDJHID4gL2Rldi9udWxsCgpp
ZiBbICIkYWxsb2MiID0gInNwYXJzZSIgXTsgdGhlbgogICAgZm9yIHBvcyBpbiAkKHNlcSAw
IDMyIDIwNDgpOyBkbwogICAgICAgIC4vcWVtdS1pbyAtYyAid3JpdGUgLVAgNDIgJHtwb3N9
TSA2NEsiIFwKICAgICAgICAgICAgLWYgJGZvcm1hdCAiJHBsYWNlL3Rlc3QuJGZvcm1hdCIg
PiAvZGV2L251bGwKICAgIGRvbmUKZWxzZQogICAgZm9yIHBvcyBpbiAkKHNlcSAwIDMyIDIw
NDgpOyBkbwogICAgICAgIC4vcWVtdS1pbyAtYyAid3JpdGUgLVAgNDIgJCgocG9zICogMTAy
NCArIDY0KSlLICQoKDMyICogMTAyNCAtIDY0KSlLIiBcCiAgICAgICAgICAgIC1mICRmb3Jt
YXQgIiRwbGFjZS90ZXN0LiRmb3JtYXQiID4gL2Rldi9udWxsCiAgICBkb25lCmZpCgp0aW1l
IC4vcWVtdS1pbWcgY29udmVydCAtZiAkZm9ybWF0IC1uIC0tdGFyZ2V0LWltYWdlLW9wdHMg
XAogICAgIiRwbGFjZS90ZXN0LiRmb3JtYXQiIGRyaXZlcj1udWxsLWNvLHNpemU9MkcKCnJt
IC1mICIkcGxhY2UvdGVzdC4kZm9ybWF0Igo=
--------------7247C0B743E008DCC56B803C
Content-Type: text/plain; charset=UTF-8;
 name="test-before"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="test-before"

Testing: raw on tmpfs (sparse): 0.436 =C2=B10.012
real    0.426 0.444 0.447 0.442 (0.500) 0.421

Testing: qcow2 on tmpfs (sparse): 0.435 =C2=B10.018
real    0.421 0.459 0.448 0.430 (0.776) 0.415

Testing: vmdk on tmpfs (sparse): 0.214 =C2=B10.004
real    0.216 0.218 0.210 0.215 (0.222) 0.209

Testing: raw on xfs (sparse): 0.452 =C2=B10.028
real    0.430 0.468 0.493 0.442 (0.640) 0.428

Testing: qcow2 on xfs (sparse): 0.462 =C2=B10.016
real    0.445 0.475 0.478 0.445 0.466 (0.437)

Testing: vmdk on xfs (sparse): 0.210 =C2=B10.005
real    0.214 0.213 (0.222) 0.203 0.207 0.213

Testing: raw on ext4 (sparse): 0.144 =C2=B10.023
real    0.119 0.181 0.142 0.143 0.137 (0.296)

Testing: qcow2 on ext4 (sparse): 0.147 =C2=B10.016
real    0.139 0.138 0.142 0.175 0.140 (0.301)

Testing: vmdk on ext4 (sparse): 0.253 =C2=B10.004
real    0.247 (0.273) 0.257 0.252 0.254 0.254

Testing: raw on tmpfs (full): 0.437 =C2=B10.012
real    (0.477) 0.436 0.434 0.432 0.457 0.424

Testing: qcow2 on tmpfs (full): 1.630 =C2=B10.021
real    1.618 1.631 (1.684) 1.625 1.665 1.612

Testing: vmdk on tmpfs (full): 612.379 (n=3D1)
real    612.379

Testing: raw on xfs (full): 0.407 =C2=B10.011
real    0.400 0.413 0.402 (0.495) 0.424 0.397

Testing: qcow2 on xfs (full): 0.410 =C2=B10.009
real    0.403 0.406 0.413 (0.485) 0.423 0.403

Testing: vmdk on xfs (full): 1.048 (n=3D1)
real    1.048

Testing: raw on ext4 (full): 0.308 =C2=B10.007
real    0.299 (0.419) 0.315 0.311 0.301 0.314

Testing: qcow2 on ext4 (full): 0.307 =C2=B10.003
real    0.307 0.306 (0.490) 0.308 0.303 0.312

Testing: vmdk on ext4 (full): 3.528 (n=3D1)
real    3.528

--------------7247C0B743E008DCC56B803C
Content-Type: text/plain; charset=UTF-8;
 name="test-after"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="test-after"

Testing: raw on tmpfs (sparse): 0.520 =C2=B10.022
real	0.496 0.535 0.536 0.538 (0.569) 0.495

Testing: qcow2 on tmpfs (sparse): 0.301 =C2=B10.008
real	0.298 0.297 (0.338) 0.292 0.307 0.312

Testing: vmdk on tmpfs (sparse): 0.294 =C2=B10.002
real	0.295 0.294 0.292 (0.287) 0.293 0.297

Testing: raw on xfs (sparse): 0.762 =C2=B10.026
real	(0.713) 0.770 0.769 0.759 0.790 0.720

Testing: qcow2 on xfs (sparse): 0.304 =C2=B10.003
real	0.309 (0.312) 0.301 0.302 0.306 0.304

Testing: vmdk on xfs (sparse): 0.298 =C2=B10.009
real	0.294 0.312 0.293 0.301 0.290 (0.345)

Testing: raw on ext4 (sparse): 0.655 =C2=B10.011
real    0.664 (0.624) 0.663 0.639 0.648 0.659

Testing: qcow2 on ext4 (sparse): 0.330 =C2=B10.035
real    0.293 0.333 (0.391) 0.374 0.353 0.297

Testing: vmdk on ext4 (sparse): 0.293 =C2=B10.004
real    0.290 0.289 0.293 0.297 (0.285) 0.296

Testing: raw on tmpfs (full): 0.398 =C2=B10.004
real	0.397 (0.406) 0.396 0.397 0.394 0.404

Testing: qcow2 on tmpfs (full): 0.403 =C2=B10.004
real	0.403 0.408 0.406 0.399 (0.538) 0.400

Testing: vmdk on tmpfs (full): 0.767 (n=3D1)
real    0.767

Testing: raw on xfs (full): 0.404 =C2=B10.004
real	0.411 0.402 0.401 0.402 0.402 (0.421)

Testing: qcow2 on xfs (full): 0.404 =C2=B10.004
real	0.402 (0.415) 0.410 0.401 0.401 0.404

Testing: vmdk on xfs (full): 0.695 (n=3D1)
real    0.695

Testing: raw on ext4 (full): 0.301 =C2=B10.004
real    0.304 0.303 0.305 0.299 0.296 (0.322)

Testing: qcow2 on ext4 (full): 0.312 =C2=B10.008
real    (0.325) 0.310 0.319 0.304 0.305 0.321

Testing: vmdk on ext4 (full): 0.839 (n=3D1)
real    0.839

--------------7247C0B743E008DCC56B803C--

--Yrgk8fZGhp84PuX2QbrsdyuVoaIbIL4bs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqXDPQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AHHkIALW0EwngmIF6TtKsX5bl4IY0mN6HJfZE
o/6fxwI347byWm/mLEIVi+keMV9bpMSgOiUzco2f6k9uaA78xtT5z8f+wt6i+rdP
SelzFQXp7sb6YUlhpy71TGR1zHoBegYqb7HOBqhlTzwwaq2NgvvhOyAuVjNxQGLv
nxfHdx1ncjlZyAhwlsLz8taYgTc1V3SJW+V5B6Fh6rq/eeiYE1fITJnGOC9IPtpP
8iqkNp1TQtP0jz9Od+g06sXKPqHxEVLy29jfQR1mxrJWPbgxdjnq8T2mi5fQOR9l
RJTYKA+VJzOwOqf0LzIPddl96BbA0vSB6sTjSnwwqUzYgVsC79Z+F7c=
=EiUp
-----END PGP SIGNATURE-----

--Yrgk8fZGhp84PuX2QbrsdyuVoaIbIL4bs--
