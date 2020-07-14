Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641C8C433E6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F35120EDD
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hj4nwi9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F35120EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvHZv-0000xk-E7
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 05:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvHZA-0000OX-Vi
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:49:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21676
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvHZ8-0003H3-Uu
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594720173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=whPcV42Y9+by28xZaM/Ogj8kTPbEU35bjt051INC/SQ=;
 b=hj4nwi9xO7rLgnQAVWZO1+vvOx2bS9+GpPF1j3cOMcEg/pbaZOuoGJeYwNNlpH+A4MGk2Q
 XLngMTkIyIOFT1bi6A20bUEFXZdWALVgZBxDDneQxoiFtZiTPDD3QPWUG8lK16fosDMiAh
 A5AX4wyxbrr2ejDT84BRl5jJ0vtGE7Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-eiwekY5FNK673a8SpC3Vfw-1; Tue, 14 Jul 2020 05:49:27 -0400
X-MC-Unique: eiwekY5FNK673a8SpC3Vfw-1
Received: by mail-wm1-f71.google.com with SMTP id z11so3126280wmg.5
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 02:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=whPcV42Y9+by28xZaM/Ogj8kTPbEU35bjt051INC/SQ=;
 b=QhTYMtyHqHeE32ExEPha1Xplx9ggNlNV9dp6OTBFcZaIedyZNmdQFwCqm3jsoVTyUH
 8Mf5Zw5v+uNGS8G3FMpEQ+OJK685MIbVnnuaRvy8fYGXA2GWQ0NwMMd4XtDVPglL5vSP
 qwpy0fmwVaOpmJLpbCDlPWTxbstIa04Jx+KRmfR546g4wHx4IA8YaeSHsMGgJU8RSvep
 OK1vrr2xraUqxnJ0bCFnQY7VBiOUTCCcHHXOekhdKetOzLyG27YBy2tGG4VQiHh+GTIK
 hWZVLMY5bcu6IVJOxW+0BXs76juTK6JMkJFGMQWT5YuvfcBJokudF93f4L3HHDq4VLKy
 +9ug==
X-Gm-Message-State: AOAM531eA75c0slescu5vhTgUQIRWAJXsFzr1qxXTya2A5Z43kRMZ6WW
 c0P/VtBP4TvHCOVrObS89zoTS/zZl4aud6IL/mZ4RFcCd910/nVCSfDJxt/csJXO9Z5O/P2urhw
 YjHgoNJuUxaHRUig=
X-Received: by 2002:a5d:54c9:: with SMTP id x9mr4336790wrv.247.1594720166309; 
 Tue, 14 Jul 2020 02:49:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkIhnvIYS1ub0ms8LTLpXgLlxI27qmJP+ZgzpZ0pB4eVPYVnJo6I8kwOc+JU/n1M5NXslSng==
X-Received: by 2002:a5d:54c9:: with SMTP id x9mr4336767wrv.247.1594720166062; 
 Tue, 14 Jul 2020 02:49:26 -0700 (PDT)
Received: from [192.168.1.43] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id d10sm26944574wrx.66.2020.07.14.02.49.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 02:49:25 -0700 (PDT)
Subject: Re: [PATCH v2 09/11] hw/virtio/pci: include vdev name in registered
 PCI sections
To: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200713200415.26214-1-alex.bennee@linaro.org>
 <20200713200415.26214-10-alex.bennee@linaro.org>
 <20200714050630-mutt-send-email-mst@kernel.org>
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
Message-ID: <b208323f-cd2d-8b4a-f9aa-354119128beb@redhat.com>
Date: Tue, 14 Jul 2020 11:49:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200714050630-mutt-send-email-mst@kernel.org>
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
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, robhenry@microsoft.com,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/14/20 11:07 AM, Michael S. Tsirkin wrote:
> On Mon, Jul 13, 2020 at 09:04:13PM +0100, Alex BennÃƒÂ©e wrote:
>> When viewing/debugging memory regions it is sometimes hard to figure
>> out which PCI device something belongs to. Make the names unique by
>> including the vdev name in the name string.
>>
>> Signed-off-by: Alex BennÃƒÂ©e <alex.bennee@linaro.org>
>> Reviewed-by: Philippe Mathieu-DaudÃƒÂ© <philmd@redhat.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> 
> I wonder here: why don't we see the owner name when debugging? Maybe that's a better
> way to address that.

It depends what you mean mean by "debugging", gdb? trace events?
monitor? Something else?

From the monitor you can use the '-o' option:

(qemu) help info mtree
info mtree [-f][-d][-o][-D] -- show memory tree (-f: dump flat view for
address spaces;-d: dump dispatch tree, valid with -f only);-o: dump
region owners/parents;-D: dump disabled regions
(qemu) info mtree -o
address-space: memory
  0000000000000000-ffffffffffffffff (prio 0, i/o): system parent:{obj
path=/machine/unattached}
    0000000000000000-0000000007ffffff (prio 0, ram): alias ram-below-4g
@pc.ram 0000000000000000-0000000007ffffff parent:{obj
path=/machine/unattached}
    0000000000000000-ffffffffffffffff (prio -1, i/o): pci parent:{obj
path=/machine/unattached}
      00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
owner:{dev path=/machine/unattached/device[28]}
      00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
parent:{obj path=/machine/unattached}
      00000000000e0000-00000000000fffff (prio 1, rom): alias isa-bios
@pc.bios 0000000000020000-000000000003ffff parent:{obj
path=/machine/unattached}
      00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
parent:{obj path=/machine/unattached}
    00000000000a0000-00000000000bffff (prio 1, i/o): alias smram-region
