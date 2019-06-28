Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BE0C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:00:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F1620645
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2nDLgIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F1620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hguEs-0001Zk-QZ
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 13:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32773)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hgtED-0005DH-RE
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:55:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hgtEC-0001iJ-GJ
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:55:57 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:46336)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hgtEC-0001fv-7c; Fri, 28 Jun 2019 11:55:56 -0400
Received: by mail-lf1-x142.google.com with SMTP id z15so4266559lfh.13;
 Fri, 28 Jun 2019 08:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bgk0fvyLTEQHcq/I3vTtUQKrD/cy3HxJRA+JpMC9O8U=;
 b=X2nDLgIgN8ohcI9VgAKoaRQgSB6JTHgQSKIzsKWuPHUPKvxsD/PrhM6VTbdgX+rtAB
 ID12yaHTxNsWS8k36R0qCDHDm0HnSXsf0GSyo+Ar1MOk6Xm7VmLu4LXYK9ayf2mcmTTu
 6ApedU/bVtHfP999OKH+fZiYovSrDl6JfYhliETAlbRexgtn92OuNGZoQKTrRow2pG67
 pS3lRZXa97QKQWplhrUcdU5VeYGAv/wDhMxtEhoJvdyzCUUoTh74vEgStsKXdJXThiAd
 y9XDIY/uP0nfGE3eBgZiNQCeTztkGZCZ01e8ENhE4RqozDFYwDy9F7jjLZgze2kRGoKl
 RU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bgk0fvyLTEQHcq/I3vTtUQKrD/cy3HxJRA+JpMC9O8U=;
 b=E+4boUGLr74C5scvZ1JNk+tJqV8gKbtPzkpgKp0DoLhC5/i6GUmkSEE4jHlHO6uTU5
 XWFyy5oLr5vcDS1WM2Hqv2hBMDPjGfoq5ojYOuDl/vkAlZP0sUp0VmprRNWoI+JwX/Wp
 8teBL/rhVIWu3CJvqYFqVZroqJuCoWI5NrSwljVJpOwfrthVriZDCdXlPUk55IHFZRlo
 gCz6xbzWQQn4aZsrFH7Nh1pIQQ/geZZmjrid4vxQClrthpDBZ/ES8N2kimOfwQwJd1DK
 UQc7BfLJPGqYkqAH5JbYiUlcShHbHVq+oTH7hRJC4cL9YteXc0esYZjyXAQgsji+xSmp
 iTeA==
X-Gm-Message-State: APjAAAUBkXpPEfVAn1bMq2fC5Oy4bDD8nk92dMuZaMI6Ey+LXnvv5050
 ejpM7RA36GxCYnjlukA3VLHWigOVr0XE+3MMPkQ=
X-Google-Smtp-Source: APXvYqwORYg0P6FHZvInyutYrPaylKS/1sWpB26992IB2bRC9hdB73l4c5Vr+W+qTtyMVbv9c8y/qLqyLoBdbXs6OMU=
X-Received: by 2002:a19:4c05:: with SMTP id z5mr5295640lfa.5.1561737354154;
 Fri, 28 Jun 2019 08:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190627202719.17739-1-philmd@redhat.com>
 <20190627202719.17739-3-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-3-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jun 2019 08:52:52 -0700
