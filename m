Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF327C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EEA324685
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jF4RAiqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEA324685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2GOD-0003sg-PF
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:26:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2GLw-0001UD-VA
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 10:24:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2GLu-0000nk-UG
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 10:24:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37131
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2GLu-0000kx-7t
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 10:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581607469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NPerDuVjCJQ2UeO9FdNW7E1PeN/DO9lJmQRRxxb5QCo=;
 b=jF4RAiqxUNdX5cmcg1PqxEZjSyvbypUhCLyOTjLqFgGcl390xqnecg+XeAbE1uoDtwWk7Q
 qtObwhrtEWYiAUind+tiTHpo5TSwDLV8VyYBRXJP/5Bg+SeWpq2/M4ZRSWxU1VSK1iP93Y
 ANwTk2yNnLfDTIpeyGzJUQqxoD3hTDc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-dk9GuXmQO-essY1y42Aigg-1; Thu, 13 Feb 2020 10:24:27 -0500
Received: by mail-wm1-f70.google.com with SMTP id z7so2491898wmi.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 07:24:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NPerDuVjCJQ2UeO9FdNW7E1PeN/DO9lJmQRRxxb5QCo=;
 b=ZHcm0lOFm6deDxZqhfdPBLD3PX6lebdHBrk+s25FS5ZM58uctq1rrgm+0X9ebOremg
 yNSJqlYWwG0ywyz44CvX2Kc3PJY+WKqUBXyrPpRlNimtTnidY4++tbcJs3gtaPJJ+GwP
 7mb+bMFNGJdYxhU/PvKvuCg9HY/5pSV4FQiXOJW89lELl90zHsZ6P70Z5JDJZnB+jups
 EfS5RA935N9gYC9bugmGU7AhWUuR2Mzw6V1iRGOxzay77D4QxwFqI5NeW4t3l0/z5YX1
 AWJChw6egNUtvTg5OmikQd/87UPL5cR3mGJvh49SI8AZQWLImIUb1az1255g2VCk9Wik
 ZerA==
X-Gm-Message-State: APjAAAXjaQR9JiTMal2Vb95kK6HDd4aC/LGKdAjLzwK00OXh+wMTRkO0
 pNP3gg3tdC0e0crsFDvwjb9Rjb/KwXB4FtX/Ba58EiOp+Bg+K0yYLyDttjZPZYPh9yJIlUjiNu8
 d+/nw5NxWZwTgtas=
X-Received: by 2002:a05:6000:1187:: with SMTP id
 g7mr22452330wrx.109.1581607466344; 
 Thu, 13 Feb 2020 07:24:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqyGzlEF/gZuTP39LH+pqBaTAspiyKFHmoyM6RoEar+L/M8sKRnSPkKw1bLoUPkQHTp6V+zCIg==
X-Received: by 2002:a05:6000:1187:: with SMTP id
 g7mr22452291wrx.109.1581607465944; 
 Thu, 13 Feb 2020 07:24:25 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id q130sm3756970wme.19.2020.02.13.07.24.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2020 07:24:25 -0800 (PST)
Subject: Re: Question about (and problem with) pflash data access
To: Peter Maydell <peter.maydell@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>
References: <20200212184648.GA584@roeck-us.net>
 <504e7722-0b60-ec02-774d-26a7320e5309@redhat.com>
 <20200212230918.GA27242@roeck-us.net>
 <560224fe-f0a3-c64a-6689-e824225cfbb9@redhat.com>
 <279d959f-f7e5-65e1-9c68-459f3fed56d3@ozlabs.ru>
 <52f0b829-151a-3dd0-0ec7-c3155185510c@redhat.com>
 <9f652340-1277-0eb2-bc2c-402b4209a220@roeck-us.net>
 <CAFEAcA8CyTqdqvT6xatkxb9EN49zD4OBaKrbaLpkyZg+eMoM6w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ff42c7de-ef78-a0e5-9abe-9343947ff6d6@redhat.com>
Date: Thu, 13 Feb 2020 16:24:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8CyTqdqvT6xatkxb9EN49zD4OBaKrbaLpkyZg+eMoM6w@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: dk9GuXmQO-essY1y42Aigg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/13/20 3:39 PM, Peter Maydell wrote:
> On Thu, 13 Feb 2020 at 14:26, Guenter Roeck <linux@roeck-us.net> wrote:
>> What really puzzles me is that there is no trace output for
>> flash data accesses (trace_pflash_data_read and trace_pflash_data_write),
>> meaning the actual flash data access must be handled elsewhere.
>> Can someone give me a hint where that might be ?

If you can share built kernel/dtb/rootfs for this machine I can have a 
look at it.

>> Clearly I am missing something about inner workings of qemu.

You can see all the pflash events using '-trace pflash*'.

> 
> Probably the device is in 'romd' mode. A QEMU MemoryRegion
> can be:
>   * RAM (includes ROM for these purposes) -- backed by host
>     memory, reads and writes (if permitted) go straight to
>     the host memory via fastpath accesses

No tracing here.

>   * MMIO -- backed by a read and write accessor function,
>     all accesses go to these functions
>   * "ROM device" -- a mix of the above where there is a
>     backing bit of host memory but also accessor functions.
>     When the device is in "romd" mode, reads go direct to
>     host memory, and writes still go to the accessor function.
>     When the device is not in "romd" mode, reads also go
>     to the accessor function.
> 
> We use this in the pflash devices to make the common case
> ("just read the flash") fast. When the guest makes a write
> to flash that puts it into programming mode, we call
> memory_region_rom_device_set_romd(..., false) so we can
> intercept reads and make them do the right thing for
> programming mode.
> 
> thanks
> -- PMM
> 


