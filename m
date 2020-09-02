Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6FBC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 09:53:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D62102084C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 09:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/fz3Zlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D62102084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDPSZ-00024u-Vu
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 05:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDPS0-0001MH-2q
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 05:53:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33917)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDPRy-0007NM-BV
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 05:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599040385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rm9+9XvMjo2bpL2GAM/21F/jpjy1E0z2Dcc+38nj9I8=;
 b=P/fz3ZlmPFHnNjXeoMTRl7AjnSBCjHb6LRXnE0u6lv0Vod5JMruU+Vn4IZSDKgJmYJKmqM
 NCy6KteVjPQIqLhG9///sPlYaZ6Jon44vx/GO3GST2Stqz2hdyLWgobaxt+thY7AxXmr4S
 uusHlewAOM2raBCW9OqcfnkS3TQT+cU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-jCyZLLzpOnmmDX69l4dREQ-1; Wed, 02 Sep 2020 05:53:03 -0400
X-MC-Unique: jCyZLLzpOnmmDX69l4dREQ-1
Received: by mail-wr1-f69.google.com with SMTP id 3so1780348wrm.4
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 02:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=rm9+9XvMjo2bpL2GAM/21F/jpjy1E0z2Dcc+38nj9I8=;
 b=oryAqRtZ0mvLeb8UJDWc1TT6uaR5+EBosI+okskPW2L8sulJhmUwjgwpvuVyCNRP14
 jR4Nc31DErjy16xr/9fRsbCun1Fv4XfQvVQ3eREA255OgljtIYUbf3dcVArMYsEfULq4
 Tu5Jme01/ntb8GQPFbFPBpD2XXSIsbul+glcDCoSHMjD4/YT4R2/BtWdpWPJKFGlZTlD
 P5II7rSj01mUp9T3oI9k8FivHI7WiC+Vp98ay8PwvccMxnwvpGLYG3helX5XTqAwRtgc
 G4zB0k7e5dnvFvumRKEeosshNUOHUAY5qet8s/YAVRJz4nCxYHTOY3qJTCCUMWF8Vw6I
 QzNg==
X-Gm-Message-State: AOAM5338ux1D5N9RHsiArm6UM+PYQ5rNZpjXaRzsaSl4UGe9nxG8zFRW
 hTxM0/lnX6Bz1jRVc+38S4ufphQfNVm8Qh0iBQaI+n8YYfZ8qd/dyma3ii2QdF3kXmeAf+1lES1
 jK4l+buHPpFYGKJ4=
X-Received: by 2002:a1c:7c17:: with SMTP id x23mr5964778wmc.30.1599040382282; 
 Wed, 02 Sep 2020 02:53:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxulEPZyLk9hmZykbgiE9hg3ckhcFUUgLb0NHjAUxd3/4OdojbJgJhmnA2ANEiERCFAbkScwQ==
X-Received: by 2002:a1c:7c17:: with SMTP id x23mr5964752wmc.30.1599040382004; 
 Wed, 02 Sep 2020 02:53:02 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id f14sm6542217wrv.72.2020.09.02.02.53.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 02:53:01 -0700 (PDT)
Subject: Re: [PATCH 5/5] util/qsp: Do not declare local variable only used for
 assertion
To: Greg Kurz <groug@kaod.org>
References: <20200902080801.160652-1-philmd@redhat.com>
 <20200902080801.160652-6-philmd@redhat.com>
 <20200902111112.251568b8@bahia.lan>
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
Message-ID: <f69d4081-a297-a9ca-b5c9-39efff9fa3ca@redhat.com>
Date: Wed, 2 Sep 2020 11:53:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902111112.251568b8@bahia.lan>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:42:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 11:11 AM, Greg Kurz wrote:
> On Wed,  2 Sep 2020 10:08:01 +0200
> Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> 
>> This variable is used once in an assertion. Remove single
>> declaration and access directly in the assert().
>>
>> See in "qemu/osdep.h":
>>
>>  *                                  [...] disable assertion is not
>>  * supported upstream so the risk is all yours.  Meanwhile, please
>>  * submit patches to remove any side-effects inside an assertion, or
>>  * fixing error handling that should use Error instead of assert.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  util/qsp.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/util/qsp.c b/util/qsp.c
>> index 7d5147f1b20..1db044ecedd 100644
>> --- a/util/qsp.c
>> +++ b/util/qsp.c
>> @@ -560,9 +560,7 @@ static void qsp_iter_diff(void *p, uint32_t hash, void *htp)
>>  
>>      /* No point in reporting an empty entry */
>>      if (new->n_acqs == 0 && new->ns == 0) {
>> -        bool removed = qht_remove(ht, new, hash);
>> -
>> -        g_assert(removed);
>> +        g_assert(qht_remove(ht, new, hash));
> 
> Urgh... this is doing exactly the opposite of the "qemu/osdep.h"
> recommandations above. We still want to remove new from the
> hash table even if QEMU was built without assertions.

Oops you are right :/

> 
>>          g_free(new);
>>      }
>>  }
> 


