Return-Path: <SRS0=aRDT=W3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED40C3A5A6
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 19:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9118D22DA9
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 19:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFU2FO6N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9118D22DA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i49TL-00079l-Oq
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 15:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1i49SZ-0006Ys-7N
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 15:54:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1i49SX-00069V-Q3
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 15:54:55 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34355)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1i49SX-00061Y-Iz
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 15:54:53 -0400
Received: by mail-wm1-x344.google.com with SMTP id y135so6798170wmc.1
 for <qemu-devel@nongnu.org>; Sat, 31 Aug 2019 12:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=2dUjAJIwZ7SXDFaqxbR7zHhlf2QGgXoJDWE5WBsCSHA=;
 b=PFU2FO6N5TGFFtggZdYJvUKrcxjxtQNAi4qWWycxxfTlVrXzEo5PdPDJwU5mXCopRt
 ij+8tZ/tUrWe88/REU2vJ/uUDvm/f6B73p3Qi161ssjtTDBpst2cQ63D70RUPetkIVmo
 /wN83XbjRFB0iLkzlAPsAbPftok0bJ2eZryDf4YKcoSRoj6QTOdsG2LRHxsDaNlWPjHx
 Hfxe5S0yiEMOaGQtfkrSC8DsbdW1XOP6zsG4Vkf84C2dvT6JW0hgS49JCOKNAP0n2QjI
 dlCD9li/0CJS0UpZwlyt4m5EZ8U+iJg02Ldi8oP/Q9f3Nbxq70D7wroEOULKBQLMYOr5
 goqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=2dUjAJIwZ7SXDFaqxbR7zHhlf2QGgXoJDWE5WBsCSHA=;
 b=bfztdNJ0N8ikDju1/n/zoB6hjYQlXa5KBJZlPllytQq/WbcQ0Vmr28APODfu4EiTmQ
 bom6/tBfLYVfNZ33khGWO3fj4TMkrRP60ldUXnTt8dBJOxhERr2GhplF1oG2w2uWIqKL
 1pvm1L5xiUmciCFCraJk1VAE5vH7y9T09UGMeQhsj+Q0L3pbaEd98hTj4r2xyMLGCEiJ
 n0ryH5e2X4XW5QjFQonBsdx8FDe47W88j9RuOEM9lN85Xlg4SiDNlb5VM4bbYCKv5Syh
 WaNlbH+rErjHXqISRJ73uNWvpBgCGBhUDfOqSy8ARHY7785Fjz0lEdLPvTnwteFP21yl
 76Ug==
X-Gm-Message-State: APjAAAW1FIVhkD/2zJWVZPzoonC57NEW5mxjqqDe+yTFVNWA+f6XaqL7
 nCi5E+wyQzpd+qrDCT8B7toxj8QgmO8=
X-Google-Smtp-Source: APXvYqwtt6cXxLiOhhSLR2Q+zP3/PMEftVpUQO9XN4p/xYLRqAGfgtw8odrSMmW9Jox1UnKzhlDDwA==
X-Received: by 2002:a7b:c094:: with SMTP id r20mr5639793wmh.134.1567281290302; 
 Sat, 31 Aug 2019 12:54:50 -0700 (PDT)
Received: from [192.168.86.99] ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id k9sm7680327wrd.7.2019.08.31.12.54.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 31 Aug 2019 12:54:49 -0700 (PDT)
To: Julia Suvorova <jusual@redhat.com>,
 Zihan Yang <whois.zihan.yang@gmail.com>, qemu-devel@nongnu.org
References: <0dc1a87882d78b071134dba7787d4459b48ed096.camel@gmail.com>
 <c87583f3e8487100fdb8196ad45e6375cc877e3b.camel@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <b7441a1c-9552-76cc-d879-ae3e7f8af8fb@gmail.com>
Date: Sat, 31 Aug 2019 22:55:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c87583f3e8487100fdb8196ad45e6375cc877e3b.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [RFC v5 0/6] pci_expander_brdige: support separate
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Julia,

On 8/27/19 5:58 PM, Julia Suvorova wrote:
> On Mon, 2018-09-17 at 22:57 +0800, Zihan Yang wrote:
>> Hi all
>>
>> Here is a minimal working version of supporting multiple pci domains.
> Hi Zihan,
> Do you plan to continue working on this project?

Since the last submission was long ago we can safely assume
Zihan moved to other projects.
Thanks Zihan for the great work!

>
> I am interested in it, and if you do not mind I would like to finish
> the project, retaining your authorship. I am going to take care
> of this patch set, and the one in SeaBios too.
> How does it sound to you?

I don't Zihan would mind, anyway I fully agree on keeping his authorship.
His work is part of GSOC, so there is no problem with the licensing either.

> Any tips and clues are welcomed.

I would start with merging his work with latest QEMU and giving it a try.
MSI/MSIx PCI devices should simply work.

If I remember correctly 2 issues remain:
1. Devices with legacy interrupts do not work (some INTx wiring issue)
2. Running lspci -vt does not show the correct tree (every pxb should 
start a separate PCI hierarchy)

Good luck!
Marcel


