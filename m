Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7008DC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F21120674
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="APE2wxb6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F21120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaj0s-0004Iw-Ex
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jaivV-0004fr-5s
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:47:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27062
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jaivU-0000KI-6j
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589820459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7hu2OrWEkpCcHuLIQYpCrRUkBwj9k8R71kfsTDwCgsc=;
 b=APE2wxb6i8GR6dD3oC1wN81VptOpl3gVZ7t0onqBRk/vO/Q4NBmvWR83rVJI1ls/T3Ok4t
 gNkRtaGJvxswexmGRYQP0JKdO4Prcx2bSQ5HymNPHOC9NMCzJQkL5v+Aa5XMfFnO7JTM0G
 /EO1qreV7C3Be0QPCjZNi9rj8iHDjVE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-Ibn4uURBMiahksaQqHtplw-1; Mon, 18 May 2020 12:47:37 -0400
X-MC-Unique: Ibn4uURBMiahksaQqHtplw-1
Received: by mail-wr1-f72.google.com with SMTP id p8so5906914wrj.5
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 09:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7hu2OrWEkpCcHuLIQYpCrRUkBwj9k8R71kfsTDwCgsc=;
 b=GNRLxL5knx8LjtAL6ua1HRvoG5VqWvCV7Gx8BwFmA/+WSpEBnjRejhpSrFE/f+CW8r
 E3MwNx7yIQRxePkRmL0gpbN3MutnZwMFXu8Bpt6nmLPQ5pwkM6pLzuSslHZSoB61FwGJ
 NzepGgQbaQlBFglvpHAvKUdsbpBqqkX04dYvXTaT1eBorNm/D+Mfn5WvYFuiyDzpinIL
 1atsSE8LrjncVWamtgfT0u8BCo9KvnB6LyV2R9elwd3GEvH2Xft7QP4V4hjjWWhYVExE
 K5vKLqb22gworAEggWZc5Lxugg2Ybr0he0OJ3XocnXkLtymyEeb4tEqTkpcBT/llJ74L
 lC2g==
X-Gm-Message-State: AOAM532bubE4z3pKdyxPeSybe2qNsR/WYVMAwh8A4tyKYDNRvqB5nSqg
 TqxNbWxGe9K5arAn9gjXi45nPA2+2NhxF95WHsMYEt0DkFBjRh1ayRcIyqar+7NQ6lR9hUM0bQa
 nZq/Z8Y/Sh5KGXBE=
X-Received: by 2002:a1c:5f08:: with SMTP id t8mr245811wmb.67.1589820456641;
 Mon, 18 May 2020 09:47:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwq9/kUn13rWPslHK9LyiBmE08GQFRYudHvwcI+PZd2+DcWX2iHY7I4ynNIe1PdXIYhKHgT4A==
X-Received: by 2002:a1c:5f08:: with SMTP id t8mr245793wmb.67.1589820456431;
 Mon, 18 May 2020 09:47:36 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id x5sm18054936wro.12.2020.05.18.09.47.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 09:47:35 -0700 (PDT)
Subject: Re: [PATCH 4/8] decodetree: Split out MultiPattern from
 IncMultiPattern
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200518164052.18689-1-richard.henderson@linaro.org>
 <20200518164052.18689-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8ee7fda0-2b7b-ed38-b50d-1c83bbda952b@redhat.com>
Date: Mon, 18 May 2020 18:47:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200518164052.18689-5-richard.henderson@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:51:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 6:40 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   scripts/decodetree.py | 37 ++++++++++++++++++++++++++-----------
>   1 file changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> index 7af6b3056d..ea313bcdea 100755
> --- a/scripts/decodetree.py
> +++ b/scripts/decodetree.py
> @@ -371,7 +371,32 @@ class Pattern(General):
>   # end Pattern
>   
>   
> -class IncMultiPattern(General):
> +class MultiPattern(General):
> +    """Class representing a set of instruction patterns"""
> +
> +    def __init__(self, lineno, pats):
> +        self.file = input_file
> +        self.lineno = lineno
> +        self.pats = pats
> +        self.base = None
> +        self.fixedbits = 0
> +        self.fixedmask = 0
> +        self.undefmask = 0
> +        self.width = None
> +
> +    def __str__(self):
> +        r = 'group'
> +        if self.fixedbits is not None:
> +            r += ' ' + str_match_bits(self.fixedbits, self.fixedmask)
> +        return r
> +
> +    def output_decl(self):
> +        for p in self.pats:
> +            p.output_decl()
> +# end MultiPattern
> +
> +
> +class IncMultiPattern(MultiPattern):
>       """Class representing an overlapping set of instruction patterns"""
>   
>       def __init__(self, lineno, pats, fixb, fixm, udfm, w):
> @@ -384,16 +409,6 @@ class IncMultiPattern(General):
>           self.undefmask = udfm
>           self.width = w
>   
> -    def __str__(self):
> -        r = "{"
> -        for p in self.pats:
> -           r = r + ' ' + str(p)
> -        return r + "}"
> -
> -    def output_decl(self):
> -        for p in self.pats:
> -            p.output_decl()
> -
>       def output_code(self, i, extracted, outerbits, outermask):
>           global translate_prefix
>           ind = str_indent(i)
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


