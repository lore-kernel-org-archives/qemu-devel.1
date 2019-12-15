Return-Path: <SRS0=VgCP=2F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AB6C43603
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 05:09:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79C7A206B7
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 05:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZgdZR6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C7A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igM9g-00027T-Ke
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 00:09:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igM8z-0001d9-2E
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 00:08:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igM8x-0004d0-9C
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 00:08:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38859
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igM8x-0004cM-4r
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 00:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576386514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FDj5lE+gPV4k+YVFT3t1OmQX6ZTeCu+eMij7H6/Od/c=;
 b=RZgdZR6lQ/R3vrVdtm5+HpBMaDEdEjiGe1yG3GT1iBjtBM/289+474KnufDn1ZIZXk5j5t
 4wXJwpwJBkFMaT7xUonqgA8sePFlrGnOPy360YPPXXSObFb9dfPpgZnC3eD9cJX83Q8E4A
 zBCS/NAJC2HfsHO2OT0WzK04OK84mfU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-jdUMgLpTMDiFEizuIdKYAQ-1; Sun, 15 Dec 2019 00:08:31 -0500
Received: by mail-wr1-f72.google.com with SMTP id b13so397574wrx.22
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2019 21:08:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FDj5lE+gPV4k+YVFT3t1OmQX6ZTeCu+eMij7H6/Od/c=;
 b=IQXV/tCBNzQoWWmQ1IGeSV2XVTUtHYWx6OwUxdO9T667RmOq82/5YxMLfyaMT7rIGa
 YBK5ovVkfkFApDNSrT+QNuZqxBng3MnSvui71RMk5lhZg916PZt1XWPpZTzpU36A4wgm
 9x+Rg8UO6opZ3gxXBq9kRzRHIR6LaPVfSTBEejY3PaEHqYXpPoDz6tH9Wnm11nwnxKBv
 KsOGYtwIb6DjCUZ4j6nPjRUYDEfu2hP/m5FyEyaVaUZyYF7uP2VIv/4r3V9LXyFKc/Av
 ZAgFsaWiHgAhSJjkFS8VBX5SjAUrQCaR6XOYIHf7tQDCEoi3SY3oiMvx1S6MusnwF/8v
 0v1Q==
X-Gm-Message-State: APjAAAWBpHiFLOBM2+4C4otPrEE80hqsHVHUzz036dj0J3yqHCG7YkYo
 qQsR+N500MT+JRJbEssSB9FCeGPhmb1swk55C9n4is0ndfjD9TRRXcbNcIHoAz7+/6EXsRIi2xx
 hWaiKhcrU6prqk6Y=
X-Received: by 2002:a5d:6406:: with SMTP id z6mr21396300wru.294.1576386510195; 
 Sat, 14 Dec 2019 21:08:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqzMIuJZ0aZpgSsWFbkbij6ffxcczTodQzZQLZW04UAOms0IJObqMh1uqFO+5S1rKUT2abjEYQ==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr21396279wru.294.1576386509874; 
 Sat, 14 Dec 2019 21:08:29 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id m10sm16532955wrx.19.2019.12.14.21.08.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2019 21:08:29 -0800 (PST)
Subject: Re: [PATCH] ppc: remove excessive logging
To: Joakim Tjernlund <joakim.tjernlund@infinera.com>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc <qemu-ppc@nongnu.org>
References: <20191214121347.17071-1-joakim.tjernlund@infinera.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4a608af2-62a2-3ffb-0c02-8e0ca699d586@redhat.com>
Date: Sun, 15 Dec 2019 06:08:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191214121347.17071-1-joakim.tjernlund@infinera.com>
Content-Language: en-US
X-MC-Unique: jdUMgLpTMDiFEizuIdKYAQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Joakim,

I'm cc'ing the PPC maintainers for you, so they won't miss your patch 
(see 
https://wiki.qemu.org/Contribute/SubmitAPatch#CC_the_relevant_maintainer 
and the output of ./scripts/get_maintainer.pl -f target/ppc/excp_helper.c).

On 12/14/19 1:13 PM, Joakim Tjernlund wrote:
> From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
> 
> ppc logs every type of Invalid instruction. This generates a lot
> of garbage on console when sshd/ssh_keygen executes as
> they try various insn to optimize its performance.
> The invalid operation log is still there so an unknown insn
> will still be logged.
> 
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
> ---
> 
> 	As far as I can see, ppc is the only one emiting thsi
> 	debug msg for Invalid insns.
> 
> target/ppc/excp_helper.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 50b004d00d..45c2fa3ff9 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -326,7 +326,6 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
>               env->spr[SPR_BOOKE_ESR] = ESR_FP;
>               break;
>           case POWERPC_EXCP_INVAL:
> -            LOG_EXCP("Invalid instruction at " TARGET_FMT_lx "\n", env->nip);

I don't think we want to remove a such important log. Since it make 
sense to not disturb the console, maybe we can replace some of the 
LOG_EXCP() calls by qemu_log_mask(LOG_GUEST_ERROR,...) instead?

>               msr |= 0x00080000;
>               env->spr[SPR_BOOKE_ESR] = ESR_PIL;
>               break;
> 


