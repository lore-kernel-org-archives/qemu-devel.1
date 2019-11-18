Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469A5C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 12:40:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11770206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 12:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CRSOHY5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11770206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWgKW-0007lw-6f
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 07:40:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iWgJg-0007BG-QG
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 07:39:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iWgJe-0005uW-Fx
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 07:39:40 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:34635)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iWgJe-0005qL-7C
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 07:39:38 -0500
Received: by mail-lf1-x144.google.com with SMTP id l28so4200892lfj.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 04:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uWmWQwA0L9S7G0xTXoXXUZEjeNolpTp1g06yPiJpqMQ=;
 b=CRSOHY5Jl0pSWMHy5XDNxpevTlgpv7f0LdqzOKPm9CPdKyP6MnE5hHYLfxOzaNMlXz
 CrIRRXvCPsDC9qSJw311sDv1A7G8gEwk+8RpF0pAllHyg7Ly+mex0ykmuRTxMiNFuZ33
 VnvzxOQeIqq3MfMiSfbjJxo6b/RxA5jSq3pg8d2GzcOWb90oEHKEuoqee+JPnNLrrTo7
 HDd5N37KFuoqy9GaF4O4j8Dj7j8pHxPnqomQQIP8Cl7CklQk5Gw1YiUD9+de207a9i6P
 U2XrAVdXQAcQJTI3QKhs9161ATanq4EEL39lAQdhi29u2JttUKjaA3dHcViNFBslGN9E
 z4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uWmWQwA0L9S7G0xTXoXXUZEjeNolpTp1g06yPiJpqMQ=;
 b=X7V3RhlzG4vNrrIkBaPmL2wgQwWUJPCDg7ty12PLfhkdbW2/jGzhicYDDoaFZjvkbm
 D3Zd94nfYqtT+KPdgNzWZLlkSDLTJjTxB7mZ7P0FZeF/P2ugWOzziPz2eW0WgTKNySaw
 fGHY+Sb69re0gn33EWTlkLjPywwEvycDfdlvOHL3HJBx6Qvg1qyls9utyd9s+OJgPf5e
 ykOnKKLwr+GzNRt3E4R/4gsDBvd5grP4xCP6VFEDENKg62Lm5DbYEi22Rh9cXdDVHfSg
 SRTtG/cOGuoweD5dNCqAlXOXvgzT3ab+KcBD9UM5SrI3N/fDJSKT8oK3EhsOQSE7sVsA
 +A/A==
X-Gm-Message-State: APjAAAWGIMp8ad0UCdOgfpVpt8SKWWx74SoazJjs1OeQn7eiyxItmkF/
 0Vwww/Ujql/Iul8CKosNWuVHOlGPmlR9sEym397c1g==
X-Google-Smtp-Source: APXvYqyey+LCWwUIyyveNvZnzArAFvbCod1yfx8ST1R/oWURqruj5ElufBCcJAbrwcntRbUska0lkyOPOQUwst1ycps=
X-Received: by 2002:ac2:4a71:: with SMTP id q17mr5390553lfp.179.1574080772996; 
 Mon, 18 Nov 2019 04:39:32 -0800 (PST)
MIME-Version: 1.0
References: <20191112150105.2498-1-robert.foley@linaro.org>
 <20191112150105.2498-2-robert.foley@linaro.org>
 <f41150bd-81dc-f754-be91-72065b31cae4@linaro.org>
In-Reply-To: <f41150bd-81dc-f754-be91-72065b31cae4@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Mon, 18 Nov 2019 07:39:22 -0500
Message-ID: <CAEyhzFt7PbvWTwTMER4icmOVGu-juCDafcOfT=sbNOBBUyXyCA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] Add a mutex to guarantee single writer to
 qemu_logfile handle.
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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
Cc: Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > +
> > +    g_assert(qemu_logfile_mutex.initialized);
>
> Why the asserts?
>
> If you want a runtime test, then use the test to initialize it.
> Otherwise, trust the constructor.
>
I see your point here.   We can/should just trust the constructor.
Will remove the mutex.initialized asserts.

Thanks,
-Rob

On Sat, 16 Nov 2019 at 06:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/12/19 4:01 PM, Robert Foley wrote:
> > Also added qemu_logfile_init() for initializing the logfile mutex.
> >
> > Signed-off-by: Robert Foley <robert.foley@linaro.org>
> > ---
> > v1
> >     - changed qemu_logfile_init() to use __constructor__.
> > ---
> >  util/log.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/util/log.c b/util/log.c
> > index 1ca13059ee..c25643dc99 100644
> > --- a/util/log.c
> > +++ b/util/log.c
> > @@ -24,8 +24,10 @@
> >  #include "qapi/error.h"
> >  #include "qemu/cutils.h"
> >  #include "trace/control.h"
> > +#include "qemu/thread.h"
> >
> >  static char *logfilename;
> > +static QemuMutex qemu_logfile_mutex;
> >  FILE *qemu_logfile;
> >  int qemu_loglevel;
> >  static int log_append = 0;
> > @@ -49,6 +51,11 @@ int qemu_log(const char *fmt, ...)
> >      return ret;
> >  }
> >
> > +static void __attribute__((__constructor__)) qemu_logfile_init(void)
> > +{
> > +    qemu_mutex_init(&qemu_logfile_mutex);
> > +}
> > +
> >  static bool log_uses_own_buffers;
> >
> >  /* enable or disable low levels log */
> > @@ -58,6 +65,9 @@ void qemu_set_log(int log_flags)
> >  #ifdef CONFIG_TRACE_LOG
> >      qemu_loglevel |= LOG_TRACE;
> >  #endif
> > +
> > +    g_assert(qemu_logfile_mutex.initialized);
>
> Why the asserts?
>
> If you want a runtime test, then use the test to initialize it.
> Otherwise, trust the constructor.
>
>
> r~

