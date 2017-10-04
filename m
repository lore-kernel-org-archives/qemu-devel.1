Received: from eggs.gnu.org ([2001:4830:134:3::10]:38213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dzjBB-00041B-8E
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dzjBA-00004w-AM
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:53:37 -0400
Date: Wed, 4 Oct 2017 14:53:17 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171004125317.GA9801@localhost.localdomain>
References: <20170815074513.9055-1-el13635@mail.ntua.gr>
	<20170929175235.GF3812@localhost.localdomain>
	<20171004122333.5r3uf3ynzqikxobs@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20171004122333.5r3uf3ynzqikxobs@postretch>
Subject: Re: [Qemu-devel] [PATCH RFC] block: add block-insert-node QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 04.10.2017 um 14:23 hat Manos Pitsidianakis geschrieben:
> > > diff --git a/block.c b/block.c
> > > index 81bd51b670..f874aabbfb 100644
> > > --- a/block.c
> > > +++ b/block.c
> > > +    /* insert 'node' as child bs of 'parent' node */
> > > +    if (check_node_edge(parent, child, errp)) {
> > > +        return;
> > > +    }
> > > +    parent_bs =3D bdrv_find_node(parent);
> > > +    c =3D bdrv_find_child(parent_bs, child);
> > > +    role =3D c->role;
> > > +    assert(role =3D=3D &child_file || role =3D=3D &child_backing);
> > > +
> > > +    bdrv_ref(node_bs);
> > > +
> > > +    bdrv_drained_begin(parent_bs);
> > > +    bdrv_unref_child(parent_bs, c);
> > > +    if (role =3D=3D &child_file) {
> > > +        parent_bs->file =3D bdrv_attach_child(parent_bs, node_bs, "f=
ile",
> > > +                                            &child_file, errp);
> > > +        if (!parent_bs->file) {
> > > +            parent_bs->file =3D bdrv_attach_child(parent_bs, child_b=
s, "file",
> > > +                                                &child_file, &error_=
abort);
> > > +            goto out;
> > > +        }
> > > +    } else if (role =3D=3D &child_backing) {
> > > +        parent_bs->backing =3D bdrv_attach_child(parent_bs, node_bs,=
 "backing",
> > > +                                               &child_backing, errp);
> > > +        if (!parent_bs->backing) {
> > > +            parent_bs->backing =3D bdrv_attach_child(parent_bs, chil=
d_bs,
> > > +                                                   "backing", &child=
_backing,
> > > +                                                   &error_abort);
> > > +            goto out;
> > > +        }
> > > +    }
> >=20
> > I would prefer if we could find a solution to avoid requiring a specific
> > role. I'm not even sure that your assertion above is correct; can you
> > explain why c couldn't have any other role?
> >=20
> > Instead of bdrv_unref_child/bdrv_attach_child, could we just change
> > where the child points to using bdrv_replace_child()? Then
>=20
> bdrv_replace_child() uses bdrv_set_perm() and co. When I tried it at firs=
t I
> got errors like "Conflicts with use by ****** as 'backing', which does not
> allow 'write' on disk". Presumably the permissions do not need to change =
but
> can we do bdrv_set_perm without bdrv_check_perm?

Which child is conflicting with which other child? Is c conflicting with
itself or something?

If unref_child/attach_child works without any other action in between,
there is no reason why replace_child shouldn't work, too. Maybe this is
a bug in bdrv_

> > parent_bs->file and parent_bs->backing (or whatever other variable
> > contains the BdrvChild pointer) can stay unchanged and just keep
> > working.
> >=20
> > > +    bdrv_refresh_filename(parent_bs);
> > > +    bdrv_refresh_limits(parent_bs, NULL);
> > > +
> > > +out:
> > > +    bdrv_drained_end(parent_bs);
> > > +}
> >=20
> > > diff --git a/blockdev.c b/blockdev.c
> > > index 8e2fc6e64c..5195ec1b61 100644
> > > --- a/blockdev.c
> > > +++ b/blockdev.c
> > > @@ -4238,3 +4238,47 @@ QemuOptsList qemu_drive_opts =3D {
> > >          { /* end of list */ }
> > >      },
> > >  };
> > > +
> > > +void qmp_block_insert_node(const char *parent, const char *child,
> > > +                           const char *node, Error **errp)
> > > +{
> > > +    BlockDriverState *bs =3D bdrv_find_node(node);
> > > +    if (!bs) {
> > > +        error_setg(errp, "Node '%s' not found", node);
> > > +        return;
> > > +    }
> > > +    if (!bs->monitor_list.tqe_prev) {
> > > +        error_setg(errp, "Node '%s' is not owned by the monitor",
> > > +                   bs->node_name);
> > > +        return;
> > > +    }
> > > +    if (!bs->drv->is_filter) {
> > > +        error_setg(errp, "Block format '%s' used by node '%s' does n=
ot support"
> > > +                   "insertion", bs->drv->format_name, bs->node_name);
> > > +        return;
> > > +    }
> > > +
> > > +    bdrv_insert_node(parent, child, node, errp);
> > > +}
> >=20
> > Do we need to acquire an AioContext lock somewhere?
>=20
> the *_child() functions call drained_begin/end which I think might cover
> this case?

I don't think it's enough when you don't own the AioContext lock.

Kevin

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZ1Nm9AAoJEH8JsnLIjy/WyOkP/RQ+tK+DPJE1asKuMF4XPKNb
oA8/tGQkOjJbCBkvodhpAu464EniVm6bxpGhykg+OoMJOxsuBe2y2N1THdFrZ3t/
GjKcgNNiD+PKNUqOOYvLFvqIiSsbgoOyUOxbqZ/MA1UuT2ipkviJGjDFx1wAsdOr
FVM41dPToBNrbTq/cNNLKbzQF1vfExEtL54GAxud9jhO1ETdK1F7uXAIh1vtOn0B
7X4f9xVEs5FQuBnGDlcDHKaFrDf7GTdSERd1jQku6VsLOTEq02sIzSRG4gujRJji
MzOyJIwMOGe9Ht5085TjnrxtD5paFNim2Ynw66m5QkYSuSIOaUVvw/PVYYmlwaID
vcPgtg2j7b4Ou/FD40SOTemHrqTYcGkEyVp0Hd5JVPthLq/i6K04EGImtKTEDY3H
unpRO+SaCAvAr5pGI7f8krVRVFCPoCvr9hmxpAP15diH5054WXnVGVdtlNViu7ra
D3STxOkiAifFe+B27lmJ4dbBOhqrOyMJ0a77LaU5zChA8GDUZUi+tXAUsNKOnl+6
McoxhzKRpmo802SPxMyjiadvoMaBN5VfH6ucvlHRgDHDxazvYDGJKx/lnstbnjOR
1VJN2S1jQFLZCm8GF2PKBTXRztZWG8SMlBtC82O9fz41jLhwwXZcV/rWA05urgOz
eJ9d5cm98oCHeebQeuh5
=tGMb
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
