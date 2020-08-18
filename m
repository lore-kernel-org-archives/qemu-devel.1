Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5029C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 07:46:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B4AC20738
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 07:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHAKXkJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4AC20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7wJt-0002PM-MV
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 03:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7wJ5-0001tQ-Jp
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 03:45:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57177
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7wJ3-0005BX-Od
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 03:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597736716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2PqBaPuwJf61r6oLWBInNe+mCCc/GyU3FRWXrUxRSzA=;
 b=hHAKXkJ0iOiugqD1wbNapPGNU/54HfsiqIR8nzCW50zju2lsx+BLawyH7bDIu50QAmoc0R
 4AuztfDG9vNl1O+ikPHxbn/ifgLW5UD+IQwfT4lXXjf3OU0Wq+YCtCJzZSZ6EDrZmifYEU
 KFU3baGSPgKs9/Rj9mB3rd4TlE3Zf94=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-NsLXgjDCPU-LLWU_g3l8yA-1; Tue, 18 Aug 2020 03:45:14 -0400
X-MC-Unique: NsLXgjDCPU-LLWU_g3l8yA-1
Received: by mail-wr1-f71.google.com with SMTP id t3so7907568wrr.5
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 00:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2PqBaPuwJf61r6oLWBInNe+mCCc/GyU3FRWXrUxRSzA=;
 b=IG+kiIklGv2Srb8h1yrJFWME/srXEADhcZqTx8yYxabUd1iSpgCFq33P49sZbXF53i
 eIkPx4dSbnaqo2KvR+EfSNSOtknWFyaY+DdTMQReOHyP8SYo1hLYzdsCDHehynp3D59Q
 yKf2svE7YC0WSA5wP5/cuuQYe4aRDhUd9UYr6FC9ZJDAccb5dwzdua8GkURODmDtQXVO
 2BDq3g1jOjTO9FtFg5Dmk09iPnyIdvt3wTVlC1tk9UR/B251+QPUoljDwpVoM4d8Fba2
 wKfqD/fgf5Lv923Ja021DM0a7HlLt9aCww6HsHTCbE6RrnN+XBGHeClP5xmitdMH+VEh
 VPpQ==
X-Gm-Message-State: AOAM531Nsf8VjS8WR+QsD4IMLKTlBxDmEv5Eqo/bO1NRzU4RqkXff5Ng
 WFb77zFHCWiCm4qtCHjhOnbN7qaNqRpO7uXZCZH5WK7k2buhaCxorn2ebR3yejmRukMG012qrfb
 BOENKDT3rhwB37cU=
X-Received: by 2002:a1c:4944:: with SMTP id w65mr17543571wma.169.1597736713227; 
 Tue, 18 Aug 2020 00:45:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+KHVNkHy0fPJENnNQnOKs0RjzubNvP7uN5nyBAGHbdqyGQI2SpWxGF9gjheNpSPRIH85PUQ==
X-Received: by 2002:a1c:4944:: with SMTP id w65mr17543552wma.169.1597736713001; 
 Tue, 18 Aug 2020 00:45:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0d1:fc42:c610:f977?
 ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id i9sm32191721wmb.11.2020.08.18.00.45.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 00:45:12 -0700 (PDT)
Subject: Re: [PATCH 1/2] i386/cpu: Clear FEAT_XSAVE_COMP_{LO, HI} when XSAVE is
 not available
To: Xiaoyao Li <xiaoyao.li@intel.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20200716082019.215316-1-xiaoyao.li@intel.com>
 <20200716082019.215316-2-xiaoyao.li@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bb5ea8b1-2c2e-f3e3-fcc6-24000c7371d1@redhat.com>
Date: Tue, 18 Aug 2020 09:45:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200716082019.215316-2-xiaoyao.li@intel.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:19:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/07/20 10:20, Xiaoyao Li wrote:
> Per Intel SDM vol 1, 13.2, if CPUID.1:ECX.XSAVE[bit 26] is 0, the
> processor provides no further enumeration through CPUID function 0DH.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1e5123251d74..f5f11603e805 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6261,6 +6261,8 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
>      uint64_t mask;
>  
>      if (!(env->features[FEAT_1_ECX] & CPUID_EXT_XSAVE)) {
> +        env->features[FEAT_XSAVE_COMP_LO] = 0;
> +        env->features[FEAT_XSAVE_COMP_HI] = 0;
>          return;
>      }
>  
> 

Queued this patch, noting in the commit message that it affects "-cpu
host,-xsave".

Paolo


