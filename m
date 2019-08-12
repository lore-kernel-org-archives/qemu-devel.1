Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D75C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 18:27:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8534F2070C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 18:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLHRRMow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8534F2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxF2C-0005CC-Oq
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 14:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43266)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <randrianasulu@gmail.com>) id 1hxF1p-0004lv-1Y
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 14:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <randrianasulu@gmail.com>) id 1hxF1n-0002Db-LU
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 14:26:44 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:39366)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
 id 1hxF1n-0002Bc-CS
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 14:26:43 -0400
Received: by mail-lf1-x141.google.com with SMTP id x3so21131891lfn.6
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 11:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=content-disposition:from:to:subject:date:user-agent:mime-version
 :content-transfer-encoding:message-id;
 bh=QcKMK13CyehigHIGy94d4e5RQfyKfGhXATXu5vDSGO8=;
 b=NLHRRMowpcK4Ny485JBZI3gWtVxYaz4c3gL1U6D2cBdc/fWtDWGGHz42LWlvIS3JJw
 qSP58lttvnn80bKChfzmP89WUUet04sGwBYZnSXy5geGmk6VgsoBoBeJt7JPYfgVx+e2
 mBx6vw4r5U4Wiiz0LEIjAAUaO3K1UxDqwPTghKL9MREfu3qRjLHGeveMjmVx8InCieW7
 89DdKoFkj8EYUm1grOTpdZzd6YceiBrJRcQYlHk74AE6lT/TPTS1Ux5nGy2hCKiVqiFm
 w/9sxob+tNCsR966BWPhLHSr7NOCmqp/Po6JLol1umGkCT65BojTQg0TXafWHnQzv0Tj
 osrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-disposition:from:to:subject:date
 :user-agent:mime-version:content-transfer-encoding:message-id;
 bh=QcKMK13CyehigHIGy94d4e5RQfyKfGhXATXu5vDSGO8=;
 b=W+hfz6ye1uTFFULmXqf0/zlxhvnmAWiVrwP/jm/Ia5xs3bQRma9KfEt2skFKSA/Q3Y
 EjuhhsumWapB7JTT6Xd+YUjbndSF4BuTg1V3urtCMHb4287TXT/jAg5qzq1QcgLe0uqu
 JB33+lnIV7KKOJ7Ns/GJ0zHAmnv2W2UoFF+sp/ypcKENVTGzPDvewECW9vTeQRbPTVHU
 APQTe6R/8bnPepf/L/buZYGUfdCRMaMDa71eOfAoG3hoTwUGI1DaK/zoqNxEPf+uWf2u
 5K1IIseDjLzwRQ9ekc8do/n89EiT+DdinvZQ1depKkLlPk78vG5e6MqNNGDlMZCYz2xP
 PQ3A==
X-Gm-Message-State: APjAAAWu/XQx9fodkyy9dUqUJwqZ0z0AQnwI3bMD7STsKSUAxH79ZIhg
 2sd+5HFwwnEV/EOC4U0Sxj8=
X-Google-Smtp-Source: APXvYqxGIZA0XSUlLeKaR0CM773re4EXeUZd4AQP+HZCYsxHmyT1MKSgdsqfQpfQa1DrAnS8FkIjcw==
X-Received: by 2002:a19:674d:: with SMTP id e13mr16218374lfj.176.1565634401744; 
 Mon, 12 Aug 2019 11:26:41 -0700 (PDT)
Received: from [192.168.1.100] ([176.116.252.109])
 by smtp.gmail.com with ESMTPSA id f12sm2509137lfm.14.2019.08.12.11.26.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 11:26:40 -0700 (PDT)
Content-Disposition: inline
From: Andrew Randrianasulu <randrianasulu@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>,
 "Philippe =?utf-8?q?Mathieu-Daud=C3=A9?=" <philmd@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 12 Aug 2019 21:15:37 +0300
User-Agent: KMail/1.9.10
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201908122115.38211.randrianasulu@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: [Qemu-devel] Fwd: Re: [PATCH 4/7] ati-vga: Fix cursor color with
 guest_hwcursor=true
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


=2D---------  =D0=9F=D0=B5=D1=80=D0=B5=D1=81=D0=BB=D0=B0=D0=BD=D0=BD=D0=BE=
=D0=B5 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5  ----------

