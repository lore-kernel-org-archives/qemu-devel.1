Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02A8C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 07:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64125206D3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 07:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPFLhZRA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64125206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieDL8-00087v-EY
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 02:20:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1ieDKV-0007jE-DO
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 02:19:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1ieDKT-0001Wo-Cz
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 02:19:39 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40343)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1ieDKT-0001TE-4D
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 02:19:37 -0500
Received: by mail-pf1-x443.google.com with SMTP id q8so6733841pfh.7
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2019 23:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=O8bqF1rn+PqYoAZ5jE0J4xonAxc3tFJdFvY8mPt2Gxs=;
 b=cPFLhZRASEQKqD7ZtOtMjP5jjTIByuWYE5vyg6zaCTg1Vudr5kjEULBUPCrcEKTVgq
 Ae4OeuMq9gPL+Yb5BwBJ4HT4T9xF5qcht2sGiQF8G2ZNid0Fv5uXVUpBOwfBHrIhFhj4
 cQoyFKLZR2U7ulzwacEnGLACGM/E3VnBbmoEYsZistL+4LGcalRNR542zXKeFUYhN++Z
 Yld/9gwDTc8YMU1eNU/4dv42xmPl1QopRFSm2FrDsZC4gFeS6gPBzrtZRFU3q+cz+ktP
 RITgfcebpDgoSg76Rx3ou2umOF0nOGQ6g4AJHU56s+nTltGH42er+oAQ0AzMoCzMZEEt
 GirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=O8bqF1rn+PqYoAZ5jE0J4xonAxc3tFJdFvY8mPt2Gxs=;
 b=HV+IU/i2UjrCuu9r0aq2JOGaVcuriNKoSuVo4bgZx/MQF5gSlrKfq2YfsbSTyNsi2o
 XBEQnsLrMAHypux3TQmPFT0pUkjV/crJpkQgv9lgwKrPkRhJHiXUQ4Q60mO8yKrfW9I8
 XZcrOeD1B6i8yLJYBxvnwC5+cpe7C+4uE3oraQfY9BLfQyCUBqx0VA0ymDutBOQOAMWf
 rmV4PCKc2Jsw0D2Mc2zKdzylmB+0UapfzWzaiUoE/2xOexzuGYgodupE8PlIreQFL7ro
 DiGXTpir6QjVU197AxNuLVIhwAxJwiNDr/ZsJYVZzPjmhNCtRuvlEYwOXhv0udc6mvfv
 Qdlg==
X-Gm-Message-State: APjAAAWxslmjO7XXxQrJfUPRmDKYsuekmpl0FR03llBX+jRvqfHaBIgZ
 5IS+i4flCAakD66KuATpKOmCR/Oc
X-Google-Smtp-Source: APXvYqwHloqb0aqrMx8HQTaT6TBbDS8TGtvjqWZT9ihks50OUaEdKge8ntMkD4ezAwccpWwpiGGLhg==
X-Received: by 2002:a63:b64a:: with SMTP id v10mr17573243pgt.145.1575875975572; 
 Sun, 08 Dec 2019 23:19:35 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 z7sm26058060pfk.41.2019.12.08.23.19.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Dec 2019 23:19:34 -0800 (PST)
Subject: Re: [PATCH 1/5] arm64: zynqmp: Add firmware DT node
To: Michal Simek <michal.simek@xilinx.com>,
 Michael Tretter <m.tretter@pengutronix.de>,
 Edgar Iglesias <edgari@xilinx.com>
References: <20191018160735.15658-1-m.tretter@pengutronix.de>
 <20191018160735.15658-2-m.tretter@pengutronix.de>
 <20191208223814.GA21260@roeck-us.net>
 <dbba2a25-cbf7-60f4-99f7-056512e28d00@xilinx.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <4821742f-2d60-b722-b954-263de975bf2e@roeck-us.net>
Date: Sun, 8 Dec 2019 23:19:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <dbba2a25-cbf7-60f4-99f7-056512e28d00@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Rajan Vaja <rajan.vaja@xilinx.com>, qemu-devel@nongnu.org,
 Rajan Vaja <rajanv@xilinx.com>, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/8/19 10:42 PM, Michal Simek wrote:
> Hi, +Edgar
> 
> 
> On 08. 12. 19 23:38, Guenter Roeck wrote:
>> On Fri, Oct 18, 2019 at 06:07:31PM +0200, Michael Tretter wrote:
>>> From: Rajan Vaja <rajan.vaja@xilinx.com>
>>>
>>> Add firmware DT node in ZynqMP device tree. This node
>>> uses bindings as per new firmware interface driver.
>>>
>>> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
>>
>> With this patch applied in the mainline kernel, the qemu xlnx-zcu102
>> emulation crashes (see below). Any idea what it might take to get
>> qemu back to working ?
> 
> Driver talks through ATF to PMU unit(microblaze). I don't think A53+MB
> concept is working with mainline qemu. But crash is too hard. It should
> be no response from PMU and then this panic.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/firmware/xilinx/zynqmp.c?h=v5.5-rc1#n728
> 

Isn't that a bit harsh too ? Normally one would print an error message
and abort driver instantiation.

It sounds like you are saying that qemu's xlnx-zcu102 emulation is
no longer supported and expected to crash the kernel. Is this a
correct assumption ? If so, I'll drop it from my list of tests.

Thanks,
Guenter

