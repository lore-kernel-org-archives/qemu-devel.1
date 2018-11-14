Received: from eggs.gnu.org ([2001:4830:134:3::10]:59550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMvmu-0002Rb-2y
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:05:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMvmp-0000Ve-Lx
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:05:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gMvmp-0000U2-CZ
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:04:55 -0500
Date: Wed, 14 Nov 2018 14:04:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181114140438.GD19298@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-30-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181114123643.24091-30-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 29/41] slirp: improve a bit the
 debug macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it

On Wed, Nov 14, 2018 at 04:36:31PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Let them accept multiple arguments. Simplify the inner argument
> handling of DEBUG_ARGS/DEBUG_MISC_DEBUG_ERROR.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  slirp/debug.h      | 47 ++++++++++++++++++++++++++++++++++++----------
>  slirp/arp_table.c  | 12 ++++++------
>  slirp/bootp.c      |  3 +--
>  slirp/cksum.c      |  4 ++--
>  slirp/dhcpv6.c     | 11 +++++------
>  slirp/ip6_icmp.c   |  2 +-
>  slirp/ip_icmp.c    | 18 +++++++++---------
>  slirp/mbuf.c       |  2 +-
>  slirp/ndp_table.c  | 18 +++++++++---------
>  slirp/slirp.c      | 12 ++++++------
>  slirp/socket.c     | 32 +++++++++++++++----------------
>  slirp/tcp_input.c  | 15 +++++++--------
>  slirp/tcp_output.c |  2 +-
>  slirp/tcp_subr.c   |  4 ++--
>  slirp/udp.c        |  6 +++---
>  slirp/udp6.c       |  6 +++---
>  16 files changed, 109 insertions(+), 85 deletions(-)
>=20
> diff --git a/slirp/debug.h b/slirp/debug.h
> index 6cfa61edb3..ca3a4b04da 100644
> --- a/slirp/debug.h
> +++ b/slirp/debug.h
> @@ -17,18 +17,45 @@
> =20
>  extern int slirp_debug;
> =20
> -#define DEBUG_CALL(x) if (slirp_debug & DBG_CALL) { fprintf(dfd, "%s..=
.\n", x); fflush(dfd); }
> -#define DEBUG_ARG(x, y) if (slirp_debug & DBG_CALL) { fputc(' ', dfd);=
 fprintf(dfd, x, y); fputc('\n', dfd); fflush(dfd); }
> -#define DEBUG_ARGS(x) if (slirp_debug & DBG_CALL) { fprintf x ; fflush=
(dfd); }
> -#define DEBUG_MISC(x) if (slirp_debug & DBG_MISC) { fprintf x ; fflush=
(dfd); }
> -#define DEBUG_ERROR(x) if (slirp_debug & DBG_ERROR) {fprintf x ; fflus=
h(dfd); }
> +#define DEBUG_CALL(fmt, ...) do {               \
> +    if (slirp_debug & DBG_CALL) {               \
> +        fprintf(dfd, fmt, ##__VA_ARGS__);       \
> +        fprintf(dfd, "...\n");                  \
> +        fflush(dfd);                            \
> +    }                                           \
> +} while (0)
> +
> +#define DEBUG_ARG(fmt, ...) do {                \
> +    if (slirp_debug & DBG_CALL) {               \
> +        fputc(' ', dfd);                        \
> +        fprintf(dfd, fmt, ##__VA_ARGS__);       \
> +        fputc('\n', dfd);                       \
> +        fflush(dfd);                            \
> +    }                                           \
> +} while (0)
> +
> +#define DEBUG_ARGS(fmt, ...) DEBUG_ARG(fmt, ##__VA_ARGS__)
> +
> +#define DEBUG_MISC(fmt, ...) do {               \
> +    if (slirp_debug & DBG_MISC) {               \
> +        fprintf(dfd, fmt, ##__VA_ARGS__);       \
> +        fflush(dfd);                            \
> +    }                                           \
> +} while (0)
> +
> +#define DEBUG_ERROR(fmt, ...) do {              \
> +    if (slirp_debug & DBG_ERROR) {              \
> +        fprintf(dfd, fmt, ##__VA_ARGS__);       \
> +        fflush(dfd);                            \
> +    }                                           \
> +} while (0)

I tend to think it would be nicer to change these to
use  g_debug, and #define G_LOG_DOMAIN  "libslirp" in
the .c files.

This would allow apps to intercept the debug messages
via a custom log handler.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
