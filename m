Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6EDC56201
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 09:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D54F9246A7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 09:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6/39xS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54F9246A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXiDL-0003Q6-Ro
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 05:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXiCM-0002f2-23
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 05:56:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXiCK-0004FL-F0
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 05:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603879011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VmWqhfUdjE1b1F+NtHcflN2U1YXzDlDg+55f/0RKfzM=;
 b=G6/39xS/HI0+FjxQDyAjOWThehj0t+g6UZvXZtah32zyXGkC3YNUbRXbLbp3vtUO7q3Wd4
 HZl8MALoKbmvIe4k3tYmyuJFs+/ez4qRd+xUU+kplzWz1fwPyzokYUs0BlxppWl4d/3A56
 WjIA9V5/ACRouuKjest0nhOTkff97wk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-XVPSd_L1M1iLVn03YuMzpQ-1; Wed, 28 Oct 2020 05:56:49 -0400
X-MC-Unique: XVPSd_L1M1iLVn03YuMzpQ-1
Received: by mail-ej1-f70.google.com with SMTP id d12so1935118ejr.19
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 02:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VmWqhfUdjE1b1F+NtHcflN2U1YXzDlDg+55f/0RKfzM=;
 b=ZU7nXUYiqplnuU6/T5Br24XyzKMuEv+FZkPxI1sbMJmeU1UsJFVZgJT7dy0S2gz6ni
 K213xXBx2Y5RMwdg51pspo/GWwIuJCrB6c1qZa9vCAEYvqFSPxSS+WPVorKIS2j5q0ge
 9R0YUDss1mIXyA/zASTou9kb/Styo6kCmq7xA/f139c8AFqjCThPIAIM/sRloG2HXtX3
 uHB4vHovMR3nnBZBTtB+OAX3IItOyuacB/MOhVIwcwFA4/UZLj2RL6t5ytIW3o0302Xt
 FbFAmGLErL8/922kYznKOvw924VoBcgydDs++6fOEngDUsfOrTQjhMa8yYv0+AkHH0xN
 bn9Q==
X-Gm-Message-State: AOAM5323nZBlsdakjfibs7zOU1mTOemtnnSKX3uI/9rxr2Q9UrDu1YeW
 VbOli67Yby9Gh9RqY+vD26Nv2qi8gPlccM07X2JoaUia9CtTLipX9T/fHYB3Ddts03irlluKhh9
 5Nf9tSql/RQh4CUo=
X-Received: by 2002:aa7:c704:: with SMTP id i4mr1049085edq.51.1603879007579;
 Wed, 28 Oct 2020 02:56:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyR/i+MBh3XeFcPndAalgCgvJeDxpjOBl1Vrgn5ZFKaJ6yE0slhYP8muPoz4q1H0k7NYR/WVw==
X-Received: by 2002:aa7:c704:: with SMTP id i4mr1049064edq.51.1603879007392;
 Wed, 28 Oct 2020 02:56:47 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id g23sm2566746edp.33.2020.10.28.02.56.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 02:56:46 -0700 (PDT)
Subject: Re: [PATCH 8/9] target/ppc: silence the compiler warnings
To: Chen Qun <kuhn.chenqun@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20201028041819.2169003-1-kuhn.chenqun@huawei.com>
 <20201028041819.2169003-9-kuhn.chenqun@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <77fb89c5-daa2-0039-bdba-cce0f9895195@redhat.com>
Date: Wed, 28 Oct 2020 10:56:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201028041819.2169003-9-kuhn.chenqun@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Euler Robot <euler.robot@huawei.com>, zhang.zhanghailiang@huawei.com,
 ganqixin@huawei.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/28/20 5:18 AM, Chen Qun wrote:
> When using -Wimplicit-fallthrough in our CFLAGS, the compiler showed warning:
> target/ppc/mmu_helper.c: In function ‘dump_mmu’:
> target/ppc/mmu_helper.c:1351:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>  1351 |         if (ppc64_v3_radix(env_archcpu(env))) {
>       |            ^
> target/ppc/mmu_helper.c:1358:5: note: here
>  1358 |     default:
>       |     ^~~~~~~
> 
> Add the corresponding "fall through" comment to fix it.
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Cc: David Gibson <david@gibson.dropbear.id.au>
> ---
>  target/ppc/mmu_helper.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index 8972714775..51749b62df 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -1355,6 +1355,7 @@ void dump_mmu(CPUPPCState *env)
>              break;
>          }
>  #endif
> +        /* fall through */

I'm surprise the compiler emit a warning for missing comment,
but don't emit one for superfluous and confusing ones (when
building a ppc32-only target). You'd need to put this before
the #endif.

But instead of this band-aid to silent warning, replace the
TODO by a LOG_UNIMP call, and add a break before the #endif.

>      default:
>          qemu_log_mask(LOG_UNIMP, "%s: unimplemented\n", __func__);
>      }
> 


