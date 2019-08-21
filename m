Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ACDC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:58:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEC972339F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="GiPg01eB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEC972339F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0PFX-0003ba-Tg
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 07:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cminyard@mvista.com>) id 1i0P6H-0002tQ-HI
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:48:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cminyard@mvista.com>) id 1i0P65-0005bg-Q4
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:48:19 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45542)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1i0P65-0005Z3-H5
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:48:13 -0400
Received: by mail-ot1-x344.google.com with SMTP id m24so1710820otp.12
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 04:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=AW9Aza1TEvwspyDbs7aPZWP45Hb1BkJSaT00iSk5rnc=;
 b=GiPg01eBdESO299rYhjWIpjUbq4Xpd29s6Adekes/DX/h/arsBWeEoxHNVi79v55Ih
 1KnL6/icq54vZAyyOyu8YvgMJaLz4c9yFh+caWcn7O60lSIknqlAhJsb2wVWXnfdrO9L
 UZnyuOPCSTS0UnYdhpyeKSl0OppVhHfHLmPsght/VXoHqJM/8jGxANCb/BvXeJRM8rPX
 wzICbHNWCMYl9P+ZMv+DbKQ0VB4u4aFjMMkI0zKK2v1ptVOczslDjcyMa0iecHcijc5h
 SRwNzhcCvHqHAoPu+dPfTwmibZnB5AzRzlPYTPTDzOudfDuyIrUGjs87nM8fKKpY+jJK
 XJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=AW9Aza1TEvwspyDbs7aPZWP45Hb1BkJSaT00iSk5rnc=;
 b=DIevz2J0PSLHyZvjasSzHyXfUj+3F0rcURUJSPFVQbxQcTc32IILTfKEtTyYv3i9P5
 ywp1HFxtqRtBonRIFAauXs1PAypLLe83zwDIsPnrWLBtwl1p7N9sLh4DOHNulkviXgXB
 RhCHkJfo5F+rujvNRhSmkZ6SUIpCBeec4WBI7ADQB0wvcRfZ6B9soTU9ppAbR26je5Rs
 7hfEQfGmaPe5bDOUBbdNvmc34/rUqMNbEnT1m+4HQP4cy8/bskNbax6SGy6xHpgXI/jR
 Y76gfzebIpqzwnj+VMQedXP577KJzFspMDUTblUxt8pf9rgbhX2OguI/nmUEwC4J5GPy
 JdyA==
X-Gm-Message-State: APjAAAWwNGKd2BHe5VlsJmqsIJwFbKIy2tJSopwDW1ucyTBUTsRjYW8Z
 B+rWxNzWCVW1m3zWg2J5DYbZhg==
X-Google-Smtp-Source: APXvYqwDtdO58I/k0iMqEil2P+W+x0BKb6ScBD+vA1OBd9B83cgx6sFuLV9qRMDK7xN26KGwn3CcjQ==
X-Received: by 2002:a9d:5e18:: with SMTP id d24mr3948668oti.182.1566388090578; 
 Wed, 21 Aug 2019 04:48:10 -0700 (PDT)
Received: from minyard.net ([47.184.134.43])
 by smtp.gmail.com with ESMTPSA id j6sm7437156otq.16.2019.08.21.04.48.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 21 Aug 2019 04:48:09 -0700 (PDT)
Date: Wed, 21 Aug 2019 06:48:07 -0500
From: Corey Minyard <cminyard@mvista.com>
To: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20190821114807.GT445@minyard.net>
References: <20190821111947.26580-1-laurent@vivier.eu>
 <20190821111947.26580-10-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190821111947.26580-10-laurent@vivier.eu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PULL 09/14] hw/ipmi: Rewrite a fall through
 comment
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
Reply-To: cminyard@mvista.com
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 21, 2019 at 01:19:42PM +0200, Laurent Vivier wrote:
> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> GCC9 is confused by this comment when building with CFLAG
> -Wimplicit-fallthrough=2:
> 
>   hw/ipmi/ipmi_bmc_extern.c: In function ‘addchar’:
>   hw/ipmi/ipmi_bmc_extern.c:178:12: error: this statement may fall through [-Werror=implicit-fallthrough=]
>     178 |         ch |= 0x10;
>         |         ~~~^~~~~~~
>   hw/ipmi/ipmi_bmc_extern.c:181:5: note: here
>     181 |     default:
>         |     ^~~~~~~
>   cc1: all warnings being treated as errors
>   make: *** [rules.mak:69: hw/ipmi/ipmi_bmc_extern.o] Error 1
> 
> Rewrite the comment using 'fall through' which is recognized by
> GCC and static analyzers.

Looks good, thanks.  I've pulled it into my tree, but if you want
to queue it someplace else:

Reviewed-by: Corey Minyard <cminyard@mvista.com>

> 
> Reported-by: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Acked-by: Corey Minyard <cminyard@mvista.com>
> Message-Id: <20190719131425.10835-5-philmd@redhat.com>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  hw/ipmi/ipmi_bmc_extern.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
> index 573428eca1b2..87da9ff99cf5 100644
> --- a/hw/ipmi/ipmi_bmc_extern.c
> +++ b/hw/ipmi/ipmi_bmc_extern.c
> @@ -177,8 +177,7 @@ static void addchar(IPMIBmcExtern *ibe, unsigned char ch)
>          ibe->outbuf[ibe->outlen] = VM_ESCAPE_CHAR;
>          ibe->outlen++;
>          ch |= 0x10;
> -        /* No break */
> -
> +        /* fall through */
>      default:
>          ibe->outbuf[ibe->outlen] = ch;
>          ibe->outlen++;
> -- 
> 2.21.0
> 

