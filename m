Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E72BC43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 11:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A2C2208FE
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 11:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWq/vdzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A2C2208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH3j2-00049G-HE
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 07:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH3iI-0003Ut-CJ; Sat, 12 Sep 2020 07:29:02 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44970)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH3iG-0007Pj-Lk; Sat, 12 Sep 2020 07:29:02 -0400
Received: by mail-wr1-x442.google.com with SMTP id s12so13868058wrw.11;
 Sat, 12 Sep 2020 04:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tLgNNKh2C4rFR53qRX7EPD5t9M8ySKtRtyiQtdzn7us=;
 b=LWq/vdzKIEvEITNPdmGgq/wEVQFXFzuiGE1CduCJsgK27qcp5osMEcHEhCMD9/1ox1
 OaVT3qiJYBFA3z84ZXCUZzcJSjkvmZp7iD64zR+poNrzbwbPyvvp9Imo2xXL9aXRc1yO
 rzG44VopOJe7WQ8kdiziM8Si5X24s62+dvooBrwUwYjC1ELkIw9zuJDgkHrXUy7Pf70V
 R+osdkPuAFS3KyKU65Uip+DHf/3gKqEJqjJ3ljcvcukYLcJK4wzUHpee7YH2JRfsbFQn
 O1PPQFZWhO/v2/q+JN5sNrBr4LmmWg0a0rCqXbW+xMgYhzcK8Z9j1CTB73Q9/9lkku2E
 n9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tLgNNKh2C4rFR53qRX7EPD5t9M8ySKtRtyiQtdzn7us=;
 b=t1y8uth3WEyAaAGq7QidwIUQjYFZ3DjK+/Ysi32H0Lv8fD0fwImYE/lZe72P2ZcWKG
 z1b17SI6bbBcKaw7wJRRE2tE1GRRhzqtk36dbVi9nCvBCT0wHwuHyU79/aL+tQ7gid+9
 ELWSTwzzMH+ExpCe9ZC+fRcgcg1c1ZTismrFsnSKdM8H9LRE7vCvit83gXtMyCVw2k6q
 B+O+Sd19wJOrEC8wZZLdUHTdQSRXYV+yT8fTaSpqOOHn6/ELQT6lBF0TAv1PTwAL/iZl
 Ca/EDRIZYPGtbuIKYu3i+UKTKqwaMX5hlg6S5ASD6Y7crHSR+KlY680VkixByUxhXKOG
 hB9Q==
X-Gm-Message-State: AOAM531c6nmP+jmpP3n5rygBQGh8ml2B+oSMhd+9J+AmOq6AxEbKk21F
 aVQjPReSGJenb4PkWur0iYg=
X-Google-Smtp-Source: ABdhPJzgEhh4WXfkfBExIxOb2dmIdu8Bn2+mSx2iSma7XKACDedWuHJOf9/OpcW0B58XKoN1dX8cvw==
X-Received: by 2002:a5d:4088:: with SMTP id o8mr6377336wrp.112.1599910138742; 
 Sat, 12 Sep 2020 04:28:58 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id y1sm9615306wmi.36.2020.09.12.04.28.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2020 04:28:58 -0700 (PDT)
Subject: Re: [PATCH 7/7] hw/char/serial: Let SerialState have an 'id' field
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200907015535.827885-1-f4bug@amsat.org>
 <20200907015535.827885-8-f4bug@amsat.org>
 <b6dceab9-d20d-290e-93c5-170a99499da2@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9ba2e4c6-859e-0798-c43d-585413864095@amsat.org>
