Received: from eggs.gnu.org ([2001:4830:134:3::10]:51834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g9l2q-0007jo-0B
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 01:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g9l2o-00045B-Sc
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 01:58:59 -0400
Received: from mail-it1-x135.google.com ([2607:f8b0:4864:20::135]:33542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1g9l2o-00044z-Lk
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 01:58:58 -0400
Received: by mail-it1-x135.google.com with SMTP id h6-v6so12399491ith.0
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 22:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <1539052760-11730-1-git-send-email-liq3ea@gmail.com>
	<7a26945a-d94f-98db-7ae2-0d4c089ab975@redhat.com>
In-Reply-To: <7a26945a-d94f-98db-7ae2-0d4c089ab975@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 9 Oct 2018 13:58:21 +0800
Message-ID: <CAKXe6SKqfm2qXuN4YNWQTOnrF9O2OFqg41vp6y-ANMgqLLXBLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] vl.c: print error message if load
 fw_cfg file failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: philmd@redhat.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, f4bug@amsat.org, Qemu Developers <qemu-devel@nongnu.org>

Hello  Philippe,

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2018=E5=B9=B410=E6=
=9C=889=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=881:52=E5=86=99=E9=81=93=
=EF=BC=9A

> Hi Li,
>
> On 09/10/2018 04:39, Li Qiang wrote:
> > It makes sense to print the error message while reading
> > file failed.
>
> OK
>
> >
> > Change since v1:
> > free error
>
> Changes are useful for reviewer, but not in the git history.
> You can have them automatically stripped if you place them below the
> next '---' separator.
>
>
Thanks for your advice.


> Hopefully the maintainer taking this patch can clean this up.
>
> >
> > Signed-off-by: Li Qiang <liq3ea@gmail.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
>
> Here goes comment not worth to stay forever in git history:
>
>   Since v1: ...
>
> >  vl.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/vl.c b/vl.c
> > index 4e25c78..69fc77c 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -2207,8 +2207,10 @@ static int parse_fw_cfg(void *opaque, QemuOpts
> *opts, Error **errp)
> >          size =3D strlen(str); /* NUL terminator NOT included in fw_cfg
> blob */
> >          buf =3D g_memdup(str, size);
> >      } else {
> > -        if (!g_file_get_contents(file, &buf, &size, NULL)) {
> > -            error_report("can't load %s", file);
> > +        GError *error =3D NULL;
> > +        if (!g_file_get_contents(file, &buf, &size, &error)) {
> > +            error_report("can't load %s, %s", file, error->message);
>
> If you ever respin, you can help Markus [1] effort using:
>
>             error_setg(errp, "can't load %s, %s", file, error->message);
>
> Else your patch will clash with [2].
>

OK, I will send out this patch based Markus' tree or later when his patch
goes to upstream.

Thanks,
Li Qiang


>
> > +            g_error_free(error);
> >              return -1;
> >          }
> >      }
> >
>
> Regards,
>
> Phil.
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01394.html
> [2] https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01406.html
>
