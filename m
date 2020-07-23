Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6322C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:50:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B91220768
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DgfGLfCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B91220768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyagV-0003AU-Qm
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyafe-0002V5-Lb
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:49:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26913
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyafc-000755-Tt
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595508596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Mho0vnIR3Uc7XNa8i7dYigpdsK4pR8TVOFRM5mczAzM=;
 b=DgfGLfCoePsU99qiFk587t4SKHqGetdERnNFnE5SAkkeK+7NZZw7/EC2J2aDcTz1ANP9j9
 nHu/Z1jf5CHp4+I8YpShdB3P0D97t2cWFjqvhV5lfuOxDf0d5mqzOc4jPRbgkCtS+/0v3a
 scOAc93heQVPMfkRrn4fxq+0cCbGCK4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-sfDcgLhSOByyQ6PbUUh4eQ-1; Thu, 23 Jul 2020 08:49:54 -0400
X-MC-Unique: sfDcgLhSOByyQ6PbUUh4eQ-1
Received: by mail-wm1-f70.google.com with SMTP id b13so2479207wme.9
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 05:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Mho0vnIR3Uc7XNa8i7dYigpdsK4pR8TVOFRM5mczAzM=;
 b=f6fOWWJsGG6THFJf+tzfXpQfM1LqjdBxKh9Ji0Yw939VuW/HA2e04CK9aBSvo3YxA2
 u9shPmVxYLAekx1smu9XP+oQZq44PF/6wUVX6u0TvOSUEUcRgGMruUGMX/a9uaLuas6W
 /g/nRNKeqQSJ5hBO2MnW9lAdAPs6nkDGPR1HuOhQWfsHc9Y2ss9cSKYz44kCA9TrpdVN
 rL/UO+J2G9ohtXyvsd0yyiVacJAwMjkcEQW7QjU43XWCAk1YY07z5HnedK4WVeWQ9UWm
 BlspVhhGsgmEldk07lB0ouuMG4i8r3KVGRK0sJ+app/C8bcserbZjHaqrbSJdyyqtAlf
 4XFA==
X-Gm-Message-State: AOAM531l5fwqIc9kAsMJLgmM7YT7bSo52ebfGxMxVFjOwzPdw8bq9VtB
 cHLJRg2/2j10Wys+hRR1TRvVwq8pzOYqsKUR7+1gLipb7QhCCObzrCFNdwzscd7B8p8laPh75IZ
 /36ow8Ex5f4gy/cg=
X-Received: by 2002:adf:eb89:: with SMTP id t9mr3866423wrn.65.1595508593412;
 Thu, 23 Jul 2020 05:49:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQM4CwXrchihmnKqB1XSRPlBx/zu0BOuh4qddQdMa0LhUIlHeXhHHHQt0xXrnTNh1fjTkYqg==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr3866404wrn.65.1595508593123;
 Thu, 23 Jul 2020 05:49:53 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id n125sm3513686wme.30.2020.07.23.05.49.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2020 05:49:52 -0700 (PDT)
Subject: Re: [PATCH for-5.1 2/2] tpm: Improve help on TPM types when none are
 available
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200723115845.1865886-1-armbru@redhat.com>
 <20200723115845.1865886-3-armbru@redhat.com>
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
Message-ID: <42246b2f-e267-b254-10cf-0dc491d5f99e@redhat.com>
Date: Thu, 23 Jul 2020 14:49:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200723115845.1865886-3-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:33:29
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
Cc: stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/20 1:58 PM, Markus Armbruster wrote:
> Help is a bit awkward when no TPM types are built into QEMU:
> 
>     $ upstream-qemu -tpmdev nonexistent,id=tpm0
>     upstream-qemu: -tpmdev nonexistent,id=tpm0: Parameter 'type' expects a TPM backend type
>     Supported TPM types (choose only one):
> 
> Improve to
> 
>     upstream-qemu: -tpmdev nonexistent,id=tpm0: Parameter 'type' expects a TPM backend type
>     No TPM backend types are available
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tpm.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/tpm.c b/tpm.c
> index f6045bb6da..cab206355a 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -47,18 +47,23 @@ tpm_be_find_by_type(enum TpmType type)
>   */
>  static void tpm_display_backend_drivers(void)
>  {
> +    bool got_one = false;
>      int i;
>  
> -    fprintf(stderr, "Supported TPM types (choose only one):\n");
> -
>      for (i = 0; i < TPM_TYPE__MAX; i++) {
>          const TPMBackendClass *bc = tpm_be_find_by_type(i);
>          if (!bc) {
>              continue;
>          }
> -        fprintf(stderr, "%12s   %s\n", TpmType_str(i), bc->desc);
> +        if (!got_one) {
> +            error_printf("Supported TPM types (choose only one):\n");
> +            got_one = true;
> +        }
> +        error_printf("%12s   %s\n", TpmType_str(i), bc->desc);
> +    }
> +    if (!got_one) {
> +        error_printf("No TPM backend types are available\n");
>      }
> -    fprintf(stderr, "\n");
>  }
>  
>  /*
> 


