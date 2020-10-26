Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AB6C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 08:52:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 465E420663
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 08:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkAGDjL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465E420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWyFF-0008IG-9E
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 04:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kWyCq-0006oe-3v
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 04:50:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28352)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kWyCo-0003Fq-AT
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 04:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603702217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4bm62pVIYdQT0NND8IJm0yvmDo/j8KozGe/eNe7mYLw=;
 b=bkAGDjL46Cf+JWpT1D54QtJUT6TFa9M/mhuu4z4aY9bqQdztxwosRXBMDcz4K8qDiJMK0I
 gZVfVjE+p9nNSmadHKOgStviMMBFnIYfrKdCD1/P22aOg6mFlxU51APfUHu9/UQKqW6BRX
 4/RJkGh8YBjH9CSaPKw0feE8PHeacZ8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-N1cOn8ClMBSvYLp68oU_ZQ-1; Mon, 26 Oct 2020 04:50:15 -0400
X-MC-Unique: N1cOn8ClMBSvYLp68oU_ZQ-1
Received: by mail-wm1-f72.google.com with SMTP id s25so6061525wmj.7
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 01:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4bm62pVIYdQT0NND8IJm0yvmDo/j8KozGe/eNe7mYLw=;
 b=Xs6EUcgIgK2jeWzmu6nl6/gzhELZiSqTvhMsgRPB8Bh092fZzuvGSOaIAVhMVWtIFi
 vY7EzRl18E5VJv1hIdWNlxmmEsEGVXfFDpMte3iApfLWCjz1AbIOyJ4/+TgmbQ5NC+f6
 CekhvGfcRv0EFf88dv4MGUcrgbXch6p+dUdG+PgTpcOAnh2565z8WxNNwZvsV1PlSgEz
 bQktZlXoQdE5yRIqA5ZL7TgtGT5BYYhY1s3FkXRVrg2nrxnulEqf5QeYa3jCr5p9a5r3
 TRP+214JVRciiyMTIb4B9ClfuElLfkAI4MVgzM8tBLBpDUiUDqFpbpZVWK44n+D1BiLH
 56uQ==
X-Gm-Message-State: AOAM531LwE9xXtP+jvsUxIIX1VY0fjEzqcAH8keGtHgrYbHaQpD0J0vQ
 ceNLBja/h2rwE8KUbaAi23FFcsEqWXzBw/m3ui7ypwCgQE2KlT+8TPjoapJsQ11EwguJLLMVbY2
 Kr3NWb3YSIwAWf5E=
X-Received: by 2002:adf:e80f:: with SMTP id o15mr16810949wrm.308.1603702214701; 
 Mon, 26 Oct 2020 01:50:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyi2LBajNABcrkSXG51KwBa5ZDRxNkRYpXtiLA75c4nMLdKfYxYjUqsTEmzSHT1UPwNwKaQdw==
X-Received: by 2002:adf:e80f:: with SMTP id o15mr16810933wrm.308.1603702214537; 
 Mon, 26 Oct 2020 01:50:14 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id a17sm22446593wra.29.2020.10.26.01.50.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 01:50:13 -0700 (PDT)
Subject: Re: [PATCH 0/6] tests/acceptance: Test the Fuloong 2E machine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201021105035.2477784-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4a82d8e0-5c3d-532e-495c-c3db65f32b67@redhat.com>
Date: Mon, 26 Oct 2020 09:50:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021105035.2477784-1-f4bug@amsat.org>
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
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
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

On 10/21/20 12:50 PM, Philippe Mathieu-Daudé wrote:
> This series add tests for the MIPS Fuloong 2E machine.
> 
> I have been using these tests for over 1 year now.
> After recent discussions with Huacai and Mark regarding
> how to contribute tests for machines using private blob,
> I think it is time to publish this series, to see how
> the final part will be discussed, as it tests a blob
> which Lemote company doesn't publish the sources. The
> binary is know to work and has been used for various
> years on real hardware. Its MD5 is also know (I am not
> using SHA-1 because it has been published with MD5).
> 
> The idea is to be able to share tests without infringing
> licenses issues.
> 
> Please comment :)
> 
> Phil.
> 
> Philippe Mathieu-Daudé (6):
>    tests/acceptance: Remove unused import
>    tests/acceptance: Use .ppm extention for Portable PixMap files
>    tests/acceptance: Extract tesseract_available() helper in new
>      namespace
>    tests/acceptance: Introduce tesseract_ocr() helper
>    tests/acceptance: Test Linux on the Fuloong 2E machine
>    tests/acceptance: Test PMON on the Fuloong 2E machine
> 
>   MAINTAINERS                                |   1 +
>   tests/acceptance/machine_m68k_nextcube.py  |  51 ++---------
>   tests/acceptance/machine_mips_fuloong2e.py | 101 +++++++++++++++++++++
>   tests/acceptance/tesseract_utils.py        |  46 ++++++++++
>   4 files changed, 158 insertions(+), 41 deletions(-)
>   create mode 100644 tests/acceptance/machine_mips_fuloong2e.py
>   create mode 100644 tests/acceptance/tesseract_utils.py

Thanks, patches #1 and #2 applied to my acceptance-testing tree.


