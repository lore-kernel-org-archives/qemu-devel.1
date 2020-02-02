Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F1EC3524A
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 11:52:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D380820679
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 11:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="d6nRV1ab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D380820679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyDnl-0004L5-T0
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 06:52:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1iyDmr-0003u3-Ic
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 06:51:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1iyDmp-0003GE-Rd
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 06:51:36 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39818)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1iyDmp-0003Fi-GG
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 06:51:35 -0500
Received: by mail-pf1-x441.google.com with SMTP id 84so6020942pfy.6
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2020 03:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=N0yXJTSQ0Hju+AmgD9EMUYqnZIUqpYMPJjQhAitUcAE=;
 b=d6nRV1abEa/B0FqdvheIMI/vCCda2Jezkk5z028RV15RQF3JyYpiFLvc98p6XCXF4b
 Jh2eU+UT/rX2TWVPlR15O90jtQWQo4IcoKnGfp1/f+TUivG0ecfvxceM9zgpgc04Ky+/
 YrcOiRJSzKLos+Fgwzf0urKnWx5/gKMkvmZuj3w/5POaiwXK2KKMwcymONdR8c2wcQaA
 eTr2iW7ZsRmspVp/tvW1zsgH7HrGtGJNCeumU4vHUlfEVVTnlpaJsbUgocHPT0vg0ou/
 h9jcdQLRVQou/G1sum/x2H9oCivnQLu1q/DtqKnSw8032pIyw5D7ncvi7jHiLnoq+I2B
 ixXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=N0yXJTSQ0Hju+AmgD9EMUYqnZIUqpYMPJjQhAitUcAE=;
 b=Q4qoQm0mH7b69z6ATMGr7kCYwWHAbzvGnc6/74F61f7sef71YDoEy5WhLyMYx6bT9y
 APqkozMhuHVAlENdCl23yxy1a3J+MNr8hVCMvbXPbB/V0jep45pi13hfVs98C2UpSOTS
 vV58q8fXtStZ6MFlTCtqwBUGZuE5PL+E39PYmHUW4PxjVRL2/3hUSMvWfubUcXdSa5HC
 K0mc2GMMMS2ILRv829Fesld/HDMNdvBZFUpyB+a49Ajf8rugUlDcYi6rmbLpFpEUmpeY
 m5n3UNizH6NIrh83s0SY+RUvHiVxUauTrKl/oFIk8pmr/5s4kvaVz451hH5x9M4P6uqG
 x1aw==
X-Gm-Message-State: APjAAAVV8gk9MDNg4pD/HKLsLSIwsRZK1MBPYHHrp9TGOHa5fXZJUDA7
 7ckYImd5k9OAlVqE0rVoZH7C4g==
X-Google-Smtp-Source: APXvYqwkatcHAEP45mAe40hQyrvKuUQo4tmdaA1UJke6xoHLJbPM3FZlG3Cs3gMXH6uX66Nlpqqb+A==
X-Received: by 2002:a62:7c8d:: with SMTP id x135mr5063124pfc.220.1580644293520; 
 Sun, 02 Feb 2020 03:51:33 -0800 (PST)
Received: from [192.168.10.152] (ppp121-45-221-81.bras1.cbr2.internode.on.net.
 [121.45.221.81])
 by smtp.gmail.com with ESMTPSA id w18sm12335803pfq.167.2020.02.02.03.51.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Feb 2020 03:51:33 -0800 (PST)
Subject: Re: VW ELF loader
To: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <f881c2e7-be92-9695-6e19-2dd88cbc63c1@ozlabs.ru>
 <e3ee4b4d-1b24-2900-4304-05fa521a9b47@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <94828b1d-fa7d-149e-9eb3-d001d6484489@ozlabs.ru>
Date: Sun, 2 Feb 2020 22:51:27 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e3ee4b4d-1b24-2900-4304-05fa521a9b47@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <conny@cornelia-huck.de>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 02/02/2020 06:04, Paolo Bonzini wrote:
> On 01/02/20 14:39, Alexey Kardashevskiy wrote:
>> QEMU needs to load GRUB from the disk. The current workaround is to read
>> it from qcow2, save in a file and then call load_elf(). Not nice.
>>
>> 2 problems with that.
>>
>> 1. when load_elf calls address_space_write() - I need to know where and
>> how much RAM was used to mark this memory "used" for the OF client
>> interface (/memory@0/available FDT property). So I'll need "preload()"
>> hook.
>>
>> 2. (bigger) GRUB comes from PReP partition which is 8MB. load_elf{32|64}
>> consumes filename, not a memory pointer nor a "read_fn" callback - so I
>> thought I need a "read_fn" callback.
>>
>> And then I discovered that load_elf actually maps the passed file. And
>> here I got lost.
>>
>> Why does not load_elf just map the entire file and parse the bits? It
>> still reads chunks with seek+read and then it maps the file in a loop
>> potentially multiple times - is this even correct? Passing "fd" around
>> is weird.
> 
> QEMU must not load GRUB from disk, that's the firmware's task.  If you
> want to kill SLOF, you can rewrite it, but loading the kernel GRUB from
> disk within QEMU is a bad idea: the next feature you'll be requested to
> implement will be network boot, and there's no way to do that in QEMU.

What is exactly the problem with netboot? I can hook up the OF's "net" to a backend (as I do for serial console and 
blockdev, in boot order) and GRUB will do the rest which is tftp/dhcp/ip (SLOF does just this and nothing more). If GRUB 
does not do this on POWER - I can fix this.

Or alternatively it is possible with my patchset to load petitboot (kernel + intramdisk, the default way of booting 
POWER8/9 baremetal systems) and that thing can do whole lot of things, we can consider it as a replacement for ROMs from 
devices (or I misunderstood what kind of netboot you meant).

> You should be able to reuse quite a lot of code from both
> pc-bios/s390-ccw (for virtio drivers) and kvm-unit-tests (for device
> tree parsing).  You'd have to write the glue code for PCI hypercalls,
> and adapt virtio.c for virtio-pci instead of virtio-ccw.

The reason for killing SLOF is to keep one device tree for the entire boot process including 
ibm,client-architecture-support with possible (and annoying) configuration reboots. Having another firware won't help 
with that.

Also the OF1275 client interface is the way for the client to get net/block device without need to have drivers, I'd 
like to do just this and skip the middle man (QEMU device and guest driver in firmware/bootloader).

I'll post another RFC tomorrow to give a better idea.


-- 
Alexey

