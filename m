Received: from eggs.gnu.org ([2001:4830:134:3::10]:40702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1etbS7-0005ad-8e
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:58:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1etbS5-0001AH-LW
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:58:03 -0500
References: <20180226170313.8178-1-mreitz@redhat.com>
	<20180227161743.GC32480@stefanha-x1.localdomain>
	<f0f0f6a0-bf09-8561-5c81-87d38ebef168@redhat.com>
	<2fddac03-cde4-8d83-7651-a3928398e909@redhat.com>
	<20180306134757.GH31045@stefanha-x1.localdomain>
	<20180306173718.GK7139@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a9315872-40fa-16fe-7107-7d74e2b24e52@redhat.com>
Date: Wed, 7 Mar 2018 16:57:52 +0100
MIME-Version: 1.0
In-Reply-To: <20180306173718.GK7139@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="m7BlJf2j6VijRs7uGVtH3WnznUQowlK0d"
Subject: Re: [Qemu-devel] [RFC] qemu-img: Drop BLK_ZERO from convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m7BlJf2j6VijRs7uGVtH3WnznUQowlK0d
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <a9315872-40fa-16fe-7107-7d74e2b24e52@redhat.com>
Subject: Re: [Qemu-devel] [RFC] qemu-img: Drop BLK_ZERO from convert
References: <20180226170313.8178-1-mreitz@redhat.com>
 <20180227161743.GC32480@stefanha-x1.localdomain>
 <f0f0f6a0-bf09-8561-5c81-87d38ebef168@redhat.com>
 <2fddac03-cde4-8d83-7651-a3928398e909@redhat.com>
 <20180306134757.GH31045@stefanha-x1.localdomain>
 <20180306173718.GK7139@localhost.localdomain>
In-Reply-To: <20180306173718.GK7139@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-06 18:37, Kevin Wolf wrote:
> Am 06.03.2018 um 14:47 hat Stefan Hajnoczi geschrieben:
>> On Wed, Feb 28, 2018 at 09:11:32PM +0100, Max Reitz wrote:
>>> On 2018-02-28 19:08, Max Reitz wrote:
>>>> On 2018-02-27 17:17, Stefan Hajnoczi wrote:
>>>>> On Mon, Feb 26, 2018 at 06:03:13PM +0100, Max Reitz wrote:
>>>>>> There are filesystems (among which is tmpfs) that have a hard time=

>>>>>> reporting allocation status.  That is definitely a bug in them.
>>>>>>
>>>>>> However, there is no good reason why qemu-img convert should query=
 the
>>>>>> allocation status in the first place.  It does zero detection by i=
tself
>>>>>> anyway, so we can detect unallocated areas ourselves.
>>>>>>
>>>>>> Furthermore, if a filesystem driver has any sense, reading unalloc=
ated
>>>>>> data should take just as much time as lseek(SEEK_DATA) + memset().=
  So
>>>>>> the only overhead we introduce by dropping the manual lseek() call=
 is a
>>>>>> memset() in the driver and a buffer_is_zero() in qemu-img, both of=
 which
>>>>>> should be relatively quick.
>>>>>
>>>>> This makes sense.  Which file systems did you test this patch on?
>>>>
>>>> On tmpfs and xfs, so far.
>>>>
>>>>> XFS, ext4, and tmpfs would be a good minimal test set to prove the
>>>>> patch.  Perhaps with two input files:
>>>>> 1. A file that is mostly filled with data.
>>>>> 2. A file that is only sparsely populated with data.
>>>>
>>>> And probably with vmdk, which (by default) forbids querying any area=
s
>>>> larger than 64 kB.
>>>>
>>>>> The time taken should be comparable with the time before this patch=
=2E
>>>>
>>>> Yep, I'll do some benchmarks.
>>>
>>> And the results are in.  I've created 2 GB images on various filesyst=
ems
>>> in various formats, then I've either written 64 kB every 32 MB to the=
m
>>> ("sparse"), or left out 64 kB every 32 MB ("full").  Then I've conver=
ted
>>> them to null-co:// and took the (real) time through "time". (Script i=
s
>>> attached.)
>>>
>>> I've attached the raw results before and after this patch.  Usually, =
I
>>> did six runs for each case and dropped the most extreme outlier --
>>> except for full vmdk images, where I've only done one run for each ca=
se
>>> because creating these images can take a very long time.
>>>
>>> Here are the differences from before to after:
>>>
>>> sparse raw on tmpfs:    + 19 % (436 ms to 520 ms)
>>> sparse qcow2 on tmpfs:  - 31 % (435 ms to 301 ms)
>>> sparse vmdk on tmpfs:   + 37 % (214 ms to 294 ms)
>>>
>>> sparse raw on xfs:      + 69 % (452 ms to 762 ms)
>>> sparse qcow2 on xfs:    - 34 % (462 ms to 304 ms)
>>> sparse vmdk on xfs:     + 42 % (210 ms to 298 ms)
>>>
>>> sparse raw on ext4:     +360 % (144 ms to 655 ms)
>>> sparse qcow2 on ext4:   +120 % (147 ms to 330 ms)
>>> sparse vmdk on ext4:    + 16 % (253 ms to 293 ms)
>>>
>>>
>>> full raw on tmpfs:      -  9 % (437 ms to 398 ms)
>>> full qcow2 on tmpfs:    - 75 % (1.63 s to 403 ms)
>>> full vmdk on tmpfs:     -100 % (10 min to 767 ms)
>>>
>>> full raw on xfs:        -  1 % (407 ms to 404 ms, insignificant)
>>> full qcow2 on xfs:      -  1 % (410 ms to 404 ms, insignificant)
>>> full vmdk on xfs:       - 33 % (1.05 s to 695 ms)
>>>
>>>
>>>
>>>
>>> full raw on ext4:       -  2 % (308 ms to 301 ms, insignificant)
>>> full qcow2 on ext4:     +  2 % (307 ms to 312 ms, insignificant)
>>> full vmdk on ext4:      - 74 % (3.53 s to 839 ms)
>>>
>>>
>>> So...  It's more extreme than I had hoped, that's for sure.  What I
>>> conclude from this is:
>>>
>>> (1) This patch is generally good for nearly fully allocated images.  =
In
>>> the worst case (on well-behaving filesystems with well-optimized imag=
e
>>> formats) it changes nothing.  In the best case, conversion time is
>>> reduced drastically.
>=20
> This makes sense. Asking the kernel whether a block is zero only helps
> the performance if the result is yes occasionally, otherwise it's just
> wasted work.
>=20
> Maybe we could try to guess the ratio by comparing the number of
> allocated blocks in the image file and the virtual disk size or
> something? Then we could only call lseek() when we can actually expect
> an improvement from it.

