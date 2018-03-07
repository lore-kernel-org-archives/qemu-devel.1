Received: from eggs.gnu.org ([2001:4830:134:3::10]:59503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1etcmR-0001By-M2
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 12:23:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1etcmQ-00062A-3I
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 12:23:07 -0500
References: <20180226170313.8178-1-mreitz@redhat.com>
	<20180227161743.GC32480@stefanha-x1.localdomain>
	<f0f0f6a0-bf09-8561-5c81-87d38ebef168@redhat.com>
	<2fddac03-cde4-8d83-7651-a3928398e909@redhat.com>
	<20180306134757.GH31045@stefanha-x1.localdomain>
	<20180306173718.GK7139@localhost.localdomain>
	<a9315872-40fa-16fe-7107-7d74e2b24e52@redhat.com>
	<20180307170521.GC7917@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <64eceb1f-c85d-e9a3-5c04-e0549bdc4ff4@redhat.com>
Date: Wed, 7 Mar 2018 18:22:47 +0100
MIME-Version: 1.0
In-Reply-To: <20180307170521.GC7917@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KNyYKue5fzS4k5a8KT1jMfcWJVlGcmD1n"
Subject: Re: [Qemu-devel] [RFC] qemu-img: Drop BLK_ZERO from convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KNyYKue5fzS4k5a8KT1jMfcWJVlGcmD1n
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <64eceb1f-c85d-e9a3-5c04-e0549bdc4ff4@redhat.com>
Subject: Re: [Qemu-devel] [RFC] qemu-img: Drop BLK_ZERO from convert
References: <20180226170313.8178-1-mreitz@redhat.com>
 <20180227161743.GC32480@stefanha-x1.localdomain>
 <f0f0f6a0-bf09-8561-5c81-87d38ebef168@redhat.com>
 <2fddac03-cde4-8d83-7651-a3928398e909@redhat.com>
 <20180306134757.GH31045@stefanha-x1.localdomain>
 <20180306173718.GK7139@localhost.localdomain>
 <a9315872-40fa-16fe-7107-7d74e2b24e52@redhat.com>
 <20180307170521.GC7917@localhost.localdomain>
In-Reply-To: <20180307170521.GC7917@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-03-07 18:05, Kevin Wolf wrote:
> Am 07.03.2018 um 16:57 hat Max Reitz geschrieben:
>> On 2018-03-06 18:37, Kevin Wolf wrote:
>>> Am 06.03.2018 um 14:47 hat Stefan Hajnoczi geschrieben:
>>>> On Wed, Feb 28, 2018 at 09:11:32PM +0100, Max Reitz wrote:
>>>>> So...  It's more extreme than I had hoped, that's for sure.  What I=

>>>>> conclude from this is:
>>>>>
>>>>> (1) This patch is generally good for nearly fully allocated images.=
  In
>>>>> the worst case (on well-behaving filesystems with well-optimized im=
age
>>>>> formats) it changes nothing.  In the best case, conversion time is
>>>>> reduced drastically.
>>>
>>> This makes sense. Asking the kernel whether a block is zero only help=
s
>>> the performance if the result is yes occasionally, otherwise it's jus=
t
>>> wasted work.
>>>
>>> Maybe we could try to guess the ratio by comparing the number of
>>> allocated blocks in the image file and the virtual disk size or
>>> something? Then we could only call lseek() when we can actually expec=
t
>>> an improvement from it.
>>
>> Sounds like "qemu should not contain policy" to me.  If the user expec=
ts
>> the image to be fully allocated, they might as well use -S 0.
>=20
> Optimising special cases isn't really what is meant when we're talking
> about having policy in qemu. The result doesn't change, but the
> performance does potentially. And as long as you access the whole image=

> like in qemu-img convert, qemu can make a pretty good estimation becaus=
e
> it knows both physical and virtual image sizes, so why bother the
> management layer with it?

Oh, I thought we should measure how long an lseek() takes and then
decide based on that.  Hm, well, yes, comparing the allocation size
would be worse thinking about.  But then it gets tricky with internal
snapshots and such...

> The thing that could be considered policy is the threshold where you
> switch from one method to the other.
>=20
>>>>> (2) For sparse raw images, this is absolutely devastating.  Reading=
 them
>>>>> now takes more than (ext4) or nearly (xfs) twice as much time as re=
ading
>>>>> a fully allocated image.  So much for "if a filesystem driver has a=
ny
>>>>> sense".
>>>
>>> Are you sure that only the filesystem is the problem? Checking for ev=
ery
>>> single byte of an image whether it is zero has to cost some performan=
ce.
>>
>> Well, yes, but "read data location from FS metadata" + "realize it's a=

>> hole" + memset() + "repe scasb" shouldn't take twice as much time as
>> "read data location from FS metadata" + "read data from SSD".
>>
>> I expected the "realize it's a hole" part to fall out for free, so thi=
s
>> would that memset() + repe scasb take much longer than reading data fr=
om
>> the SSD -- and that's just pretty much impossible.
>=20
> Not sure where you get the SSD part from. The scenarios you're comparin=
g
> are these:
>=20
> 1. Query holes with lseek() and then memset() in qemu's emulation of
>    bdrv_co_pwrite_zeroes() for drivers that don't implement it. (Which
>    is true for your null-co, but not representative for the real-world
>    use cases with an actual file-posix protocol layer. Benchmarking wit=
h
>    an extended null-co that has write_zero support would probably
>    better.)

