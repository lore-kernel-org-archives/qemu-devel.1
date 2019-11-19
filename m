Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D58C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 19:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A1672071F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 19:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iscwv2nD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A1672071F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX9G0-00013T-Nv
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 14:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iX9E5-0000YN-UN
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 14:31:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iX9E3-0003W6-72
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 14:31:49 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43671)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iX9E1-0003Tn-I5
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 14:31:46 -0500
Received: by mail-oi1-x243.google.com with SMTP id l20so20062534oie.10
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 11:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cbKcKRKbwQtv9Ci+cPhasDK8gmHv4/LOTNE1WwRIn6s=;
 b=iscwv2nD88BuQhp6dazs+iQVVKNb4H0Nu8nwcdoFeJQy0m/6KU4OlgoPGguqQr+4O9
 uMkvzHCB03cPku5pqyAVJErHwqbJgKPHCXLdZnmqLhCtI0Al5lOUpDRsVndxR8b+14mY
 xmF578DnjtzPWZhvby9vnFcv62aqJncsu+Jff9ika3Hynp7UC2KWPEzPpDLkcCXKfzFD
 voGTZ0rTi0wrhXB4GX5ruye1e6FwhEZCgNtJCEPCUhQsn2AgkEGpBgPfcRoRr4MEZUTD
 VjHAMgb9/W5ptSurQiEDG89r0M0A1p+yl9U1YRTyGtM6vYpOzQVGqzvXetXWbugA8toj
 5D4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cbKcKRKbwQtv9Ci+cPhasDK8gmHv4/LOTNE1WwRIn6s=;
 b=oGr4MBXMRN89ynEqjJQKbPXXf0/1LWcu11ZN9iH8BpoG8gm+5mfR7+UZbHiKFgsJ84
 JOP5LvgytoX04AwO3HjGqJvTAvIGI3xjVUrsS6uss2ZUdcIP/F3e1wUMzZjXJTv2x5Z9
 63lBg5/2pwIDsMEb7+ZlXX5TSRrYsp/h1lfyyjmz5RnuMBIBbWyqExJyJeo64AyWSpl6
 Et4nvEKpboqW9AoHrmIGjgGvUR0TtmqFzkfJIA38zCk8YLlGDp1+z6uKfGiPzqlbRD/u
 WFMAkHDss50UA8uzH/+MoT9qQBahRjAK2Za7lxHAk2fDwgas85x0OG3EZS86XH8L+i3Q
 780w==
X-Gm-Message-State: APjAAAV4ygU4oqjg/1w+gGJ3UIx6XAtekOCMPXIDC/eyGyfYKK4epIC2
 bnl+7ff5VozuarwGWLULzMOnDyAspWsYOiCI/lJdMw==
X-Google-Smtp-Source: APXvYqwWqKeBc2J5hPW4Io53QZtui5veR0zDiv//8G6/wQvu0fC+WVXztjalI7WNfOq9HRxv/zH925TGug2pi62WL6Y=
X-Received: by 2002:aca:4945:: with SMTP id w66mr5790666oia.98.1574191899230; 
 Tue, 19 Nov 2019 11:31:39 -0800 (PST)
MIME-Version: 1.0
References: <1574190388-12605-1-git-send-email-tsimpson@quicinc.com>
In-Reply-To: <1574190388-12605-1-git-send-email-tsimpson@quicinc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Nov 2019 19:31:28 +0000
Message-ID: <CAFEAcA8AeTgY+3GaN9ZUi-5XtX5jxhqpdOhr3ixYwouWhQOQ5g@mail.gmail.com>
Subject: Re: [PATCH] Hexagon: Swap SIGRGMAX-1 and SIGRTMIN+1
To: Taylor Simpson <tsimpson@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 Nov 2019 at 19:07, Taylor Simpson <tsimpson@quicinc.com> wrote:
>
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>  linux-user/signal.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index 5ca6d62..ce3d27f 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -72,6 +72,14 @@ static uint8_t host_to_target_signal_table[_NSIG] = {
>         over a single host signal.  */
>      [__SIGRTMIN] = __SIGRTMAX,
>      [__SIGRTMAX] = __SIGRTMIN,
> +#ifdef TARGET_HEXAGON
> +    /*
> +     * Hexagon uses the same signal for pthread cancel as the host pthreads,
> +     * so cannot be overridden.
> +     * Therefore, we map Hexagon signal to a different host signal.
> +     */
> +    [__SIGRTMAX - 1] = __SIGRTMIN + 1,
> +#endif
>  };

This breaks other stuff, unfortunately, like Go binaries.
(Also, you now have two host signals mapped to the same
target signal; notice that the existing RTMAX/RTMIN
is a swap of the two slots.)

We need a generic solution for this, Hexagon is not the
only one with the problem. There's a patchset on list
from ages back that had a suggested approach, but
it needed review and work.

thanks
-- PMM

