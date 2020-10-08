Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159A3C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:47:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24A9B2184D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DM1xRthW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A9B2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQQeH-0007PI-QI
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 03:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQQbB-0005vE-Tx
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:44:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45268)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQQb9-0008Rp-Es
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602143062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L2Ubjsc/gTyKZFufptoYRixH+M6Y+mAewGZQDH/hnSU=;
 b=DM1xRthWoZt8SIdl3R84KsVd6s6yGQNphRqBWTxoRIZEe4c70fffEFlC6WvO0nzoaBFw32
 JqiXXiTntpUk9K4KoU1Pi69+uVUjpwwkH+7mdRuIRfwNERqW3eu4MCagWa4zqDdUkFFCYl
 oveEm4CcwAT4LojHu6rcFsW8cI61Ybc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-EqylQ0JQOfix5s37BSTTZg-1; Thu, 08 Oct 2020 03:44:21 -0400
X-MC-Unique: EqylQ0JQOfix5s37BSTTZg-1
Received: by mail-wr1-f69.google.com with SMTP id b6so3553019wrn.17
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 00:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=L2Ubjsc/gTyKZFufptoYRixH+M6Y+mAewGZQDH/hnSU=;
 b=jwqeKkQKw8p64qKVN54SWWPR9e1JoS2sCN/+W3u9Ls0fgnJAEaWX9qh3wZxB7ldZCc
 M7xwqxMzuwnEBhlrlchWbMmeauqNmBisDIBZB9eW/gU6MsAqeUnWPK/gUa7i7jSQ0UCW
 ibxaoFu9sy/cb5WiDOvmKAmIC0eaczQBq6AU5Hz555g2QroBHXxumHH91NBZefACA9kU
 mxJ/bxZZs2clQD/4rP77dS0NC5m6O6+oJuvpUc+6hmA3xjsEDbHi0A9Cd8YY8H9+/Eyy
 NTRufWBBeN/uBaDMfe3+rCCLz/ga/+WeQQ8RYznowkC9noyI1kCDtGwIHtvZCF2PeYYG
 vGnw==
X-Gm-Message-State: AOAM532JggIVJuM5p5BpPTv6b+McY9cMunI2q2oB7jLoX/60DUyWnnKn
 kisuV8zQOGKx/H9QJcx8tia9CpqsikooLIoGdBxcuGWacffkCcrvmG+XiDTuB8IPF3Wv7/6XXmz
 8REe3TyX1O4lDLHE=
X-Received: by 2002:a5d:5609:: with SMTP id l9mr6004630wrv.140.1602143059911; 
 Thu, 08 Oct 2020 00:44:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwv2aP4iNExcxydOXovSDkY/q1F4CWraOYwBr21RgVryTTYOy9yEYMWFKzccjft7qsnFZitUQ==
X-Received: by 2002:a5d:5609:: with SMTP id l9mr6004614wrv.140.1602143059752; 
 Thu, 08 Oct 2020 00:44:19 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j134sm5773559wmj.7.2020.10.08.00.44.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 00:44:19 -0700 (PDT)
Subject: Re: [PATCH] qom: Fix "typddef" typo
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20201007220255.1170167-1-ehabkost@redhat.com>
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
Message-ID: <3a0f87a3-afcd-93d9-f54f-8aa0942542fa@redhat.com>
Date: Thu, 8 Oct 2020 09:44:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201007220255.1170167-1-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/20 12:02 AM, Eduardo Habkost wrote:
> Fix typo introduced in the C11 #ifdef for qemu_max_align_t.  It
> never caused any problems because we always compile using
> -std=gnu99.
> 
> Fixes: 4c880f363e9e ("qom: Allow objects to be allocated with increased alignment")
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  qom/object.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qom/object.c b/qom/object.c
> index c335dce7e4..125dabd28b 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -692,7 +692,7 @@ static void object_finalize(void *data)
>  
>  /* Find the minimum alignment guaranteed by the system malloc. */
>  #if __STDC_VERSION__ >= 201112L
> -typddef max_align_t qemu_max_align_t;
> +typedef max_align_t qemu_max_align_t;

Oops
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  #else
>  typedef union {
>      long l;
> 


