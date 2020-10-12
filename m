Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4626CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9D532078E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBbJ6gvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D532078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS4rG-00075i-W3
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 16:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kS4aW-0001Iu-Fz
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:38:33 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:42971)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kS4aU-0003Ef-By
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:38:32 -0400
Received: by mail-lf1-x141.google.com with SMTP id a7so18587079lfk.9
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 13:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cooTXEHZCY4iqCHzog1t5U5S0Qhy0LEUjSbQsJ0c9OM=;
 b=rBbJ6gvR35guqwNM7P0ZKcQZ0uw2x3uNTfVPHqa6px1KXDPCQYNud/nLrGc9jKK7Qw
 UquFU7YztYnxYp/G+i0WpVT1TfGyy7z1kyqyTNBpYI/RcCkQKKv3mX07eRAD5kG9k6xo
 LFd+NCp2IiMtMb/Ia5ZrsZW80xKN7cnglBHM8D05KKoDF9AJxF1VdB1pAzu8WRqh7MCF
 /9Ueze8W2mQj8V5RH5mbe59e8PzVNlyO1x+n9K3+0Iz8N+cc2DHNozbbre28+6N0p6IU
 qq9iuD7X93TjMb2xxc1fFKHkyIaTCwHm7BG4BL4UdJaj6iH/Hp+TEzPVkLAHBVe5QR/V
 4dZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cooTXEHZCY4iqCHzog1t5U5S0Qhy0LEUjSbQsJ0c9OM=;
 b=i8Zz3obzzcMVvOpy/ZzLW0zRcMyijOmY47WOZKz79YoaXa9mboBJ6C/fYvi1bY1t9G
 3UJMkBX8CCQ5BxeEK3oD0xlU9rzGGGKycbl8o4zlbgW8Or37JJ5rFVFL4AbNHdMPgF5w
 rGCjtWXkmjOuYT848ZtgrxOiB75P3rCdlHmiLCV81NF06Km5pw44TK73n2WyruNN4kiI
 Cg59Hw24KDRZ6N1Tn/R/ofSkRQq0Pth1eQjwFEfsWUP06tJnI4wJLbapjFtG9NpZ3k5T
 2z8QtbaQ83JQG6APLqL4Mod4n09lEPX4xEKUNIBHM79d9w0TBUdt+MPUDuVvqd7tJcKk
 4Ujg==
X-Gm-Message-State: AOAM53169AiqGaDAvsII9u3nWzihi1sXCjuy49tV0bLsFqzVayCPBLho
 WFuQc9kYjQwdY/1XWpgIW7v4twjorRxzcD1vnVw=
X-Google-Smtp-Source: ABdhPJw1mcqpB4g9r6kx2eZCqQuPZTXLZwkWjoKwQ+DdwazNlOpdKkoj1AZUDlkpie+ANYBfoMwM7iRusdtgYZchbxc=
X-Received: by 2002:a19:4314:: with SMTP id q20mr7133591lfa.320.1602535108318; 
 Mon, 12 Oct 2020 13:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201012200725.64137-1-jandryuk@gmail.com>
 <20201012200725.64137-2-jandryuk@gmail.com>
 <f29b58c7-62c5-ad10-91c8-47598759c876@suse.de>
 <1f99e620-8356-a67f-1741-4e1c607795e1@redhat.com>
In-Reply-To: <1f99e620-8356-a67f-1741-4e1c607795e1@redhat.com>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Mon, 12 Oct 2020 16:38:16 -0400
Message-ID: <CAKf6xps2tHJHN-WmyNiTY5KFgZNsuGSNHc5LvxvRvc=16WbmrQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] accel: move qtest CpusAccel functions to a common
 location
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=jandryuk@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 12, 2020 at 4:30 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 12/10/20 22:23, Claudio Fontana wrote:
> > On 10/12/20 10:07 PM, Jason Andryuk wrote:
> >> Move and rename accel/qtest/qtest-cpu.* files to accel/dummy/ so they
> >> can be re-used by Xen.
> >>
> >> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> >> ---
> >>  .../qtest-cpus.c => dummy/dummy-cpus.c}       | 22 +++++--------------
> >>  .../qtest-cpus.h => dummy/dummy-cpus.h}       | 10 ++++-----
> >>  accel/dummy/meson.build                       |  6 +++++
> >>  accel/meson.build                             |  1 +
> >>  accel/qtest/meson.build                       |  1 -
> >>  accel/qtest/qtest.c                           |  7 +++++-
> >>  6 files changed, 23 insertions(+), 24 deletions(-)
> >>  rename accel/{qtest/qtest-cpus.c => dummy/dummy-cpus.c} (76%)
> >>  rename accel/{qtest/qtest-cpus.h => dummy/dummy-cpus.h} (59%)
> >>  create mode 100644 accel/dummy/meson.build
>
> Maybe accel/dummy-cpus.c, no need to add a new directory.

Sure.

> >> diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
> >> index 537e8b449c..ac54bc8f52 100644
> >> --- a/accel/qtest/qtest.c
> >> +++ b/accel/qtest/qtest.c
> >> @@ -25,7 +25,12 @@
> >>  #include "qemu/main-loop.h"
> >>  #include "hw/core/cpu.h"
> >>
> >> -#include "qtest-cpus.h"
> >> +#include "accel/dummy/dummy-cpus.h"
> >
> > this is a bit strange from my perspective, does not look right.

Yeah, I didn't really know where to put it.

> > Maybe this dummy cpu prototype should be somewhere in include/ ,
> > like include/sysemu/cpus.h or even better include/sysemu/accel.h
>
> Yes, it should be in include/sysemu/cpus.h.

Sounds good.

Thanks,
Jason

