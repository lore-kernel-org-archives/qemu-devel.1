Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D03C43457
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE28B22281
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMl+dGLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE28B22281
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQuud-0007s4-Fw
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQupr-0003fi-Kn
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:01:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23585)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQupp-00016w-Cg
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602259292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wHbPtlk3HViqlDVYbfmQ+TXD9+4ifgXIzwGdcgNOAdc=;
 b=LMl+dGLd+CfHhXuCV2xV4/HVoyTA0q/tnJRCjBfmCqNjzzTgtrcRC79B0+LdhhUBC62FQH
 vtB/Js1ZZWg6zogSeYHoe6wNg4OaYptXfptvjowTQEoveYH1MmeuZpInsoPy8a6mh3IunZ
 QuTxb2DtMMjuKEIwkrpP9+AGQpRwP/8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-4Aa2Km7YPfyHaho7Lg6c7Q-1; Fri, 09 Oct 2020 12:01:30 -0400
X-MC-Unique: 4Aa2Km7YPfyHaho7Lg6c7Q-1
Received: by mail-wr1-f70.google.com with SMTP id n14so1919134wrp.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wHbPtlk3HViqlDVYbfmQ+TXD9+4ifgXIzwGdcgNOAdc=;
 b=C3JestUYzoO4+5rP7mjZVWFiknADKYfrpM0xKvmOaZYLsLteOqfqnuPVrYiFAcy6Dk
 K9wOEni3UJmAHolNLZHJAVyyW7S+i2Fd3+euB8YdirOVef1ONKXNEEOpTdUc+wSDrNsh
 SZ+sKAuBjJDJJ4VJz509qNdYzMudv20ofmC11yQID/pYtjbFgY5m3StvMuR0IYtBI9zA
 Veela4/TLmr+HLYi2LKdvy6W024cgVGcS34nNt3FOXSB+VOuEAx6gY4yHR6Lj1Z0VCNs
 Fgsgeilja+HhNSd6cEONxzXuHUMCMtPOn58hNVJR+GYPjBP46ho6ihgipAxOh/DrGDOJ
 6Cjg==
X-Gm-Message-State: AOAM532tgHFH/g27/KMGSMGqUXmTX1ot2d6hS+ENZyauHWvW2wecgX7T
 lTBfTZtV5a9L7AgNl7lXKLGXfLxCNf20HhCfJMR5XNQ/eEkuFVka9VFTplXOb7nQ2/cgciSyPES
 jqA3/fjjR3USXb6E=
X-Received: by 2002:adf:b787:: with SMTP id s7mr3226948wre.390.1602259289411; 
 Fri, 09 Oct 2020 09:01:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbJDhSKH8a/AKDfb9Sg6ey8Ri/8KZ/t97+s8vCJTDUZ7bhHLrl64twH+PTSTYG3k28TDXxnw==
X-Received: by 2002:adf:b787:: with SMTP id s7mr3226919wre.390.1602259289191; 
 Fri, 09 Oct 2020 09:01:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cee1:4797:6958:7698?
 ([2001:b07:6468:f312:cee1:4797:6958:7698])
 by smtp.gmail.com with ESMTPSA id f14sm12889157wme.22.2020.10.09.09.01.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 09:01:28 -0700 (PDT)
Subject: Re: [RFC v1 2/4] qtest: unbreak non-TCG builds in bios-tables-test
To: Claudio Fontana <cfontana@suse.de>
References: <20201009152108.16120-1-cfontana@suse.de>
 <20201009152108.16120-3-cfontana@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <acbc3e92-f1fe-8e55-940e-82d1c39e743b@redhat.com>
Date: Fri, 9 Oct 2020 18:01:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201009152108.16120-3-cfontana@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.208, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/10/20 17:21, Claudio Fontana wrote:
> the tests assume TCG is available, thus breaking
> for TCG-only tests, where only the TCG accelerator option
> is passed to the QEMU binary.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>  tests/qtest/bios-tables-test.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index e15f36c8c7..e783da54ba 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -122,6 +122,9 @@ static void free_test_data(test_data *data)
>  {
>      int i;
>  
> +    if (!data->tables) {
> +        return;
> +    }
>      for (i = 0; i < data->tables->len; ++i) {
>          cleanup_table_descriptor(&g_array_index(data->tables, AcpiSdtTable, i));
>      }
> @@ -651,6 +654,13 @@ static void test_acpi_one(const char *params, test_data *data)
>      char *args;
>      bool use_uefi = data->uefi_fl1 && data->uefi_fl2;
>  
> +#ifndef CONFIG_TCG
> +    if (data->tcg_only) {
> +        g_test_skip("TCG disabled, skipping ACPI tcg_only test");
> +        return;
> +    }
> +#endif /* CONFIG_TCG */
> +
>      if (use_uefi) {
>          /*
>           * TODO: convert '-drive if=pflash' to new syntax (see e33763be7cd3)
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>


