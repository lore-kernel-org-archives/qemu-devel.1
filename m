Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623ECC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:15:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 353AB21019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353AB21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33945 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTlhI-0000gz-Fh
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 07:15:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTlg7-0008Rk-NM
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTlg6-0008CL-42
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:14:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hTlg5-0008Bg-IM
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:14:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id q15so5355080wmj.0
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 04:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=YxoKGsJIzIqMuVih6sr/frL8mW9QYobeMeZCyxl2Fn0=;
	b=U+EJCszuAG66LNJJ/vZBaGkvoRBIfaKfbNV+8tvtGaY1eT/wCx7c5XgqLb2WMBbIUs
	KaPxJU4BHI1JjMWaojf1P/FDmyCGFjhi6dbczZrv77uGezXjE9SQYa+eNTAFBO3n7gsP
	U0VVClS+cevbnnJ+0BKCRylUtuyNf3B6/Y8ZNSGfMkWmsYcvXcU94R+kmKe2leUe26pQ
	Kf7Cn9CIgzzCw/ZBICUGMDOoFs/mRnurwx68mcKqqGL44RXJ4VPiTQRXR+5dYpJ/UVEX
	gUJyaDNUekc9XBl6ZRl0LcJUdUtbvaWl6TjssG0yu5/GGqDvbFcE4KmkwXnLl2DxMzS5
	F4WQ==
X-Gm-Message-State: APjAAAXNkK1MzTVHJ8XiYWhT/qw3LmmF7HtsltIuNQh5Y92hNJoywhfZ
	v7hRtXfdZKYbD7JclN8R+/3l0A==
X-Google-Smtp-Source: APXvYqwpUWTtjwUoB2pgMjGeESNr5+tzDXZMGZGRE96Yrf0d75rV8iZ4Im4u3Yw2oHgjzI3r0m37aw==
X-Received: by 2002:a1c:2dc2:: with SMTP id t185mr11869758wmt.52.1558610068437;
	Thu, 23 May 2019 04:14:28 -0700 (PDT)
Received: from [192.168.1.38] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	p17sm11039563wrq.95.2019.05.23.04.14.27
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 04:14:27 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190523024229.1158-1-richard.henderson@linaro.org>
	<20190523024229.1158-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <aeba8f7d-63b2-b9c0-dfe7-9cd460381fce@redhat.com>
Date: Thu, 23 May 2019 13:14:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523024229.1158-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH 2/3] capstone: Update to master
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 4:42 AM, Richard Henderson wrote:
> Update to fbb20ea83c5a.  Choose this over the 4.0.1 tag because
> master now includes the s390x z13 vector opcodes.

Cool! I was watching few fixed issues on the capstone repo, which are
now fixed in QEMU too :)

Various riscv/arm64 improvement too.

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  capstone  | 2 +-
>  configure | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/capstone b/capstone
> index 22ead3e0bf..fbb20ea83c 160000
> --- a/capstone
> +++ b/capstone
> @@ -1 +1 @@
> -Subproject commit 22ead3e0bfdb87516656453336160e0a37b066bf
> +Subproject commit fbb20ea83c5af4f29b40c17fbadb1f71b0a08fae
> diff --git a/configure b/configure
> index eec7f061c3..a2e4636a34 100755
> --- a/configure
> +++ b/configure
> @@ -5016,6 +5016,7 @@ case "$capstone" in
>        LIBCAPSTONE=libcapstone.a
>      fi
>      LIBS="-L\$(BUILD_DIR)/capstone -lcapstone $LIBS"
> +    capstone_capstone_h=yes
>      ;;
>  
>    system)
> 


