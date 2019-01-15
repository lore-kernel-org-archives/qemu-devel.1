Received: from eggs.gnu.org ([209.51.188.92]:55747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gjUTs-00052I-LX
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:34:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gjUI9-0006Lx-PF
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:22:31 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gjUI9-0006LX-HP
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:22:29 -0500
Received: by mail-qt1-f195.google.com with SMTP id r14so4352507qtp.1
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 11:22:26 -0800 (PST)
MIME-Version: 1.0
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-7-marcandre.lureau@redhat.com>
	<b4ea0f6b-4080-75f7-2369-2795fbe264ed@redhat.com>
In-Reply-To: <b4ea0f6b-4080-75f7-2369-2795fbe264ed@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 15 Jan 2019 23:22:15 +0400
Message-ID: <CAMxuvawODzddSpGpPj8=AWwr5hFkpDgaz7_mseUW1ra-xdaw+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 06/41] slirp: add a callback for
 qemu_chr_fe_write_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Richard Jones <rjones@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, renzo@cs.unibo.it

Hi

On Thu, Nov 15, 2018 at 5:15 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 14/11/2018 13:36, Marc-Andr=C3=A9 Lureau wrote:
> > Replace strong dependency on QEMU.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  slirp/libslirp.h | 1 +
> >  net/slirp.c      | 6 ++++++
> >  slirp/slirp.c    | 2 +-
> >  3 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/slirp/libslirp.h b/slirp/libslirp.h
> > index 36d5fb9163..16ced2aa0f 100644
> > --- a/slirp/libslirp.h
> > +++ b/slirp/libslirp.h
> > @@ -7,6 +7,7 @@ typedef struct Slirp Slirp;
> >
> >  typedef struct SlirpCb {
> >      void (*output)(void *opaque, const uint8_t *pkt, int pkt_len);
> > +    int (*chr_write_all)(void *chr, const void *buf, size_t len);
> >  } SlirpCb;
> >
> >
> > diff --git a/net/slirp.c b/net/slirp.c
> > index 233f66b1ef..5c1f676487 100644
> > --- a/net/slirp.c
> > +++ b/net/slirp.c
> > @@ -140,8 +140,14 @@ static NetClientInfo net_slirp_info =3D {
> >      .cleanup =3D net_slirp_cleanup,
> >  };
> >
> > +static int net_slirp_chr_write_all(void *chr, const void *buf, size_t =
len)
> > +{
> > +    return qemu_chr_fe_write_all(chr, buf, len);
> > +}
> > +
> >  static SlirpCb slirp_cb =3D {
> >      .output =3D net_slirp_output,
> > +    .chr_write_all =3D net_slirp_chr_write_all,
>
>
> >  };
> >
> >  static int net_slirp_init(NetClientState *peer, const char *model,
> > diff --git a/slirp/slirp.c b/slirp/slirp.c
> > index 7213915bf3..4e809e5d7f 100644
> > --- a/slirp/slirp.c
> > +++ b/slirp/slirp.c
> > @@ -1099,7 +1099,7 @@ ssize_t slirp_send(struct socket *so, const void =
*buf, size_t len, int flags)
> >      if (so->s =3D=3D -1 && so->chardev) {
> >          /* XXX this blocks entire thread. Rewrite to use
> >           * qemu_chr_fe_write and background I/O callbacks */
> > -        qemu_chr_fe_write_all(so->chardev, buf, len);
> > +        so->slirp->cb->chr_write_all(so->chardev, buf, len);
> >          return len;
> >      }
> >
> >
>
> Rather than this, I would split out add_exec's do_pty=3D=3D3 case to a ne=
w
> function add_guestfwd, and pass the function pointer to add_guestfwd.  Th=
en:
>
> 1) add_guestfwd can store the function pointer in struct ex_list,
>
> 2) tcp_ctl can store the ex_ptr in struct socket directly, instead of
> storing ex_ptr->ex_exec (that is the chardev field becomes "struct
> ex_list *guestfwd" or something)
>
> 3) slirp_send can use so->chardev to retrieve both the function pointer
> and the void* (renaming it to so->exec maybe)

Ok, please check the upcoming series, patch "slirp: generalize
guestfwd with a callback based approach". I think it is what you
propose here.

thanks
