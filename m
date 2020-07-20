Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F46DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 19:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63351207DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 19:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63351207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxbn6-0001vR-7N
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 15:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1jxbj2-00019O-7D
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 15:45:24 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:46667)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1jxbiz-0006cd-Vm
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 15:45:23 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1FCE740575;
 Mon, 20 Jul 2020 22:45:19 +0300 (MSK)
Received: from [192.168.177.99] (mjt.vpn.tls.msk.ru [192.168.177.99])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9B7C4A4;
 Mon, 20 Jul 2020 22:45:19 +0300 (MSK)
Subject: Re: [RFC PATCH-not-for-5.1? v2] hw/isa/isa-bus: Ensure ISA I/O
 regions are 8/16-bit accessible
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200720185758.21280-1-f4bug@amsat.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <d4fbf384-91cd-2820-abd8-157f9849ef53@msgid.tls.msk.ru>
Date: Mon, 20 Jul 2020 22:45:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720185758.21280-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 15:45:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.07.2020 21:57, Philippe Mathieu-Daudé пишет:
> Since commit 5d971f9e67 we don't accept mismatching sizes
> in memory_region_access_valid(). This gives troubles when
> a device is on an ISA bus, because the CPU is free to use
> 8/16-bit accesses on the bus (or up to 32-bit on EISA bus),
> regardless what range is valid for the device.
> 
> Add a check to ensure devices plugged on the ISA bus can
> accept 8/16-bits accesses.
> 
> Related bug reports:
> 
> - https://lore.kernel.org/xen-devel/20200630170913.123646-1-anthony.perard@citrix.com/T/
> - https://bugs.debian.org/964793
> - https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=964247
> - https://bugs.launchpad.net/bugs/1886318

Here's the output (of a similar patch), after I fixed the 3 acpi core
devies, of one of my windows7 test VMs. I guess we need to fix either
these devices or the registration, before 5.1 is out, or else more
difficult-to-catch breakage like the above will pop up..

For now we don't have any released qemu version with this situation
so not many project enabled workarounds for broken qemu behavour
like the xen-devel link above.

qemu-system-x86_64: ISA device 'kvm-i8259' requires I/O max_access_size of 2
qemu-system-x86_64: ISA device 'kvm-i8259' requires I/O max_access_size of 2
qemu-system-x86_64: ISA device 'kvm-i8259' requires I/O max_access_size of 2
qemu-system-x86_64: ISA device 'kvm-i8259' requires I/O max_access_size of 2
qemu-system-x86_64: ISA device 'mc146818rtc' requires I/O max_access_size of 2
qemu-system-x86_64: ISA device 'kvm-pit' requires I/O max_access_size of 2
qemu-system-x86_64: ISA device 'isa-pcspk' requires I/O max_access_size of 2
qemu-system-x86_64: ISA device 'isa-serial' requires I/O max_access_size of 2
qemu-system-x86_64: ISA device 'i8042' requires I/O max_access_size of 2
qemu-system-x86_64: ISA device 'i8042' requires I/O max_access_size of 2
qemu-system-x86_64: ISA device 'vmport' requires I/O max_access_size of 2
qemu-system-x86_64: ISA device 'port92' requires I/O max_access_size of 2

Thanks,

/mjt

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> MST: I really don't like this approach, I think the ISA bus
>      should adjust the access.
> 
> since v1: only 8/16-bit accesses enforced
> ---
>  hw/isa/isa-bus.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
> index 58fde178f9..e142eeef06 100644
> --- a/hw/isa/isa-bus.c
> +++ b/hw/isa/isa-bus.c
> @@ -132,6 +132,20 @@ static inline void isa_init_ioport(ISADevice *dev, uint16_t ioport)
>  
>  void isa_register_ioport(ISADevice *dev, MemoryRegion *io, uint16_t start)
>  {
> +    if (io->ops->valid.min_access_size > 1) {
> +        /*
> +         * To be backward compatible with IBM-PC bus, ISA bus must accept
> +         * 8-bit accesses.
> +         */
> +        error_report("ISA device '%s' requires I/O min_access_size of 1 (byte)",
> +                     object_get_typename(OBJECT(dev)));
> +        exit(1);
> +    } else if (io->ops->valid.max_access_size < 2) {
> +        /* ISA bus must accept 16-bit accesses (EISA accepts 32-bit) */
> +        error_report("ISA device '%s' requires I/O max_access_size of "
> +                     "at least 2 (bytes)", object_get_typename(OBJECT(dev)));
> +        exit(1);
> +    }
>      memory_region_add_subregion(isabus->address_space_io, start, io);
>      isa_init_ioport(dev, start);
>  }
> 


