Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21FBC2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 13:47:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 699BB2083E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 13:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kIjI3mQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 699BB2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMXWN-0007BW-HK
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 09:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jMXVO-0006M2-2B
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 09:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jMXVL-00016K-U4
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 09:46:05 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38118)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jMXVL-00015s-Kz
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 09:46:03 -0400
Received: by mail-oi1-x243.google.com with SMTP id w2so3265537oic.5
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 06:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zvmRGpy/8Cv5dYHvdYn3I5Yhxeo5kGD1AgF5Vtk3Er8=;
 b=kIjI3mQimEzG3MQhIY7WN2jbL3+LtZBuPCiQFdrxrP1GfAADX9Il+3lGizpYBug2Al
 tnFkweV56uylXe8XE1xJEykd/Q6YHFnYl3bIhOJgETKW1zL7JWkqXIdUSPf+FTCMHR6j
 CQur6JOrfYTjAAv27zSDWO91cVYI3giJFE9hKvUZfXxWtR13/GC7I63UMSalCqjSLIF1
 zVxRpUjc3TpnLy9PBDeI8jIxiftUNJ3N7jbJtFgv3GR58gu1zya8BW5IByFXY0uf535n
 BY32bCVcAl2tSqKupM3w5Pd2wioKnb0vCwg4JQiryt4XdbEGVIrervJM/mg7ufiX2mb4
 rSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zvmRGpy/8Cv5dYHvdYn3I5Yhxeo5kGD1AgF5Vtk3Er8=;
 b=VjNkE6NZd/W41fiDIZVHoc2zcDw4GfgKnj1gq22v5wg/svcFS91axO3LUAuAaMOJBn
 GfoC0TTO/PtNy8ZLrjpOeHCwwejhcDZSxq5UnXkSpTy2wxlMJc5EKZtPkeysmIGp3ybl
 TfiWTkI7OWPsHR/1OpuoHOdgOa/psiUSMITaBcftNwdpL1sasZ+C+NORr3IbUHuFgJkd
 ohLRAVnQRy/AtRg3FCxo/eeU6cXcVoQnWfYKp1iySP4Pex+e2FOn6qOGCJAG2IqIRGe+
 SlpvCpZyozdpDmGdwYmTtPw5dAHN8Mnb4YqFYTxRCtNsrxgxNa9f3w42U3F24qbNa5cd
 kpZA==
X-Gm-Message-State: AGi0PubaNb68ZUywAPoYykjgv579+hK8GCcY2eMbFgeqafHkyv3KX0lZ
 gHoY9wPUyruGm1eIYDsH9HiE9Mt8MeynDRFI71VFeA==
X-Google-Smtp-Source: APiQypKqCyi48cDkc9nNt3jK2YKgGz3gYOCSyJbQJhNICDe4y3JYXMHowOvLTfBv3k8cVvRqW7vBUCxk5q7XxOGc1Z4=
X-Received: by 2002:aca:3049:: with SMTP id w70mr3444963oiw.146.1586439962367; 
 Thu, 09 Apr 2020 06:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_40A25AAA0184A47D23DEABAB49067CBA3E05@qq.com>
In-Reply-To: <tencent_40A25AAA0184A47D23DEABAB49067CBA3E05@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Apr 2020 14:45:51 +0100
Message-ID: <CAFEAcA96sxmaoryvRQJnYJoYLCVFDOKRWyzfBJnXxnjOmZvWEQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Add Kunpeng-920
To: KevinZ <zheng.zhenyu@foxmail.com>
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 Apr 2020 at 14:17, KevinZ <zheng.zhenyu@foxmail.com> wrote:
>
> HiSilicon Kunpeng-920 CPU is one of the commonly used
> data center CPUs, this patch adds it to target.
>
> Signed-off-by: Zhenyu Zheng <zhengzhenyulixi@gmail.com>

Could you explain what this provides that you couldn't
get with either -cpu cortex-a72 or -cpu host ?

Also, is there a reference manual/datasheet for
this CPU to check whether we're implementing the
right set of features and ID register values?

thanks
-- PMM

