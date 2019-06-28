Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61704C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:31:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A91B2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0w0My9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A91B2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgtm9-0004ff-CU
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 12:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40715)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hgtk9-000319-LU
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:28:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hgtk8-0007p3-A3
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:28:57 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:46138)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hgtk8-0007ng-26; Fri, 28 Jun 2019 12:28:56 -0400
Received: by mail-lj1-x243.google.com with SMTP id v24so6565259ljg.13;
 Fri, 28 Jun 2019 09:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QVB/NSSXD1O9PJfpJgBnUtdqj1nZvjQkzhHzB0cTIT8=;
 b=R0w0My9k0LGfPuSHVeEM2AEV4KH6AdXauh6PGZwDRpAZ5Q+B0xjXl1/q6NMInSx0oD
 6S8nxA2bO2qomK6YJPFkztAXNTkCIlXqWgM2Mh8GxhpjAHXAj1IguoU9gYAmXNtbKuC1
 v+pHO2DKOrsLkyR+zh9n2WCPnH/qlvmuA+qJlJ7pAtEreVJgkKZ3Y4QVhp5l9WSr50nY
 TSIIRFGbYkpHjKuV+xtSNFSiLu48cGTfYSC3Igh9MAIBsxLCuJ4kwGkTAVAUhqNorWUi
 pUXfLitL8vykxdNP+0B872t9bdDIxlCGJ1rQ25Wz/Sq4t0zrwHmAT99XG2gmsmlHnVUE
 WcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QVB/NSSXD1O9PJfpJgBnUtdqj1nZvjQkzhHzB0cTIT8=;
 b=lA+i7byou+MDC/SZrJN0D3XxswqeWTkqaG0hH9itu2Dbu1IDu9FEtK21rcs2W/pfgi
 9q1CrC+dgnv008qsaUPi5KmFZcmC+3ww4dOZv7JvwKPUOBuOM5802oj3Y0eoma0Y8FOu
 +DoFbYnOHTOi71bupf3uVNq0FmKN8eSj9aer2AC9JyxRxmG1v/XkQcTHYRi/Ckd/qV5a
 nqCSCW7H0An/m/mEFjwfH4Md6bqXWc5ZxnoREbt5i/7vnjwYoFHOab+J8TfbYBgUilO6
 6hqWdBOCeE98pgdz7+RMYFJ7+VAYGZrKWqsrvcrWZ2TLMDUckTW0Q2QPTe1I+dKhevsT
 hokw==
X-Gm-Message-State: APjAAAXbN+44ZsZ1Y6JP2NTN3heeA6s/Hn7FYOgb+6Cgkh98OnnTVOqj
 LD1Jn6lhgoL8Q9doHC4chMirknamTdgM4bpsvlw=
X-Google-Smtp-Source: APXvYqwE3SoT3F/fw8wD3kt0QK6lMJxqLDLH1gpPphVe5fp4qHC9vp5YiLw+eQVjlHzRTEo75pqQ956J4zaUQ8Te03A=
X-Received: by 2002:a2e:3604:: with SMTP id d4mr6765360lja.85.1561739334453;
 Fri, 28 Jun 2019 09:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190627202719.17739-1-philmd@redhat.com>
 <20190627202719.17739-12-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-12-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jun 2019 09:25:42 -0700
Message-ID: <CAKmqyKMi4HJgrKZekt6KDouFu7mvtKGuyAP6Tk6wRXGP1zXMdQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v5 11/28] hw/block/pflash_cfi02: Unify the
 MemoryRegionOps
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

