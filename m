Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2ACC76195
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 07:55:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23CEA20880
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 07:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="N0h16r78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23CEA20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho1GG-00063b-Eu
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 03:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40879)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aik@ozlabs.ru>) id 1ho1G4-0005U7-24
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 03:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1ho1G2-0002FZ-Qf
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 03:55:20 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45590)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ho1G2-0002En-Bv
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 03:55:18 -0400
Received: by mail-pg1-x544.google.com with SMTP id o13so12485281pgp.12
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 00:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6l+BaGNpVfBZL988gX1Uk/8JYFgoehkxg6UYZmWhSrA=;
 b=N0h16r78RNk7fJM1AMAHtvnAkojmn43MU+zyK60GYYbvLK1LvHqYQTgldWDR3apu2k
 aIoIFNsUvyqzW7g581e/MXIykE0hbh0yVGra8AcUe33S126PczxDNQBoi4nlbOZWMIxk
 utUk12QXUK+ynyfRVrdt5Z8t8b+7Ymulnruhsrj2LDbZ0VHlkGReUvyds7J8PH02psZq
 DTFlkM8JqrkZBxSdBfphttRlv0ItHvnmLeRBkxo0bXqD5bLGZJB+fT5DixoACICBwCr4
 trD/YpST1YJzpKMahj4Uxt+IfgJr3Vma8abzuGzGM/Irr/tirInyEhZObH6mSnDV+Fr6
 l6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6l+BaGNpVfBZL988gX1Uk/8JYFgoehkxg6UYZmWhSrA=;
 b=TNy8IaDE5zgA2QxbKa4oUCcTlPYKcAiNWEb1KZVfjcWF8Sd2UUiK5o8ROOmhz1YORh
 ib7pf9NNGF/gkjisuW2rmVMWBRPDtrJrEwCvzh9MswAIhe0Yu8Crq9wAImA9npSSBPis
 BQEv9rgdmvd2ATsca4ZAp0QN7icQwCK0wMJhLcQhQCiikxmrSSG4aNwIYNopOd1Nx+D8
 O2LQH6p4OXrltEX4pkxpT8W8irTF/7N6twXbwwr0ggkETsN6cksmqydGWc1T5Urmt6rz
 546ZpMztJnbXoNwfYgm6ANtu1SjWrE+SYmMSWNwzZmfOZdZoxYKl3kn/aOJOgAYuHMkg
 rhIg==
X-Gm-Message-State: APjAAAUBs7PtjWvIvcf7O6DCZi6zkbb76a0JBzNZMyBDBa+GtRcLwPQa
 ED0wqxfwQAvNQIv1o12ll2E=
X-Google-Smtp-Source: APXvYqw4nU4vYXHtjFFHbZ6utgKu1r6JSke1eBCiLyA70gplTAYksA3W5aGRM5CUFej/iJtbhOWmZQ==
X-Received: by 2002:a17:90a:ac14:: with SMTP id
 o20mr50066325pjq.114.1563436516605; 
 Thu, 18 Jul 2019 00:55:16 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id a128sm25177344pfb.185.2019.07.18.00.55.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Jul 2019 00:55:15 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190716053522.78813-1-aik@ozlabs.ru>
 <8b727864-1634-0a5d-c557-fcaa52c49434@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <9587706e-d53c-5490-cb4a-4c89eadfc497@ozlabs.ru>
Date: Thu, 18 Jul 2019 17:55:12 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8b727864-1634-0a5d-c557-fcaa52c49434@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [RFC PATCH qemu] spapr: Stop providing RTAS blob
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 18/07/2019 17:20, Thomas Huth wrote:
> On 16/07/2019 07.35, Alexey Kardashevskiy wrote:
>> SLOF implements one itself so let's remove it from QEMU. It is one less
>> image and simpler setup as the RTAS blob never stays in its initial place
>> anyway as the guest OS always decides where to put it.
>>
>> This totally depends on https://patchwork.ozlabs.org/patch/1132440/ ,
>> hence RFC.
> 
> Patch looks basically fine for me, but I wonder whether we should wait
> for one or two releases until we really remove it from QEMU, so that it
> is still possible to test the latest QEMU with older SLOF releases for a
> while (which is sometimes useful when hunting bugs). Or should this
> maybe even go through the official deprecation process (i.e. with an
> entry in qemu-deprecated.texi)?

I worry more about slof being distributed as a separate package in RHEL, 
easy enough to get qemu/slof out of sync.


-- 
Alexey

