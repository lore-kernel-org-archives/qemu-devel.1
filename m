Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA7DC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:53:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 734412073D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1osDuq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734412073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieLLT-0008MT-Jx
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 10:53:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56816)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ieLKm-0007wo-MR
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:52:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ieLKl-0003Y1-LT
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:52:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31845
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ieLKl-0003Xl-I4
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:52:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575906746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QdYjkpeXCoRWSDHRguJYtY6mM/RlsIQDXjQPo/b6dN8=;
 b=B1osDuq+pHySNrsaQw/LyCUpPqfoxlQQ69dcA5f2P+vjj+AwMLoc28JWUo0Fd1/uU4ZIzH
 +liqsGbn/SfAYJS9MODfYJFGayXUEeeE0lVhju2dCqwTGKOnQw2y6OpS3YkhBFPRPe+H+A
 ZzLeYDuT01akZ1nliYxPuMfuB/2IunE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-iILfwosJPImS_8EOfH8MBg-1; Mon, 09 Dec 2019 10:52:25 -0500
Received: by mail-wm1-f69.google.com with SMTP id o135so3122576wme.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 07:52:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QdYjkpeXCoRWSDHRguJYtY6mM/RlsIQDXjQPo/b6dN8=;
 b=ht1XdXdLg2DwarkxPeILWWl0go7fSnhbqbRmHNsX8bKf7qvULWP5LRvFFVuIjr82ME
 d2zeqAhkWIeyYlUXIF1UwqDTgwIA1AxlXxRRW2JdmBUGr+tO2VUI8Uex40Hlyp3Xh2dA
 lycYYwlhhQj/Po0yIHHm4SxJlI0+Y3nOshdG6nL9/kzzCd7Mi2EC9vpZg5rm9b86+4nG
 5eeUQFKFQ9KmNdOcqGkDYb3UIUX9bhiIF81zKrZ5zTM1vkwdFx0ADUPt701RAA+UxwLV
 EcR/3OKBxs4KdzCl5t8W7drLUetC8dmruHHu+/UHXBuj1Kbd1eMi7abmaW/9zDDpOB0b
 zbqw==
X-Gm-Message-State: APjAAAUc3rmQt40KPIN2K2LGeyDgSh1bCgPTNPG2g0p0/yD0BTjHuLYB
 Ow/VQIqJ/0sqv6ATa4EiAHf9yDHE0Fmoe/rpCUKCuaEuCkS36v0geqrEnqWfmY5NltVZblBBXAm
 di0fOOTQjPRgnR9w=
X-Received: by 2002:a1c:984f:: with SMTP id a76mr24493828wme.64.1575906744388; 
 Mon, 09 Dec 2019 07:52:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqzhI4DQDaBR/PWa9OOS9c6kg1mg/AXx4Np75JW3hQMILaV9bUih1EuOICct5tXi4QeljyhyMA==
X-Received: by 2002:a1c:984f:: with SMTP id a76mr24493813wme.64.1575906744188; 
 Mon, 09 Dec 2019 07:52:24 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id x11sm29413279wre.68.2019.12.09.07.52.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2019 07:52:23 -0800 (PST)
Subject: Re: [PATCH v2 14/18] tcg: add "-accel tcg, tb-size" and deprecate
 "-tb-size"
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
 <1575903705-12925-15-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1383ee6f-7bc6-8e3c-571a-0a85a787b4be@redhat.com>
Date: Mon, 9 Dec 2019 16:52:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575903705-12925-15-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-MC-Unique: iILfwosJPImS_8EOfH8MBg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: thuth@redhat.com, elmarco@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/9/19 4:01 PM, Paolo Bonzini wrote:
> -tb-size fits nicely in the new framework for accelerator-specific options.  It
> is a very niche option, so insta-deprecate it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
[...]
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 65c9473..9775258 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -118,8 +118,9 @@ Select CPU model (@code{-cpu help} for list and additional feature selection)
>   ETEXI
>   
>   DEF("accel", HAS_ARG, QEMU_OPTION_accel,
> -    "-accel [accel=]accelerator[,thread=single|multi]\n"
> +    "-accel [accel=]accelerator[,prop[=value][,...]]\n"

^ This seems from the previous patch, 'convert "-accel threads"'.

>       "                select accelerator (kvm, xen, hax, hvf, whpx or tcg; use 'help' for a list)\n"
> +    "                tb-size=n (TCG translation block cache size)\n"
>       "                thread=single|multi (enable multi-threaded TCG)\n", QEMU_ARCH_ALL)
>   STEXI
>   @item -accel @var{name}[,prop=@var{value}[,...]]
> @@ -129,6 +130,8 @@ kvm, xen, hax, hvf, whpx or tcg can be available. By default, tcg is used. If th
>   more than one accelerator specified, the next one is used if the previous one
>   fails to initialize.
>   @table @option
> +@item tb-size=@var{n}
> +Controls the size (in MiB) of the TCG translation block cache.
>   @item thread=single|multi
>   Controls number of TCG threads. When the TCG is multi-threaded there will be one
>   thread per vCPU therefor taking advantage of additional host cores. The default
[...]


