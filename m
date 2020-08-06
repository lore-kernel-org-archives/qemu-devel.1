Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59FCC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:16:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD5D9204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INSJEf8H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5D9204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3a0E-0005fC-7F
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 03:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3ZzR-0005AS-BR
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 03:07:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42097
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3ZzO-0007Ao-0b
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 03:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596697616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DbthWF/LgKCdQHPwR2XtBaGWNOd6GCSJudayM3EHW3w=;
 b=INSJEf8Hsjd7L7kj18pZAlEuVsrhlRmYsLH5cfJ2h4Kj1lzj9jT+oFCNXbC8028WI3A51S
 yRnWCHlAAZ44/VsgXmbXxHJeD+/ueBa3eJUQUJmovBM0123YlGD8Pf0i2wHu1JzHRpdLHp
 lrdDjsrgYZrnEyK5acdjvYM90UcZUz8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-JtWOVT5DOE6uq7_b-G8WNw-1; Thu, 06 Aug 2020 03:06:54 -0400
X-MC-Unique: JtWOVT5DOE6uq7_b-G8WNw-1
Received: by mail-wr1-f70.google.com with SMTP id e14so10903612wrr.7
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 00:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=DbthWF/LgKCdQHPwR2XtBaGWNOd6GCSJudayM3EHW3w=;
 b=dU8mOl2dKGvFzYvnWjZfizywiEq4ibW5w0gAd5IN1pJ0nEtV1Gcxx/+gjULThr2key
 esFI807CuNdshtUK75yxvEau4c/qYXMu9wRdipVFygTdiEf5reAUHsWx/5UYNkwxe+9k
 tXcG0IljVk+ArAO+YFDMh9MnyCQYBX7OP53+9N+64wP4+NhOgIEtzQ5HKg+KmH97evlS
 2OPAUjyGBj0MLbXLAP0Uq+PzveT8WtxXquS6oPPTfnw/lv+wafkN0dygtKpK6eBnT/oH
 aJluxr+GTTaDSP3TqPl7twRYL5VjDGtnn6kpX6e73MGrxC5D+3QALcOlXeVW//nEZEZm
 JoYg==
X-Gm-Message-State: AOAM5310j7sbncz9CaR+Rvg9TQln89j+JqsZ1IP1ob+6a7A+6ad5/umv
 dFZSMjctmu9dX2fIi01Yz5CJ6r0o2vHsHXwT9M2MULenE0Dgvzp78xyMgWA5zo+F80dIWRkd4Hs
 bhKiWIhdG7l9Dgk8=
X-Received: by 2002:adf:e647:: with SMTP id b7mr6422624wrn.220.1596697613738; 
 Thu, 06 Aug 2020 00:06:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8ClNgGz1D7ZOZcOGxflSB16b4qeQrm2TstnXLIOneStaqYaJCdu/2ln0mp9yYA7dduTrAdQ==
X-Received: by 2002:adf:e647:: with SMTP id b7mr6422589wrn.220.1596697613374; 
 Thu, 06 Aug 2020 00:06:53 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id c15sm5171789wme.23.2020.08.06.00.06.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 00:06:52 -0700 (PDT)
Subject: Re: [PATCH] block/vhdx: Support vhdx image only with 512 bytes
 logical sector size
To: Swapnil Ingle <swapnil.ingle@nutanix.com>, qemu-devel@nongnu.org
References: <1596663040-172084-1-git-send-email-swapnil.ingle@nutanix.com>
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
Message-ID: <e867e590-83e8-8925-d02c-b79c40048d7d@redhat.com>
Date: Thu, 6 Aug 2020 09:06:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1596663040-172084-1-git-send-email-swapnil.ingle@nutanix.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Jeff Cody <codyprime@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:VHDX" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/5/20 11:30 PM, Swapnil Ingle wrote:
> block/vhdx uses qemu block layer where sector size is always 512 byte.

"bytes".

> This may have issues  with 4K logical sector sized vhdx image.
> 
> For e.g qemu-img convert on such images fails with following assert:
> 
> $qemu-img convert -f vhdx -O raw 4KTest1.vhdx test.raw
> qemu-img: util/iov.c:388: qiov_slice: Assertion `offset + len <=
> qiov->size' failed.
> Aborted
> 
> This patch adds an check to return ENOTSUP for vhdx images which
> has logical sector size other than 512 bytes.

Probably "which have".

> 
> Signed-off-by: Swapnil Ingle <swapnil.ingle@nutanix.com>
> ---
>  block/vhdx.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/vhdx.c b/block/vhdx.c
> index 791eb90..356ec4c 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -816,9 +816,9 @@ static int vhdx_parse_metadata(BlockDriverState *bs, BDRVVHDXState *s)
>          goto exit;
>      }
>  
> -    /* only 2 supported sector sizes */
> -    if (s->logical_sector_size != 512 && s->logical_sector_size != 4096) {
> -        ret = -EINVAL;
> +    /* Currently we only support 512 */
> +    if (s->logical_sector_size != 512) {
> +        ret = -ENOTSUP;
>          goto exit;
>      }
>  
> 


