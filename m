Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6CDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB5DB2074B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJTtgwZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB5DB2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k18Rm-0007EJ-6F
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 09:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k18Qp-00066T-7E
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:17:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30158
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k18Qn-0004vn-8g
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596115028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OpLzgsFkNX8PZg8qnS3MlSi1x1A+9qtPsiXmj3np3Zg=;
 b=OJTtgwZVnLDR5Omb+oCbfJdNPA9hasjgJMpb7IzDQi/ZaH7gjHi5hBdPBeCTelFm/v96H4
 3GLkMr9YqxyzsWwtJ56Xd5VuH9N2jGSZTPpQbCpSvJe9qhwOw7js0BIJb76PqI8Aw8/LHS
 Og75kvw74EBcjaFyIhchNWxniIRHEY8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-HdOjaqxqN4C3G9tjpAyo9w-1; Thu, 30 Jul 2020 09:17:06 -0400
X-MC-Unique: HdOjaqxqN4C3G9tjpAyo9w-1
Received: by mail-wm1-f71.google.com with SMTP id f74so2236023wmf.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 06:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=OpLzgsFkNX8PZg8qnS3MlSi1x1A+9qtPsiXmj3np3Zg=;
 b=NQrF1saTQVQ1mLIhd62Z0WIeMUbY8fE4ENtI2mfze0nT53I+inVkruyVyCHOu7m4p7
 FgxmABMR8eDPgp/CJYwlpQMXpM797BM7N5tXMfYpC7JWQw+cqscWJBaOoXDvOVZ7QNlX
 yNpGMrQAQEg/ClLNj3FTm/CIGHzNUHfNvhyKA5adCzMvSkNoxCIOt5SvYIpVnSuSa8Fm
 lq01hFbxOCUJTE9UHDGo8ru7w1FWIVMohaggdI4F03HS1SMFVwfz0BJIHSDLXVHlJFAi
 DMnYnX5ppK8gdX55dlqTlI9wEoqTUQLlrami2qYvT/cRHvOpwYK842c0OK9lTY1cqu2d
 R7IA==
X-Gm-Message-State: AOAM530kVLQDjEQheymNoMrCy4j6ltz5HJ8SYrVQtjKBUdX1TZhik/b6
 79Xlnimazx3M929pxuXUwbvd9cRCft/D0Dd+8ZB8zI4zszf2UytnhCgtvUelH+4Tt66KDB/ODSs
 CB5GbJD/VFiBtgMM=
X-Received: by 2002:a5d:4109:: with SMTP id l9mr2882454wrp.398.1596115025256; 
 Thu, 30 Jul 2020 06:17:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWiSIJMpjeFdE4iiIp0tol8FhDu4ZB/MdzzZAAeys+9wYcPPUwxGFa8l0hcRJdJMKJftbpkg==
X-Received: by 2002:a5d:4109:: with SMTP id l9mr2882432wrp.398.1596115025043; 
 Thu, 30 Jul 2020 06:17:05 -0700 (PDT)
Received: from [192.168.1.39] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id h199sm9111133wme.42.2020.07.30.06.17.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 06:17:04 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] target/arm: Fix compile error.
To: Kaige Li <likaige@loongson.cn>, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <1596110248-7366-1-git-send-email-likaige@loongson.cn>
 <1596110248-7366-2-git-send-email-likaige@loongson.cn>
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
Message-ID: <43e912f0-4383-93c0-ccd7-204c7eaf9850@redhat.com>
Date: Thu, 30 Jul 2020 15:17:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1596110248-7366-2-git-send-email-likaige@loongson.cn>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 23:51:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/30/20 1:57 PM, Kaige Li wrote:
> When I compile qemu with such as:
> 
> git clone https://git.qemu.org/git/qemu.git
> cd qemu
> git submodule init
> git submodule update --recursive
> ./configure
> make

Again, timeless information is not useful.

> 
> There is error log:
> 
> /home/LiKaige/qemu/target/arm/translate-a64.c: In function ‘disas_ldst’:
> /home/LiKaige/qemu/target/arm/translate-a64.c:3392:5: error: ‘fn’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>      fn(cpu_reg(s, rt), clean_addr, tcg_rs, get_mem_index(s),
>      ^
> /home/LiKaige/qemu/target/arm/translate-a64.c:3318:22: note: ‘fn’ was declared here
>      AtomicThreeOpFn *fn;
>                       ^
> cc1: all warnings being treated as errors

Again, what compiler / version are you using? My guess is you are
using an old GCC, and I wonder if it is still supported.

> 
> So, add an initiallization value NULL for fn to fix this.
> 
> Signed-off-by: Kaige Li <likaige@loongson.cn>
> ---
>  target/arm/translate-a64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 8c07649..c98dfb1 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -3315,7 +3315,7 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
>      bool r = extract32(insn, 22, 1);
>      bool a = extract32(insn, 23, 1);
>      TCGv_i64 tcg_rs, clean_addr;
> -    AtomicThreeOpFn *fn;
> +    AtomicThreeOpFn *fn = NULL;
>  
>      if (is_vector || !dc_isar_feature(aa64_atomics, s)) {
>          unallocated_encoding(s);
> 


