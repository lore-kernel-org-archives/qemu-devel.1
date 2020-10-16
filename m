Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96134C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 08:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E993E2080A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 08:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XPeakHKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E993E2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTKnV-0005rD-Q0
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 04:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTKmu-0005LN-Fu
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 04:08:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26709)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTKms-0002e5-7c
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 04:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602835708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BCSZ17Jh/3+UFfPfRXfK27SAb08/f0XjwW1lT+9+PTc=;
 b=XPeakHKUSPa4UbCN2SS/zNDukbqBd+L1ggmHs0SzrxOTaK17NYK14c9NcvJJT6U7YxLBZj
 0fQjWqtfFeR1ShzCm0bjaD/XOP/xWSBg7dplh81NnRIs0zWBIx1DG08yMWgjJmIife74UM
 3VAkdc3vktwttX9ysTUCb56YVb2aqdo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-BloNhE_eO4eZYX9qlRi63g-1; Fri, 16 Oct 2020 04:08:27 -0400
X-MC-Unique: BloNhE_eO4eZYX9qlRi63g-1
Received: by mail-wm1-f70.google.com with SMTP id u5so290212wme.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 01:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BCSZ17Jh/3+UFfPfRXfK27SAb08/f0XjwW1lT+9+PTc=;
 b=a3QhuOKbGSM+R4pBIGwEcDzhwWqehRH7VA2O+AKaC6tH2RIL3NkyOEfH3UxeK5QdO8
 ho+kIYGmClHYXz8ur9oavChovZNx3otOEL+HRlxgm3OtQWgBwjU77APzRK9a5VtDy4Z5
 ZVIuEZHZdVcwmDVXluwuKjFMu7K58h18kXWtA9LY+sTZqN3YW6ge/x34zogHddizeASn
 pSfctj6aP/6FxgoTNUE+vCqbjFRhOSTKs+rtel2vIkgj0YnS7FOTse49ruQQpW+Gflkq
 O/og+lF+TC23AxMq5ywU97e4MC+qNTEz2Mq07tphsD2ZAmxj9w5dzEJKmCMOViniIVks
 NfEw==
X-Gm-Message-State: AOAM531OmqrVAY199NDO6cGoE7Z1oUqyP1CM3oFE2gKIkpZ42KufobgA
 9imjzBjWtLBloF8SZHFaFQ/UEGkDMq1PsKyf5fuGBUFJiL+aMlTEfOXTSgcBfksKiYUB1OGBZpX
 kzBBM5z1a4lMoRZw=
X-Received: by 2002:a05:600c:d8:: with SMTP id u24mr2478115wmm.2.1602835702978; 
 Fri, 16 Oct 2020 01:08:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLe3hG1tfPoTHkxvSe9Si3UFueQyvgyM0blKAqPyxf9uOU6dYETrbSYXm6n3OIF6Nh4ClyBw==
X-Received: by 2002:a05:600c:d8:: with SMTP id u24mr2478094wmm.2.1602835702733; 
 Fri, 16 Oct 2020 01:08:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4e8a:ee8e:6ed5:4bc3?
 ([2001:b07:6468:f312:4e8a:ee8e:6ed5:4bc3])
 by smtp.gmail.com with ESMTPSA id e25sm2577125wra.71.2020.10.16.01.08.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 01:08:22 -0700 (PDT)
Subject: Re: [PATCH] hax: unbreak accelerator cpu code after cpus.c split
To: Claudio Fontana <cfontana@suse.de>, =?UTF-8?Q?Volker_R=c3=bcmelin?=
 <vr_qemu@t-online.de>
References: <20201016080032.13914-1-cfontana@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <68898e9b-d89d-1a5c-870d-a053eb8ea570@redhat.com>
Date: Fri, 16 Oct 2020 10:08:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201016080032.13914-1-cfontana@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 03:57:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>, haxm-team@intel.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/10/20 10:00, Claudio Fontana wrote:
> during my split of cpus.c, code line
> "current_cpu = cpu"
> was removed by mistake, causing hax to break.
> 
> This commit fixes the situation restoring it.
> 
> Reported-by: Volker Rümelin <vr_qemu@t-online.de>
> Fixes: e92558e4bf8059ce4f0b310afe218802b72766bc
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>  target/i386/hax-cpus.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/i386/hax-cpus.c b/target/i386/hax-cpus.c
> index 99770e590c..f72c85bd49 100644
> --- a/target/i386/hax-cpus.c
> +++ b/target/i386/hax-cpus.c
> @@ -38,6 +38,7 @@ static void *hax_cpu_thread_fn(void *arg)
>      qemu_thread_get_self(cpu->thread);
>  
>      cpu->thread_id = qemu_get_thread_id();
> +    current_cpu = cpu;
>      hax_init_vcpu(cpu);
>      cpu_thread_signal_created(cpu);
>      qemu_guest_random_seed_thread_part2(cpu->random_seed);
> 

Queued, thanks.

Paolo


