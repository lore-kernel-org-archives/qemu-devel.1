Received: from eggs.gnu.org ([2001:4830:134:3::10]:55236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckzrB-00049M-Pi
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 16:07:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckzrA-0008HJ-9i
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 16:07:49 -0500
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
	<1488817322-11397-9-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <83d6bdd5-0f46-76c4-5459-e8a6b8dcefb8@redhat.com>
Date: Mon, 6 Mar 2017 15:07:40 -0600
MIME-Version: 1.0
In-Reply-To: <1488817322-11397-9-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rfuLLmHMB3JeBIosn6Ao5VhnNllGcNAoP"
Subject: Re: [Qemu-devel] [PATCH 08/10] block: Ignore multiple children in
 bdrv_check_update_perm()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rfuLLmHMB3JeBIosn6Ao5VhnNllGcNAoP
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Message-ID: <83d6bdd5-0f46-76c4-5459-e8a6b8dcefb8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/10] block: Ignore multiple children in
 bdrv_check_update_perm()
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
 <1488817322-11397-9-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488817322-11397-9-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/06/2017 10:22 AM, Kevin Wolf wrote:
> change_parent_backing_link() will need to update multiple BdrvChild
> objects at once. Checking permissions reference by reference doesn't
> work because permissions need to be consistent only with all parents
> moved to the new child.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c                   | 35 ++++++++++++++++++++++-------------
>  include/block/block_int.h |  2 +-
>  2 files changed, 23 insertions(+), 14 deletions(-)
>=20


>  static int bdrv_check_update_perm(BlockDriverState *bs, uint64_t new_u=
sed_perm,
>                                    uint64_t new_shared_perm,
> -                                  BdrvChild *ignore_child, Error **err=
p)
> +                                  GSList *ignore_children, Error **err=
p)
>  {
>      BdrvChild *c;
>      uint64_t cumulative_perms =3D new_used_perm;
> @@ -1572,7 +1574,7 @@ static int bdrv_check_update_perm(BlockDriverStat=
e *bs, uint64_t new_used_perm,
>      assert(new_shared_perm & BLK_PERM_WRITE_UNCHANGED);
> =20
>      QLIST_FOREACH(c, &bs->parents, next_parent) {
> -        if (c =3D=3D ignore_child) {
> +        if (g_slist_find(ignore_children, c)) {

Quadratic complexity (searching one list for each element of another
list). Hopefully the combination of lists isn't too long in practice (it
might be a potential problem if someone creates 200 snapshots then tries
to commit them down to 1 image in a single operation, where
ignore_children would then be a long list of intermediate children being
iterated on multiple times, but I don't know if bs->parents can easily
be made as long).  We could always create some sort of hash table to
reduce complexity, as a followup patch, if it turns out to be a problem
in practice, but for now I'm okay with it.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--rfuLLmHMB3JeBIosn6Ao5VhnNllGcNAoP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvc+cAAoJEKeha0olJ0NqS8oH/ioa0l+NRGrDpBYFyAB8Jbm6
p/A/f02SJbc+rChvU62MCnengLIL/FA67naYORgiulRA24kMJT+cmW+bV+ql+30A
18vhJo0f0ReOobEt8iasfrXRTZh7YMaUmW7JmTbbJMv725CAgZSv31BgsFl0vYt7
u8GnJHQZKElGFJ2Z4JNFonVm4XuiALIRzUl7a0liIiYMnI9BzNuonVtX+5j8eo34
K5rys6robi0wUZp/vtkFysaV2W9jXv9sVfm6VYnDED8YFiExW3KbQXulz8Rs/2Kg
eVJOGz52d3BgtyppJAkGjcdiXuQtgKoncCeBWuSIWPlfKO/xKbOB9THvNl48fjs=
=oAkL
-----END PGP SIGNATURE-----

--rfuLLmHMB3JeBIosn6Ao5VhnNllGcNAoP--
