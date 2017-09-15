Received: from eggs.gnu.org ([2001:4830:134:3::10]:41118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dss2k-0006ek-O3
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 10:56:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dss2h-00066T-JP
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 10:56:34 -0400
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:47539)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dss2h-00065A-9h
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 10:56:31 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id A8793AB560
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 16:56:28 +0200 (CEST)
Date: Fri, 15 Sep 2017 16:56:24 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170915165624.1e9b51c2@bahia.lan>
In-Reply-To: <1505406696-2260-1-git-send-email-jan.dakinevich@gmail.com>
References: <1505406696-2260-1-git-send-email-jan.dakinevich@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/VEVTccEPAUCBKS0lHAtlnXV";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] 9pfs: check the size of transport buffer
 before marshaling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Dakinevich <jan.dakinevich@gmail.com>
Cc: qemu-devel@nongnu.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

--Sig_/VEVTccEPAUCBKS0lHAtlnXV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Sep 2017 19:31:36 +0300
Jan Dakinevich <jan.dakinevich@gmail.com> wrote:

> v9fs_do_readdir_with_stat() and v9fs_do_readdir() stores as much data in
> the buffer as can fit unless marshaling erorr occurs. However, after
> commit 23a006d the behavior pdu_marshal was changed, and on error the
> routine assumes that buffers are misconfigured and breaks communication.
>=20

I agree and I could easily reproduce with a linux guest using 9p2000.u, ie,=
 the
v9fs_do_readdir_with_stat() case, but I couldn't find a way to break transp=
ort
with 9p2000.L. Do you have a reproducer for the latter ?

I ask because I would appreciate to see some more details in the changelog,
for the records.

> Signed-off-by: Jan Dakinevich <jan.dakinevich@gmail.com>
> ---

Anyway the patch looks fine, but I'll wait for your answer before pushing
to 9p-next.

Cheers,

--
Greg

>  hw/9pfs/9p.c | 44 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 1e38109..8e0b87e 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1679,6 +1679,16 @@ static void v9fs_init_qiov_from_pdu(QEMUIOVector *=
qiov, V9fsPDU *pdu,
>      qemu_iovec_concat(qiov, &elem, skip, size);
>  }
> =20
> +static size_t v9fs_marshal_size(V9fsPDU *pdu)
> +{
> +    struct iovec *iov;
> +    unsigned int niov;
> +
> +    pdu->s->transport->init_in_iov_from_pdu(pdu, &iov, &niov, 0);
> +
> +    return iov_size(iov, niov);
> +}
> +
>  static int v9fs_xattr_read(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fid=
p,
>                             uint64_t off, uint32_t max_count)
>  {
> @@ -1725,6 +1735,10 @@ static int coroutine_fn v9fs_do_readdir_with_stat(=
V9fsPDU *pdu,
>      off_t saved_dir_pos;
>      struct dirent *dent;
> =20
> +    /* 11 =3D 7 + 4 (7 =3D start offset, 4 =3D space for storing count) =
*/
> +    size_t offset =3D 11;
> +    size_t marshal_size =3D v9fs_marshal_size(pdu);
> +
>      /* save the directory position */
>      saved_dir_pos =3D v9fs_co_telldir(pdu, fidp);
>      if (saved_dir_pos < 0) {
> @@ -1752,18 +1766,23 @@ static int coroutine_fn v9fs_do_readdir_with_stat=
(V9fsPDU *pdu,
>          if (err < 0) {
>              break;
>          }
> -        /* 11 =3D 7 + 4 (7 =3D start offset, 4 =3D space for storing cou=
nt) */
> -        len =3D pdu_marshal(pdu, 11 + count, "S", &v9stat);
> =20
> -        v9fs_readdir_unlock(&fidp->fs.dir);
> +        if (v9stat.size + 2 > MIN(marshal_size - offset, max_count - cou=
nt)) {
> +            v9fs_readdir_unlock(&fidp->fs.dir);
> =20
> -        if ((len !=3D (v9stat.size + 2)) || ((count + len) > max_count))=
 {
>              /* Ran out of buffer. Set dir back to old position and retur=
n */
>              v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
>              v9fs_stat_free(&v9stat);
>              v9fs_path_free(&path);
>              return count;
>          }
> +
> +        len =3D pdu_marshal(pdu, offset, "S", &v9stat);
> +        BUG_ON(len !=3D v9stat.size + 2);
> +
> +        v9fs_readdir_unlock(&fidp->fs.dir);
> +
> +        offset +=3D len;
>          count +=3D len;
>          v9fs_stat_free(&v9stat);
>          v9fs_path_free(&path);
> @@ -1884,6 +1903,10 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *p=
du, V9fsFidState *fidp,
>      off_t saved_dir_pos;
>      struct dirent *dent;
> =20
> +    /* 11 =3D 7 + 4 (7 =3D start offset, 4 =3D space for storing count) =
*/
> +    size_t offset =3D 11;
> +    size_t marshal_size =3D v9fs_marshal_size(pdu);
> +
>      /* save the directory position */
>      saved_dir_pos =3D v9fs_co_telldir(pdu, fidp);
>      if (saved_dir_pos < 0) {
> @@ -1899,7 +1922,8 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pd=
u, V9fsFidState *fidp,
>          }
>          v9fs_string_init(&name);
>          v9fs_string_sprintf(&name, "%s", dent->d_name);
> -        if ((count + v9fs_readdir_data_size(&name)) > max_count) {
> +        if (v9fs_readdir_data_size(&name) > MIN(marshal_size - offset,
> +                                                max_count - count)) {
>              v9fs_readdir_unlock(&fidp->fs.dir);
> =20
>              /* Ran out of buffer. Set dir back to old position and retur=
n */
> @@ -1918,18 +1942,14 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *=
pdu, V9fsFidState *fidp,
>          qid.type =3D 0;
>          qid.version =3D 0;
> =20
> -        /* 11 =3D 7 + 4 (7 =3D start offset, 4 =3D space for storing cou=
nt) */
> -        len =3D pdu_marshal(pdu, 11 + count, "Qqbs",
> +        len =3D pdu_marshal(pdu, offset, "Qqbs",
>                            &qid, dent->d_off,
>                            dent->d_type, &name);
> +        BUG_ON(len !=3D v9fs_readdir_data_size(&name));
> =20
>          v9fs_readdir_unlock(&fidp->fs.dir);
> =20
> -        if (len < 0) {
> -            v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
> -            v9fs_string_free(&name);
> -            return len;
> -        }
> +        offset +=3D len;
>          count +=3D len;
>          v9fs_string_free(&name);
>          saved_dir_pos =3D dent->d_off;


--Sig_/VEVTccEPAUCBKS0lHAtlnXV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWbvqGAAKCRAC/DrrAQHb
wrzjAJ9pyt1gUteUQ427GNDHw8iwFWBcqwCgmVkNsW0ctryzGSXEKg031upAUzY=
=3GMz
-----END PGP SIGNATURE-----

--Sig_/VEVTccEPAUCBKS0lHAtlnXV--
