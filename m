Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0FAC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 12:51:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E642465A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 12:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRSqmX+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E642465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irLfT-0007p7-VM
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 07:51:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39900)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1irLej-0007Km-S7
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:50:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1irLeg-0000RS-1p
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:50:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23455
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1irLef-0000Pv-Tw
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579006245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jznu29L5CZMHphB9FqtzLYXxZbnd4lMQl4XJsbScFxo=;
 b=VRSqmX+aoHmb1rrzhKmSlLydh8s0h3hEDbqCJ8yNtTQaPLMtwyFlhPdn0NlYia986jNLue
 dbrMWJGG/SnS5rKCTJhKr0b6Wy4FllM0nnjaWn7k0lg8ErSbSkzBg3l4eKplwMbzQy41RK
 iqK7xN5oJPBJCZwSBAltYrVZDqrttYM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-qfJijcuVPK-jCtf798g_hQ-1; Tue, 14 Jan 2020 07:50:44 -0500
Received: by mail-wr1-f69.google.com with SMTP id f10so6466694wro.14
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 04:50:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Jznu29L5CZMHphB9FqtzLYXxZbnd4lMQl4XJsbScFxo=;
 b=kGhFzLIDh7PhOFKO8kjqR3drW73JsloHcX0jQnlCU0ftP28PV2QQnEcRWKYA1M3vDh
 uWXJitoLYLVDSxckJQzKIWOENVqpkcmd5gNSuGaZLTlI43e1SDu/Bic1FZHXUn3xnP9D
 0m2zBjSXHlYAKlt53W9W7/GFakp/xw6ZIfF4daaiEvZFVGFGi2OglucD9/iDdkCYvPFQ
 DSa+nfofXvA71zu+X2pxsEqvXTR53tPI3Ms+hA5+G/gCIt4uuvJ67CPGRcLZc45MbQzA
 1jthQJZS2nykNi+E+NkxCJ4xmxBe2wxivWMw4vd49GjE/ml+cm/XzrFOzlLlDIRMTCwp
 gGhg==
X-Gm-Message-State: APjAAAVgNTRNZqBvrfXG13SJ5X1pFmsZZa8sGhTyQTOM1bGfCsGuVqdd
 nXYnotqAMeSoghw5upJA4GTUnzyat2uPfyQvNT1HaVQeIM1VYwiD4IKVP0d8bvmhmb61wyuwROm
 lfgqvo1CyQgC4oY4=
X-Received: by 2002:adf:f484:: with SMTP id l4mr24796469wro.207.1579006242961; 
 Tue, 14 Jan 2020 04:50:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqzgav61kX6uCp6dlTZ/owENK4G74uPEt1NlXQ8sde+zhPqcInlYIBJT7RVqhl2e9TNxTyPEeA==
X-Received: by 2002:adf:f484:: with SMTP id l4mr24796443wro.207.1579006242637; 
 Tue, 14 Jan 2020 04:50:42 -0800 (PST)
Received: from [10.0.1.197] (lfbn-mon-1-1103-34.w90-48.abo.wanadoo.fr.
 [90.48.206.34])
 by smtp.gmail.com with ESMTPSA id n3sm18715756wmc.27.2020.01.14.04.50.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2020 04:50:42 -0800 (PST)
Subject: Re: [PATCH] block: Use a GString in bdrv_perm_names()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20200110171518.22168-1-berto@igalia.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c2436d27-e130-4e38-e981-78c4f929ca5b@redhat.com>
Date: Tue, 14 Jan 2020 13:50:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200110171518.22168-1-berto@igalia.com>
Content-Language: en-US
X-MC-Unique: qfJijcuVPK-jCtf798g_hQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/10/20 6:15 PM, Alberto Garcia wrote:
> This is a bit more efficient than having to allocate and free memory
> for each new permission.
> 
> The default size (30) is enough for "consistent read, write, resize".
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/block.c b/block.c
> index 1b6f7c86e8..2bc9e58392 100644
> --- a/block.c
> +++ b/block.c
> @@ -1976,18 +1976,19 @@ char *bdrv_perm_names(uint64_t perm)
>           { 0, NULL }
>       };
>   
> -    char *result = g_strdup("");
> +    GString *result = g_string_sized_new(30);
>       struct perm_name *p;
>   
>       for (p = permissions; p->name; p++) {
>           if (perm & p->perm) {
> -            char *old = result;
> -            result = g_strdup_printf("%s%s%s", old, *old ? ", " : "", p->name);
> -            g_free(old);
> +            if (result->len > 0) {
> +                g_string_append(result, ", ");
> +            }
> +            g_string_append(result, p->name);
>           }
>       }
>   
> -    return result;
> +    return g_string_free(result, FALSE);
>   }

Maybe similar cleanup can be done to report_unsupported_feature() in 
block/qcow2.c.


