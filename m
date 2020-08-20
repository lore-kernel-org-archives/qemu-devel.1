Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84727C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 20:32:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D0132076E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 20:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r9Nd+f5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0132076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8rEj-0005BF-Eg
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 16:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1k8rD5-00044D-G4
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 16:30:55 -0400
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44]:46234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1k8rCv-0000Jh-UW
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 16:30:52 -0400
Received: by mail-vs1-xe44.google.com with SMTP id b26so1770082vsa.13
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 13:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=avKOzD1xqNur7yDwT+dTnw38wAGDWbTeBDODCRqKZIA=;
 b=r9Nd+f5oDZYrHK6boncyLUpYqSYvESOEPJPQ++GN1x1FZNQzYrUmXBVVFegcRoVmio
 cFhgzKNA4ZaYI7Y9ls4aYdg8KpD+Jzg9VTjVJpwhBQ25Ohlo+ko3SgRzt+oaZnsbCTHq
 Lhiix5ZVYeB909NmRB7vOyr7+QLFZYh0uPSvpo3INejwxuoUYgTqAgV/YqN2bVl14L4L
 vwrh5s7gCR6V+eBozUiKIpfA6ilTzBsUNW8gl/VB1q4mD3iXc6Qq62NxDVc8QUJFnzjV
 PNTnbwsWwHMCYumZa55lqkoGaf72BKALjh0icO9GthFd1faUz1cS5ap965ouoXh9IvGC
 rYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=avKOzD1xqNur7yDwT+dTnw38wAGDWbTeBDODCRqKZIA=;
 b=f8J4lXMrYPyfDLo0xkYl1BqodFaXEu9O1266VKT0s5nhELXZAwrZoUCv9xTgxHMJCU
 jiy4zG3mCxIKrT+eu0jv2mXIGXoqCoxqIgNKJESM3yfOZ7D0BXZL+goAYMX4eFIvdAWT
 efzt2eCtw+zns89wxIOX+ZN9Pl7W+FXdDFFNYSXt3goY+qCpVdKWlKvOw5CiVQwbEqMY
 UcaqbdKLS4PTtQ4GPAcMBofSolBAKer5YusjTvpTISZSU76upidO8xMLDE6ksjtX78WE
 mYu5iCBmnVAl6MsSA6VXBtcLAml9j3uSGJSGkAFJHFt+eDHp8omNERxw26/k2j/qRx4K
 J8wg==
X-Gm-Message-State: AOAM532CAXn0QHA4l5FJAkzS4i8ngWaPjhgDbMmwaIg57KWWXsfAjkhc
 FTY0u8+OPHpYXWoli1L4V4a8ObhCj/ZNeALHsaF1xw==
X-Google-Smtp-Source: ABdhPJzvNrbgDFzVR8Oa+SUv4WBPD0O7iAiLzJN7a8oXaOxhTOsq2oZ7HLK1cY3wY2VbnvciczxYjvX+V7IVGUujnVI=
X-Received: by 2002:a67:cd10:: with SMTP id u16mr436361vsl.152.1597955443489; 
 Thu, 20 Aug 2020 13:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200811004607.2133149-1-hskinnemoen@google.com>
 <20200811004607.2133149-14-hskinnemoen@google.com>
 <64f8cd56-306e-4961-488b-36c666894a54@amsat.org>
 <CAFQmdRbvSKYJ00tE_79Eh+gW_ge8kEco=1gqFtvMcoJGraozdw@mail.gmail.com>
 <CAFQmdRZCk5Rqb1C2TRCEUMaKmF608g2_Or8mLCTSG03nCQ1Ygg@mail.gmail.com>
 <28a30c64-7cc5-4b4f-2be2-b3d3af511cb1@amsat.org>
 <CAFQmdRYFLUdbs5mj3zHzNN1y+bvQXCrtGhY_iOLVfnydGxM0Jw@mail.gmail.com>
 <6a23375f-64ec-cfdd-10cf-272eef719dd6@amsat.org>