That's before this patch for sparsely allocated images.

> 2. Uncondtionally call pread() and let the kernel do a memset(), at the=

>    cost of having to scan the buffer afterwards because qemu doesn't
>    know yet that it contains zeros.

That's after this patch for sparsely allocated images.

What I was wondering about was solely post-patch behavior, namely
sparsely vs. nearly fully allocated images.

The thing was that converting a sparsely allocated image from an SSD
took twice as much time as converting a fully allocated image.  Reading
data comes in for the fully allocated case.

The thing was that I forgot to drop the caches (and I really do want to
drop those, because they only help for my 2 GB test case, but in the
real world with 300+ GB images, they won't do much).  So, yes, I guess
what I compared was an in-memory metadata lookup + memset() +
O(n) buffer_is_zero() vs. in-memory metadata lookup + memcpy() +
O(1) buffer_is_zero().

Still leaves something to be explained (because I'd expect memset() to
be twice as fast as memcpy()), but at least it isn't completely weird.

> Neither case involves disk accesses if the filesystem metadata is
> cached. You're comparing a memset+scan to just a memset (and the more
> realistic case should be comparing memset+scan to nothing).
>=20
> (BTW, buffer_is_zero() does complicated stuff, but 'repe scasb' isn't
> among it.)

I know, that was just a simplification.

>>> The fully allocated image doesn't suffer from this because (a) it onl=
y
>>> has to check the first byte in each block and (b) the cost was alread=
y
>>> there before this patch.
>>>
>>> In fact, if null-co supported .bdrv_co_pwrite_zeroes, I think you wou=
ld
>>> get even worse results for your patch because then the pre-patch vers=
ion
>>> doesn't even have to do the memset().
>>>
>>>>> (2a) It might be worth noting that on xfs, reading the sparse file =
took
>>>>> longer even before this patch...
>>>>>
>>>>> (3) qcow2 is different: It benefits from this patch on tmpfs and xf=
s
>>>>> (note that reading a sparse qcow2 file took longer than reading a f=
ull
>>>>> qcow2 file before this patch!), but it gets pretty much destroyed o=
n
>>>>> ext4, too.
>>>
>>> I suppose an empty qcow2 with metadata preallocation behaves roughly
>>> like sparse raw?
>>
>> Yep, more on that below.
>>
>>> As long as the qcow2 metadata reflects the allocation status in the
>>> image file (which it probably usually does, except with preallocation=
),
>>> it makes sense that qcow2 performs better with just relying on its
>>> metadata. Calling an lseek() that just returns the same result is a
>>> wasted effort then.
>>>
>>>>> (4) As for sparse vmdk images...  Reading them takes longer, but it=
's
>>>>> still fasster than reading full vmdk images, so that's not horrible=
=2E
>>>
>>> Hm, why is that? Shouldn't vmdk metadata reflect the allocation statu=
s
>>> in the image file just as well as qcow2 metadata?
>>>
>>> But actually, the absolute numbers are much lower than both raw and
>>> qcow2, which is a bit surprising. Is there a bug somewhere in vmdk or=

>>> are we missing optimisations in raw and qcow2?
>>
>> I wondered about that, too.  Maybe something to look into another time=
=2E..
>=20
> A first thing to try would be a larger qcow2 cluster size. VMDK has 1 M=
B
> clusters, if I remember correctly, so maybe it just covers larger range=
s
> with a single call.

IIRC when doing block-status queries on VMDK, it only returns 64 kB
clusters.  That's the main issue for tmpfs, because we have to do so
many lseek()s, whereas qcow2 can cover an entire 2 GB image with a
single block-status call.

Max


--KNyYKue5fzS4k5a8KT1jMfcWJVlGcmD1n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqgH+cSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AUAIIALmePJhqE8gLHuaThgx1SHvUEwyR8ZCP
4WO7dq8TfjYMwmnSKhQ9OvN8QijfAf3VHpl1OjPvmMzsrM19mXd8q8022yOMEn+9
qJEFHktqvVKh/qhYPv00Lwrn4cE3A6b4pOu2S1F/Z61W/HVfQ25hQ3MjdQ8HkjxO
2pgLTY8/NjpwibxA4GToHOPxgr2mzKxD8Jyh3g9TfkNU+IsP7xxK4IhmHQuBIcMY
28/1H2npZsoe9hukUQn4fWpR/mJkbF1fdGcEOu3CTrUiAj0kvBQ891DLUOB3JVIl
wuzn6219C5yIwthIxJyqd2zwZGT0tLPqNro4m0owGcqw3Qirsa8P1ec=
=L769
-----END PGP SIGNATURE-----

--KNyYKue5fzS4k5a8KT1jMfcWJVlGcmD1n--
