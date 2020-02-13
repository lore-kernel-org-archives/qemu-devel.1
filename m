Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF29AC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 10:31:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A96A320873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 10:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KiTlNXIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96A320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Bm1-0003dB-TX
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 05:31:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j2Bl8-00035k-NB
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 05:30:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j2Bl7-0001VJ-EJ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 05:30:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58609
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j2Bl7-0001Ua-8a
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 05:30:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581589812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ewfrBWtSttSzc3Zbabts2YochykXbj2SF+6+qFanDJQ=;
 b=KiTlNXIswa/k+13KCx3EY36ViDFP4SjYFNV4I1+CuwSYFd+qebuRLbR+Qcz7ZsCFyNxhBO
 MqFqi/sjG5EoH9V2yH2uWwOru0p/PVqHCWM/dcs0PYonnHFTvGUx+a0XMQUk167dexA4FE
 QIbtfTXc1afGFHyqb0w6WzEb+0TxriA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-PRex88l9MYq9LkRtRPk59g-1; Thu, 13 Feb 2020 05:30:10 -0500
Received: by mail-wr1-f72.google.com with SMTP id o9so2155509wrw.14
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 02:30:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ewfrBWtSttSzc3Zbabts2YochykXbj2SF+6+qFanDJQ=;
 b=LoGXrcVYka7cv0/9/JW8KF28u5/gKoDGn+Q6VpcLapEwlPjjWnjjIYN2EjhfHBbMPI
 YnoKpE/XyxFgUYYY1SJTGAXqlScMZ7dJHrM3IF11vkfeRfpJ9FYXnczo3RMmgGKkpnu/
 Ed4wwHUzkvFst/H19u4IJJgplzH9OrpRmstxDIDjS7SsmViABBTAowJZ68kA+WarSlc/
 y47tUdOen/wgk1dl/tYHKuQvcZMqQw1XE5mB7/NanJ9IwhghTedLyPsASBT/Mw0Ke1AM
 XSniIWhunFy2brIKiWtWpM8VX2ZhYCKiLIu0s7JYKnMLQ1mEIu3tYVkPITXds3UJAEGg
 JlfQ==
X-Gm-Message-State: APjAAAUROFdp5cljMHz4wGDB6KsYwjn5Rht/xRALRt71MujzzLcJWeSt
 yjG243kK7JhjpPusF872Hm02S5qGjBH0kbixvD5FGd2+1L4fciNcbeMje5QBxnmtAj6thtc+GZn
 pxcgkHxPmcqOGLnI=
X-Received: by 2002:adf:cd04:: with SMTP id w4mr22208410wrm.219.1581589809375; 
 Thu, 13 Feb 2020 02:30:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqzSrFeZz80zvqsbD7I04/qgAwepTevEgzAbqgfsZY/mNd8r6ylQv+rnRDzPIbkjXHLP2Aqg8w==
X-Received: by 2002:adf:cd04:: with SMTP id w4mr22208381wrm.219.1581589809066; 
 Thu, 13 Feb 2020 02:30:09 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:48f0:7b10:ad88:6d83?
 ([2001:b07:6468:f312:48f0:7b10:ad88:6d83])
 by smtp.gmail.com with ESMTPSA id a62sm2476231wmh.33.2020.02.13.02.30.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2020 02:30:08 -0800 (PST)
Subject: Re: [PATCH 2/2] util: add util function buffer_zero_avx512()
To: Robert Hoo <robert.hu@linux.intel.com>, qemu-devel@nongnu.org,
 laurent@vivier.eu, philmd@redhat.com, berrange@redhat.com
References: <1581580379-54109-1-git-send-email-robert.hu@linux.intel.com>
 <1581580379-54109-3-git-send-email-robert.hu@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dfc22e0f-79db-25d7-ccd8-26db1353c3b6@redhat.com>
Date: Thu, 13 Feb 2020 11:30:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1581580379-54109-3-git-send-email-robert.hu@linux.intel.com>
Content-Language: en-US
X-MC-Unique: PRex88l9MYq9LkRtRPk59g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: robert.hu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/02/20 08:52, Robert Hoo wrote:
> +
> +}
> +#pragma GCC pop_options
> +#endif
> +
> +
>  /* Note that for test_buffer_is_zero_next_accel, the most preferred
>   * ISA must have the least significant bit.
>   */
> -#define CACHE_AVX2    1
> -#define CACHE_SSE4    2
> -#define CACHE_SSE2    4
> +#define CACHE_AVX512F 1
> +#define CACHE_AVX2    2
> +#define CACHE_SSE4    4
> +#define CACHE_SSE2    6

This should be 8, not 6.

Paolo

>  
>  /* Make sure that these variables are appropriately initialized when
>   * SSE2 is enabled on the compiler command-line, but the compiler is
> @@ -226,6 +268,11 @@ static void init_accel(unsigned cache)
>          fn = buffer_zero_avx2;
>      }
>  #endif
> +#ifdef CONFIG_AVX512F_OPT
> +    if (cache & CACHE_AVX512F) {
> +        fn = buffer_zero_avx512;
> +    }
> +#endif
>      buffer_accel = fn;
>  }
>  
> @@ -255,6 +302,9 @@ static void __attribute__((constructor)) init_cpuid_cache(void)
>              if ((bv & 6) == 6 && (b & bit_AVX2)) {
>                  cache |= CACHE_AVX2;
>              }
> +            if ((bv & 6) == 6 && (b & bit_AVX512F)) {
> +                cache |= CACHE_AVX512F;
> +            }
>          }


