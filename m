Received: from eggs.gnu.org ([2001:4830:134:3::10]:52558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g9YWP-000687-7C
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 12:36:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g9YWM-0002yx-3w
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 12:36:41 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g9YWL-0002yN-Ui
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 12:36:38 -0400
Received: by mail-yw1-f68.google.com with SMTP id j75-v6so8311843ywj.10
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 09:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181007043335.23631-1-liq3ea@163.com>
	<be443eb3-742d-08c6-492c-058331ec14b0@amsat.org>
In-Reply-To: <be443eb3-742d-08c6-492c-058331ec14b0@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 8 Oct 2018 18:36:25 +0200
Message-ID: <CAAdtpL70LmVs=58J2zbG7qig7UMST6J9sCjb=i5AtJYG5zxpaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vl.c: print error message if load fw_cfg
 file failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

Hi Li,

On Sun, Oct 7, 2018 at 7:48 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
> On 10/7/18 6:33 AM, Li Qiang wrote:
> > It makes sense to print the error message while reading
> > file failed.
> >
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> >  vl.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/vl.c b/vl.c
> > index cc55fe04a2..3db410e771 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -2207,8 +2207,9 @@ static int parse_fw_cfg(void *opaque, QemuOpts *o=
pts, Error **errp)
> >          size =3D strlen(str); /* NUL terminator NOT included in fw_cfg=
 blob */
> >          buf =3D g_memdup(str, size);
> >      } else {
> > -        if (!g_file_get_contents(file, &buf, &size, NULL)) {
> > -            error_report("can't load %s", file);
> > +        GError *error =3D NULL;
> > +        if (!g_file_get_contents(file, &buf, &size, &error)) {
> > +            error_report("can't load %s, %s", file, error->message);

You forgot:

                    g_error_free(error);

With the free:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

>
> >              return -1;
> >          }
> >      }
> >
