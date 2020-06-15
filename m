Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877DFC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5021920644
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XC5GzuiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5021920644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkqXs-0000j5-Ib
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 10:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jkqX3-0008Ij-Cc
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:56:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39560
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jkqX1-0003N8-7a
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592232973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UpPOyh9paP7bM+l0ODFiLubvlWTVTbP7tgFzskBvHGI=;
 b=XC5GzuiBPrmtz1kIBR4U5Er4i/gSbpkjNak+KKFHrHmpuDNHT0lwhFtJOtk5VILNkd4u2E
 crRFrNcxbJDvBxE86JvJLT1UwdiBXKKquQk5lHyipR+s4BtGEaOo3b8TPJQWm4r7arlm8Z
 nnH2+uhX7/vHwfZAA3w8AnKDmmdWV/c=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-rGrg4I_SPSKCt-qRcucTMw-1; Mon, 15 Jun 2020 10:56:06 -0400
X-MC-Unique: rGrg4I_SPSKCt-qRcucTMw-1
Received: by mail-ed1-f71.google.com with SMTP id z8so4990956edr.12
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 07:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=UpPOyh9paP7bM+l0ODFiLubvlWTVTbP7tgFzskBvHGI=;
 b=KfeYBoPBL1f2bbMuLaLhZpZvv8dZPt0qSKyUpd5uP2GS5EbvWdpDkOw+gSB2/8xLw1
 x1qHALcIPxEPtRhrZ/JTcRXjiNcSK3uO+25rQ+16pP17A3iPjMEyFfok/yA32av8AhIu
 bOd9uNe6+2c/J31LUqoCNycCmw4qyajXkhUh0MakdcmQhXmMMy12rMeku0R7QKGglNaA
 FKRjVxzZpnRckp2u3CCPqrSOmG4hlq2hfNmWikEHnSpTkYDE9MzCGBH/Ooh4D/2B+nfq
 f7G9QgW6gIv89+U7hnf0YT17PkRUm98GWMj1AHkWWDQTXXCOLjka3TjiPh3E/YPieKeb
 8fXg==
X-Gm-Message-State: AOAM53342teKRdV/dozr0qYwkXs5fpwa26mMv4nnu2k2DZXUih6o1Dth
 5e7qciMlkuoygGvmGPLvn7oQ+pOt8kewmn/ARMj/500nXkZ8zxhPuBgTPjjE0ogUtjZeLsPN5KB
 VMiFlloH/9nZJKz0=
X-Received: by 2002:a17:906:b7cd:: with SMTP id
 fy13mr26812829ejb.133.1592232965004; 
 Mon, 15 Jun 2020 07:56:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz246686ce4DsIavwLjJivG/hR4t4mjM11QpFUhP0AVJrOj3Yh/TktS6EzhevJ0tswvFGkN0g==
X-Received: by 2002:a17:906:b7cd:: with SMTP id
 fy13mr26812810ejb.133.1592232964773; 
 Mon, 15 Jun 2020 07:56:04 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id be19sm8520335edb.5.2020.06.15.07.56.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2020 07:56:04 -0700 (PDT)
Subject: Re: [PATCH] tests/qtest/bios-tables: Only run the TPM test with
 CONFIG_TPM enabled
To: Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Auger Eric <eric.auger@redhat.com>,
 qemu-devel@nongnu.org
References: <20200615125402.12898-1-thuth@redhat.com>
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
Message-ID: <1a050581-585a-5177-77bf-cb527196ac8a@redhat.com>
Date: Mon, 15 Jun 2020 16:56:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200615125402.12898-1-thuth@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:12:36
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
Cc: Laurent Vivier <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/15/20 2:54 PM, Thomas Huth wrote:
> "make check-qtest" currently fails if configure has been run with
> "--disable-tpm" - the TPM-related tests can only work if the TPM is
> enabled in the build. So let's use the CONFIG_TPM switch to disable
> the test if TPM is not available.
> 

$ git showfix 5da7c35e25a
Fixes: 5da7c35e25 ("bios-tables-test: Add Q35/TPM-TIS test")
Cc: eric.auger@redhat.com

> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/qtest/bios-tables-test.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 53f104a9c5..d170a617d8 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -877,6 +877,8 @@ static void test_acpi_piix4_tcg_numamem(void)
>      free_test_data(&data);
>  }
>  
> +#ifdef CONFIG_TPM
> +
>  uint64_t tpm_tis_base_addr;
>  
>  static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
> @@ -931,6 +933,8 @@ static void test_acpi_q35_tcg_tpm_tis(void)
>      test_acpi_tcg_tpm("q35", "tis", 0xFED40000);
>  }
>  
> +#endif /* CONFIG_TPM */
> +
>  static void test_acpi_tcg_dimm_pxm(const char *machine)
>  {
>      test_data data;
> @@ -1094,7 +1098,9 @@ int main(int argc, char *argv[])
>              return ret;
>          }
>  
> +#ifdef CONFIG_TPM
>          qtest_add_func("acpi/q35/tpm-tis", test_acpi_q35_tcg_tpm_tis);
> +#endif
>          qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
>          qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
>          qtest_add_func("acpi/q35", test_acpi_q35_tcg);
> 


