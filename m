Received: from eggs.gnu.org ([208.118.235.92]:60844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gegEg-0003mv-E7
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 08:07:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gegEb-0004jF-Cg
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 08:07:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gegEb-0004iq-3s
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 08:06:57 -0500
Date: Wed, 2 Jan 2019 13:06:50 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190102130650.GM24009@stefanha-x1.localdomain>
References: <1545422632-24444-1-git-send-email-liam.merwick@oracle.com>
	<1545422632-24444-2-git-send-email-liam.merwick@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DXTueXWT3Da08pik"
Content-Disposition: inline
In-Reply-To: <1545422632-24444-2-git-send-email-liam.merwick@oracle.com>
Subject: Re: [Qemu-devel] [RFC v2 1/4] elf: Add optional function ptr to
 load_elf() to parse ELF notes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net, xen-devel@lists.xenproject.org, sgarzare@redhat.com, mst@redhat.com, maran.wilson@oracle.com, george.kennedy@oracle.com, boris.ostrovsky@oracle.com


--DXTueXWT3Da08pik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 21, 2018 at 08:03:49PM +0000, Liam Merwick wrote:
> diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> index 74679ff8da3a..37d20a3800c1 100644
> --- a/include/hw/elf_ops.h
> +++ b/include/hw/elf_ops.h
> @@ -266,6 +266,7 @@ fail:
>  }
> =20
>  static int glue(load_elf, SZ)(const char *name, int fd,
> +                              uint64_t (*elf_note_fn)(void *, void *, bo=
ol),
>                                uint64_t (*translate_fn)(void *, uint64_t),
>                                void *translate_opaque,
>                                int must_swab, uint64_t *pentry,
> @@ -496,8 +497,30 @@ static int glue(load_elf, SZ)(const char *name, int =
fd,
>                  high =3D addr + mem_size;
> =20
>              data =3D NULL;
> +
> +        } else if (ph->p_type =3D=3D PT_NOTE && elf_note_fn) {
> +            struct elf_note *nhdr =3D NULL;
> +
> +            file_size =3D ph->p_filesz; /* Size of the range of ELF note=
s */
> +            data =3D g_malloc0(file_size);
> +            if (ph->p_filesz > 0) {
> +                if (lseek(fd, ph->p_offset, SEEK_SET) < 0) {
> +                    goto fail;
> +                }
> +                if (read(fd, data, file_size) !=3D file_size) {
> +                    goto fail;
> +                }
> +            }
> +
> +            if (nhdr !=3D NULL) {
> +                bool is64 =3D
> +                    sizeof(struct elf_note) =3D=3D sizeof(struct elf64_n=
ote);
> +                elf_note_fn((void *)nhdr, (void *)&ph->p_align, is64);

How does data get used?

> +            }
> +            g_free(data);

Missing data =3D NULL to prevent double free later?

--DXTueXWT3Da08pik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcLLdqAAoJEJykq7OBq3PIPNUIAMlYfpbNVFsonh226rbJaR3w
YSt+vscNyY1R2INl6kh2p9zdUi3CEU4jdzTK7s3IhvwIeGi6rsefFl3ugrL7rDGv
V8oJjii8OE+5P9eteDERVAWExWCzssTu4pc/DCOAUx3u7SR/xgVXTprtmjM2HCkC
4P2P6YQdILerjRFCVI+CoYGn3lYpGg+6ZFxldZMjtoMzHCwk0b+EXip6v3pIlwoN
wVbyIcft2sGHqDEXXNHHx6FuXOxba7PK+esv7EKLMtQaFC9mV/WGEOMnyabvICoy
CZFi9KcL38fOEUtsgkNqpJAisWSFcPqVgjpMr0HsUlw5hjpa3z7V+QFpLjfE1es=
=FlQZ
-----END PGP SIGNATURE-----

--DXTueXWT3Da08pik--