On Thu, Jun 27, 2019 at 1:37 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> The pflash_read()/pflash_write() can check the device endianess
> via the pfl->be variable, so remove the 'int be' argument.
>
> Since the big/little MemoryRegionOps are now identical, it is
> pointless to declare them both. Unify them.
>
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> Message-Id: <20190426162624.55977-3-stephen.checkoway@oberlin.edu>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> [PMD: Extracted from bigger patch to ease review]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Nice cleanup!

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/block/pflash_cfi02.c | 60 +++++++++++------------------------------
>  1 file changed, 15 insertions(+), 45 deletions(-)
>
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index c079a63880..e64dc69c6c 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -177,11 +177,11 @@ static uint64_t pflash_data_read(PFlashCFI02 *pfl, =
hwaddr offset,
>      return ret;
>  }
>
> -static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr offset,
> -                            int width, int be)
> +static uint64_t pflash_read(void *opaque, hwaddr offset, unsigned int wi=
dth)
>  {
> +    PFlashCFI02 *pfl =3D opaque;
>      hwaddr boff;
> -    uint32_t ret;
> +    uint64_t ret;
>
>      ret =3D -1;
>      /* Lazy reset to ROMD mode after a certain amount of read accesses *=
/
> @@ -228,14 +228,14 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwadd=
r offset,
>          default:
>              ret =3D pflash_data_read(pfl, offset, width);
>          }
> -        DPRINTF("%s: ID " TARGET_FMT_plx " %" PRIx32 "\n", __func__, bof=
f, ret);
> +        DPRINTF("%s: ID " TARGET_FMT_plx " %" PRIx64 "\n", __func__, bof=
f, ret);
>          break;
>      case 0xA0:
>      case 0x10:
>      case 0x30:
>          /* Status register read */
>          ret =3D pfl->status;
> -        DPRINTF("%s: status %" PRIx32 "\n", __func__, ret);
> +        DPRINTF("%s: status %" PRIx64 "\n", __func__, ret);
>          toggle_dq6(pfl);
>          break;
>      case 0x98:
> @@ -253,8 +253,7 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr =
offset,
>  }
>
>  /* update flash content on disk */
> -static void pflash_update(PFlashCFI02 *pfl, int offset,
> -                          int size)
> +static void pflash_update(PFlashCFI02 *pfl, int offset, int size)
>  {
>      int offset_end;
>      if (pfl->blk) {
> @@ -267,9 +266,10 @@ static void pflash_update(PFlashCFI02 *pfl, int offs=
et,
>      }
>  }
>
> -static void pflash_write(PFlashCFI02 *pfl, hwaddr offset,
> -                         uint32_t value, int width, int be)
> +static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
> +                         unsigned int width)
>  {
> +    PFlashCFI02 *pfl =3D opaque;
>      hwaddr boff;
>      uint8_t *p;
>      uint8_t cmd;
> @@ -477,39 +477,9 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr of=
fset,
>      pfl->cmd =3D 0;
>  }
>
> -static uint64_t pflash_be_readfn(void *opaque, hwaddr addr, unsigned siz=
e)
> -{
> -    return pflash_read(opaque, addr, size, 1);
> -}
> -
> -static void pflash_be_writefn(void *opaque, hwaddr addr,
> -                              uint64_t value, unsigned size)
> -{
> -    pflash_write(opaque, addr, value, size, 1);
> -}
> -
> -static uint64_t pflash_le_readfn(void *opaque, hwaddr addr, unsigned siz=
e)
> -{
> -    return pflash_read(opaque, addr, size, 0);
> -}
> -
> -static void pflash_le_writefn(void *opaque, hwaddr addr,
> -                              uint64_t value, unsigned size)
> -{
> -    pflash_write(opaque, addr, value, size, 0);
> -}
> -
> -static const MemoryRegionOps pflash_cfi02_ops_be =3D {
> -    .read =3D pflash_be_readfn,
> -    .write =3D pflash_be_writefn,
> -    .valid.min_access_size =3D 1,
> -    .valid.max_access_size =3D 4,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> -};
> -
> -static const MemoryRegionOps pflash_cfi02_ops_le =3D {
> -    .read =3D pflash_le_readfn,
> -    .write =3D pflash_le_writefn,
> +static const MemoryRegionOps pflash_cfi02_ops =3D {
> +    .read =3D pflash_read,
> +    .write =3D pflash_write,
>      .valid.min_access_size =3D 1,
>      .valid.max_access_size =3D 4,
>      .endianness =3D DEVICE_NATIVE_ENDIAN,
> @@ -537,9 +507,9 @@ static void pflash_cfi02_realize(DeviceState *dev, Er=
ror **errp)
>
>      chip_len =3D pfl->sector_len * pfl->nb_blocs;
>
> -    memory_region_init_rom_device(&pfl->orig_mem, OBJECT(pfl), pfl->be ?
> -                                  &pflash_cfi02_ops_be : &pflash_cfi02_o=
ps_le,
> -                                  pfl, pfl->name, chip_len, &local_err);
> +    memory_region_init_rom_device(&pfl->orig_mem, OBJECT(pfl),
> +                                  &pflash_cfi02_ops, pfl, pfl->name,
> +                                  chip_len, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> --
> 2.20.1
>
>

