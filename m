Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D9EC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:26:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 070CC2081E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dg3ei8rz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070CC2081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iroJE-0001qa-T8
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 14:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iro6I-0008Cq-JH
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:13:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iro6G-0003Vy-6n
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:13:10 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23398
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iro6F-0003UT-1Q
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579115586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GDomOs4ePwSwi3gp1Drl6ElWftkWoN6MYS7+HsQX5O4=;
 b=Dg3ei8rzgAV+0XV2VJEMdgieMZf8Fi8PtZcUs7np0PhBP3XgWOk4XjvpWjyK6dnpBZnnJH
 QE9YzvLPA91GBeWN+W7cxMcy+FocjO18FJ6rllp78aPSVNGTKmlaFl1YZnXErp8rmPuiJA
 ZqRxESR07uOJ5GTX6qJSZaC9PYOh62A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-e5f_4pA6OTC40hdeW17C-Q-1; Wed, 15 Jan 2020 14:13:05 -0500
Received: by mail-wr1-f72.google.com with SMTP id z10so8277614wrt.21
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 11:13:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GDomOs4ePwSwi3gp1Drl6ElWftkWoN6MYS7+HsQX5O4=;
 b=IM3KntXsPzzSKoFDk0Bk+5rBvwdvnXzlIwQ7PVv3CI3foZj91erEgIMHH6uPzbjMu3
 YeM/mquEwMHIlZFF+HjG7y7URAhgU9He9kwvF79cqnPHO2uneLlkMesn7qXITX1V4EZr
 ZeZSGw6JDyZ/Q0qGMhxX8EVQ3tqyZIFkmMy5sSkazdNuvVRL4ILNgKtXLv2M7XzJd/2p
 kvQ0sxGz81rDX8MMn97cD/nx5698wlf6yOChoggTVYqdRD4iFQtFxj1l0T/kP/jk3DvF
 ZDSSWP6ay+nhV81g9c9e8R6+gxGcsiX3paJk8DuNVRJ4FNTNIu5fAW2Zw3HMTaM87gs4
 oDfg==
X-Gm-Message-State: APjAAAUd9a6FUi4P7VQ1ZAhmkd+xtvMrAv7mX+zTfiUwJRKt2v+8A8cu
 3NxRFqkvsKHH2tYKnvHYrzPg2lMqarbcFiPY7zBLu+rbKxKd/5ledVVyuxY0MVfDiz2BUqpGzav
 0utQ953Z9GccdnI8=
X-Received: by 2002:a7b:cb01:: with SMTP id u1mr1424181wmj.156.1579115583258; 
 Wed, 15 Jan 2020 11:13:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqx8Zuxnbn+nIJDzXccXjESOp9h17bfYjVFJVDHIB0AGogTTSx6X0ORHF5MLp+4Hni21aPRumw==
X-Received: by 2002:a7b:cb01:: with SMTP id u1mr1424172wmj.156.1579115583080; 
 Wed, 15 Jan 2020 11:13:03 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id z6sm25610562wrw.36.2020.01.15.11.13.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 11:13:01 -0800 (PST)
Subject: Re: [PATCH v2 00/86] refactor main RAM allocation to use hostmem
 backend
To: Igor Mammedov <imammedo@redhat.com>, no-reply@patchew.org
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <157910661287.7467.969397900495856191@37313f22b938>
 <20200115180957.74ccc5f4@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <30de05ac-ca5b-5956-6d88-09ab9b6b4572@redhat.com>
Date: Wed, 15 Jan 2020 20:13:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115180957.74ccc5f4@redhat.com>
Content-Language: en-US
X-MC-Unique: e5f_4pA6OTC40hdeW17C-Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/15/20 6:09 PM, Igor Mammedov wrote:
> On Wed, 15 Jan 2020 08:43:33 -0800 (PST)
> no-reply@patchew.org wrote:
> 
>> Patchew URL: https://patchew.org/QEMU/1579100861-73692-1-git-send-email-imammedo@redhat.com/
>>
>>
>>
>> Hi,
>>
>> This series seems to have some coding style problems. See output below for
>> more information:
> [...]
> 
>> 6/86 Checking commit b9b1823833a3 (alpha:dp264: use memdev for RAM)
>> ERROR: spaces required around that '*' (ctx:WxV)
>> #30: FILE: hw/alpha/alpha_sys.h:14:
>> +PCIBus *typhoon_init(MemoryRegion *, ISABus **, qemu_irq *, AlphaCPU *[4],
> 
> patch keeps the same style that was used in original code
> I can rewrite it on the next respin to mach current codestyle

False positive I think.


