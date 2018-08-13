Received: from eggs.gnu.org ([2001:4830:134:3::10]:36440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fpFOk-0005hf-Dv
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:08:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fpFOj-0001Qq-7r
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:08:50 -0400
References: <20180810062647.23211-1-lbloch@janustech.com>
	<20180810062647.23211-7-lbloch@janustech.com>
	<w5136vm8m8u.fsf@maestria.local.igalia.com>
	<ca79bbff-163b-f50e-e17b-54d6597e6bfe@redhat.com>
	<20180813112333.GD4323@localhost.localdomain>
	<e9a77f1e-6b9e-3fea-69c9-c18638961a2e@redhat.com>
	<20180813155856.GL4323@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5436d747-9cf3-50a0-6fab-537fb8cc8bae@redhat.com>
Date: Mon, 13 Aug 2018 18:08:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180813155856.GL4323@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5cdwn2ctv9SZNTNgQfMuDHNJCXodf9SKM"
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5cdwn2ctv9SZNTNgQfMuDHNJCXodf9SKM
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, Leonid Bloch <lbloch@janustech.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>
Message-ID: <5436d747-9cf3-50a0-6fab-537fb8cc8bae@redhat.com>
Subject: Re: [PATCH v7 6/9] qcow2: Increase the default upper limit on the L2
 cache size
References: <20180810062647.23211-1-lbloch@janustech.com>
 <20180810062647.23211-7-lbloch@janustech.com>
 <w5136vm8m8u.fsf@maestria.local.igalia.com>
 <ca79bbff-163b-f50e-e17b-54d6597e6bfe@redhat.com>
 <20180813112333.GD4323@localhost.localdomain>
 <e9a77f1e-6b9e-3fea-69c9-c18638961a2e@redhat.com>
 <20180813155856.GL4323@localhost.localdomain>
In-Reply-To: <20180813155856.GL4323@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-08-13 17:58, Kevin Wolf wrote:
> Am 13.08.2018 um 17:11 hat Max Reitz geschrieben:
>>>> My personal opinion is this: Most users should be fine with 8 GB of
>>>> randomly accessible image space (this may be wrong).  Whenever a use=
r
>>>> does have an application that uses more than 8 GB, they are probably=
 in
>>>> an area where they want to do some performance tuning anyway.  Requi=
ring
>>>> them to set l2-cache-full in that case seems reasonable to me.
>>>
>>> In principle, I'd agree. I'd even say that management tools should
>>> always explicitly set those options instead of relying on our default=
s.
>>> But management tools have been ignoring these options for a long time=

>>> and keep doing so.
>>>
>>> And honestly, if you can't spend a few megabytes for the caches, it's=

>>> just as reasonable that you should set l2-cache to a lower value. You=
'll
>>> need some more tweaking anyway to reduce the memory footprint.
>>
>> It isn't, because as I explained above, it is more reasonable to expec=
t
>> people to find out about disk options because their disk performance i=
s
>> abysmal than because their RAM is exhausted.
>>
>> I would like to say "but it is nearly as reasonable", but I really don=
't
>> think so.
>=20
> Maybe in a perfect world, finding the option when their disk performanc=
e
> is abysmal is what users would do. In this world, they either just use
> raw and scream for backing files and dirty bitmaps and whatnot for raw,=

> or they just directly go to some other hypervisor.
>=20
> Realistically, the cache options don't exist. They are hard to discover=

> in the QEMU command line and management tools don't support them.
>=20
> Conclusion: We're doomed to find a one-size-fits-all default that works=

> well in all common use cases, including benchmarks. We can try and make=

> it adapt to the situation, but we can't reasonably expect users to
> manually override it.

OK, saying both is unreasonable is something I can get behind.

>>>                                                         Our choice of=
 a
>>> default should reflect that, especially considering that we only use
>>> the memory on demand. If your image is only 32 GB, you'll never use m=
ore
>>> than 4 MB of cache.
>>
>> Well, OK, yes.  This is an especially important point when it really i=
s
>> about hosts that have limited memory.  In those cases, users probably
>> won't run huge images anyway.
>>
>>>                     And if your image is huge, but only access part o=
f
>>> it, we also won't use the full 32 MB.
>>
>> On Linux. O:-)
>=20
> No, on any system where qemu_try_blockalign() results in a COW zero
> page.

OK, yes, but why would you only ever access part of it?  Then you might
just as well have created a smaller disk from the beginning.

> The Linux-only addition is returning memory even after an access.
>=20
>> So it's good that you have calmed my nerves about how this might be
>> problematic on Linux systems (it isn't in practice, although I disagre=
e
>> that people will find qcow2 to be the fault when their memory runs out=
),
>> but you haven't said anything about non-Linux systems.  I understand
>> that you don't care, but as I said here, this was my only substantial
>> concern anyway.
>=20
> I don't actually think it's so bad to keep the cache permanently
> allocated, but I wouldn't object to a lower default for non-Linux hosts=

> either. 1 MB may still be a little too low, 4 MB (covers up to 32 GB)
> might be more adequate. My typical desktop VMs are larger than 8 GB, bu=
t
> smaller than 32 GB.

Will your typical desktop VMs gain anything from the cache covering more
than 8 GB?

Anyway, I certainly won't complain about 4 MB.

(My point here is that on non-Linux systems, qemu probably does not have
users who have use cases where they need to access 256 GB of disk
simultaneously.  Probably not even more than 8 GB.  If you want to
increase the cache size there to 4 MB, fine, I think that won't hurt.
But 32 MB might hurt, and I don't think on non-Linux systems there are
users who would benefit from it -- specifically because your "typical
desktop VM" wouldn't benefit from it.)

Max


--5cdwn2ctv9SZNTNgQfMuDHNJCXodf9SKM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAltxrQcACgkQ9AfbAGHV
z0DcyAf/b6WD9fTIiCSVIjLc3DxRYLt6G0zS8RPR4ZjWOI9VvdGGeVvWH8vzwj/y
h/RPBYkSLp4Jzo3E3A17GnFDLAwmCfEUhC7+PKeGnvGF23ksRZHOM3uWY/BT45u0
YCmjpdNwT6I3gI4Q2BWlpUAf5G228Ea+r52m7jXz+FecCkp6IRPP767NTWBFNAcX
w2yWR2pYhli2a7+vPI/SjK74Mghmjt+8T0cYIDNGkHp9aAMu9AOoFIUY2EtZ6Qtk
ES55gJs7zGn5sa4HZvxRb+tpX0dozdG25pcu7+RX51wbSaS5l95sDHbB3VVXQasU
t3H84NmM3rs73cjnVDjOY1w+46IR4A==
=5KBi
-----END PGP SIGNATURE-----

--5cdwn2ctv9SZNTNgQfMuDHNJCXodf9SKM--
