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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB688C35257
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:56:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28F1A206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CuiwPBgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F1A206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kONQW-0007Mv-62
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 11:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kONNj-0005q9-AY
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:54:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kONNg-0005sL-Rm
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601654039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jNhLb38RB5xuTM1T2eoZEbny90Y7kEvpq9cZK+wncLg=;
 b=CuiwPBgzfXlSZPnYqDAr7tSGILnoUlcKMMyq5OuVvnYgwuFZ1f+tEI+ZqVFLWbLJzrBZy6
 G9B8Zk16ATV+/vLOUcfB8WQhn+5IcobrbRqReYIs8/1BJHO8ms2d/6VinakNUJk9mrFYn2
 M54DzYR5hC2cLGM6z39K3+u71sMHQKQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-B3Z4Xy9LM7CLr01ueV4cdw-1; Fri, 02 Oct 2020 11:53:55 -0400
X-MC-Unique: B3Z4Xy9LM7CLr01ueV4cdw-1
Received: by mail-wr1-f71.google.com with SMTP id v5so695908wrs.17
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 08:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=jNhLb38RB5xuTM1T2eoZEbny90Y7kEvpq9cZK+wncLg=;
 b=QHGHaXYqf4g1Bm9cfdhmfCSwnyxLSVcPy4cOZINiygztPV5oXHOfSD79hDDfE2lfVp
 x/8PS/JbwgnIughF7VMhPZPGlMm/D/bad6Jw2CMKlpvSKhCuhIgJwhuRt2cObD/Du7fK
 Pjp19TDyiugSUMRedzyixNAMq7QvoOWaIpNipw2q43iVXEA2zlRUsvL3emo02lDr5jMC
 6haIFvUekTWpzewo02R5Sc8pQv51m7SGl272zm3ZvVFwuKq0IWRGa+tn7VTcJewMIO4e
 DxSX6T+UjdHJMCuHN00ndr2uPHUz1x8mmHEdyfCDRVr+XzWkqnT2LKt0lr8UHcn8X0al
 u9EQ==
X-Gm-Message-State: AOAM530WFoouU3dP4r0GGZtXyRo/Z7EF+4pLIM2+CZfJyHBgcGGeUi6Z
 +rJy/pCnPzY/9v01RSo3ze9sxZvLxVfs5CB4qtKjlaDbNzH3yBplcKIDqgclUuSy9SbgAx3bYvH
 yUmNBrvKn1m4WRMY=
X-Received: by 2002:a5d:6283:: with SMTP id k3mr3903725wru.191.1601654034095; 
 Fri, 02 Oct 2020 08:53:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCiAPlUoifDDsBiiE8b9VE0R5RzO0skSaAauhmPA959x2Os1D2SC3X1+tLNsr5xIK5XxgDNA==
X-Received: by 2002:a5d:6283:: with SMTP id k3mr3903709wru.191.1601654033882; 
 Fri, 02 Oct 2020 08:53:53 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id d9sm2093631wmb.30.2020.10.02.08.53.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 08:53:53 -0700 (PDT)
Subject: Re: [PATCH] gitlab-ci.yml: Only run one test-case per fuzzer
To: Thomas Huth <thuth@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 qemu-devel@nongnu.org
References: <20201002143524.56930-1-alxndr@bu.edu>
 <6564a712-71e5-460b-c9d6-1d2c245ff6ea@redhat.com>
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
Message-ID: <746477ee-01db-e52b-8348-c42aad18e9da@redhat.com>
Date: Fri, 2 Oct 2020 17:53:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <6564a712-71e5-460b-c9d6-1d2c245ff6ea@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.256, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/2/20 5:15 PM, Thomas Huth wrote:
> On 02/10/2020 16.35, Alexander Bulekov wrote:
>> With 1000 runs, there is a non-negligible chance that the fuzzer can
>> trigger a crash. With this CI job, we care about catching build/runtime
>> issues in the core fuzzing code. Actual device fuzzing takes place on
>> oss-fuzz. For these purposes, only running one input should be
>> sufficient.
>>
>> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>> Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  .gitlab-ci.yml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index a51c89554f..075c15d45c 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -303,7 +303,7 @@ build-oss-fuzz:
>>                        | grep -v slirp); do
>>          grep "LLVMFuzzerTestOneInput" ${fuzzer} > /dev/null 2>&1 || continue ;
>>          echo Testing ${fuzzer} ... ;
>> -        "${fuzzer}" -runs=1000 -seed=1 || exit 1 ;
>> +        "${fuzzer}" -runs=1 -seed=1 || exit 1 ;
> 
> ... but we're apparently already using a fixed seed for running the
> test, so it should be pretty much deterministic, shouldn't it? So the
> chance that the fuzzer hits a crash here for a pre-existing problem
> should be close to zero? ... so I'm not quite sure whether we really
> need this?

You are right, "non-negligible chance that the fuzzer can trigger a
crash" shouldn't be a problem. What matters is we don't waste CI
resources, 1 run is enough to test the fuzzer is working.

> Anyway, I certainly also won't object this patch, so in case
> anybody wants to merge it:
> 
> Acked-by: Thomas Huth <thuth@redhat.com>
> 


