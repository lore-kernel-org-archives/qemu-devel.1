Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2FFFA372B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 15:04:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E02F220640
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 15:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJqqbSTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02F220640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKkqx-0007rz-0c
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 11:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iKkp0-0005yd-BM
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 11:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iKkoy-0004xE-B4
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 11:02:42 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40272)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iKkov-0004uz-Vf
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 11:02:38 -0400
Received: by mail-wm1-x342.google.com with SMTP id b24so3132111wmj.5
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 08:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pHpMCzzRrZS/oZnfwvR0FHu5tkrYXhe+IhAdWUo+pfY=;
 b=aJqqbSTHnOYpjoThBxxzLEYn3AcB6xTQcrkrPVtlyEqZ4R8bis4AraLjt8bb/h3ncP
 +UEBu6dhFa2rTKkEV6YRNS6StSJKYRtfgV+Sq0i/NkfLJqoK7dQycSyXw3Fmrxz6sMdr
 6uW72FoXMs1HY6RDVW3Ko8j+YNYq0cKTO75HBMIeIVbor3i4nlPv1UOlyzLCZBdnJqO5
 H1qOY3F9ZlQqzR/IifIYqwmonO2juLpNRfxPeB1XVTJmzmVlPKAJX7YwffiZta0H4kmF
 CT63Tx3nyuBfKmPurnQ/790010+K+jy456zPx+/Ss386zC8iyiv+ZWBerl/71LuN94YV
 wluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pHpMCzzRrZS/oZnfwvR0FHu5tkrYXhe+IhAdWUo+pfY=;
 b=kfLyIZT2dwNQTwbUG86ptXbCROWJ0VHPZN412ZtV6+AuiT839vC6YKqCMDqsJdEGQk
 evAEsBxR7vIQjW4z0WEvGGHTYU7dznPRetfDDPKIMM8auKTJ2EDHtnAp7vxfKw4UXa3e
 gwG0V1+aagQbNo1eOWI5vCxBqsENkbE320M+qWOH/BLs+gc60Wl307bI8HPZPvlKPsye
 n64Gwl3bW3SM2o0TNwrhTDDwqhuFjf3s/kcYnhafdZ1/4BNZJGxwHbUnwEefLCEXsFko
 mDdYCO40J+x58rGw96I+ukgP0kpyd41ONP6gR8QSYmq++B7AfiM0djUGrliCyZHXzU6n
 J90A==
X-Gm-Message-State: APjAAAW8JX+VLZVqss++0cF3lGksOyBAxpDLYcfg9e/o/ZTLm7j/vxQZ
 hvycS1spLJZywh3bjXM2jhIgXBV6NLEuf/3obgvK5Q==
X-Google-Smtp-Source: APXvYqynYHZmS41zlUsu91shfLM7K6iRbzyJmjkWlWasSXSIu/UeV++7D6xIYyhzlOMDQFAimqhejBNs3IUXd3AQgZs=
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr3720344wmj.91.1571238154077;
 Wed, 16 Oct 2019 08:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191016101241.24405-1-slp@redhat.com>
 <20191016101241.24405-5-slp@redhat.com>
In-Reply-To: <20191016101241.24405-5-slp@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 16 Oct 2019 17:02:21 +0200
Message-ID: <CAJ+F1CL_L50iaTxrxJqThzTP8RRfE6GqLGkx_Dj+4yahnPWdwg@mail.gmail.com>
Subject: Re: [PATCH v10 04/15] hw/i386/pc: replace use of strtol with
 qemu_strtoui in x86_load_linux()
To: Sergio Lopez <slp@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, groug@kaod.org,
 QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Laszlo Ersek <lersek@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 16, 2019 at 12:16 PM Sergio Lopez <slp@redhat.com> wrote:
>
> Follow checkpatch.pl recommendation and replace the use of strtol with
> qemu_strtoui in x86_load_linux().
>
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/i386/pc.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 77e86bfc3d..c8608b8007 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -68,6 +68,7 @@
>  #include "qemu/config-file.h"
>  #include "qemu/error-report.h"
>  #include "qemu/option.h"
> +#include "qemu/cutils.h"
>  #include "hw/acpi/acpi.h"
>  #include "hw/acpi/cpu_hotplug.h"
>  #include "hw/boards.h"
> @@ -1202,6 +1203,7 @@ static void x86_load_linux(PCMachineState *pcms,
>      vmode =3D strstr(kernel_cmdline, "vga=3D");
>      if (vmode) {
>          unsigned int video_mode;
> +        int ret;
>          /* skip "vga=3D" */
>          vmode +=3D 4;
>          if (!strncmp(vmode, "normal", 6)) {
> @@ -1211,7 +1213,12 @@ static void x86_load_linux(PCMachineState *pcms,
>          } else if (!strncmp(vmode, "ask", 3)) {
>              video_mode =3D 0xfffd;
>          } else {
> -            video_mode =3D strtol(vmode, NULL, 0);
> +            ret =3D qemu_strtoui(vmode, NULL, 0, &video_mode);
> +            if (ret !=3D 0) {
> +                fprintf(stderr, "qemu: can't parse 'vga' parameter: %s\n=
",
> +                        strerror(-ret));
> +                exit(1);
> +            }
>          }
>          stw_p(header + 0x1fa, video_mode);
>      }
> --
> 2.21.0
>
>


--
Marc-Andr=C3=A9 Lureau

