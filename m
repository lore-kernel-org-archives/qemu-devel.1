Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE075C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:40:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9846820774
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CdqjMf4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9846820774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnl1r-0003JT-Rb
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 11:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnl1B-0002gv-GF
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:39:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51036
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnl18-0007B3-LS
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592926760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XY6ebUwbL66ALjwEfWPhUoEVjl2/AFfBvB/uhze7Oa4=;
 b=CdqjMf4jXga2Nvr4MWUI/VeqLVGl+pwxa0hQpZIYXumapWkRbz5jWRfLe4wP25hEBL70iK
 b4jVZ/b3Q0s4OsygDblzzsonCfeiiVenGVPTExf9/a+2NiD0aPkPKqubSkq57t1lBde0MR
 oUc0uhet+GstIHcjx3fHJIzuSQID8+E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-pchFJZRbN0qn5nd9WgQlBQ-1; Tue, 23 Jun 2020 11:39:16 -0400
X-MC-Unique: pchFJZRbN0qn5nd9WgQlBQ-1
Received: by mail-wr1-f71.google.com with SMTP id c14so16087386wrm.15
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 08:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=XY6ebUwbL66ALjwEfWPhUoEVjl2/AFfBvB/uhze7Oa4=;
 b=nTVh2WqIATOAaCyTCqw5PBCIIDpz0TrIDQ5iojIVmDBIzpMC3pi9TLKYiedaV4SHdD
 k++GC31Nxsc+Eo3P/n9c1QWxSFeTzbUMl0en9ZLKE9BLWoBc8WCXiDol887UFBarHqCs
 BcBt9W8TM6hmflMCAjsX9UkFC/3B9ZOjosggeVoIFkzbsF0GTXfn8Itqj8RFMjMFT82K
 POIVfQ1el69DV7pX49wsS/Lc4aDdnKpR2+vv/iI5UU5BnR1S9sKJ47IpWmOw5qlOIN00
 7rpy+8cBEh0g/1MWkkaM8YRblfU7jHz3c13MqTP8kWzQ0a6xhxbqzEgHsw5GxxIcW/kc
 bEWA==
X-Gm-Message-State: AOAM5326hLWt79jk+Yu91mu2F9ODSUGBNHYxLZ9DdJwPdhNTu4pFL4vQ
 LAS89iukOA3gY5fNM9BI1zRZWGqztSbegAbJIdY/ftwcLnpV5krCiPgRqOml5kY1fFAl1v96L1k
 lTITKIobikFZ5fIc=
X-Received: by 2002:adf:ea84:: with SMTP id s4mr14638706wrm.222.1592926755513; 
 Tue, 23 Jun 2020 08:39:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/xqaHbn/nlTfYy5aU5m96snoBoI33gMIzxBnaDzV8xjLYueYRaFwSySxr3SQnP7qZmjVjOw==
X-Received: by 2002:adf:ea84:: with SMTP id s4mr14638678wrm.222.1592926755206; 
 Tue, 23 Jun 2020 08:39:15 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id c2sm23818116wrv.47.2020.06.23.08.39.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 08:39:14 -0700 (PDT)
Subject: Re: [PATCH] Revert "tests/migration: Reduce autoconverge initial
 bandwidth"
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20200623145506.439100-1-mst@redhat.com>
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
Message-ID: <3554a068-ba6f-0aa0-38b4-b6dca3069630@redhat.com>
Date: Tue, 23 Jun 2020 17:39:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200623145506.439100-1-mst@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:55:08
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/23/20 4:56 PM, Michael S. Tsirkin wrote:
> This reverts commit 6d1da867e65f ("tests/migration: Reduce autoconverge initial bandwidth")
> since that change makes unit tests much slower for all developers, while it's not
> a robust way to fix migration tests. Migration tests need to find
> a more robust way to discover a reasonable bandwidth without slowing
> things down for everyone.

Please also mention we can do this since 1de8e4c4dcf which allow
marked the s390x job as "unstable" and allow it to fail.

But if nobody is going to look at it, instead lets disable
it until someone figure out the issue:

-- >8 --
diff --git a/.travis.yml b/.travis.yml
index 74158f741b..364e67b14b 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -507,6 +507,7 @@ jobs:

     - name: "[s390x] Clang (disable-tcg)"
       arch: s390x
+      if: false # Temporarily disabled due to issue testing migration
(see commit 6d1da867e65).
       dist: bionic
       compiler: clang
       addons:
---

With the hunk amended (no need to mention 1de8e4c4d actually):
Acked-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ---
>  tests/qtest/migration-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index dc3490c9fa..21ea5ba1d2 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1211,7 +1211,7 @@ static void test_migrate_auto_converge(void)
>       * without throttling.
>       */
>      migrate_set_parameter_int(from, "downtime-limit", 1);
> -    migrate_set_parameter_int(from, "max-bandwidth", 1000000); /* ~1Mb/s */
> +    migrate_set_parameter_int(from, "max-bandwidth", 100000000); /* ~100Mb/s */
>  
>      /* To check remaining size after precopy */
>      migrate_set_capability(from, "pause-before-switchover", true);
> 


