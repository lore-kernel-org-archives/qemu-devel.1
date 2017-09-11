Received: from eggs.gnu.org ([2001:4830:134:3::10]:45734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drWNN-0002zn-Fa
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drWNK-000086-Br
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:36:17 -0400
Received: from 13.mo1.mail-out.ovh.net ([178.33.253.128]:45362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1drWNK-00007T-5M
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:36:14 -0400
Received: from player169.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id B29F393207
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 23:36:12 +0200 (CEST)
Date: Mon, 11 Sep 2017 23:35:57 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170911233557.0925e053@bahia.lan>
In-Reply-To: <20170911172022.4738-36-eblake@redhat.com>
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-36-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/twt01Ge2l7AF9hhhRsA4uZj";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v7 35/38] libqtest: Merge qtest_{mem,
 buf}{read, write}() with {mem, buf}{read, write}()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, thuth@redhat.com, John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "Aneesh
	Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, "open list:IDE" <qemu-block@nongnu.org>, "open
	list:sPAPR" <qemu-ppc@nongnu.org>

--Sig_/twt01Ge2l7AF9hhhRsA4uZj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Sep 2017 12:20:19 -0500
Eric Blake <eblake@redhat.com> wrote:

> Maintaining two layers of libqtest APIs, one that takes an explicit
> QTestState object, and the other that uses the implicit global_qtest,
> is annoying.  In the interest of getting rid of global implicit
> state and having less code to maintain, merge:
>  qtest_memread()
>  qtest_bufread()
>  qtest_memwrite()
>  qtest_bufwrite()
> with their short counterparts.  All callers that previously
> used the short form now make it explicit that they are relying on
> global_qtest, and later patches can then clean things up to remove
> the global variable.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/libqtest.h         | 69 ++++++------------------------------------=
------
>  tests/libqtest.c         |  8 +++---
>  tests/ahci-test.c        | 16 +++++------
>  tests/e1000e-test.c      | 16 ++++++-----
>  tests/i440fx-test.c      |  8 +++---
>  tests/ide-test.c         | 14 +++++-----
>  tests/libqos/ahci.c      | 22 +++++++--------
>  tests/libqos/pci-pc.c    |  4 +--
>  tests/libqos/pci-spapr.c |  4 +--
>  tests/megasas-test.c     |  2 +-
>  tests/postcopy-test.c    | 12 ++++-----
>  tests/virtio-9p-test.c   |  4 +--
>  tests/virtio-blk-test.c  | 16 +++++------
>  tests/virtio-net-test.c  |  6 ++---
>  tests/virtio-scsi-test.c |  4 +--
>  15 files changed, 78 insertions(+), 127 deletions(-)
>=20
[...]
> diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
> index 07cbb7f37c..e2a14bc2ff 100644
> --- a/tests/virtio-9p-test.c
> +++ b/tests/virtio-9p-test.c
> @@ -116,7 +116,7 @@ typedef struct {
>=20
>  static void v9fs_memwrite(P9Req *req, const void *addr, size_t len)
>  {
> -    memwrite(req->t_msg + req->t_off, addr, len);
> +    memwrite(global_qtest, req->t_msg + req->t_off, addr, len);

Maybe use req->v9p->qs->qts instead of global_qtest ?

>      req->t_off +=3D len;
>  }
>=20
> @@ -132,7 +132,7 @@ static void v9fs_memrewind(P9Req *req, size_t len)
>=20
>  static void v9fs_memread(P9Req *req, void *addr, size_t len)
>  {
> -    memread(req->r_msg + req->r_off, addr, len);
> +    memread(global_qtest, req->r_msg + req->r_off, addr, len);

Same here.

But this can be done in a follow-up patch. In case you don't respin, for
tests/virtio-9p-test.c:

Acked-by: Greg Kurz <groug@kaod.org>

--Sig_/twt01Ge2l7AF9hhhRsA4uZj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWbcBvQAKCRAC/DrrAQHb
wluYAKCS7FQYmY2d+os/uzxS5268HdioHgCZAQfLUrs/8tuaEX2jB/e0nmW6TTY=
=tqOd
-----END PGP SIGNATURE-----

--Sig_/twt01Ge2l7AF9hhhRsA4uZj--
