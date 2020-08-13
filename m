Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0ECDC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6940A20771
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PcHRyc/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6940A20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Ahp-0007Wz-Np
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 06:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k6Agu-0006sB-Uw
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 06:42:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35954
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k6Agr-000879-GJ
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 06:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597315349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gxlDasVghYbwKFLuepg+JPTEz1tT6/aO0i5RF/f86XI=;
 b=PcHRyc/M0oQhV4WsBok0po61nqfvvIeXC4fl6dJkCUaK/sVJAdy3kcWiqunOEq1YQjorG7
 ygDjAdaDWRworK1761qLKdrMI3aHNGQBNyhpBoOIOd+KaE8Ikw7k+yq/kvstGkcbUgHIn9
 u8esbP1Qeb4NlSkkuaiXqtncFEIFA5A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-E6z5WD2dODyoX7ZfJ3ePzQ-1; Thu, 13 Aug 2020 06:42:27 -0400
X-MC-Unique: E6z5WD2dODyoX7ZfJ3ePzQ-1
Received: by mail-wm1-f69.google.com with SMTP id h6so1812444wml.8
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 03:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=gxlDasVghYbwKFLuepg+JPTEz1tT6/aO0i5RF/f86XI=;
 b=uWdg8KxSS22FdjNERCfx5PG/Bw5hW5tzuKYHBpuiw7gK243xSIRRRIi6LTZHMULgzE
 VdrIRkSD/WlRiWPOz0upp3p9w6BvJWz3BqjB02qFRSfZq3GlpI69g5yFKwyRQXl32nIg
 FhXtL6Bdh9/Vyznqu3jVvkrEfb9LDEo9y1eGdKmZfVTAKp3v73DPQcLQKfPISWtATw7J
 qDufgp3zzOqJpIWRvpko0u/Lk2oCXMqW30xj/GLJli/CNVdfC//6hKNJwLSTcphg2rOu
 5/2oYiYn7wX2HrMzIJoKu+4iA1tillEhT0McIo5BBJFKy1FVX5s39OPS/a2A1iMHhWg4
 PQaA==
X-Gm-Message-State: AOAM530IkifLIyTPYpjKgX7/X79/Sbx3lHKocM3ncEe3yAtiyU9MoPQ8
 xkZ70WsOdrStUn9bnubJj6XVjQYXnKC6VopdxZ900c1dsjOl8ozqNz+CRAOWAVlRotSXEp+VCTS
 0Je+I1p8PwOT0vPI=
X-Received: by 2002:adf:ca06:: with SMTP id o6mr3327216wrh.181.1597315346330; 
 Thu, 13 Aug 2020 03:42:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvHOJ4nNKWb4n1r+cRDiAds7fLbLKAx6i7xGw08iJBrR58yhEZGQFGQ1bAId8FCsGvYcyXHA==
X-Received: by 2002:adf:ca06:: with SMTP id o6mr3327191wrh.181.1597315346038; 
 Thu, 13 Aug 2020 03:42:26 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id e16sm9599778wrx.30.2020.08.13.03.42.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2020 03:42:25 -0700 (PDT)
Subject: Re: [RFC 1/9] target/arm: convert isar regs to array
To: Peng Liang <liangpeng10@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200813102657.2588720-1-liangpeng10@huawei.com>
 <20200813102657.2588720-2-liangpeng10@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <6151cd0a-b3ff-ae68-e843-c6b294b846a8@redhat.com>
Date: Thu, 13 Aug 2020 12:42:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200813102657.2588720-2-liangpeng10@huawei.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 02:03:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, drjones@redhat.com,
 zhang.zhanghailiang@huawei.com, mst@redhat.com, cohuck@redhat.com,
 xiexiangyou@huawei.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/20 12:26 PM, Peng Liang wrote:
> The isar in ARMCPU is a struct, each field of which represents an ID
> register.  It's not convenient for us to support CPU feature in AArch64.
> So let's change it to an array first and add an enum as the index of the
> array for convenience.  Since we will never access high 32-bits of ID
> registers in AArch32, it's harmless to change the ID registers in
> AArch32 to 64-bits.
> 
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Peng Liang <liangpeng10@huawei.com>
> ---
>  hw/intc/armv7m_nvic.c  |  48 ++++----
>  target/arm/cpu.c       | 232 +++++++++++++++++++-------------------
>  target/arm/cpu.h       | 226 +++++++++++++++++++------------------
>  target/arm/cpu64.c     | 170 ++++++++++++++--------------
>  target/arm/cpu_tcg.c   | 250 +++++++++++++++++++++--------------------
>  target/arm/helper.c    |  54 ++++-----
>  target/arm/internals.h |  15 +--
>  target/arm/kvm64.c     |  72 ++++++------
>  8 files changed, 541 insertions(+), 526 deletions(-)

Please consider using scripts/git.orderfile.

[...]
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 9e8ed423ea..5d8074d03b 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -67,6 +67,37 @@
>  #define ARMV7M_EXCP_PENDSV  14
>  #define ARMV7M_EXCP_SYSTICK 15
>  
> +typedef enum CPUIDReg {
> +    MIDR_EL1,
> +    ID_ISAR0,
> +    ID_ISAR1,
> +    ID_ISAR2,
> +    ID_ISAR3,
> +    ID_ISAR4,
> +    ID_ISAR5,
> +    ID_ISAR6,
> +    ID_MMFR0,
> +    ID_MMFR1,
> +    ID_MMFR2,
> +    ID_MMFR3,
> +    ID_MMFR4,
> +    ID_AA64ISAR0,
> +    ID_AA64ISAR1,
> +    ID_AA64PFR0,
> +    ID_AA64PFR1,
> +    ID_AA64MMFR0,
> +    ID_AA64MMFR1,
> +    ID_AA64MMFR2,
> +    ID_AA64DFR0,
> +    ID_AA64DFR1,
> +    ID_DFR0,
> +    MVFR0,
> +    MVFR1,
> +    MVFR2,
> +    DBGDIDR,
> +    ID_MAX,

(nitpicking, drop the last comma).

> +} CPUIDReg;
> +
>  /* For M profile, some registers are banked secure vs non-secure;
>   * these are represented as a 2-element array where the first element
>   * is the non-secure copy and the second is the secure copy.
> @@ -890,32 +921,7 @@ struct ARMCPU {
>       * field by reading the value from the KVM vCPU.
>       */
>      struct ARMISARegisters {
> -        uint32_t id_isar0;
> -        uint32_t id_isar1;
> -        uint32_t id_isar2;
> -        uint32_t id_isar3;
> -        uint32_t id_isar4;
> -        uint32_t id_isar5;
> -        uint32_t id_isar6;
> -        uint32_t id_mmfr0;
> -        uint32_t id_mmfr1;
> -        uint32_t id_mmfr2;
> -        uint32_t id_mmfr3;
> -        uint32_t id_mmfr4;
> -        uint32_t mvfr0;
> -        uint32_t mvfr1;
> -        uint32_t mvfr2;
> -        uint32_t id_dfr0;
> -        uint32_t dbgdidr;
> -        uint64_t id_aa64isar0;
> -        uint64_t id_aa64isar1;
> -        uint64_t id_aa64pfr0;
> -        uint64_t id_aa64pfr1;
> -        uint64_t id_aa64mmfr0;
> -        uint64_t id_aa64mmfr1;
> -        uint64_t id_aa64mmfr2;
> -        uint64_t id_aa64dfr0;
> -        uint64_t id_aa64dfr1;
> +        uint64_t regs[ID_MAX];
>      } isar;

Why not simply this?

       uint64_t isar[ID_MAX];

>      uint64_t midr;
>      uint32_t revidr;
[...]


