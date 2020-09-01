Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872D0C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:21:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D272087D
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDfpcsZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D272087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD9yN-0000pk-HJ
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 13:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kD9xa-0000II-Ky
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:20:42 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:35946)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kD9xY-000726-Uv
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:20:42 -0400
Received: by mail-ed1-x541.google.com with SMTP id w1so2213108edr.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 10:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/nq/Zs2ETPVHLa3om9uFeoLEJPwIPqGD1vJtu6srYgc=;
 b=VDfpcsZYzQ1wsFUnHRRdjU+aomzFTI52v21j5Lebh4XlAUAiHKP1e77mAnbN0HwGFu
 QvUIihfVPMVj3dPSdIHUkCI+9kf3Lo59MSMVKWPmGhp9FTjscUYi2HNwNcSa/ZXP7hMw
 UA4dNCkx/7x2RUc6Hw3wnQmlD8UwAtPYInvqxPDMnMcSek5kcsmzN9ydb1zYFGvPFJwc
 D+nU5EnXdU1LZ1v+8D31qMuzyucGnFa3RjPHdEuzNUxQ60sukRhHlxf02wGH3aE45+tq
 ZAEhQVmQ4oYKNIA73pkCwGL+UYj6ub+gKINLOZ/HaDeruK69NfeRFF1gejY/uNZ0SOCf
 eiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/nq/Zs2ETPVHLa3om9uFeoLEJPwIPqGD1vJtu6srYgc=;
 b=VZW9+Ri+FPQzz54Sqdc4DfxywDlai9gf2gGP18I2f3G6awVj8Rg/rHzTeHrwR8ffDp
 oTWxU0YpstTg8EI4VJvyMVb6Dxa+1qiXrFIDtw2aQtzf6BdArSrwRmealYJxyL5UnqaR
 al4p5FKsJwecvMEXkRUtEpGVImcBV/DAI/QrKghnlRqKA+AcDekYxy84OBLYg4J2+bbw
 z5FeJ8cHRT+bH7fArcm5NxOsBaDmKMUT4tlxwLXdI8hKyoaJ8RnZ4b/Ku8r5NVYBaazG
 uv7x3t5unEo2V9ViB3AA72RdJ0LEjZUOkwM5zaFvkqZ8vyZEdq9+P3d45sVvaBeRYGmT
 v9OA==
X-Gm-Message-State: AOAM531lcL0AWz+ApP6gNS13VfGkqiOJBGv/EkyFnOZoPWTSa7dtnStX
 DrdzNwk+i4DgXkBM4QDDpdmZZaPF4SxWldLgA08=
X-Google-Smtp-Source: ABdhPJxS1hKlUGvWDnNRyuR+FEPEl/BIVZLIkzZokgFSae0rXP3XthHseCdWZtsA+2/1rhwr4+faYVxZzaP43/mJIzU=
X-Received: by 2002:a50:fc08:: with SMTP id i8mr2759606edr.257.1598980839542; 
 Tue, 01 Sep 2020 10:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200730165900.7030-1-philmd@redhat.com>
 <20200730165900.7030-2-philmd@redhat.com>
In-Reply-To: <20200730165900.7030-2-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 1 Sep 2020 21:20:27 +0400
Message-ID: <CAJ+F1C+LGO-nCEo7ELs4j07-cAahXmrbn=NWDX31=gpMP7OKLA@mail.gmail.com>
Subject: Re: [PATCH-for-5.2 1/2] hw/mips/mipssim: Use MMIO serial device on
 fake ISA I/O
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f1964b05ae43bcfb"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f1964b05ae43bcfb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Jul 30, 2020 at 9:04 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> The 'mipssim' is not a real hardware, it is a simulator.
>
> There is an ISA MMIO space mapped at 0x1fd00000, however
> this is not a real ISA bus (no ISA IRQ). So can not use
> the TYPE_ISA_SERIAL device...
> Instead we have been using a plain MMIO device, but named
> it IO.
>
> TYPE_SERIAL_IO is a superset of TYPE_SERIAL_MM, using
> regshift=3D0 and endianness=3DDEVICE_LITTLE_ENDIAN.
>
> Directly use the TYPE_SERIAL_MM device, enforcing the
> regshift/endianness values. 'regshift' default is already
> '0'. 'endianness' is meaningless for 8-bit accesses.
>
> Note, there is no migration problem, because TYPE_SERIAL_IO
> was not migrated.
>

