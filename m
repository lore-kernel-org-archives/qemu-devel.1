Return-Path: <SRS0=YAkC=B2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4C4C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 12:09:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A2420716
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 12:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nathanrossi.com header.i=@nathanrossi.com header.b="gk470iRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A2420716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nathanrossi.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7HTA-00061r-8g
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 08:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathan@nathanrossi.com>)
 id 1k7HSU-0005bb-K1
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 08:08:19 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34092)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nathan@nathanrossi.com>)
 id 1k7HSR-0006mv-DC
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 08:08:18 -0400
Received: by mail-wm1-x342.google.com with SMTP id c19so11441637wmd.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2020 05:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nathanrossi.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3pzozrvq/Zjaa2RRbzG24LT+gFXCoeMryH4chEhO4WA=;
 b=gk470iRQQUC371JcuMZiq2Gjz2b9J1XrPcneOqfkq4oKx/FGoRx5wcEs+ykOhJYGmN
 vS7xYtJNJGz3UhpWEBsrEJIRDibTQH0mT2RmT++CR5mnlvtk6pYbAGMrzSmfW/zGMYbF
 Dz1IWJ4UyH4fYwCaYcKEefFhOQlB7wuyuL0NujzHHhofSJDiCjqV8HEYkShMd4BDQ3bO
 C57adv7FsnxT4uAGyUxXcuGk4BS9k3YineUqTU2VIAE5Usl4RiSbeX0oEMyxe+Nuvbb/
 36r8Xpl4+fIUVG3Fgb6Ju0Mdm1A1oikWif5QR4tGNUQFsBaPJrZmah+XY//Hc7Z/5JT0
 2cZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3pzozrvq/Zjaa2RRbzG24LT+gFXCoeMryH4chEhO4WA=;
 b=ocsnGLoPAJWWNz5NP+kaQXBdgzRFPB6YTWM5qkHBO3sHUwNOKSeUmvLn+QAKXhAHqH
 cxWCeThMLFMjCelxuy5qnbHyxWebO+lGnxjSOpeS0p/v5xvZQd4RU/I8LvZYXANfZKV4
 22+u1jT9lF/UKf7a4Ux/Zr789iEAEXS1xsR0Zbpi5X7hItP873K70fUK1X6GqlbtGGab
 PeNrXtc7JBwa3/cfgKLnf6t2mnB0MbQhNHRRmt244Z5IEtwZM6qw0ZTF09myOTL2vPJ6
 UFEAitWI6i9hZ9Uu9+QtVviHKFqsdqj7VdYzsNDvh/StBFiWpTWPRwrzRAIbpe14aQ58
 R2Jw==
X-Gm-Message-State: AOAM531A7QTOAHdflk9p0is9ok0o1NhAOLPXzGxo/Z9+8OZMTU+429/C
 tiyHjUrlluEj5WMUg77tO48C0+zjMJahOypRN455mg==
X-Google-Smtp-Source: ABdhPJwJ2KNk32XeckjVEYgQt8+2wQe/dpPQ5O4MupeUFht51nJMZzjqv5hMPobXrDAdkLb9jRzPf7i2AjI9yeNASDM=
X-Received: by 2002:a7b:c954:: with SMTP id i20mr11346091wml.189.1597579692752; 
 Sun, 16 Aug 2020 05:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <1597423256-14847-15-git-send-email-bmeng.cn@gmail.com>
 <e97e1bc4-277d-9fdd-1372-f69d22b4a7e4@amsat.org>
 <CAEUhbmX6O7gGc2+sZFXSve=rBJLZQ5ts2sfWM=OU6k+4j-uryg@mail.gmail.com>
In-Reply-To: <CAEUhbmX6O7gGc2+sZFXSve=rBJLZQ5ts2sfWM=OU6k+4j-uryg@mail.gmail.com>
From: Nathan Rossi <nathan@nathanrossi.com>
Date: Sun, 16 Aug 2020 22:08:01 +1000
Message-ID: <CA+aJhH1YooxPkaT2xc4o6CjDYLm++6psSc3ZZW-EiAPFCz=PjA@mail.gmail.com>
Subject: Re: [PATCH 14/18] hw/net: cadence_gem: Add a new 'phy-addr' property
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=nathan@nathanrossi.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
 Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Bin Meng <bin.meng@windriver.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Jason Wang <jasowang@redhat.com>, Palmer Dabbelt <palmerdabbelt@google.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Peter A. G. Crosthwaite" <peter.crosthwaite@petalogix.com>,
 qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 John Linn <john.linn@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 16 Aug 2020 at 18:29, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Sat, Aug 15, 2020 at 5:06 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org> wrote:
