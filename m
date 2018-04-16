Received: from eggs.gnu.org ([2001:4830:134:3::10]:57059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f7ybX-0006qd-5p
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 03:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f7ybS-00076y-4v
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 03:31:11 -0400
Received: from mail-pl0-x235.google.com ([2607:f8b0:400e:c01::235]:33537)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f7ybR-00076i-UX
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 03:31:06 -0400
Received: by mail-pl0-x235.google.com with SMTP id w12-v6so8622281plp.0
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 00:31:05 -0700 (PDT)
Date: Mon, 16 Apr 2018 15:31:00 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180416073100.GA28904@stefanha-x1.localdomain>
References: <20180406194205.9872-1-nikhilbalachandra.inbox@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <20180406194205.9872-1-nikhilbalachandra.inbox@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] Make qemu-bridge-helper work in macOS
 and FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikhil Balachandra <nikhilbalachandra.inbox@gmail.com>
Cc: qemu-devel@nongnu.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 07, 2018 at 01:12:05AM +0530, Nikhil Balachandra wrote:
> Eventhough macOS does not ship with the if_bridgevar.h header file[2],
> I expect the API to remain stable as this header file is similar to what
> is found in other BSDs. If this patch is decided to be included in the
> qemu, can experienced qemu developers please tell me how to go about
> having this header file in the include path such that it does not require
> manually downloading and copying the file[3]?

QEMU ships Linux headers.  They are synced using this script:
scripts/update-linux-headers.sh

If the macOS header is appropriately licensed, it could be kept under
include/standard-headers/ alongside the other third-party headers that
QEMU ships.

> @@ -310,30 +374,18 @@ int main(int argc, char **argv)
>          goto cleanup;
>      }
> =20
> +
>      /* open the tap device */
> -    fd =3D open("/dev/net/tun", O_RDWR);
> +    memset(&iface, '\0', sizeof(char) * IFNAMSIZ);
> +    int vnet_supported =3D has_vnet_hdr(fd);

fd is always -1 here, so this patch breaks vnet hdr?

> +    Error *err =3D NULL;
> +    fd =3D tap_open(&iface[0], sizeof(iface), &vnet_supported, use_vnet,=
 0, &err);

tap_open() was not written with setuid programs in mind.  I think this
is a case where code duplication is justified.

It's safer to have the minimal code to open the tap device rather than
calling into QEMU code which may not realize it is running setuid.

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa1FE0AAoJEJykq7OBq3PI+9IIAK4OkFoRuRLk7e8uArjHFgob
Od2cUxC35RepOQx4S2ahT4YV7V373nDP1rvnyDsh8I8rDw2YR+fZp/0v5Z72/gh6
Z1ey6lijXAt0WKVhOZOVaJYVz8ONshJu2MdBSNiVZsps53x6ZlMHN7lkYHShkr52
hScuI72Mr3XycPE2uziSUMZPeMvqWTlLFQNOSgvLQwYRKEGFB2VbYWKyosbnHNGe
id3vQ5Uf46HShuoUpYfJqpZPdcK9tuxi/0CmFIcZ2Fzikh7fzx2RefzEmiKAVLDG
MBXYWzZlcSYcKQNcOV34riMTPMYQDA3la/7TZacIjwsg7IcJBjM+np0PBGdxGJo=
=Jgw0
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
