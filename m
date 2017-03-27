Received: from eggs.gnu.org ([2001:4830:134:3::10]:50898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1csa4C-0007ZR-DP
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 15:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1csa49-000382-4M
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 15:12:36 -0400
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:45187)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1csa48-00037m-Uo
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 15:12:33 -0400
Received: from player796.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 2149F78382
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 21:12:30 +0200 (CEST)
Date: Mon, 27 Mar 2017 21:12:20 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170327211220.1b593d47@bahia.lan>
In-Reply-To: <1490637544-15650-1-git-send-email-peter.maydell@linaro.org>
References: <1490637544-15650-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/4uk_Bt72E.ytUcZW6=2sY.=";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH for-2.9] tests/virtio-9p-test: Don't call
 le*_to_cpus on fields of packed struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

--Sig_/4uk_Bt72E.ytUcZW6=2sY.=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Mar 2017 18:59:04 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> For a packed struct like 'P9Hdr' the fields within it may not be
> aligned as much as the natural alignment for their types.  This means
> it is not valid to pass the address of such a field to a function
> like le32_to_cpus() which operate on uint32_t* and assume alignment.
> Doing this results in a SIGBUS on hosts like SPARC which have strict
> alignment requirements.
>=20
> Use ldl_le_p() instead, which is specified to correctly handle
> unaligned pointers.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

I'll apply this to my tree and send a pull request tomorrow.

Cheers.

--
Greg

> Sadly gcc doesn't warn about this:
>  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D51628
> clang supposedly was fixed to do so:
>  https://bugs.llvm.org//show_bug.cgi?id=3D22821
> but I think that commit was reverted without the bug being
> reopened; at least my clang doesn't have that warning flag.
> ---
>  tests/virtio-9p-test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
> index 43a1ad8..ad33d96 100644
> --- a/tests/virtio-9p-test.c
> +++ b/tests/virtio-9p-test.c
> @@ -256,8 +256,8 @@ static void v9fs_req_recv(P9Req *req, uint8_t id)
>          qvirtio_wait_queue_isr(v9p->dev, v9p->vq, 1000 * 1000);
> =20
>          v9fs_memread(req, &hdr, 7);
> -        le32_to_cpus(&hdr.size);
> -        le16_to_cpus(&hdr.tag);
> +        hdr.size =3D ldl_le_p(&hdr.size);
> +        hdr.tag =3D lduw_le_p(&hdr.tag);
>          if (hdr.size >=3D 7) {
>              break;
>          }


--Sig_/4uk_Bt72E.ytUcZW6=2sY.=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljZZBQACgkQAvw66wEB28LPlACfWtp55iV5qStBXQzov323VsLi
rgwAnA4qgDXGrVzMCgaT6KPEzt8PkIEn
=5KAi
-----END PGP SIGNATURE-----

--Sig_/4uk_Bt72E.ytUcZW6=2sY.=--