Sounds like "qemu should not contain policy" to me.  If the user expects
the image to be fully allocated, they might as well use -S 0.

>>> (2) For sparse raw images, this is absolutely devastating.  Reading t=
hem
>>> now takes more than (ext4) or nearly (xfs) twice as much time as read=
ing
>>> a fully allocated image.  So much for "if a filesystem driver has any=

>>> sense".
>=20
> Are you sure that only the filesystem is the problem? Checking for ever=
y
> single byte of an image whether it is zero has to cost some performance=
=2E

Well, yes, but "read data location from FS metadata" + "realize it's a
hole" + memset() + "repe scasb" shouldn't take twice as much time as
"read data location from FS metadata" + "read data from SSD".

I expected the "realize it's a hole" part to fall out for free, so this
would that memset() + repe scasb take much longer than reading data from
the SSD -- and that's just pretty much impossible.

> The fully allocated image doesn't suffer from this because (a) it only
> has to check the first byte in each block and (b) the cost was already
> there before this patch.
>=20
> In fact, if null-co supported .bdrv_co_pwrite_zeroes, I think you would=

> get even worse results for your patch because then the pre-patch versio=
n
> doesn't even have to do the memset().
>=20
>>> (2a) It might be worth noting that on xfs, reading the sparse file to=
ok
>>> longer even before this patch...
>>>
>>> (3) qcow2 is different: It benefits from this patch on tmpfs and xfs
>>> (note that reading a sparse qcow2 file took longer than reading a ful=
l
>>> qcow2 file before this patch!), but it gets pretty much destroyed on
>>> ext4, too.
>=20
> I suppose an empty qcow2 with metadata preallocation behaves roughly
> like sparse raw?

