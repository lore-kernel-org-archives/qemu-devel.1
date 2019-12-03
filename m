Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694F2C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 09:13:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D60620409
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 09:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIdIbjAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D60620409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic4FO-000337-CX
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 04:13:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ic44z-0007UL-82
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 04:02:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ic44v-00081h-IZ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 04:02:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53107
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ic44v-0007tB-Ch
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 04:02:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575363758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J9wA7CJmUNjsbOGNQtUhipGAMwMyhN4/fwSlPUTcVls=;
 b=FIdIbjAuRMFctRy64tQa/RNiEkyr5HtFwSL5XHyY+4d2Uv6T+twmt2WXtmJLwz8N3727tV
 mpE6//z1ZRl3Z21tkoFtPqvrrPvCZUoF4mG3E/r+J8re55yHcuGz6E8msY1Y9bCqHt9Hye
 GmkLd0ciAcyRevtM9KK4pVr4DB8u8/U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-HiqUzdzuOd-HnqBPwTh7xQ-1; Tue, 03 Dec 2019 04:02:37 -0500
Received: by mail-wr1-f72.google.com with SMTP id z10so1406959wrt.21
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 01:02:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J9wA7CJmUNjsbOGNQtUhipGAMwMyhN4/fwSlPUTcVls=;
 b=WJOvg9bLbvjCkOWKWQoS0x67YPDWbIDPBVl7eoXxUxckcT8CYzRAk4W1J5vzRsKvtI
 MYBnRhsl61SWb/ZBZRh5512P0KEzW5cLXaa2/DiCY5KBR6W+yuYcCuEpYDpgYyD7jTDV
 WSFdx3PtoQwIWvcvPVAkIoUztA99d+63IQT/v3Bpu8hcPkpmLZbxOzKhkCp+4uEBfxOu
 TFlmxd8eMcEQhjk60heRUg1mBPkHJ7daPsUThlrnFyWzxtaz5K6VroXC8Mr62D1NrKVq
 mPNJOo9hjuM5YUxn9CygD8r6D8WBrcSg1cyFFr7WvafZxAc3JVWqhZjYvcu7kzJQjdME
 S6Zg==
X-Gm-Message-State: APjAAAWEGDE+0oq71baDlBCma1hh58an9PN+gl7IjE1BRn9wRk60V07D
 491TLP4fE2/2p7x5FXcSGEmyYp9q2XMpSnE0hlQjktkSCfpCckz/vKQ2HU0Wg1Btt1dAkPK8kf7
 z59oQqhcoTzWZYmY=
X-Received: by 2002:a05:600c:218c:: with SMTP id
 e12mr33279569wme.30.1575363756261; 
 Tue, 03 Dec 2019 01:02:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqy2aOE+qHXZUXHzSmd+kbDMr8R3DrtuMZ3GoKKTEBJv94VZinq1c6uZ7XUxESOuhqNSvExGuA==
X-Received: by 2002:a05:600c:218c:: with SMTP id
 e12mr33279542wme.30.1575363755985; 
 Tue, 03 Dec 2019 01:02:35 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id i16sm2193619wmb.36.2019.12.03.01.02.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2019 01:02:35 -0800 (PST)
Subject: Re: [PATCH 00/10] Add Allwinner H3 SoC and Orange Pi PC Machine
To: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-devel@nongnu.org
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1de57227-8124-4d11-d996-9faf67b3e4f3@redhat.com>
Date: Tue, 3 Dec 2019 10:02:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191202210947.3603-1-nieklinnenbank@gmail.com>
Content-Language: en-US
X-MC-Unique: HiqUzdzuOd-HnqBPwTh7xQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Niccol=c3=b2_Izzo?= <izzoniccolo@gmail.com>, b.galvani@gmail.com,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/2/19 10:09 PM, Niek Linnenbank wrote:
> Dear QEMU developers,
> 
> Hereby I would like to contribute the following set of patches to QEMU
> which add support for the Allwinner H3 System on Chip and the
> Orange Pi PC machine. The following features and devices are supported:
> 
>   * SMP (Quad Core Cortex A7)
>   * Generic Interrupt Controller configuration
>   * SRAM mappings
>   * Timer device (re-used from Allwinner A10)
>   * UART
>   * SD/MMC storage controller
>   * EMAC ethernet connectivity
>   * USB 2.0 interfaces
>   * Clock Control Unit
>   * System Control module
>   * Security Identifier device
> 
> Functionality related to graphical output such as HDMI, GPU,
> Display Engine and audio are not included.

I'd love to see the OpenRISC AR100 core instantiated in this SoC.

Your contribution makes another good example of multi-arch/single-binary 
QEMU (here 4x ARM + 1x OpenRISC).


