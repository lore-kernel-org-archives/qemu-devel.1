Received: from eggs.gnu.org ([2001:4830:134:3::10]:42417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fqkWN-0006az-S9
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 15:34:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fqkWM-0007jK-Ua
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 15:34:55 -0400
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
	<13910182-771b-c5dc-26a7-0958a7241fe8@redhat.com>
	<6c318533-dc87-daeb-1fe8-6b11b0cbec8d@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <747506be-aceb-0ab8-a4ee-c79f9a6b929a@redhat.com>
Date: Fri, 17 Aug 2018 21:34:39 +0200
MIME-Version: 1.0
In-Reply-To: <6c318533-dc87-daeb-1fe8-6b11b0cbec8d@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PRRPgYe0w87EZNo5sA2zGj5NSRhEU9Q6p"
Subject: Re: [Qemu-devel] [PATCH 0/7] qcow2: async handling of fragmented io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PRRPgYe0w87EZNo5sA2zGj5NSRhEU9Q6p
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org
Message-ID: <747506be-aceb-0ab8-a4ee-c79f9a6b929a@redhat.com>
Subject: Re: [PATCH 0/7] qcow2: async handling of fragmented io
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
 <13910182-771b-c5dc-26a7-0958a7241fe8@redhat.com>
 <6c318533-dc87-daeb-1fe8-6b11b0cbec8d@virtuozzo.com>
In-Reply-To: <6c318533-dc87-daeb-1fe8-6b11b0cbec8d@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-16 15:58, Vladimir Sementsov-Ogievskiy wrote:
> 16.08.2018 03:51, Max Reitz wrote:
>> On 2018-08-07 19:43, Vladimir Sementsov-Ogievskiy wrote:
>>> Hi all!
>>>
>>> Here is an asynchronous scheme for handling fragmented qcow2
>>> reads and writes. Both qcow2 read and write functions loops through
>>> sequential portions of data. The series aim it to parallelize these
>>> loops iterations.
>>>
>>> It improves performance for fragmented qcow2 images, I've tested it
>>> as follows:
>>>
>>> I have four 4G qcow2 images (with default 64k block size) on my ssd d=
isk:
>>> t-seq.qcow2 - sequentially written qcow2 image
>>> t-reverse.qcow2 - filled by writing 64k portions from end to the star=
t
>>> t-rand.qcow2 - filled by writing 64k portions (aligned) in random ord=
er
>>> t-part-rand.qcow2 - filled by shuffling order of 64k writes in 1m clu=
sters
>>> (see source code of image generation in the end for details)
>>>
>>> and the test (sequential io by 1mb chunks):
>>>
>>> test write:
>>>     for t in /ssd/t-*; \
>>>         do sync; echo 1 > /proc/sys/vm/drop_caches; echo =3D=3D=3D  $=
t  =3D=3D=3D; \
>>>         ./qemu-img bench -c 4096 -d 1 -f qcow2 -n -s 1m -t none -w $t=
; \
>>>     done
>>>
>>> test read (same, just drop -w parameter):
>>>     for t in /ssd/t-*; \
>>>         do sync; echo 1 > /proc/sys/vm/drop_caches; echo =3D=3D=3D  $=
t  =3D=3D=3D; \
>>>         ./qemu-img bench -c 4096 -d 1 -f qcow2 -n -s 1m -t none $t; \=

>>>     done
>>>
>>> short info about parameters:
>>>   -w - do writes (otherwise do reads)
>>>   -c - count of blocks
>>>   -s - block size
>>>   -t none - disable cache
>>>   -n - native aio
>>>   -d 1 - don't use parallel requests provided by qemu-img bench itsel=
f
>> Hm, actually, why not?  And how does a guest behave?
>>
>> If parallel requests on an SSD perform better, wouldn't a guest issue
>> parallel requests to the virtual device and thus to qcow2 anyway?
>=20
> Guest knows nothing about qcow2 fragmentation, so this kind of
> "asynchronization" could be done only at qcow2 level.

Hm, yes.  I'm sorry, but without having looked closer at the series
(which is why I'm sorry in advance), I would suspect that the
performance improvement comes from us being able to send parallel
requests to an SSD.

So if you send large requests to an SSD, you may either send them in
parallel or sequentially, it doesn't matter.  But for small requests,
it's better to send them in parallel so the SSD always has requests in
its queue.

I would think this is where the performance improvement comes from.  But
I would also think that a guest OS knows this and it would also send
many requests in parallel so the virtual block device never runs out of
requests.

> However, if guest do async io, send a lot of parallel requests, it
> behave like qemu-img without -d 1 option, and in this case,
> parallel loop iterations in qcow2 doesn't have such great sense.
> However, I think that async parallel requests are better in
> general than sequential, because if device have some unused opportunity=

> of parallelization, it will be utilized.

I agree that it probably doesn't make things worse performance-wise, but
it's always added complexity (see the diffstat), which is why I'm just
routinely asking how useful it is in practice. :-)

Anyway, I suspect there are indeed cases where a guest doesn't send many
requests in parallel but it makes sense for the qcow2 driver to
parallelize it.  That would be mainly when the guest reads seemingly
sequential data that is then fragmented in the qcow2 file.  So basically
what your benchmark is testing. :-)

Then, the guest could assume that there is no sense in parallelizing it
because the latency from the device is large enough, whereas in qemu
itself we always run dry and wait for different parts of the single
large request to finish.  So, yes, in that case, parallelization that's
internal to qcow2 would make sense.

Now another question is, does this negatively impact devices where
seeking is slow, i.e. HDDs?  Unfortunately I'm not home right now, so I
don't have access to an HDD to test myself...

> We've already
> use this approach in mirror and qemu-img convert.

Indeed, but here you could always argue that this is just what guests
do, so we should, too.

> In Virtuozzo we have
> backup, improved by parallelization of requests
> loop too. I think, it would be good to have some general code for such
> things in future.
Well, those are different things, I'd think.  Parallelization in
mirror/backup/convert is useful not just because of qcow2 issues, but
also because you have a volume to read from and a volume to write to, so
that's where parallelization gives you some pipelining.  And it gives
you buffers for latency spikes, I guess.

Max


--PRRPgYe0w87EZNo5sA2zGj5NSRhEU9Q6p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt3I08ACgkQ9AfbAGHV
z0CyhAf/UraXMGpz7il/jbRNrcmm5bwQMrli7Z1ZDS6hwYkM49Q/MruGLtomPxig
Pj2hfxBrjCY6amtYWSQoD+wcSBrQMExXjjhpUToLxJaNMRmzMHhkGmSUaxmWynjx
G0PFQUP05O1HsGErVTyELkkQCi72NtCPdHLGrCbj+J8QJbGYjoTADEIiEN6s0nCG
gekVrytpieV2fWp/6jPX4O8jSAn4ejXN4G+Q5RuAGXHOYzDtgP/Rp2tbauGu+bn8
z8TSTRlZo9Xs4ZPuvL1SnUaXFXrQ95bbj1MHhevTpBuTict0a3uyMkC6sijhL4tL
XdheQ1P7LTpzMX+H1sZPH0D7UgfRVg==
=xxNh
-----END PGP SIGNATURE-----

--PRRPgYe0w87EZNo5sA2zGj5NSRhEU9Q6p--
