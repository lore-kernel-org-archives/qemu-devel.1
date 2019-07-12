Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D50C742C7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 15:35:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94AA5208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 15:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TXwpdtv1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AA5208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlxZm-0004Ao-Ua
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 11:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34788)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hlxZb-0003fG-26
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hlxZZ-0002JF-Va
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:34:59 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33846)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hlxZZ-0002IZ-PY
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:34:57 -0400
Received: by mail-oi1-x242.google.com with SMTP id l12so7608123oil.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 08:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=N/AZlVvSfQx4gLDJnm2LXUHc6oBDvINOUeKs1at6adk=;
 b=TXwpdtv1nekNSUm6Lj8Cc/SYL6TDWfre2pEWSFSGlZ6KqXNZs37HMEf6NqFbaCyfmP
 suJR/dfGKP3u3QO8uvuyLNIzwhm3B2P3Ftv1mQYt57g/glQugPvkY+15crSse/8IgX1k
 37yoAaZqEM9du0GlVjcGxhWRcTZif4OxY+2vkQjz5FnCvf5J28IwkDheavCS/AOQQZDF
 T+/F3bNz1rLRebR3GooFqbZm+9VpofClrCi3OKTBwasNkz2IYkMbAsTDXm/392ANkFJf
 6e6NhdD+b9EsHFJ+Oh/IMbQDLvGkGyn3r0PIfnGNp9vxJVMmKYlGiWiVT1mbS9FRM6hP
 +g6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=N/AZlVvSfQx4gLDJnm2LXUHc6oBDvINOUeKs1at6adk=;
 b=bh4EeAcWR18h1CNzx1HyzS40uIawjE8xR+mNfKUoU0PviQm/qO9RjOi84+9D0sTe0X
 oUNdeLy+9ohX+f3qOsmHVRYujoyy3Xex3sA1bbnEl1OsoGlDJM7UTZ1guCavNK2LLpX+
 /8HaaPIwd1vbezeM9dP5BZu+jUdq1qrVIf84w+AT+APjdcRDzsYAy3R/fVd9ZTy5n+7a
 HyBFeDj7dnpAn5jzmywxj+nTbtpLL8IMX4BqMmDXqRAupc6fdW8AiKaqXsYzDpuR4/nb
 wFRgtuBCIJDWH9BTdrEf2S4Plbu58aTIt9QktKMPCusQF4MobH8nvN/h8pkBXFqoXCvv
 Vq9A==
X-Gm-Message-State: APjAAAUhhvVmepvrAao700Am59o4rmifTiUn0rfeSWlwoirSjlp6tmoe
 8Yp0PB9n9y4t/r4kL04i9CMLPkbXB5rpr+211TJtAMQNTlg=
X-Google-Smtp-Source: APXvYqwzb6SeulnX4NzzCVLHqFxn/ATJfOGi/NO6VrVYA21FQaDUmHjxdFPzgjfjRhv+UJHeFhxKBnqR+DLhK66cQ+c=
X-Received: by 2002:aca:5cd7:: with SMTP id q206mr5753847oib.146.1562945696865; 
 Fri, 12 Jul 2019 08:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190712075002.14326-1-david.engraf@sysgo.com>
In-Reply-To: <20190712075002.14326-1-david.engraf@sysgo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jul 2019 16:34:46 +0100
Message-ID: <CAFEAcA9xon6RmoUA=r5XLeVsYrVTub8F_gJsYcWJavaRX7Fosg@mail.gmail.com>
To: David Engraf <david.engraf@sysgo.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH] hw/arm/virt: Fix non-secure flash mode
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 12 Jul 2019 at 08:53, David Engraf <david.engraf@sysgo.com> wrote:
>
> Using the whole 128 MiB flash in non-secure mode is not working because
> virt_flash_fdt() expects the same address for secure_sysmem and sysmem.
> This is not correctly handled by caller because it forwards NULL for
> secure_sysmem in non-secure flash mode.
>
> Fixed by using sysmem when secure_sysmem is NULL.
>
> Signed-off-by: David Engraf <david.engraf@sysgo.com>

Nice catch; applied to target-arm.next for 4.1.

thanks
-- PMM

