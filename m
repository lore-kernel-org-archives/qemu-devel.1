Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E864CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 11:56:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37BC620700
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 11:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pqqwmRb9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37BC620700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLQrV-00060k-Bm
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 07:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iLQqY-0004kb-Hw
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 07:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iLQqX-0002D6-8Q
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 07:55:06 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:36035)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iLQqX-0002CZ-4G
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 07:55:05 -0400
Received: by mail-oi1-x22e.google.com with SMTP id k20so4975021oih.3
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 04:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DtIlcyul9aLdZziuGa4qPSMs18kQJ9pup3Mvo8v6yzI=;
 b=pqqwmRb9HCtk7hfTBRda/GoV+eqctA1jF/ljkDjnjKOhPiVvjiNeNVQxjDvxNM5iXf
 L0DjB0LyUYqID62JuPPsz9Jv66+iwv2KV1rYOx0clyrD6PTSX3dZVx5U04zLMId/8YFd
 j3awtwhEnN3EllZaE3lbGkdM6FT9sOVIKnvxC8eC0JcxzSuNDlB83dijyiclLXvdYNhR
 irgIOaBmKSYUsa5INhyzOUSL9W/4vvICVwLtSr7eHsKzjwUbC0TPZNdUbsLwQnvr3ly8
 CLGuLG4ihot+0HlsF64rRqvHp+U9yD/mGcFeTMoggV3URYMwDaYdFy7Jo3PV/Utb73jR
 9a7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DtIlcyul9aLdZziuGa4qPSMs18kQJ9pup3Mvo8v6yzI=;
 b=RdWss0KLzjPoK4lT0QsH1QawCFjvtJPJ49v9qCXLtkb4cQ8YwxE2dXLdLOC3zoojtb
 U4t6cSsRJawGzMecHZP6MIwj3S6fXPdl1KUVl6C4dlJzWQz4Gb7TkkvpVbZ2Z+Z+8OfH
 ckikfKoCg+RIPECpTFr2ie2rIqhPcH5ulv+/jMSInyEPKKQdraxCDPCjXxiMuAQhU+w4
 Wu5vFfoHCF7rfgOas+KK7Qc16UTgjPIZyXemhWD+K52fr4Lz9zPZ9VrcQ1I8fKI70gO4
 4uxg3+QyJLuksFF5tuAe6wurwtZ3D9jxF11ejEJnaaWYf+fzTblqinRc4CZuwMAsVK8y
 Wy7A==
X-Gm-Message-State: APjAAAV7dBC9ZekDR2zyHYSS9Fmr/UnHyo8QuqVoJc/x9leqUM1sW3zA
 cuhjTDXUMFqhOcKzlRQv9xaUDQG61PgBetvfv/iqGA==
X-Google-Smtp-Source: APXvYqxI2VQvWTnQcoxy7TyrmB5biKKcl615nWibcQvTEeRrwcioVhJtyaGGoUN8rUC5IiYYFV8AL0CyW6FFP1g0Cok=
X-Received: by 2002:aca:2b08:: with SMTP id i8mr7327992oik.146.1571399704090; 
 Fri, 18 Oct 2019 04:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191018101711.24105-1-kraxel@redhat.com>
 <20191018101711.24105-2-kraxel@redhat.com>
In-Reply-To: <20191018101711.24105-2-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2019 12:54:53 +0100
Message-ID: <CAFEAcA9QMKaQiC+=0MYZsdX5NRMJ3D5Hqws=ZmWK8mHYakGr0w@mail.gmail.com>
Subject: Re: [PULL 1/4] ui: Fix hanging up Cocoa display on macOS 10.15
 (Catalina)
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
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
Cc: Hikaru Nishida <hikarupsp@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Oops, just noticed that this patch should have been
Cc: qemu-stable@nongnu.org.

Hopefully the stable team can pick it up anyway.

thanks
-- PMM

On Fri, 18 Oct 2019 at 11:17, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> From: Hikaru Nishida <hikarupsp@gmail.com>
>
> macOS API documentation says that before applicationDidFinishLaunching
> is called, any events will not be processed. However, some events are
> fired before it is called in macOS Catalina. This causes deadlock of
> iothread_lock in handleEvent while it will be released after the
> app_started_sem is posted.
> This patch avoids processing events before the app_started_sem is
> posted to prevent this deadlock.
>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1847906
> Signed-off-by: Hikaru Nishida <hikarupsp@gmail.com>
> Message-id: 20191015010734.85229-1-hikarupsp@gmail.com
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/cocoa.m | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index f12e21df6e10..fbb5b1b45f81 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -134,6 +134,7 @@ NSArray * supportedImageFileTypes;
>
>  static QemuSemaphore display_init_sem;
>  static QemuSemaphore app_started_sem;
> +static bool allow_events;
>
>  // Utility functions to run specified code block with iothread lock held
>  typedef void (^CodeBlock)(void);
> @@ -729,6 +730,16 @@ QemuCocoaView *cocoaView;
>
>  - (bool) handleEvent:(NSEvent *)event
>  {
> +    if(!allow_events) {
> +        /*
> +         * Just let OSX have all events that arrive before
> +         * applicationDidFinishLaunching.
> +         * This avoids a deadlock on the iothread lock, which cocoa_display_init()
> +         * will not drop until after the app_started_sem is posted. (In theory
> +         * there should not be any such events, but OSX Catalina now emits some.)
> +         */
> +        return false;
> +    }
>      return bool_with_iothread_lock(^{
>          return [self handleEventLocked:event];
>      });
> @@ -1156,6 +1167,7 @@ QemuCocoaView *cocoaView;
>  - (void)applicationDidFinishLaunching: (NSNotification *) note
>  {
>      COCOA_DEBUG("QemuCocoaAppController: applicationDidFinishLaunching\n");
> +    allow_events = true;
>      /* Tell cocoa_display_init to proceed */
>      qemu_sem_post(&app_started_sem);
>  }
> --
> 2.18.1

