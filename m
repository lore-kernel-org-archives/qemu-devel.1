Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1ABC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 10:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083DF22200
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 10:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQu5mUSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083DF22200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvIcD-0004Kj-B4
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 06:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvIbM-0003Qe-Ch
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 06:55:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46121
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvIbJ-0004J8-M8
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 06:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594724152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+Ydl41/I9H4a7/oq3cF9M5jYD9IlxMRzPZmoGHS3EHE=;
 b=LQu5mUSdYppa9VsD+W4M8LgI8HWry0TP9hUNXpPX7vMaTdY541jTVjzjSmDUvJhcLLrMlI
 tDs9nMIs14yEWroF2RduDbHelqLs6kIdW06X+tK0Q6j+MP00ndjWJX25X48CgJ6zc0IDig
 h4lntdb5xOy37O5cFCCl6JN1DkKJ7r0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-je_r5-sgPV6COXv_Utn7hQ-1; Tue, 14 Jul 2020 06:55:48 -0400
X-MC-Unique: je_r5-sgPV6COXv_Utn7hQ-1
Received: by mail-wr1-f70.google.com with SMTP id y13so21132545wrp.13
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 03:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=+Ydl41/I9H4a7/oq3cF9M5jYD9IlxMRzPZmoGHS3EHE=;
 b=KOli56OomvWSFztLAFYoHkRVkDsOjXc4XzEINumgYIQaIPQIni7FVLVOiJ1gpzy+gv
 fmxq39bylGg5khugvywVgOlpmRNkI4jTtGYGy1vN/B1yG9jSboYO4S/2daL1HrNJLNEO
 aR1Wfh/GuJ0NA/1U+KztUljIPqmqlxy+3PhCFv9N7snpVkjID/uoi6cJV0X5Txf7gNmw
 r9pulLfsJW2+f95pesmPN7oMN3pYk4yqeoRfmqFG4MN87f4xyf0s9dgjMwixhgF61IwT
 ykGU3QBuM0hpXkizXox8RCS96xir8Aeg18/c2lt4oHl6qwdCIG+LfXRQeJl5MqxbQ8YK
 Z14A==
X-Gm-Message-State: AOAM533Smf+Ef/dJi13eteEfLUrrMpL1ytYijaHKR3ebtmgkzF6U8gug
 AFPqGFA+wccQGiJC7F3jqvwX1e49hquXPzI66bFhbIyPu6Ve0d4MfeDprvc/XMTGbUkrmvUX+/n
 kEiZaZiCLpvKK4bs=
X-Received: by 2002:adf:92c4:: with SMTP id 62mr4375146wrn.290.1594724147153; 
 Tue, 14 Jul 2020 03:55:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNebMtTbJbIocKmCBY+TCCsLlrz9nf/1FXIw7W+ZHmqxur0scn9e5QzacNMHd3FSRLh65KQg==
X-Received: by 2002:adf:92c4:: with SMTP id 62mr4375107wrn.290.1594724146802; 
 Tue, 14 Jul 2020 03:55:46 -0700 (PDT)
Received: from [192.168.1.43] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id s10sm3928015wme.31.2020.07.14.03.55.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 03:55:46 -0700 (PDT)
Subject: Re: [PATCH] Allow acpi-tmr size=2
To: "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
References: <5f12377f-b640-c4c5-1bcd-858c622c6c31@the-jedi.co.uk>
 <4a5cfe21-d370-8ebf-b905-c37d39b68353@msgid.tls.msk.ru>
 <20200713070946-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <cf26ffdf-3165-8f54-267f-70f150c73c37@redhat.com>
Date: Tue, 14 Jul 2020 12:55:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200713070946-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Simon John <github@the-jedi.co.uk>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Peter/Paolo

