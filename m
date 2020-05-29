Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111A6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 10:24:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04E12074B
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 10:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JVjQFthF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04E12074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jecBy-0008VU-0p
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 06:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jecBN-0007li-3J
 for qemu-devel@nongnu.org; Fri, 29 May 2020 06:24:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32758
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jecBL-0000Iy-Pq
 for qemu-devel@nongnu.org; Fri, 29 May 2020 06:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590747846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pxDBHAtntdYo3/I5jF5RO1+05QKmLkITNesr/lf56qc=;
 b=JVjQFthF7L976DwuWQQo10+LD36qNmoYtUC7pWtdS/qOXBQgOoTdc8A/ZIrcLjJl1Ps2hs
 3ezu/2bpTIM8hEIz5fkWfuXOA+B7zpUeJqsZy5jiQok1gwFyVuKlwsmCuMx1+tjj0vQdwN
 YRTnc84PZSKolxjxxX4M2v337UIGHJ4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120--pUeCN0APCCcXUi86aYoyQ-1; Fri, 29 May 2020 06:24:03 -0400
X-MC-Unique: -pUeCN0APCCcXUi86aYoyQ-1
Received: by mail-wm1-f70.google.com with SMTP id y202so470638wmd.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 03:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pxDBHAtntdYo3/I5jF5RO1+05QKmLkITNesr/lf56qc=;
 b=VeKho+1OWFQwQnZNY2Cy0hShbiNiOA/0vMytp+MmaBTuMoLg2fAtgerpbjKqgjkkeB
 Hkkbw31zMWE6KYCa07BI9VnODDT4S+EqLINzCpfh+YXzCDNBWYY9yKio+tKmqrwf7LH5
 nuqcAKR18hR8dKhtGHkyRgC3000e/KVe+CKX5ZGUmyThyUkfd+54NxnglS+IkBRlhVjv
 KOxnHD9i48VDsgnLlwxgLm3ajVR0wTNnO0VRmMaxODkR+Ka1gddF/0ak4Lqlhn7r0U6C
 tRGD5tB47/NWnClMm3U+eqMM8xE2WTk4ClS+snYRf1YRSYK0yYqhvsNVV85VPAEQxnTM
 1c3A==
X-Gm-Message-State: AOAM5317r0NbeTJlM0SF/8uTIov2oS1bsHveLQ/yER65ZrKXdAPn4sON
 HRKtwaZVoOYRJnO+AmYQC5Jc4/nsPGhgWoXrh4U+Nj/Zqm1ibPhFjh2B4xES7PKIozvO+wDUaxt
 EQ5WeFa+vsGavIN0=
X-Received: by 2002:a1c:df57:: with SMTP id w84mr8387059wmg.52.1590747842081; 
 Fri, 29 May 2020 03:24:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTJlbT0P7UibD2L2+OQYbTMuMmZmH8apUHkw6a/gvcox+qHPjE6vge9qVAIxlOiHSEMqBYiQ==
X-Received: by 2002:a1c:df57:: with SMTP id w84mr8387030wmg.52.1590747841776; 
 Fri, 29 May 2020 03:24:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b096:1b7:7695:e4f7?
 ([2001:b07:6468:f312:b096:1b7:7695:e4f7])
 by smtp.gmail.com with ESMTPSA id e6sm3010301wrx.80.2020.05.29.03.24.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2020 03:24:00 -0700 (PDT)
Subject: Re: [Qemu-devel PATCH] target/i386: define a new MSR based feature
 word - FEAT_PERF_CAPABILITIES
To: Like Xu <like.xu@linux.intel.com>
References: <20200529074347.124619-1-like.xu@linux.intel.com>
 <20200529074347.124619-5-like.xu@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1aa68600-e48d-fa83-b2e2-b070a486afd4@redhat.com>
Date: Fri, 29 May 2020 12:23:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200529074347.124619-5-like.xu@linux.intel.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 23:43:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Wanpeng Li <wanpengli@tencent.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>, qemu-devel@nongnu.org,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Jim Mattson <jmattson@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/05/20 09:43, Like Xu wrote:
> +        if (!cpu->enable_pmu) {
> +            *ecx &= ~CPUID_EXT_PDCM;
> +        }
>          break;
>      case 2:
>          /* cache info: needed for Pentium Pro compatibility */
> @@ -6505,6 +6528,12 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>          }
>      }
>  
> +    if (kvm_enabled() && cpu->enable_pmu &&
> +        (kvm_arch_get_supported_cpuid(kvm_state, 1, 0, R_ECX) &
> +         CPUID_EXT_PDCM)) {
> +        env->features[FEAT_1_ECX] |= CPUID_EXT_PDCM;
> +    }
> +

I'm dropping this hunk two hunks because it's going to break live
migration with e.g. "-cpu IvyBridge,pmu=on".  We will have to add PDCM
by default only to future CPU models, but "-cpu host,pmu=on" will pick
it up automatically.

Paolo


