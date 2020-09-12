Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED210C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 22:26:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CCEC214F1
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 22:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HsjCNrKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCEC214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHDyA-0007Rv-3Y
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 18:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kHDxO-0006pZ-2j
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 18:25:18 -0400
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943]:40644)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kHDxL-0002Ea-57
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 18:25:17 -0400
Received: by mail-ua1-x943.google.com with SMTP id j12so1550069ual.7
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2020 15:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZGaX7CsCAWtERESwHJLWurSNk7QjKSPOqUNldqXNN+8=;
 b=HsjCNrKrg1lOg8ickXxcAAbpkMteeXxOwnqnjlxRChB5fxpChvMGfykP/rkNGlA2g+
 BR8OVCC35K1a7FAK/wcN1P07I3pMVEDZ/mwkArN+ual6kcIa2+YgPfeyAk2KQlTtLMvP
 HXUyiktDbIEuzpxX8xZHqgR97+Kvxl88KmtUupo95CzLSEcYhy9v7n6sYDh0CUAF8MP+
 f4kW6GgKVyOTYtxigiNlKnsWeqFwZxpxn18E8TCadYCyem8MNTiFowmVqzanztc2paHu
 0GuvwPTGRy/AqiCkmBznPoIoFC4QGqF0F1bQRO+nLFo7xxssn0D+tE+a7wVQeYsmKJYZ
 wUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZGaX7CsCAWtERESwHJLWurSNk7QjKSPOqUNldqXNN+8=;
 b=CI9Ql40WtHNhH/QpJv+I2t0fo+G0feEnEuIqvcpYhL9jmmgqe3Y6ahiQyJm3g6ERvH
 FhYT0w+sqk8jeb+bp4bipzL/KIO9Y3Y48BtgH0R8dVr8rfzmgTECyzHdZ2QBbSXO+RtS
 3J//Dt7hUrKzc5wOOwGvMtApQJdL0ewEgVbuXYo2a32babvz4KKPqTLwuCVVaoQFWVNX
 KbAXikTLMBn8jqPDLdA+zixoJtezwjCo/gKOHAHY3Dn5RT2Ec0usndJHYEz0nls6iU6k
 IgiYt3lazah+rr5wLj2EzBVq2Nv3gIxSxZ9NRJ59//FiAW0sL3ovt+Ey+YaVjeJPruE3
 k4dw==
X-Gm-Message-State: AOAM532X4cMT1y2OwyVUD/72ULDYOxlj3kaRhdPXxKIkZow5NjKBzTnR
 cS7fz5R//bHce8AUB3D5I+DMzw1yOE2HHO4IY5rZ1A==
X-Google-Smtp-Source: ABdhPJx+2XLlQdNmYlJwEJXep6kZvT8n5bBlmtC5qF7kA0QYGi3P4BObSscHnN5bRkt6k0mI6eRHJhGSys3d37tNK9M=
X-Received: by 2002:ab0:2904:: with SMTP id v4mr4017866uap.15.1599949511811;
 Sat, 12 Sep 2020 15:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200911052101.2602693-1-hskinnemoen@google.com>
 <20200911052101.2602693-12-hskinnemoen@google.com>
 <e852efda-b8d9-0e41-8b1b-ed7cb01e7f51@amsat.org>
In-Reply-To: <e852efda-b8d9-0e41-8b1b-ed7cb01e7f51@amsat.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Sat, 12 Sep 2020 15:24:58 -0700
Message-ID: <CAFQmdRbjH7=6VE=dDVNmKGenHoseKnNNr3SLcQojo0doS+gT7Q@mail.gmail.com>
Subject: Re: [PATCH v9 11/14] hw/arm: Wire up BMC boot flash for npcm750-evb
 and quanta-gsj
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, 
 CS20 KFTing <kfting@nuvoton.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: multipart/alternative; boundary="0000000000004fdb6d05af2546eb"
Received-SPF: pass client-ip=2607:f8b0:4864:20::943;
 envelope-from=hskinnemoen@google.com; helo=mail-ua1-x943.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004fdb6d05af2546eb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2020 at 5:46 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