On 7/13/20 1:14 PM, Michael S. Tsirkin wrote:
> On Mon, Jul 13, 2020 at 10:20:12AM +0300, Michael Tokarev wrote:
>> 12.07.2020 15:00, Simon John wrote:
>>> macos guests no longer boot after commit 5d971f9e672507210e77d020d89e0e89165c8fc9
>>>
>>> acpi-tmr needs 2 byte memory accesses, so breaks as that commit only allows 4 bytes.
>>>
>>> Fixes: 5d971f9e672507210e7 (memory: Revert "memory: accept mismatching sizes in memory_region_access_valid")
>>> Buglink: https://bugs.launchpad.net/qemu/+bug/1886318
>>
>> Actually this fixes 77d58b1e47c8d1c661f98f12b47ab519d3561488
>> Author: Gerd Hoffmann <kraxel@redhat.com>
>> Date:   Thu Nov 22 12:12:30 2012 +0100
>> Subject: apci: switch timer to memory api
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>
>> because this is the commit which put min_access_size = 4 in there
>> (5d971f9e672507210e7 is just a messenger, actual error were here
>> earlier but it went unnoticed).
>>
>> While min_access_size=4 was most likely an error, I wonder why
>> we use 1 now, while the subject says it needs 2? What real min
>> size is here for ACPI PM timer?
>>
>> /mjt
> 
> 
> Well the ACPI spec 1.0b says
> 
> 4.7.3.3 Power Management Timer (PM_TMR)
> 
> ...
> 
> This register is accessed as 32 bits.
> 
> and this text is still there in 6.2.
> 
> 
> So it's probably worth it to cite this in the commit log
> and explain it's a spec violation.
> I think it's better to be restrictive and only allow the
> minimal variation from spec - in this case I guess this means 2 byte
> reads.

Now reading this thread, I guess understand this register is
accessed via the I/O address space, where 8/16/32-bit accesses
are always valid if the CPU supports an I/O bus.

We have 3 different devices providing this register:
- ICH9
- PIIX4 (abused in PIIX3)
- VT82C686

All are PCI devices, exposing this register via an ISA function.

The ISA MemoryRegion should allow 8/16/32-bit accesses.

For these devices we use:

MemoryRegion *pci_address_space_io(PCIDevice *dev)
{
    return pci_get_bus(dev)->address_space_io;
}

Which comes from:

static void pci_root_bus_init(PCIBus *bus, DeviceState *parent,
                              MemoryRegion *address_space_mem,
                              MemoryRegion *address_space_io,
                              uint8_t devfn_min)
{
    ...
    bus->address_space_mem = address_space_mem;
    bus->address_space_io = address_space_io;
    ...


In i440fx_init():

    b = pci_root_bus_new(dev, NULL, pci_address_space,
                         address_space_io, 0, TYPE_PCI_BUS);

q35_host_initfn() uses get_system_io() from pc_q35_init().

If the guest did a 16-bit read, it should work ...:

uint16_t cpu_inw(uint32_t addr)
{
    uint8_t buf[2];
    uint16_t val;

    address_space_read(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED,
buf, 2);
    val = lduw_p(buf);
    trace_cpu_in(addr, 'w', val);
    return val;
}

... but it is indeed prevented by min_access_size=4.

Maybe we should have the ISA MemoryRegion accepts min_access_size=1
and adjust the access sizes.

> 
> In any case pls do include an explanation for why you picked
> one over the other.
> 
>>
>>> Signed-off-by: Simon John <git@the-jedi.co.uk>
>>> ---
>>> Ãƒâ€šÃ‚Â hw/acpi/core.c | 2 +-
>>> Ãƒâ€šÃ‚Â 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
>>> index f6d9ec4f13..05ff29b9d7 100644
>>> --- a/hw/acpi/core.c
>>> +++ b/hw/acpi/core.c
>>> @@ -527,7 +527,7 @@ static void acpi_pm_tmr_write(void *opaque, hwaddr addr, uint64_t val,
>>> Ãƒâ€šÃ‚Â static const MemoryRegionOps acpi_pm_tmr_ops = {
>>> Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â  .read = acpi_pm_tmr_read,
>>> Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â  .write = acpi_pm_tmr_write,
>>> -Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â  .valid.min_access_size = 4,
>>> +Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â  .valid.min_access_size = 1,
>>> Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â  .valid.max_access_size = 4,
>>> Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â  .endianness = DEVICE_LITTLE_ENDIAN,
>>> Ãƒâ€šÃ‚Â };
> 
> 


