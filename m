Received: from eggs.gnu.org ([2001:4830:134:3::10]:49765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cjNq6-0008TU-G7
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:20:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cjNq5-00038n-By
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:20:02 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:36253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cjNq5-00038V-79
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:20:01 -0500
Received: by mail-it0-x243.google.com with SMTP id w185so7913162ita.3
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 02:20:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <910332417.8403823.1487665924940.JavaMail.zimbra@redhat.com>
References: <1487665107-88004-1-git-send-email-liqiang6-s@360.cn>
	<910332417.8403823.1487665924940.JavaMail.zimbra@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 2 Mar 2017 18:20:00 +0800
Message-ID: <CAKXe6S+Gw5q1Ohw8F3SQzYp7g_2sBUW7gEYd94yYt8m_3Naw2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] spice-char: fix segfault in
 char_spice_finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: marcandre lureau <marcandre.lureau@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Li Qiang <liqiang6-s@360.cn>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <mlureau@redhat.com>

Hello Paolo,

Have you queued this patch?

2017-02-21 16:32 GMT+08:00 Marc-Andr=C3=A9 Lureau <mlureau@redhat.com>:

> Hi
>
> ----- Original Message -----
> > In 'qemu_chr_open_spice_vmc' if the 'psubtype' is NULL, it will
> > call 'char_spice_finalize'. But as the SpiceChardev is not inserted
> > in the 'spice_chars' list, the 'QLIST_REMOVE' will cause a segfault.
> > Add a detect to avoid it.
> >
> > Signed-off-by: Li Qiang <liqiang6-s@360.cn>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> > ---
> >  spice-qemu-char.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/spice-qemu-char.c b/spice-qemu-char.c
> > index 6f46f46..4d1c76e 100644
> > --- a/spice-qemu-char.c
> > +++ b/spice-qemu-char.c
> > @@ -215,7 +215,10 @@ static void char_spice_finalize(Object *obj)
> >      SpiceChardev *s =3D SPICE_CHARDEV(obj);
> >
> >      vmc_unregister_interface(s);
> > -    QLIST_REMOVE(s, next);
> > +
> > +    if (s->next.le_prev) {
> > +        QLIST_REMOVE(s, next);
> > +    }
> >
> >      g_free((char *)s->sin.subtype);
> >  #if SPICE_SERVER_VERSION >=3D 0x000c02
> > --
> > 1.8.3.1
> >
> >
>
