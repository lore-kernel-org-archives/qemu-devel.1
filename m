Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033F5C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 17:43:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B03A12078B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 17:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DcV4hJsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03A12078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtaZn-00041k-17
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 13:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jtaYv-0003Sl-TC
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 13:42:21 -0400
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43]:32992)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jtaYt-0007bY-72
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 13:42:21 -0400
Received: by mail-vs1-xe43.google.com with SMTP id u133so1563059vsc.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 10:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=o2JbeKMXftGtJoL4s8sfFCDl/e8tVsp9dpvtKG1ma3A=;
 b=DcV4hJshXTJBj7dMYGyBE7xsv4bChnWOB8rp0tsqHW04UARtLHhMRL7LaaJ2j2B06H
 PsISGNWRkotms4cQYGJ4F/gs4s4e1QVbnUs7GjcyzTV2vQhoqMd0olLZF7Jq7RZZnOcN
 wKWCkz9uwyOsjLXSWfjFULT13gfmkBTtlIw+4hDzH3MWv3bSPlL5eMhYYo0lrnemTVot
 wLADi/3KtuqTImB8tUU3uWbYi6CLrd7fLRIXjjI0VxY8wFNYw2WBsVmyuTmjUS1tVmFk
 r2M5X4DmYvWLxLaPQq4OgWiQLWFnTtyMvAwAaBz2tlB5EzWZmCBHWk1Bcmvj5b2VdfhH
 lOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=o2JbeKMXftGtJoL4s8sfFCDl/e8tVsp9dpvtKG1ma3A=;
 b=hcTpyLhPbxwPhXfomHh1bwPVxJ53Ed/RjoUZWzTF/h6P60UcSYftTK5dYxRETc9Fzz
 QVE2nCnYj6SHs/42WBRPjHns+PyBKMqy01cJfyzPHkpXClXT7oDl67bEZbj8OVWiCIvK
 EbXVyh6NrC+90hNYZ8CIENz/w+sNa6lQFto6AHcJ8vZpptVLgrXLN1jksZMmL4ZvmmVN
 XY7LRGrA/54K/UQIPiRx+J0JVHhoNWpUbw3P5mbRzyHV24c6K+uujcYHF9tXDNuW9/DC
 kYTALSBnCQ62gASEjLwXdeDDeYvNhsUd6GvfaEivg6kapzMncF7hW7vEuvDzXnyK9gYQ
 p7pQ==
X-Gm-Message-State: AOAM532WdRFOXm6dcJtc8ow0IpJhf2MJWfyj7xsrvMlUVlxDjeoNhEc7
 Ug1ZlPWT2JZi6ttCD0gvxHcphJ00lv7ErP777myrig==
X-Google-Smtp-Source: ABdhPJw5Ty3VgOMyIAnHyW72iIak90HlCQUZ5hDcSMkQ/o6rmRq0aFI6SXhIp5fE48kz2opv76xQztBipdCq+MsNMlE=
X-Received: by 2002:a67:1b85:: with SMTP id
 b127mr44165443vsb.152.1594316537468; 
 Thu, 09 Jul 2020 10:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-2-hskinnemoen@google.com>
 <2fe8ea5e-56de-f57f-6146-8355125daa7f@amsat.org>
 <CAFQmdRYx99PpWz6bftCvBR7=YRftD_WNex_A9aoDaeRg=4tsCw@mail.gmail.com>
 <bd2972b0-0684-e379-6d66-16ceb62deade@amsat.org>
 <CAFQmdRbHXhd9-HUQP5ET=JQEnQ3FMCQBHajwZrP5d7=iCc0tzA@mail.gmail.com>
 <ee8bc620-6d58-98ef-1c53-a8687282af50@amsat.org>
In-Reply-To: <ee8bc620-6d58-98ef-1c53-a8687282af50@amsat.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Thu, 9 Jul 2020 10:42:06 -0700
Message-ID: <CAFQmdRa3u_Sst0i6e2whoJcYau15gVQubhZHmm+z26SD8G8uCQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] hw/misc: Add NPCM7xx System Global Control
 Registers device model
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, 
 CS20 KFTing <kfting@nuvoton.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e43;
 envelope-from=hskinnemoen@google.com; helo=mail-vs1-xe43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, PDS_OTHER_BAD_TLD=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
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

