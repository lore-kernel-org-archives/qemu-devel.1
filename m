Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3654C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:28:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7225D20575
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uIuI70Y0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7225D20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDpms-0001YC-6x
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 09:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jDocJ-0000iB-9V
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jDocC-0004uP-KB
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:13:11 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:43258)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jDocC-0004bv-AW; Mon, 16 Mar 2020 08:13:04 -0400
Received: by mail-lj1-x242.google.com with SMTP id r7so18336568ljp.10;
 Mon, 16 Mar 2020 05:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=UwsGaBMEoczo/OQrl4sRsyO0TTUJDm0MSMApTklmPvo=;
 b=uIuI70Y09i/5j2pKLPY3CzyQaEFirLis9TcSrnK4xfVVn7bvrrafABtjqEk7m+O13h
 mxnGYrrOd2Vtt9VBXf/Oo/3XWNDXrmcvwueAJnIdHsnXaWiAR3FEsOq973qiXpB1Db0R
 7n+qvEFPByPmiYka0sYx6fkBm/H5ZnaP0ovo/15KSswzkLZkT3am/WMe963dejsbj3tv
 AwId+GOQWVaZCI4jnYpHOy0317DI74iExxw/fG37qRhSz7I1BxHM18BEIewXe0ek75K0
 42nuPyZ6xApsAUu+KAYFKp8qwmuqEc0wgiD0TrI1DgwXFcgBb5RscEPQL84VhXAJWU0y
 eEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=UwsGaBMEoczo/OQrl4sRsyO0TTUJDm0MSMApTklmPvo=;
 b=KqTNAM8zYgJgygbvwE9Yw3OeTmK+hketTbMqL9v58aKz+7BcON1obXnnENW88AIf0k
 pRGQ7VnnD7yBBSfI3CTaEofSwma1RQv0kFBRNvJkhLRkb42no9/6B1KZxaKXV3dwFGMR
 sQ0M50Yl//wIfQNYbAJwchGZEEt+b+L/GbrbZosSGrCQN3yBLFZOEFe8QYRuvRW9B3/n
 c4e4DREcKXVeN6s0CLdhlvlODDgMy37hxCzyfjOXf9N61uUlPgQ5vKSHYlLNSmaAkZDc
 Kt/y6NzFwq9yotwNtWNGQpOdwXWzFXz1rLItLX8BILCnEPnZPcoGLE47rSsoK+b26ZFR
 1cAA==
X-Gm-Message-State: ANhLgQ1G6VUDnxVkVAagdMr4bIow1a7cXPlHr0D+mGxgYn0f2s+CSq8N
 4py3sqYdnDCUc7sPV3tlvgE=
X-Google-Smtp-Source: ADFU+vv/uKJVb/T/7ATVfepgHM1KIGKTXapwetS/bXBA5Nm7Umq1JcJ/ZFTZ9d/k+mcSiwLYrVxIOg==
X-Received: by 2002:a2e:96cc:: with SMTP id d12mr9952257ljj.87.1584360781481; 
 Mon, 16 Mar 2020 05:13:01 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id a11sm16306708ljb.45.2020.03.16.05.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 05:13:00 -0700 (PDT)
Date: Mon, 16 Mar 2020 13:14:09 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Subject: Re: [PATCH v8 0/9] Clock framework API
Message-ID: <20200316121409.GA2669@toto>
References: <20200225131422.53368-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225131422.53368-1-damien.hedde@greensocs.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 alistair@alistair23.me, mark.burton@greensocs.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 25, 2020 at 02:14:13PM +0100, Damien Hedde wrote:
> This series aims to add a way to model clock distribution in qemu.
> The proposed objet and qdev API allows to model the clock tree of
> a platform allowing us to inspect clock configuration and detect
> problems such as disabled clock or bad configured pll.

