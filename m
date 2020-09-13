Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69076C43461
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 15:33:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA1C42078D
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 15:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7xYhhMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1C42078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHTzx-0002fi-SL
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 11:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHTys-0001kb-LD
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 11:31:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34665)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHTyq-000670-MO
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 11:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600011111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VZQPT/4v+63TRRddlsE3lwAOypPyg10G/q0ewL1l2Fw=;
 b=N7xYhhMtHqP/bvoo3E/daK1FA0eysbprnVHKcj/4ZgeWVhSic5Dxgf21alC5fTUHadtXQu
 GnWEFe/n53CO0lnNDMID/wTROJq0f1yjq1Op0lb5448+9vaTwWlQ7+irRemurK49pSNF4p
 mj8NlyJI5r+ypRYFIuMgZw9O3ef6SIo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-zN0qpTBvNYG41kd6sOqAaQ-1; Sun, 13 Sep 2020 11:31:50 -0400
X-MC-Unique: zN0qpTBvNYG41kd6sOqAaQ-1
Received: by mail-wr1-f71.google.com with SMTP id g6so5701475wrv.3
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 08:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=VZQPT/4v+63TRRddlsE3lwAOypPyg10G/q0ewL1l2Fw=;
 b=FJuYYxWPqXeAQZiRZeMv+nHTvJlTlOxDilgS0tDd0OZ+OHK64xtq5rbusAx5d995dl
 jiPpGQ2VscTKoJGxLZubVGetH4VcF6vSDtkdY+mbIPgSlI2fSpPVv+YBLmFZskbZilSx
 +oyLP81tavdu5Z4gSuGomS6NCJ3MLCYPhjh9uUk3fpgnew66+/e2P7YFnocZX6I9+ujP
 i3L+aqlokK1C2hzx04Z+RzMCvwQcPGE4yU3ihw+Bb2CujoxbYKw01ZfVVw+0v84hZOmf
 S4noM/2oZTSItZ+8pyFNhUBLr3IfJ11OVMG1zNoyavmmaS/I8DeRxvDKKDmVzWqeeLda
 0Z4A==
X-Gm-Message-State: AOAM530L2jmyAOi7cQZf/kUBRSHg4uSpL2UL3C9QocqWRxmC/VsQa9vi
 MyMdP9pU0xbVsmM0J0G/u9sYyprUzyo+8d/xMKEwQIc5FwnqXia8yxi0iWAC4fdZW7UZ47fkzGP
 y/V+ygJaYtAyYEbA=
X-Received: by 2002:a1c:6487:: with SMTP id y129mr11635863wmb.90.1600011108794; 
 Sun, 13 Sep 2020 08:31:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxA8uD43kvJMezBNTWyU6bDgAbzQu7B7RCJXFeempPbrS6VDRCnRFHPYTtBJo6PXqhgptWJg==
X-Received: by 2002:a1c:6487:: with SMTP id y129mr11635831wmb.90.1600011108491; 
 Sun, 13 Sep 2020 08:31:48 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id i6sm17395981wra.1.2020.09.13.08.31.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2020 08:31:47 -0700 (PDT)
Subject: Re: [PATCH v8 12/27] gcrypt: test_tls_psk_init should write binary
 file instead text file.
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <20200912224431.1428-13-luoyonggang@gmail.com>
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
Message-ID: <600fe2fb-3c24-d0ee-419e-0ba973a0e120@redhat.com>
Date: Sun, 13 Sep 2020 17:31:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200912224431.1428-13-luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 11:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/13/20 12:44 AM, Yonggang Luo wrote:
> On windows, if open file with "w", it's will automatically convert
> "\n" to "\r\n" when writing to file.

This is one change.

> 
> Convert unlink to use g_remove.

This is another (unrelated) change.

We expect patches to be atomic (only one change at
a time). Can you split this patch in 2?

> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  tests/crypto-tls-psk-helpers.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/crypto-tls-psk-helpers.c b/tests/crypto-tls-psk-helpers.c
> index a8395477c3..58888d5537 100644
> --- a/tests/crypto-tls-psk-helpers.c
> +++ b/tests/crypto-tls-psk-helpers.c
> @@ -26,13 +26,15 @@
>  #include "crypto-tls-psk-helpers.h"
>  #include "qemu/sockets.h"
>  
> +#include <glib/gstdio.h>
> +
>  #ifdef QCRYPTO_HAVE_TLS_TEST_SUPPORT
>  
>  void test_tls_psk_init(const char *pskfile)
>  {
>      FILE *fp;
>  
> -    fp = fopen(pskfile, "w");
> +    fp = fopen(pskfile, "wb");
>      if (fp == NULL) {
>          g_critical("Failed to create pskfile %s", pskfile);
>          abort();
> @@ -44,7 +46,7 @@ void test_tls_psk_init(const char *pskfile)
>  
>  void test_tls_psk_cleanup(const char *pskfile)
>  {
> -    unlink(pskfile);
> +    g_remove(pskfile);
>  }
>  
>  #endif /* QCRYPTO_HAVE_TLS_TEST_SUPPORT */
> 