Message-ID: <CAKmqyKPDKbHW+bH-sHefHJ3A_wpXNOyP2BoFRTtAMrr61yt6SA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [PATCH v5 02/28] hw/block/pflash: Simplify
 trace_pflash_io_read/write()
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Qemu-block <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 27, 2019 at 1:38 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Call the read() trace function after the value is set, so we can
> log the returned value.
> Rename the I/O trace functions with '_io_' in their name.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/block/pflash_cfi01.c | 5 +++--
>  hw/block/pflash_cfi02.c | 6 ++----
>  hw/block/trace-events   | 4 ++--
>  3 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 35080d915f..74fc1bc2da 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -288,7 +288,6 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwaddr =
offset,
>      uint32_t ret;
>
>      ret =3D -1;
> -    trace_pflash_read(offset, pfl->cmd, width, pfl->wcycle);
>      switch (pfl->cmd) {
>      default:
>          /* This should never happen : reset state & treat it as a read *=
/
> @@ -391,6 +390,8 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwaddr =
offset,
>
>          break;
>      }
> +    trace_pflash_io_read(offset, width, width << 1, ret, pfl->cmd, pfl->=
wcycle);
> +
>      return ret;
>  }
>
> @@ -453,7 +454,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
>
>      cmd =3D value;
>
> -    trace_pflash_write(offset, value, width, pfl->wcycle);
> +    trace_pflash_io_write(offset, width, width << 1, value, pfl->wcycle)=
;
>      if (!pfl->wcycle) {
>          /* Set the device in I/O access mode */
>          memory_region_rom_device_set_romd(&pfl->mem, false);
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index eb106f4996..f05cd507b3 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -145,7 +145,6 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr =
offset,
>      uint8_t *p;
>
>      ret =3D -1;
> -    trace_pflash_read(offset, pfl->cmd, width, pfl->wcycle);
>      /* Lazy reset to ROMD mode after a certain amount of read accesses *=
/
>      if (!pfl->rom_mode && pfl->wcycle =3D=3D 0 &&
>          ++pfl->read_counter > PFLASH_LAZY_ROMD_THRESHOLD) {
> @@ -241,6 +240,7 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr =
offset,
>          }
>          break;
>      }
> +    trace_pflash_io_read(offset, width, width << 1, ret, pfl->cmd, pfl->=
wcycle);
>
>      return ret;
>  }
> @@ -267,6 +267,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr off=
set,
>      uint8_t *p;
>      uint8_t cmd;
>
> +    trace_pflash_io_write(offset, width, width << 1, value, pfl->wcycle)=
;
>      cmd =3D value;
>      if (pfl->cmd !=3D 0xA0 && cmd =3D=3D 0xF0) {
>  #if 0
> @@ -275,11 +276,8 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr of=
fset,
>  #endif
>          goto reset_flash;
>      }
> -    trace_pflash_write(offset, value, width, pfl->wcycle);
>      offset &=3D pfl->chip_len - 1;
>
> -    DPRINTF("%s: offset " TARGET_FMT_plx " %08x %d\n", __func__,
> -            offset, value, width);
>      boff =3D offset & (pfl->sector_len - 1);
>      if (pfl->width =3D=3D 2)
>          boff =3D boff >> 1;
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 97a17838ed..f637fe918e 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -7,9 +7,9 @@ fdc_ioport_write(uint8_t reg, uint8_t value) "write reg 0=
x%02x val 0x%02x"
>  # pflash_cfi02.c
>  # pflash_cfi01.c
>  pflash_reset(void) "reset"
> -pflash_read(uint64_t offset, uint8_t cmd, int width, uint8_t wcycle) "of=
fset:0x%04"PRIx64" cmd:0x%02x width:%d wcycle:%u"
> -pflash_write(uint64_t offset, uint32_t value, int width, uint8_t wcycle)=
 "offset:0x%04"PRIx64" value:0x%03x width:%d wcycle:%u"
>  pflash_timer_expired(uint8_t cmd) "command 0x%02x done"
> +pflash_io_read(uint64_t offset, int width, int fmt_width, uint32_t value=
, uint8_t cmd, uint8_t wcycle) "offset:0x%04"PRIx64" width:%d value:0x%0*x =
cmd:0x%02x wcycle:%u"
> +pflash_io_write(uint64_t offset, int width, int fmt_width, uint32_t valu=
e, uint8_t wcycle) "offset:0x%04"PRIx64" width:%d value:0x%0*x wcycle:%u"
>  pflash_data_read8(uint64_t offset, uint32_t value) "data offset:0x%04"PR=
Ix64" value:0x%02x"
>  pflash_data_read16(uint64_t offset, uint32_t value) "data offset:0x%04"P=
RIx64" value:0x%04x"
>  pflash_data_read32(uint64_t offset, uint32_t value) "data offset:0x%04"P=
RIx64" value:0x%08x"
> --
> 2.20.1
>
>

