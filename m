Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A30C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91AA12067D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0m+3LSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AA12067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdeO-0006Q2-RG
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqdcd-0003O9-39
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:21:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50377
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqdcb-0001UR-Br
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593613316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SJmnnOG9GG3BCeo8BnGqxBYs797f1abmxEEKMrx26C0=;
 b=O0m+3LSbKq5uo8UWyw6zyDxX2baJkqUb5yWZnV2Vuq/5zqU4KNKX8GEymmpbbHsVMzXHF8
 ZRPc9SGfmGEbrUDuJl+i1DQlmjBu0Rz4PaDriqq2DPsU+tC5ufGO4BHlW3A94H8WOa5PtX
 yN965XsiL8faxLRr+iuCLrrOOqx8qHU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-nrnstg4RPJunhRN-WCSuCg-1; Wed, 01 Jul 2020 10:21:54 -0400
X-MC-Unique: nrnstg4RPJunhRN-WCSuCg-1
Received: by mail-wr1-f70.google.com with SMTP id s16so7819311wrv.1
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 07:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SJmnnOG9GG3BCeo8BnGqxBYs797f1abmxEEKMrx26C0=;
 b=e30ditEmOj0lpekhEBfCLhPTB6iYUPS8WE3KQ12lc8uOvD4lLzveNlK48IhpY4s9N0
 BIU+9q+aYTpdOgQdfvSd6Kq5hgL3MywdQeo99KRxN2sZQbrKRg0wqsahe6b4PTaRGWdf
 hS4fm/D1wUBaEBW7r13jNFXCgq7mmmdDEULeBHdwCVoKpnYoqHxzJgT/yMrivPA/gGaS
 rV8i6YrX6L3Twb3JDxBkqfM+anYdh5kaEoVIFCBfn7+Y5r/8NqA4WO9ZlNet/BFnZvdc
 yTlxrNPpkGpPkIyhQ3cxTfBdjVoqLnIDdhxlFirzQOb4jyhQmRj8OI9hgSO5SATjKpTD
 dObA==
X-Gm-Message-State: AOAM533hIF03Tz4zC8mh93BM797gLGLY5Ia5bap3LxxBpHK/oig8SUBA
 jWfA4nbf2u5aRmCPoQVn6T0xjYo5MNl00/gfaywu2UZn4J6XClffZvDl26DY7Qjpm3Q2srIQYr3
 zbUWBW7Co5czdHUQ=
X-Received: by 2002:adf:9bc1:: with SMTP id e1mr26919750wrc.253.1593613313348; 
 Wed, 01 Jul 2020 07:21:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxauVoKZf0WWTPGJsQhoVmG3PCnLF1aG+240I7UEfPiIbG/+z6/m5YTrLEyoACxFleS5M6lQ==
X-Received: by 2002:adf:9bc1:: with SMTP id e1mr26919727wrc.253.1593613313065; 
 Wed, 01 Jul 2020 07:21:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1142:70d6:6b9b:3cd1?
 ([2001:b07:6468:f312:1142:70d6:6b9b:3cd1])
 by smtp.gmail.com with ESMTPSA id k126sm7826976wme.17.2020.07.01.07.21.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 07:21:52 -0700 (PDT)
Subject: Re: [PATCH] target/i386: Correct the warning message of Intel PT
To: Luwei Kang <luwei.kang@intel.com>, qemu-devel@nongnu.org
References: <1593499113-4768-1-git-send-email-luwei.kang@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4292eab0-9a6b-80f8-2b90-4e2d9c4214a4@redhat.com>
Date: Wed, 1 Jul 2020 16:21:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1593499113-4768-1-git-send-email-luwei.kang@intel.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 00:56:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/06/20 08:38, Luwei Kang wrote:
> The CPUID level need to be set to 0x14 manually on old
> machine-type if Intel PT is enabled in guest. E.g. the
> CPUID[0].EAX(level)=7 and CPUID[7].EBX[25](intel-pt)=1 when the
> Qemu with "-machine pc-i440fx-3.1 -cpu qemu64,+intel-pt" parameter.
> 
> This patch corrects the warning message of the previous
> submission(ddc2fc9).
> 
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> ---
>  target/i386/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 90ffc5f..a0e39d1 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6375,7 +6375,7 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>              } else if (cpu->env.cpuid_min_level < 0x14) {
>                  mark_unavailable_features(cpu, FEAT_7_0_EBX,
>                      CPUID_7_0_EBX_INTEL_PT,
> -                    "Intel PT need CPUID leaf 0x14, please set by \"-cpu ...,+intel-pt,level=0x14\"");
> +                    "Intel PT need CPUID leaf 0x14, please set by \"-cpu ...,+intel-pt,min-level=0x14\"");
>              }
>          }
>  
> 

Queued, thanks.

Paolo


