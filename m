Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05372C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:32:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 381F92072E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCZNHtAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 381F92072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIu1e-0004Eu-4R
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 09:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kItxJ-0000dH-8M
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:28:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33105)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kItxG-000442-2v
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600349285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zE92His0GLYdt6oo1+crgYcgskgYVS4Yla3YCB7mQXQ=;
 b=fCZNHtAWsAPwNG5FJB8T4L7k680IuAlKp6Kh+Vp2h6FLkgsiqFHUra+Cys7gVVoMJeZ8ob
 T3wXiUh+qRovKEhhQ2q/7UlfXBO6IyqkrQWNGSsxdVzWOUV+4EKmibeosL0pVo+Bxi6Vgg
 Wkqc2N5PetpLDORG/ZRGhDPUGT/Qbro=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596--Dw1okNZOwWJ1-_Ifj7acQ-1; Thu, 17 Sep 2020 09:27:59 -0400
X-MC-Unique: -Dw1okNZOwWJ1-_Ifj7acQ-1
Received: by mail-wm1-f72.google.com with SMTP id l15so745670wmh.9
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 06:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=zE92His0GLYdt6oo1+crgYcgskgYVS4Yla3YCB7mQXQ=;
 b=dNjXV5dH/0Ce2tCloQPb+7gOEKNuZFIgI6bXqT6GhQysGEsuKOJ49jC2ufIZ64gVoO
 ZjlGjEk8iFpF9tJkKDNDHsWjSYtQxM6HR6X/0jO6JgMjSwb2mXL22NehdSn+JddNJjxq
 uV3UiwcXxG2hIQM3pHua7b2GQH4cYcDmymb4YgI+bBZsQ2qgrXYcamhy0xnznqDrojKs
 zRhhb4Z9UZD83zwuIdfnj4u97Vew5nP0EfhsfYg+0bfmQNTgHe/0Am8TnP/UqrUka0i9
 0HC+ZjI7SL3EhVKQ1RZ0R3dbHcogRtQTCD69t40OjDK+0q3dUMgJnxA1FC4L5gzWVA6s
 bqPQ==
X-Gm-Message-State: AOAM532gmhv1DluM+X38nuARV/Hf4qaFbRt5yG0aoyKOcxaEJH0WmB+t
 lqd0Md77efW6f+k0/o6YQW/JJxJO810Bori3WCWMnEgSrseIdx79Ad3VAbK1p+7IDWJg5YQah3G
 TR+vhsHSscECRvFk=
X-Received: by 2002:a5d:5281:: with SMTP id c1mr31909640wrv.184.1600349277470; 
 Thu, 17 Sep 2020 06:27:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0Q9vjUKiUw4pC5bHrSZu8AUTFdl0XbnkNYxlmGDipLt7brylM6Hcw4PmVQOmtHW2AzrTfEQ==
X-Received: by 2002:a5d:5281:: with SMTP id c1mr31909599wrv.184.1600349277078; 
 Thu, 17 Sep 2020 06:27:57 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id i3sm37953213wrs.4.2020.09.17.06.27.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2020 06:27:56 -0700 (PDT)