In-Reply-To: <6a23375f-64ec-cfdd-10cf-272eef719dd6@amsat.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Thu, 20 Aug 2020 13:30:31 -0700
Message-ID: <CAFQmdRY9GSqjW+wcbRzsC6dEB9KMibnxWAp+F6jpmf2_9iBEFw@mail.gmail.com>
Subject: Re: [PATCH v7 13/13] tests/acceptance: console boot tests for
 quanta-gsj
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, 
 CS20 KFTing <kfting@nuvoton.com>, Cleber Rosa <crosa@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 Richard Henderson <rth@twiddle.net>, Andrew Jeffery <andrew@aj.id.au>, 
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e44;
 envelope-from=hskinnemoen@google.com; helo=mail-vs1-xe44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

On Thu, Aug 20, 2020 at 10:46 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> On 8/20/20 6:24 PM, Havard Skinnemoen wrote:
> > On Wed, Aug 19, 2020 at 10:29 PM Philippe Mathieu-Daud=C3=A9 <f4bug@ams=
at.org> wrote:
> >>
> >> +Eric / Richard for compiler optimizations.
> >>
> >> On 8/20/20 3:53 AM, Havard Skinnemoen wrote:
> >>> On Tue, Aug 11, 2020 at 8:26 PM Havard Skinnemoen
> >>> <hskinnemoen@google.com> wrote:
> >>>>
> >>>> On Tue, Aug 11, 2020 at 1:48 AM Philippe Mathieu-Daud=C3=A9 <f4bug@a=
msat.org> wrote:
> >>>>> INTERRUPTED: Test interrupted by SIGTERM
> >>>>> Runner error occurred: Timeout reached
> >>>>> (240.45 s)
> >>>>>
> >>>>> Is that expected?
> >>>>
> >>>> I'm not sure why it only happens when running direct kernel boot wit=
h
> >>>> unoptimized qemu, but it seems a little happier if I enable a few mo=
re
> >>>> peripherals that I have queued up (sd, ehci, ohci and rng), though n=
ot
> >>>> enough.
> >>>>
> >>>> It still stalls for an awfully long time on "console: Run /init as
> >>>> init process" though. I'm not sure what it's doing there. With -O2 i=
t
> >>>> only takes a couple of seconds to move on.
> >>>
> >>> So it turns out that the kernel gets _really_ sluggish when skipping
> >>> the clock initialization normally done by the boot loader.
> >>>
> >>> I changed the reset value of CLKSEL like this:
> >>>
> >>> diff --git a/hw/misc/npcm7xx_clk.c b/hw/misc/npcm7xx_clk.c
> >>> index 21ab4200d1..5e9849410f 100644
> >>> --- a/hw/misc/npcm7xx_clk.c
> >>> +++ b/hw/misc/npcm7xx_clk.c
> >>> @@ -67,7 +67,7 @@ enum NPCM7xxCLKRegisters {
> >>>   */
> >>>  static const uint32_t cold_reset_values[NPCM7XX_CLK_NR_REGS] =3D {
> >>>      [NPCM7XX_CLK_CLKEN1]        =3D 0xffffffff,
> >>> -    [NPCM7XX_CLK_CLKSEL]        =3D 0x004aaaaa,
> >>> +    [NPCM7XX_CLK_CLKSEL]        =3D 0x004aaba9,
> >>>      [NPCM7XX_CLK_CLKDIV1]       =3D 0x5413f855,
> >>>      [NPCM7XX_CLK_PLLCON0]       =3D 0x00222101 | PLLCON_LOKI,
> >>>      [NPCM7XX_CLK_PLLCON1]       =3D 0x00202101 | PLLCON_LOKI,
> >>>
> >>> which switches the CPU core and UART to run from PLL2 instead of
> >>> CLKREF (25 MHz).
> >>>
> >>> With this change, the test passes without optimization:
> >>>
> >>>  (02/19) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test=
_arm_quanta_gsj_initrd:
> >>> PASS (39.62 s)
> >>>
> >>> It doesn't look like this change hurts booting from the bootrom (IIUC
> >>> the nuvoton bootblock overwrites CLKSEL anyway), but it's not super
> >>> clean.
> >>>
> >>> Perhaps I should make it conditional on kernel_filename being set? Or
> >>> would it be better to provide a write_board_setup hook for this?
> >>
> >> QEMU prefers to avoid ifdef'ry at all cost. However I find this
> >> approach acceptable (anyway up to the maintainer):
> >>
> >> +static void npcm7xx_clk_cold_reset_fixup(NPCM7xxCLKState *s)
> >> +{
> >> +#ifndef __OPTIMIZE__
> >> +    /*
> >> +     * When built without optimization, ...
> >> +     * so run CPU core and UART from PLL2 instead of CLKREF.
> >> +     */
> >> +    s->regs[NPCM7XX_CLK_CLKSEL] |=3D 0x103,
> >> +#endif
> >> +}
> >
> > I think this is actually a problem regardless of optimization level.
> > Turning optimization off amplifies the problem, but the problem is
> > still there with optimization on.
>
> OK, this reminds me few more details about the problem I had with the
> raspi3 when adding the ClockPowerResetManager block.
> Found the branch. A bit bitter/sad it was more than 1 year ago.
>
> So if ARM_FEATURE_GENERIC_TIMER is available, Linux polls the CNTFRQ_EL0
> register. At that time this register were using a fixed frequency:
>
> #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable *=
/
>
> Xilinx' fork does it this way:
> https://github.com/Xilinx/qemu/commit/9e939b54e2d
>
> Now I see Andrew Jeffery fixed that in 96eec6b2b38
> ("target/arm: Prepare generic timer for per-platform CNTFRQ")
> adding a 'cntfrq' property, which he then sets in the Aspeed
> machine in commit 058d095532d ("ast2600: Configure CNTFRQ at 1125MHz").
>
> Maybe your SoC is simply missing this property?

Hmm, it doesn't look like Cortex-A9 has this property...

Unexpected error in object_property_find() at
/usr/local/google/home/hskinnemoen/qemu/upstream/qom/object.c:1254:
qemu-system-arm: Property '.cntfrq' not found

However, I did notice there are a lot of constraints on input
frequencies to the CPU and various peripherals, and many of these are
not met by the power-on reset values.

For example, the UART needs a 24 MHz input clock, but there's no way
to generate this from the default 25 MHz reference clock. However,
PLL2 is set up to run at 960 MHz by default (as soon as it's locked),
with a fixed /2 divider. The UART uses a /20 divider by default, so it
gets a 25 MHz / 20 =3D 1.25 MHz clock with power-on defaults. However,
switching the source to PLL2 results in 960 MHz / 2 / 20 =3D 24 MHz.

Similarly, the CPU is supposed to run at 800 MHz, but it runs at 25
MHz with power-on defaults. PLL1 runs at 800 MHz by default, with a
fixed /2 divider. The boot loader doubles the feedback divider so it
turns into 1600 MHz / 2 =3D 800 MHz.

Turns out I was wrong above, the patch snippet routes PLL1, not PLL2,
to the CPU. But it will only result in half the recommended speed, so
a patch to PLLCON1 is needed as well.

It seems like the cleanest solution would be to add a
write_board_setup hook to fix up these registers so clocks are within
normal ranges when bypassing the boot loader. In particular:

  - Switch UART to PLL2 for a 24 MHz input clock.
  - Set up PLL1 to run at 1600 MHz.
  - Switch the CPU core to PLL1 / 2 for a 800 MHz input clock.

Does that make sense? It should be just three simple register writes,
which is doable with hand-edited machine code.

I'll add this as a separate patch (right before the acceptance test)
so it's clear what's happening.

Unfortunately, I haven't been able to make the flash boot test pass
without optimization. U-boot seems to have a tiny buffer for the
command line, so I can only disable two or three systemd services
before it gets truncated. I might try to create a reduced openbmc
image instead.

Havard

