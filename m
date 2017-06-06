Received: from eggs.gnu.org ([2001:4830:134:3::10]:54973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIDHx-0007SW-7u
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:08:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIDHw-0001ad-AK
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:08:45 -0400
References: <20170530104857.70083-1-vsementsov@virtuozzo.com>
	<20170530104857.70083-2-vsementsov@virtuozzo.com>
	<21763282-556d-4389-29b5-664f6f4f4479@redhat.com>
	<b1e2e189-c195-0f54-ffe8-45287d8d522f@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c523b295-0e15-c20a-12e6-5d920d7bbec3@redhat.com>
Date: Tue, 6 Jun 2017 07:08:34 -0500
MIME-Version: 1.0
In-Reply-To: <b1e2e189-c195-0f54-ffe8-45287d8d522f@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lN7mgLEqq45PJnw2pWNGWAMANR9qkbwRS"
Subject: Re: [Qemu-devel] [PATCH 1/4] block: add bdrv_get_format_alloc_stat
 format interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lN7mgLEqq45PJnw2pWNGWAMANR9qkbwRS
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <c523b295-0e15-c20a-12e6-5d920d7bbec3@redhat.com>
Subject: Re: [PATCH 1/4] block: add bdrv_get_format_alloc_stat format
 interface
References: <20170530104857.70083-1-vsementsov@virtuozzo.com>
 <20170530104857.70083-2-vsementsov@virtuozzo.com>
 <21763282-556d-4389-29b5-664f6f4f4479@redhat.com>
 <b1e2e189-c195-0f54-ffe8-45287d8d522f@virtuozzo.com>
In-Reply-To: <b1e2e189-c195-0f54-ffe8-45287d8d522f@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/02/2017 10:26 AM, Vladimir Sementsov-Ogievskiy wrote:
> 30.05.2017 17:53, Eric Blake wrote:
>> On 05/30/2017 05:48 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> The function should collect statistics, about allocted/unallocated by=

>>> top-level format driver space (in its .file) and allocation status
>>> (allocated/hole/after eof) of corresponding areas in this .file.
>>>

>>> +# @BlockFormatAllocInfo:
>>> +#
>>> +# Information about allocations, including metadata. All fields are
>>> in bytes.
>=20
> s/All fields are in bytes./All fields are in bytes and aligned by secto=
r
> (512 bytes)./

I wouldn't even promise sector alignment. We probably happen to have
sector alignment (especially for qcow2, since the smallest cluster size
permitted is sector aligned), but I see no inherent reason why we can't
support sub-sector values if we are reporting in bytes.

>=20
> - ok? to emphasize that there is nothing about clusters... Or may be
> better to write that they are aligned by byte.

I think "All fields are in bytes" is sufficient.


>>> +{ 'struct': 'BlockFormatAllocInfo',
>>> +  'data': {'alloc_alloc':    'uint64',
>>> +           'alloc_hole':     'uint64',
>>> +           'alloc_overhead': 'uint64',
>>> +           'hole_alloc':     'uint64',
>>> +           'hole_hole':      'uint64' } }
>> The idea seems okay, but the naming needs to be fixed.  Also, I'm not
>> sure if we need all 5, or if 4 is enough; and I'm not sure if we have
>> the right names ("how does alloc-hole differ from hole-alloc?"), or if=

>> we can come up with something more descriptive.  Particularly since
>> "hole-" is not a hole in the filesystem sense, so much as unused
>> clusters.  But I'm also not coming up with better names to suggest at
>> the moment.
>>
> how about:
>=20
> used-allocated
> used-discarded
> used-overrun
>=20
> unused-allocated
> unused-discarded

Those work for me.

>=20
>=20
> also, do you mention that your detailed wordings should be included int=
o
> block-core.json or you just clarify things?

Good documentation is worth the effort. I don't know if you want all of
my details in block-core.json, but giving a better overview of how each
statistic is possible does make it easier to visualize what the
statistic is actually counting.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lN7mgLEqq45PJnw2pWNGWAMANR9qkbwRS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZNptCAAoJEKeha0olJ0NqmDwH/RY+lVpvV4e3AMfioxj7XcRg
eAIrNTBRAiJ/EvPDFH2qGC1/6plEiMlFJFfOwq/s7yY9eD1hGlNcj6XOFvW7RFm+
2om49QheLsy1Mg0MzCLotshpiz4LRL0JN4ygGgwJct6QVEoG90laqf5IJJV4yFYg
ZPr6PCXrc4cM/MJqY01whXDDu+yMqA1NxFnb/1Yw4SkK9BRPQLQ23dXaLCFc872v
++TJ1MktyTX3SXybEGu9Ml0pNvTHynqtKFh5Ez6Zp0UqlWzDdMJIxYDpJa3fHuON
yhHel18yzpRjbndV3uzN9xhamYK96biUNKHSWt7NQykLEWnRcHVmQx4pwfXz9Ko=
=zKxc
-----END PGP SIGNATURE-----

--lN7mgLEqq45PJnw2pWNGWAMANR9qkbwRS--
