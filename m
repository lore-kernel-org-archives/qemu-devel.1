Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151D3C3A5A3
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 03:28:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D46CA217F5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 03:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="0sMBQq2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46CA217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2odd-000861-Hx
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 23:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1i2ocZ-0007dt-3O
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 23:27:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1i2ocX-0003wA-1H
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 23:27:41 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:44777)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1i2ocW-0003vV-Jl
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 23:27:40 -0400
Received: by mail-pl1-x643.google.com with SMTP id t14so516272plr.11
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 20:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZTwNtYb7EOzPSEZnqkdux3/fFS5BoQ98K9pOL5VEUyI=;
 b=0sMBQq2F20LUZN8Hf0kzEs06Qoz6uj8MSOenWBHUdwxO37ixL3VpMqb/6LFgEyd637
 /b6OSpQixco4Ui6GeSY2KzKPF7X2LLVBMQ/IOOvVVrYJkJeS0KV3tix33tSDzMOoAxas
 WxjDTbr2+/qrqahenrOrtyNao1Y0EWpMI8MhJ62sBcxPCQp7guwrwbAUmy18XEZQ/ead
 /XNiZjDuGXl1L7lGXInZnqp5Rudne43j1KDs5rw5UaM3FtBYSGifoIH44A2joT+4y1qT
 hYliDavmVqWVaZpPXLRRwWYvJVO5nhplXXq/fuk4fQ5jSYXA5+YrRfqIezwnAQROprgJ
 MyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZTwNtYb7EOzPSEZnqkdux3/fFS5BoQ98K9pOL5VEUyI=;
 b=WmWClwv9tuWm0APzfOr3LHfF4HgJImKf8K9euSZimf+iJoXi8reAcsTJnUKE2wJzLT
 cVzoTxbXdfNIgBQsU4qR04W7IcO8LLCsOc0og5yIdzJDgvRis8iDsO7k9lQgngXXs1+1
 RoWeJIXvrCTq+cMggBJXBP/0dqenhH4jd8C6Su8Zr76ysBixmrgYOAHtsWTQdEEWB5xc
 ZSxTwBXO6TCSpfmZ1bJW9Smk4dgmrB4HImEKDP7GdKHaG/GFKZkoEcgLpQAXSbpJfCAy
 T4+U4wZGya6fwXBL2yNuk7I+IpquP5Jabi5GXH1fBMTZMLgt4VoO9+mVtyW62UK9P64w
 KtbA==
X-Gm-Message-State: APjAAAU5Su2rns+qXCBbSpAcF52FgvfpXLa915SXsMZOsdix/edYyMsN
 +YGyP6rG3BRS2rWULuRToGYeEMQyHL0=
X-Google-Smtp-Source: APXvYqxDC3OzR0djLNUx28u3hSptc2wymCKGy/7TGNiDJBMNyW6b2JRivQabT1KP17WbtTrQsOSMUA==
X-Received: by 2002:a17:902:1002:: with SMTP id
 b2mr2151357pla.336.1566962859143; 
 Tue, 27 Aug 2019 20:27:39 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id c13sm813483pfi.17.2019.08.27.20.27.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Aug 2019 20:27:38 -0700 (PDT)
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190827065650.107319-1-aik@ozlabs.ru>
 <20190828004634.GB16825@umbus.fritz.box>
 <20190828021237.GD16825@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <2ee9df47-1536-f2e3-9892-b4868ec359c2@ozlabs.ru>
Date: Wed, 28 Aug 2019 13:27:35 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828021237.GD16825@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [GIT PULL for qemu-pseries] spapr: Render full FDT
 on ibm, client-architecture-support
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 28/08/2019 12:12, David Gibson wrote:
> On Wed, Aug 28, 2019 at 10:46:34AM +1000, David Gibson wrote:
>> On Tue, Aug 27, 2019 at 04:56:50PM +1000, Alexey Kardashevskiy wrote:
>>> The following changes since commit d6bb8b27204eaa58f1da948b65454e3a598ab2a4:
>>>
>>>    pseries: Update SLOF firmware image (2019-08-27 16:47:04 +1000)
>>>
>>> are available in the Git repository at:
>>>
>>>    git@github.com:aik/qemu.git tags/qemu-slof-20190827
>>>
>>> for you to fetch changes up to da9960a5aaa25d27c9798c3d94c7b4c2d8af31ac:
>>>
>>>    spapr: Render full FDT on ibm,client-architecture-support (2019-08-27 16:47:46 +1000)
>>>
>>> ----------------------------------------------------------------
>>> Alexey Kardashevskiy (1):
>>>        spapr: Render full FDT on ibm,client-architecture-support
>>>
>>>   hw/ppc/spapr.c | 90 +++++++---------------------------------------------------
>>>   1 file changed, 10 insertions(+), 80 deletions(-)
>>>
>>>
>>> *** Note: this is not for master, this is for pseries
>>>
>>
>> Merged, thanks.
> 
> Urgh.  And the qemu change is now un-merged.  Alas, as soon as we had
> a CAS reboot for XIVE the guest didn't boot on the second attempt.
> Haven't had a chance to investigate yet.

QEMU command line, guest kernel version? I'd give it a try.



-- 
Alexey

