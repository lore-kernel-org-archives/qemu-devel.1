Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15508C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83F2D208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rnpjnh+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F2D208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSHwP-0003C1-JO
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 06:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSHul-0001xc-0H
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:52:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41135)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSHuj-0005iK-CC
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602586336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4OUT7Xb2E2UHmLCYZtcntffZHVyGUxUghI4V5Y605w=;
 b=Rnpjnh+nYaqqrtp9EQJ59LmOIsa5alMhOocQmeF4jP15JAzGi2gXA3hWZtYtY9dBdXTa1d
 SG/RSUneUaYcVh7SW9jYuZspQzQp2ay0kCOrFTSCY//etYEySb4mjuvOfNUimsqlB7uDbf
 FIL/mosihI+w/Beany4s1YDelA5v9ds=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-3uHMGdhcPr6XM7kPNFPFAw-1; Tue, 13 Oct 2020 06:52:14 -0400
X-MC-Unique: 3uHMGdhcPr6XM7kPNFPFAw-1
Received: by mail-wm1-f71.google.com with SMTP id g125so6619399wme.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 03:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w4OUT7Xb2E2UHmLCYZtcntffZHVyGUxUghI4V5Y605w=;
 b=CKKaeKreieH4ShM41Yqd/3br49B75rt6d1veX6yS4GfQxkwDQiA9gcnBER2TgbaGaU
 pGP820v9q+pGlkFz39+IuwXpREUOAQeNKyvRYqmRw4ZP6cyzGL/rm0+wXxoYWK7bpuN7
 EJicHTiUvBwCQbP9kdQ/XBFcEVksQCc5IdFu8WSZ+EOEbHOf681ErDgcckmAqt2uWfkX
 fxXJPGnTGsu7kA1Jhth6toTLfghoJb2tTYo1prlR9IKdYECzmsuPJrj1cMF/1IcBm9gU
 c7flu76KwkqZR8YrC+DzyFvrvZNuAS2K7ZTJqt3DbqGvWIGoHkTzwBznUqqoGpmhfsKb
 q9RA==
X-Gm-Message-State: AOAM5315nUCdutwhef0V6eMkhbH5fbeDX4B+XTQm8fLNG5RqPPNdyBPw
 RiwwXyx0yBn48lMC7Y9uMTs29jgUewc3C6V0oY3qKHxCCVJSH4vNYVSPZAjVoqeg5w41mm/oWLc
 1YPRZhak90dVQDjU=
X-Received: by 2002:a7b:c4cb:: with SMTP id g11mr10705525wmk.88.1602586333054; 
 Tue, 13 Oct 2020 03:52:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyIGERZzMUxOTUX1EXy96GUPayv4dKfQ2GcPQMuwkYq07jefBvlE1u6qNnpmvgoH7RJrLZYw==
X-Received: by 2002:a7b:c4cb:: with SMTP id g11mr10705509wmk.88.1602586332804; 
 Tue, 13 Oct 2020 03:52:12 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id b7sm4042810wrp.16.2020.10.13.03.52.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 03:52:12 -0700 (PDT)
Subject: Re: [PATCH 1/2] gcrypt: test_tls_psk_init should write binary file
 instead text file.
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20201013010310.497-1-luoyonggang@gmail.com>
 <20201013010310.497-2-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <499ceebd-20a6-057b-ae77-133fa1a8da10@redhat.com>
Date: Tue, 13 Oct 2020 12:52:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201013010310.497-2-luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 3:03 AM, Yonggang Luo wrote:
> On windows, if open file with "w", it's will automatically convert
> "\n" to "\r\n" when writing to file.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>   tests/crypto-tls-psk-helpers.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/crypto-tls-psk-helpers.c b/tests/crypto-tls-psk-helpers.c
> index a8395477c3..11ae26368c 100644
> --- a/tests/crypto-tls-psk-helpers.c
> +++ b/tests/crypto-tls-psk-helpers.c
> @@ -32,7 +32,7 @@ void test_tls_psk_init(const char *pskfile)
>   {
>       FILE *fp;
>   
> -    fp = fopen(pskfile, "w");
> +    fp = fopen(pskfile, "wb");
>       if (fp == NULL) {
>           g_critical("Failed to create pskfile %s", pskfile);
>           abort();
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


