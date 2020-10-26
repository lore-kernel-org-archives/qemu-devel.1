Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC61C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:53:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9006C20791
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+5uPfsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9006C20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6gU-0007xY-Ko
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX6AL-0000p8-Jc
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:20:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX6AH-00006t-UJ
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603732812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ykof1hbJtqIcuVoIi96MWeulNjqmlmjeonGQCj55wFI=;
 b=S+5uPfsJFt5Xe52jlwqhRtYk9PZCRmci982m5QTjg9r5X5h3ojJSlB+EZge1aoIANkfW4n
 8FU+gF4QrL8BNRvD4ZsDZyn0wVV3XSlCPf8Jf/jwIXrmfVixGQQ63vV03bXxW5Ei39NKL/
 AWZn2JJEQjfiTRNJDuvbJDPssBJtxUM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-FFnX4so5Nuynp42xc8JKQw-1; Mon, 26 Oct 2020 13:20:08 -0400
X-MC-Unique: FFnX4so5Nuynp42xc8JKQw-1
Received: by mail-ej1-f72.google.com with SMTP id z18so5552233eji.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 10:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ykof1hbJtqIcuVoIi96MWeulNjqmlmjeonGQCj55wFI=;
 b=UPrWYA4Lw+BZ11/3StBmhX8bzPlfrNy2YTV8Y8/SMcYL2u+BxuAdkF1ap1VFXhQqVF
 44B75nebbkvRmYcQ/qNAA4iN0cX14+XFUk0E8Z8gamBgtpLXteRP2BvzfE116AlGoubU
 jnTwlhuE+Wj4UXmVkMI8vTNZYG61NyH1jWxHcMNBNlIdHmas7j9bhIWWc6p1TIRCYuLJ
 iuliOof4Kk+qf+r5LOuv8nKuVGwPXfBL+CUTNnrUPqXr/b8TNiNmXrjzD/hYDATUJCLj
 UwIk4x0UQuoG0wsM/rTCoZDnZntalgUIzPXJSRYwZjclJLoMwJ5Q30kDdPahHb3P9j2c
 VWTg==
X-Gm-Message-State: AOAM532X2tUWqmCOfViP1Bz3bo5z1hYS3U3m9Lq6gQjfPGUMFJCY/hcb
 r3gSJOQtyttqCsLlkkBmCCrZOyY3Fe6cfKt9Z8GA9YliCbpnG/HOO35WtopT8IJ6ViLkDAWHKtJ
 sUDH4k2KuhY+in6s=
X-Received: by 2002:aa7:cb82:: with SMTP id r2mr16597760edt.306.1603732807461; 
 Mon, 26 Oct 2020 10:20:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGnRRCetvvHXPG/+Cj7fjIjtexcBL5FLsVBhkslF0dszV6Ma0/NaDNRbMx/OX/SZ2nmLakQQ==
X-Received: by 2002:aa7:cb82:: with SMTP id r2mr16597744edt.306.1603732807285; 
 Mon, 26 Oct 2020 10:20:07 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id bt16sm6248638ejb.89.2020.10.26.10.20.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 10:20:06 -0700 (PDT)
Subject: Re: [PATCH 0/6] tests/acceptance: Test the Fuloong 2E machine
To: qemu-devel@nongnu.org
References: <20201021105035.2477784-1-f4bug@amsat.org>
 <4a82d8e0-5c3d-532e-495c-c3db65f32b67@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1d32ced0-57da-c8e4-e00d-463245f5e65d@redhat.com>
Date: Mon, 26 Oct 2020 18:20:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <4a82d8e0-5c3d-532e-495c-c3db65f32b67@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Huacai Chen <zltjiangshi@gmail.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/20 9:50 AM, Philippe Mathieu-Daudé wrote:
> On 10/21/20 12:50 PM, Philippe Mathieu-Daudé wrote:
>> Philippe Mathieu-Daudé (6):
>>    tests/acceptance: Remove unused import
>>    tests/acceptance: Use .ppm extention for Portable PixMap files
>>    tests/acceptance: Extract tesseract_available() helper in new
>>      namespace
>>    tests/acceptance: Introduce tesseract_ocr() helper
>>    tests/acceptance: Test Linux on the Fuloong 2E machine
>>    tests/acceptance: Test PMON on the Fuloong 2E machine
>>
>>   MAINTAINERS                                |   1 +
>>   tests/acceptance/machine_m68k_nextcube.py  |  51 ++---------
>>   tests/acceptance/machine_mips_fuloong2e.py | 101 +++++++++++++++++++++
>>   tests/acceptance/tesseract_utils.py        |  46 ++++++++++
>>   4 files changed, 158 insertions(+), 41 deletions(-)
>>   create mode 100644 tests/acceptance/machine_mips_fuloong2e.py
>>   create mode 100644 tests/acceptance/tesseract_utils.py
> 
> Thanks, patches #1 and #2 applied to my acceptance-testing tree.

Dequeuing as Thomas already merged them.