On the series:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> 
> This fast v8 fixes the documentation rst patchew errors and includes
> Alistair's review on v7.
> 
> There's 2 notable changes since v6:
> + The value stored in clock is now a period on 64 bits integer. The
>   unit is 2^-32ns to achieve the same precision as the ptimer internal
>   representation.
> + No more ClockIn/ClockOut base types, just a single Clock type. It
>   makes things simplier for everything else (standalone clocks,
>   possibility to read device's output clocks) and allow to chain
>   several clock inputs.
> 
> Regarding the internal represention. The precision is huge so that
> it is possible (in the future) to somehow connect a ptimer with a
> Clock with no loss of precision.
> The consequence is that we have a ~4seconds period upper bound only.
> Alternatives, allowing us to keep this precision, are to use a
> floating point or to extend the integer.
> 
> The added clock api is very similar the the GPIO API for devices. We
> can add input and output and connect them together.
> 
> Now that ressettable API is merged, the clock tree is properly
> initialized during the machine reset.
> I've tested this patchset running Xilinx's Linux on the xilinx-zynq-a9
> machine. Clocks are correctly updated and we ends up with a configured
> baudrate of 115601 on the console uart (for a theoretical 115200)
> which is nice. "cadence_uart*" and "clock*" traces can be enabled to
> see what's going on in this platform.
> 
> Any comments and suggestions are welcomed.
> 
> Patches 1, 3 and 5 to 8 still need some reviews.
> 
> The patches are organised as follows:
> + Patches 1 to 4 adds the clock support in qemu
> + Patch 5 adds some documentation in docs/devel
> + Patches 6 to 8 adds the uart's clocks to the xilinx_zynq platform
>   as an example for this framework. It updates the zynq's slcr clock
>   controller, the cadence_uart device, and the zynq toplevel platform.
> + Patch 9 adds clock info to monitor "info qtree" command
> 
> Changes since v7:
> https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg06451.html
>  - rst errors in doc
>  - Alistair's comments on patch 1 and 3
> 
> Changes since v6:
> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg00599.html
>  - switch from frequency to period based clock state
>  - single Clock type (no more ClockIn and ClockOut)
>  - doc converted in rst format (Peter)
>  - various fixes (Peter and Philippe)
>  - better migration support for zynq devices (Peter)
> 
> Thanks to the Xilinx QEMU team who sponsored this development.
> 
> Damien Hedde (9):
>   hw/core/clock: introduce clock object
>   hw/core/clock-vmstate: define a vmstate entry for clock state
>   qdev: add clock input&output support to devices.
>   qdev-clock: introduce an init array to ease the device construction
>   docs/clocks: add device's clock documentation
>   hw/misc/zynq_slcr: add clock generation for uarts
>   hw/char/cadence_uart: add clock support
>   hw/arm/xilinx_zynq: connect uart clocks to slcr
>   qdev-monitor: print the device's clock with info qtree
> 
>  docs/devel/clocks.rst          | 360 +++++++++++++++++++++++++++++++++
>  docs/devel/index.rst           |   1 +
>  include/hw/char/cadence_uart.h |   1 +
>  include/hw/clock.h             | 225 +++++++++++++++++++++
>  include/hw/qdev-clock.h        | 159 +++++++++++++++
>  include/hw/qdev-core.h         |  12 ++
>  hw/arm/xilinx_zynq.c           |  57 +++++-
>  hw/char/cadence_uart.c         |  73 ++++++-
>  hw/core/clock-vmstate.c        |  25 +++
>  hw/core/clock.c                | 130 ++++++++++++
>  hw/core/qdev-clock.c           | 185 +++++++++++++++++
>  hw/core/qdev.c                 |  12 ++
>  hw/misc/zynq_slcr.c            | 172 +++++++++++++++-
>  qdev-monitor.c                 |   9 +
>  hw/char/trace-events           |   3 +
>  hw/core/Makefile.objs          |   2 +
>  hw/core/trace-events           |   7 +
>  tests/Makefile.include         |   1 +
>  18 files changed, 1412 insertions(+), 22 deletions(-)
>  create mode 100644 docs/devel/clocks.rst
>  create mode 100644 include/hw/clock.h
>  create mode 100644 include/hw/qdev-clock.h
>  create mode 100644 hw/core/clock-vmstate.c
>  create mode 100644 hw/core/clock.c
>  create mode 100644 hw/core/qdev-clock.c
> 
> -- 
> 2.25.1
> 

