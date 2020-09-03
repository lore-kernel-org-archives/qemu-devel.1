Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6717BC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:37:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2617E2072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxpYyP67"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2617E2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDpQT-0007Ws-7M
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 09:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDpPO-0005t8-SX
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 09:36:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33215
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDpPK-00005w-Gd
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 09:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599140164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ybc8dO9AzTRI3pxIowNLbAevhVlaqgCr0a6akGYkl6g=;
 b=XxpYyP678cw6WLTip4wFnCY6YLuyuyT1e6/NsT2lVIPckHwiZwFRPgM9ghQ6S3NJFGB+Ng
 Kw+ntx9sGUK0o1M3TpWDLZWqpFD4g1iSroeqbHyIXS5UttdT3//BegysFobWOukLDi5x7s
 HYX6LSy3+DbbyLeUidXSN40i3XdqQIo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-HAAq5h_tPhWHOgQ4O6PSug-1; Thu, 03 Sep 2020 09:36:03 -0400
X-MC-Unique: HAAq5h_tPhWHOgQ4O6PSug-1
Received: by mail-wr1-f71.google.com with SMTP id b7so1094824wrn.6
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 06:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ybc8dO9AzTRI3pxIowNLbAevhVlaqgCr0a6akGYkl6g=;
 b=fYSnVBNA6XMFtVLpPiBlAwu9p8eslzFxOVeaeBeY72PDILfYiFnIf9Ne61MCZyhaI3
 gOmP4xbscCINSeLtabc72r43gKjQtjs+7nhmVMdjz4fx9/yP15L9EK8N0JUY5EaobdLM
 UrP8FyFjHEFUKD+x/7Q9xqw186qIzsxsYWoOW3zUbOQPa/QXpKFklqlZVsYj7lrJzSNj
 l4UXzxbfjaHXE08FxTwINgrLzHjSo6NPUELIODK0PjG+GWh28GIHRHZgn2S1sT9kCXw0
 ylI5qDTrm430XbBjBCfzkxS35WtUtT+doKWBwTP9xftoJXumpVaiMiBScYjBxx91LfvA
 BYNQ==
X-Gm-Message-State: AOAM5330JGkfeUMmEPmfJ2lJ23r94DzkqR/FPJ/9x1bTXgxaolcEtCC2
 O/+HgJdNSvoFH7+F2a6dacUAVdHYxEqVnnLZkoo+mtUADav6GrFqKGgEhBusO6u+YkxzEUkwXQu
 VJc1FffAyS6k0+xk=
X-Received: by 2002:adf:828e:: with SMTP id 14mr2712256wrc.217.1599140161263; 
 Thu, 03 Sep 2020 06:36:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIVLKG68MJIta3rIA7EpY4STpdoyNLnAbI7yx21UcONH514naB8Hh20Mwg/4nlXsLnRMkZYw==
X-Received: by 2002:adf:828e:: with SMTP id 14mr2712243wrc.217.1599140161053; 
 Thu, 03 Sep 2020 06:36:01 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id t16sm4528264wrm.57.2020.09.03.06.35.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 06:36:00 -0700 (PDT)
Subject: Re: [RFC 0/3] try to solve the DMA to MMIO issue
To: Peter Maydell <peter.maydell@linaro.org>, Li Qiang <liq3ea@gmail.com>
References: <20200902162206.101872-1-liq3ea@163.com>
 <b840aab8-542d-af43-43e5-0a07f442b5d5@redhat.com>
 <CAFEAcA9mvMaR5MJJ74Vv63TG6frWnMeSZA19Zxv8TUceudPUTQ@mail.gmail.com>
 <CAKXe6SLYgkiTAYa81nppHUMEzoeGy3988OmrzZyw8-VY8ajE3w@mail.gmail.com>
 <CAFEAcA9TEpfBmfOOtpfR9JCAFkMF0fy20L=DBVDTFaLp6J3Lfg@mail.gmail.com>
 <CAKXe6SKgVo5HBL2Uf8AscEn5ohZOJZGLMmT3NZL5cEbcQzgivg@mail.gmail.com>
 <CAFEAcA_yTWf2toD_R3ye_cYRZjGOeyrKTV6At2U6vtHn5iiYPg@mail.gmail.com>
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
Message-ID: <475a8df6-f54d-9dff-f014-0aedf74ccc88@redhat.com>
Date: Thu, 3 Sep 2020 15:35:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_yTWf2toD_R3ye_cYRZjGOeyrKTV6At2U6vtHn5iiYPg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Li Qiang <liq3ea@163.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Alexander Bulekov <alxndr@bu.edu>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 1:28 PM, Peter Maydell wrote:
> On Thu, 3 Sep 2020 at 12:24, Li Qiang <liq3ea@gmail.com> wrote:
>> Peter Maydell <peter.maydell@linaro.org> 于2020年9月3日周四 下午7:19写道：
>>> No. Any device can have an inbound or outbound qemu_irq line.
>>> We use them not just for actual IRQ lines but for any
>>> situation where we need to pass an on-or-off signal from
>>> one device to another.
>>
>> Could you please provide some example, I haven't noticed this before.
> 
> Look at any device that calls qdev_init_gpio_in() or
> qdev_init_gpio_in_named() for an example of inbound signals.
> Outbound signals might be created via qdev_init_gpio_out(),
> qdev_init_gpio_out_named() or sysbus_init_irq().

Not sure if this is a valid example, but when adding:

