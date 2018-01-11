Received: from eggs.gnu.org ([2001:4830:134:3::10]:35245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZe6E-0008L8-WF
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:45:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZe6D-0003jU-MA
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:44:59 -0500
References: <76a29a1e-7fdb-37a8-9f79-df618d385b05@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9e11cf33-cbe1-9fd5-f265-180e4e14dfa7@redhat.com>
Date: Thu, 11 Jan 2018 08:43:40 -0600
MIME-Version: 1.0
In-Reply-To: <76a29a1e-7fdb-37a8-9f79-df618d385b05@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sbNuy4SzferDgutsTLlwXBez4KStE4qqr"
Subject: Re: [Qemu-devel] qcow2 autoloading bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sbNuy4SzferDgutsTLlwXBez4KStE4qqr
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>
Message-ID: <9e11cf33-cbe1-9fd5-f265-180e4e14dfa7@redhat.com>
Subject: Re: [Qemu-devel] qcow2 autoloading bitmaps
References: <76a29a1e-7fdb-37a8-9f79-df618d385b05@virtuozzo.com>
In-Reply-To: <76a29a1e-7fdb-37a8-9f79-df618d385b05@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2018 08:26 AM, Vladimir Sementsov-Ogievskiy wrote:

> # @autoload: the bitmap will be automatically loaded when the image it
> is stored
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in =
is opened. This flag may only be specified for persistent
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bit=
maps. Default is false for block-dirty-bitmap-add.
> (Since: 2.10)
>=20
> so, if we consider only enabled bitmaps it is ok to direct map autoload=

> <=3D> auto.
>=20
> But now we've faced into necessity of load/store disabled bitmaps.
>=20
> Current behavior is definitely wrong: user sets autoload flag for
> disabled bitmap, but on next
> Qemu start the bitmap will be autoloaded and enabled.

Can we make it an error to set autoload to true when requesting a
disabled bitmap? Or can we not even request a disabled bitmap?

>=20
>=20
> Proposed solution:
> =C2=A0- deprecate @autoload flag for bitmap creation, ignore it

Is there ever a case where you'd create an enabled persistent
dirty-tracking bitmap, but not want it to be re-enabled the next time
the image is created?  Your argument for ignoring/deleting the parameter
is that you can decide whether to set the "auto" flag solely based on
whether the bitmap is both persistent and enabled, without needing any
additional user input?

> =C2=A0- save persistent enabled bitmaps with "auto" flag
> =C2=A0- save persistent disabled bitmaps without "auto" flag
> =C2=A0- on Qemu start load all bitmaps, mapping "auto" flag state to
> "enabled" state.

So if I follow the argument, the state of the 'auto' flag stored into
the file on BDS close (often at qemu exit) is based on whether the
bitmap was currently enabled, and the user can then control whether to
enable/disable the bitmap on the fly to control whether the 'auto' flag
is stored; thus, having the flag at creation time is redundant.

>=20
>=20
> Note: we may store a lot of disabled bitmaps in qcow2 image, but loadin=
g
> them all into RAM may be
> inefficient. Actually such bitmap will be needed only on demand (for
> export through nbd or
> making some kind of backup). So in future it may be optimized by "lazy
> load" of disabled bitmaps,
> postponing their actual load up to first read or enabling. This
> optimization doesn't need changing
> of qapi or qcow2 format (at first sight).
>=20
>=20
> Note2: now there is no way to disable/enable bitmaps, but there is a
> =C2=A0 [PATCH for-2.12 0/4] qmp dirty bitmap API
> with big conversation, but I hope, I'll post a new version with a small=

> fix soon and it will be merged.

In other words, you can incorporate your QAPI tweaks proposed here into
your respin of that series.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--sbNuy4SzferDgutsTLlwXBez4KStE4qqr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpXeBwACgkQp6FrSiUn
Q2o38gf7Bicr6eSYBqY+0C9sIiZDyZnpyhyyOcc1YISqsvkq+7SheJxll489HXM4
LhJFK5WuRjigOcf/azNS0ZMvahxGgwDahdF+qtbyLMHalPOlOt0zDIyzjTOONgGV
bf6hfwEJPSKOuT9gkpCx+fQmIWt2MJWc4ND376nxZ1qSEAyCrCRnp0Q1miASa83S
5g3q3f989z0wu8hgvjAYAddH/c/tcAaiQg9vK7qrmI1OEI8A4z//DDxXKt+6+k1H
bopaONtOrWEzMtK4j3fo/QToZGASSK/P2qsoXZ93odui9ks7rbu5YCahz9tc3fR1
Q3xvt1gMNcKAiwFxnRiVXf0ooen1Dw==
=/pOD
-----END PGP SIGNATURE-----

--sbNuy4SzferDgutsTLlwXBez4KStE4qqr--