@pci 00000000000a0000-00000000000bffff owner:{dev path=/machine/q35/mch}
    00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-pci @pci
00000000000c0000-00000000000c3fff owner:{dev path=/machine/q35/mch}
    00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-pci @pci
00000000000c4000-00000000000c7fff owner:{dev path=/machine/q35/mch}
    00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-pci @pci
00000000000c8000-00000000000cbfff owner:{dev path=/machine/q35/mch}
    00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-pci @pci
00000000000cc000-00000000000cffff owner:{dev path=/machine/q35/mch}
    00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-pci @pci
00000000000d0000-00000000000d3fff owner:{dev path=/machine/q35/mch}
    00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-pci @pci
00000000000d4000-00000000000d7fff owner:{dev path=/machine/q35/mch}
    00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-pci @pci
00000000000d8000-00000000000dbfff owner:{dev path=/machine/q35/mch}
    00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-pci @pci
00000000000dc000-00000000000dffff owner:{dev path=/machine/q35/mch}
    00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-pci @pci
00000000000e0000-00000000000e3fff owner:{dev path=/machine/q35/mch}
    00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-pci @pci
00000000000e4000-00000000000e7fff owner:{dev path=/machine/q35/mch}
    00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-pci @pci
00000000000e8000-00000000000ebfff owner:{dev path=/machine/q35/mch}
    00000000000ec000-00000000000effff (prio 1, i/o): alias pam-pci @pci
00000000000ec000-00000000000effff owner:{dev path=/machine/q35/mch}
    00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-pci @pci
00000000000f0000-00000000000fffff owner:{dev path=/machine/q35/mch}
    00000000fec00000-00000000fec00fff (prio 0, i/o): ioapic owner:{dev
path=/machine/q35/ioapic}
    00000000fed00000-00000000fed003ff (prio 0, i/o): hpet owner:{dev
path=/machine/unattached/device[5]}
    00000000fee00000-00000000feefffff (prio 4096, i/o): apic-msi
owner:{dev path=/machine/unattached/device[0]/lapic}

For trace events it has been suggested to use
object_get_canonical_path_component() but there is a discussion about if
it is practical or not in its current state, see:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg722110.html

For gdb I guess remember Marc-André sent a patch for the Python script,
but it hasn't been merged apparently:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg659085.html

> 
>> ---
>> v2
>>   - swap ()'s for an extra -
>> ---
>>  hw/virtio/virtio-pci.c | 22 ++++++++++++++--------
>>  1 file changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>> index 8554cf2a03..215e680c71 100644
>> --- a/hw/virtio/virtio-pci.c
>> +++ b/hw/virtio/virtio-pci.c
>> @@ -1406,7 +1406,8 @@ static void virtio_pci_device_write(void *opaque, hwaddr addr,
>>      }
>>  }
>>  
>> -static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy)
>> +static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy,
>> +                                           const char *vdev_name)
>>  {
>>      static const MemoryRegionOps common_ops = {
>>          .read = virtio_pci_common_read,
>> @@ -1453,36 +1454,41 @@ static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy)
>>          },
>>          .endianness = DEVICE_LITTLE_ENDIAN,
>>      };
>> +    g_autoptr(GString) name = g_string_new(NULL);
>>  
>> -
>> +    g_string_printf(name, "virtio-pci-common-%s", vdev_name);
>>      memory_region_init_io(&proxy->common.mr, OBJECT(proxy),
>>                            &common_ops,
>>                            proxy,
>> -                          "virtio-pci-common",
>> +                          name->str,
>>                            proxy->common.size);
>>  
>> +    g_string_printf(name, "virtio-pci-isr-%s", vdev_name);
>>      memory_region_init_io(&proxy->isr.mr, OBJECT(proxy),
>>                            &isr_ops,
>>                            proxy,
>> -                          "virtio-pci-isr",
>> +                          name->str,
>>                            proxy->isr.size);
>>  
>> +    g_string_printf(name, "virtio-pci-device-%s", vdev_name);
>>      memory_region_init_io(&proxy->device.mr, OBJECT(proxy),
>>                            &device_ops,
>>                            virtio_bus_get_device(&proxy->bus),
>> -                          "virtio-pci-device",
>> +                          name->str,
>>                            proxy->device.size);
>>  
>> +    g_string_printf(name, "virtio-pci-notify-%s", vdev_name);
>>      memory_region_init_io(&proxy->notify.mr, OBJECT(proxy),
>>                            &notify_ops,
>>                            virtio_bus_get_device(&proxy->bus),
>> -                          "virtio-pci-notify",
>> +                          name->str,
>>                            proxy->notify.size);
>>  
>> +    g_string_printf(name, "virtio-pci-notify-pio-%s", vdev_name);
>>      memory_region_init_io(&proxy->notify_pio.mr, OBJECT(proxy),
>>                            &notify_pio_ops,
>>                            virtio_bus_get_device(&proxy->bus),
>> -                          "virtio-pci-notify-pio",
>> +                          name->str,
>>                            proxy->notify_pio.size);
>>  }
>>  
>> @@ -1623,7 +1629,7 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
>>  
>>          struct virtio_pci_cfg_cap *cfg_mask;
>>  
>> -        virtio_pci_modern_regions_init(proxy);
>> +        virtio_pci_modern_regions_init(proxy, vdev->name);
>>  
>>          virtio_pci_modern_mem_region_map(proxy, &proxy->common, &cap);
>>          virtio_pci_modern_mem_region_map(proxy, &proxy->isr, &cap);
>> -- 
>> 2.20.1
> 


