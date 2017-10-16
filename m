Received: from eggs.gnu.org ([2001:4830:134:3::10]:34935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4B57-0004eH-PX
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 15:29:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4B56-00036G-P3
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 15:29:45 -0400
References: <20171015010131.12172-1-eblake@redhat.com>
	<20171015010131.12172-5-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <682100d0-97bc-013b-48d7-50991c905fa1@redhat.com>
Date: Mon, 16 Oct 2017 14:29:34 -0500
MIME-Version: 1.0
In-Reply-To: <20171015010131.12172-5-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ftt1VFrIAw9pJk65vXd2jeuOkRjP1QCvD"
Subject: Re: [Qemu-devel] [PATCH v4 4/8] nbd: Minimal structured read for
 server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ftt1VFrIAw9pJk65vXd2jeuOkRjP1QCvD
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org
Message-ID: <682100d0-97bc-013b-48d7-50991c905fa1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 4/8] nbd: Minimal structured read for
 server
References: <20171015010131.12172-1-eblake@redhat.com>
 <20171015010131.12172-5-eblake@redhat.com>
In-Reply-To: <20171015010131.12172-5-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/14/2017 08:01 PM, Eric Blake wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> Minimal implementation of structured read: one structured reply chunk,
> no segmentation.
> Minimal structured error implementation: no text message.
> Support DF flag, but just ignore it, as there is no segmentation any
> way.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20

> +
> +            case NBD_OPT_STRUCTURED_REPLY:
> +                if (client->structured_reply) {
> +                    ret =3D nbd_negotiate_send_rep_err(
> +                        client->ioc, NBD_REP_ERR_INVALID, option, errp=
,
> +                        "structured reply already negotiated");
> +                } else {
> +                    ret =3D nbd_negotiate_send_rep(client->ioc, NBD_RE=
P_ACK,
> +                                                 option, errp);
> +                }

Fails spectacularly if the client sent a non-zero length payload along
with the option, because we forgot to nbd_drop the payload, getting the
server out-of-sync with the client's next option request.  I'm
requesting clarification from the NBD list on how to best handle that
(presumably with NBD_REP_ERR_INVALID), and in the meantime will copy
what we do for NBD_OPT_LIST with unexpected payload.  It also made me
realize that we don't reject unexpected payload for NBD_OPT_STARTTLS; a
common helper function would make that easier, so guess what I'm adding
in v5 :)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ftt1VFrIAw9pJk65vXd2jeuOkRjP1QCvD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnlCJ4ACgkQp6FrSiUn
Q2oKmgf7BUUHMRN8EMFhmGVpwAz6f251y4CRs8Ct3GxulOyKBh06klaMb7S+gnsS
rVSzq5Em4x9ulGEc+qNuMzf+wOHjNKySYjUrnEJmSevIti81lYjdI0xlHfdAD7Nt
Yo5OnDAO++Z7SCnVXVlJ7CzxUh0yJKavnBrE4++UHeDQcymXXB+kDP+hotJNtx+T
aLuH01jHDwA6Y2uhym/BibubApC0EOb/ML5GzYHuBKbWYLXeqF73vX8Fk2wmeQJ9
EWWWMe0bUbRsuPQcejIHEE59tpvQuHvor3qw7eOmvr51PhX7j5hokE+gfExQIT/n
5TJu1AZiGkatfh1XsNL//e0K19AIeA==
=rFfh
-----END PGP SIGNATURE-----

--ftt1VFrIAw9pJk65vXd2jeuOkRjP1QCvD--
