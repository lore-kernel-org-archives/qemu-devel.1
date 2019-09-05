Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F6EC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 20:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43FDE20674
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 20:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqxuKRJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43FDE20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5yim-0006Cy-6z
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 16:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1i5yht-0005dg-H3
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 16:50:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1i5yhr-0003nV-Hx
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 16:50:17 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:44461)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1i5yhp-0003lU-KI
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 16:50:15 -0400
Received: by mail-yb1-xb44.google.com with SMTP id y21so1371511ybi.11
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 13:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z0ouXPBMSp+HSq3seITSkUyxFWOxT/dHi8uKotdMr0I=;
 b=cqxuKRJ4B219B+UPV4hcqrF+biqWuGI+B0RQflVhNy7gWPYdiSr3P2n1BoOqfKwDti
 Z5ILMzkyRFFj9mY9X1lTpuHTwI23tJNT1HRTN3BLNXnx4j13N30qz1Twee5m2E/5AQ/M
 Uh9VrDVqT9qj2SmPfSqDIZEfAdKGclVGJBZfNoEnLCOn8nl07PQ6xcqmSYMXsgoATHLj
 J4IuMy5IuHddpzLXJHfz3qGra91/2O82s49rGXm6TKssfhZ6oh0VmxO9o4m7UI6jhzEd
 BY1fGdjAJxN0UbOK+NBUSxkULX3olwylCXTEB+AqSqpCjjy8/9EXW5MEiv3e0U/oZNMG
 AL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z0ouXPBMSp+HSq3seITSkUyxFWOxT/dHi8uKotdMr0I=;
 b=EqqqtYWTfzRfIqXzo/87cKMsB6Ijojy8fNa9DKx4lK1E7iVEyvuz5Sp7tO8nZYeM6D
 vBatx1FVcPKuX+QErn/MxcrmnOK6+qIFWfsnyOY5EcdiMqiJXaB0selY7GTUxu7B9KiK
 ebzHrOjaw38tjCMTOGOUOmNztw4Zcu5qObM7j/WfpaJyznHVHhrw3tT3GAqGBNKv+Ucq
 PpBnOtdYos+v4jx/IPp8zFo+sVnk9HKSHBFcB1ApN5H1e1TihIRxL3m7J8w7UPP0CCAI
 Vr9cWFSD1z6T9nbpbjrLSs2gURDYKPubdK2Urosd8sXuckGv1/YNKYTDdOprQsXbxcn3
 X5dA==
X-Gm-Message-State: APjAAAW+GalMQDWeGkqiDQ5VV2WnQkFIW8jEVAFMN9fV3Sz/NcZUUP3k
 iAFSrHMCEYEyRpAIDaaolfreBIPipMaCsUe3N1xs6vgt
X-Google-Smtp-Source: APXvYqxa34x2Rt50CmrxFbRczkTUVPE3mopRXy0+uFnEwbRegGlFahp1ekJ+jXsJ3mhaZijitg2XopLXSH5yDYh+qI0=
X-Received: by 2002:a25:5f49:: with SMTP id h9mr3734062ybm.25.1567716612641;
 Thu, 05 Sep 2019 13:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190826195806.15998-1-jcmvbkbc@gmail.com>
In-Reply-To: <20190826195806.15998-1-jcmvbkbc@gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 5 Sep 2019 13:50:01 -0700
Message-ID: <CAMo8BfLQErOxW_xcTGt1_hsqKzwqNxZDHtzct3-2JxeRPpEN9Q@mail.gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: Re: [Qemu-devel] [PATCH v3] target/xtensa: linux-user: add call0
 ABI support
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Laurent,

On Mon, Aug 26, 2019 at 12:58 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Xtensa binaries built for call0 ABI don't rotate register window on
> function calls and returns. Invocation of signal handlers from the
> kernel is therefore different in windowed and call0 ABIs.
> There's currently no way to determine xtensa ELF binary ABI from the
> binary itself. Add handler for the -xtensa-abi-call0 command line
> parameter/QEMU_XTENSA_ABI_CALL0 envitonment variable to the qemu-user
> and record ABI choice. Use it to initialize PS.WOE in xtensa_cpu_reset.
> Check PS.WOE in setup_rt_frame to determine how a signal should be
> delivered.
>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes v2->v3:
>
> - revert to checking PS.WOE in the setup_rt_frame
>
> Changes v1->v2:
>
> - move handling of QEMU_XTENSA_ABI_CALL0 to linux-user/main.c
> - check xtensa_abi_call0 instead of PS.WOE in the setup_rt_frame
>
>  linux-user/main.c          | 17 +++++++++++++++++
>  linux-user/xtensa/signal.c | 25 +++++++++++++++++--------
>  target/xtensa/cpu.c        | 24 ++++++++++++++++++++----
>  target/xtensa/cpu.h        |  3 +++
>  4 files changed, 57 insertions(+), 12 deletions(-)

Could you please take a look at the most recent (v3) version of
this change?

The corresponding linux change is queued here:
https://github.com/jcmvbkbc/linux-xtensa/commit/09f8a6db20e6ed8eab1b2b23d09d2458f6e15062

-- 
Thanks.
-- Max

