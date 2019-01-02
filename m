Received: from eggs.gnu.org ([208.118.235.92]:33895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gegKD-00063a-U7
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 08:12:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gegK8-00015I-U2
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 08:12:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gegK6-00013E-Tp
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 08:12:40 -0500
Date: Wed, 2 Jan 2019 13:12:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190102131234.GN24009@stefanha-x1.localdomain>
References: <1545422632-24444-1-git-send-email-liam.merwick@oracle.com>
	<1545422632-24444-3-git-send-email-liam.merwick@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b1ERR0FXR0PvNIRE"
Content-Disposition: inline
In-Reply-To: <1545422632-24444-3-git-send-email-liam.merwick@oracle.com>
Subject: Re: [Qemu-devel] [RFC v2 2/4] elf-ops.h: Add get_elf_note_type()
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


--b1ERR0FXR0PvNIRE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 21, 2018 at 08:03:50PM +0000, Liam Merwick wrote:
> +    while (note_type !=3D elf_note_type) {
> +        nhdr_namesz =3D nhdr->n_namesz;
> +        nhdr_descsz =3D nhdr->n_descsz;
> +
> +        elf_note_entry_offset =3D nhdr_size +
> +            QEMU_ALIGN_UP(nhdr_namesz, phdr_align) +
> +            QEMU_ALIGN_UP(nhdr_descsz, phdr_align);
> +
> +        /* If the offset calculated in this iteration exceeds the
> +	 * supplied size, we are done and no matching note was found.
> +	 */

Indentation is off here.  QEMU uses 4-space indentation.

> +        if (elf_note_entry_offset > note_size) {
> +            return NULL;
> +        }
> +
> +        /* skip to the next ELF Note entry */
> +        nhdr =3D (void *)nhdr + elf_note_entry_offset;
> +        note_type =3D nhdr->n_type;
> +    }
> +
> +    return nhdr;
> +}
> +
>  static int glue(load_elf, SZ)(const char *name, int fd,
>                                uint64_t (*elf_note_fn)(void *, void *, bo=
ol),
>                                uint64_t (*translate_fn)(void *, uint64_t),
> @@ -512,6 +555,13 @@ static int glue(load_elf, SZ)(const char *name, int =
fd,
>                  }
>              }
> =20
> +	    /* Search the ELF notes to find one with a type matching the
> +	     * value passed in via 'translate_opaque'
> +	     */
> +            nhdr =3D (struct elf_note *)data;

Ah, I see data gets used here!  It would be clearer to move loading of
data into this patch.

> +	    assert(translate_opaque !=3D NULL);
> +            nhdr =3D glue(get_elf_note_type, SZ)(nhdr, file_size, ph->p_=
align,
> +                                               *(uint64_t *)translate_op=
aque);

Indentation is off in this hunk.  QEMU uses 4-space indentation.

--b1ERR0FXR0PvNIRE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcLLjCAAoJEJykq7OBq3PIZ/EH/ipgOt8ASb7G9HtihUXxltlG
FpiavcTULh6RYCjIP0k5h/EM78MOZwXCKgG0xZQg5QrqR3WzuBhmVukRfLAnJsPK
HzrQREc/P7GzkQJtrWjiWDmVIvmw6QrBx7BUOAMCGqx6ewFvyRj3eo65tzMSCVeq
+tc7PYtc7sOP7BR0jrX5y6t+NcuENhEBJVF5oXqoB35Sdyh/xmeOXnHKL/1ltiSr
q6unzKvvEA/nM/j/m09FUzVyqM1AKQpJDM+uHMlFtZO2llEmMzGLLKJjF3FSiY5C
tEGQB3xGVAgHjkCjo5Ci5LqbdoGpgB2yyB423WLuqcC9YdzfUwKm7rWJ7bam1eY=
=zvH5
-----END PGP SIGNATURE-----

--b1ERR0FXR0PvNIRE--
