Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7B0C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 08:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB249206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 08:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hP46o934"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB249206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijJGV-0007Yv-3C
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 03:40:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ijJFe-0006zK-0W
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 03:39:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ijJFb-0000l8-Fq
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 03:39:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51139
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ijJFb-0000dL-B7
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 03:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577090377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G2rnv9yKhwVaUv3tAS0Tb9fA2sI/sbMHrjOieIL7y5s=;
 b=hP46o934m4bIhEU+/H5NXF/wEDkTuKVEKgyMWvzYpzkOlkgwTVMlB1RZcu7EFTPLi/NuCl
 1UbRDUXHdCDL06+XwaZ5UEyWzyLU4/lV3OsGEejpzmJIl3VjegCaYJuYnJN5urKJlrxJRo
 2vKnkiJlo1wetfCS56DZV1T/fsdMpY4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-IYhsdY6HMeuUJtKIBNkUJg-1; Mon, 23 Dec 2019 03:39:36 -0500
Received: by mail-wm1-f69.google.com with SMTP id p5so2158229wmc.4
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 00:39:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G2rnv9yKhwVaUv3tAS0Tb9fA2sI/sbMHrjOieIL7y5s=;
 b=cWeHppIIysPX4qyLUxqm/4iB2Lf6AgXVdKJakeSmOQugBMneSb5xa0+aHvX+VdpqzD
 6m2SZ5lfZvnBa30GUcEcGCLr5qk3WmaUM3PVvXFOoQsmUnY+MGGHdmBuLzACIMUZTpAA
 MBo70onFQystMUOHvW+o9mBBQEKGfdXw7DGfW6ro+RJ0DyoC0bOBk1HUEheKA02Ljqnv
 HdN5h8AZTQuT4AsEG/2s/Krv1kkqYwHGypkfj47/Era1czwbB7vy3jBPcL0RiFXUtyHQ
 +OfNmHxREdmtKtkRWois7gnlYuYp4vDYVwcqm0W/FDNmMoiZ/yM6wdWmXb/I6NKJG7+x
 RqDw==
X-Gm-Message-State: APjAAAXf8ni+W7my+Ty9+DWf8K7yWM01yCrfTthC0niqTOL9IfBt40e8
 lLs554zv9s3Svsbd+DsmkLvOegF9sYyJKYaPiBL6lj2p1THJ//K51dCkPeA+xZwpUw/0RS9w5Vs
 TikXjSnkASzbHzgo=
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr29838971wmj.96.1577090375326; 
 Mon, 23 Dec 2019 00:39:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqx7vznAFw8WNXqjo2JJBjpop74SpRR2gEss0uaWcuwVcCrNvWpL3aJd3ojoSp1EYG9VmJUSPA==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr29838952wmj.96.1577090375015; 
 Mon, 23 Dec 2019 00:39:35 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ac09:bce1:1c26:264c?
 ([2001:b07:6468:f312:ac09:bce1:1c26:264c])
 by smtp.gmail.com with ESMTPSA id a1sm19518267wrr.80.2019.12.23.00.39.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Dec 2019 00:39:34 -0800 (PST)
Subject: Re: [PATCH] iotests: fix usage -machine accel= together with -accel
 option
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191223074329.21262-1-vsementsov@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8900f0c8-19ce-2475-01c6-150394d516f0@redhat.com>
Date: Mon, 23 Dec 2019 09:39:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191223074329.21262-1-vsementsov@virtuozzo.com>
Content-Language: en-US
X-MC-Unique: IYhsdY6HMeuUJtKIBNkUJg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/12/19 08:43, Vladimir Sementsov-Ogievskiy wrote:
> diff --git a/vl.c b/vl.c
> index 86474a55c9..9fb859969c 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2779,7 +2779,7 @@ static void configure_accelerators(const char *progname)
>          for (tmp = accel_list; !accel_initialised && tmp && *tmp; tmp++) {
>              /*
>               * Filter invalid accelerators here, to prevent obscenities
> -             * such as "-machine accel=tcg,,thread=single".
> +             * such as "-machine accel=tcg,thread=single".

The double comma is intentional.  Without the "if" below, the comma
would be escaped and parsed as "-accel tcg,thread=single".

>               */
>              if (accel_find(*tmp)) {
>                  qemu_opts_parse_noisily(qemu_find_opts("accel"), *tmp, true);
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index 90970b0549..2890785a10 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -587,13 +587,13 @@ export QEMU_PROG="$(type -p "$QEMU_PROG")"
>  
>  case "$QEMU_PROG" in
>      *qemu-system-arm|*qemu-system-aarch64)
> -        export QEMU_OPTIONS="-nodefaults -display none -machine virt,accel=qtest"
> +        export QEMU_OPTIONS="-nodefaults -display none -machine virt -accel qtest"
>          ;;
>      *qemu-system-tricore)
> -        export QEMU_OPTIONS="-nodefaults -display none -machine tricore_testboard,accel=qtest"
> +        export QEMU_OPTIONS="-nodefaults -display none -machine tricore_testboard -accel qtest"
>          ;;
>      *)
> -        export QEMU_OPTIONS="-nodefaults -display none -machine accel=qtest"
> +        export QEMU_OPTIONS="-nodefaults -display none -accel qtest"
>          ;;
>  esac
>  
> 

This part is good, but what is the reproducer?

Paolo


