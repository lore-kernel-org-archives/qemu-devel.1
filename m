Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230AFC76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 11:00:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE928217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 11:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yl8O3/Wj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE928217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho49a-00088y-6z
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 07:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42033)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1ho49K-0007Om-Py
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:00:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ho49J-0004BU-KR
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:00:34 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35479)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ho49J-00049r-E4
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:00:33 -0400
Received: by mail-ot1-x342.google.com with SMTP id j19so28554289otq.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 04:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yT9crJu5E3LwSFN+JTYNzKLoBncuuOSYGS+xJ71gc70=;
 b=Yl8O3/Wj9z9RHr0NMRo+GJhz+9+Nv16XTypVsKMfvgHb/2zNgE8dcWH74Zg5/pRPIb
 GABtFU/RlflvfoeRrscvREn7aQNVIoX23EYrjAvc7elKZhGWwtSngZlaQtJrI6i3QwpU
 k1uGBzfdjQlyhPi3podHsAahn9sIndIaHXQYIxcgpPnx4XVF5Qa0rDqnH2RmjQQcKoMl
 jyAv5v/rL7CA9QougGodVgv+NpoLfAMRG/cUigRG0liKdM+CL5vQWfKo8N+MPXktGkXX
 LF1yv57uxRSkw30tgJb3ozYpyaBdoZsmUmS/l60Zjv0175JPbvZZxFuYEqPOjyKvduXS
 AqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yT9crJu5E3LwSFN+JTYNzKLoBncuuOSYGS+xJ71gc70=;
 b=PJoM5hfpaSltZqYS1KFBQRcxM2O7z2rCvu8MWcgGBS1ro2hmmgUfzNoEk/io0y/S8n
 mBbyNbnEC0hcZJRXaxXsmi9oMjTbHjUxAkcAlkKwmZWqZL5fm29K2HIMDtnhmYiV8sEm
 fB5vumpkYCZT1oM7VIMZttiWoO8Z+288/pC9TA+64GQjVmA/0M6nUyhqQsJnvOQx/bAx
 eXnRuLBGjhLLmoIrWtZc7DqJqcdTGgXa9wv+6rKmJ2r7x85Dsijs/7MflbWYYykbf1ht
 AT1AZ1dQkUrdIZoy52bUEh7qw0QOQhMkYEjTfxiqSz4OBi5Iu2gRZvWg5wJOrRCvsR89
 tkXg==
X-Gm-Message-State: APjAAAWruG9zCQLAAALhIHFRO2mcX5bz4qIIJG4A/BbJanVEkzy7nk0/
 sX6WQf3Ur4RD5rsiBnyQz0JgO6SswxYBs+pElhYIRQ==
X-Google-Smtp-Source: APXvYqx40Vpors/lfoAMKCRNK2LJEDrgMiWN8BFyJX2gbtTISxo+eKeixPV6Q+hiy6azQ8BeMfZqjYI2P5GBCU0GGUE=
X-Received: by 2002:a05:6830:1653:: with SMTP id
 h19mr26612216otr.232.1563447632371; 
 Thu, 18 Jul 2019 04:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190717145418.23883-1-laurent@vivier.eu>
 <CAFEAcA8kMkRuqWt4_tv+ZH5NJ0-kidJ==2A_JdFbPhjYuS+XCQ@mail.gmail.com>
 <a1c7dda7-8a20-c712-686f-5648014ce643@vivier.eu>
In-Reply-To: <a1c7dda7-8a20-c712-686f-5648014ce643@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jul 2019 12:00:21 +0100
Message-ID: <CAFEAcA86Ev+-m5hYTyUDZMcfzYUcmmaSxhq05k1OACgcZFj40w@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PULL 0/3] Linux user for 4.1 patches
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 18 Jul 2019 at 11:40, Laurent Vivier <laurent@vivier.eu> wrote:
> It comes from linux-user/syscall.c:
>
>  6328         /* automatic consistency check if same arch */
>  6329 #if (defined(__i386__) && defined(TARGET_I386) && defined(TARGET_ABI32)) || \
>  6330     (defined(__x86_64__) && defined(TARGET_X86_64))
>  6331         if (unlikely(ie->target_cmd != ie->host_cmd)) {
>  6332             fprintf(stderr, "ERROR: ioctl(%s): target=0x%x host=0x%x\n",
>  6333                     ie->name, ie->target_cmd, ie->host_cmd);
>  6334         }
>  6335 #endif
>
> because of:
>
> +  { TARGET_SIOCGSTAMP_OLD, SIOCGSTAMP, "IOCGSTAMP_OLD", IOC_R, \
> +    do_ioctl_SIOCGSTAMP },
> +  { TARGET_SIOCGSTAMPNS_OLD, SIOCGSTAMPNS, "IOCGSTAMPNS_OLD", IOC_R, \
> +    do_ioctl_SIOCGSTAMPNS },
> +  { TARGET_SIOCGSTAMP_NEW, SIOCGSTAMP, "IOCGSTAMP_NEW", IOC_R, \
> +    do_ioctl_SIOCGSTAMP },
> +  { TARGET_SIOCGSTAMPNS_NEW, SIOCGSTAMPNS, "IOCGSTAMPNS_NEW", IOC_R, \
> +    do_ioctl_SIOCGSTAMPNS },
>
> As the host_cmd is not used, the simplest way to fix that is
>
> +  { TARGET_SIOCGSTAMP_OLD, TARGET_SIOCGSTAMP_OLD, "IOCGSTAMP_OLD", IOC_R, \
> +    do_ioctl_SIOCGSTAMP },
> +  { TARGET_SIOCGSTAMPNS_OLD, TARGET_SIOCGSTAMPNS_OLD, "IOCGSTAMPNS_OLD", IOC_R, \
> +    do_ioctl_SIOCGSTAMPNS },
> +  { TARGET_SIOCGSTAMP_NEW, TARGET_SIOCGSTAMP_NEW, "IOCGSTAMP_NEW", IOC_R, \
> +    do_ioctl_SIOCGSTAMP },
> +  { TARGET_SIOCGSTAMPNS_NEW, TARGET_SIOCGSTAMPNS_NEW, "IOCGSTAMPNS_NEW", IOC_R, \
> +    do_ioctl_SIOCGSTAMPNS },
>
> As SIOCGSTAMP_OLD and SIOCGSTAMP_NEW can be undefined on the host (and not needed
> because we always use SIOCGSTAMP and SIOCGSTAMPNS)

So we don't use the host_cmd because we have a custom do_ioctl_foo
function which doesn't look at that field?

Sounds OK, but please include a comment explaining why.

PS: why didn't you use IOCTL_SPECIAL() rather than hand-written
array entries? None of the other ioctls.h entries do that.
Of course now we're trying to sidestep the consistency check
we can't use the macro, but it wolud have been fine otherwise.
It also would get the names of the ioctls in the string form
right -- they are all missing the initial "S" here.

Perhaps for 4.2 it might be worth considering having a
macro for "IOCTL_SPECIAL but skip the consistency check"
to be a bit less hacky here.

thanks
-- PMM

