Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06928C2D0EC
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:28:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C943120733
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X7UDRFm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C943120733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIuT7-0008WV-Vw
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 09:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jIuPP-0005R6-Ka
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jIuPO-0005Gq-6n
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:24:55 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39379)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jIuPN-0005GB-V9
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:24:54 -0400
Received: by mail-ot1-x342.google.com with SMTP id x11so17973307otp.6
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 06:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X+qqckzSyBfB8qpfsDQW+k74OkzwkU/rTpX8h4O0/oA=;
 b=X7UDRFm7DbucO3BIKsiTNIZpq/U0jMtzgkLKz/N4GlEZMVGbkBJPQJptOtvfpUXWyA
 Cp5PiSRlMs88msYfejItJF+jH2/XaVi6D8D73161uQZGQeW+meg3aNBXtFt8+oBiO2t8
 dvX0LrGkKpQN1tOt/G1SXifgPRkM1qwkKn039vwxGTu81aWHJIPGh9b2VEyTAFcLPwgJ
 J6CS58Cvcp4Q7UiwjplrWtRu7jK/D/cwdggaLTMe5wkHC2KpBk0AcXOrkpsX4r3DxkAA
 0kQtCX+voq1PxPChOOc3H0uknMoghI96pdRlBKCJMp4Gcs+EwB+2LL11DskeyFuV5GxK
 yqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X+qqckzSyBfB8qpfsDQW+k74OkzwkU/rTpX8h4O0/oA=;
 b=oKKTVRkyt7XlsGbcRx8UBSVStBkgT2PFAm4hN9gi5mMRD08ZcrDrjyxbQQJAHclQ/P
 FW0RBt3ce7X14Wp8BpA7A2GbixJGvknFdtjUC0P24sKUz3SWvtxnOaieqg5N2hPQ5XEP
 wWTfdLTQyNyxI+8mkRZSXkooumrEtRkgFu1jb3kbm6xUeiuzhkMZGAzT4/mU6dzVGswW
 1A+/E/ZtEEiXbqKET146z8zQLnRVGGOfgVEC+np+P5oFeYk29DWLj6zEqYwFT0LaUnvi
 WxPx/9d+43YxhQ79p9TKPrxzR4Xgv8g0JQ7dMCmBbJ9g7MZtUQzY0d3SUWIBCxFoPz7C
 JeNA==
X-Gm-Message-State: ANhLgQ2PHDQFSRgd2KatXlqBIIMZt+19PVBMZstE7ZDMw6oVPtO8jn0g
 HEsYRTeBLYxtlV3fEJJHyt/iSr52youLF30+3hkGBA==
X-Google-Smtp-Source: ADFU+vu8TGWgK5Zzn43Lr1eAc49rthxRJtNSAZXx7GZnhukFTmj7AYl7cEzYgCFDvsOMdQCVipWvIA2WLFSab8DP86k=
X-Received: by 2002:a05:6830:18f4:: with SMTP id
 d20mr9257506otf.91.1585574692918; 
 Mon, 30 Mar 2020 06:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200330125228.24994-1-peter.maydell@linaro.org>
 <alpine.BSF.2.22.395.2003301454060.10279@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.22.395.2003301454060.10279@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Mar 2020 14:24:41 +0100
Message-ID: <CAFEAcA9rPrcub183BOBYb0LEprgyh3G8M7ToFU7jwbhh2s9R=A@mail.gmail.com>
Subject: Re: [PATCH for-5.0] hw/ppc/ppc440_uc.c: Remove incorrect iothread
 locking from dcr_write_pcie()
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Mar 2020 at 14:17, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Mon, 30 Mar 2020, Peter Maydell wrote:
> > In dcr_write_pcie() we take the iothread lock around a call to
> > pcie_host_mmcfg_udpate().  This is an incorrect attempt to deal with
> > the bug fixed in commit 235352ee6e73d7716, where we were not taking
> > the iothread lock before calling device dcr read/write functions.
> > (It's not sufficient locking, because although the other cases in the
> > switch statement won't assert, there is no locking which prevents
> > multiple guest CPUs from trying to access the PPC460EXPCIEState
> > struct at the same time and corrupting data.)
>
> Even though there's only a single CPU on sam460ex and PCIe is mostly
> unused, with this patch I could no more reproduce a problem that we had
> before with some programs crashing within guest under AmigaOS for unknown
> reason. That problem happened randomly (although I could reproduce it
> before) so I'm not sure if this fixed it or something else (more likely
> commit 235352ee6e) or will just resurface later but at least this seems to
> work so
>
> Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> Thanks for fixing it.

Thanks for the testing. I'm not sure why a single-cpu setup
would have problems but I guess some device has a bottom-half or
timer callback that will run in the iothread context, in which
case it could race with the vcpu thread doing a dcr access. As
you say, probably 235352ee6e rather than this change that's fixed it,
assuming we really have fixed it.

> > Unfortunately with commit 235352ee6e73d7716 we are now trying
> > to recursively take the iothread lock, which will assert:
> >
> >  $ qemu-system-ppc -M sam460ex --display none
> >  **
> >  ERROR:/home/petmay01/linaro/qemu-from-laptop/qemu/cpus.c:1830:qemu_mutex_lock_iothread_impl: assertion failed: (!qemu_mutex_iothread_locked())
> >  Aborted (core dumped)
> >
> > Remove the locking within dcr_write_pcie().
> >
> > Fixes: 235352ee6e73d7716
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > I did a grep of hw/ppc and didn't see anything else that was doing
> > its own locking inside a dcr read/write fn.
>
> I think we needed to add locking here because it asserted otherwise but I
> don't remember the details now.

Yeah, the memory-region adjustment done under the pcie_host_mmcfg_update()
function will assert that the iothread lock is held. The locking just
needs to be one level further up in the callstack.

thanks
-- PMM

