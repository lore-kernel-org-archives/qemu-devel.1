Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969DBC11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 673FA208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dtyAx+tb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673FA208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4nQY-0000P8-KQ
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 10:07:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j4nPB-00081I-Ip
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:06:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j4nP7-0003aH-2o
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:06:21 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36383)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j4nP6-0003Zs-Tk
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:06:17 -0500
Received: by mail-ot1-x344.google.com with SMTP id j20so3945034otq.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 07:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=efiuR+2dcp57AwoB7w8S2M9pnxIzJNL+qV197dIIuLA=;
 b=dtyAx+tb+q6+o2Hn54rruQKwaYTISB0GTjxzu3/EsE3+UQnftsbcPKCozCpG+qyBOk
 +XC0OIWu5PpfH39Hhb4uIfj4nbgIzWwVH3F4FcCnkOU7tMZzaUFNsOzn6x/wP+p70yDV
 HVi9ti7rWlJiObuvD3tBhjQE0uOxeNHkyxZuALht4BZdTu3mtcrd+XvbHUkVdE00VoqF
 Yb6KQdKFDw4riY4D7mVSVpFAmLDMNRLyIMtNz3pDq8BDcKkv1e5hLxBCFKfulS8JxyLZ
 pRjzqkpjDn508TWO19cEdXSbrOcnIaC/Dnl2NOHNXLu9aZVY0ZbxWNQxziy/9Kid5s68
 EndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=efiuR+2dcp57AwoB7w8S2M9pnxIzJNL+qV197dIIuLA=;
 b=FVNbtaXAPrpPQtuFyvfR91vPKMgIL7eQWl/o1ZAbqRS/vyb6xagXVpn98V/W4laNm+
 39VIVDcNaZxYpnTMcrHVVa2eNBR+2mwQrF7Z4pPTP7vvsucHD+Qi16UrT2daVEgd+67N
 dKoNcy6+Dbrds70n4VSfY0pUN0QnO0IEyPcgXcPdRzZe7pC6YDwUSVIJiNcW4e9wBDE5
 Q1LpLtS4twaiA3h74YqAumfEwWqP/zkVXhyKQDalISMvYs059IHgGDVmuCLtAQ3itwHB
 l2CQwMzzt/hGT/9WVvN6Eaj99B9XCyUBMTYrU6ymS/tKKcSa4oFV3jzZtktZrGWQVizn
 EAAw==
X-Gm-Message-State: APjAAAX9TFArAaEMRtBhVn+U0tj8wUm8VuxxDeNeYDJhN7rWFDM+Xs7U
 zb1reIviHQHsrsUJdpz9lpIugjqZgLE0+qNQdL2M9TPu
X-Google-Smtp-Source: APXvYqwtBTjcxvs4Y/f/aIRHznovh0ekeTEJNrHJIksy2TEIW98HqMwBzUO0cTlqJTdsgk711OFlJ+2hUEK4zkQG94k=
X-Received: by 2002:a9d:68d9:: with SMTP id i25mr11833763oto.135.1582211175986; 
 Thu, 20 Feb 2020 07:06:15 -0800 (PST)
MIME-Version: 1.0
References: <20200218201050.15273-1-linux@roeck-us.net>
In-Reply-To: <20200218201050.15273-1-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2020 15:06:05 +0000
Message-ID: <CAFEAcA8ocGcGHwzdY2ao73WQcfoUbYTy2udUP5w+ZV5NOMeGLA@mail.gmail.com>
Subject: Re: [PATCH v2] sh4: Fix PCI ISA IO memory subregion
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Feb 2020 at 20:10, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Booting the r2d machine from flash fails because flash is not discovered.
> Looking at the flattened memory tree, we see the following.
>
> FlatView #1
>  AS "memory", root: system
>  AS "cpu-memory-0", root: system
>  AS "sh_pci_host", root: bus master container
>  Root memory region: system
>   0000000000000000-000000000000ffff (prio 0, i/o): io
>   0000000000010000-0000000000ffffff (prio 0, i/o): r2d.flash @0000000000010000
>
> The overlapping memory region is sh_pci.isa, ie the ISA I/O region bridge.
> This region is initially assigned to address 0xfe240000, but overwritten
> with a write into the PCIIOBR register. This write is expected to adjust
> the PCI memory window, but not to change the region's base adddress.
>
> Peter Maydell provided the following detailed explanation.
>
> "Section 22.3.7 and in particular figure 22.3 (of "SSH7751R user's manual:
> hardware") are clear about how this is supposed to work: there is a window
> at 0xfe240000 in the system register space for PCI I/O space. When the CPU
> makes an access into that area, the PCI controller calculates the PCI
> address to use by combining bits 0..17 of the system address with the
> bits 31..18 value that the guest has put into the PCIIOBR. That is, writing
> to the PCIIOBR changes which section of the IO address space is visible in
> the 0xfe240000 window. Instead what QEMU's implementation does is move the
> window to whatever value the guest writes to the PCIIOBR register -- so if
> the guest writes 0 we put the window at 0 in system address space."
>
> Fix the problem by calling memory_region_set_alias_offset() instead of
> removing and re-adding the PCI ISA subregion on writes into PCIIOBR.
> At the same time, in sh_pci_device_realize(), don't set iobr since
> it is overwritten later anyway. Instead, pass the base address to
> memory_region_add_subregion() directly.
>
> Many thanks to Peter Maydell for the detailed problem analysis, and for
> providing suggestions on how to fix the problem.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I'll put this in via target-arm.next, since we don't really
have a more active sh4-specific tree to send it via.

thanks
-- PMM

