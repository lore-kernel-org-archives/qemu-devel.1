Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F643C352BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 10:40:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD7A821D94
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 10:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fJJve5VC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7A821D94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPOPy-0000xE-26
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 06:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jPOPL-0000R9-Fw
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jPOPK-0003yE-7T
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:39:39 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41187)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jPOPK-0003xZ-2f
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:39:38 -0400
Received: by mail-oi1-x242.google.com with SMTP id k9so1669594oia.8
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 03:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5nzwvwmfOZPiP8MgyjxaZA/nsHP01MUTiYZMGpB1IQw=;
 b=fJJve5VChNmbNEyE4RssX36h1BaQECR7okQfuRd5/lvgpeqnRSSFMf6UHUJN51TZoy
 yBxm6Xp6Hf3beJCVLLZbmUa7H0buGWYWXf2RJai0DwtdXAGyeP794kyaG9EPYred/1W5
 RA5qtgjP7YLlnUqvMXUCX03/EPPbOLsBe4ga2HxOWBg3UB1EfV4egxSUUoqgXpHAc5Eq
 zNlpEGdcpprWXkQP8R0Lacvnt2Z1jo1DCqxrfql6f+2ERjxnXb9XD80nfWypdWP8cJII
 2fVmtq6XXSPs9XtIIGOlUCYGOdX78yTvcl71NFjS8gsyHV22VjrhlwQAaBRSi3PFuOT3
 NE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5nzwvwmfOZPiP8MgyjxaZA/nsHP01MUTiYZMGpB1IQw=;
 b=ORbB+1NnxHzecvYDjFH7olwWzSlI4yypI+4CNN3V3lkciBM2NTgc+X+t0nv+8bMVCo
 HFNNbYpIu3RBSQoYQkU059MR/m5slGfsjgwWNehW6GFnb7MDd9VFNeCIl0svcqWPtnif
 oiqwGBgjA9K3GUwNSTnWC8FOLXZK1buNJojcOI+AFjvhqIn7I3QE6YUV80C8RKbV2aO9
 ruatczKYYEXIXqAvXCH6Qpm/7eOxEkm3JY9xqzUfZVqvqQqB2WkxV+4J1ra8scgfnikz
 bW8uRkEQG+dMBcLBe7U0C9L7h/nOATFTvA0YmdH7SNIrjRQvNPEpjyXMFxvkoue87KbQ
 WfrA==
X-Gm-Message-State: AGi0PuaQhHmZkEkcgobMbIkrbpKnEmuVcBRsgEKJcBLEYlS4BmwYW3WI
 TBsxOVfQlsFM4Wi9lNhTbH90Tf67UE0AV0056/AdHg==
X-Google-Smtp-Source: APiQypKpsoCGBM8B+5ULU2Kgg0ztLFZk9VQ9Z2Ac/7fK1Wbv+hVQnub17Ti7V4wympxWG8jlVVSUhGkZZaXj36jfJ7A=
X-Received: by 2002:aca:dc56:: with SMTP id t83mr1572060oig.48.1587119977020; 
 Fri, 17 Apr 2020 03:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200323113227.3169-1-beata.michalska@linaro.org>
 <20200323113227.3169-2-beata.michalska@linaro.org>
In-Reply-To: <20200323113227.3169-2-beata.michalska@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Apr 2020 11:39:25 +0100
Message-ID: <CAFEAcA_uWS+cVRk=BKra8AhsD+B1syVzhXeCMttSKwQDdo=j3w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] target/arm: kvm: Handle DABT with no valid ISS
To: Beata Michalska <beata.michalska@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Andrew Jones <drjones@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Christoffer Dall <Christoffer.Dall@arm.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Mar 2020 at 11:32, Beata Michalska
<beata.michalska@linaro.org> wrote:
>
> On ARMv7 & ARMv8 some load/store instructions might trigger a data abort
> exception with no valid ISS info to be decoded. The lack of decode info
> makes it at least tricky to emulate those instruction which is one of the
> (many) reasons why KVM will not even try to do so.
>
> Add support for handling those by requesting KVM to inject external
> dabt into the quest.
>
> Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
> ---
>  target/arm/cpu.h     |  2 ++
>  target/arm/kvm.c     | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/kvm_arm.h | 11 +++++++++++
>  3 files changed, 67 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 4ffd991..4f834c1 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -560,6 +560,8 @@ typedef struct CPUARMState {
>          uint64_t esr;
>      } serror;
>
> +    uint8_t ext_dabt_pending; /* Request for injecting ext DABT */

I was trying to work out whether we need to migrate this state,
and I'm not sure. Andrew, do you know? I think this comes down
to "at what points in QEMU's kvm run loop can migration kick in",
and specifically if we get a KVM_EXIT_ARM_NISV do we definitely
go round the loop and KVM_RUN again without ever checking
to see if we should do a migration ?

thanks
-- PMM

