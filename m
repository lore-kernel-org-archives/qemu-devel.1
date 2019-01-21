Received: from eggs.gnu.org ([209.51.188.92]:56707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1glUCe-0001kk-Cr
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 02:41:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1glUCd-0007MG-7F
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 02:41:04 -0500
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:45874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1glUCd-0007LW-0j
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 02:41:03 -0500
Received: by mail-io1-xd41.google.com with SMTP id c2so15631573iom.12
	for <qemu-devel@nongnu.org>; Sun, 20 Jan 2019 23:41:02 -0800 (PST)
MIME-Version: 1.0
References: <20190118223152.24183-1-lersek@redhat.com>
	<20190121072121.rid3fmx3i2a7s5gu@sirius.home.kraxel.org>
In-Reply-To: <20190121072121.rid3fmx3i2a7s5gu@sirius.home.kraxel.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 21 Jan 2019 15:40:25 +0800
Message-ID: <CAKXe6SJd=BmH8CttVu7wU9EGJDt6go06uZV0qVOV=ney6y8_Gg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] fw_cfg: fix the life cycle and the name of
 "qemu_extra_params_fw"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

Gerd Hoffmann <kraxel@redhat.com> =E4=BA=8E2019=E5=B9=B41=E6=9C=8821=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=883:22=E5=86=99=E9=81=93=EF=BC=9A

> On Fri, Jan 18, 2019 at 11:31:52PM +0100, Laszlo Ersek wrote:
> > Commit 19bcc4bc3213 ("fw_cfg: Make qemu_extra_params_fw locally",
> > 2019-01-04) changed the storage duration of the "qemu_extra_params_fw"
> > array from static to automatic. This broke the interface contract on th=
e
> > fw_cfg_add_file() function, which is documented as follows, in
> > "include/hw/nvram/fw_cfg.h":
> >
> > > [...] The data referenced by the starting pointer is only linked, NOT
> > > copied, into the data structure of the fw_cfg device. [...]
> >
> > As a result, when guest firmware fetches the "etc/boot-menu-wait" fw_cf=
g
> > file, it now sees garbage. Fix the regression by changing the storage
> > duration to allocated. (The call is reached at most once, on the realiz=
e
> > path of the board-specific fw_cfg sysbus device.)
> >
> > While at it, clean up the name and the assignment of the object as well=
.
>
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
>
> >
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Cc: Markus Armbruster <armbru@redhat.com>
> > Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Fixes: 19bcc4bc3213e78c303ad480a7a578f62258252d
> > Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>

Oh my fault.

Reviewed-by: Li Qiang <liq3ea@gmail.com>

So I think my patch:
-->http://lists.nongnu.org/archive/html/qemu-devel/2019-01/msg04896.html
is useful to write this file entry test cases

Thanks,
Li Qiang


> > ---
> >  hw/nvram/fw_cfg.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> > index 53e8e010a8b7..7fdf04adc97f 100644
> > --- a/hw/nvram/fw_cfg.c
> > +++ b/hw/nvram/fw_cfg.c
> > @@ -118,7 +118,6 @@ static void fw_cfg_bootsplash(FWCfgState *s)
> >  {
> >      const char *boot_splash_filename =3D NULL;
> >      const char *boot_splash_time =3D NULL;
> > -    uint8_t qemu_extra_params_fw[2];
> >      char *filename, *file_data;
> >      gsize file_size;
> >      int file_type;
> > @@ -132,6 +131,8 @@ static void fw_cfg_bootsplash(FWCfgState *s)
> >      /* insert splash time if user configurated */
> >      if (boot_splash_time) {
> >          int64_t bst_val =3D qemu_opt_get_number(opts, "splash-time", -=
1);
> > +        uint16_t bst_le16;
> > +
> >          /* validate the input */
> >          if (bst_val < 0 || bst_val > 0xffff) {
> >              error_report("splash-time is invalid,"
> > @@ -139,9 +140,9 @@ static void fw_cfg_bootsplash(FWCfgState *s)
> >              exit(1);
> >          }
> >          /* use little endian format */
> > -        qemu_extra_params_fw[0] =3D (uint8_t)(bst_val & 0xff);
> > -        qemu_extra_params_fw[1] =3D (uint8_t)((bst_val >> 8) & 0xff);
> > -        fw_cfg_add_file(s, "etc/boot-menu-wait", qemu_extra_params_fw,
> 2);
> > +        bst_le16 =3D cpu_to_le16(bst_val);
> > +        fw_cfg_add_file(s, "etc/boot-menu-wait",
> > +                        g_memdup(&bst_le16, sizeof bst_le16), sizeof
> bst_le16);
> >      }
> >
> >      /* insert splash file if user configurated */
> > --
> > 2.19.1.3.g30247aa5d201
> >
>
>
