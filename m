Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587ADC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:30:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 278992072D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="etIez6NM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278992072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k95FI-0004aa-BY
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k94YV-0003fS-5i
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:45:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58247
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k94YS-0004aH-UJ
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598006751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mfNaxaVa//Ptpg41/R+EuWBIgpNNPyWKFWiLOalNkPw=;
 b=etIez6NMJVzkJ46QrQMmykCX9yndIT5xmnvF53F/Fr1rMKaJkrAuihcf1psRWnpahrH7YG
 1bCzj9/LRvIArojxefdMK7JFPTwDmjh1ZzhFOQ7BXKFCS+bQbpgry6bTvGhqQl0F1pD4C1
 3l17YeXTT33ABvYxWq1QniDXhuQPIOs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-k2iJmns_Md-cbXBRdihemg-1; Fri, 21 Aug 2020 06:45:49 -0400
X-MC-Unique: k2iJmns_Md-cbXBRdihemg-1
Received: by mail-wr1-f72.google.com with SMTP id o10so426499wrs.21
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 03:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=mfNaxaVa//Ptpg41/R+EuWBIgpNNPyWKFWiLOalNkPw=;
 b=W7pSFyGGLekk1akcSzBXNBqaDesrx0kdSjuXNT1ZW8w41QHDpmfPOXw32gtXtECIKn
 +cLaiTnkNUz9aWFI1+MCxOLgwPWA1egkZDg3F9WD94m+jDLJwGsVtQTM+0gcHfy2PXLe
 5ytHx/vafkeSTCVbGPx/wup9xOvLSRHOkF1PAo+pVN1MplpjLPk6+Nz8IZrIsfDGb9q/
 g1HMJDqnTk/qT05Qtm2qRDxjN6QeRbC9Pd20Wz4tpcoq8/HozoqEHGVJwFE8q+CjaYDc
 K5QUSc3tWgUYS/TvYybwr8EVOkxBXaFWoOFPX0c+N+XJGDZ4MBaborJNE4I9TWScAxOB
 h1cQ==
X-Gm-Message-State: AOAM532j875EprWjVvpTZKOXQWdWJcfos1eNxyscUDptvpgVGCe6h+ws
 aEL/OPb0Y2SLVIwcko30VIUiWVe7gDADtia8Rr0aZES9a1ulReDeVbeCdS/isFrkRFKd1Poz3xb
 Imdri5tYHgRfNFHs=
X-Received: by 2002:a5d:538d:: with SMTP id d13mr2184868wrv.400.1598006748068; 
 Fri, 21 Aug 2020 03:45:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbMyO/3b2Q3arlx88Wk3oxt+xPRvLiJ2aBSRvLUQLsZhrpiG5z2PvThE2Rb28CZ/q16BKmXQ==
X-Received: by 2002:a5d:538d:: with SMTP id d13mr2184852wrv.400.1598006747787; 
 Fri, 21 Aug 2020 03:45:47 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id j11sm3599911wrw.79.2020.08.21.03.45.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 03:45:47 -0700 (PDT)
Subject: Re: [PATCH] numa: hmat: fix cache size check
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200821100519.1325691-1-imammedo@redhat.com>
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
Message-ID: <8f64b400-cff7-d7a7-bf1d-1eb641a475be@redhat.com>
Date: Fri, 21 Aug 2020 12:45:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821100519.1325691-1-imammedo@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 23:41:39
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
Cc: mprivozn@redhat.com, ehabkost@redhat.com, jingqi.liu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/20 12:05 PM, Igor Mammedov wrote:
> when QEMU is started like:
> 
> qemu-system-x86_64 -smp 2 -machine hmat=on \
>  -m 2G \
>  -object memory-backend-ram,size=1G,id=m0 \
>  -object memory-backend-ram,size=1G,id=m1 \
>  -numa node,nodeid=0,memdev=m0 \
>  -numa node,nodeid=1,memdev=m1,initiator=0 \
>  -numa cpu,node-id=0,socket-id=0 \
>  -numa cpu,node-id=0,socket-id=1 \
>  -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,latency=5 \
>  -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=200M \
>  -numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-latency,latency=10 \
>  -numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-bandwidth,bandwidth=100M \
>  -numa hmat-cache,node-id=0,size=8K,level=1,associativity=direct,policy=write-back,line=5 \
>  -numa hmat-cache,node-id=0,size=16K,level=2,associativity=direct,policy=write-back,line=5
> 
> it errors out with:
>  -numa hmat-cache,node-id=0,size=16K,level=2,associativity=direct,policy=write-back,line=5:
>         Invalid size=16384, the size of level=2 should be less than the size(8192) of level=1
> 
> which doesn't look right as one would expect that L1 < L2 < L3 ...
> Fix it by sawpping relevant size checks.

It makes sense (typo "swapping").
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Fixes: c412a48d4d91 (numa: Extend CLI to provide memory side cache information)
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: jingqi.liu@intel.com
> 
>  hw/core/numa.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index d1a94a14f8..f9593ec716 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -425,10 +425,10 @@ void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
>  
>      if ((node->level > 1) &&
>          ms->numa_state->hmat_cache[node->node_id][node->level - 1] &&
> -        (node->size >=
> +        (node->size <=
>              ms->numa_state->hmat_cache[node->node_id][node->level - 1]->size)) {
>          error_setg(errp, "Invalid size=%" PRIu64 ", the size of level=%" PRIu8
> -                   " should be less than the size(%" PRIu64 ") of "
> +                   " should be larger than the size(%" PRIu64 ") of "
>                     "level=%u", node->size, node->level,
>                     ms->numa_state->hmat_cache[node->node_id]
>                                               [node->level - 1]->size,
> @@ -438,10 +438,10 @@ void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
>  
>      if ((node->level < HMAT_LB_LEVELS - 1) &&
>          ms->numa_state->hmat_cache[node->node_id][node->level + 1] &&
> -        (node->size <=
> +        (node->size >=
>              ms->numa_state->hmat_cache[node->node_id][node->level + 1]->size)) {
>          error_setg(errp, "Invalid size=%" PRIu64 ", the size of level=%" PRIu8
> -                   " should be larger than the size(%" PRIu64 ") of "
> +                   " should be less than the size(%" PRIu64 ") of "
>                     "level=%u", node->size, node->level,
>                     ms->numa_state->hmat_cache[node->node_id]
>                                               [node->level + 1]->size,
> 


