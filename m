Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586D8C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2551B207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="zqcAFhGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2551B207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir2zb-0001gs-Q4
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 11:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57515)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1ir2wd-0007Lz-1k
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:52:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1ir2wb-0001ML-Uf
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:52:02 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:39354)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1ir2wb-0001IH-Fu; Mon, 13 Jan 2020 11:52:01 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 7CD3296EF0;
 Mon, 13 Jan 2020 16:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1578934319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yXw7+BUWZPJMUfrhjJW4K3ZCI6R2eDXFNcxnkNnkzYk=;
 b=zqcAFhGkBX4oy/RfBs5YZMGSRNQ7bQPluCD5v3vYkmNKwC2rfwc5VU8bg6LZOMg1vfX/SB
 Y1Ke/A/QzWpin/Q4VuAbsOZXP1YH5DM88qYPtSWJmGcUPAj29v72w4P50r8bsOFN7JLWPO
 bMVBKGRgeftm3ppt97ODPzjqTIr3EGw=
Subject: Re: [PATCH v6 07/11] hw/core/qdev: update hotplug reset regarding
 resettable
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191220115035.709876-1-damien.hedde@greensocs.com>
 <20191220115035.709876-8-damien.hedde@greensocs.com>
 <f70ba0cf-8bf6-d6dc-6a1e-b7dad7454a36@linaro.org>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <92bc1529-b3cf-cf2a-8249-8467021825c8@greensocs.com>
Date: Mon, 13 Jan 2020 17:51:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <f70ba0cf-8bf6-d6dc-6a1e-b7dad7454a36@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1578934319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yXw7+BUWZPJMUfrhjJW4K3ZCI6R2eDXFNcxnkNnkzYk=;
 b=3PpxjnHBurJdhG4KvPtZ6xSyQC7PDBVY9Z5IJSzESElo9F6DEqHUbozAZ8Q6bRA8CqTWLK
 +WBTW9UFTnmyPrDlbbOcUZiLuw8xxjUnabI07S15Ll8cPtSaoeq03EOUnSaWbmt1WO0PXJ
 RGy5P+7/RSJaq/LegtI+Puzw/sAQwqw=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1578934319; a=rsa-sha256; cv=none;
 b=gsyqiXvjSFfHcVEMDC36MJpGjXu5h7coS6daZPB24FSF9VGgesPLf5dinotaXba7HmLxxx
 wiQvY4mEV1uYJpg6tOU9bgYveiX9GQ45aqwDoUuHBQGbCYBLiWPuc+c2WgI5lkUbRRvQZH
 g7LdDLyV4eaTU4uoicnxk8Gb9VeU9tI=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 cohuck@redhat.com, mark.burton@greensocs.com, edgari@xilinx.com,
 qemu-s390x@nongnu.org, pbonzini@redhat.com, philmd@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12/29/19 12:58 AM, Richard Henderson wrote:
> On 12/20/19 10:50 PM, Damien Hedde wrote:
>> +void resettable_state_clear(ResettableState *state)
>> +{
>> +    memset(state, 0, sizeof(ResettableState));
>> +}
> 
> Worth moving this into the header as inline?  Anyway,

I can but it is really not a function which matters a lot since it is
only called during realize. I hesitated not to add the function since it
is used at only one place.

I'm not sure what's bets in that case.

Damien

