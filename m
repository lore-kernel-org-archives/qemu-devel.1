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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F747C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 12:39:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC4B520663
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 12:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMzY0DIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC4B520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx9bz-0008C4-2V
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 08:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43919)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <randrianasulu@gmail.com>) id 1hx9bN-0007m7-AC
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 08:39:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <randrianasulu@gmail.com>) id 1hx9bM-0004rY-2D
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 08:39:05 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:43618)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
 id 1hx9bL-0004qj-MX
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 08:39:04 -0400
Received: by mail-lf1-x143.google.com with SMTP id c19so74120168lfm.10
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 05:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:user-agent:cc:references:in-reply-to
 :mime-version:content-transfer-encoding:content-disposition
 :message-id; bh=T3UFkfZVOYvpMwdINYQTXRqex/OJ9MIESAtVURuyhJg=;
 b=sMzY0DIF94W+0EAIuKWQy0L/6izfFMKiSQKkci9pEeIDnNKKXDqVMdnKzmbJ9+K/AE
 TwUf5mKCG2KbzYJJGFtbBO2kvJ7tnQqQLGac1OOvT90LQq57UQgKrVXsgrcsbUhWbG2W
 kIB8ff6eVQLLtN48V5vYaFl/QgzibUFRM73JZN5lm4pFNjUY18QgXGnAD4WM1r/d2GVC
 xkPtYYRZRW0f4ltAUPnpMWqhB/DFiJhRt1+ilR7q5uCFlWAmD0vruUK4RWQ+q9QoEHoG
 oOx0KLsn+NeXWGabc31HC/PXvoqCWfIi1B/kWF2FVGY4fq5uwRLA5EM7mRggBAlVLaVd
 WftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:user-agent:cc:references
 :in-reply-to:mime-version:content-transfer-encoding
 :content-disposition:message-id;
 bh=T3UFkfZVOYvpMwdINYQTXRqex/OJ9MIESAtVURuyhJg=;
 b=h0dsM2fmOihnWceklJg5sNih1SR3u7IxVy4mIoRZJNSI6fP+8s8/d7jMab84okRFOG
 OvBg8NizEgq2/Ibiks8v3RDqQE98RnIWnZGbZDGC2Pxj3NJmINttlI7fylAmOM5MNfWy
 s0KtFxOV4D8irGde523bMdI6uMTRn0QjY2FyUjpCuJP11CrbqwP7XHIi3ux0m7oO6/4G
 atUu7CL9rS326k785EERSoInNHNgQVt66U7+FVdiTq5bs/E5elo4WIj5mW/7x5pT5qDo
 940YEJro9c/gU6CEJO4I/nEJh6K60Xa706typVtbMa5y+F+Ld+BeQKX6IKZA5HMarFgZ
 ifQg==
X-Gm-Message-State: APjAAAUkweGMSl0F/nXqucKKIsCalS7dhowENHPsbjmPRTRFwj5/F1gw
 cumozwtvLK+lsSW52m23DJ4=
X-Google-Smtp-Source: APXvYqwDLuy0F7O8fmGL6M3gXnyCwito+vwyKBxHjW+Ycq8t/kXSTXivfK25yc+2PVBYrkCHR7T8XQ==
X-Received: by 2002:a05:6512:244:: with SMTP id
 b4mr20843505lfo.114.1565613541229; 
 Mon, 12 Aug 2019 05:39:01 -0700 (PDT)
Received: from [192.168.1.100] ([176.116.252.109])
 by smtp.gmail.com with ESMTPSA id x13sm582273ljm.7.2019.08.12.05.38.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 05:38:59 -0700 (PDT)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Date: Mon, 12 Aug 2019 15:27:55 +0300
User-Agent: KMail/1.9.10
References: <cover.1565558093.git.balaton@eik.bme.hu>
 <8942e49f-493f-70c4-b2a1-10b97f2a7c6d@redhat.com>
 <alpine.BSF.2.21.9999.1908121239520.68551@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.21.9999.1908121239520.68551@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201908121527.55871.randrianasulu@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] [PATCH 4/7] ati-vga: Fix cursor color with
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
Cc: Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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



>=20
> (You may also need latest vgabios-ati.bin from Gerd's repo to get Linux=20
> drivers load and for rage128p that has to be in pc-bios dir because PCI=20
> IDs are only patched in that way.)
>=20
> Regards,
> BALATON Zoltan



