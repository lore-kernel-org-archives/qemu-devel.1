Received: from eggs.gnu.org ([209.51.188.92]:60388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkY8L-000398-FX
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:40:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkY8K-000223-Ef
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:40:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gkY8K-0001yw-2e
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:40:44 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14E7780F6D
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 17:40:43 +0000 (UTC)
References: <20190118173103.4903-1-berrange@redhat.com>
	<20190118173103.4903-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <83c29d37-d37c-86ea-9133-8268df23c3ad@redhat.com>
Date: Fri, 18 Jan 2019 11:40:29 -0600
MIME-Version: 1.0
In-Reply-To: <20190118173103.4903-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yTqeVyeSAPJrQctxoKazaVfByxetHqJL1"
Subject: Re: [Qemu-devel] [PATCH v2 1/4] display: ensure qxl log_buf is a
 nul terminated string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yTqeVyeSAPJrQctxoKazaVfByxetHqJL1
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <83c29d37-d37c-86ea-9133-8268df23c3ad@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] display: ensure qxl log_buf is a nul
 terminated string
References: <20190118173103.4903-1-berrange@redhat.com>
 <20190118173103.4903-2-berrange@redhat.com>
In-Reply-To: <20190118173103.4903-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/18/19 11:31 AM, Daniel P. Berrang=C3=A9 wrote:
> The QXL_IO_LOG command allows the guest to send log messages to the hos=
t
> via a buffer in the QXLRam struct. QEMU prints these to the console if
> the qxl 'guestdebug' option is set to non-zero. It will also feed them
> to the trace subsystem if any backends are built-in.
>=20
> In both cases the log_buf data will get treated as being as a nul
> terminated string, by the printf '%s' format specifier and / or other
> code reading the buffer.
>=20
> QEMU does nothing to guarantee that the log_buf really is nul terminate=
d,
> so there is potential for out of bounds array access.
>=20
> This would affect any QEMU which has the log, syslog or ftrace trace
> backends built into QEMU. It can only be triggered if the 'qxl_io_log'
> trace event is enabled, however, so they are not vulnerable without
> specific administrative action to enable this.
>=20
> It would also affect QEMU if the 'guestdebug' parameter is set to a
> non-zero value, which again is not the default and requires explicit
> admin opt-in.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  hw/display/qxl.c        | 3 ++-
>  hw/display/trace-events | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> +++ b/hw/display/qxl.c
> @@ -1763,7 +1763,8 @@ async_common:
>          qxl_set_mode(d, val, 0);
>          break;
>      case QXL_IO_LOG:
> -        trace_qxl_io_log(d->id, d->ram->log_buf);
> +        d->ram->log_buf[sizeof(d->ram->log_buf) - 1] =3D '\0';

May lose a character from the log, but the improved safety is worth it.

> +        trace_qxl_io_log(d->id, (const char *)d->ram->log_buf);
>          if (d->guestdebug) {
>              fprintf(stderr, "qxl/guest-%d: %" PRId64 ": %s", d->id,
>                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), d->ram->log=
_buf);
> diff --git a/hw/display/trace-events b/hw/display/trace-events
> index 5a48c6cb6a..387c6b8931 100644
> --- a/hw/display/trace-events
> +++ b/hw/display/trace-events
> @@ -72,7 +72,7 @@ qxl_interface_update_area_complete_rest(int qid, uint=
32_t num_updated_rects) "%d
>  qxl_interface_update_area_complete_overflow(int qid, int max) "%d max=3D=
%d"
>  qxl_interface_update_area_complete_schedule_bh(int qid, uint32_t num_d=
irty) "%d #dirty=3D%d"
>  qxl_io_destroy_primary_ignored(int qid, const char *mode) "%d %s"
> -qxl_io_log(int qid, const uint8_t *log_buf) "%d %s"
> +qxl_io_log(int qid, const char *log_buf) "%d %s"
>  qxl_io_read_unexpected(int qid) "%d"
>  qxl_io_unexpected_vga_mode(int qid, uint64_t addr, uint64_t val, const=
 char *desc) "%d 0x%"PRIx64"=3D%"PRIu64" (%s)"
>  qxl_io_write(int qid, const char *mode, uint64_t addr, const char *ana=
me, uint64_t val, unsigned size, int async) "%d %s addr=3D%"PRIu64 " (%s)=
 val=3D%"PRIu64" size=3D%u async=3D%d"
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--yTqeVyeSAPJrQctxoKazaVfByxetHqJL1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxCD40ACgkQp6FrSiUn
Q2rkFwf/dsxy5gSlRgu2NAwk3WvlVbzV4xxdSGqXZXJoFvx9nIoL2sbafPcHyv3h
4Tap1NNtrCJQ4ARWY87mxrlErmccUxPFoUBsUex1uF6nzsDT+0zb0rgH1/KKtx/I
JYXaAAS39gOfgT+5ykcDprEhYm+DFI1EPaMV5k40O1hj4unjObSFNmimA78v+5jx
0RbYgC32jHfHk3gyUKeHoG3Sf5yiKp3cSVov97nYdUAf+kaS9fIj/KNVQjuMeca1
og3A7z793y6MgfO0h4ASwo8Ac1Zkbw1aJoj+D4EEV0hL+TKrxqtrwbhcTIb2l+du
lHbphI96yaMkkxvsZleYM+UEP78AfQ==
=aOmj
-----END PGP SIGNATURE-----

--yTqeVyeSAPJrQctxoKazaVfByxetHqJL1--
