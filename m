Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6C5C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:28:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E873721741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGkPR/1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E873721741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izi8p-0007F9-2n
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 09:28:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1izi6x-0004Zt-TR
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:26:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1izi6w-0005cd-Sf
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:26:31 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38426)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1izi6u-0004yM-F6; Thu, 06 Feb 2020 09:26:28 -0500
Received: by mail-pl1-x642.google.com with SMTP id t6so2418747plj.5;
 Thu, 06 Feb 2020 06:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dgvelOjxXepWDkCo+aQxeDvybFNaShgsH498mYyRW24=;
 b=YGkPR/1HaAW5MnJvS47pmUITdfddFk8EqCzyjCkUqLeES5Q5u4MWiIvXVsIKZe6cJO
 gdKaznoFskLynbg/XCtE31NqDhqvHA5xnpWxmuqpn+/DZHuZ9KnVX5xPjrh7NSFgRy6R
 dUD0TzutqBXEVfa8yfhHKGaLBMxPW5h5msiHp9+VJStZrDzwOqwnElosaqIaLsg4kh34
 Zknab0wO6aLKRq0Fv7m0O6Z1ejI3aF3liEFx/p7z5UW+b0x5roT2ltvU+KojPE0Dg4TX
 EtPomucQRzrf3C8OgXbS0oEe7tyJwrDNeOXkXwSgS0qpxPrllnNPph3tL2MSTNMaWsF2
 q6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dgvelOjxXepWDkCo+aQxeDvybFNaShgsH498mYyRW24=;
 b=rtdGw7HRcw55qIcVLAHlt5A96meN6frDw07mXUh9ijtDxEmuvinYbpQQq+ZUxIxesR
 hd4d4ixKPT7clhQyi9rWyhfWfY9/k4QU0GtDWoY0M85ZVcML2Ikc8RNfNM1IxEmjdhl0
 5CTaZ4Ntp6t10UQJK206PTkIKeNP8jEuEvW27n9AZc24kLs0KVKRKNph3E/UjObJ4iwq
 i67lkJvDL5rg0Lip+tenE8ue0nBp+3+KAdV1pPUOQiT1XYNNK+Dijtzg+3GmWp3kKtje
 kRMx+IsLrastCHJtwCGGokFOpWqA4VevLyOzgwx9D2W4RLhs4ylUybSNJdDDUwMIlviU
 Mr6Q==
X-Gm-Message-State: APjAAAWa77tozXiRYn64JwxiuwJutPCvLs6af6wv/3c/DXz10ixgxkRJ
 6FUoXK53gqaPPHwzo+gx+sY=
X-Google-Smtp-Source: APXvYqxbeNN2ZRneGxIUXb4P/bNjdmjUBBV3mVHfceTvpJs+g+RNgoAFRSJqWkH5uhyRXDEMkU7ByQ==
X-Received: by 2002:a17:902:b690:: with SMTP id
 c16mr4077065pls.320.1580999186314; 
 Thu, 06 Feb 2020 06:26:26 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 m12sm3722748pjf.25.2020.02.06.06.26.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 06:26:25 -0800 (PST)
Subject: Re: [PATCH 2/3] m25p80: Improve command handling for Jedec and
 unsupported commands
To: Joel Stanley <joel@jms.id.au>
References: <20200203180904.2727-1-linux@roeck-us.net>
 <20200203180904.2727-2-linux@roeck-us.net>
 <accf297f-0c54-7475-8817-c1014999a57d@kaod.org>
 <7fe70871-c0e3-4ff6-bfda-17b45aa50c5e@roeck-us.net>
 <22a96987-9548-1335-8b04-00167ed9491d@kaod.org>
 <20200205174345.GA7754@roeck-us.net>
 <CACPK8XesxroZii2-r-HTigW4-7Ahw4TQNG1r-YO2K09S7Ap9=Q@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <7318860e-4d6c-b7f8-182f-d0efa332973f@roeck-us.net>
Date: Thu, 6 Feb 2020 06:26:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CACPK8XesxroZii2-r-HTigW4-7Ahw4TQNG1r-YO2K09S7Ap9=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 11:04 PM, Joel Stanley wrote:
> On Wed, 5 Feb 2020 at 17:43, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Wed, Feb 05, 2020 at 11:08:07AM +0100, Cédric Le Goater wrote:
>>>
>>> ok. we will need to model SFDP one day.
>>>
>>> Are you using the OpenBMC images or do you have your own ?
>>>
>>
>> I am running images built from upstream/stable kernel branches.
> 
> I think Cédric was wondering which flash images and therefore
> filesystems you were using in your testing.
> 
Ah, ok. Sorry, misunderstood.

> I had a poke around here but I couldn't work out where 'mtd32' came from:
> 
> https://github.com/groeck/linux-build-test/blob/master/rootfs/arm/run-qemu-arm.sh
> 

mtd32 tells the infrastructure that the boot device is mtd (flash) with
32MB capacity. The infrastructure uses that to create the actual flash
image and to generate the qemu command line. The root file system is
is rootfs-armv5.ext2 (located in the same directory as the run script).
It was generated using buildroot.

Guenter

