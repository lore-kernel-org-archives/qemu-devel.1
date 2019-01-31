Received: from eggs.gnu.org ([209.51.188.92]:45751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gpDvT-000866-B2
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:06:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gpDvR-0002GR-EU
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:06:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gpDvR-0002GC-6A
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:06:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 70B8B32691A
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 15:06:44 +0000 (UTC)
Date: Thu, 31 Jan 2019 10:06:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190131100526-mutt-send-email-mst@kernel.org>
References: <20190118223152.24183-1-lersek@redhat.com>
	<e4370e19-04f8-d14b-4f7e-bce22f722805@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <e4370e19-04f8-d14b-4f7e-bce22f722805@redhat.com>
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Thu, Jan 31, 2019 at 03:27:01PM +0100, Laszlo Ersek wrote:
> On 01/18/19 23:31, Laszlo Ersek wrote:
> > Commit 19bcc4bc3213 ("fw_cfg: Make qemu_extra_params_fw locally",
> > 2019-01-04) changed the storage duration of the "qemu_extra_params_fw=
"
> > array from static to automatic. This broke the interface contract on =
the
> > fw_cfg_add_file() function, which is documented as follows, in
> > "include/hw/nvram/fw_cfg.h":
> >=20
> >> [...] The data referenced by the starting pointer is only linked, NO=
T
> >> copied, into the data structure of the fw_cfg device. [...]
> >=20
> > As a result, when guest firmware fetches the "etc/boot-menu-wait" fw_=
cfg
> > file, it now sees garbage. Fix the regression by changing the storage
> > duration to allocated. (The call is reached at most once, on the real=
ize
> > path of the board-specific fw_cfg sysbus device.)
> >=20
> > While at it, clean up the name and the assignment of the object as we=
ll.
> >=20
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Cc: Markus Armbruster <armbru@redhat.com>
> > Cc: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > Fixes: 19bcc4bc3213e78c303ad480a7a578f62258252d
> > Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> > ---
> >  hw/nvram/fw_cfg.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >=20
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
> >          int64_t bst_val =3D qemu_opt_get_number(opts, "splash-time",=
 -1);
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
> > -        qemu_extra_params_fw[1] =3D (uint8_t)((bst_val >> 8) & 0xff)=
;
> > -        fw_cfg_add_file(s, "etc/boot-menu-wait", qemu_extra_params_f=
w, 2);
> > +        bst_le16 =3D cpu_to_le16(bst_val);
> > +        fw_cfg_add_file(s, "etc/boot-menu-wait",
> > +                        g_memdup(&bst_le16, sizeof bst_le16), sizeof=
 bst_le16);
> >      }
> > =20
> >      /* insert splash file if user configurated */
> >=20
>=20
> I hope a polite ping can't hurt; can we get this merged please?
>=20
> Thanks
> LAszlo

Sure it does not hurt. I have it tagged  for the next pull.