-- >8 --
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index bca71b5934b..b8b4ba362b1 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -96,6 +96,8 @@ static void ioapic_service(IOAPICCommonState *s)
     uint32_t mask;
     uint64_t entry;

+    assert(!resettable_is_in_reset(OBJECT(s)));
+
     for (i = 0; i < IOAPIC_NUM_PINS; i++) {
         mask = 1 << i;
         if (s->irr & mask) {
---

I get a MMIO write triggered from an IRQ:

(gdb) bt
#3  0x0000555558e44a12 in memory_region_write_accessor
(mr=0x61600001ab10, addr=0, value=0x7fffffffaa10, size=4, shift=0,
mask=4294967295, attrs=...) at softmmu/memory.c:482
#4  0x0000555558e4453b in access_with_adjusted_size (addr=0,
value=0x7fffffffaa10, size=4, access_size_min=1, access_size_max=4,
access_fn=
    0x555558e44600 <memory_region_write_accessor>, mr=0x61600001ab10,
attrs=...) at softmmu/memory.c:545
#5  0x0000555558e42c56 in memory_region_dispatch_write
(mr=0x61600001ab10, addr=0, data=0, op=MO_32, attrs=...) at
softmmu/memory.c:1466
#6  0x0000555558f322b3 in address_space_stl_internal (as=0x55555c0120e0
<address_space_memory>, addr=4276092928, val=0, attrs=..., result=0x0,
endian=DEVICE_LITTLE_ENDIAN)
    at memory_ldst.c.inc:315
#7  0x0000555558f32802 in address_space_stl_le (as=0x55555c0120e0
<address_space_memory>, addr=4276092928, val=0, attrs=..., result=0x0)
at memory_ldst.c.inc:353
#8  0x0000555558be2e22 in stl_le_phys (as=0x55555c0120e0
<address_space_memory>, addr=4276092928, val=0) at
/home/phil/source/qemu/include/exec/memory_ldst_phys.h.inc:103
#9  0x0000555558be0e14 in ioapic_service (s=0x61b000002a80) at
hw/intc/ioapic.c:138
#10 0x0000555558be4901 in ioapic_set_irq (opaque=0x61b000002a80,
vector=2, level=1) at hw/intc/ioapic.c:186
#11 0x00005555598769f6 in qemu_set_irq (irq=0x606000040f40, level=1) at
hw/core/irq.c:44
#12 0x00005555585fc097 in gsi_handler (opaque=0x61200000b8c0, n=0,
level=1) at hw/i386/x86.c:336
#13 0x00005555598769f6 in qemu_set_irq (irq=0x60600003db80, level=1) at
hw/core/irq.c:44
#14 0x0000555557653047 in hpet_handle_legacy_irq (opaque=0x61f000000080,
n=0, level=1) at hw/timer/hpet.c:707
#15 0x00005555598769f6 in qemu_set_irq (irq=0x606000042500, level=1) at
hw/core/irq.c:44
#16 0x00005555571c0686 in pit_irq_timer_update (s=0x616000032018,
current_time=0) at hw/timer/i8254.c:262
#17 0x00005555571c01c9 in pit_irq_control (opaque=0x616000031e80, n=0,
enable=1) at hw/timer/i8254.c:304
#18 0x00005555598769f6 in qemu_set_irq (irq=0x6060000435e0, level=1) at
hw/core/irq.c:44
#19 0x00005555576518cb in hpet_reset (d=0x61f000000080) at
hw/timer/hpet.c:690
#20 0x000055555986dfbe in device_transitional_reset (obj=0x61f000000080)
at hw/core/qdev.c:1114
#21 0x0000555559870e8e in resettable_phase_hold (obj=0x61f000000080,
opaque=0x0, type=RESET_TYPE_COLD) at hw/core/resettable.c:182
#22 0x0000555559846add in bus_reset_child_foreach (obj=0x60c00002e000,
cb=0x5555598707e0 <resettable_phase_hold>, opaque=0x0,
type=RESET_TYPE_COLD) at hw/core/bus.c:94
#23 0x0000555559873c29 in resettable_child_foreach (rc=0x60e00003e160,
obj=0x60c00002e000, cb=0x5555598707e0 <resettable_phase_hold>,
opaque=0x0, type=RESET_TYPE_COLD)
    at hw/core/resettable.c:96
#24 0x0000555559870b01 in resettable_phase_hold (obj=0x60c00002e000,
opaque=0x0, type=RESET_TYPE_COLD) at hw/core/resettable.c:173
#25 0x000055555986fbc3 in resettable_assert_reset (obj=0x60c00002e000,
type=RESET_TYPE_COLD) at hw/core/resettable.c:60
#26 0x000055555986fa6a in resettable_reset (obj=0x60c00002e000,
type=RESET_TYPE_COLD) at hw/core/resettable.c:45
#27 0x00005555598725ba in resettable_cold_reset_fn
(opaque=0x60c00002e000) at hw/core/resettable.c:269
#28 0x000055555986f9e9 in qemu_devices_reset () at hw/core/reset.c:69
#29 0x000055555865d711 in pc_machine_reset (machine=0x615000020100) at
hw/i386/pc.c:1901
#30 0x00005555589ea197 in qemu_system_reset (reason=SHUTDOWN_CAUSE_NONE)
at softmmu/vl.c:1403
#31 0x00005555589f7738 in qemu_init (argc=16, argv=0x7fffffffd278,
envp=0x7fffffffd300) at softmmu/vl.c:4458
#32 0x00005555571615fa in main (argc=16, argv=0x7fffffffd278,
envp=0x7fffffffd300) at softmmu/main.c:49


