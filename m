Received: from eggs.gnu.org ([2001:4830:134:3::10]:38094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cyIz7-0006aY-2Q
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 10:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cyIz1-0002Y8-AJ
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 10:11:01 -0400
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
	<w5160ibyufr.fsf@maestria.local.igalia.com>
	<9d848582-8c76-4d88-2b31-e0e4c63b61d4@redhat.com>
	<w5137dfyq1f.fsf@maestria.local.igalia.com>
	<5cb5f7fb-aadd-d8b5-7cf5-d677db045105@redhat.com>
	<w51fuhdkdbg.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b1a0b5a7-4528-eba8-630e-dd80bc8c26d2@redhat.com>
Date: Wed, 12 Apr 2017 16:10:46 +0200
MIME-Version: 1.0
In-Reply-To: <w51fuhdkdbg.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Amw8QbVvI6KMMbgugo8IrEmcuXSwLUqu6"
Subject: Re: [Qemu-devel] [Qemu-block] [RFC] Proposed qcow2 extension:
 subcluster allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Amw8QbVvI6KMMbgugo8IrEmcuXSwLUqu6
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <b1a0b5a7-4528-eba8-630e-dd80bc8c26d2@redhat.com>
Subject: Re: [Qemu-block] [RFC] Proposed qcow2 extension: subcluster
 allocation
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
 <d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
 <w5160ibyufr.fsf@maestria.local.igalia.com>
 <9d848582-8c76-4d88-2b31-e0e4c63b61d4@redhat.com>
 <w5137dfyq1f.fsf@maestria.local.igalia.com>
 <5cb5f7fb-aadd-d8b5-7cf5-d677db045105@redhat.com>
 <w51fuhdkdbg.fsf@maestria.local.igalia.com>
In-Reply-To: <w51fuhdkdbg.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.04.2017 14:41, Alberto Garcia wrote:
> On Tue 11 Apr 2017 04:45:29 PM CEST, Eric Blake wrote:
>>>>>> (We could even get one more bit if we had a subcluster-flag,
>>>>>> because I guess we can always assume subclustered clusters to have=

>>>>>> OFLAG_COPIED and be uncompressed. But still, three bits missing.)
>>>>>
>>>>> Why can we always assume OFLAG_COPIED?
>>>>
>>>> Because partially allocated clusters cannot be used with internal
>>>> snapshots, and that is what OFLAG_COPIED is for.
>>>
>>> Why can't they be used?
>>
>> An internal snapshot causes a COW to happen if another write happens
>> anywhere in the cluster. Setting OFLAG_COPIED is a shorthand for
>> whether the COW must happen, but it is always possible (but slower) to=

>> refer back to the refcount to learn the same information.  If we have
>> a cluster with missing subclusters, and need to do a COW, we are
>> already reading from the backing file - so we might as well populate
>> the missing subclusters of the original cluster at that time we write
>> the new updated cluster, at which point we no longer need to mark the
>> cluster as using subclusters.
>=20
> I still don't see why we can always assume OFLAG_COPIED. Before doing
> the COW one cluster can have references from multiple snapshots,

Yes...

>                                                                  and
> OFLAG_COPIED is equally valid in that context.

In what context? When having subclusters? Why?

>                                                We still need to know if=

> we need to perform COW when writing to it, regardless of whether it has=

> subclusters or not.

But why would you reference a cluster multiple times if it has
subclusters? Yes, you can do it in theory, but we could just disallow
it, because it doesn't make sense.

As I've said before, there may be uses for clusters to be referenced
multiple times other than internal snapshots; but right now we only use
it for internal snapshots, and I don't think that disallowing multiple
references for subclustered clusters would be horrible for any of the
other use cases.

> Also, when doing a COW for an internal snapshot we definitely have to
> duplicate the whole cluster, but do we really need to read from the
> backing file? Can't we leave the missing subclusters unallocated in the=

> copy?
Can't we just disallow !OFLAG_COPIED for subclustered clusters?

To me it seems you implicitly assume we would want to allow
!OFLAG_COPIED, and based on that you argue how we could do so and what
semantics it would bear. However, I fail to see why we would want that
feature at all.

Max


--Amw8QbVvI6KMMbgugo8IrEmcuXSwLUqu6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljuNWYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ar20IAIQpxDuk4U+0KGzPR3byWF94Y49tGe7S
vfrpgrvMdJrGg/CGkofBVt4T6qwQ3Y1rg+2s85+PSXIp/xADgb2ZYhcGS7A6ilQ8
qjQUwYlIXJzkqWqalnhXRyzQJM0FOsb0nKgoyfNvq6tpznTsSsGRRx8ywawnmjpZ
zQsc4glHGpWmVTF0qxIEzMiZaLl3wYKaHbNlyH8fTvLCRZL0FLEEM0hfJo3/S7jZ
SUhcJelw5abRzIchUfGBr5qiGlCR8QNsccVz/MmujEjakPdi9sLxsOJCdAX8cwgx
mKxtcGt0Q1Nx7za39GgrvmVsLxACzEmRTEOTNZ6rJvFaPPVApHAp+NI=
=Z50B
-----END PGP SIGNATURE-----

--Amw8QbVvI6KMMbgugo8IrEmcuXSwLUqu6--
