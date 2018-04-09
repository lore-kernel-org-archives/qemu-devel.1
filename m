Received: from eggs.gnu.org ([2001:4830:134:3::10]:35360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f5SqG-0007BT-NF
	for Qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:12:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f5SqB-0004rj-P0
	for Qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:12:00 -0400
Date: Mon, 9 Apr 2018 11:11:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180409091146.GC5294@localhost.localdomain>
References: <9b490d71-4f3e-9069-9c92-89d27e107f57@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <9b490d71-4f3e-9069-9c92-89d27e107f57@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] block-stream/commit and mixing
 internal and external snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 07.04.2018 um 00:16 hat Eric Blake geschrieben:
> Perhaps others have already known this, but I just realized that if you
> mix internal and external snapshots, you can set yourself up for massive
> failures when trying to use block-stream or block-commit to consolidate
> data across the external backing chain, without also thinking about the
> internal snapshots.

Yeah, internal and external snapshots don't mix well. Basically, the
only thing that will work reliably is having a qcow2 image with internal
snapshots at the top, and then an immutable backing chain without
internal snapshots below it.

> Here's a quick demonstration:
> [...]
>=20
> The root cause to all of this is that right now, ALL internal snapshots
> share the same backing file information in the file header; but
> block-stream operations only modify the active snapshot.  The actions of
> changing the backing file or of rewriting the clusters in the backing
> file don't break the active snapshot, but DO bleed through to the
> internal snapshots, for any cluster where the internal snapshot was
> relying on the backing file.
>=20
> Does this mean we should make it harder to perform external block
> operations on a qcow2 file that has internal snapshots (either refuse
> outright, or at least require a 'force' flag to let the user acknowledge
> the risk)?  Similarly, should it be harder to create an internal
> snapshot when an image already has an external backing file, and/or
> should we improve the qcow2 specification of internal snapshot
> descriptors to record a per-snapshot backing file rather than the
> current approach that all snapshots share the same backing file?
> Whether or not we track a per-snapshot backing file, should the presence
> of internal snapshots be used to request op-blockers for read
> consistency on backing files?

Op blockers can't really protect a node against itself. As far as the
backing file node is concerned, nothing bad has happened. It is still
fully consistent and it hasn't been written to. It just isn't used any
more by its parent node.

Possibly we can use a blocker to enforce that the backing file child
isn't changed, but that would be something like a BLK_PERM_GRAPH_MOD
permission that we failed to define precisely so far.

Other than that, if you want to make the merge of the external snapshots
fail, maybe the only thing you could do is returning an error in when
trying to change the backing file link in qcow2_change_backing_file()
while there are internal snapshots. I'm not sure that this will result
in a good state, though, and it is only called at the very end of the
block job (i.e. all data is already copied), so it's not a nice failure
mode.

Kevin

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJayy5SAAoJEH8JsnLIjy/WHfoP/RU4w9776cCOKhbG3nIVFkQW
srMOIsxGYLou2KnL1fqgTr8qQcmmyC775Ou6Mnmz0pmjMpT7dRIX3t7q4Y4w5CdP
i9a6A0jJ+rmgCT3KutushHKfaiQwZ7UFzRh60GJpBDmyK28bq9x+fdXMs/frbMkp
fOjVRsv13iecVQUcClVD3HgQbmD/ux+R8Jz7umk1wSI/VSdAXf8b7CkmytJdCaTF
Rpk5FqK8J4S10twZ99jtETYQrqCYgKKIS7JAKAstY7W69JXNapCCBfOoN6wphi/6
X7EljXCi4fFY7IOMCirv4yWg/xkyS/itOTfKjnZZp7O9ACLAIkTqRx7MAe8WZp9C
1M7oCYFUYUxbuWWEOzLkYgNNxrzbJtRBLy6P4xzawJmVbQ2uO5n+6XSZfLKDQFXe
aaRlGxUhEboroG2OKN62/qQRjSgGuL3tMVkaQX8dUBk7aVobrKOcsZEG7p6HyM8z
qIxl1yOA1w8XIbr+F8h/2Ywyrni1k0SDW3tpgUGEKoSJGeHIvLRNCo9AoZA1P+YA
F3O/sL3pAM65yy1pQIztTsgST4oEtrCkn5TmsVNscExbOJ5t/XXRQY8Zpjz+nYmJ
i+8nrZzPcWEInolSic7X/s6cOCEXc3CK5xJjhaIwDTLQcrd2yrzn1fHy3xd7j6G6
OXmzl6m+bnDx6XRC5AgI
=oRIr
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
