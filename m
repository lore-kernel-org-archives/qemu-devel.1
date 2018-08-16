Received: from eggs.gnu.org ([2001:4830:134:3::10]:41444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fqF5m-0005PE-DK
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 06:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fqF5g-0007Sn-CS
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 06:01:22 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:52879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fqF5g-0007S6-2G
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 06:01:16 -0400
Received: by mail-wm0-x244.google.com with SMTP id o11-v6so3849575wmh.2
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 03:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180815195051.24586-1-marcandre.lureau@redhat.com>
	<87pnyieq43.fsf@dusky.pond.sub.org>
In-Reply-To: <87pnyieq43.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 16 Aug 2018 12:01:03 +0200
Message-ID: <CAJ+F1C+GEerjpUED38b5caVO-ZUsp4anS-gcTR8_7KZuM5uTVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-option: add help fallback to
 print the list of options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Thu, Aug 16, 2018 at 9:19 AM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > QDev options accept '?' or 'help' in the list of parameters, which is
> > really handy to list the available options.
> >
> > Unfortunately, this isn't built in QemuOpts. qemu_opts_parse_noisily()
> > seems to be the common path for command line options, so place a
> > fallback to check for '?' and print help listing available options.
>
> My immediate reaction was "how come this doesn't break -device help"?
> It doesn't, because...
>
> > This is very handy, for example with qemu "-spice ?".
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  util/qemu-option.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/util/qemu-option.c b/util/qemu-option.c
> > index 01886efe90..8839ee6523 100644
> > --- a/util/qemu-option.c
> > +++ b/util/qemu-option.c
> > @@ -889,7 +889,12 @@ QemuOpts *qemu_opts_parse_noisily(QemuOptsList *li=
st, const char *params,
> >
> >      opts =3D opts_parse(list, params, permit_abbrev, false, &err);
> >      if (err) {
> > -        error_report_err(err);
> > +        if (has_help_option(params)) {
> > +            qemu_opts_print_help(list);
> > +            error_free(err);
> > +        } else {
> > +            error_report_err(err);
> > +        }
> >      }
> >      return opts;
> >  }
>
> ... it only kicks in when parsing failed, and it doesn't for option
> argument "help".
>
> However, it *can* break for some option arguments:
>
>     $ upstream-qemu -device e1000,id=3D@
>     upstream-qemu: -device e1000,id=3D@: Parameter 'id' expects an identi=
fier
>     Identifiers consist of letters, digits, '-', '.', '_', starting with =
a letter.
>     [Exit 1 ]
>     $ upstream-qemu -device e1000,id=3D@,help
>     [Exit 1 ]
>
> In the second test case, the error message gets replaced by (empty)
> help.

Good catch

>
> I love patches improving help, but I can't immediately see how to
> salvage this one.
>

We can pass a with_help option down to opt_set(), and print help
there? Alternatively, pass a bool *invalid_parameter, to be set in
this case, so qemu_opts_parse_noisly() would only print help when it
is set.

Do you see a problem with any of those 2 options?

--=20
Marc-Andr=C3=A9 Lureau