>
>
> On 9/11/20 7:20 AM, Havard Skinnemoen via wrote:
> > This allows these NPCM7xx-based boards to boot from a flash image, e.g.
> > one built with OpenBMC. For example like this:
> >
> > IMAGE=3D${OPENBMC}/build/tmp/deploy/images/gsj/image-bmc
> > qemu-system-arm -machine quanta-gsj -nographic \
> >       -drive file=3D${IMAGE},if=3Dmtd,bus=3D0,unit=3D0,format=3Draw,sna=
pshot=3Don
> >
> > Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> > Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> > ---
> >  hw/arm/npcm7xx_boards.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
> > index b4c772d6b5..79e2e2744c 100644
> > --- a/hw/arm/npcm7xx_boards.c
> > +++ b/hw/arm/npcm7xx_boards.c
> > @@ -20,6 +20,7 @@
> >  #include "hw/arm/npcm7xx.h"
> >  #include "hw/core/cpu.h"
> >  #include "hw/loader.h"
> > +#include "hw/qdev-properties.h"
> >  #include "qapi/error.h"
> >  #include "qemu-common.h"
> >  #include "qemu/units.h"
> > @@ -55,6 +56,22 @@ static void npcm7xx_load_bootrom(MachineState
> *machine, NPCM7xxState *soc)
> >      }
> >  }
> >
> > +static void npcm7xx_connect_flash(NPCM7xxFIUState *fiu, int cs_no,
> > +                                  const char *flash_type, DriveInfo
> *dinfo)
> > +{
> > +    DeviceState *flash;
> > +    qemu_irq flash_cs;
> > +
> > +    flash =3D qdev_new(flash_type);
> > +    if (dinfo) {
> > +        qdev_prop_set_drive(flash, "drive", blk_by_legacy_dinfo(dinfo)=
);
> > +    }
> > +    qdev_realize_and_unref(flash, BUS(fiu->spi), &error_fatal);
> > +
> > +    flash_cs =3D qdev_get_gpio_in_named(flash, SSI_GPIO_CS, 0);
> > +    qdev_connect_gpio_out_named(DEVICE(fiu), "cs", cs_no, flash_cs);
> > +}
> > +
> >  static void npcm7xx_connect_dram(NPCM7xxState *soc, MemoryRegion *dram=
)
> >  {
> >      memory_region_add_subregion(get_system_memory(), NPCM7XX_DRAM_BA,
> dram);
> > @@ -92,6 +109,7 @@ static void npcm750_evb_init(MachineState *machine)
> >      qdev_realize(DEVICE(soc), NULL, &error_fatal);
> >
> >      npcm7xx_load_bootrom(machine, soc);
> > +    npcm7xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD=
,
> 0, 0));
>
> Nitpicking: add definition for '0' magic number
> (consider as future cleanup).
>

Thanks. I've made the change, but won't send it out until this series is
merged, or I'll fold it in if I need to do another iteration for other
reasons.

>      npcm7xx_load_kernel(machine, soc);
> >  }
> >
> > @@ -104,6 +122,8 @@ static void quanta_gsj_init(MachineState *machine)
> >      qdev_realize(DEVICE(soc), NULL, &error_fatal);
> >
> >      npcm7xx_load_bootrom(machine, soc);
> > +    npcm7xx_connect_flash(&soc->fiu[0], 0, "mx25l25635e",
> > +                          drive_get(IF_MTD, 0, 0));
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> >      npcm7xx_load_kernel(machine, soc);
> >  }
> >
> >
>

--0000000000004fdb6d05af2546eb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 11, 2020 at 5:46 AM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.o=
rg</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><br>
<br>
On 9/11/20 7:20 AM, Havard Skinnemoen via wrote:<br>
&gt; This allows these NPCM7xx-based boards to boot from a flash image, e.g=
.<br>
&gt; one built with OpenBMC. For example like this:<br>
&gt; <br>
&gt; IMAGE=3D${OPENBMC}/build/tmp/deploy/images/gsj/image-bmc<br>
&gt; qemu-system-arm -machine quanta-gsj -nographic \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-drive file=3D${IMAGE},if=3Dmtd,bus=3D0,unit=
=3D0,format=3Draw,snapshot=3Don<br>
&gt; <br>
&gt; Reviewed-by: Tyrone Ting &lt;<a href=3D"mailto:kfting@nuvoton.com" tar=
get=3D"_blank" class=3D"cremed">kfting@nuvoton.com</a>&gt;<br>
&gt; Reviewed-by: C=C3=A9dric Le Goater &lt;<a href=3D"mailto:clg@kaod.org"=
 target=3D"_blank" class=3D"cremed">clg@kaod.org</a>&gt;<br>
