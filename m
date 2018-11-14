Received: from eggs.gnu.org ([2001:4830:134:3::10]:33890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gN28D-0004Zs-79
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 15:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gN288-000554-Uv
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 15:51:24 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gN288-00054B-Qx
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 15:51:20 -0500
Received: by mail-qk1-f196.google.com with SMTP id y16so28336838qki.7
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 12:51:20 -0800 (PST)
MIME-Version: 1.0
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-30-marcandre.lureau@redhat.com>
	<20181114140438.GD19298@redhat.com>
In-Reply-To: <20181114140438.GD19298@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 15 Nov 2018 00:51:08 +0400
Message-ID: <CAMxuvawRtUs11PgDmKdDzHEvnVu16qzD--jzq6xjctPjxV9b1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "P. Berrange, Daniel" <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, samuel.thibault@ens-lyon.org, Richard Jones <rjones@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, renzo@cs.unibo.it

Hi

On Wed, Nov 14, 2018 at 6:04 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> On Wed, Nov 14, 2018 at 04:36:31PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Let them accept multiple arguments. Simplify the inner argument
> > handling of DEBUG_ARGS/DEBUG_MISC_DEBUG_ERROR.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  slirp/debug.h      | 47 ++++++++++++++++++++++++++++++++++++----------
> >  slirp/arp_table.c  | 12 ++++++------
> >  slirp/bootp.c      |  3 +--
> >  slirp/cksum.c      |  4 ++--
> >  slirp/dhcpv6.c     | 11 +++++------
> >  slirp/ip6_icmp.c   |  2 +-
> >  slirp/ip_icmp.c    | 18 +++++++++---------
> >  slirp/mbuf.c       |  2 +-
> >  slirp/ndp_table.c  | 18 +++++++++---------
> >  slirp/slirp.c      | 12 ++++++------
> >  slirp/socket.c     | 32 +++++++++++++++----------------
> >  slirp/tcp_input.c  | 15 +++++++--------
> >  slirp/tcp_output.c |  2 +-
> >  slirp/tcp_subr.c   |  4 ++--
> >  slirp/udp.c        |  6 +++---
> >  slirp/udp6.c       |  6 +++---
> >  16 files changed, 109 insertions(+), 85 deletions(-)
> >
> > diff --git a/slirp/debug.h b/slirp/debug.h
> > index 6cfa61edb3..ca3a4b04da 100644
> > --- a/slirp/debug.h
> > +++ b/slirp/debug.h
> > @@ -17,18 +17,45 @@
> >
> >  extern int slirp_debug;
> >
> > -#define DEBUG_CALL(x) if (slirp_debug & DBG_CALL) { fprintf(dfd, "%s..=
.\n", x); fflush(dfd); }
> > -#define DEBUG_ARG(x, y) if (slirp_debug & DBG_CALL) { fputc(' ', dfd);=
 fprintf(dfd, x, y); fputc('\n', dfd); fflush(dfd); }
> > -#define DEBUG_ARGS(x) if (slirp_debug & DBG_CALL) { fprintf x ; fflush=
(dfd); }
> > -#define DEBUG_MISC(x) if (slirp_debug & DBG_MISC) { fprintf x ; fflush=
(dfd); }
> > -#define DEBUG_ERROR(x) if (slirp_debug & DBG_ERROR) {fprintf x ; fflus=
h(dfd); }
> > +#define DEBUG_CALL(fmt, ...) do {               \
> > +    if (slirp_debug & DBG_CALL) {               \
> > +        fprintf(dfd, fmt, ##__VA_ARGS__);       \
> > +        fprintf(dfd, "...\n");                  \
> > +        fflush(dfd);                            \
> > +    }                                           \
> > +} while (0)
> > +
> > +#define DEBUG_ARG(fmt, ...) do {                \
> > +    if (slirp_debug & DBG_CALL) {               \
> > +        fputc(' ', dfd);                        \
> > +        fprintf(dfd, fmt, ##__VA_ARGS__);       \
> > +        fputc('\n', dfd);                       \
> > +        fflush(dfd);                            \
> > +    }                                           \
> > +} while (0)
> > +
> > +#define DEBUG_ARGS(fmt, ...) DEBUG_ARG(fmt, ##__VA_ARGS__)
> > +
> > +#define DEBUG_MISC(fmt, ...) do {               \
> > +    if (slirp_debug & DBG_MISC) {               \
> > +        fprintf(dfd, fmt, ##__VA_ARGS__);       \
> > +        fflush(dfd);                            \
> > +    }                                           \
> > +} while (0)
> > +
> > +#define DEBUG_ERROR(fmt, ...) do {              \
> > +    if (slirp_debug & DBG_ERROR) {              \
> > +        fprintf(dfd, fmt, ##__VA_ARGS__);       \
> > +        fflush(dfd);                            \
> > +    }                                           \
> > +} while (0)
>
> I tend to think it would be nicer to change these to
> use  g_debug, and #define G_LOG_DOMAIN  "libslirp" in
> the .c files.
>
> This would allow apps to intercept the debug messages
> via a custom log handler.

Yes, even better would be structured logging, but it requires glib 2.50

One issue with the replacement is that we may want to keep the
slirp_debug filtering. If not, then we lose the classification.
Second issue is that slirp issues several debug calls and write \n in
the end. This is something you can't do with g_log. So it would need
some debug calls rewrite.

I would like to see this clean up patch applied before we decide how
to replace it with glog.

And yes, we should have a Slirp G_LOG_DOMAIN (I meant to do that, and forgo=
t)

>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
