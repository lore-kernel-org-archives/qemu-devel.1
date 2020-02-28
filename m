Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B20C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B3372468E
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lxvWbdNp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3372468E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7iTA-000099-K9
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7iSM-0007Yl-DL
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:25:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7iSL-0007YO-ID
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:25:42 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46930)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7iSL-0007Xz-EO
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:25:41 -0500
Received: by mail-ot1-x342.google.com with SMTP id g96so3054563otb.13
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ImV9GXcTg3axtWS42bX0vZt1uE0u7nNuiWPJpxObbF0=;
 b=lxvWbdNpkz65y/npDOUy5Y+x6V5yMNwZgqmolcInw2MwA/yIljow/KpIek2Te1++oK
 lJzoGkppFLkMwZxIVudKbpGRzdxwe9uqDbtTuaiQxlux/R3MAMtVQtxUEx39poJrDxAQ
 pC/u3OHPORVEOxClzEheZtSRGREKjE/T09zeAj5ZopWbdhRzhfkVni0zwdIoDI9dQ0k5
 gRz2Ip0jNkPEfrnQ29AIa5pVMF9mUS//hECUri5MtCMXT06np4mAjEas/1pjqorTZV8E
 Kt+VN26ZQqOpDhLO3HPHWMhv5TWAOu5LG37z7rB3nq49IhYayPAaJ9qXIhr/UVEaWVrf
 UJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ImV9GXcTg3axtWS42bX0vZt1uE0u7nNuiWPJpxObbF0=;
 b=MJa9t30eeWuTiGQBbqK9oA2SaxiLiwTtmWXHzoxr7j1FQXV3P1fd4g82jmKacKL+Ax
 F7mBGubaPqtWEEBlRcRsJt+HHex5MjH+CnrcKw9UeaU454O+CCUKvbBpOhyqLXtyInyU
 IF+7puRNiBUa7tWtWvzlLQgQxpVljQMJLHOvkE1TVJD3qbp5V3WQvZJNtLQfLDxyCenF
 UixzdkLIwVQ0/I3srJlAvV6fKa2t2C+ZbfX+1/9IkWIpy/th2zhVMnD5aTI+JbJez103
 aW8f4UglPOhqosGpCBDqvzw8v0g6octWnLoUTB80TSZpHQ5d9QMkxY3on8dELIT+I8qQ
 5e/A==
X-Gm-Message-State: APjAAAVaYbuCVG2qFpB4QnK6w5AmTqGozjY+35a4wU3LBeenyKSl3EqL
 oCULAjV2VHxw5kdjimMMXXRHHSTTX2iofBfIYcyPWQ==
X-Google-Smtp-Source: APXvYqxEpI3wfKswEyIKwPFF18H+w5VRfoc6ULq4Ma3VYF4OSdU7J+GaLn0DqoRJRfyRpv5EJHwUUfDWG8i5XZw+jqI=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr4054138otd.91.1582907140713; 
 Fri, 28 Feb 2020 08:25:40 -0800 (PST)
MIME-Version: 1.0
References: <20200225180831.26078-1-richard.henderson@linaro.org>
 <20200225180831.26078-6-richard.henderson@linaro.org>
In-Reply-To: <20200225180831.26078-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Feb 2020 16:25:29 +0000
Message-ID: <CAFEAcA-ejGqet4iJypfZ3WbmWZaKENs+jMf0Vs2uNUngXsrxgg@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] target/arm: Honor the HCR_EL2.TPCP bit
To: Richard Henderson <richard.henderson@linaro.org>
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 at 18:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This bit traps EL1 access to cache maintenance insns that operate
> to the point of coherency or persistence.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v4: Fix el0 fallthru (pmm).

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

