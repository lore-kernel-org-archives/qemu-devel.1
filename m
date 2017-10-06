Received: from eggs.gnu.org ([2001:4830:134:3::10]:43196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e0T1V-0002iH-D6
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e0T1U-0007OH-3n
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:50:41 -0400
References: <CAEfK_45dZvxvBNQpPLo71ZJhrPN5_GJr8uJ2pJZpCaFf0+i3YA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <62e835a4-ba5d-e620-47d2-180932a33426@redhat.com>
Date: Fri, 6 Oct 2017 08:50:31 -0500
MIME-Version: 1.0
In-Reply-To: <CAEfK_45dZvxvBNQpPLo71ZJhrPN5_GJr8uJ2pJZpCaFf0+i3YA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xvBcVkKurXd4LNaMFir0E0j5t7Kumh9tb"
Subject: Re: [Qemu-devel] Patch to add helpful tracing output for driver
 authors in NVMe emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Doug Gale <doug16k@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: keith.busch@intel.com, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xvBcVkKurXd4LNaMFir0E0j5t7Kumh9tb
From: Eric Blake <eblake@redhat.com>
To: Doug Gale <doug16k@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: keith.busch@intel.com, kwolf@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Message-ID: <62e835a4-ba5d-e620-47d2-180932a33426@redhat.com>
Subject: Re: [Qemu-devel] Patch to add helpful tracing output for driver
 authors in NVMe emulation
References: <CAEfK_45dZvxvBNQpPLo71ZJhrPN5_GJr8uJ2pJZpCaFf0+i3YA@mail.gmail.com>
In-Reply-To: <CAEfK_45dZvxvBNQpPLo71ZJhrPN5_GJr8uJ2pJZpCaFf0+i3YA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/05/2017 06:18 PM, Doug Gale wrote:
> I added the tracing output in this patch to assist me in implementing
> an NVMe driver. It helped tremendously.
>=20
>>From 1d19086cdef8d492929852d582cb41dcc5026f71 Mon Sep 17 00:00:00 2001
> From: Doug Gale <doug16k@gmail.com>
> Date: Thu, 5 Oct 2017 19:02:03 -0400
> Subject: [PATCH] Add tracing output to NVMe emulation to help driver au=
thors.
>=20
> It is off by default, enable it by uncommenting #define DEBUG_NVME
> or through CFLAGS
>=20
> Signed-off-by: Doug Gale <doug16k@gmail.com>
> ---
>  hw/block/nvme.c | 191 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++-----
>  1 file changed, 177 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 9aa32692a3..74220c0171 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -36,6 +36,14 @@
>=20
>  #include "nvme.h"
>=20
> +//#define DEBUG_NVME
> +
> +#ifdef DEBUG_NVME
> +#define DPRINTF(fmt, ...) fprintf(stderr, "nvme: " fmt "\n", ## __VA_A=
RGS__)
> +#else
> +#define DPRINTF(fmt, ...) ((void)0)
> +#endif

As Kevin said, using trace-events is nicer than fprintf().  But if you
absolutely insist on fprintf(), then do NOT do it like this, because
this leads to bit-rot.  Instead, do it in a form that lets -Wformat
checking work even when tracing is disabled:

#ifdef DEBUG_NVME
# define DEBUG_NVME_PRINT 1
#else
# define DEBUG_NVME_PRINT 0
#endif
#define DPRINTF(fmt, ...) \
    do { \
        if (DEBUG_NVME_PRINT) { \
            fprintf(stderr, "nvme: " fmt "\n", ## __VA_ARGS__); \
        } \
    while (0)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--xvBcVkKurXd4LNaMFir0E0j5t7Kumh9tb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEyBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnXiicACgkQp6FrSiUn
Q2pb0Af1HVRfTFkSRn1CtweHi0COuhkUwcrpD21I6J7CQ1dI8fFaoCFJZIpsVdGD
Yw7MTLmDP5+r3rgbwzpmxPjH7VkMxlLzMkb00eVcjzZQY6XV5Alo3vGwl27XQBFV
ULuiLWFNgfyxUff2AbjsCc6UEctdqTKYD/F3tqLLvDbC4LWNGOPxVkLOkxSazull
2GhO5UaMykkROqWnF9FXLetjriN0EciDlbLbZxbehfIK003Mck1EQXtoWyjOHJ+t
GoYOJpAKWlG8XGSD26gf8iid/FufVVNzv6GJASQdUPcRejqW8YYQtFnUdmNlsKDX
UPayyXyZExeOEbDrNIK4HM5K5fWd
=7d70
-----END PGP SIGNATURE-----

--xvBcVkKurXd4LNaMFir0E0j5t7Kumh9tb--
