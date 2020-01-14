Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C12BC33CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 00:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12F7B207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 00:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="PyiHSjSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F7B207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irAAh-00085l-1z
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 19:35:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1irA9m-0006Pq-Q2
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 19:34:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1irA9k-0008Q2-FQ
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 19:34:05 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36710)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1irA9k-0008Op-1p
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 19:34:04 -0500
Received: by mail-pf1-x444.google.com with SMTP id x184so5703707pfb.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 16:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=h82tEPbi1SzihaOlkziOCdOvzGets6i1k2fOOCiJB9Q=;
 b=PyiHSjScX8GMbtD2SfQdbdpW6et9I/Nb/yG1QPvAtPvVG41ro6DM4TcRG4xOPMbTIO
 9m/ipaodRraauY3fJaRpv6I7yEVRxKpX8WkOYxeN2eb0EGV1Oku0JTX/E9sYvhLnM4oV
 c6xJfS/KoO/b/A0dhMSGGwJPINsBfJQO+5KDgWjkS3C4wD/0frvRkh8QyAtj9Q/QkdLh
 d7S96xi1m/ENKJYdwBeqVvvM5gPGcuJtYpcw0j5odUHop3quomnjqFLu5Q9yszo3eEYB
 piRs6MDyhGk/w/lDMS+wHSdKr6v/HitNtJGGdkgXOz9XfoZglRUOYDs9NlYbrYHpNSlC
 lX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=h82tEPbi1SzihaOlkziOCdOvzGets6i1k2fOOCiJB9Q=;
 b=h9/g3W7u/SUGZgB/R6w19O+ptdiomH4Uz5YPDqid/yFR+/Un/i7cI/Rtvp6Qj+4/SZ
 iWBoza7Hf1hSHY+0pGdeGcl/OzllB4OOU2KbJCQ24JTjpFfKZtY2usDO0DJ4EG8kwYow
 cxm2QPmQLBzBOWyf7Yf/oqe/rsgLL+ud6bVGPSZ7ohmt7XvDAiryQa5tabJvw5hPJVDG
 09z8DnDV/emMr2I1BWvE0tmsdnEjAt4QyUYDySXPU4sq8vR0QDxf70U04o5b+jOIXIxn
 5S0GnaBPf5QrEAzw9W1AfOQMW1Hh9u+vOuS2PsYpnlf3GOw4Uyk1VPUTKxW9cPiGtM0H
 PXdA==
X-Gm-Message-State: APjAAAUy30ULHo03vkY8o/jGaVdz07sNMPg4zn0ulPo0l3cDCI6NtJ85
 RbqrUBcdGCb1NahRuj+obTuZew==
X-Google-Smtp-Source: APXvYqw9TfNgczozLb0UDjMCSdyfjMf/hydZ3ZjmcmjBOuPsQQ6Mf40YhFCGWxx7/U36VtX02Ww+NQ==
X-Received: by 2002:aa7:9205:: with SMTP id 5mr22634518pfo.213.1578962042258; 
 Mon, 13 Jan 2020 16:34:02 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id b12sm15227730pfi.157.2020.01.13.16.34.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2020 16:34:01 -0800 (PST)
Subject: Re: [PATCH qemu v4] spapr: Kill SLOF
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200108061856.4554-1-aik@ozlabs.ru>
 <b4011a6b-d502-b514-84ad-4e6a1580449d@ozlabs.ru>
 <75b2a298-b549-dcc9-519b-7bf7c388110b@ozlabs.ru>
 <684e7d31-04d0-3176-5de2-c817ce1aedf3@ozlabs.ru>
 <20200113070500.GD19995@umbus>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <af4205d1-7399-2db1-4dcc-26b16dd73611@ozlabs.ru>
Date: Tue, 14 Jan 2020 11:33:58 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200113070500.GD19995@umbus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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



On 13/01/2020 18:05, David Gibson wrote:
> On Fri, Jan 10, 2020 at 11:51:32AM +1100, Alexey Kardashevskiy wrote:
>>
>>
>> On 10/01/2020 10:32, Alexey Kardashevskiy wrote:
>>>
>>>
>>> On 10/01/2020 10:05, Alexey Kardashevskiy wrote:
>>>>
>>>>
>>>> On 08/01/2020 17:18, Alexey Kardashevskiy wrote:
>>>>> The Petitboot bootloader is way more advanced than SLOF is ever going to
>>>>> be as Petitboot comes with the full-featured Linux kernel with all
>>>>> the drivers, and initramdisk with quite user friendly interface.
>>>>> The problem with ditching SLOF is that an unmodified pseries kernel can
>>>>> either start via:
>>>>> 1. kexec, this requires presence of RTAS and skips
>>>>> ibm,client-architecture-support entirely;
>>>>> 2. normal boot, this heavily relies on the OF1275 client interface to
>>>>> fetch the device tree and do early setup (claim memory).
>>>>>
>>>>> This adds a new bios-less mode to the pseries machine: "bios=on|off".
>>>>> When enabled, QEMU does not load SLOF and jumps to the kernel from
>>>>> "-kernel".
>>>>>
>>>>> The client interface is implemented exactly as RTAS - a 20 bytes blob,
>>>>> right next after the RTAS blob. The entry point is passed to the kernel
>>>>> via GPR5.
>>>>>
>>>>> This implements a handful of client interface methods just to get going.
>>>>> In particular, this implements the device tree fetching,
>>>>> ibm,client-architecture-support and instantiate-rtas.
>>>>>
>>>>> This implements changing FDT properties for RTAS (for vmlinux and zImage)
>>>>> and initramdisk location (for zImage). To make this work, this skips
>>>>> fdt_pack() when bios=off as not packing the blob leaves some room for
>>>>> appending.
>>>>>
>>>>> This assigns "phandles" to device tree nodes as there is no more SLOF
>>>>> and OF nodes addresses of which served as phandle values.
>>>>> This keeps predefined nodes (such as XICS/NVLINK/...) unchanged.
>>>>> phandles are regenerated at every FDT rebuild.
>>>>>
>>>>> This defines phandles for VIO devices to have phandle assigned to
>>>>> the default stdout device at the point when we write "/chosen/stdout"
>>>>> which an ihandle which the OS uses to write to the console.
>>>>
>>>>
>>>> And I do not really need to preallocate phandles for stdout as it is a
>>>> leftover from when I populated /chosen/stdout before populating VIO
>>>> nodes, now /chosen/stdout is added at the very end. Thanks,
>>>
>>>
>>> Ah noo, I do, to implement "write" to the selected stdout as I need to
>>> trace ihandle back to Object* and  object_resolve_path() does not know
>>> about FDT path, it is /machine/peripheral/svty0 in QOM. The commit log
>>> needs an update, or this needs a fix but I cannot think of a nicer one.
>>> Thanks,
>>
>>
>> I just might extend instances to do real instances, i.e. associate
>> ihandle with phandle _and_ Object*, I just need a helper to find Object
>> which matches what qdev_get_fw_dev_path() returns. Fun :)
> 
> If you only allow one instance per device, could you just make
> ihandles == phandle | CONSTANT?


I started doing real instances so I am not sure such limiting is worth it.


-- 
Alexey