Date: Sat, 12 Sep 2020 13:28:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <b6dceab9-d20d-290e-93c5-170a99499da2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-1.543,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/12/20 11:14 AM, Paolo Bonzini wrote:
> On 07/09/20 03:55, Philippe Mathieu-Daudé wrote:
>> When a SoC has multiple UARTs (some configured differently),
>> it is hard to associate events to their UART.
>>
>> To be able to distinct trace events between various instances,
>> add an 'id' field. Update the trace format accordingly.
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  include/hw/char/serial.h | 1 +
>>  hw/char/serial.c         | 7 ++++---
>>  hw/char/trace-events     | 6 +++---
>>  3 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
>> index 3d2a5b27e87..3ee2d096a85 100644
>> --- a/include/hw/char/serial.h
>> +++ b/include/hw/char/serial.h
>> @@ -75,6 +75,7 @@ typedef struct SerialState {
>>      uint64_t char_transmit_time;    /* time to transmit a char in ticks */
>>      int poll_msl;
>>  
>> +    uint8_t id;
>>      QEMUTimer *modem_status_poll;
>>      MemoryRegion io;
>>  } SerialState;
>> diff --git a/hw/char/serial.c b/hw/char/serial.c
>> index ade89fadb44..e5a6b939f13 100644
>> --- a/hw/char/serial.c
>> +++ b/hw/char/serial.c
>> @@ -177,7 +177,7 @@ static void serial_update_parameters(SerialState *s)
>>      ssp.stop_bits = stop_bits;
>>      s->char_transmit_time =  (NANOSECONDS_PER_SECOND / speed) * frame_size;
>>      qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_PARAMS, &ssp);
>> -    trace_serial_update_parameters(speed, parity, data_bits, stop_bits);
>> +    trace_serial_update_parameters(s->id, speed, parity, data_bits, stop_bits);
>>  }
>>  
>>  static void serial_update_msl(SerialState *s)
>> @@ -333,7 +333,7 @@ static void serial_ioport_write(void *opaque, hwaddr addr, uint64_t val,
>>      SerialState *s = opaque;
>>  
>>      assert(size == 1 && addr < 8);
>> -    trace_serial_write(addr, val);
>> +    trace_serial_write(s->id, addr, val);
>>      switch(addr) {
>>      default:
>>      case 0:
>> @@ -550,7 +550,7 @@ static uint64_t serial_ioport_read(void *opaque, hwaddr addr, unsigned size)
>>          ret = s->scr;
>>          break;
>>      }
>> -    trace_serial_read(addr, ret);
>> +    trace_serial_read(s->id, addr, ret);
>>      return ret;
>>  }
>>  
>> @@ -1013,6 +1013,7 @@ static const TypeInfo serial_io_info = {
>>  };
>>  
>>  static Property serial_properties[] = {
>> +    DEFINE_PROP_UINT8("id", SerialState, id, 0),
>>      DEFINE_PROP_CHR("chardev", SerialState, chr),
>>      DEFINE_PROP_UINT32("baudbase", SerialState, baudbase, 115200),
>>      DEFINE_PROP_BOOL("wakeup", SerialState, wakeup, false),
>> diff --git a/hw/char/trace-events b/hw/char/trace-events
>> index cd36b63f39d..40800c9334c 100644
>> --- a/hw/char/trace-events
>> +++ b/hw/char/trace-events
>> @@ -5,9 +5,9 @@ parallel_ioport_read(const char *desc, uint16_t addr, uint8_t value) "read [%s]
>>  parallel_ioport_write(const char *desc, uint16_t addr, uint8_t value) "write [%s] addr 0x%02x val 0x%02x"
>>  
>>  # serial.c
>> -serial_read(uint16_t addr, uint8_t value) "read addr 0x%02x val 0x%02x"
>> -serial_write(uint16_t addr, uint8_t value) "write addr 0x%02x val 0x%02x"
>> -serial_update_parameters(uint64_t baudrate, char parity, int data_bits, int stop_bits) "baudrate=%"PRIu64" parity='%c' data=%d stop=%d"
>> +serial_read(uint8_t id, uint8_t addr, uint8_t value) "id#%u read addr 0x%x val 0x%02x"
>> +serial_write(uint8_t id, uint8_t addr, uint8_t value) "id#%u write addr 0x%x val 0x%02x"
>> +serial_update_parameters(uint8_t id, uint64_t baudrate, char parity, int data_bits, int stop_bits) "id#%u baudrate=%"PRIu64" parity=%c data=%d stop=%d"
>>  
>>  # virtio-serial-bus.c
>>  virtio_serial_send_control_event(unsigned int port, uint16_t event, uint16_t value) "port %u, event %u, value %u"
>>
> 
> I'm not sure about making this one a one-off for serial.c.  You could
> add the SerialState* too, for example.

hw/char/serial-pci-multi.c:45

Ah indeed, not sure why I only used qdev_alias_all_properties()
on the ISA one. Probably because I don't use the other ones.

I'll send a new patch for the PCI-single device:

-- >8 --
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -81,7 +81,6 @@ static const VMStateDescription vmstate_pci_serial = {
 };

 static Property serial_pci_properties[] = {
-    DEFINE_PROP_CHR("chardev",  PCISerialState, state.chr),
     DEFINE_PROP_UINT8("prog_if",  PCISerialState, prog_if, 0x02),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -106,6 +105,8 @@ static void serial_pci_init(Object *o)
     PCISerialState *ps = PCI_SERIAL(o);

     object_initialize_child(o, "serial", &ps->state, TYPE_SERIAL);
+
+    qdev_alias_all_properties(DEVICE(&ps->state), o);
 }
---

And amend to this one:

-- >8 --
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -105,6 +105,7 @@ static void multi_serial_pci_realize(PCIDevice *dev,
Error **errp)

     for (i = 0; i < nports; i++) {
         s = pci->state + i;
+        qdev_prop_set_uint8(s, "id", i);
         if (!qdev_realize(DEVICE(s), NULL, errp)) {
             multi_serial_pci_exit(dev);
             return;
---

Then we are done.

>  I have queued the other six though.

Thanks!

> 
> Paolo
> 
> 

