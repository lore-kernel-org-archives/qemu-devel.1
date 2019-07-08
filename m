Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D7EC606D1
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 20:54:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B152173E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 20:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFcFxu0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B152173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkaei-0005mE-1k
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 16:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56592)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hkae3-0005KM-OC
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 16:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hkae2-0008Pm-I6
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 16:53:55 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:34071)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hkae2-0008Oq-Af; Mon, 08 Jul 2019 16:53:54 -0400
Received: by mail-lf1-x141.google.com with SMTP id b29so11909691lfq.1;
 Mon, 08 Jul 2019 13:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xNJdLUDck8N9rbAuIyFgiog/r0oXVAnMf289PEsEveo=;
 b=ZFcFxu0A6CFFdXyMSYXszvSKQEC4F6z4B1lO9Ppiwl8uVruxwaqIeedovwYy9NDwXY
 Qr/rN10312vkO9aykNxla35kH1TD3EFVfW64M2kJENbVSHnYqvTFqr6UtfBc6g0OxamB
 Gs2oDIKKExvihq+1G0AXrBPyBYmd97WnmvInMAWXHCm8aIxhm2QyBAcWuj/E24vHerZF
 Ags0buF03ozRPeLYJeJ7GbQqij/hYux7e0ByncsOvwUXi0mky8HIfPVk4woYvpgVnLhF
 OSUTiYJu9IL/DlWhGOlrsXCfBuAlnRVEYXtQqxQKy6AiNRAdqnHO181PDJLKRaJrEhd6
 dGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xNJdLUDck8N9rbAuIyFgiog/r0oXVAnMf289PEsEveo=;
 b=i7s4/PrDrtPVoKZjxmnAR4mPHmMvcmmKyhYYPjKRtvPRwsbsfjVbJ5rF/9sc3xZp8V
 eyKSaxCAwXJ/hqu9sX9ZZFzLois+rv+NAgaxw3m095khmJKYpL7haDLokVIuO6NvW6RO
 lfGSFFpAmAnzSlNWdMPPcdR/kP7ijsEzU6X1vUAWaCqEmhWqQ5BUULfHirXvlKsup3OL
 DMsjEbX8arN3ujKWp9iPweO1I0k3EFulUPaAPuCsf0B9b2sUeIqQZP+1/J8sgfsQAIY4
 eyi4182NiW0iAt40SsWHDMZlG4p3fbD/HhyvQeiAu0Uu3gTEKdQXEa4p3j/j4n4gyUdg
 SrnA==
X-Gm-Message-State: APjAAAVtqjr9iEwjrFP7RrUM+4mpsi2H0L1/ubHeNRCXIjDxRBGqRdw3
 7VIEEKIaVST7LJq0wkeU9we/CRnXxHiM6re2Kx0=
X-Google-Smtp-Source: APXvYqzA+QhzXF/x/NjBw9Nj5ay/KPe0X8lbf7hUr63Gnh3Teal5BBP9wMpXNIoymlfQqiCAV9rEZWkNpdRB3L5djOk=
X-Received: by 2002:a19:6a01:: with SMTP id u1mr9466275lfu.141.1562619231633; 
 Mon, 08 Jul 2019 13:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190705154639.16591-1-philmd@redhat.com>
 <20190705154639.16591-6-philmd@redhat.com>
In-Reply-To: <20190705154639.16591-6-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 8 Jul 2019 13:50:43 -0700
Message-ID: <CAKmqyKPoM+=0+pa6mG6mE4JVz99dDpnx0cciYfOvYWgpBTtXWg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH v3 5/9] hw/block/pflash_cfi01: Add the
 DeviceReset() handler
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
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 5, 2019 at 8:51 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> A "system reset" sets the device state machine in READ_ARRAY mode
> and, after some delay, set the SR.7 READY bit.
>
> We do not model timings, so we set the SR.7 bit directly.
>
> The TYPE_DEVICE interface provides a DeviceReset handler.
> This pflash device is a subclass of TYPE_SYS_BUS_DEVICE (which
> is a subclass of TYPE_DEVICE).
> SYS_BUS devices are automatically plugged into the 'main system
> bus', which is the root of the qbus tree.
> Devices in the qbus tree are guaranteed to have their reset()
> handler called after realize() and before we try to run the guest.
>
> To avoid incoherent states when the machine resets (see but report
> below), factor out the reset code into pflash_cfi01_system_reset,
> and register the method as a device reset callback.
>
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1678713
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Regression-tested-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> v3: reword description
> ---
>  hw/block/pflash_cfi01.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 200bfd0ab8..c32c67d01d 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -762,8 +762,6 @@ static void pflash_cfi01_realize(DeviceState *dev, Er=
ror **errp)
>          pfl->max_device_width =3D pfl->device_width;
>      }
>
> -    pflash_mode_read_array(pfl);
> -    pfl->status =3D 0x80; /* WSM ready */
>      /* Hardcoded CFI table */
>      /* Standard "QRY" string */
>      pfl->cfi_table[0x10] =3D 'Q';
> @@ -851,6 +849,18 @@ static void pflash_cfi01_realize(DeviceState *dev, E=
rror **errp)
>      pfl->cfi_table[0x3f] =3D 0x01; /* Number of protection fields */
>  }
>
> +static void pflash_cfi01_system_reset(DeviceState *dev)
> +{
> +    PFlashCFI01 *pfl =3D PFLASH_CFI01(dev);
> +
> +    pflash_mode_read_array(pfl);
> +    /*
> +     * The WSM ready timer occurs at most 150ns after system reset.
> +     * This model deliberately ignores this delay.
> +     */
> +    pfl->status =3D 0x80;
> +}
> +
>  static Property pflash_cfi01_properties[] =3D {
>      DEFINE_PROP_DRIVE("drive", PFlashCFI01, blk),
>      /* num-blocks is the number of blocks actually visible to the guest,
> @@ -895,6 +905,7 @@ static void pflash_cfi01_class_init(ObjectClass *klas=
s, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>
> +    dc->reset =3D pflash_cfi01_system_reset;
>      dc->realize =3D pflash_cfi01_realize;
>      dc->props =3D pflash_cfi01_properties;
>      dc->vmsd =3D &vmstate_pflash;
> --
> 2.20.1
>
>

