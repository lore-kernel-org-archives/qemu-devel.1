Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B75C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:58:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B096620644
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/S5FJcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B096620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkqZ5-0002KF-O5
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 10:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jkqY7-0001Uk-Th
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:57:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27945
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jkqY6-0003WO-3n
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592233041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lfae3rppXNAdE7IF0YTrwr+MIE/ADa70w2imZpUvVLA=;
 b=g/S5FJcTqdlafrU0U6a6oJkEd50lcS3WD7qx8WF5IhfJShNJ/gM09sYg6/qYoKkf4O9RE9
 LIEdBtIKF7sFyqo1gOWCrke4YEghczvPkamnvK6dmAnJDrXLo82tdAERY6DhmWt0XrLEqs
 mcEoDGw25ULN54peFVC9LGkI9jLT9bQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-6xxAo5sUNHSuwrjt-5ezUg-1; Mon, 15 Jun 2020 10:57:16 -0400
X-MC-Unique: 6xxAo5sUNHSuwrjt-5ezUg-1
Received: by mail-ed1-f70.google.com with SMTP id o3so4987480eda.23
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 07:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=lfae3rppXNAdE7IF0YTrwr+MIE/ADa70w2imZpUvVLA=;
 b=VJz7GoX9iprhFQxM1+XLMZRPlR1c6uKCMpVavQRn1oMH2LIWVJUxMfLIBiDZt2Pa+B
 rbEUwg6vR9uhFy5QXGxcfdYKxyIxUUcOzKkgdRXRAEHWztPR9N2+5sfSaQOLCIcEufkd
 IGAOZYl89PS+SU50Mzzuzu3lvEfzr/Ji1PTos3T19LxgooiQXhaenfdRg/ODvbZbiR9V
 oa13k0kdvHL/DgytE5VXloSwtU9blDf+eZHktl8he76EbYjH4aPIZck6E4h2vLRuYs74
 orQq/xzLzAin36vyHZSQwsFgi7x/u9IG6uLiCcGAeWGkj3syQfrMT80EU/wMRDzd1EQq
 3lPg==
X-Gm-Message-State: AOAM530r3UaS5HSxX1+hUZb0h4JKYaXlNs8zFbIiQdLk4RKL46YR0sfy
 kcPB1jEt9tT0ELjEk1RXHAKKwhY0bvJY5mKaPfTfvf6Pvye7ONhfBh6RV0+Zn9u73r4KBQkm79d
 s7FTwrctObJC8SI4=
X-Received: by 2002:a05:6402:b79:: with SMTP id
 cb25mr24597426edb.334.1592233034674; 
 Mon, 15 Jun 2020 07:57:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3LvCKKg3OYycQUJ5YzvAFSZtwEAr50vJ02neyZ8/6fcvVDDenW8jGFc17s1Fs5G+6xvKmdQ==
X-Received: by 2002:a05:6402:b79:: with SMTP id
 cb25mr24597403edb.334.1592233034484; 
 Mon, 15 Jun 2020 07:57:14 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id jt16sm1488149ejb.57.2020.06.15.07.57.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2020 07:57:13 -0700 (PDT)
Subject: Re: [PATCH] bios-tables-test: Fix "-tpmdev: invalid option"
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 stefanb@linux.ibm.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, mst@redhat.com, imammedo@redhat.com
References: <20200615135051.2213-1-eric.auger@redhat.com>
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
Message-ID: <aa595991-7f3a-fd83-026b-1b35aaf9c49e@redhat.com>
Date: Mon, 15 Jun 2020 16:57:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200615135051.2213-1-eric.auger@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:17:36
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
Cc: thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/15/20 3:50 PM, Eric Auger wrote:
> When configure is run with "--disable-tpm", the bios-tables-test
> q35/tis test fails with "-tpmdev: invalid option".
> 
> Skip the test if CONFIG_TPM is unset.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  tests/qtest/bios-tables-test.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 53f104a9c5..b482f76c03 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -882,6 +882,7 @@ uint64_t tpm_tis_base_addr;
>  static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
>                                uint64_t base)
>  {
> +#ifdef CONFIG_TPM
>      gchar *tmp_dir_name = g_strdup_printf("qemu-test_acpi_%s_tcg_%s.XXXXXX",
>                                            machine, tpm_if);
>      char *tmp_path = g_dir_make_tmp(tmp_dir_name, NULL);
> @@ -924,6 +925,9 @@ static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
>      g_free(tmp_path);
>      g_free(tmp_dir_name);
>      free_test_data(&data);
> +#else
> +    g_test_skip("TPM disabled");
> +#endif
>  }
>  
>  static void test_acpi_q35_tcg_tpm_tis(void)
> 

This is simpler than Thomas' version.

Fixes: 5da7c35e25 ("bios-tables-test: Add Q35/TPM-TIS test")
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>


