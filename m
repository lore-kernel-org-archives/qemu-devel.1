Received: from eggs.gnu.org ([2001:4830:134:3::10]:57316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dtsTL-0002gU-PC
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dtsTH-00024N-R8
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:36:11 -0400
Date: Mon, 18 Sep 2017 11:35:57 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170918093557.GE31915@localhost.localdomain>
References: <20170915101008.16646-1-kwolf@redhat.com>
	<20170915101008.16646-7-kwolf@redhat.com>
	<726a7ef6-820b-2695-4ce5-ffa06da078d1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <726a7ef6-820b-2695-4ce5-ffa06da078d1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 6/6] block: Fix permissions after
 bdrv_reopen()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 15.09.2017 um 21:06 hat Eric Blake geschrieben:
> On 09/15/2017 05:10 AM, Kevin Wolf wrote:
> > If we switch between read-only and read-write, the permissions that
> > image format drivers need on bs->file change, too. Make sure to update
> > the permissions during bdrv_reopen().
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  include/block/block.h |  1 +
> >  block.c               | 64 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  2 files changed, 65 insertions(+)
> >=20
>=20
> > +static BlockReopenQueueEntry *find_parent_in_reopen_queue(BlockReopenQ=
ueue *q,
> > +                                                          BdrvChild *c)
> > +{
> > +    BlockReopenQueueEntry *entry;
> > +
> > +    QSIMPLEQ_FOREACH(entry, q, entry) {
> > +        BlockDriverState *bs =3D entry->state.bs;
> > +        BdrvChild *child;
> > +
> > +        QLIST_FOREACH(child, &bs->children, next) {
> > +            if (child =3D=3D c) {
> > +                return entry;
>=20
> An O(n^2) loop. Is it going to bite us at any point in the future, or
> are we generally dealing with a small enough queue size and BDS graph to
> not worry about it?

The loops you're quoting aren't O(n^2), they don't loop over the same
thing. This part is O(n) in terms of BdrvChild elements looked at.

The thing that worried me a bit more is the caller:

+    QLIST_FOREACH(c, &bs->parents, next_parent) {
+        parent =3D find_parent_in_reopen_queue(q, c);

This is indeed O(n^2) (again with n =3D number of BdrvChild elements) in
the pathological worst case of a quorum node where all children point to
the same node.

As soon as all parents of the node are distinct - and I don't see any
reason why they wouldn't in practice - we're back to O(n) because each
BdrvChild belongs to only one parent. Even if we ever introduce a driver
where having the same node as a child in a constant number of different
roles makes sense for a parent (i.e. anything that doesn't involve an
(unbounded) array of children), we would still be O(n) with an additional
small constant factor.

So I think in practice we should be okay.

Kevin

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZv5N9AAoJEH8JsnLIjy/W2G8QALkkwHv1yDKhiBygc3fn5ekP
Tfge9rWE5Hh21pDyv9qwdUDb7qUMb1JylpNkSt7t8uM6Jvoxa+HfC0sl1Zjl8ECA
UKdjF1IQjKtOGoUksJcihirgdWCxEuGVMA5NZG4sB3IbUoJ68j1YobhWvFkSGYO0
DFwZ81udFgfNIToQZ0yiicrB58jj/SeE9+RXMJqUndJwElRVO45hvioiR7oEYCYN
ZuTwdn3MZF6mkIRi6v0Du9VcGaVBvxIcoBW0YexkiD5saCKqkPM9UP+cRUA7IpVd
pjCx3lljJnQ0QLhQWKM3pE3PDqRsLRNM3T5wkcLPlTuh+eZKAs37rpXnZ5NUhDET
4jKE5ANjP9IjCeCFROg57fQidYqhLmrFhVnRFqHyODHNFElujDAEpJ2BUnfnWmpg
pmElCiC6qqjrmqxv9vFuks3sVKyip13XSLFg/JvV2iFbl5Sq26naFpQn4CwFGun5
oHKazAx4O2qsa2h79RrRlvdjjmQlHvIxciT16wVi63jL6F5rE668A1Pmiv0vleam
k7yDJVOvXiQWLBlZUg6R8Wf9/IyBBf7CACVGDts2cYTAMYh4TKH70/9ubAUIkx45
zX+aEh/tWggeGo5FQ2YRP8t+DxLicO7z34IJI7rU5xl/kv8KGxlabFSfQr3l7fD6
CR3rTRthaCOLrp9inFlJ
=Esgy
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
