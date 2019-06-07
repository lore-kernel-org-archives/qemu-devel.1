Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF170C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 804A9208C0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U+f5kDWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804A9208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50760 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZJpl-0007JE-9t
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 14:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53843)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hZIHx-0002OS-MQ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 13:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hZIHw-00024v-9Y
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 13:04:25 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37039)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hZIHu-0001nj-D3
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 13:04:24 -0400
Received: by mail-ot1-x341.google.com with SMTP id r10so2513758otd.4
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 10:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jCBiWPbdweBj8ITHgOEv9sNhHLi+ww1+RUSY7Yw/Eio=;
 b=U+f5kDWqktttDornlfJBNtHpDgj55mercqQzTy+8nDlus3ruDVbNc6OIViZZHSX8/3
 rs73Zg3yyNMy/6mn1KXlV0nYTg6bubvJ5GbjKUtkJnKHoprJ9qjVtDVS6hOpcI0gdfiP
 1aCU39YHq06YiDbx4i1+wdc3TKSq9gciZSIRuB3OKyuUXJsYT2/XInVXEfUKozjgGz8i
 FcaUVz0kzJhno5R8wsgBh1iOn/FddjOoVLc9wBTDnTzmwqvLLaZTU6wNMhPtGkdC4crE
 rTNF/knqZCPq/iMYf9XRgXhSptZEBBhT3sijyDYe3gmRx1cCiUGL5hx18XZsarhdJ1SV
 z6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jCBiWPbdweBj8ITHgOEv9sNhHLi+ww1+RUSY7Yw/Eio=;
 b=e4QxanqisleqQBI0Qy2ueCEyH6d8juJZ3xx5+XsBWYTQjeMWRElv26eZYzSvslA6wM
 RvdM+89gufvn6mmbPO6p9QHtHTUPb8lOKnDcKVA2AhV6lKD5KgkZTuxFe7HTS+S5ylYJ
 7nGeBgQsJokY6acqe6e7wWjVCUpeBlB+DgArCZXA1SU85roOxzyt/mGRfbBGU9+RPI6f
 6H3ae4ShjqlHSCJxHbuuHQSirqcJ8+o/VXkzjv8xZloDFEQBPuC5+yCIlm1pCmrsIXMF
 A9gW/rbnYpP4JEiD8lor7vp9XwJ0j9Qi4xQevy0zllXJ7WiiNBMEwgDZr/N3vlm9tS1h
 C/OA==
X-Gm-Message-State: APjAAAX0TxR3/HTb4mqFkCeUPQRLPJYYJOSo0NtlQhaTKxT0CTCPiKwj
 FTuvpig2rCT9JVIrY+St3QehOKAlfIQOCirPWrZ89g==
X-Google-Smtp-Source: APXvYqyUMkYPF/OE5z8fuQxvGVjJuQemWDYsgbm/V3jMKlGjhZdtrMMjjf4HWPKjG77Jy+/JQEHFhHYYW8NkPct9OPY=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr20513097otk.232.1559927057879; 
 Fri, 07 Jun 2019 10:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <B3540B0C-9A71-4733-8109-11B0DC7A17D2@me.com>
 <FA3FBC4F-5379-4118-B997-58FE05CC58F9@me.com>
In-Reply-To: <FA3FBC4F-5379-4118-B997-58FE05CC58F9@me.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2019 18:04:07 +0100
Message-ID: <CAFEAcA9uz28s-RGkYfgYGVkW9L3VP0Q4-psxVkZwaLzD_VxsBg@mail.gmail.com>
To: Chen Zhang <tgfbeta@me.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 1/2] ui/cocoa: Fix absolute input device
 grabbing issue on Mojave
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 4 Jun 2019 at 10:36, Chen Zhang <tgfbeta@me.com> wrote:
>
> On Mojave, absolute input device, i.e. tablet, had trouble re-grabbing
> the cursor in re-entry into the virtual screen area. In some cases,
> the `window` property of NSEvent object was nil after cursor exiting from
> window, hinting that the `-locationInWindow` method would return value in
> screen coordinates. The current implementation used raw locations from
> NSEvent without considering whether the value was for the window coordinates
> or the macOS screen coordinates, nor the zooming factor for Zoom-to-Fit in
> fullscreen mode.
>
> In fullscreen mode, the fullscreen cocoa window might not be the key
> window, therefore the location of event in virtual coordinates should
> suffice.
>
> This patches fixed boundary check methods for cursor in normal
> and fullscreen with/without Zoom-to-Fit in Mojave.
>
> Note: CGRect, -convertRectToScreen: and -convertRectFromScreen: were
> used in coordinates conversion for compatibility reason.
>
> Signed-off-by: Chen Zhang <tgfbeta@me.com>
> ---
>  ui/cocoa.m | 43 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 41 insertions(+), 2 deletions(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 420b2411c1..474d44cb9f 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -405,6 +405,41 @@ QemuCocoaView *cocoaView;
>      return (p.x > -1 && p.x < screen.width && p.y > -1 && p.y < screen.height);
>  }
>
> +/* Get location of event and convert to virtual screen coordinate */
> +- (CGPoint) screenLocationOfEvent:(NSEvent *)ev
> +{
> +    NSWindow *eventWindow = [ev window];
> +    // XXX: Use CGRect and -convertRectFromScreen: to support macOS 10.10

The "XXX" prefix usually indicates something in the code that
needs to be fixed, but in this case the code is already using
these methods, so it's OK I think?

(I hope to have some time to test these patches this weekend
or next week.)

thanks
-- PMM

