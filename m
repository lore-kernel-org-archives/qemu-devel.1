Received: from eggs.gnu.org ([209.51.188.92]:38214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmhG6-00080S-Ur
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:49:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmhG6-0006yY-5a
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:49:38 -0500
References: <20190110132048.49451-1-vsementsov@virtuozzo.com>
	<20190111104126.GC5010@dhcp-200-186.str.redhat.com>
	<b504e946-205c-8800-fe2c-e11f0b27c23a@virtuozzo.com>
	<20190122185740.GC5220@localhost.localdomain>
	<340bf08d-57ff-c6b3-13f4-b7c1b0a5e707@virtuozzo.com>
	<02acf2a0-50d9-16d8-c2c4-3001a1d30b23@virtuozzo.com>
	<20190124153945.GJ4601@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9a32c574-5ddb-eca0-1e2c-50b9cc6a7a00@redhat.com>
Date: Thu, 24 Jan 2019 09:49:19 -0600
MIME-Version: 1.0
In-Reply-To: <20190124153945.GJ4601@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="n9XZ6eZ5Cxn9cOpPIxe1jCpGFF2POHWt1"
Subject: Re: [Qemu-devel] [PATCH] block: don't probe zeroes in bs->file by
 default on block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n9XZ6eZ5Cxn9cOpPIxe1jCpGFF2POHWt1
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>
Message-ID: <9a32c574-5ddb-eca0-1e2c-50b9cc6a7a00@redhat.com>
Subject: Re: [PATCH] block: don't probe zeroes in bs->file by default on
 block_status
References: <20190110132048.49451-1-vsementsov@virtuozzo.com>
 <20190111104126.GC5010@dhcp-200-186.str.redhat.com>
 <b504e946-205c-8800-fe2c-e11f0b27c23a@virtuozzo.com>
 <20190122185740.GC5220@localhost.localdomain>
 <340bf08d-57ff-c6b3-13f4-b7c1b0a5e707@virtuozzo.com>
 <02acf2a0-50d9-16d8-c2c4-3001a1d30b23@virtuozzo.com>
 <20190124153945.GJ4601@localhost.localdomain>
In-Reply-To: <20190124153945.GJ4601@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/24/19 9:39 AM, Kevin Wolf wrote:

>>>
>>> Hmm, and one more idea from Den:
>>>
>>> We can detect preallocated image, comparing allocated size of real fi=
le with
>>> number of non-zero qcow2 refcounts. So, real allocation is much less =
than
>>> allocation in qcow2 point of view, we'll enable lseeks, otherwise - n=
ot.
>>>
>>
>> Kevin, what do you think?
>=20
> I'm unsure. I think it requires scanning all refcount blocks in
> qcow2_open(), right? This could be slow on huge images. On the other
> hand, the first cluster allocation will probably do this anyway, so it
> might be reasonable enough.
>=20

We could add a qcow2 header to cache the last known values, to make
things faster on open (will only benefit users that know to set/read the
cache; should probably be an autoclear-type feature to detect when an
older user modified the image but not the cache).

We can on first allocation for images being modified - but the use case
in question is 'qemu-img convert' which only reads the image, not writes
it, so yes, it adds a startup delay.  But if the delay is no worse than
the current code, or if it can end early, it may help.  We're using it
as some sort of heuristic; we need to compare the size of the underlying
file to the count of known-allocated clusters in the qcow2 layer (where
internal snapshots may throw things off, and where having a backing file
or not changes whether a sparse file is worth further checking for extra
precision for encountering holes on allocated clusters).

> How would you communicate this? Another block_status return flag that
> says "don't bother to ask the protocol layer" and which we would only
> set in qcow2 if the probing came to the conclusion that it's not
> preallocated?

That could work.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--n9XZ6eZ5Cxn9cOpPIxe1jCpGFF2POHWt1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxJ3oAACgkQp6FrSiUn
Q2pLzQgAk55Ou1GwyPV9osLMs7f4U9fEOyFae0N0kNGgxR2mCK+X5BYCDQzu5n87
Z3hBXal99vYjEUyPkOyIRYlaGD85sLiqgQGc2PFn9+FzTrmGg1cw0TJky7BmkWgG
wc/LeVDXQCh+822A1u7SS31Zt5htwj01s6t1evFOzTyZ9lJ8LrxHDLEmsxtL4dOB
QRCFnUMucOTJfPgxB7BFekJrb5Yp8/9B79dibKP+3xHBRrWE/Fx7fZzaksYuzdZb
m0WQY6MgITufWvpLB0zCbKwAR9PzwkjlygVPbGyV3Tv76sKzKW409Yu/Ab5QeRfZ
TQrXsmTT0hvC2gLEXNQP6uXOJlbNCg==
=1N37
-----END PGP SIGNATURE-----

--n9XZ6eZ5Cxn9cOpPIxe1jCpGFF2POHWt1--
