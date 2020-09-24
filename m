Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99A1C4727D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 08:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A0202137B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 08:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSeKzkju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0202137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLMjY-00085u-Vf
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 04:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kLMiP-00075s-8O
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 04:34:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20236)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kLMiM-0007uo-Ob
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 04:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600936494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4SXMKaQgnn5i4FN20dARbAe1L5GTbmsj3XVStcL4nS4=;
 b=gSeKzkjugjxNRMfVF/dtKIuED7V+nLi479uGf7itvkiL0fjUO++sNPhk9w4vas53Urj2Ft
 T7rb7Kfp87dM1B68PEdCqYCVctH9Gichj7hCBhjgm6kXxN6c2A9vLj5iG1oHv+Q0u2X4TJ
 3Jei6fD7FHxdFOfVJ9PaqK8oUsRV3ps=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-iH0hgxZzNICAaJR1lQddNw-1; Thu, 24 Sep 2020 04:34:52 -0400
X-MC-Unique: iH0hgxZzNICAaJR1lQddNw-1
Received: by mail-wm1-f72.google.com with SMTP id m19so950754wmg.6
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 01:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=4SXMKaQgnn5i4FN20dARbAe1L5GTbmsj3XVStcL4nS4=;
 b=GvpH+rRIfW3nMifVwRJXOVGgNSF3fttBic74ZS+0t1E/KE+kiSndNsTzxqGp5uQxqM
 eELT2TYjxx2+ofYkAKlIYpYUV/8LoWSse2YWpLwzZCnUffFj2LSjafx6jIYmPPEUYxTM
 KfZ5EVhJUqPbD2PXg5PEUo6a1J1XKT0rFjgyNmtzinZ0sOWn35bD4d8BBfLutP4HH4mo
 uG79D6qlZYjAaB3s+A9XvT7+T+/XJb2cgLvdVytUbiTkpcZrpoqN238mLLwyuqBleKDc
 S835sSBmTiojEvqq/gAo5PIljP6wxLl2MVD2a85IVnlauU8GiC+g1Ti3usV9ZCzPucGS
 jyNA==
X-Gm-Message-State: AOAM5313KD9EYefpVn6B5mG92+teNMm2pK5bYf6alBl6KufFepjoXwvZ
 21H1M6oIsj8XNXa7RDFGP5AlLchlrRFkNKpJ6uK39/RVjwbQ/1vQ6nLM1jx2f3Gs8DqJgXr/YMH
 WEi9gnPH8QQ4Ns1o=
X-Received: by 2002:a5d:570b:: with SMTP id a11mr3913834wrv.139.1600936491004; 
 Thu, 24 Sep 2020 01:34:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMFvsK3YZq15s08GtTMvtjvvL+g6cHFgPK1uKGYF57haYuQ9ErTsdOhsF+eD1bhCPlZKJwRA==
X-Received: by 2002:a5d:570b:: with SMTP id a11mr3913805wrv.139.1600936490728; 
 Thu, 24 Sep 2020 01:34:50 -0700 (PDT)
Received: from [192.168.1.34] (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id z13sm2710778wro.97.2020.09.24.01.34.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2020 01:34:49 -0700 (PDT)
Subject: Re: [PATCH v8 3/7] block: declare some coroutine functions in
 block/coroutines.h
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200915164411.20590-1-vsementsov@virtuozzo.com>
 <20200915164411.20590-4-vsementsov@virtuozzo.com>
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
Message-ID: <8c2dc647-dfe2-f350-e4b3-0baaf346d10f@redhat.com>
Date: Thu, 24 Sep 2020 10:34:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200915164411.20590-4-vsementsov@virtuozzo.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, ehabkost@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/15/20 6:44 PM, Vladimir Sementsov-Ogievskiy wrote:
> We are going to keep coroutine-wrappers code (structure-packing
> parameters, BDRV_POLL wrapper functions) in separate auto-generated
> files. So, we'll need a header with declaration of original _co_
> functions, for those which are static now. As well, we'll need
> declarations for wrapper functions. Do these declarations now, as a
> preparation step.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/coroutines.h | 67 ++++++++++++++++++++++++++++++++++++++++++++++
>  block.c            |  8 +++---
>  block/io.c         | 34 +++++++++++------------
>  3 files changed, 88 insertions(+), 21 deletions(-)
>  create mode 100644 block/coroutines.h
> 
> diff --git a/block/coroutines.h b/block/coroutines.h
> new file mode 100644
> index 0000000000..9ce1730a09
> --- /dev/null
> +++ b/block/coroutines.h
> @@ -0,0 +1,67 @@

Maybe also add:

   /* SPDX-License-Identifier: MIT */

> +/*
> + * Block layer I/O functions
> + *
> + * Copyright (c) 2003 Fabrice Bellard
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef BLOCK_COROUTINES_INT_H
> +#define BLOCK_COROUTINES_INT_H
> +
> +#include "block/block_int.h"
> +
> +int coroutine_fn bdrv_co_check(BlockDriverState *bs,
> +                               BdrvCheckResult *res, BdrvCheckMode fix);
> +int coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs, Error **errp);
> +
> +int coroutine_fn
> +bdrv_co_prwv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov,
> +             bool is_write, BdrvRequestFlags flags);
> +int
> +bdrv_prwv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov,
> +          bool is_write, BdrvRequestFlags flags);
> +
> +int coroutine_fn
> +bdrv_co_common_block_status_above(BlockDriverState *bs,
> +                                  BlockDriverState *base,
> +                                  bool want_zero,
> +                                  int64_t offset,
> +                                  int64_t bytes,
> +                                  int64_t *pnum,
> +                                  int64_t *map,
> +                                  BlockDriverState **file);
> +int
> +bdrv_common_block_status_above(BlockDriverState *bs,
> +                               BlockDriverState *base,
> +                               bool want_zero,
> +                               int64_t offset,
> +                               int64_t bytes,
> +                               int64_t *pnum,
> +                               int64_t *map,
> +                               BlockDriverState **file);
> +

Prototypes documentation welcomed, but this is rather scarce
in the block APIs, so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +int coroutine_fn
> +bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
> +                   bool is_read);
> +int
> +bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
> +                bool is_read);
> +
> +#endif /* BLOCK_COROUTINES_INT_H */