I am not so sure about that. It has:
    /* No dc->vmsd: class has no migratable state */

but that doesn't mean it's not migratable I think.


> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/mips/mipssim.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
> index 1b3b762203..853bbaca58 100644
> --- a/hw/mips/mipssim.c
> +++ b/hw/mips/mipssim.c
> @@ -216,9 +216,11 @@ mips_mipssim_init(MachineState *machine)
>       * MIPS CPU INT2, which is interrupt 4.
>       */
>      if (serial_hd(0)) {
> -        DeviceState *dev =3D qdev_new(TYPE_SERIAL_IO);
> +        DeviceState *dev =3D qdev_new(TYPE_SERIAL_MM);
>
>          qdev_prop_set_chr(dev, "chardev", serial_hd(0));
> +        qdev_prop_set_uint8(dev, "regshift", 0);
> +        qdev_prop_set_uint8(dev, "endianness", DEVICE_LITTLE_ENDIAN);
>          qdev_set_legacy_instance_id(dev, 0x3f8, 2);
>          sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>          sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, env->irq[4]);
> --
> 2.21.3
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000f1964b05ae43bcfb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 30, 2020 at 9:04 PM Phi=
lippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@re=
dhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">The &#39;mipssim&#39; is not a real hardware, it is a simulator.<br=
>
<br>
There is an ISA MMIO space mapped at 0x1fd00000, however<br>
this is not a real ISA bus (no ISA IRQ). So can not use<br>
the TYPE_ISA_SERIAL device...<br>
Instead we have been using a plain MMIO device, but named<br>
it IO.<br>
<br>
TYPE_SERIAL_IO is a superset of TYPE_SERIAL_MM, using<br>
regshift=3D0 and endianness=3DDEVICE_LITTLE_ENDIAN.<br>
<br>
Directly use the TYPE_SERIAL_MM device, enforcing the<br>
regshift/endianness values. &#39;regshift&#39; default is already<br>
&#39;0&#39;. &#39;endianness&#39; is meaningless for 8-bit accesses.<br>
<br>
Note, there is no migration problem, because TYPE_SERIAL_IO<br>
was not migrated.<br></blockquote><div><br></div><div>I am not so sure abou=
t that. It has:</div><div>=C2=A0 =C2=A0 /* No dc-&gt;vmsd: class has no mig=
ratable state */</div><div><br></div><div>but that doesn&#39;t mean it&#39;=
s not migratable I think.<br></div><div> <br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
<br>
Suggested-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org"=
 target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/mips/mipssim.c | 4 +++-<br>
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c<br>
index 1b3b762203..853bbaca58 100644<br>
--- a/hw/mips/mipssim.c<br>
+++ b/hw/mips/mipssim.c<br>
@@ -216,9 +216,11 @@ mips_mipssim_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0 * MIPS CPU INT2, which is interrupt 4.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0if (serial_hd(0)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 DeviceState *dev =3D qdev_new(TYPE_SERIAL_IO);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DeviceState *dev =3D qdev_new(TYPE_SERIAL_MM);=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_prop_set_chr(dev, &quot;chardev&quot=
;, serial_hd(0));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_uint8(dev, &quot;regshift&quot;,=
 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_uint8(dev, &quot;endianness&quot=
;, DEVICE_LITTLE_ENDIAN);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_set_legacy_instance_id(dev, 0x3f8, 2=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_realize_and_unref(SYS_BUS_DEVICE(d=
ev), &amp;error_fatal);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0=
, env-&gt;irq[4]);<br>
-- <br>
2.21.3<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000f1964b05ae43bcfb--

