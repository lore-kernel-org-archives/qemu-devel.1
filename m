Received: from eggs.gnu.org ([2001:4830:134:3::10]:43022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cP8eF-0005K9-T9
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 09:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cP8eE-0007cz-Tg
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 09:04:07 -0500
Received: from mail-yw0-x243.google.com ([2607:f8b0:4002:c05::243]:33743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cP8eE-0007cl-Oc
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 09:04:06 -0500
Received: by mail-yw0-x243.google.com with SMTP id s68so45023733ywg.0
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 06:04:06 -0800 (PST)
MIME-Version: 1.0
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
	<20161212224325.20790-13-marcandre.lureau@redhat.com>
	<1abe545e-a9a3-e14e-5fe1-0490c86ad0ba@redhat.com>
In-Reply-To: <1abe545e-a9a3-e14e-5fe1-0490c86ad0ba@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 05 Jan 2017 14:03:54 +0000
Message-ID: <CAJ+F1C+Ppu8VO22ETKaKQZBy6dEB7dcdPcQugzOFOAz2vW6AUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 12/54] spice-char: improve error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Markus Armbruster <armbru@redhat.com>

Hi

On Wed, Jan 4, 2017 at 11:00 PM Eric Blake <eblake@redhat.com> wrote:

> On 12/12/2016 04:42 PM, Marc-Andr=C3=A9 Lureau wrote:
> > Set errp to report errors up.
> >
> > Use error_report() to give hints about parameters on the right monitor,
> > instead of a direct fprintf() call.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  spice-qemu-char.c | 29 +++++++++--------------------
> >  1 file changed, 9 insertions(+), 20 deletions(-)
> >
>
> And it's shorter!  I like it.
>
> > @@ -302,8 +286,13 @@ static Chardev *qemu_chr_open_spice_vmc(const
> CharDriver *driver,
> >          }
> >      }
> >      if (*psubtype =3D=3D NULL) {
> > -        fprintf(stderr, "spice-qemu-char: unsupported type: %s\n",
> type);
> > -        print_allowed_subtypes();
> > +        char *subtypes =3D g_strjoinv(", ",
> > +            (gchar **)spice_server_char_device_recognized_subtypes());
> > +
> > +        error_setg(errp, "unsupported type name: %s", type);
> > +        error_report("allowed spice char type names: %s", subtypes);
>
> However, I'm not sure if error_setg() followed by error_report() is
> correct; should you be using error_append_hint() instead?  Markus?
>
>
That doesn't work well with command line errors. error_vprintf_unless_qmp()
doesn't print if !cur_mon. I sent a patch on the ML, and I'll follow your
suggestion.



--=20
Marc-Andr=C3=A9 Lureau
