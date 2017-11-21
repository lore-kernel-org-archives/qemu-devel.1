Received: from eggs.gnu.org ([2001:4830:134:3::10]:38780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHCYp-0003YY-Va
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:42:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHCYo-0005N8-NZ
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:42:16 -0500
Date: Tue, 21 Nov 2017 18:42:02 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171121174202.GD11073@localhost.localdomain>
References: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1510654613-47868-3-git-send-email-anton.nefedov@virtuozzo.com>
	<97df2225-908c-e817-8364-2454f1451768@redhat.com>
	<1dae35e5-390f-cfbe-fbd1-8c993517d596@virtuozzo.com>
	<efa75e61-f1f7-478f-b5b5-ab39491761e2@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
In-Reply-To: <efa75e61-f1f7-478f-b5b5-ab39491761e2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] qcow2: multiple clusters write
 compressed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, eblake@redhat.com, stefanha@redhat.com, famz@redhat.com, den@virtuozzo.com, Pavel Butsykin <pbutsykin@virtuozzo.com>


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 15.11.2017 um 17:30 hat Max Reitz geschrieben:
> On 2017-11-15 17:28, Anton Nefedov wrote:
> > On 15/11/2017 6:11 PM, Max Reitz wrote:
> >> On 2017-11-14 11:16, Anton Nefedov wrote:
> >>> From: Pavel Butsykin <pbutsykin@virtuozzo.com>
> >>>
> >>> At the moment, qcow2_co_pwritev_compressed can process the requests s=
ize
> >>> less than or equal to one cluster. This patch added possibility to wr=
ite
> >>> compressed data in the QCOW2 more than one cluster. The implementation
> >>> is simple, we just split large requests into separate clusters and wr=
ite
> >>> using existing functionality. For unaligned requests we use a workaro=
und
> >>> and do write data without compression.
> >>>
> >>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> >>> ---
> >>> =A0 block/qcow2.c | 77
> >>> +++++++++++++++++++++++++++++++++++++++++++----------------
> >>> =A0 1 file changed, 56 insertions(+), 21 deletions(-)
> >>
> >> On one hand, it might be better to do this centrally somewhere in
> >> block/io.c.=A0 On the other, that would require more work because it w=
ould
> >> probably mean having to introduce another field in BlockLimits, and it
> >> wouldn't do much -- because qcow (v1) is, well, qcow v1...=A0 And vmdk
> >> seems to completely not care about this single cluster limitation.=A0 =
So
> >> for now we probably wouldn't even gain anything by doing this in
> >> block/io.c.
> >>
> >> So long story short, it's OK to do this locally in qcow2, yes.
> >>
> >=20
> > [..]
> >=20
> >>> +=A0=A0=A0=A0=A0=A0=A0 qemu_iovec_reset(&hd_qiov);
> >>> +=A0=A0=A0=A0=A0=A0=A0 chunk_size =3D MIN(bytes, s->cluster_size);
> >>> +=A0=A0=A0=A0=A0=A0=A0 qemu_iovec_concat(&hd_qiov, qiov, curr_off, ch=
unk_size);
> >>> +
> >>> +=A0=A0=A0=A0=A0=A0=A0 ret =3D qcow2_co_pwritev_cluster_compressed(bs=
, offset +
> >>> curr_off,
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 chunk_size,
> >>> &hd_qiov);
> >>> +=A0=A0=A0=A0=A0=A0=A0 if (ret =3D=3D -ENOTSUP) {
> >>
> >> Why this?=A0 I mean, I can see the appeal, but then we should probably
> >> actually return -ENOTSUP somewhere (e.g. for unaligned clusters and the
> >> like) -- and we should not abort if offset_into_cluster(s, cluster) is
> >> true, but we should write the header uncompressed and compress the main
> >> bulk.
> >>
> >> Max
> >>
> >=20
> > Right, sorry, missed this part when porting the patch.
> >=20
> > I think this needs to be removed (and the commit message fixed
> > accordingly).
> > Returning an error, rather than silently falling back to uncompressed
> > seems preferable to me. "Compressing writers" (backup, img convert and
> > now stream) are aware that they have to cluster-align, and if they fail
> > to do so that means there is an error somewhere.
>=20
> OK for me.
>=20
> > If it won't return an error anymore, then the unaligned tail shouldn't
> > either. So we can end up 'letting' the callers send small unaligned
> > requests which will never get compressed.
>=20
> Either way is fine.  It just looks to me like vmdk falls back to
> uncompressed writes, so it's not like it would be completely new behavior=
=2E..
>=20
> (But I won't judge whether what vmdk does is a good idea.)

Probably not.

If we let io.c know about the cluster-size alignment requirement for
compressed writes, the usual RMW code path could kick in. Wouldn't this
actually be a better solution than uncompressed writes or erroring out?

In fact, with this, we might even be very close to an option that turns
every write into a compressed write, so you get images that stay
compressed even while they are in use.

Kevin

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaFGVqAAoJEH8JsnLIjy/WJdEP/2Qhd+FX+9iYKuRunvWISNHJ
BFURS1CP+N00gAtoJUzsgeCtT/wMg1S5eyVK6u6C8S6LwlkqyeOu2kr5eHAbwAmw
8/MEB8VR0hDvNfyp4bvzUYEE2ZqbPeVqg0Gw7d0qQy4nS89WLB8ff4zupm9Ar7ht
UfwDpEnqCapBg3Ipfpg87hVALCOR6wAJ6rXu9sf6FCqENsV8i8uMzaI0Zw/wBUHw
lrRZW4YZug8bCSamuDEWhyBxXA5aYWUvXXjQkIZm+60MXC/GSQblpWqJd0/HLzQ4
9Knx+BlGZBsBymHnTO5aNJi2bVlugTRBiW6FgkfvTHgBO8Ji0e5HPfHcUWZY3Z5J
L018CDtJeHrY9gPDDx6KKcrJeky18lxs8bCl8iC6OuFYlrNxP0IUitGt2UDutWnQ
qucvwC7nGNgbZdruDS7tiDj9vNHvz3s4+dCrCQcV/CEu8B4+eHjc5NyPMIgY6omn
dHEDLmcyODcix4J890Mni5JJKUV5oBn0KncN8apUn1uGznTQEMD73U0Gpe9XYBe9
3vHBOPzbSyXLKKJLLD6sGFIBVsG/gsBWElm1Z4CRVPuv5d8OAOWtGLuvcxNJgsJd
XVVSs0UusRPtzb1SRIghwzEW9Yg/TL3FkbfmA0cEHZWLh+dK8BHMQ9itAmdHtn6I
gqzCnivB0sktgB8pRMfd
=FW8l
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
