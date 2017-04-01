Received: from eggs.gnu.org ([2001:4830:134:3::10]:49507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cuRRS-0007f2-8p
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 18:24:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cuRRN-000175-B0
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 18:24:18 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:33485)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cuRRN-00012v-1s
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 18:24:13 -0400
Date: Sun, 2 Apr 2017 00:24:05 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170401222405.bu7suteldbhztarm@var.youpi.perso.aquilenet.fr>
References: <CA+KKJYArwiqdP4=nVvbz5z6dGtgDzKgzZ9_hRJbjV-cHz9vOhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+KKJYArwiqdP4=nVvbz5z6dGtgDzKgzZ9_hRJbjV-cHz9vOhQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 14/43] usb: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Danil Antonov <g.danil.anto@gmail.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

Danil Antonov, on sam. 01 avril 2017 16:48:58 +0300, wrote:
> From 02b1e378eea154c0169a3d16b64ae27c64919c2c Mon Sep 17 00:00:00 2001
> From: Danil Antonov <[1]g.danil.anto@gmail.com>
> Date: Wed, 29 Mar 2017 12:28:51 +0300
> Subject: [PATCH 14/43] usb: made printf always compile in debug output
>=20
> Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
> This will ensure that printf function will always compile even if debug
> output is turned off and, in turn, will prevent bitrot of the format
> strings.
>=20
> Signed-off-by: Danil Antonov <[2]g.danil.anto@gmail.com>

Acked-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
> =C2=A0hw/usb/dev-serial.c=C2=A0 | 17 +++++++++--------
> =C2=A0hw/usb/dev-storage.c | 17 +++++++++--------
> =C2=A0hw/usb/hcd-ehci.h=C2=A0=C2=A0=C2=A0 | 10 +++++-----
> =C2=A0hw/usb/hcd-xhci.c=C2=A0=C2=A0=C2=A0 | 19 ++++++++++++-------
> =C2=A04 files changed, 35 insertions(+), 28 deletions(-)
>=20
> diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
> index 6d51373..739e79b 100644
> --- a/hw/usb/dev-serial.c
> +++ b/hw/usb/dev-serial.c
> @@ -17,14 +17,15 @@
> =C2=A0#include "hw/usb/desc.h"
> =C2=A0#include "sysemu/char.h"
> =C2=A0
> -//#define DEBUG_Serial
> -
> -#ifdef DEBUG_Serial
> -#define DPRINTF(fmt, ...) \
> -do { printf("usb-serial: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) do {} while(0)
> -#endif
> +#ifndef DEBUG_Serial
> +#define DEBUG_Serial 0
> +#endif
> +
> +#define DPRINTF(fmt, ...) do {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +=C2=A0=C2=A0=C2=A0 if (DEBUG_Serial) {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "usb-serial=
: " fmt,## __VA_ARGS__); \
> +=C2=A0=C2=A0=C2=A0 }=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +} while (0);
> =C2=A0
> =C2=A0#define RECV_BUF 384
> =C2=A0
> diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
> index 8a61ec9..b85c006 100644
> --- a/hw/usb/dev-storage.c
> +++ b/hw/usb/dev-storage.c
> @@ -24,14 +24,15 @@
> =C2=A0#include "qapi/visitor.h"
> =C2=A0#include "qemu/cutils.h"
> =C2=A0
> -//#define DEBUG_MSD
> -
> -#ifdef DEBUG_MSD
> -#define DPRINTF(fmt, ...) \
> -do { printf("usb-msd: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) do {} while(0)
> -#endif
> +#ifndef DEBUG_MSD
> +#define DEBUG_MSD 0
> +#endif
> +
> +#define DPRINTF(fmt, ...) do {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +=C2=A0=C2=A0=C2=A0 if (DEBUG_MSD) {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "usb-msd: "=
 fmt , ## __VA_ARGS__); \
> +=C2=A0=C2=A0=C2=A0 }=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +} while (0);
> =C2=A0
> =C2=A0/* USB requests.=C2=A0 */
> =C2=A0#define MassStorageReset=C2=A0 0xff
> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
> index 938d8aa..ca6094e 100644
> --- a/hw/usb/hcd-ehci.h
> +++ b/hw/usb/hcd-ehci.h
> @@ -30,11 +30,11 @@
> =C2=A0#define EHCI_DEBUG=C2=A0=C2=A0 0
> =C2=A0#endif
> =C2=A0
> -#if EHCI_DEBUG
> -#define DPRINTF printf
> -#else
> -#define DPRINTF(...)
> -#endif
> +#define DPRINTF(fmt, ...) do {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +=C2=A0=C2=A0=C2=A0 if (EHCI_DEBUG) {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, fmt, ## __V=
A_ARGS__); \
> +=C2=A0=C2=A0=C2=A0 }=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +} while (0);
> =C2=A0
> =C2=A0#define MMIO_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x100=
0
> =C2=A0#define CAPA_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x10
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index f0af852..9f5e5b2 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -32,11 +32,16 @@
> =C2=A0//#define DEBUG_XHCI
> =C2=A0//#define DEBUG_DATA
> =C2=A0
> -#ifdef DEBUG_XHCI
> -#define DPRINTF(...) fprintf(stderr, __VA_ARGS__)
> -#else
> -#define DPRINTF(...) do {} while (0)
> -#endif
> +#ifndef DEBUG_XHCI
> +#define DEBUG_XHCI 0
> +#endif
> +
> +#define DPRINTF(fmt, ...) do {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +=C2=A0=C2=A0=C2=A0 if (DEBUG_XHCI) {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, fmt , ## __=
VA_ARGS__); \
> +=C2=A0=C2=A0=C2=A0 }=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +} while (0);
> +
> =C2=A0#define FIXME(_msg) do { fprintf(stderr, "FIXME %s:%d %s\n", \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__, __LINE__, _=
msg); abort(); } while
> (0)
> =C2=A0
> @@ -1806,7 +1811,7 @@ static int xhci_setup_packet(XHCITransfer *xfer)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ep =3D xhci_epid_to_us=
bep(xfer->epctx);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ep) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 DPRINTF("xhci: slot %d has no device\n",
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xfer->slotid);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xfer->epctx->slotid);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 return -1;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> @@ -1980,7 +1985,7 @@ static int xhci_submit(XHCIState *xhci, XHCITrans=
fer
> *xfer, XHCIEPContext *epctx
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 uint64_t mfindex;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 DPRINTF("xhci_submit(slotid=3D%d,epid=3D%d)\n", xfe=
r->slotid, xfer->epid);
> +=C2=A0=C2=A0=C2=A0 DPRINTF("xhci_submit(slotid=3D%d,epid=3D%d)\n", xfe=
r->epctx->slotid, xfer->
> epctx->epid);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 xfer->in_xfer =3D epctx->type>>2;
> =C2=A0
> --
> 2.8.0.rc3
>=20
>=20
> References:
>=20
> [1] mailto:g.danil.anto@gmail.com
> [2] mailto:g.danil.anto@gmail.com

--=20
Samuel
c> [ ] morning [ ] afternoon [ ] evening [ ] night , everyone (choose as =
applicable)
