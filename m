Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE691C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:45:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FEC1206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RObs0GL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FEC1206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOMJh-0003C6-Ef
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 10:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kOMHo-00012t-IF
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:43:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29962)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kOMHm-0004U3-Dk
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601649827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=G8FVA2pApPajgk5f0KCKkT+GbakwtULbBVubAzEKm1A=;
 b=RObs0GL2UOqs7/GXRFadfh8MNi9teFjwxNxAduv+YL2+6fZ3eWX9nTpAon111jGKbpg0+y
 p15m3xzrbbwwn6/fKIrlfVY8Xs/qZdmgQabc3zG1JEDnyce8jl3djesm77r+n6pZHy5bnK
 qqRJXlekH/rbRQcU7Kaoql1TXtdgp7g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-H6wFcP9WPQSTlXemRDbdiw-1; Fri, 02 Oct 2020 10:43:46 -0400
X-MC-Unique: H6wFcP9WPQSTlXemRDbdiw-1
Received: by mail-wm1-f72.google.com with SMTP id f2so602960wml.6
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 07:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=G8FVA2pApPajgk5f0KCKkT+GbakwtULbBVubAzEKm1A=;
 b=iin7MkNp1J6Yru6bWtrnmuNjZv/VFt1rtA1dMej99RlB/KG6FeLpxKW6vetzZjW+gU
 uDfWj/FJeid23rxaUspv5nE9+YSNpF56bO3vrhjrd4XJOV/TS16Rwf2k52g8iwR9fgyY
 QyHVQONCdXyn+O/8EDBW6iSFoOt6Rvtft+pg4pnhfU0SmaDSbEtuI+AeG7+9O6G5nprQ
 D4XqRYDiE4YZOp2V+JlwjzPMLsFrgMgvpryFsI4qd1362HTUwdTzT8sbZCqaoXAkE8LB
 hNtBBl0bKVbyMp1wfeIwoS1wWAYYMasuuKwUB/Ep4z2zZjYU5s6v5qwS9PMJ2UHwg0tr
 myEw==
X-Gm-Message-State: AOAM533Rak1KQnwqf1vEgBZ6Mqdq57auHbZ1aXkyAGrv1mcIGarWiv3c
 br9Mhl1D0zsPnswflLQS6ulG1PGeIbAeBL6VeX8UE+Q0gOosbGwnpaQgAqE0Caqh1CRt0a0CLp/
 TFl+HYGYLs8stY0Y=
X-Received: by 2002:a7b:c1c3:: with SMTP id a3mr3557215wmj.68.1601649824650;
 Fri, 02 Oct 2020 07:43:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaet1dusnBcmlCi+4ty0L2XyXfCbXqEw4wL8uVrkzBemP8QZTqTRMTU2i9VjCrOa36GR9C2g==
X-Received: by 2002:a7b:c1c3:: with SMTP id a3mr3557197wmj.68.1601649824458;
 Fri, 02 Oct 2020 07:43:44 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id b84sm2124448wmd.0.2020.10.02.07.43.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 07:43:43 -0700 (PDT)
Subject: Re: [PATCH] gitlab-ci.yml: Only run one test-case per fuzzer
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20201002143524.56930-1-alxndr@bu.edu>
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
Message-ID: <893310a2-b2bb-da3c-4a4f-ff037d304dde@redhat.com>
Date: Fri, 2 Oct 2020 16:43:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201002143524.56930-1-alxndr@bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.256, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/2/20 4:35 PM, Alexander Bulekov wrote:
> With 1000 runs, there is a non-negligible chance that the fuzzer can
> trigger a crash. With this CI job, we care about catching build/runtime
> issues in the core fuzzing code. Actual device fuzzing takes place on
> oss-fuzz. For these purposes, only running one input should be
> sufficient.
> 
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  .gitlab-ci.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index a51c89554f..075c15d45c 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -303,7 +303,7 @@ build-oss-fuzz:
>                        | grep -v slirp); do
>          grep "LLVMFuzzerTestOneInput" ${fuzzer} > /dev/null 2>&1 || continue ;
>          echo Testing ${fuzzer} ... ;
> -        "${fuzzer}" -runs=1000 -seed=1 || exit 1 ;
> +        "${fuzzer}" -runs=1 -seed=1 || exit 1 ;
>        done
>      # Unrelated to fuzzer: run some tests with -fsanitize=address
>      - cd build-oss-fuzz && make check-qtest-i386 check-unit
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


