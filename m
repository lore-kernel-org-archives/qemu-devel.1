Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6163EC43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:41:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC318206A4
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5iqCmCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC318206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJfvO-0008Cb-56
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 12:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJfK5-0008N8-E0
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 12:02:49 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJfK3-0007tD-G0
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 12:02:49 -0400
Received: by mail-wm1-x342.google.com with SMTP id l15so8696683wmh.1
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2020 09:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FSDTJJm0AiY1cJL804Ya2N20+pLbHfwZZl1522+7sqM=;
 b=e5iqCmCoSDIx81UStpCXLYgMzT3btCrLhxtfTHaqhIF46jZ47TSbGwyj3uahNo/fmk
 8G0tomDwD4hLZp3ir/4NZbkKZTRT3qFvn8aGtcnsayAEbSKSSpazEqEtCeij/YXr7ZWY
 FUz/45qxUfNMiaFet7Cpg60QGVntAEw3V2/WueJ1L6H0HaUVoOxbwnNRbRz0GUVLePIP
 UbbvWLeS9OZ4HgYNtNGYCtQkPA0Y374RK7HWwaPK0kTrkBo3R2eDkMq1CvaU67vIHp1n
 AaNNth6MRYUEu/H1GAYRw7GNPzj0Ix1O2vNlyA9KnujskwydxNtpvnRQKwiOCQb9GvRk
 Y4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FSDTJJm0AiY1cJL804Ya2N20+pLbHfwZZl1522+7sqM=;
 b=Na329aZFit3e8OCbRSLcND3NYn4JQ4ExJH+Bav1sLaLGK2F189sQkgGDrlZIhTVrlQ
 umZHt+aNe5LdCT4Rq3NnoTAk/EKHHjRTLivyAokqSjiHTIPMTSwxcZiY8cySy3lmgMza
 puxISfznQMnl6kQQUYSIz6sDsVt8Y9thUkP6KHBr4Fdp7WueOXhRGyTEcf4uoKGXEp++
 Duq6vrWU11sGBbHQqrsQkI2r0NKSBWxvG/8IXTQ4E957SbSwfbavrSJq8EOdhEHI6yAX
 RmOrMfwPORWGqCC3PtbJ4VWRuUgrGCu4RsPZD1Q+dFJBMqiAClmJAf1RhclrIddCEadq
 YRhw==
X-Gm-Message-State: AOAM530s1R6W+RzXHO3lB8rEHLJSlBXv5iE1jN+gvpEdsTVuY3VIJISG
 EiSfhUEvg9PUR5b7YZ6qavM=
X-Google-Smtp-Source: ABdhPJy2pBs8k6Url+zAMul3o2snoC2P+ywFJNDLodCXkaqY+m7mhGMyZsG7zspurYp0C1CN2vINZw==
X-Received: by 2002:a1c:7c17:: with SMTP id x23mr22077798wmc.165.1600531365721; 
 Sat, 19 Sep 2020 09:02:45 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id h8sm11885623wrw.68.2020.09.19.09.02.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Sep 2020 09:02:45 -0700 (PDT)
Subject: Re: [PATCH] configure: fix performance regression due to PIC objects
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200919155639.1045857-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2ae0f4d8-a80e-e682-0752-4051c703046b@amsat.org>
Date: Sat, 19 Sep 2020 18:02:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200919155639.1045857-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Ahmed Karaman <ahmedkrmn@outlook.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Aleksandar as Ahmed is away.

On 9/19/20 5:56 PM, Paolo Bonzini wrote:
> Because most files in QEMU are grouped into static libraries, Meson conservatively
> compiles them with -fPIC.  This is overkill and produces slowdowns up to 20% on
> some TCG tests.
> 
> As a stopgap measure, use the b_staticpic option to limit the slowdown to
> --enable-pie.  https://github.com/mesonbuild/meson/pull/7760 will allow
> us to use b_staticpic=false and let Meson do the right thing.
> 
> Reported-by: Ahmed Karaman <ahmedkrmn@outlook.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configure b/configure
> index 0004c46525..0786144043 100755
> --- a/configure
> +++ b/configure
> @@ -7414,6 +7414,7 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
>          -Dwerror=$(if test "$werror" = yes; then echo true; else echo false; fi) \
>          -Dstrip=$(if test "$strip_opt" = yes; then echo true; else echo false; fi) \
>          -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
> +        -Db_staticpic=$(if test "$pie" = yes; then echo true; else echo false; fi) \
>          -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
>  	-Dmalloc=$malloc -Dmalloc_trim=$malloc_trim -Dsparse=$sparse \
>  	-Dkvm=$kvm -Dhax=$hax -Dwhpx=$whpx -Dhvf=$hvf \
> 


