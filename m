Return-Path: <SRS0=nsQZ=2M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E415C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 12:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB7FC20733
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 12:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dEMzmqbh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7FC20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ij0CV-0003XA-UG
	for qemu-devel@archiver.kernel.org; Sun, 22 Dec 2019 07:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ij0B1-0002uy-1h
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 07:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ij0Ax-0002CG-D5
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 07:17:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51331
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ij0Av-000282-4L
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 07:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577017051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=59i9Hvc7KW/B3yTLKwq8h3XAdaOrr4Ixjg+cMlgs2V8=;
 b=dEMzmqbhiuWMPXM1QZ9+OqGBIKbNpIrUMcVjxcuI7jFLff3dwUuEWL/Dsdv9Aba8zgZI4m
 gMsNh9b34xQqIv9cCXtpPd2+SnCGby1uQ9c1CR+Tuuojo/093K8a77gY8g3QGamKnqOUDK
 vEuos0tlM7pz7lpmZmeON5/eONohDVs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-6NxsWqA8NgKdqoqvh3uEDg-1; Sun, 22 Dec 2019 07:17:28 -0500
Received: by mail-wr1-f70.google.com with SMTP id c17so359511wrp.10
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2019 04:17:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=59i9Hvc7KW/B3yTLKwq8h3XAdaOrr4Ixjg+cMlgs2V8=;
 b=IR72PZmq34Rfjghk37yelkUqFluYeRVqrbSjkLS0mTvTNqQfkhAmXYjBfQA5wiB2va
 dZBXJUuWcKJXEdU8YHJisBENtRXumg31ZF6iFEIs4hzwLKPDD8lMDaZ+ooMvCi94Ay80
 2UErgTXAhLov4J7hkTn/hZ9LU2PWF0+kNm0p39bGVPfpxwfwLb/KTGBdliWFeiKxT89Z
 WmHPkg944QrVYDSbk8yvYDLK23EvUkueZzrLtTOE/+fa4DI29ItVgK/0UchrNDPHbQp0
 bpoDuS8rstmgB7hv9BZAnyemWX9lf/O5ApAlOk2oCDgN/1FLKIEXhpUp5tNWXdKsUoOp
 R2yw==
X-Gm-Message-State: APjAAAWORtlhzFykpP22lDSihsc/87ObdCCsk7IqkznyFUMU6xnXVDgE
 jKAqgn6OrDjNe5rvmO9eGVfKciS+r9eWunu0oDaAi2YQYqyLnYmxfGdDqQSesrYNutaXMiIU5zn
 dH1HIHgtgTmSXENc=
X-Received: by 2002:a5d:4085:: with SMTP id o5mr24803314wrp.321.1577017046895; 
 Sun, 22 Dec 2019 04:17:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqzKuf1fAaOnE/jOizhfzxwjdSQz8lw+pQsG4LmFI95e15JERVG4OHKpGOjfnpYhHG6HhIszcw==
X-Received: by 2002:a5d:4085:: with SMTP id o5mr24803290wrp.321.1577017046601; 
 Sun, 22 Dec 2019 04:17:26 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:7009:9cf0:6204:f570?
 ([2001:b07:6468:f312:7009:9cf0:6204:f570])
 by smtp.gmail.com with ESMTPSA id c2sm17038371wrp.46.2019.12.22.04.17.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Dec 2019 04:17:26 -0800 (PST)
Subject: Re: [PATCH] hw/i386/pc: fix regression in parsing vga cmdline
 parameter
To: Peter Wu <peter@lekensteyn.nl>, qemu-devel@nongnu.org
References: <20191221162124.1159291-1-peter@lekensteyn.nl>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8ea4abfe-0154-f22e-c484-97102d8603bf@redhat.com>
Date: Sun, 22 Dec 2019 13:17:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191221162124.1159291-1-peter@lekensteyn.nl>
Content-Language: en-US
X-MC-Unique: 6NxsWqA8NgKdqoqvh3uEDg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>, Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/12/19 17:21, Peter Wu wrote:
> When the 'vga=' parameter is succeeded by another parameter, QEMU 4.2.0
> would refuse to start with a rather cryptic message:
> 
>     $ qemu-system-x86_64 -kernel /boot/vmlinuz-linux -append 'vga=792 quiet'
>     qemu: can't parse 'vga' parameter: Invalid argument
> 
> It was not clear whether this applied to the '-vga std' parameter or the
> '-append' one. Fix the parsing regression and clarify the error.
> 
> Fixes: 133ef074bd ("hw/i386/pc: replace use of strtol with qemu_strtoui in x86_load_linux()")
> Cc: Sergio Lopez <slp@redhat.com>
> Signed-off-by: Peter Wu <peter@lekensteyn.nl>
> ---
> Hi,
> 
> This fixes a regression in QEMU 4.2.0 where my existing scripts would
> fail to boot while it worked fine with QEMU 4.1.1.
> 
> I do wonder whether QEMU has any business in strictly enforcing the
> contents of the kernel command line. Perhaps it should only warn about
> the issue, and not exit? Previously it would silently ignore bad values.
> 
> Kind regards,
> Peter
> ---
>  hw/i386/x86.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 394edc2f72..121650ae51 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -508,6 +508,7 @@ void x86_load_linux(X86MachineState *x86ms,
>      vmode = strstr(kernel_cmdline, "vga=");
>      if (vmode) {
>          unsigned int video_mode;
> +        const char *end;
>          int ret;
>          /* skip "vga=" */
>          vmode += 4;
> @@ -518,10 +519,9 @@ void x86_load_linux(X86MachineState *x86ms,
>          } else if (!strncmp(vmode, "ask", 3)) {
>              video_mode = 0xfffd;
>          } else {
> -            ret = qemu_strtoui(vmode, NULL, 0, &video_mode);
> -            if (ret != 0) {
> -                fprintf(stderr, "qemu: can't parse 'vga' parameter: %s\n",
> -                        strerror(-ret));
> +            ret = qemu_strtoui(vmode, &end, 0, &video_mode);
> +            if (ret != 0 || (*end && *end != ' ')) {
> +                fprintf(stderr, "qemu: invalid 'vga=' kernel parameter.\n");
>                  exit(1);
>              }
>          }
> 

Cc: qemu-stable@nongnu.org

Queued, thanks.


