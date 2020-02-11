Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2506C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:48:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF95320708
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ASpMZD+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF95320708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Yhw-0004ct-Vt
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 11:48:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1YhM-0004E6-RC
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:47:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1YhL-0001Yp-Gc
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:47:44 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35407)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1YhL-0001YW-98
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:47:43 -0500
Received: by mail-ot1-x341.google.com with SMTP id r16so10803435otd.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 08:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FB4ranumZ7Z/S4U4c5Fc02BpJKzPZxVyew8P5G0QiUw=;
 b=ASpMZD+RoRZaEv7DdX6WykJs/a2G59SrsBr5m0peVfgJ2/+bmc62NbWxuSPayQRUcQ
 wfCOPOpkqrXGiF4mDrmtFc33GwD8yjv1U9SshpD++KeyDFlfOAGRuOJDJ52BN5QIaCV1
 l4weUFWU6z9X2Zkn4tDqEm4WfUcmnQ6ciVGO7AUT1xSevwBEg2Ewg9gEfuPjq+mfK6jZ
 Q/GLEwIKUPpu57C3GhMKmRqPUPo+S85OsSIWAyFrKpuIc2fZ8IRoniPGM68sHzi5T6wi
 BJ5bxzgmhcaLGjFjFZT1QpQlOUk3noua9GfBQPTioTelkPXba+HcbrjN7PXLIbpZlUWF
 ukVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FB4ranumZ7Z/S4U4c5Fc02BpJKzPZxVyew8P5G0QiUw=;
 b=gYqczqjBGAvF8oI3MgIvU6suZ0+18bjifxFxRT0JFS9qEM6Tc3XFRmkC73ixCxBo6w
 Pu0ppbix5HrIGY+TSMeKbppvAFv/nCq9wkFEZ/r7Splb8TLoL/ROlJQX/Lk247sEOgFp
 4ABDFTs8oChoq6j2AQwSQZaaZS2aXXVzXUCTk+bIFRayfL48//FEJLtuhxL0/p0IT61i
 waA1OrJ3PtdkQ9SnxS14JqIm28ZAtBHd39f00GiA23sFRTzDMdKlpGnRokDsOjLExzPD
 3oPnC+rJtwS3RV9rlF/5/9WT9V+YewrAH8qtMjy38ZHuBIDYqwCyYBdUttdlwA6QBQWj
 sagA==
X-Gm-Message-State: APjAAAVU5o3ynD0ZeO64XxO9p2XiMUHKqTNs0RAEgwJdpzPYhiCi9Mqu
 GYxomnpYGs2SLCV1MlDJqU+fLn8hWxzz25D7CAH8/Q==
X-Google-Smtp-Source: APXvYqx5QRQcO8JUmZARlPIsw030R5UboiOUU0Lliy29cwRMM8/75pkXJamvpLJpdOVIANzEk/InHtY8bUI4fQtf9J4=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr5617720otq.221.1581439661968; 
 Tue, 11 Feb 2020 08:47:41 -0800 (PST)
MIME-Version: 1.0
References: <20200204171053.1718013-1-laurent@vivier.eu>
 <20200204171053.1718013-4-laurent@vivier.eu>
In-Reply-To: <20200204171053.1718013-4-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Feb 2020 16:47:30 +0000
Message-ID: <CAFEAcA_BVPRXkhVoq7=r6QsQ+upkg1YbiXEHmoR9R824QcjZ0Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] linux-user: fix TARGET_NSIG and _NSIG uses
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Marlies Ruck <marlies.ruck@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Josh Kunz <jkz@google.com>, Taylor Simpson <tsimpson@quicinc.com>,
 Matus Kysel <mkysel@tachyum.com>,
 =?UTF-8?B?TWlsb8WhIFN0b2phbm92acSH?= <milos.stojanovic@rt-rk.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 4 Feb 2020 at 17:11, Laurent Vivier <laurent@vivier.eu> wrote:
>
> Valid signal numbers are between 1 (SIGHUP) and SIGRTMAX.
>
> System includes define _NSIG to SIGRTMAX + 1, but
> QEMU (like kernel) defines TARGET_NSIG to TARGET_SIGRTMAX.
>
> Fix all the checks involving the signal range.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>
> Notes:
>     v2: replace i, j by target_sig, host_sig
>
>  linux-user/signal.c | 52 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 37 insertions(+), 15 deletions(-)
>
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index 246315571c09..c1e664f97a7c 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -30,6 +30,15 @@ static struct target_sigaction sigact_table[TARGET_NSIG];

Optional follow-on patch: make sigact_table[] also size
TARGET_NSIG + 1, for consistency with target_to_host_signal_table[],
and remove all the "- 1"s when we index into it.


> @@ -492,10 +514,10 @@ static void signal_table_init(void)
>          if (host_to_target_signal_table[host_sig] == 0) {
>              host_to_target_signal_table[host_sig] = host_sig;
>          }
> -    }
> -    for (host_sig = 1; host_sig < _NSIG; host_sig++) {
>          target_sig = host_to_target_signal_table[host_sig];
> -        target_to_host_signal_table[target_sig] = host_sig;
> +        if (target_sig <= TARGET_NSIG) {
> +            target_to_host_signal_table[target_sig] = host_sig;
> +        }

Why does this hunk apparently delete the for() line ?

Why do we need the if() -- surely there should never be any
entries in host_to_target_signal_table[] that aren't
valid target signal numbers ?

>      }
>  }
>
> @@ -518,7 +540,7 @@ void signal_init(void)
>      act.sa_sigaction = host_signal_handler;
>      for(i = 1; i <= TARGET_NSIG; i++) {
>  #ifdef TARGET_GPROF
> -        if (i == SIGPROF) {
> +        if (i == TARGET_SIGPROF) {
>              continue;
>          }
>  #endif
> --

thanks
-- PMM

