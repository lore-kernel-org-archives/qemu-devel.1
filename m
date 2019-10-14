Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FAFECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 13:20:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C12B2089C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 13:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="er9cYZQP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C12B2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK0Gw-0003mG-Nc
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 09:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK0G7-0003Fu-7D
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK0G5-0003TK-ME
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:19:34 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40550)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK0G5-0003Rn-GV
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:19:33 -0400
Received: by mail-oi1-x243.google.com with SMTP id k9so13705999oib.7
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 06:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rqAxjp1zGubptscXU/TrDtJKnU2SUIb+xn+gSzBcjMc=;
 b=er9cYZQPTr3DRZfDR1S0zS9Ft1cbkpjlT67U5T4texbSOGj6U0vwMW520h22e8EAgQ
 GZttl4KfEvi7I1Yd3lXLgQ5uVuaWZYNGCxOy61qhhDtHDgxjf5Qpl0t7fl90dnIfCr9l
 fIW5fjHCeD5ZBrYjCcgVwuWb0LGcNrr9AbzpkWeVCyF1B4kzF7k5WsIMN2tIOrgFi+7o
 r/XatYGUjktQhwIyqTEAgDVUE8OAB7KQ3UCyP4lA5DoG1yaYEsXZd9DuH82lLlt0DGt5
 tbZqQ0QYZtQohLFnF0m6c91JFcUIPxBp9uzZ9Q5z0qtcuWuRp2y5uYG5UWrwyfndRPtv
 wY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rqAxjp1zGubptscXU/TrDtJKnU2SUIb+xn+gSzBcjMc=;
 b=RyPC2RkIz0tfiUwdfsq0VbpfXdfrOefkF205dBEP7DK+18dNzhjExknITsB72RXFac
 m+BD6gtlbZyMaA0sa5P3smJKITkcD0IPh4/VETQP9fKq0R63YH8bS6Xk4QTkimrl7OYZ
 gbxgvTDdogxyilbk/pu2IMDmRPyK8QQ+UVTv29FtSuh62UqxzkidgPUJkagar94qdG7g
 oG/IkqkKrsAR+gDuPTI0237d9rLp8O+6UuypfI3KugiwS9no1G48bWPzz43HUAD7WBtt
 vZ9CuKhLVoSb12gvI6USlaQa/QXmWmlfzfmVBYDqfm390+3/iDnC6MQMT1c4erFSscih
 SiIg==
X-Gm-Message-State: APjAAAXXqrB6Ck3eATaTclFqxs6FnPD1BWrcdFMtBBavOfdHyHADSmHR
 bEzkXfW9q4pljjdOo7Ij1nGdGkf6p5vNl/10SU6XOA==
X-Google-Smtp-Source: APXvYqxwsfuUAGKPeiCYax2Tv9ogz6WkDq8TsanvaDzh9botmt2mak49rNzznXqtQ244QeixYMVhAkFrpQktMuAHJU0=
X-Received: by 2002:aca:3b41:: with SMTP id i62mr23187793oia.48.1571059171225; 
 Mon, 14 Oct 2019 06:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191014125254.74913-1-hikarupsp@gmail.com>
In-Reply-To: <20191014125254.74913-1-hikarupsp@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2019 14:19:19 +0100
Message-ID: <CAFEAcA-iaUraj+AZuGcXw6pNy2aBQ2J0Cm9900COsY+quJc2tA@mail.gmail.com>
Subject: Re: [PATCH] This patch fixes hanging up Cocoa display on macOS 10.15
 (Catalina)
To: hikarupsp@gmail.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Oct 2019 at 13:53, <hikarupsp@gmail.com> wrote:
>
> From: Hikaru Nishida <hikarupsp@gmail.com>
>
> An NSEvent is fired before applicationDidFinishLaunching on macOS
> Catalina. This causes deadlock of iothread_lock by calling
> bool_with_iothread_lock in handleEvent while its already locked.
> This patch prevents to call bool_with_iothread_lock until the
> app_started_sem is released to prevent this deadlock.
>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1847906
> Signed-off-by: Hikaru Nishida <hikarupsp@gmail.com>
> ---
>  ui/cocoa.m | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index f12e21df6e..f16d341a0a 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -134,6 +134,7 @@
>
>  static QemuSemaphore display_init_sem;
>  static QemuSemaphore app_started_sem;
> +volatile sig_atomic_t allow_events;
>
>  // Utility functions to run specified code block with iothread lock held
>  typedef void (^CodeBlock)(void);
> @@ -729,6 +730,9 @@ - (void) handleMonitorInput:(NSEvent *)event
>
>  - (bool) handleEvent:(NSEvent *)event
>  {
> +    if(!allow_events) {
> +        return false;
> +    }
>      return bool_with_iothread_lock(^{
>          return [self handleEventLocked:event];
>      });
> @@ -1897,6 +1901,7 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
>      /* Tell main thread to go ahead and create the app and enter the run loop */
>      qemu_sem_post(&display_init_sem);
>      qemu_sem_wait(&app_started_sem);
> +    allow_events = true;
>      COCOA_DEBUG("cocoa_display_init: app start completed\n");

If we do use a flag to fix this race, I think it would be
better to set allow_events = true in the
applicationDidFinishLaunching() function before posting
the app_started_sem. Otherwise there's a window after
applicationDidFinishLaunching() returns but before
cocoa_display_init() resumes and sets the flag where we
will unnecessarily drop events.

Could you try that and check that it still fixes the hang?

thanks
-- PMM