=D0=A2=D0=B5=D0=BC=D0=B0: Re: [Qemu-devel] [PATCH 4/7] ati-vga: Fix cursor =
color with guest_hwcursor=3Dtrue
=D0=94=D0=B0=D1=82=D0=B0: =D0=9F=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D0=BB=D1=8C=
=D0=BD=D0=B8=D0=BA 12 =D0=B0=D0=B2=D0=B3=D1=83=D1=81=D1=82=D0=B0 2019
=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D0=B5=D0=BB=D1=8C: Andrew =
Randrianasulu <randrianasulu@gmail.com>
=D0=9F=D0=BE=D0=BB=D1=83=D1=87=D0=B0=D1=82=D0=B5=D0=BB=D1=8C:  BALATON Zolt=
an <balaton@eik.bme.hu>

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
Monday 12 August 2019 13:55:45 BALATON Zoltan =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BB(=D0=B0):
> On Mon, 12 Aug 2019, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 8/12/19 12:28 PM, BALATON Zoltan wrote:
> >> On Mon, 12 Aug 2019, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> On 8/11/19 11:14 PM, BALATON Zoltan wrote:
> >>>> Fixes: a38127414bd007c5b6ae64c664d9e8839393277e
> >>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >>>> ---
> >>>> ?hw/display/ati.c | 2 +-
> >>>> ?1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/hw/display/ati.c b/hw/display/ati.c
> >>>> index 699f38223b..b849f5d510 100644
> >>>> --- a/hw/display/ati.c
> >>>> +++ b/hw/display/ati.c
> >>>> @@ -207,7 +207,7 @@ static void ati_cursor_draw_line(VGACommonState
> >>>> *vga, uint8_t *d, int scr_y)
> >>>> ???????????????? }
> >>>> ???????????? } else {
> >>>> ???????????????? color =3D (xbits & BIT(7) ? s->regs.cur_color1 :
> >>>> -????????????????????????????????????????? s->regs.cur_color0) << 8 |
> >>>> 0xff;
> >>>> +????????????????????????????????????????? s->regs.cur_color0) |
> >>>> 0xff000000;
> >>>> ???????????? }
> >>>> ???????????? if (vga->hw_cursor_x + i * 8 + j >=3D h) {
> >>>> ???????????????? return; /* end of screen, don't span to next line */
> >>>>
> >>>
> >>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >>
> >> Thanks. I've noticed that cursor color may still be wrong with MacOS
> >> that uses big endian frame buffer so maybe this will also need to take
> >> frame buffer endianness into account somehow but this patch corrects a
> >> difference between guest_hwcursor true and false values, reproducible
> >> with some Linux versions (as far as I remember). While the wrong cursor
> >> color with MacOS is now consistent after this patch with both
> >> guest_hwcursor true or false so that likely needs a different fix that
> >> should be applied both to this place and to ati_cursor_define. (MacOS
> >> does not yet boot fully, it needs patches to OpenBIOS to be able to run
> >> an FCode ROM and will probably need the VBlank interrupt implemented in
> >> ati-vga without which it displays a desktop but freezes there).
> >
> > If you remember which Linux version had this problem, or you can link to
> > roms that behave incorrectly, please share, so we can add display
> > regression tests.
>=20
> Unfortunately I don't. I think it was Andrew who found this so maybe he=20
> can remember.

Blue cursor was seen on specific dvd (x86) image I did for myself,=20
because it was  using plain X cursor (arrow or X-shaped), not colored=20
versions used by default in many distributions.

may be 'startx -- -retro" will show it briefly too?

from man Xserver (1.19.7):

=2Dretro  starts  the  server  with  the  classic stipple and cursor visibl=
e.  The default is to start with a black root window, and to suppress displ=
ay of the cursor until the
               first time an application calls XDefineCursor().=20


https://yadi.sk/d/F8cbINWzWJ-DkA

users: root and guest
passwords: toor and guest

You need to boot it to syslinux and type 'slax' there, because default will=
 boot x86-64 kernel without aty128fb .... (my fault)
Unfortunately, i don't have fresh qemu compiled (previous tests were done f=
rom tmpfs copy of qemu source tree),
 will recompile from git and re-test. from memory, loading aty128fb and
setting config fragment in /etc/X11/xorg.conf.d for EXA AccelMethod and "Op=
tion "UseFBDev" "1" ' allowed device (ati-vga) to work.

=2D-----------------------------

Update: qemu commit 864ab314f1d924129d06ac7b571f105a2b76a4b2 (tag: v4.1.0-r=
c4)
plus patch series by Zoltan (https://patchew.org/QEMU/cover.1565558093.git.=
balaton%40eik.bme.hu/)
actually boots my x86 dvd image with this command:

x86_64-softmmu/qemu-system-x86_64 -m 512 -enable-kvm -device ati-vga,guest_=
hwcursor=3Dtrue -cdrom /mnt/sdb1/slax-14_06_2019-private0.iso

or
x86_64-softmmu/qemu-system-x86_64 -m 512 -enable-kvm -device ati-vga,guest_=
hwcursor=3Dtrue -cdrom /mnt/sdb1/slax-14_06_2019-private0.iso -display sdl,=
gl=3Don

Cursor is normally-colored, but you need something like "xrandr -s 23" beca=
use default resolution a bit too big.=20
(after modprobe aty128fb + usual xorg.conf dance about UseFBDev)

=2D---end of update--------



>=20
> (You may also need latest vgabios-ati.bin from Gerd's repo to get Linux=20
> drivers load and for rage128p that has to be in pc-bios dir because PCI=20
> IDs are only patched in that way.)
>=20
> Regards,
> BALATON Zoltan



=2D------------------------------------------------------