>
> Best regards, Julia Suvorova.
>
>> The next a few paragraphs will illustrate the purpose and use
>> example.
>> Current issue and limitations will be in last 2 paragraphs, followed
>> by the changelog of each verison.
>>
>> Currently only q35 host bridge is allocated an item in MCFG table,
>> all
>> pxb-pcie host bridges stay within pci domain 0. This series of
>> patches
>> allow each pxb-pcie to be put in separate pci domain, allocating a
>> new
>> MCFG table item for it.
>>
>> Users can configure whether to put pxb host bridge into separate
>> domain
>> by specifying property 'domain_nr' of pxb-pcie device. 'bus_nr'
>> property
>> indicates the Base Bus Number(BBN) of the pxb-pcie host bridge.
>> Another
>> property max_bus specifies the maximum desired bus numbers to reduce
>> MCFG space cost. Example command is
>>
>>      -device pxb-pcie,id=bridge3,bus="pcie.0",domain_nr=1,max_bus=15
>>
>> Then this pxb-pcie host bridge is placed at pci domain 1, and only
>> reserve
>> (15+1)=16 buses, which is much smaller than the default 256 buses.
>>
>> Compared with previous version, this version is much simpler because
>> mcfg of extra domain now has a relatively fixed address, as suggested
>> by Marcel and Gerd. Putting extra mmconfig above 4G and let seabios
>> leave them for guest os will be expected in next version. The range
>> is
>> [0x80000000, 0xb0000000), which allows us to hold 4x busses compared
>> with before.
>>
>> A complete command line for test is follows, you need to replace
>> GUEST_IMAGE,
>> DATA_IMAGE and SEABIOS_BIN with proper environment variable
>>
>> ./x86_64-softmmu/qemu-system-x86_64 \
>>      -machine q35,accel=kvm -smp 2 -m 2048 \
>>      -drive file=${GUEST_IMAGE}  -netdev user,id=realnet0 \
>>      -device e1000e,netdev=realnet0,mac=52:54:00:12:34:56 \
>>      -device pxb-pcie,id=bridge3,bus="pcie.0",domain_nr=1 \
>>      -device pcie-root-
>> port,id=rp1,bus=bridge3,addr=1c.0,port=8,chassis=8
>> \
>>      -drive if=none,id=drive0,file=${DATA_IMAGE} \
>>      -device virtio-scsi-pci,id=scsi,bus=rp1,addr=00.0 \
>>      -bios ${SEABIOS_BIN}
>>
>> There are a few limitations, though
>> 1. Legacy interrupt routing is not dealt with yet. There is only
>> support
>> for
>>     devices using MSI/MSIX
>> 2. Only 4x devices is supported, you need to be careful not to
>> overuse
>> 3. I have not fully tested the functionality of devices under
>> separate
>> domain
>>     yet, but Linux can recognize then when typing `lspci`
>>
>> Current issue:
>> * SCSI storage device will be recognized twice, one in domain 0 as
>> 0000:01.0,
>>    the other in domain 1 as 0001:01.0. I will try to fix it in next
>> version
>>
>> v5 <- v4:
>> - Refactor the design and place pxb-pcie's mcfg in [0x80000000,
>> 0xb0000000)
>> - QEMU only decides the desired mcfg_size and leaves mcfg_base for
>> seabios
>> - Does not connect PXBDev and PXBPCIEHost with link property
>> anymore,
>> but
>>    with the pcibus under them, which makes code simpler.
>>
>> v4 <- v3:
>> - Fix bug in setting mcfg table
>> - bus_nr is not used when pxb-pcie is in a new pci domain
>>
>> v3 <- v2:
>> - Replace duplicate properties in pxb pcie host with link property
>> to
>> PXBDev
>> - Allow seabios to access config space and data space of expander
>> bridge
>>    through a different ioport, because 0xcf8 is attached only to
>> sysbus.
>> - Add a new property start_bus to indicate the BBN of pxb host
>> bridge.
>> The
>>    bus_nr property is used as the bus number of pxb-pcie device on
>> pcie.0
>> bus
>>
>> v2 <- v1:
>> - Allow user to configure whether to put pxb-pcie into seperate
>> domain
>> - Add AML description part of each host bridge
>> - Modify the location of MCFG space to between RAM hotplug and pci
>> hole64
>>
>> Many thanks to
>> Please let me know if you have any suggestions.
>>
>> Zihan Yang (6):
>>    pci_expander_bridge: add type TYPE_PXB_PCIE_HOST
>>    pci_expander_bridge: add domain_nr and max_bus property for pxb-
>> pcie
>>    acpi-build: allocate mcfg for pxb-pcie host bridges
>>    i386/acpi-build: describe new pci domain in AML
>>    pci_expander_bridge: add config_write callback for pxb-pcie
>>    pci_expander_bridge: inform seabios of desired mcfg size via hidden
>>      bar
>>
>>   hw/i386/acpi-build.c                        | 162
>> ++++++++++++++++++--------
>>   hw/pci-bridge/pci_expander_bridge.c         | 172
>> +++++++++++++++++++++++++++-
>>   hw/pci/pci.c                                |  30 ++++-
>>   include/hw/pci-bridge/pci_expander_bridge.h |  25 ++++
>>   include/hw/pci/pci.h                        |   2 +
>>   include/hw/pci/pci_bus.h                    |   2 +
>>   include/hw/pci/pci_host.h                   |   2 +-
>>   7 files changed, 336 insertions(+), 59 deletions(-)
>>   create mode 100644 include/hw/pci-bridge/pci_expander_bridge.h
>>


