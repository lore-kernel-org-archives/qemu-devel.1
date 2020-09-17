Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507F0C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 17:04:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F6D3206CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 17:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egV3DjpR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6D3206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIxKd-0006dG-HB
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 13:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIxHt-0003iq-Ge
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 13:01:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24502)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIxHq-0005Q4-Ev
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 13:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600362093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=67fKgAft+sJNq/MKgW8S3a1w3i5qeWx6p/YWGXtSgNU=;
 b=egV3DjpRiv5Rv3XxyHJu8nFfq1SK8VOeMkOeK2PQjBBAzTvUS8/xHT/YzIMILP8+ry1ZMm
 v95gJ+ijPu/p/G9feBX/BPw5EaDVNapHQcgfzRJLYspn9ALS/MkgzrzONwI0PCvGGq/O1j
 +b4my987pFBjxTJYgrOHKLgOsDVqGqg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-1ndBMkNCNtiRrJCa50egXw-1; Thu, 17 Sep 2020 13:01:26 -0400
X-MC-Unique: 1ndBMkNCNtiRrJCa50egXw-1
Received: by mail-wr1-f71.google.com with SMTP id x15so1112992wrm.7
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 10:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=67fKgAft+sJNq/MKgW8S3a1w3i5qeWx6p/YWGXtSgNU=;
 b=OMB1rYqyHlhoqsp+dPnRWq+Yhpy0c2VPKzucomjvwl9ALL7tbtSgF/dLllNmkd1C82
 4o7n2+cyjYJ6//WIlR5gJ0uPRlAr6bFw3p35kaZVtlSHunDQRAE/CNJvGekdPVwW6W12
 /LWpsNZ6OUw2HwU311b/X1RMBoScfaUojgSHGDfAcFdIvqGouTIPgYbLrngW7gKktqdF
 +oH15YcqzU+VwP1JN+f7WLP/Rht35bF44w9ySsqHQ4qwPx1TXUcpXqSSZsrmq8wY4q5C
 BawmxRKnjWzGq7FrsxVok4EISImS+aJgiPib/Y0Cknzy+6rD6LEaz5u38E+T7gaZkSVP
 /Y9A==
X-Gm-Message-State: AOAM532DBX1ct5HLsAiDu1K4jz7qG/aeAE0BJSGTlgW8qhZrPq/MGHdS
 wKsaYUCjg11prcEd/CPdD2bVlVkIe6CBlSoKULwjnOHEbJ2P2xeZ0Ncenb7DtJ4VFSTxsya3Bu7
 tPrnf9PPEkOoo8j8=
X-Received: by 2002:a1c:c256:: with SMTP id s83mr11115083wmf.93.1600362085010; 
 Thu, 17 Sep 2020 10:01:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9oMil8bqOf42o26mbehVUW5BTH8Go5KvmsJx2kSHEnzFUJf46geowch8uHLOdQs8LSgyvpQ==
X-Received: by 2002:a1c:c256:: with SMTP id s83mr11115048wmf.93.1600362084787; 
 Thu, 17 Sep 2020 10:01:24 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id k8sm245041wrl.42.2020.09.17.10.01.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2020 10:01:24 -0700 (PDT)
Subject: Re: [PATCH] tests/acceptance: Disable tests dependent of unreliable
 apt.armbian.com
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200917163954.50514-1-philmd@redhat.com>
 <308aaf63-a9a4-256e-a29f-9d0bd1c53532@redhat.com>
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
Message-ID: <450f5b49-6309-5806-9ab2-4fad6a06e180@redhat.com>
Date: Thu, 17 Sep 2020 19:01:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <308aaf63-a9a4-256e-a29f-9d0bd1c53532@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/20 6:53 PM, Thomas Huth wrote:
> On 17/09/2020 18.39, Philippe Mathieu-Daudé wrote:
>> Armbian servers are not very reliable and confused the GitLab CI
>> users a few times this month (path updated, archives moved, and
>> now the SSL: CERTIFICATE_VERIFY_FAILED "certificate has expired"
>> error). Time to disable these tests.
>> Users can still use the artifacts from the cache (or manually add
>> them to the cache).
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  tests/acceptance/boot_linux_console.py | 10 ++++++++++
>>  tests/acceptance/replay_kernel.py      |  2 ++
>>  2 files changed, 12 insertions(+)
> 
> These failures in the Gitlab-CI are quite annoying, indeed.

I'd rather not go via this path, but since we don't save the
artifacts cache, I can't find a better way to not block all
the other developers using GitLab CI.

But I prefer we disable the tests until something better
emerge, rather that having the developers stopping running
these tests. So this is a quick band-aid patch.

> 
> Acked-by: Thomas Huth <thuth@redhat.com>
> 

Thanks!

Phil.