Subject: Re: [REPORT] Nightly Performance Tests - Wednesday, September 16, 2020
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <5f628ca9.1c69fb81.a40be.a654@mx.google.com>
 <CALTWKrUgbOmsJ75M68EfvgG_o7G_hkiXJiqSTBCdZ0pTsu6Sqg@mail.gmail.com>
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
Message-ID: <9e1b693b-3d83-1bdf-a7b7-fa0ee8fa106e@redhat.com>
Date: Thu, 17 Sep 2020 15:27:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CALTWKrUgbOmsJ75M68EfvgG_o7G_hkiXJiqSTBCdZ0pTsu6Sqg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/20 10:02 AM, Ahmed Karaman wrote:
> On Thu, Sep 17, 2020 at 12:07 AM Ahmed Karaman
> <ahmedkhaledkaraman@gmail.com> wrote:
>>
>> Host CPU         : Intel(R) Core(TM) i7-8750H CPU @ 2.20GHz
>> Host Memory      : 15.49 GB
>>
>> Start Time (UTC) : 2020-09-16 21:35:02
>> End Time (UTC)   : 2020-09-16 22:07:32
>> Execution Time   : 0:32:29.941492
>>
>> Status           : SUCCESS
>>
>> Note:
>> Changes denoted by '-----' are less than 0.01%.
>>
>> --------------------------------------------------------
>>             SUMMARY REPORT - COMMIT 8ee61272
>> --------------------------------------------------------
>>                     AVERAGE RESULTS
>> --------------------------------------------------------
>> Target              Instructions      Latest      v5.1.0
>> ----------  --------------------  ----------  ----------
>> aarch64            2 158 513 150       -----     +1.703%
>> alpha              1 914 947 541       -----     +3.522%
>> arm                8 076 527 003       -----     +2.308%
>> hppa               4 261 673 329       -----     +3.163%
>> m68k               2 690 293 359       -----     +7.134%
>> mips               1 861 902 263       -----     +2.484%
>> mipsel             2 008 240 685       -----     +2.676%
>> mips64             1 918 624 648       -----     +2.817%
>> mips64el           2 051 554 799       -----     +3.025%
>> ppc                2 480 174 328       -----     +3.109%
>> ppc64              2 576 701 038       -----     +3.142%
>> ppc64le            2 558 820 807       -----     +3.171%
>> riscv64            1 406 685 833       -----     +2.648%
>> s390x              3 158 140 071       -----     +3.119%
>> sh4                2 364 606 066       -----     +3.341%
>> sparc64            3 318 698 928       -----     +3.855%
>> x86_64             1 775 941 661       -----     +2.167%
>> --------------------------------------------------------
>>
>>                    DETAILED RESULTS
>> --------------------------------------------------------
>> Test Program: dijkstra_double
>> --------------------------------------------------------
>> Target              Instructions      Latest      v5.1.0
>> ----------  --------------------  ----------  ----------
>> aarch64            3 062 745 624       -----     +1.429%
>> alpha              3 191 842 908       -----     +3.695%
>> arm               16 357 299 506       -----     +2.348%
>> hppa               7 228 387 843       -----     +3.086%
>> m68k               4 294 056 834       -----     +9.693%
>> mips               3 051 314 790       -----     +2.423%
>> mipsel             3 231 546 887       -----      +2.87%
>> mips64             3 245 814 633       -----     +2.596%
>> mips64el           3 414 215 768       -----     +3.021%
>> ppc                4 914 556 467       -----      +4.74%
>> ppc64              5 098 137 458       -----     +4.565%
>> ppc64le            5 082 383 704       -----     +4.579%
>> riscv64            2 192 269 006       -----     +1.954%
>> s390x              4 584 587 692       -----     +2.898%
>> sh4                3 949 197 667       -----     +3.468%
>> sparc64            4 586 104 947       -----     +4.235%
>> x86_64             2 484 245 797       -----     +1.757%
>> --------------------------------------------------------
>> --------------------------------------------------------
>> Test Program: dijkstra_int32
>> --------------------------------------------------------
>> Target              Instructions      Latest      v5.1.0
>> ----------  --------------------  ----------  ----------
>> aarch64            2 210 360 293       -----     +1.501%
>> alpha              1 494 111 691       -----     +2.149%
>> arm                8 263 044 506       -----     +2.667%
>> hppa               5 207 306 045       -----     +3.047%
>> m68k               1 725 880 564       -----     +2.528%
>> mips               1 495 110 368       -----     +1.484%
>> mipsel             1 497 169 328       -----     +1.481%
>> mips64             1 715 421 334       -----     +1.894%
>> mips64el           1 695 209 677       -----     +1.909%
>> ppc                2 014 602 126       -----     +1.822%
>> ppc64              2 206 256 217       -----     +2.138%
>> ppc64le            2 197 967 863       -----     +2.145%
>> riscv64            1 354 884 068       -----     +2.394%
>> s390x              2 916 098 604       -----     +1.236%
>> sh4                1 990 693 666       -----     +2.678%
>> sparc64            2 874 142 164       -----     +3.827%
>> x86_64             1 554 138 606       -----      +2.13%
>> --------------------------------------------------------
>> --------------------------------------------------------
>> Test Program: matmult_double
>> --------------------------------------------------------
>> Target              Instructions      Latest      v5.1.0
>> ----------  --------------------  ----------  ----------
>> aarch64            1 412 417 224       -----     +0.312%
>> alpha              3 233 972 467       -----     +7.473%
>> arm                8 545 300 144       -----      +1.09%
>> hppa               3 483 516 785       -----     +4.466%
>> m68k               3 919 111 292       -----    +18.433%
>> mips               2 344 644 680       -----     +4.085%
>> mipsel             3 329 922 415       -----     +5.178%
>> mips64             2 359 029 035       -----     +4.075%
>> mips64el           3 343 640 141       -----     +5.166%
>> ppc                3 209 498 342       -----     +3.247%
>> ppc64              3 287 492 489       -----     +3.173%
>> ppc64le            3 287 139 805       -----     +3.172%
>> riscv64            1 221 606 224       -----     +0.277%
>> s390x              2 874 163 578       -----     +5.826%
>> sh4                3 544 104 659       -----      +6.42%
>> sparc64            3 426 093 790       -----     +7.138%
>> x86_64             1 249 074 159       -----     +0.335%
>> --------------------------------------------------------
>> --------------------------------------------------------
>> Test Program: matmult_int32
>> --------------------------------------------------------
>> Target              Instructions      Latest      v5.1.0
>> ----------  --------------------  ----------  ----------
>> aarch64              598 849 290       -----     +0.614%
>> alpha                372 421 527       -----     +0.673%
>> arm                  746 701 945       -----     +1.479%
>> hppa                 674 262 347       -----     +1.181%
>> m68k                 410 573 125       -----     +0.919%
>> mips                 499 569 698       -----     +0.505%
>> mipsel               499 534 043       -----     +0.504%
>> mips64               481 536 611       -----     +0.595%
>> mips64el             465 055 187       -----     +0.619%
>> ppc                  341 373 763       -----     +0.956%
>> ppc64                393 782 076       -----     +0.962%
>> ppc64le              393 946 608       -----     +0.957%
>> riscv64              351 686 870       -----     +0.778%
>> s390x                494 453 514       -----     +0.604%
>> sh4                  402 832 141       -----      +0.94%
>> sparc64              495 859 747       -----     +1.173%
>> x86_64               403 090 322       -----     +0.874%
>> --------------------------------------------------------
>> --------------------------------------------------------
>> Test Program: qsort_double
>> --------------------------------------------------------
>> Target              Instructions      Latest      v5.1.0
>> ----------  --------------------  ----------  ----------
>> aarch64            2 709 844 598       -----     +2.423%
>> alpha              1 969 441 131       -----     +3.679%
>> arm                8 323 162 789       -----     +2.589%
>> hppa               3 188 306 263       -----       +2.9%
>> m68k               4 953 945 309       -----    +15.153%
>> mips               2 123 792 134       -----     +3.049%
>> mipsel             2 124 245 545       -----     +3.049%
>> mips64             1 999 032 821       -----     +3.404%
>> mips64el           1 996 422 106       -----     +3.408%
>> ppc                2 819 292 527       -----     +5.436%
>> ppc64              2 768 174 645       -----     +5.512%
>> ppc64le            2 724 770 326       -----     +5.602%
>> riscv64            1 638 311 731       -----      +4.02%
>> s390x              2 519 121 025       -----     +3.364%
>> sh4                2 595 705 920       -----     +3.001%
>> sparc64            3 988 891 870       -----     +2.744%
>> x86_64             2 033 622 123       -----     +3.242%
>> --------------------------------------------------------
>> --------------------------------------------------------
>> Test Program: qsort_int32
>> --------------------------------------------------------
>> Target              Instructions      Latest      v5.1.0
>> ----------  --------------------  ----------  ----------
>> aarch64            2 193 564 781       -----     +2.924%
>> alpha              1 521 270 291       -----     +4.191%
>> arm                3 465 576 821       -----     +2.759%
>> hppa               2 280 027 399       -----     +3.821%
>> m68k               1 843 184 147       -----     +3.583%
>> mips               1 557 902 048       -----     +3.854%
>> mipsel             1 560 659 413       -----     +3.851%
>> mips64             1 563 400 635       -----     +4.411%
>> mips64el           1 542 675 391       -----     +4.474%
>> ppc                1 728 740 551       -----     +3.667%
>> ppc64              1 842 432 964       -----     +3.555%
>> ppc64le            1 791 790 880       -----     +3.659%
>> riscv64            1 348 869 693       -----     +4.654%
>> s390x              2 184 089 336       -----      +3.32%
>> sh4                1 946 651 461       -----     +3.632%
>> sparc64            3 452 122 741       -----     +2.934%
>> x86_64             1 813 701 223       -----     +3.546%
>> --------------------------------------------------------
>> --------------------------------------------------------
>> Test Program: qsort_string
>> --------------------------------------------------------
>> Target              Instructions      Latest      v5.1.0
>> ----------  --------------------  ----------  ----------
>> aarch64            2 592 362 540       -----     +2.473%
>> alpha              1 855 815 639       -----     +3.486%
>> arm                7 347 821 471       -----     +2.684%
>> hppa               4 758 745 598       -----     +3.542%
>> m68k               2 376 781 988       -----     +3.566%
>> mips               2 166 448 905       -----     +2.525%
>> mipsel             2 163 390 872       -----     +2.528%
>> mips64             2 029 239 289       -----     +3.117%
>> mips64el           2 011 623 990       -----     +3.144%
>> ppc                2 492 961 613       -----     +2.674%
>> ppc64              2 464 688 318       -----     +2.487%
>> ppc64le            2 445 219 975       -----     +2.504%
>> riscv64            1 625 026 163       -----     +3.952%
>> s390x              4 194 618 628       -----     +6.623%
>> sh4                2 164 283 129       -----     +3.173%
>> sparc64            4 299 396 665       -----     +4.062%
>> x86_64             2 940 164 421       -----     +2.639%
>> --------------------------------------------------------
>> --------------------------------------------------------
>> Test Program: search_string
>> --------------------------------------------------------
>> Target              Instructions      Latest      v5.1.0
>> ----------  --------------------  ----------  ----------
>> aarch64            2 487 960 855       -----     +1.946%
>> alpha              1 680 704 675       -----     +2.834%
>> arm               11 563 308 846       -----     +2.849%
>> hppa               7 272 834 358       -----     +3.263%
>> m68k               1 998 813 614       -----     +3.198%
>> mips               1 656 435 485       -----     +1.949%
>> mipsel             1 659 456 983       -----     +1.947%
>> mips64             1 955 522 831       -----     +2.446%
>> mips64el           1 943 596 136       -----     +2.462%
>> ppc                2 320 369 235       -----     +2.333%
>> ppc64              2 552 644 142       -----     +2.742%
>> ppc64le            2 547 347 296       -----     +2.747%
>> riscv64            1 520 832 915       -----     +3.157%
>> s390x              5 497 988 198       -----     +1.078%
>> sh4                2 323 379 889       -----     +3.417%
>> sparc64            3 426 979 505       -----     +4.726%
>> x86_64             1 729 496 637       -----     +2.814%
>> --------------------------------------------------------
>>
>>
> 
> Hi,
> 
> For anyone following these nightly tests, I will not be able to send
> the performance reports starting from today until the end of next week
> as I won't be able to access my PC for this period of time.
> I've been running these nightly tests locally on my machine for about
> a month now. I'm currently in contact with Mr. Alex Bennée to run the
> tests independently on QEMU servers.

FYI I filled the m68k perf degradation here:
https://bugs.launchpad.net/qemu/+bug/1895703
(I didn't add you because I couldn't find you on Launchpad).

Enjoy this time without PC! :)

Phil.