On Thu, Jul 9, 2020 at 10:24 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 7/9/20 7:09 PM, Havard Skinnemoen wrote:
> > On Thu, Jul 9, 2020 at 9:23 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=
.org> wrote:
> >> On 7/9/20 8:43 AM, Havard Skinnemoen wrote:
> >>> On Wed, Jul 8, 2020 at 11:04 PM Philippe Mathieu-Daud=C3=A9 <f4bug@am=
sat.org> wrote:
> >>>> On 7/9/20 2:35 AM, Havard Skinnemoen wrote:
> >>>>> Implement a device model for the System Global Control Registers in=
 the
> >>>>> NPCM730 and NPCM750 BMC SoCs.
> >>>>>
> >>>>> This is primarily used to enable SMP boot (the boot ROM spins readi=
ng
> >>>>> the SCRPAD register) and DDR memory initialization; other registers=
 are
> >>>>> best effort for now.
> >>>>>
> >>>>> The reset values of the MDLR and PWRON registers are determined by =
the
> >>>>> SoC variant (730 vs 750) and board straps respectively.
> >>>>>
> >>>>> Reviewed-by: Joel Stanley <joel@jms.id.au>
> >>>>> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >>>>> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> >>>>> ---
> >> [...]
> >>>>> diff --git a/hw/misc/npcm7xx_gcr.c b/hw/misc/npcm7xx_gcr.c
> >>>>> new file mode 100644
> >>>>> index 0000000000..9934cd238d
> >>>>> --- /dev/null
> >>>>> +++ b/hw/misc/npcm7xx_gcr.c
> >>>>> @@ -0,0 +1,226 @@
> >>>>> +/*
> >>>>> + * Nuvoton NPCM7xx System Global Control Registers.
> >>>>> + *
> >>>>> + * Copyright 2020 Google LLC
> >>>>> + *
> >>>>> + * This program is free software; you can redistribute it and/or m=
odify it
> >>>>> + * under the terms of the GNU General Public License as published =
by the
> >>>>> + * Free Software Foundation; either version 2 of the License, or
> >>>>> + * (at your option) any later version.
> >>>>> + *
> >>>>> + * This program is distributed in the hope that it will be useful,=
 but WITHOUT
> >>>>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABIL=
ITY or
> >>>>> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public Li=
cense
> >>>>> + * for more details.
> >>>>> + */
> >>>>> +
> >>>>> +#include "qemu/osdep.h"
> >>>>> +
> >>>>> +#include "hw/misc/npcm7xx_gcr.h"
> >>>>> +#include "hw/qdev-properties.h"
> >>>>> +#include "migration/vmstate.h"
> >>>>> +#include "qapi/error.h"
> >>>>> +#include "qemu/log.h"
> >>>>> +#include "qemu/module.h"
> >>>>> +#include "qemu/units.h"
> >>>>> +
> >>>>> +#include "trace.h"
> >>>>> +
> >>>>> +static const uint32_t cold_reset_values[NPCM7XX_GCR_NR_REGS] =3D {
> >>>>> +    [NPCM7XX_GCR_PDID]          =3D 0x04a92750,   /* Poleg A1 */
> >>>>> +    [NPCM7XX_GCR_MISCPE]        =3D 0x0000ffff,
> >>>>> +    [NPCM7XX_GCR_SPSWC]         =3D 0x00000003,
> >>>>> +    [NPCM7XX_GCR_INTCR]         =3D 0x0000035e,
> >>>>> +    [NPCM7XX_GCR_HIFCR]         =3D 0x0000004e,
> >>>>> +    [NPCM7XX_GCR_INTCR2]        =3D (1U << 19),   /* DDR initializ=
ed */
> >>>>> +    [NPCM7XX_GCR_RESSR]         =3D 0x80000000,
> >>>>> +    [NPCM7XX_GCR_DSCNT]         =3D 0x000000c0,
> >>>>> +    [NPCM7XX_GCR_DAVCLVLR]      =3D 0x5a00f3cf,
> >>>>> +    [NPCM7XX_GCR_SCRPAD]        =3D 0x00000008,
> >>>>> +    [NPCM7XX_GCR_USB1PHYCTL]    =3D 0x034730e4,
> >>>>> +    [NPCM7XX_GCR_USB2PHYCTL]    =3D 0x034730e4,
> >>>>> +};
> >>>>> +
> >>>>> +static uint64_t npcm7xx_gcr_read(void *opaque, hwaddr offset, unsi=
gned size)
> >>>>> +{
> >>>>> +    uint32_t reg =3D offset / sizeof(uint32_t);
> >>>>> +    NPCM7xxGCRState *s =3D opaque;
> >>>>> +
> >>>>> +    if (reg >=3D NPCM7XX_GCR_NR_REGS) {
> >>>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: offset 0x%04x out of r=
ange\n",
> >>>>> +                      __func__, (unsigned int)offset);
> >>>>
> >>>> Maybe use HWADDR_PRIx instead of casting to int?
> >>>
> >>> Will do, thanks!
> >>
> >> Glad you are not annoyed by my review comments.
> >>
> >> FYI your series quality is in my top-4 "adding new machine to QEMU".
> >> I'd like to use it as example to follow.
> >>
> >> I am slowly reviewing because this is not part of my work duties,
> >> so I do that in my free time before/after work, which is why I can
> >> barely do more that 2 per day, as I have to learn the SoC and
> >> cross check documentation (or in this case, existing firmware code
> >> since there is no public doc).
> >
> > Your feedback is super valuable, thanks a lot. I really appreciate it.
>
> OK I'll continue, but might not have time until next week.
> After I plan to test too.

OK, I'll try to post a v6 before the weekend, unless you prefer that I
hold off until you've reviewed the whole series.

> What would be useful is an acceptance test (see examples in
> tests/acceptance/), using the artefacts from the link you shared
> elsewhere:
> https://openpower.xyz/job/run-meta-ci/distro=3Dubuntu,label=3Dbuilder,tar=
get=3Dgsj/lastSuccessfulBuild/artifact/openbmc/build/tmp/deploy/images/gsj/

Yes, tests are definitely on my radar. I'm working on SPI flash
qtests. I haven't had much success with avocado yet, but I'll keep
trying (perhaps using docker to control the environment more tightly).

Since the 5.1 release is frozen now, I might post some followup
patches before this series is merged, e.g. tests, bootrom
submodule+blob, more peripherals, etc. Is it preferable to keep this
series frozen (modulo API updates) since you spent a lot of time
reviewing it, and post the new stuff separately, or is it better to
add new patches to the end of the series and resend the whole thing?

> But these are apparently not stable links (expire after 30 days?).

Sorry, I'm too ignorant about Jenkins to know. I'll see if I can
figure something out.

> >> [...]
> >>>>> +static void npcm7xx_gcr_realize(DeviceState *dev, Error **errp)
> >>>>> +{
> >>>>> +    NPCM7xxGCRState *s =3D NPCM7XX_GCR(dev);
> >>>>> +    uint64_t dram_size;
> >>>>> +    Error *err =3D NULL;
> >>>>> +    Object *obj;
> >>>>> +
> >>>>> +    obj =3D object_property_get_link(OBJECT(dev), "dram-mr", &err)=
;
> >>>>> +    if (!obj) {
> >>>>> +        error_setg(errp, "%s: required dram-mr link not found: %s"=
,
> >>>>> +                   __func__, error_get_pretty(err));
> >>>>> +        return;
> >>>>> +    }
> >>>>> +    dram_size =3D memory_region_size(MEMORY_REGION(obj));
> >>>>> +
> >>>>> +    /* Power-on reset value */
> >>>>> +    s->reset_intcr3 =3D 0x00001002;
> >>>>> +
> >>>>> +    /*
> >>>>> +     * The GMMAP (Graphics Memory Map) field is used by u-boot to =
detect the
> >>>>> +     * DRAM size, and is normally initialized by the boot block as=
 part of DRAM
> >>>>> +     * training. However, since we don't have a complete emulation=
 of the
> >>>>> +     * memory controller and try to make it look like it has alrea=
dy been
> >>>>> +     * initialized, the boot block will skip this initialization, =
and we need
> >>>>> +     * to make sure this field is set correctly up front.
> >>>>> +     *
> >>>>> +     * WARNING: some versions of u-boot only looks at bits 8 and 9=
, so 2 GiB or
> >>>>> +     * more of DRAM will be interpreted as 128 MiB.
> >>>>
> >>>> I'd say u-boot is right in wrapping at 2GB, as more DRAM is
> >>>> un-addressable.
> >>>
> >>> Ah, maybe I shouldn't have said "or more". The bug is that if you
> >>> specify _exactly_ 2GiB, u-boot will see 128 MiB.
> >>>
> >>> But I agree more than 2GiB doesn't make sense, so I'll add a check fo=
r that.
> >>>
> >>> Not sure if I agree that the check should be here. > 2 GiB is an
> >>> addressing limitation, and the GCR module shouldn't really know what
> >>> the SoC's address space looks like. The lower limit is because the GC=
R
> >>> module can't encode anything less than 128 MiB.
> >>>
> >>>>> +     *
> >>>>> +     * https://github.com/Nuvoton-Israel/u-boot/blob/2aef993bd2aaf=
eb5408dbaad0f3ce099ee40c4aa/board/nuvoton/poleg/poleg.c#L244
> >>>>> +     */
> >>>>> +    if (dram_size >=3D 2 * GiB) {
> >>>>
> >>>> See my comment in this series on the machine patch.
> >>>>
> >>>>> +        s->reset_intcr3 |=3D 4 << 8;
> >>>>> +    } else if (dram_size >=3D 1 * GiB) {
> >>>>> +        s->reset_intcr3 |=3D 3 << 8;
> >>>>> +    } else if (dram_size >=3D 512 * MiB) {
> >>>>> +        s->reset_intcr3 |=3D 2 << 8;
> >>>>> +    } else if (dram_size >=3D 256 * MiB) {
> >>>>> +        s->reset_intcr3 |=3D 1 << 8;
> >>>>> +    } else if (dram_size >=3D 128 * MiB) {
> >>>>> +        s->reset_intcr3 |=3D 0 << 8;
> >>
> >> I think this can be simplified as:
> >>
> >>          s->reset_intcr3 =3D (4 - clz32(dram_size)) << 8;
> >>
> >> Which implicitly truncate to power of 2 (which is what this
> >> block does, as you can have only 1 bank managed per this SGC).
> >
> > Good idea. I find this a little easier to understand though:
> >
> > #define NPCM7XX_GCR_MIN_DRAM_SIZE   (128 * MiB)
> >
> >     s->reset_intcr3 |=3D ctz64(dram_size / NPCM7XX_GCR_MIN_DRAM_SIZE) <=
< 8;
>
> I like it, furthermore it will work with >4GB if this model is
> ever reused on an ARMv8-A SoC.
>
> >> But checking is_power_of_2(dram_size) and reporting an error
> >> else, is probably even better.
> >
> > OK, I'll add a check for this, and also explicit checks for too large
> > and too small. The former is currently redundant with the DRAM size
> > check I'm adding to npcm7xx_realize(), but I kind of like the idea of
> > checking for encoding limitations and addressing limitations
> > separately, as they may not necessarily stay the same forever.
> >
> >>>>> +    } else {
> >>>>> +        error_setg(errp,
> >>>>> +                   "npcm7xx_gcr: DRAM size %" PRIu64
> >>>>> +                   " is too small (need 128 MiB minimum)",
> >>>>> +                   dram_size);
> >>>>
> >>>> Ah, so you could add the same error for >2GB. Easier.
> >>>>
> >>>> Preferably using HWADDR_PRIx, and similar error for >2GB:
> >>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >

