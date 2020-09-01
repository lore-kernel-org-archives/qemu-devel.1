Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400D8C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02DDB206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+DyN81y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DDB206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD33O-0001QN-4K
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kD32M-0007rJ-H7
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:57:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30389
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kD32K-0004A8-Qk
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598954228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jP5p5m08MY5Ke5ekH/aXsG7IpEvIwI9jDjnp2LckHqs=;
 b=K+DyN81y53dSpmxY6RtZVPBhrY+TeTxGs1D8DGWkuuKfEMNfyBfYIckLx8wDivVOoWoRIt
 AKK8G40WtrjMtW0qLTx7jRI5EoDsuWhB6v1pnkWA3XtRfM2ZN8Wik8PAciZwgtiOT+OvRn
 1eQOfEb+LNZ3IqU2FpXBZKX7+U6r4vg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-iYA0WaSEM7GGlhUIQJ4sYg-1; Tue, 01 Sep 2020 05:57:06 -0400
X-MC-Unique: iYA0WaSEM7GGlhUIQJ4sYg-1
Received: by mail-wm1-f69.google.com with SMTP id w3so264739wmg.4
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 02:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=jP5p5m08MY5Ke5ekH/aXsG7IpEvIwI9jDjnp2LckHqs=;
 b=NanzCQTciUEAbxTpGPc4BSiSGkyWkmmiyVu/nqqfS3ESp8fEcD1fs0TjiUeeaQw1qi
 eMc829+e3FEWz2sV0An3QS8iKBIX75g5PRxstSTlPbDcRVTi7OcfV/1ExqoXDB/F6sCi
 6gHOihRv4c9Rh+D5fn1NFZwGLUjLrOcyaQ+/g2klJF0YuieMZSwzporA3UopDBmGEUjO
 /rflaX4MJTQ0iioYKPm4gDp+cs42EjhKVZz1KthwfN4yU7LNHg3ak9uUWK6wgQXRVJcd
 KXWB1nJQO5KgwKTb+BrioGePsHCPRltpVzOKNKxbzaduc7Bllt3lSBuj4pC3KnxF3paK
 AXFw==
X-Gm-Message-State: AOAM533h2qasfp9y8ulJ9ykOSXW8NLaW79WAxu1ZMgKKHTiZ7J5a7onA
 vxBcJo16c8IaOa2vL25yCRqltk90Mqygi84qzPnGl2L5Am+N3pFjdmzbmMCZfbTatOPip2qffm3
 VvA2bKfF84MFvlcU=
X-Received: by 2002:a1c:4381:: with SMTP id q123mr956431wma.108.1598954225257; 
 Tue, 01 Sep 2020 02:57:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyj3FfRWYunCBXo3Yf0lnPHPsDaMDqBRicH6Suu11odGvvMe+6FkAs/pb0JXpVRLMAQtvPYkQ==
X-Received: by 2002:a1c:4381:: with SMTP id q123mr956418wma.108.1598954225081; 
 Tue, 01 Sep 2020 02:57:05 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id f19sm1071990wmh.44.2020.09.01.02.57.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 02:57:04 -0700 (PDT)
Subject: Re: [PATCH 2/3] ppc/pnv: Fix TypeInfo of PnvLpcController abstract
 class
To: David Gibson <david@gibson.dropbear.id.au>, ehabkost@redhat.com
References: <20200825111627.2007820-1-david@gibson.dropbear.id.au>
 <20200825111627.2007820-3-david@gibson.dropbear.id.au>
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
Message-ID: <288bda47-42bd-77cc-e3d8-5076aad50853@redhat.com>
Date: Tue, 1 Sep 2020 11:56:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825111627.2007820-3-david@gibson.dropbear.id.au>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 05:11:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/25/20 1:16 PM, David Gibson wrote:
> From: Cédric Le Goater <clg@kaod.org>
> 
> It was missing the instance_size field.
> 
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Message-Id: <20200822083920.2668930-1-clg@kaod.org>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/pnv_lpc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index b5ffa48dac..23f1e09492 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -646,7 +646,6 @@ static void pnv_lpc_power8_class_init(ObjectClass *klass, void *data)
>  static const TypeInfo pnv_lpc_power8_info = {
>      .name          = TYPE_PNV8_LPC,
>      .parent        = TYPE_PNV_LPC,
> -    .instance_size = sizeof(PnvLpcController),
>      .class_init    = pnv_lpc_power8_class_init,
>      .interfaces = (InterfaceInfo[]) {
>          { TYPE_PNV_XSCOM_INTERFACE },
> @@ -687,7 +686,6 @@ static void pnv_lpc_power9_class_init(ObjectClass *klass, void *data)
>  static const TypeInfo pnv_lpc_power9_info = {
>      .name          = TYPE_PNV9_LPC,
>      .parent        = TYPE_PNV_LPC,
> -    .instance_size = sizeof(PnvLpcController),
>      .class_init    = pnv_lpc_power9_class_init,
>  };
>  
> @@ -768,6 +766,7 @@ static void pnv_lpc_class_init(ObjectClass *klass, void *data)
>  static const TypeInfo pnv_lpc_info = {
>      .name          = TYPE_PNV_LPC,
>      .parent        = TYPE_DEVICE,
> +    .instance_size = sizeof(PnvLpcController),
>      .class_init    = pnv_lpc_class_init,
>      .class_size    = sizeof(PnvLpcClass),
>      .abstract      = true,
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


