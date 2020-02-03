Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910F3C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 10:59:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC2120658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 10:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="rHbYPBJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC2120658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyZS1-0000iZ-Il
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 05:59:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1iyZRM-0008MJ-4g
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:58:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1iyZRK-00066g-DB
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:58:51 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35923)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1iyZRJ-00063C-Vt
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:58:50 -0500
Received: by mail-pg1-x543.google.com with SMTP id k3so7627286pgc.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 02:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NRWM0E1bafEKcPBcUriwPBrnB3ZJe2oBlMdsvRRlbM8=;
 b=rHbYPBJuTICyymCa0VHztL21VzSKAwIO5VrA/H5bO234GunJkD6dCSAM6P+Acni04r
 qB/t8vxZ+muY3gxa+o2kUKSq7blLUMTPABssq8NMHIEqNYupFpytNvqm+2i4ycf2LCWh
 seZ5Lf8KTtteYM98X8Jh3Bmn3NLgRR1+yLrW5/EUCtmIilx/WQno6poonw2oG8ExHR88
 5or8jaKL9w6zRvBmy2dhJv/+b2l2yIFKRnnfanfvdXUjFHUaoIMxMjZQrIV6JB6g6RUM
 zWgRW5Xko8ISsBTESd0ESZEmau9d+gGPjeep+7SqqSd8LhtPdhrA3ztEEdjrV1dnED0H
 jz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NRWM0E1bafEKcPBcUriwPBrnB3ZJe2oBlMdsvRRlbM8=;
 b=pNiskZy6lKuY/ZnVQLIqguJ/MIpevsK4F9GwoCL6uJszRPcnk2kseIWBZ3BY8B7Dfy
 S8zNV0GcrSyUlztWfTwBQ8B8ck6/kMyomB/GmLIri+K7CiK7tXh7uGDcw/zcZrJreQ8z
 p/GInDBJxe4THhmKzbhCm84kKYX3Ch+7PMHbFObIXGdAhLX7qyKzOIRe/ib2pfX91SEJ
 MXwXgYvFJMfXjWyoxxMQzRC7mfJ8LeXC5apyFER59Fr3Iy6LVH4WF28USq6gdIAowXMx
 L1tuEFv5g0oAh3ZAi2Dt0nnxvF8m+AEjBaYoDy9fLHBbIpAaV/k3kJZpmWHK+OaYYWba
 bd7Q==
X-Gm-Message-State: APjAAAUX9X+kA4hk5udO1vKTsT0rfnzkThu1mcoVcOUzWX8VTgk4auvm
 WbrBQoefeUIYEVRDLkzFH6bZTA==
X-Google-Smtp-Source: APXvYqzRpejdY8U2a9mmsLGBOCvkMXyhQLGDB0kJR4G2pIGbK2c3nd309aC97XQzInQt8s+uODIEeA==
X-Received: by 2002:a63:3d42:: with SMTP id k63mr1550763pga.318.1580727528785; 
 Mon, 03 Feb 2020 02:58:48 -0800 (PST)
Received: from [192.168.10.85] (ppp121-45-221-81.bras1.cbr2.internode.on.net.
 [121.45.221.81])
 by smtp.gmail.com with ESMTPSA id o6sm19055915pgg.37.2020.02.03.02.58.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2020 02:58:48 -0800 (PST)
Subject: Re: VW ELF loader
To: Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <f881c2e7-be92-9695-6e19-2dd88cbc63c1@ozlabs.ru>
 <e3ee4b4d-1b24-2900-4304-05fa521a9b47@redhat.com>
 <20200203012842.GD52446@umbus.fritz.box>
 <ec81cca1-d5fb-3f1e-b433-3328d81a117e@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <de7e4d34-eb63-904c-3475-7feee154c72c@ozlabs.ru>
Date: Mon, 3 Feb 2020 21:58:43 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <ec81cca1-d5fb-3f1e-b433-3328d81a117e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
 Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Cornelia Huck <conny@cornelia-huck.de>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/2/20 8:12 pm, Paolo Bonzini wrote:
> On 03/02/20 02:28, David Gibson wrote:
>> But "pseries" is different.  We're implementing the PAPR platform,
>> which describes an OS environment that's presented by a combination of
>> a hypervisor and firmware.  The features it specifies *require*
>> collaboration between the firmware and the hypervisor.
> 
> Which features are these?

RTAS: PCI handling - MSI allocations, config space, interrupts
(XICS/XIVE) - we do it in QEMU right now so this went unnoticed but
ideally there should have been a RTAS binary lot bigger than those 20
bytes (never even had a chance to look at what IBM pHyp does).

OF CI: ibm,client-architecture-support and all these spapr-vlan/vty/scsi
paradevices - we do not really need any driver between GRUB and QEMU -
the OF interface defines enough.

Resource allocation - we allocate some in QEMU (PCI bus numbers
assignment and PHB windows) but assign BARs and bridge windows in SLOF
(boottime) or Linux (hotplug). We could just let Linux do this or do
this in QEMU.

Interrupt map - QEMU does this for PHB (as a host interrupt controller
is a parent) and SLOF does it for PCI bridges (they have PHB or other
bridges as parents so they do it themselves), except of course PCI hot
plug after the guest started but Linux has not fetched the device tree.

All this is manageable but quite hard to maintain while benefits of such
separation of hypervisor code are not clear.


>> So really, the question isn't whether we implement things in firmware
>> or in qemu.  It's whether we implement the firmware functionality as
>> guest cpu code, which needs to be coded to work with a limited
>> environment, built with a special toolchain, then emulated with TCG.
>> Or, do we just implement it in normal C code, with a full C library,
>> and existing device and backend abstractions inside qemu.
> 
> ... which is adding almost 2000 lines of new code to the host despite
> the following limitations:

Kind of. But it replaces a log bigger chunk of SLOF, easy to read and it
works faster. Just virtio-scsi/net drivers are about 1700 lines and we
do need them at all with the proposed patches (or I missed the bigger
picture again and we need them?).

Also Linux needs only roughly a half of this. One idea was to hack GRUB
to run in the userspace from initrd with petitboot-alike kernel, and
carry this small kernel with a franken-GRUB with QEMU, then extra code
goes to GRUB and then those folks become unhappy :)


>> 4. no networking in OF CI at all;
>> 5. no vga;
>> 6. no disk partitions in CI, i.e. no commas to select a partition -
>> this relies on a bootloader accessing the disk as a whole;

This is not going to be a lot really, especially supporting partitions -
the code is practically there already as I needed it to find GRUB, and
GRUB does the rest asking very little from the firmware to work.

btw what is the common way of netbooting in x86? NIC ROM or GRUB (but
this would be a disk anyway)? Can we consider having a precompiled GRUB
image somewhere in pc-bios/ to use for netboot? Or Uboot would do (it is
already in pc-bios/, no?), I suppose?


> and of course:
> 
>> 7. "interpret" (executes passed forth expression) does nothing as in this
>> environment grub only uses it for switching cursor off and similar tasks.
> 
> In other words you're not dropping SLOF, you're really dropping
> OpenFirmware completely.

What is the exact benefit of having OpenFirmware's "interpret"? The rest
is there as far as known clients are concerned. FreeBSD is somewhere
between GRUB and Linux, and we never truly supported AIX as it has (or
at least used to) fixes for pHyp firmware bugs which we never cared to
simulate in SLOF.

I totally get why people want a firmware, it makes perfect sense when
emulating bare metal machine (such as the powernv machine type in QEMU)
but spapr is not the case.



>  It's little more than what ARM does.
> 
> Paolo
> 

-- 
Alexey

