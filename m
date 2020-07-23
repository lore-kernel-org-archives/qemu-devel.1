Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6421C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 823812086A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRaSkW81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823812086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyYoo-0008ER-PG
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 06:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyYnk-0006yI-TS
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:50:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26657
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyYni-0000Kr-Bb
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595501408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qL5PSwBcjX4a+9VFdnbhK09oit5slpaQEGQ8FuXFaTA=;
 b=fRaSkW81bStomEa9zUrWb0TKmajaWPrV8yiaVHUDgoOcsx7U4kymr04G+vOnuMmDrDqD9F
 gXPqdYXs6IGzjsh6GGyFQrx0+v5/JL/+TmSc8Zn/FoZuYm3Ng6CLgKzXiUvMOgI9j58plz
 0tZCDoLzBujPQdIXFmPfvNALiKxCixc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-LOD4TyxdNmuQM9JuIjH2uA-1; Thu, 23 Jul 2020 06:50:07 -0400
X-MC-Unique: LOD4TyxdNmuQM9JuIjH2uA-1
Received: by mail-wm1-f69.google.com with SMTP id q15so1648099wmj.6
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 03:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=qL5PSwBcjX4a+9VFdnbhK09oit5slpaQEGQ8FuXFaTA=;
 b=e9n3Ujax9VAPYC8h0J47rt8GhUCTTy7IRdR1MT4ykmswLWPodNdaF0Ryzjc3SPtM6q
 kRc6PvKct1ASzF1dWtyozs8jnagMTttFsmzmff5pPAOwTMlt+IkSQlJg7SVps1DaKs3y
 1gPrYO9B3Hr3aBzCvXRKf1ST2yVNM6boD2lUXb+JLmQt6phlLReC8Q2h6RGKzxP9xgrL
 S6AHvUqWTNPBxjK8kQcv9ehFDP6xoZV164NmuHZpU0UlEFsKSDNUJyvxRznwkhRhp+6c
 N2Gi43FevSgxEX9MJ2UMMgo8V7Rq2tki6BumvM33BVgvz1FkQwjLw6ciHKH/ZNVryqkE
 zi+Q==
X-Gm-Message-State: AOAM5316AKT7L/1h/vVbdbDL5drkbtg6fMhOQ32SMMMCg6Z6iNNin8dW
 R0FKjTQSpdFaIEfTRNRgrpXkLgrwoaOJg2cY3HiYjTvyZyTR2KRZET1PkFBkQx+5hz93SAP9g2U
 FYOx5BS9YsCXSR/k=
X-Received: by 2002:adf:9bdd:: with SMTP id e29mr3796740wrc.394.1595501405833; 
 Thu, 23 Jul 2020 03:50:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJW0Z8ybjzUHaN6a3luC5/Wo6TsbOzSXbGzuhsQl/fHsS8fDzm2jJzB3gRwSId0RgDXayu/A==
X-Received: by 2002:adf:9bdd:: with SMTP id e29mr3796727wrc.394.1595501405601; 
 Thu, 23 Jul 2020 03:50:05 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id w7sm3167163wmc.32.2020.07.23.03.50.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2020 03:50:04 -0700 (PDT)
Subject: Re: [PATCH-for-5.1 v2 2/2] tpm: List the available TPM backends
To: qemu-devel@nongnu.org
References: <20200723103939.19624-1-philmd@redhat.com>
 <20200723103939.19624-3-philmd@redhat.com>
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
Message-ID: <767c3596-a7e4-ac22-d754-0b67483d63f5@redhat.com>
Date: Thu, 23 Jul 2020 12:50:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200723103939.19624-3-philmd@redhat.com>
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
Cc: Markus Armbruster <armbru@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/20 12:39 PM, Philippe Mathieu-Daudé wrote:
> When an incorrect backend is selected, tpm_display_backend_drivers()
> is supposed to list the available backends. However the error is
> directly propagated, and we never display the list. The user only
> gets "Parameter 'type' expects a TPM backend type" error.
> 
> Convert the fprintf(stderr,) calls to error hints propagated with
> the error.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Since v1:
> - Use g_assert_not_reached after processing 'help' in tpm_config_parse
> ---
>  tpm.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/tpm.c b/tpm.c
> index e36803a64d..f883340d1a 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -58,23 +58,21 @@ static int tpm_backend_drivers_count(void)
>  }
>  
>  /*
> - * Walk the list of available TPM backend drivers and display them on the
> - * screen.
> + * Walk the list of available TPM backend drivers and list them as Error hint.
>   */
> -static void tpm_display_backend_drivers(void)
> +static void tpm_list_backend_drivers_hint(Error **errp)
>  {
>      int i;
>  
> -    fprintf(stderr, "Supported TPM types (choose only one):\n");
> +    error_append_hint(errp, "Supported TPM types (choose only one):\n");
>  
>      for (i = 0; i < TPM_TYPE__MAX; i++) {
>          const TPMBackendClass *bc = tpm_be_find_by_type(i);
>          if (!bc) {
>              continue;
>          }
> -        fprintf(stderr, "%12s   %s\n", TpmType_str(i), bc->desc);
> +        error_append_hint(errp, "%12s   %s\n", TpmType_str(i), bc->desc);
>      }
> -    fprintf(stderr, "\n");
>  }
>  
>  /*
> @@ -97,6 +95,7 @@ TPMBackend *qemu_find_tpm_be(const char *id)
>  
>  static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
>  {
> +    ERRP_GUARD();
>      const char *value;
>      const char *id;
>      const TPMBackendClass *be;
> @@ -122,7 +121,7 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
>      value = qemu_opt_get(opts, "type");
>      if (!value) {
>          error_setg(errp, QERR_MISSING_PARAMETER, "type");
> -        tpm_display_backend_drivers();
> +        tpm_list_backend_drivers_hint(errp);
>          return 1;
>      }
>  
> @@ -131,7 +130,7 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
>      if (be == NULL) {
>          error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "type",
>                     "a TPM backend type");
> -        tpm_display_backend_drivers();
> +        tpm_list_backend_drivers_hint(errp);
>          return 1;
>      }
>  
> @@ -184,8 +183,8 @@ int tpm_config_parse(QemuOptsList *opts_list, const char *optarg)
>      QemuOpts *opts;
>  
>      if (!strcmp(optarg, "help")) {
> -        tpm_display_backend_drivers();
> -        return -1;
> +        tpm_list_backend_drivers_hint(&error_fatal);
> +        g_assert_not_reached(); /* Using &error_fatal triggers exit(1). */

Maybe tpm_config_parse() should take an Error** parameter instead?
And in vl.c:

-- >8 --
 #ifdef CONFIG_TPM
             case QEMU_OPTION_tpmdev:
-                if (tpm_config_parse(qemu_find_opts("tpmdev"), optarg)
< 0) {
-                    exit(1);
-                }
+                tpm_config_parse(qemu_find_opts("tpmdev"), optarg,
+                                 &error_fatal);
                 break;
 #endif
---

>      }
>      opts = qemu_opts_parse_noisily(opts_list, optarg, true);
>      if (!opts) {
> 