> >
> > On 8/14/20 6:40 PM, Bin Meng wrote:
> > > From: Bin Meng <bin.meng@windriver.com>
> > >
> > > At present the PHY address of the PHY connected to GEM is hard-coded
> > > to either 23 (BOARD_PHY_ADDRESS) or 0. This might not be the case for
> > > all boards. Add a new 'phy-addr' property so that board can specify
> > > the PHY address for each GEM instance.
> > >
> > > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> > > ---
> > >
> > >  hw/net/cadence_gem.c         | 7 +++++--
> > >  include/hw/net/cadence_gem.h | 2 ++
> > >  2 files changed, 7 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> > > index a93b5c0..9fa03de 100644
> > > --- a/hw/net/cadence_gem.c
> > > +++ b/hw/net/cadence_gem.c
> > > @@ -1446,7 +1446,8 @@ static uint64_t gem_read(void *opaque, hwaddr o=
ffset, unsigned size)
> > >              uint32_t phy_addr, reg_num;
> > >
> > >              phy_addr =3D (retval & GEM_PHYMNTNC_ADDR) >> GEM_PHYMNTN=
C_ADDR_SHFT;
> > > -            if (phy_addr =3D=3D BOARD_PHY_ADDRESS || phy_addr =3D=3D=
 0) {
> > > +            if (phy_addr =3D=3D BOARD_PHY_ADDRESS || phy_addr =3D=3D=
 0 ||
> > > +                phy_addr =3D=3D s->phy_addr) {
> > >                  reg_num =3D (retval & GEM_PHYMNTNC_REG) >> GEM_PHYMN=
TNC_REG_SHIFT;
> > >                  retval &=3D 0xFFFF0000;
> > >                  retval |=3D gem_phy_read(s, reg_num);
> > > @@ -1569,7 +1570,8 @@ static void gem_write(void *opaque, hwaddr offs=
et, uint64_t val,
> > >              uint32_t phy_addr, reg_num;
> > >
> > >              phy_addr =3D (val & GEM_PHYMNTNC_ADDR) >> GEM_PHYMNTNC_A=
DDR_SHFT;
> > > -            if (phy_addr =3D=3D BOARD_PHY_ADDRESS || phy_addr =3D=3D=
 0) {
> > > +            if (phy_addr =3D=3D BOARD_PHY_ADDRESS || phy_addr =3D=3D=
 0 ||
> > > +                phy_addr =3D=3D s->phy_addr) {
> > >                  reg_num =3D (val & GEM_PHYMNTNC_REG) >> GEM_PHYMNTNC=
_REG_SHIFT;
> > >                  gem_phy_write(s, reg_num, val);
> > >              }
> > > @@ -1682,6 +1684,7 @@ static Property gem_properties[] =3D {
> > >      DEFINE_NIC_PROPERTIES(CadenceGEMState, conf),
> > >      DEFINE_PROP_UINT32("revision", CadenceGEMState, revision,
> > >                         GEM_MODID_VALUE),
> > > +    DEFINE_PROP_UINT8("phy-addr", CadenceGEMState, phy_addr, 0),
> >
> > This patch would be complete by moving the BOARD_PHY_ADDRESS definition
> > to each board using this NIC, and setting the "phy-addr" property to
> > this value.
>
> I actually have no idea which board in QEMU is using this special PHY
> address instead of default 0.

Given Xilinx's QEMU fork has not used this value for quite some time,
I suspect it was only used to match an early chip emulation
platform/board.

https://github.com/Xilinx/qemu/blame/master/hw/net/cadence_gem.c#L248

>
> It looks BOARD_PHY_ADDRESS has been there since the initial version of
> the cadence_gem model.
>
> commit e9f186e514a70557d695cadd2c2287ef97737023
> Author: Peter A. G. Crosthwaite <peter.crosthwaite@petalogix.com>
> Date:   Mon Mar 5 14:39:12 2012 +1000
>
>     cadence_gem: initial version of device model
>
>     Device model for cadence gem ethernet controller.
>
>     Signed-off-by: Peter A. G. Crosthwaite <peter.crosthwaite@petalogix.c=
om>
>     Signed-off-by: John Linn <john.linn@xilinx.com>
>     Acked-by: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>     Signed-off-by: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>
> Later PHY address 0 was added via the following commit:
>
> commit 553893736885e4f2dda424bff3e2200e1b6482a5
> Author: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
> Date:   Thu Apr 3 23:55:19 2014 -0700
>
>     net: cadence_gem: Make phy respond to broadcast
>
>     Phys must respond to address 0 by specification. Implement.
>
>     Signed-off-by: Nathan Rossi <nathan.rossi@xilinx.com>
>     Signed-off-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
>     Message-id:
> 6f4d53b04ddbfb19895bfb61a595e69f1c08859a.1396594056.git.peter.crosthwaite=
@xilinx.com
>     Reviewed-by: Beniamino Galvani <b.galvani@gmail.com>
>     Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> I doubt the commit message said that PHYs must respond to address 0. I
> am not aware of such specs. The issue was probably that whatever board
> 2nd commit was tested against did not have a PHY at address
> BOARD_PHY_ADDRESS.

It is common for phy devices to support it as a broadcast address. It
is also commonly written in Xilinx documentation that it is treated as
a broadcast address. e.g. the axi ethernet core
(https://www.xilinx.com/support/documentation/ip_documentation/axi_ethernet=
/v7_0/pg138-axi-ethernet.pdf
page 45). But 802.3 does not require it, instead address 0 is only
reserved.

With this commit the "must" refers to the device specification, in
that QEMU is emulating a real phy (though more specifically the phy(s)
that were being emulated for Zynq boards) that does respond to address
0 as a broadcast. This change was a trade off in order to make QEMU
behave as it would on hardware, such that software using address 0 as
broadcast would work correctly.

Regards,
Nathan


>
> + a couple of Xilinx folks to comment.
>
> >
> > >      DEFINE_PROP_UINT8("num-priority-queues", CadenceGEMState,
> > >                        num_priority_queues, 1),
> > >      DEFINE_PROP_UINT8("num-type1-screeners", CadenceGEMState,
> > > diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_ge=
m.h
> > > index 54e646f..01c6189 100644
> > > --- a/include/hw/net/cadence_gem.h
> > > +++ b/include/hw/net/cadence_gem.h
> > > @@ -73,6 +73,8 @@ typedef struct CadenceGEMState {
> > >      /* Mask of register bits which are write 1 to clear */
> > >      uint32_t regs_w1c[CADENCE_GEM_MAXREG];
> > >
> > > +    /* PHY address */
> > > +    uint8_t phy_addr;
> > >      /* PHY registers backing store */
> > >      uint16_t phy_regs[32];
>
> Regards,
> Bin

