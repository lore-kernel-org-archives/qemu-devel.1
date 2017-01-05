Received: from eggs.gnu.org ([2001:4830:134:3::10]:38170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPAMq-0002PL-Ol
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 10:54:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPAMm-0005pL-Rf
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 10:54:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPAMm-0005pB-JF
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 10:54:12 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C1848FCF0
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 15:54:12 +0000 (UTC)
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
	<20161212224325.20790-16-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8cee4fa4-26a0-551c-f351-4d00742f2eb1@redhat.com>
Date: Thu, 5 Jan 2017 09:54:10 -0600
MIME-Version: 1.0
In-Reply-To: <20161212224325.20790-16-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XQ8eVEJBOK1jebgUEqsD5iP3uHkpxaH7L"
Subject: Re: [Qemu-devel] [PATCH 15/54] chardev: qom-ify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XQ8eVEJBOK1jebgUEqsD5iP3uHkpxaH7L
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <8cee4fa4-26a0-551c-f351-4d00742f2eb1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 15/54] chardev: qom-ify
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
 <20161212224325.20790-16-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-16-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/12/2016 04:42 PM, Marc-Andr=C3=A9 Lureau wrote:
> Turn Chardev into Object.
>=20
> qemu_chr_alloc() is replaced by the qemu_chardev_new() constructor. It
> will call qemu_char_open() to open/intialize the chardev with the
> ChardevCommon *backend settings.

Review part 2:

>  spice-qemu-char.c     |  144 +++---
>  ui/console.c          |   73 +--
>  ui/gtk.c              |   51 +-
>  vl.c                  |    2 +

> +++ b/spice-qemu-char.c
> @@ -18,6 +18,12 @@ typedef struct SpiceChardev {
>      QLIST_ENTRY(SpiceChardev) next;
>  } SpiceChardev;
> =20
> +#define TYPE_CHARDEV_SPICE "chardev-spice"
> +#define TYPE_CHARDEV_SPICEVMC "chardev-spicevmc"
> +#define TYPE_CHARDEV_SPICEPORT "chardev-spiceport"

Why do we have a lot of TYPE_CHARDEV_* in sysemu/char.h, but not these?
Should they all live in the same place?

> +++ b/ui/console.c
> @@ -1040,9 +1040,12 @@ typedef struct VCChardev {
>      QemuConsole *console;
>  } VCChardev;
> =20
> -static int console_puts(Chardev *chr, const uint8_t *buf, int len)
> +#define TYPE_CHARDEV_VC "chardev-vc"
> +#define VC_CHARDEV(obj) OBJECT_CHECK(VCChardev, (obj), TYPE_CHARDEV_VC=
)
> +
> +static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
=2E..

> @@ -1951,9 +1954,9 @@ int qemu_console_get_height(QemuConsole *con, int=
 fallback)
>      return con ? surface_height(con->surface) : fallback;
>  }
> =20
> -static void text_console_set_echo(Chardev *chr, bool echo)
> +static void vc_chr_set_echo(Chardev *chr, bool echo)

Should these function renames be split to a separate patch?

> +++ b/ui/gtk.c
> @@ -184,6 +184,9 @@ typedef struct VCChardev {
>      bool echo;
>  } VCChardev;
> =20
> +#define TYPE_CHARDEV_VC "chardev-vc"
> +#define VC_CHARDEV(obj) OBJECT_CHECK(VCChardev, (obj), TYPE_CHARDEV_VC=
)

Why do we have TYPE_CHARDEV_VC and VC_CHARDEV() defined in two different
=2Ec files?

Overall the conversion looks good; as said elsewhere in the thread, I
think you can post a v2 of 1-15 and get that merged first, while still
hammering out the details of the rest of the series.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--XQ8eVEJBOK1jebgUEqsD5iP3uHkpxaH7L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYbmwiAAoJEKeha0olJ0NqtuMH/itFPCffKdj/nlpNUN6MpO+S
tWPaEZ1/9w1Ao1xAjR4gsPm6BlWgX8fsQf6rmFfm1uVCshYwdGid9xPPbhxaN2mz
mvcYIGxc8LGWEVdgMqPR0W3f8o8JJaQE5USobqMWI5l2LN+vcggdqswdtpfaGcac
nQUTPCldb7K1OJd7gwF2muQGaw0xh0RHReEq9kHBfP3TMeXNRMcJ7oLsmZ1sPiFI
WRV6RbAOA0xRcAacSw1KkyVBTWUA/+03FhhlAm0iNVlXr5fiwIdEii195jWqpe/k
J+A+LvpmWbCRFvKxzrPUrokKxSSqqaREvJPAT5fHCpiEAGIr1jn8k7qLc+jkCk0=
=IYTo
-----END PGP SIGNATURE-----

--XQ8eVEJBOK1jebgUEqsD5iP3uHkpxaH7L--
