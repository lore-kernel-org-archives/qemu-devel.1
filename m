Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39685C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:36:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 073D7206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gm+nXz97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073D7206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHAv-0001G9-BQ
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 04:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrHA2-0000eg-LP
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 04:35:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41776
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrHA1-0006eL-2U
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 04:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593765304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=K6LzQK2kIslHTJQZqsVJyTyXcA8Ie4oBgb28mu5j4LY=;
 b=Gm+nXz97odoomQMBA4xN31zplWd9fO5KpZQWgAegV8k9N4dEflAoS/Rx391EFbtNZc4n5j
 v1TBHbhvZDJEuF7XhHcfrFsvB5Zjz2peCnrOk9n+G9y50Hb6buP0vNJzI96Ur4VvjLhMm5
 giZcJuzmuAcyrtFrvDqIjK5R7w0d9Fo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-Peq3pi8WOOOmt5Nro2E0Kg-1; Fri, 03 Jul 2020 04:35:00 -0400
X-MC-Unique: Peq3pi8WOOOmt5Nro2E0Kg-1
Received: by mail-wr1-f72.google.com with SMTP id a18so31114151wrm.14
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 01:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=K6LzQK2kIslHTJQZqsVJyTyXcA8Ie4oBgb28mu5j4LY=;
 b=Iln46d9If9px9Z6m75W3OgcbRZOn/KNeyVohsXAFFFd54XqjkIrulhbrggFTRWJ3lH
 A0+cKM7eu9yjQ8RHFSiwc8HUkUkDNjwAsQOQGTVSLXvu7ggSJR1YmrPaZRjWiUC+w65D
 AlNWfrBD5YpAJIRZC192rqB7YNB3L5JGFoq7UJ4XoKFOJqOF4RU6Vu0t/g8ZUgT79xQB
 DbpdtMlyq6ll3sbOJxRhJ+9Mc17YyJ84byvLdtU+ClA7tlESTtT8EOswNYHTK/Lrueuj
 UvO47cciGJTT8GYFh2jkGwe4KHv+/X9vQMromKuC01OcdH12tGvpL5rqP0LEAtu+BlSS
 4YQw==
X-Gm-Message-State: AOAM531dCKskejDQZzvr5qdtj2xijtN0j5vv+N8xmg+0+azAbL+rQymt
 uWPmC/39FJX6rrbJDtQfYMfAnO8J1GSP+qeUET2WRDUizOf3C36fj8mZVaNoL21humb5JzHW4rB
 1MnZI8K88A/JAQgI=
X-Received: by 2002:a1c:c908:: with SMTP id f8mr35389266wmb.150.1593765299378; 
 Fri, 03 Jul 2020 01:34:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxigZMsYajspUguqKA1PTj+de6kMpGn7E+vFePJzESD11Np1VecAN1WjhoaA1crLydR4bPJ+w==
X-Received: by 2002:a1c:c908:: with SMTP id f8mr35389237wmb.150.1593765299037; 
 Fri, 03 Jul 2020 01:34:59 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id b62sm12687887wmh.38.2020.07.03.01.34.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 01:34:58 -0700 (PDT)
Subject: Re: [PATCH v2 10/18] hw/block/nvme: fix missing endian conversion
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200703063420.2241014-1-its@irrelevant.dk>
 <20200703063420.2241014-11-its@irrelevant.dk>
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
Message-ID: <86d5bd10-cfbd-4455-d7fe-af8d24d1b536@redhat.com>
Date: Fri, 3 Jul 2020 10:34:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200703063420.2241014-11-its@irrelevant.dk>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:38:32
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
Cc: Kevin Wolf <kwolf@redhat.com>, Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/20 8:34 AM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Fix a missing cpu_to conversion.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  hw/block/nvme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index f3a5b857bc92..ba523f6768bf 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1080,7 +1080,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  
>          break;
>      case NVME_VOLATILE_WRITE_CACHE:
> -        result = blk_enable_write_cache(n->conf.blk);
> +        result = cpu_to_le32(blk_enable_write_cache(n->conf.blk));
>          trace_pci_nvme_getfeat_vwcache(result ? "enabled" : "disabled");
>          break;
>      case NVME_NUMBER_OF_QUEUES:
> 

This doesn't look correct. What you probably want:

-- >8 --

--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -815,8 +815,8 @@ static uint16_t nvme_get_feature(NvmeCtrl *n,
NvmeCmd *cmd, NvmeRequest *req)
         trace_pci_nvme_getfeat_vwcache(result ? "enabled" : "disabled");
         break;
     case NVME_NUMBER_OF_QUEUES:
-        result = cpu_to_le32((n->params.max_ioqpairs - 1) |
-                             ((n->params.max_ioqpairs - 1) << 16));
+        result = (n->params.max_ioqpairs - 1)
+                  | ((n->params.max_ioqpairs - 1) << 16);
         trace_pci_nvme_getfeat_numq(result);
         break;
     case NVME_TIMESTAMP:
@@ -825,8 +825,8 @@ static uint16_t nvme_get_feature(NvmeCtrl *n,
NvmeCmd *cmd, NvmeRequest *req)
         trace_pci_nvme_err_invalid_getfeat(dw10);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
+    req->cqe.result = cpu_to_le32(result);

-    req->cqe.result = result;
     return NVME_SUCCESS;
 }
---


