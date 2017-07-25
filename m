Received: from eggs.gnu.org ([2001:4830:134:3::10]:51758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da7Tr-0007nV-JZ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da7Tq-0007o3-Cu
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:35:03 -0400
References: <1500993699-19299-1-git-send-email-pl@kamp.de>
	<1500993699-19299-5-git-send-email-pl@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <40d3e043-7a70-5d23-f4a2-10453d7653a8@redhat.com>
Date: Tue, 25 Jul 2017 16:34:54 -0500
MIME-Version: 1.0
In-Reply-To: <1500993699-19299-5-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CGeiF9duN8lK6gF3vQvIqBpCd9XLsSXHS"
Subject: Re: [Qemu-devel] [PATCH V5 04/10] qemu-img: add documentation for
 compress settings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CGeiF9duN8lK6gF3vQvIqBpCd9XLsSXHS
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com,
 den@openvz.org, mreitz@redhat.com, berrange@redhat.com
Message-ID: <40d3e043-7a70-5d23-f4a2-10453d7653a8@redhat.com>
Subject: Re: [PATCH V5 04/10] qemu-img: add documentation for compress
 settings
References: <1500993699-19299-1-git-send-email-pl@kamp.de>
 <1500993699-19299-5-git-send-email-pl@kamp.de>
In-Reply-To: <1500993699-19299-5-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/25/2017 09:41 AM, Peter Lieven wrote:
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  qemu-img.texi | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/qemu-img.texi b/qemu-img.texi
> index 72dabd6..3612c59 100644
> --- a/qemu-img.texi
> +++ b/qemu-img.texi
> @@ -676,6 +676,32 @@ file which is COW and has data blocks already, it =
couldn't be changed to NOCOW
>  by setting @code{nocow=3Don}. One can issue @code{lsattr filename} to =
check if
>  the NOCOW flag is set or not (Capital 'C' is NOCOW flag).
> =20
> +@item compress.format
> +Defines which compression algorithm is should be used for compressed c=
lusters.
> +The following options are available if support for the respective libr=
aries
> +has been enabled at compile time:
> +
> +   deflate        Uses standard zlib defalte compression
> +
> +The compression algorithm can only be defined at image create time and=
 cannot
> +be changed later.

We can't change it via 'qemu-img amend'?  Might be an interesting
feature to add later: in-place re-compression to a new algorithm - but
since compression is global to the file, you have to be careful that
aborting the operation in the middle doesn't mix the two compressions.
Or put another way, we have to use at least twice the disk space for all
compressed clusters, and only at the end of things update the headers to
point to the new clusters and away from the old (so that an early abort
just treats all the new clusters as leaked); possibly by amending from
compressed to uncompressed back to compressed.

Oh, and why is 'qemu-img --help' mostly alphabetical, except that
'amend' comes after 'resize'?  Guess I'll do a quickie patch for that.


> +
> +Note: defining compression format settings which are different from th=
e old
> +      default (format=3Ddeflate, level=3D0, window-size=3D12) will res=
ult in the
> +      compression format extension being written to the Qcow2 image. V=
ersions
> +      of QEMU before 2.11 will not be able to open images with this ex=
tension.
> +
> +@item compress.level
> +Valid for compress.format=3Ddeflate defines the compression level to u=
se for
> +selected compression format. The default of @code{compress.level=3D0} =
will use
> +the default compression level for the format. Alternate values range f=
rom 1 for
> +fastest compression to 9 for the best compression.
> +
> +@item compress.window-size
> +Valid for compress.format=3Ddeflate defines the compression window siz=
e used
> +during compression. Valid window sizes for deflate compression range f=
rom 8 to
> +15 inclusively. The default is @code{compress.window-size=3D15}.

Maybe emphasize that larger is generally better (smaller exists for the
long-gone days of small machines, and for back-compat usage of 12 in
older qemu).  In fact, if we wanted, we could declare that qcow2's use
of deflate can ONLY use 12 or 15, instead of anything in the range 8-15,
if we though that would be easier to maintain.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CGeiF9duN8lK6gF3vQvIqBpCd9XLsSXHS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll3uX4ACgkQp6FrSiUn
Q2oUDwf/S7cMCAH9hlk2zMArCBXO9MZcnXIdxjDPUHc0zUaphtRcEI59T8xr00iL
CT/xeL8KouYYqgqmjPlGGNgDJ+ecYRNZzH3d4OFb3b3PwQ26soScNDRJrZ4vSeAE
LwZWbUnOiqJSSzMgWhkq+Vmm9MihmFN/QD5lORVRT1Jd5fuEgYIhanjGX9aZo0xO
TYLUGA5UgOAwApeHY5Aa7s8V95I6sgnZHvWhg+gKGIy7AonBl4ZDDGBThAHN5XWd
2eNSxgsSsbUtqyKNeK+np11H5WSDbep0DyVtQaiHnEuG+sMN+zNmwRlhPDoVjYzi
xdXp7zedoWQ1nlBGhV5VF2z1smowqA==
=Bpf9
-----END PGP SIGNATURE-----

--CGeiF9duN8lK6gF3vQvIqBpCd9XLsSXHS--
