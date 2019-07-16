Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED76DC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 22:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B954B20659
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 22:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/cj1B3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B954B20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnVvr-0005Ke-UG
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 18:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45439)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hnVvi-0004rv-0k
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 18:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hnVvg-0001bx-Sn
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 18:28:13 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:35102)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hnVvg-0001bM-I6; Tue, 16 Jul 2019 18:28:12 -0400
Received: by mail-lj1-x244.google.com with SMTP id x25so21595254ljh.2;
 Tue, 16 Jul 2019 15:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IT5RheTQYkKAMQ78utcSnhMBl+X8MmEEBJAnDYSZIq4=;
 b=T/cj1B3FeJRoPfuhNHboJXeeKjsNc7AAMb89fipUDK38lfjVWmU/X9y23C447nVDPp
 LMDtd6j0MqZSmvSbw1sZS8KZp86goorBnUZtOCJlDIEuMV83up3bBw/1jDf4adlEq1cC
 d/XUHWe3JyoPFK7VzEDPaGN2HeT4zpq9KK+AF34MHR61w7kmi1Lf/o1D+c6r8AKkeTpz
 4a49qo/XbPfXpYyzpvzd4eghilur2KQ4N9+PxO/zEiZkEt6oWu8uwr+tVHULY5VlVFp4
 D4Sn8oLvpoPqNBviaVViUiRGg8odr2AwmMBu9drVoz2bzJhhMVVHIaqbY4eSJvugZV+6
 8ZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IT5RheTQYkKAMQ78utcSnhMBl+X8MmEEBJAnDYSZIq4=;
 b=HiB+yK9UymgsGZ2/LBUbEcv5ngEsDtGJ7TJKGijf/CWOgFlprRhi7fvSJ71/UW7JU3
 VWMaLn8rlTN8Ji3MkFywCMpl7BowyhhGKmB4cXrjQksvPEy4UdKbtME+9ppsrtXUimip
 tZE1FKpladwz0oR3gbsHjEikmKYugDeeOJT42UQkMsyeoyrKQmft6oTBhiwYPYqy4QzE
 L3Dqnv7UQDmLAjbAwpQAjmp0UDAKvZTDOo4Jd60hFwW2ARClGHViYNCKhy/N+CYi0Yff
 SHTMrA2ywuvUouTx8XUtJbQHbqA7OrC595u7P3/aGDwFGyDRncxqdMnAzbm7KTy/yoBV
 M9/A==
X-Gm-Message-State: APjAAAXAJku7PdgBmVkC7eTsMXtzLjCbSpi7OQlGrX+Mu1+TD8oRRBfk
 pEu640RlhvCTu3Ndxcv4sYlaHEPZOTJz3Hd3DU0=
X-Google-Smtp-Source: APXvYqzhBd55guBLX0PZGLK+5kVL5vp5K2C4Y8W313kYXmSGjBih4sS0zDZ+Vv2TOXyu3vm70EtSyd2Yjo14GfYUWRQ=
X-Received: by 2002:a2e:9158:: with SMTP id q24mr19142770ljg.119.1563316091003; 
 Tue, 16 Jul 2019 15:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190716221555.11145-1-philmd@redhat.com>
 <20190716221555.11145-3-philmd@redhat.com>
In-Reply-To: <20190716221555.11145-3-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jul 2019 15:24:52 -0700
Message-ID: <CAKmqyKN-wbWvT_WDS5AEkuO4ZVMnVSmnL6swYr5h_-NECUrsBg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v6 2/5] hw/block/pflash_cfi01:
 Document use of non-CFI compliant command '0x00'
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Qemu-block <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Max Reitz <mreitz@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 16, 2019 at 3:16 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> The command 0x00 is used by this model since its origin (commit
> 05ee37ebf630). In this commit the command is described with a
> amusing '/* ??? */' comment, probably meaning 'FIXME'.
>
>         switch (cmd) {
>         case 0x00: /* ??? */
>             ...
>
> This comment survived 12 years because the 0x00 value is indeed
> not specified by the CFI open standard (as of this commit).
>
> The 'cmd' field is transfered during migration. To keep the
> migration feature working with older QEMU version, we have to
> take a lot of care with migrated field. We figured out it is
> too late to remove a non-specified value from this model
> (this would make migration review very complex). It is however
> not too late to improve the documentation.
>
> Add few comments to remember this is a special value related
> to QEMU, and we won't find information about it on the CFI
> spec.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> v6: new patch
> ---
>  hw/block/pflash_cfi01.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index a9529957f8..6838e8a1ab 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -277,9 +277,13 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwaddr=
 offset,
>          /* This should never happen : reset state & treat it as a read *=
/
>          DPRINTF("%s: unknown command state: %x\n", __func__, pfl->cmd);
>          pfl->wcycle =3D 0;
> -        pfl->cmd =3D 0;
> +        /*
> +         * The command 0x00 is not assigned by the CFI open standard,
> +         * but QEMU historically uses it for the READ_ARRAY command (0xf=
f).
> +         */
> +        pfl->cmd =3D 0x00;
>          /* fall through to read code */
> -    case 0x00:
> +    case 0x00: /* This model reset value for READ_ARRAY (not CFI complia=
nt) */
>          /* Flash area read */
>          ret =3D pflash_data_read(pfl, offset, width, be);
>          break;
> @@ -448,7 +452,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
>      case 0:
>          /* read mode */
>          switch (cmd) {
> -        case 0x00: /* ??? */
> +        case 0x00: /* This model reset value for READ_ARRAY (not CFI) */
>              goto reset_flash;
>          case 0x10: /* Single Byte Program */
>          case 0x40: /* Single Byte Program */
> @@ -645,7 +649,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
>      trace_pflash_reset();
>      memory_region_rom_device_set_romd(&pfl->mem, true);
>      pfl->wcycle =3D 0;
> -    pfl->cmd =3D 0;
> +    pfl->cmd =3D 0x00; /* This model reset value for READ_ARRAY (not CFI=
) */
>  }
>
>
> @@ -761,7 +765,11 @@ static void pflash_cfi01_realize(DeviceState *dev, E=
rror **errp)
>      }
>
>      pfl->wcycle =3D 0;
> -    pfl->cmd =3D 0;
> +    /*
> +     * The command 0x00 is not assigned by the CFI open standard,
> +     * but QEMU historically uses it for the READ_ARRAY command (0xff).
> +     */
> +    pfl->cmd =3D 0x00;
>      pfl->status =3D 0x80; /* WSM ready */
>      /* Hardcoded CFI table */
>      /* Standard "QRY" string */
> --
> 2.20.1
>
>