&gt; Tested-by: C=C3=A9dric Le Goater &lt;<a href=3D"mailto:clg@kaod.org" t=
arget=3D"_blank" class=3D"cremed">clg@kaod.org</a>&gt;<br>
&gt; Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@ams=
at.org" target=3D"_blank" class=3D"cremed">f4bug@amsat.org</a>&gt;<br>
&gt; Signed-off-by: Havard Skinnemoen &lt;<a href=3D"mailto:hskinnemoen@goo=
gle.com" target=3D"_blank" class=3D"cremed">hskinnemoen@google.com</a>&gt;<=
br>
&gt; ---<br>
&gt;=C2=A0 hw/arm/npcm7xx_boards.c | 20 ++++++++++++++++++++<br>
&gt;=C2=A0 1 file changed, 20 insertions(+)<br>
&gt; <br>
&gt; diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c<br>
&gt; index b4c772d6b5..79e2e2744c 100644<br>
&gt; --- a/hw/arm/npcm7xx_boards.c<br>
&gt; +++ b/hw/arm/npcm7xx_boards.c<br>
&gt; @@ -20,6 +20,7 @@<br>
&gt;=C2=A0 #include &quot;hw/arm/npcm7xx.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/core/cpu.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/loader.h&quot;<br>
&gt; +#include &quot;hw/qdev-properties.h&quot;<br>
&gt;=C2=A0 #include &quot;qapi/error.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu-common.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/units.h&quot;<br>
&gt; @@ -55,6 +56,22 @@ static void npcm7xx_load_bootrom(MachineState *mach=
ine, NPCM7xxState *soc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static void npcm7xx_connect_flash(NPCM7xxFIUState *fiu, int cs_no,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *flash_type, D=
riveInfo *dinfo)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceState *flash;<br>
&gt; +=C2=A0 =C2=A0 qemu_irq flash_cs;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 flash =3D qdev_new(flash_type);<br>
&gt; +=C2=A0 =C2=A0 if (dinfo) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_drive(flash, &quot;drive&qu=
ot;, blk_by_legacy_dinfo(dinfo));<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 qdev_realize_and_unref(flash, BUS(fiu-&gt;spi), &amp;er=
ror_fatal);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 flash_cs =3D qdev_get_gpio_in_named(flash, SSI_GPIO_CS,=
 0);<br>
&gt; +=C2=A0 =C2=A0 qdev_connect_gpio_out_named(DEVICE(fiu), &quot;cs&quot;=
, cs_no, flash_cs);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static void npcm7xx_connect_dram(NPCM7xxState *soc, MemoryRegion=
 *dram)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), N=
PCM7XX_DRAM_BA, dram);<br>
&gt; @@ -92,6 +109,7 @@ static void npcm750_evb_init(MachineState *machine)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qdev_realize(DEVICE(soc), NULL, &amp;error_fatal);=
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 npcm7xx_load_bootrom(machine, soc);<br>
&gt; +=C2=A0 =C2=A0 npcm7xx_connect_flash(&amp;soc-&gt;fiu[0], 0, &quot;w25=
q256&quot;, drive_get(IF_MTD, 0, 0));<br>
<br>
Nitpicking: add definition for &#39;0&#39; magic number<br>
(consider as future cleanup).<br></blockquote><div><br></div><div>Thanks. I=
&#39;ve made the change, but won&#39;t send it out until this series is mer=
ged, or I&#39;ll fold it in if I need to do another iteration for other rea=
sons.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
&gt;=C2=A0 =C2=A0 =C2=A0 npcm7xx_load_kernel(machine, soc);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; @@ -104,6 +122,8 @@ static void quanta_gsj_init(MachineState *machine)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qdev_realize(DEVICE(soc), NULL, &amp;error_fatal);=
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 npcm7xx_load_bootrom(machine, soc);<br>
&gt; +=C2=A0 =C2=A0 npcm7xx_connect_flash(&amp;soc-&gt;fiu[0], 0, &quot;mx2=
5l25635e&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 drive_get(IF_MTD, 0, 0));<br>
<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.=
org" target=3D"_blank" class=3D"cremed">f4bug@amsat.org</a>&gt;<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 npcm7xx_load_kernel(machine, soc);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; <br>
</blockquote></div></div>

--0000000000004fdb6d05af2546eb--

