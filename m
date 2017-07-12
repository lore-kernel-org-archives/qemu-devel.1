Received: from eggs.gnu.org ([2001:4830:134:3::10]:60741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVIns-0000tu-SP
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:39:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVInr-0004vt-Od
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:39:48 -0400
References: <CAPuOgO2q9nNtoPOYuXSWDxBVVsXcWEMbMboLT4OdpXA_Dq5O=Q@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7a891962-9c57-7668-e2fd-69e5e13b9078@redhat.com>
Date: Wed, 12 Jul 2017 09:39:32 -0500
MIME-Version: 1.0
In-Reply-To: <CAPuOgO2q9nNtoPOYuXSWDxBVVsXcWEMbMboLT4OdpXA_Dq5O=Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="52Vh2pq74kr0F2ERo06pmRcp3wSG9iSDE"
Subject: Re: [Qemu-devel] Supporting unsafe create when backing file is not
 accessible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ala Hino <ahino@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-discuss@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow Huston <jsnow@redhat.com>, Nir Soffer <nsoffer@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--52Vh2pq74kr0F2ERo06pmRcp3wSG9iSDE
From: Eric Blake <eblake@redhat.com>
To: Ala Hino <ahino@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, qemu-discuss@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow Huston <jsnow@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>
Message-ID: <7a891962-9c57-7668-e2fd-69e5e13b9078@redhat.com>
Subject: Re: Supporting unsafe create when backing file is not accessible
References: <CAPuOgO2q9nNtoPOYuXSWDxBVVsXcWEMbMboLT4OdpXA_Dq5O=Q@mail.gmail.com>
In-Reply-To: <CAPuOgO2q9nNtoPOYuXSWDxBVVsXcWEMbMboLT4OdpXA_Dq5O=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/12/2017 03:56 AM, Ala Hino wrote:
> Hi,
>=20
> We encountered a performance issue when creating a volume for a running=
 VM
> and we'd like to share the info with you. The root cause of the issue i=
s in
> our code but we found a workaround that relies on qemu-img create
> undocumented behavior.
>=20
> During our tests, we found that in order to create a volume with a back=
ing
> file, the baking file has to be valid and accessible.

In general, that's a good thing. But you're also right that it is nice
to have a mode where the backing file is not probed.

> This requires us to
> activate the entire chain before creating the volume, and deactivate th=
e
> chain after the operation completes. Activating and deactivating the ch=
ain
> are expensive operations that we prefer to avoid when possible. Below i=
s
> the command we use to create volumes:
>=20
> qemu-img create -f qcow2 -o compat=3D1.1 -b
> 8a28cda2-548d-47da-bbba-faa81284f6ba -F raw
> /rhev/data-center/e6b272af-84cb-43fc-ae5b-7fe18bc469a2/f47c980a-fd76-44=
a9-8b78-00d3ab2ffd2f/images/2ff0a3c0-f145-4f83-b668-fc0c39ba191f/d3b69657=
-892f-499c-9ac3-9c443ead7d9b
> 1073741824
>=20
> We also found that when providing the size and the backing format for q=
emu,
> qemu doesn't open the backing chain, and in this case we don't have to
> activate/deactivate the entire chain - exactly the behavior we wish to =
have.

Yes, that is currently the case. You are correct that patches have been
proposed to tighten things so that we would probe the existence of the
backing file in more cases (even when the size is provided); and that if
we do so, we'd also have to provide a backdoor for creating an image
without probing the backing file.  But it is also the case that you can
create an image with NO backing file, and then use 'qemu-img rebase -u'
to add the backing file after the fact, without waiting for any proposed
patches to land.

> We we'd like to get your confirmation of the above behavior as it isn't=

> documented, and whether it can be documented.

The fact that you are asking does mean that we should revive John's
proposed patches, in some form or another.

>=20
> In addition, we are aware of https://bugzilla.redhat.com/1213786, where=
 a
> -u (unsafe) option is planned to be added (see comment #4 in the BZ). C=
an
> you please confirm that once that support is released, it won't break
> existing, i.e. code that provides size and backing format assuming that=

> "unsafe" create is supported?

If we tighten things to require the backing file to exist unless -u is
provided, then providing the size alone will no longer be sufficient to
prevent the probe - you'd have to use -u to prevent the probe, or change
your workflow to create the image without a backing file then add in the
backing information via 'qemu-img rebase -u'.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--52Vh2pq74kr0F2ERo06pmRcp3wSG9iSDE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZjSkAAoJEKeha0olJ0Nqej4H/RActaQWOfFHdMg/8usZ2sy6
mftZ+12cLameqzsgxuYdx8pF49aaNWk5sRdmaZ0DEdKBRZht5Ot/BIE9DlLLDGjX
LjGINGCv1fwlr3aRvMz0+HYMrQ1mUBTVJMaraa1VPs3UDzVs8i191py8/Iml1vnH
Kv3n9tS3y/ZeCydF/rvUi5v7zR+w/nP2rYN3qXXQ6OhJC6r+A3CtkEAs3ilq9x8R
tZ5q+tc6LD7uiQt0mODB9SH/394zKvicqd5ujQ8MSaPM9/+y5CD8CotxgLVfFFea
/nB69AJLmSR1ETZv11416b1Beopt5z8eFk1aQcNcxM6CxmVYpY9gXURwJ4/o+CQ=
=bNxy
-----END PGP SIGNATURE-----

--52Vh2pq74kr0F2ERo06pmRcp3wSG9iSDE--
