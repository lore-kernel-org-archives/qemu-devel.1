Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4CCC433EC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:26:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD02206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S77ldiQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD02206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Ogt-0000tz-5S
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 08:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k0Og7-0000F7-0r
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 08:25:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49820
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k0Og5-0000XA-FL
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 08:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595939151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3dwJ6kJxdW3SDMfkdRz8sQkUUgXIzrZOLZ+/1ZCFX5A=;
 b=S77ldiQoZVvJ0qBjdddknD75pvfKsX3bDBkwH8vprb6MoSfWDNbf/eLTZ50GNHonkaibfL
 Q62gA/t+U9lkyAdJwcQkKmDPXOegeCq8sgAo6RdnzzDcm2VRUOewCSxF6lNXljkZ+2YaQ9
 4TWhxFn1u0+/YSK+wMKEHUX5l5EjKf0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-OIEOcD7kMZCexeeY8wiZJQ-1; Tue, 28 Jul 2020 08:25:44 -0400
X-MC-Unique: OIEOcD7kMZCexeeY8wiZJQ-1
Received: by mail-wr1-f70.google.com with SMTP id j2so2630980wrr.14
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 05:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=3dwJ6kJxdW3SDMfkdRz8sQkUUgXIzrZOLZ+/1ZCFX5A=;
 b=ZfBEsOAosf38JTe+J+g13JIXqDWahLDCDYRd0yNBOnIESqBlwUB0ZCLI/v3Gr7ALuw
 nz2be0jdGbvsucpgSuKndsJpJng6i74ukmg0OY9tYVOh9vp01srvKb2/Op9cgSXhYG5P
 oQRjqpLXmxpr7ESCkdjjTimZu+P0S/d0va7ZFc4MhJAu+Nmhqk83gev733z71d21r8wo
 CQzyVvkbJFCqRISw20VORQgpl+I44biu5footjh6dTG0gsvxXnnP+2LGaNVIu15rodsn
 V4PIMMNvqe0IZNjkz69nUz64CfKF4ryonQPCisg6NXUERVxbE5sVab7olBzKhFWt1yRN
 qFQQ==
X-Gm-Message-State: AOAM530rvAQnPC0avN0EhT5lZe9nTFVKd2ZJljHPG/kaOVFi4IvFSbu7
 qZUjoInvLkXjwZMEiYWCiwsg89VW/AL0LlZhlEdRlCakx1k9IAnLcsHGQKoM3MHCAeqNkyzlUK2
 ERyBbFbWAxghm7OI=
X-Received: by 2002:a05:600c:2246:: with SMTP id
 a6mr3903467wmm.71.1595939143708; 
 Tue, 28 Jul 2020 05:25:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDXTaLHGaEJK9TmLJ8BOsBWuwku3YHyXYR/CAdqfG2E2+eOd2kJCedoYAewBjOyvB3/LLCSQ==
X-Received: by 2002:a05:600c:2246:: with SMTP id
 a6mr3903440wmm.71.1595939143402; 
 Tue, 28 Jul 2020 05:25:43 -0700 (PDT)
Received: from [192.168.1.39] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id q7sm17814949wra.56.2020.07.28.05.25.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 05:25:42 -0700 (PDT)
Subject: Re: [PATCH for-5.1 1/2] block: Fix bdrv_aligned_p*v() for qiov_offset
 != 0
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200728120806.265916-1-mreitz@redhat.com>
 <20200728120806.265916-2-mreitz@redhat.com>
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
Message-ID: <5e8316f0-7e46-4157-46f8-a865cebf2382@redhat.com>
Date: Tue, 28 Jul 2020 14:25:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200728120806.265916-2-mreitz@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 23:55:28
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Claudio Fontana <cfontana@suse.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Bruce Rogers <brogers@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/28/20 2:08 PM, Max Reitz wrote:
> Since these functions take a @qiov_offset, they must always take it into
> account when working with @qiov.  There are a couple of places where
> they do not, but they should.
> 
> Fixes: 65cd4424b9df03bb5195351c33e04cbbecc0705c
> Fixes: 28c4da28695bdbe04b336b2c9c463876cc3aaa6d

Maybe:
Fixes: 65cd4424b9 ("bdrv_aligned_preadv: use and support qiov_offset")
Fixes: 28c4da2869 ("bdrv_aligned_pwritev: use and support qiov_offset")

> Reported-by: Claudio Fontana <cfontana@suse.de>
> Reported-by: Bruce Rogers <brogers@suse.com>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/io.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index b6564e34c5..ad3a51ed53 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1524,12 +1524,13 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
>              assert(num);
>  
>              ret = bdrv_driver_preadv(bs, offset + bytes - bytes_remaining,
> -                                     num, qiov, bytes - bytes_remaining, 0);
> +                                     num, qiov,
> +                                     qiov_offset + bytes - bytes_remaining, 0);
>              max_bytes -= num;
>          } else {
>              num = bytes_remaining;
> -            ret = qemu_iovec_memset(qiov, bytes - bytes_remaining, 0,
> -                                    bytes_remaining);
> +            ret = qemu_iovec_memset(qiov, qiov_offset + bytes - bytes_remaining,
> +                                    0, bytes_remaining);
>          }
>          if (ret < 0) {
>              goto out;
> @@ -2032,7 +2033,8 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
>              }
>  
>              ret = bdrv_driver_pwritev(bs, offset + bytes - bytes_remaining,
> -                                      num, qiov, bytes - bytes_remaining,
> +                                      num, qiov,
> +                                      qiov_offset + bytes - bytes_remaining,
>                                        local_flags);
>              if (ret < 0) {
>                  break;
> 


