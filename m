Received: from eggs.gnu.org ([2001:4830:134:3::10]:42255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciJCi-00036C-Ot
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:10:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciJCd-0006oi-GQ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:10:56 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:32833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ciJCd-0006oe-9p
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:10:51 -0500
Received: by mail-wm0-x244.google.com with SMTP id v77so12873186wmv.0
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 03:10:51 -0800 (PST)
Date: Mon, 27 Feb 2017 11:10:47 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170227111047.GF28403@stefanha-x1.localdomain>
References: <20170223105922.22989-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gdTfX7fkYsEEjebm"
Content-Disposition: inline
In-Reply-To: <20170223105922.22989-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] os: don't corrupt pre-existing
 memory-backend data with prealloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Jitendra Kolhe <jitendra.kolhe@hpe.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Michal Privoznik <mprivozn@redhat.com>, Rik van Riel <riel@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>


--gdTfX7fkYsEEjebm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2017 at 10:59:22AM +0000, Daniel P. Berrange wrote:
> When using a memory-backend object with prealloc turned on, QEMU
> will memset() the first byte in every memory page to zero. While
> this might have been acceptable for memory backends associated
> with RAM, this corrupts application data for NVDIMMs.
>=20
> Instead of setting every page to zero, read the current byte
> value and then just write that same value back, so we are not
> corrupting the original data.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>=20
> I'm unclear if this is actually still safe in practice ? Is the
> compiler permitted to optimize away the read+write since it doesn't
> change the memory value. I'd hope not, but I've been surprised
> before...
>=20
> IMHO this is another factor in favour of requesting an API from
> the kernel to provide the prealloc behaviour we want.
>=20
>  util/oslib-posix.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 35012b9..8f5b656 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -355,7 +355,8 @@ void os_mem_prealloc(int fd, char *area, size_t memor=
y, Error **errp)
> =20
>          /* MAP_POPULATE silently ignores failures */
>          for (i =3D 0; i < numpages; i++) {
> -            memset(area + (hpagesize * i), 0, 1);
> +            char val =3D *(area + (hpagesize * i));
> +            memset(area + (hpagesize * i), 0, val);

Please include a comment in the final patch explaining why we want to
preserve memory contents.

In the case of NVDIMM I'm not sure if the memset is needed at all.  The
memory already exists - no new pages need to be allocated by the kernel.
We just want the page table entries to be populated for the NVDIMM when
-mem-prealloc is used.

Perhaps Andrea or Rik have ideas on improving the kernel interface and
whether mmap(MAP_POPULATE) should be used with NVDIMM instead of this
userspace "touch every page" workaround?

Stefan

--gdTfX7fkYsEEjebm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYtAk3AAoJEJykq7OBq3PIaFEH/1JLhmu08IrMbTkTRfryiGc0
kwrwbSlzUQhpZwESo5qBX0ZZUzUeoIMFwSc45TS12zS750HONNZc0QSqImRXyGYH
FKiF4swLwzQgQcPuY3JfQTsUeBVwAfbLzoOjdSOS+MSbEl50JE8xT1S9MFupNrAp
ezdJAYYEyUzFHSdq9EQEMxfrup07Te/xc7IdTrrUafKCTAt9iWMp/ts+UWZqhebe
FaTj9LNfb49gZGuQ1Le/8iXlabNe+JZKtJbZH3Nan6StJGOO3w3Z4L3qdu4b/J8/
dVvLhQjHBk7xX8S5mYs/ih+zX2w4umMNkMr8cQZNpH9MiCaD6L2aQ62dE46c820=
=G88n
-----END PGP SIGNATURE-----

--gdTfX7fkYsEEjebm--
