Received: from eggs.gnu.org ([2001:4830:134:3::10]:42368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dId1O-0003gb-7H
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dId1N-0005ZH-AN
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:37:22 -0400
References: <d5b487b58c2c6b3e68de0e858b84877434f05c76.1496843678.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f10688f7-0e86-38b5-fae7-31911a9d66e8@redhat.com>
Date: Wed, 7 Jun 2017 10:37:13 -0500
MIME-Version: 1.0
In-Reply-To: <d5b487b58c2c6b3e68de0e858b84877434f05c76.1496843678.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Xehldbbq6FGxfCJdLKR55A4NlVn8tEDuD"
Subject: Re: [Qemu-devel] [PATCH] block: fix external snapshot abort
 permission error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xehldbbq6FGxfCJdLKR55A4NlVn8tEDuD
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <f10688f7-0e86-38b5-fae7-31911a9d66e8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: fix external snapshot abort
 permission error
References: <d5b487b58c2c6b3e68de0e858b84877434f05c76.1496843678.git.jcody@redhat.com>
In-Reply-To: <d5b487b58c2c6b3e68de0e858b84877434f05c76.1496843678.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/07/2017 08:55 AM, Jeff Cody wrote:
> In external_snapshot_abort(), we try to undo what was done in
> external_snapshot_prepare() calling bdrv_replace_node() to swap the
> nodes back.  However, we receive a permissions error as writers are
> blocked on the old node, which is now the new node backing file.
>=20
> An easy fix (initially suggested by Kevin Wolf) is to call
> bdrv_set_backing_hd() on the new node, to set the backing node to NULL.=

>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  blockdev.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/blockdev.c b/blockdev.c
> index 892d768..6472548 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1803,7 +1803,11 @@ static void external_snapshot_abort(BlkActionSta=
te *common)
>                               DO_UPCAST(ExternalSnapshotState, common, =
common);
>      if (state->new_bs) {
>          if (state->overlay_appended) {
> +            bdrv_ref(state->old_bs);   /* we can't let bdrv_set_backin=
d_hd()
> +                                          close state->old_bs; we need=
 it */
> +            bdrv_set_backing_hd(state->new_bs, NULL, &error_abort);
>              bdrv_replace_node(state->new_bs, state->old_bs, &error_abo=
rt);
> +            bdrv_unref(state->old_bs); /* bdrv_replace_node() ref'ed o=
ld_bs */
>          }
>      }
>  }
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Xehldbbq6FGxfCJdLKR55A4NlVn8tEDuD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOB2pAAoJEKeha0olJ0Nq+I4H/3fmgs4QPzDKSmL+sDMAWonR
0GUdFPwtvyybYQ68/PyT847SowgXRzuBh1aKIxw5IkkQ/qnPdxkorQMvTLFRC3qx
OH6d0mS9WE2CS8iUtDBW5CDuG5g4wiKykGU1dKB9fyqPy9D2ZLGQJ6TECr12TnGc
i6vO6DE9zVZQuyNMU70ULL1I1TVExV+Z5AJ4wLsWc+7ofotAivFdsKR9d3zZbPQK
Pm2yIqr1hPcc4iphhiQ/4vBNQGjE9/jeTlql9pm+uFJQxE+MA47WkJ/W9KRQppPe
RULlxqa3JX3XyY/mah6pY1F3QwFJ8TPMOHV19hRDqOx3N39QEASIOgfVsWvkAAU=
=BBIz
-----END PGP SIGNATURE-----

--Xehldbbq6FGxfCJdLKR55A4NlVn8tEDuD--
