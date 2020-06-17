Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0C7C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B33208B3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRS3I8TA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B33208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlVGx-0004BR-1J
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 06:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlVGG-0003fX-MD
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:25:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33461
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlVGE-0007J6-Hv
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592389537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fI3dRtlNjC89poL5ucKO0KBL6RBWlnw4FbMAWqqKI2Q=;
 b=FRS3I8TA/gb4MH5gRHBnmfaAd587K4yjzf0yQPgxKnZEdrggXsDp6SoSrz9fnqNu3JgR6R
 JRcKnuq8frLd41DUQc+3I+4ZeItO8dhQDU9GRohcFD4xvZhjiyJNZo5WxgK0yZGW3Og/7L
 IzVIrysqsoB8qAuCyChC/xSp3bZaOig=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-AaKZhN-UOCGrpQnEm24c1A-1; Wed, 17 Jun 2020 06:25:32 -0400
X-MC-Unique: AaKZhN-UOCGrpQnEm24c1A-1
Received: by mail-ed1-f72.google.com with SMTP id o3so619499eda.23
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 03:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=fI3dRtlNjC89poL5ucKO0KBL6RBWlnw4FbMAWqqKI2Q=;
 b=un5INnUKX1iituEcI1+f+GWJ96VKwHv0iZYpEnbsn/OzIOliHThr5hNInKuRif9Ve9
 HHre4HYPkWc+ZobYOGvVdUd6zExC+3OqCo337vfttq4VZBwh2wwMYyW69gCSLntiw774
 cASx0we1dcPkrJVeqIZaDEwYlSWA9bMhTomDzMP+mjJY8+8uLe9bFwkUVlkOnWYUzHyM
 dNhevdoaPH8LB6Vdd17LjX80UZnNXfkbR9T+HGUejaeC48v8cqPs9y/yGWugBQLwc138
 GJdPo3PhLzBNNjUzTwrU4b414H/kQWyEKCxbPZqTSZRnOgaRuaAouofEBLY9zvdfosH5
 C/gw==
X-Gm-Message-State: AOAM530G/snBKDdfyyF4et1M6+dP6sZBb7n894HOFKQ4IJuWTw0OxdIC
 0yDPC5Zpw3eB9fFU9pMFvQmGul3sGSDRTGfzVEPotNXK+LaHMmBcEZmmAEP9uLGdFQGrZxZjk/1
 8bH39AhJVHi2yNwM=
X-Received: by 2002:a50:fd05:: with SMTP id i5mr6449283eds.79.1592389531615;
 Wed, 17 Jun 2020 03:25:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYxT2X9nv4//rroomT8mSp3vTzKSvpDwBp8hFZsNzzNdTvq/SFOTxjvFEalUjRQnUadCBi4Q==
X-Received: by 2002:a50:fd05:: with SMTP id i5mr6449267eds.79.1592389531342;
 Wed, 17 Jun 2020 03:25:31 -0700 (PDT)
Received: from [192.168.1.37] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id a62sm834851ede.45.2020.06.17.03.25.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2020 03:25:30 -0700 (PDT)
Subject: Re: [PATCH v3 2/5] migration: fix xbzrle encoding rate calculation
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200617043757.1623337-1-richard.henderson@linaro.org>
 <20200617043757.1623337-3-richard.henderson@linaro.org>
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
Message-ID: <efc60816-9122-1951-b86a-83be588af944@redhat.com>
Date: Wed, 17 Jun 2020 12:25:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200617043757.1623337-3-richard.henderson@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Wei Wang <wei.w.wang@intel.com>, "cota@braap.org" <cota@braap.org>,
 alex.bennee@linaro.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/20 6:37 AM, Richard Henderson wrote:
> From: Wei Wang <wei.w.wang@intel.com>
> 
> It's reported an error of implicit conversion from "unsigned long" to
> "double" when compiling with Clang 10. Simply make the encoding rate 0
> when the encoded_size is 0.

There is a similar error in tests/qht-bench.c, see the asan log:
https://patchew.org/QEMU/20200617072539.32686-1-f4bug@amsat.org/

/tmp/qemu-test/src/tests/qht-bench.c:287:29: error: implicit conversion
from 'unsigned long' to 'double' changes value from 18446744073709551615
to 18446744073709551616 [-Werror,-Wimplicit-int-float-conversion]
        *threshold = rate * UINT64_MAX;
                          ~ ^~~~~~~~~~
/usr/include/stdint.h:130:23: note: expanded from macro 'UINT64_MAX'
# define UINT64_MAX             (__UINT64_C(18446744073709551615))
                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/usr/include/stdint.h:107:25: note: expanded from macro '__UINT64_C'
#  define __UINT64_C(c) c ## UL
                        ^~~~~~~
<scratch space>:33:1: note: expanded from here
18446744073709551615UL
^~~~~~~~~~~~~~~~~~~~~~
1 error generated.
make: *** [/tmp/qemu-test/src/rules.mak:69: tests/qht-bench.o] Error 1

> 
> Fixes: e460a4b1a4
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  migration/ram.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 41cc530d9d..069b6e30bc 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -913,10 +913,8 @@ static void migration_update_rates(RAMState *rs, int64_t end_time)
>          unencoded_size = (xbzrle_counters.pages - rs->xbzrle_pages_prev) *
>                           TARGET_PAGE_SIZE;
>          encoded_size = xbzrle_counters.bytes - rs->xbzrle_bytes_prev;
> -        if (xbzrle_counters.pages == rs->xbzrle_pages_prev) {
> +        if (xbzrle_counters.pages == rs->xbzrle_pages_prev || !encoded_size) {
>              xbzrle_counters.encoding_rate = 0;
> -        } else if (!encoded_size) {
> -            xbzrle_counters.encoding_rate = UINT64_MAX;
>          } else {
>              xbzrle_counters.encoding_rate = unencoded_size / encoded_size;
>          }
> 


