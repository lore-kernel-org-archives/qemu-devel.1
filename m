Received: from eggs.gnu.org ([2001:4830:134:3::10]:47945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwZDi-0003Lr-Hp
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 15:39:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwZDh-0004BD-0r
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 15:39:10 -0400
References: <20170925122808.14561-1-kwolf@redhat.com>
	<20170925122808.14561-3-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <59f25063-4338-dc44-be0b-bc682e72d4ee@redhat.com>
Date: Mon, 25 Sep 2017 14:38:59 -0500
MIME-Version: 1.0
In-Reply-To: <20170925122808.14561-3-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="P6qgJCaLt8qLn8jae4Lt6AFWLMWdgGipc"
Subject: Re: [Qemu-devel] [PATCH 2/5] commit: Support multiple roots above
 top node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P6qgJCaLt8qLn8jae4Lt6AFWLMWdgGipc
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org
Message-ID: <59f25063-4338-dc44-be0b-bc682e72d4ee@redhat.com>
Subject: Re: [PATCH 2/5] commit: Support multiple roots above top node
References: <20170925122808.14561-1-kwolf@redhat.com>
 <20170925122808.14561-3-kwolf@redhat.com>
In-Reply-To: <20170925122808.14561-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/25/2017 07:28 AM, Kevin Wolf wrote:
> This changes the commit block job to support operation in a graph where=

> there is more than a single active layer that references the top node.
>=20
> This involves inserting the commit filter node not only on the path
> between the given active node and the top node, but between the top nod=
e
> and all of its parents.
>=20
> On completion, bdrv_drop_intermediate() must consider all parents for
> updating the backing file link. These parents may be backing files
> themselves and such read-only; reopen them temporarily if necessary.

s/such/as such/

> Previously this was achieved by the bdrv_reopen() calls in the commit
> block job that made overlay_bs read-write for the whole duration of the=

> block job, even though write access is only needed on completion.

Do we know, at the start of the operation, enough to reject attempts
that will eventually fail because we cannot obtain write access at
completion, without having to wait for all the intermediate work before
the completion phase is reached?  If not, that might be a bit of a
regression (where a command used to fail up front, we now waste a lot of
effort, and possibly modify the backing chain irreversably, before
finding out we still fail because we lack write access).

>=20
> Now that we consider all parents, overlay_bs is meaningless. It is left=

> in place in this commit, but we'll remove it soon.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c        | 68 ++++++++++++++++++++++++++++++++++----------------=
--------
>  block/commit.c |  2 +-
>  2 files changed, 41 insertions(+), 29 deletions(-)
> =20
>      /* success - we can delete the intermediate states, and link top->=
base */
> -    if (new_top_bs->backing->role->update_filename) {
> -        backing_file_str =3D backing_file_str ? backing_file_str : bas=
e->filename;
> -        ret =3D new_top_bs->backing->role->update_filename(new_top_bs-=
>backing,
> -                                                         base, backing=
_file_str,
> -                                                         &local_err);
> -        if (ret < 0) {
> -            bdrv_set_backing_hd(new_top_bs, top, &error_abort);
> +    backing_file_str =3D backing_file_str ? backing_file_str : base->f=
ilename;
> +
> +    QLIST_FOREACH_SAFE(c, &top->parents, next_parent, next) {
> +        /* Check whether we are allowed to switch c from top to base *=
/
> +        GSList *ignore_children =3D g_slist_prepend(NULL, c);
> +        bdrv_check_update_perm(base, NULL, c->perm, c->shared_perm,
> +                               ignore_children, &local_err);
> +        if (local_err) {
> +            ret =3D -EPERM;
> +            error_report_err(local_err);
>              goto exit;
>          }
> -    }
> +        g_slist_free(ignore_children);
> =20

And it looks like you DO check up front that permissions are sufficient
for later on.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--P6qgJCaLt8qLn8jae4Lt6AFWLMWdgGipc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnJW1MACgkQp6FrSiUn
Q2oS8Af+JG8hz5A57s+30HBjlvhRIsluDkYmGbLlG345EiL6W+8eHDJQmDAezZaw
AbttXdJDG3zDV/G+ugxoxVDDB1Ejxd5f0/m8b65pbsrO/xa4/7T+jv2nHVTC2Pmk
vDP7RGgJjNFQAPJeY+JU+0wj1BQbDDneJMzRr+2Prt7R1k3p3sMY50BT49+K5xFV
FLq6cjckneM8WlnS9PFibMZpkLESP3jAV4xr9x283bJdWf2uSW2HQ2R7Hnm2dzIZ
07uG74SwEXMAuaQcCkiRrYgGsmb7+SibX3MOAM1xLe6QsI7GRBlLor+lw8fHR5Km
b6ucygyRtih9D5FEvSyh1hjuoVErUw==
=uovQ
-----END PGP SIGNATURE-----

--P6qgJCaLt8qLn8jae4Lt6AFWLMWdgGipc--
