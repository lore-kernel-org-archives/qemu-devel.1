Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65361C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:18:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 374C02073B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374C02073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIuJZ-0001rM-Bs
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 09:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jIuIi-00010O-2G
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jIuIg-0006HD-AY
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:17:59 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:15224)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jIuIg-0005qa-4Q; Mon, 30 Mar 2020 09:17:58 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 4EF77747EA5;
 Mon, 30 Mar 2020 15:17:45 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2B65E747E04; Mon, 30 Mar 2020 15:17:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 29825747E00;
 Mon, 30 Mar 2020 15:17:45 +0200 (CEST)
Date: Mon, 30 Mar 2020 15:17:45 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH for-5.0] hw/ppc/ppc440_uc.c: Remove incorrect iothread
 locking from dcr_write_pcie()
In-Reply-To: <20200330125228.24994-1-peter.maydell@linaro.org>
Message-ID: <alpine.BSF.2.22.395.2003301454060.10279@zero.eik.bme.hu>
References: <20200330125228.24994-1-peter.maydell@linaro.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Mar 2020, Peter Maydell wrote:
> In dcr_write_pcie() we take the iothread lock around a call to
> pcie_host_mmcfg_udpate().  This is an incorrect attempt to deal with
> the bug fixed in commit 235352ee6e73d7716, where we were not taking
> the iothread lock before calling device dcr read/write functions.
> (It's not sufficient locking, because although the other cases in the
> switch statement won't assert, there is no locking which prevents
> multiple guest CPUs from trying to access the PPC460EXPCIEState
> struct at the same time and corrupting data.)

Even though there's only a single CPU on sam460ex and PCIe is mostly 
unused, with this patch I could no more reproduce a problem that we had 
before with some programs crashing within guest under AmigaOS for unknown 
reason. That problem happened randomly (although I could reproduce it 
before) so I'm not sure if this fixed it or something else (more likely 
commit 235352ee6e) or will just resurface later but at least this seems to 
work so

Tested-by: BALATON Zoltan <balaton@eik.bme.hu>

Thanks for fixing it.

> Unfortunately with commit 235352ee6e73d7716 we are now trying
> to recursively take the iothread lock, which will assert:
>
>  $ qemu-system-ppc -M sam460ex --display none
>  **
>  ERROR:/home/petmay01/linaro/qemu-from-laptop/qemu/cpus.c:1830:qemu_mutex_lock_iothread_impl: assertion failed: (!qemu_mutex_iothread_locked())
>  Aborted (core dumped)
>
> Remove the locking within dcr_write_pcie().
>
> Fixes: 235352ee6e73d7716
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I did a grep of hw/ppc and didn't see anything else that was doing
> its own locking inside a dcr read/write fn.

I think we needed to add locking here because it asserted otherwise but I 
don't remember the details now.

Regards,
BALATON Zoltan

> ---
> hw/ppc/ppc440_uc.c | 3 ---
> 1 file changed, 3 deletions(-)
>
> diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
> index d5ea962249f..b30e093cbb0 100644
> --- a/hw/ppc/ppc440_uc.c
> +++ b/hw/ppc/ppc440_uc.c
> @@ -13,7 +13,6 @@
> #include "qemu/error-report.h"
> #include "qapi/error.h"
> #include "qemu/log.h"
> -#include "qemu/main-loop.h"
> #include "qemu/module.h"
> #include "cpu.h"
> #include "hw/irq.h"
> @@ -1183,9 +1182,7 @@ static void dcr_write_pcie(void *opaque, int dcrn, uint32_t val)
>     case PEGPL_CFGMSK:
>         s->cfg_mask = val;
>         size = ~(val & 0xfffffffe) + 1;
> -        qemu_mutex_lock_iothread();
>         pcie_host_mmcfg_update(PCIE_HOST_BRIDGE(s), val & 1, s->cfg_base, size);
> -        qemu_mutex_unlock_iothread();
>         break;
>     case PEGPL_MSGBAH:
>         s->msg_base = ((uint64_t)val << 32) | (s->msg_base & 0xffffffff);
>