Yep, more on that below.

> As long as the qcow2 metadata reflects the allocation status in the
> image file (which it probably usually does, except with preallocation),=

> it makes sense that qcow2 performs better with just relying on its
> metadata. Calling an lseek() that just returns the same result is a
> wasted effort then.
>=20
>>> (4) As for sparse vmdk images...  Reading them takes longer, but it's=

>>> still fasster than reading full vmdk images, so that's not horrible.
>=20
> Hm, why is that? Shouldn't vmdk metadata reflect the allocation status
> in the image file just as well as qcow2 metadata?
>=20
> But actually, the absolute numbers are much lower than both raw and
> qcow2, which is a bit surprising. Is there a bug somewhere in vmdk or
> are we missing optimisations in raw and qcow2?

I wondered about that, too.  Maybe something to look into another time...=


>>> So there we are.  I was wrong about filesystem drivers having any sen=
se,
>>> so this patch can indeed have a hugely negative impact.
>>>
>>> I would argue that conversion time for full images is more important,=

>>> because that's probably the main use case; but the thing is that here=

>>> this patch only helps for tmpfs and vmdk.  We don't care too much abo=
ut
>>> vmdk, and the fact that tmpfs takes so long simply is a bug.
>>>
>>> I guess the xfs/tmpfs results would still be in a range where they ar=
e
>>> barely acceptable (because it's mainly a qcow2 vs. raw tradeoff), but=

>>> the ext4 horrors probably make this patch a no-go in its current form=
=2E
>>>
>>> In any case it's interesting to see that even the current qemu-img
>>> convert takes longer to read sparsely allocated qcow2/raw files from =
xfs
>>> than fully allocated images...
>>>
>>>
>>> So I guess I'll re-send this patch where the change is done only for
>>> -S 0.
>>
>> Wow, unexpected.  Thanks for doing the benchmarks!
>=20
> ext4 is a bit surprising, yes. vmdk, too. The rest kind of makes sense
> to me.

To me it still quite doesn't...


Anyway, I wrote another variation of this which I called "greedy
block_status".  This series introduced a
bdrv_greedy_block_status_above() function which basically returns the
first "reliable" allocation information it can get: For instance, for
qcow2 images it will use only the qcow2 metadata and not descend down to
the protocol level.  However, for raw images it will go down to the
protocol because raw doesn't give any information.

The idea was that we don't want to leave the block layer unless we have
to, because we have no idea how protocols behave and whether they agree
to our notion that hole information should be available quickly.

The result looked good, but then I thought "wait, what about
preallocated qcow2 files"...  And, well...  Not good.  Here are the
benchmarks from that:

sparse raw/tmpfs:       -  3 % (0.6=CF=83)
sparse qcow2/tmpfs:     +  6 % (0.9=CF=83)
sparse vmdk/tmpfs:      -  5 % (0.7=CF=83)

sparse raw/xfs:         +  2 % (0.4=CF=83)
sparse qcow2/xfs:       +  4 % (1.0=CF=83)
sparse vmdk/xfs:        +  0 % (0.1=CF=83)

sparse raw/ext4:        +  2 % (0.4=CF=83)
sparse qcow2/ext4:      =C2=B1  0 % (0.0=CF=83)
sparse vmdk/ext4:       -  0 % (0.1=CF=83)

full raw/tmpfs:         +  5 % (1.5=CF=83)
full qcow2/tmpfs:       - 71 % (> 3=CF=83) (from 1.76 s to 0.51 s)
full vmdk/tmpfs:        -100 % (n=3D1)  (from 10 min to 0.8 s)

full raw/xfs:           -  0 % (0.2=CF=83)
full qcow2/xfs:         -  1 % (1.1=CF=83)
full vmdk/xfs:          -  7 % (n=3D1)

full raw/ext4:          +  0 % (0.1=CF=83)
full qcow2/ext4:        -  0 % (1.6=CF=83)
full vmdk/ext4:         - 26 % (> 3=CF=83) (from 7.5 s to 5.6 s)

metadata qcow2/tmpfs:   +800 % (> 3=CF=83) (from 0.14 s to 1.25 s)
metadata qcow2/xfs:     +870 % (> 3=CF=83) (from 0.14 s to 1.34 s)
metadata qcow2/ext4:    +780 % (> 3=CF=83) (from 0.11 s to 0.98 s)


And here are some notes from the cover letter I had already written:

=3D=3D cover letter excerpt start =3D=3D

So, the results:

- The main issue before this series is relieved, you can now indeed

  convert a vmdk file from tmpfs without starving in the meantime.



- However, in exchange, converting metadata-preallocated qcow2 files now

  takes much longer than bevore.  (Same for falloc, in case you are

  wondering.)



- Apart from that, the only significant changes are that converting

  qcow2 off tmpfs got quicker, same for vmdk from ext4.





The question is now whether it is more important to bring down the

conversion time for vmdk, which is absolutely unbearable, and in

exchange bring up the conversion time for falloc/metadata preallocated

qcow2 images so something that is much larger than before, but still
much lower than if they were fully allocated (about a fourth of that).

Comparison for qcow2 on e.g. xfs:
- Sparse: from 0.569 s to 0.592 s
- preallocation=3Dmetadata: from 0.138 s to 1.339 s
- Nearly full: from 4.056 s to 4.032 s

Just for fun:
- preallocation=3Doff: from 0.162 s to 0.152 s

Interesting to see that (before this patch) it seems to take a little
longer with preallocation=3Doff than with preallocation=3Dmetadata.
(And yes, if you take enough measurements, you can see that this is a
 consistent result.)

So I wouldn't call the change for preallocated qcow2 files absolutely
horrible -- whereas the previous time for vmdk was absolutely horrible.
But qcow2 is much more important than vmdk on a buggy filesystem
(tmpfs), so there's that.

=3D=3D cover letter excerpt end =3D=3D

If anyone is still interested, I have the patches here...  But in the
end, it probably is indeed best to just do something about -S 0 and
leave the rest alone.  (And keep putting the blame on tmpfs.)

Max


--m7BlJf2j6VijRs7uGVtH3WnznUQowlK0d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqgDAASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AQLYH/i68QCG+cFboFmawl0GyCfCHtgzcSrBi
OOYzionyK/5BjqsvxoEPmzg1Mo9Dknmz7w3RZ0IbrbXX/NT26viqvVz3atHfVuV1
tw/4bVbG5u2kNAfZlgk6Rn1/TyeJzFEcROW5a/s+MFXw9CMx34fzlZn5GOgu+/d+
l+mCn5qwyIBQB8QSnrnHsWyVFnmrg7Z9jWZdAOCrnTR41aVQCvIQaaCZGUbNQiFH
FmjLqIDYAwnFhvjOrKBWEqjrRWJQTDVFwlGEXIsyEX3OMs0JcgTMxd0c6DZDMJQE
+5Rl6zPLOLDXoEAooXUIDpv/2rPiS/jrxn2nZLF88lbIChO63DlwzU4=
=YxED
-----END PGP SIGNATURE-----

--m7BlJf2j6VijRs7uGVtH3WnznUQowlK0d--
