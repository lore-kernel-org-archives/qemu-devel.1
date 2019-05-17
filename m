Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1F2C04E87
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:03:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05D5E2087E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhEqC2mX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D5E2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48326 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRcWE-0003XG-86
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 09:03:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hRcSw-0001MP-MC
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:00:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hRcSv-0004ds-GS
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:00:02 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:39523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1hRcSv-0004al-4p
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:00:01 -0400
Received: by mail-ed1-x541.google.com with SMTP id e24so10460678edq.6
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 06:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=sm4IK8mTjMbbK1oBXVy4nB/0FIaM8FCZ/ND3BrEjTrI=;
	b=hhEqC2mX26uAhqO5Bt1bdwMuvr3n621wEHtSTir5ZwkCFByxN1SVTguYUYCmvYRL3o
	m4s3MkxZZ16BpkATxF8A3N4NCeRMkRwfgbAa+nDc+kbOjPLGc/6AdLuHzF/pfwdXC8lJ
	BXPYbjzKB5NZeayHsvveY1fK017QpVUm0LO/lGqDgFAHvnRBL1co2GGVo1A3nC/+cSjM
	32Ht0dqq1McQCAwryTKgv0h3coj9bNudxEjTfVtTRVCbpwTtT6STkReYlb9MQX8/KD1C
	QZh6iUa1JqOM15dXgVvyTkdax0268deFBf/ml33HM3Ap/j2R8zehWwrvLWMUfFwzErlL
	oI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=sm4IK8mTjMbbK1oBXVy4nB/0FIaM8FCZ/ND3BrEjTrI=;
	b=IwMzgIr5SOvEF3l7eM8Ne2NS9h/pRSThnNqU9FtAR8LykuXAI6BcaoiEzQjBkOMtq6
	XeKEoJS15V1hL5dOVw6WV5ajNsjlIg19o6bbKCUD4GLiT81WrIp4n5GWCFQKi2yZnlkR
	hw0+nHPvEs8aSorBiXcKn9jSt/H4tyZNpAkJAmOdyyK8Nw+DiaTzsNI5FJTCovWR9/cy
	G657IN/0Bdlaqw2s7eHUPuYNwOPscGn7ouy7aFiAY7keHWHJ/lOQnwFMpphDPZyGiZRv
	sI8bypK4o3qOwbeUtKdXJnTVKao4LKSceMNe2GrNrn2MtCZEUj9UreaadkoWGyxSpQFI
	MY8w==
X-Gm-Message-State: APjAAAV2AI1F1nuwJo88n2Yt9JQH+rbLfPPMKnLVfv/DPmsYfS1wBH+t
	Air14P7tWBrg79dVRO4YeqE=
X-Google-Smtp-Source: APXvYqyocR8Tk6jZVRv7hmaVLXmRPRIP9PWvd7mETFtsUXKC9LBUg4biqWZvUJ3qK/8st96HWneP7w==
X-Received: by 2002:a50:b7f8:: with SMTP id i53mr56591484ede.196.1558097999392;
	Fri, 17 May 2019 05:59:59 -0700 (PDT)
Received: from localhost ([185.92.221.13]) by smtp.gmail.com with ESMTPSA id
	x18sm1530825ejd.66.2019.05.17.05.59.58
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 17 May 2019 05:59:58 -0700 (PDT)
Date: Fri, 17 May 2019 12:59:57 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190517125957.56uoupbo3ai4jybr@master>
References: <20190517005114.19456-1-richardw.yang@linux.intel.com>
	<20190517131116.02b25408@Igors-MacBook-Pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517131116.02b25408@Igors-MacBook-Pro>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: Re: [Qemu-devel] [PATCH] hw/acpi: ACPI_PCI should depends on both
 ACPI and PCI
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: mst@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 17, 2019 at 01:11:16PM +0200, Igor Mammedov wrote:
>On Fri, 17 May 2019 08:51:14 +0800
>Wei Yang <richardw.yang@linux.intel.com> wrote:
>
>> Pointed out by Philippe Mathieu-Daud?? <philmd@redhat.com>.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  hw/acpi/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
>> index 7265843cc3..7c59cf900b 100644
>> --- a/hw/acpi/Kconfig
>> +++ b/hw/acpi/Kconfig
>> @@ -25,7 +25,7 @@ config ACPI_NVDIMM
>>  
>>  config ACPI_PCI
>>      bool
>> -    depends on ACPI
>> +    depends on ACPI && PCI
>>  
>>  config ACPI_VMGENID
>>      bool
>
>are you sure you didn't miss anything?
>

This patch is based on the comment in
http://qemu.11.n7.nabble.com/PATCH-v4-0-6-Extract-build-mcfg-tt650106.html#a655913

My understanding is not correct?

>On Fri, 17 May 2019 10:37:42 +0200
>Philippe Mathieu-Daud?? <philmd@redhat.com> wrote:
>
>[...]
>> 
>> config ARM_VIRT
>>     ...
>>     select ACPI_PCI
>> 
>> config ACPI_PCI
>>     bool
>>     depends on ACPI && PCI
>> 
>
>

-- 
Wei Yang
Help you, Help me

