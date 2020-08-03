Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99974C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 17:53:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ABD222B45
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 17:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhmYRsWR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABD222B45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2edx-0000zR-OF
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 13:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k2edF-0000PP-PA
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 13:52:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k2edD-0007zy-Cc
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 13:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596477134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V69CQn5ED8yx8hTErXL6iO14e2txwAN9EbWykthQYMM=;
 b=YhmYRsWR1Smn5LvJLd/BARO5Kp3oQcFmXkyH8MaDMrufg2/zdXc9vJUB5x6frTErV1vMxo
 HcbYAvGYq6wytvj2lMnkuG+FBD0G1mtjMPh2p5SI6DXy6I07y31MqWydhF0VlDOVrkAuto
 QXrEOS6E8FQaVjsmD3pzp7itC88DBDY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-qwVgvBJFONKlEKd3yCIYgA-1; Mon, 03 Aug 2020 13:52:10 -0400
X-MC-Unique: qwVgvBJFONKlEKd3yCIYgA-1
Received: by mail-wm1-f69.google.com with SMTP id u144so132988wmu.3
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 10:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V69CQn5ED8yx8hTErXL6iO14e2txwAN9EbWykthQYMM=;
 b=sBuJ11nMJ+tmZMh/iJMnRXkgT4hVowYZdlrPSurcQYoRvLYXowIPAOTW+4fmpvM+Rv
 9B+BMRvHSoxSdZsKeSAn6njFO4ZBAtlNPrIKm5uJFr0dqa3yRSJDfsaG6K+hgvUPp4cw
 qx2VZ0kTNytjQEH9q+x1JXgOhQQLFep7S5o+B/+eF1EZm/MZd/s35+V0hggJzVbnPnxR
 xX/S7DNiyfjStzfXPDeBYhYPt2NpuK629b6lLnmZxiGpnxCClD55YNjVFyKyzfQiT0Ha
 isdWik1VyCyhpk4+6g1u/xdDzmUpHq6ZbClTiRJA1Di4X6fYP3hRU988DcylHIlrLWkY
 zoJA==
X-Gm-Message-State: AOAM533yJD+T64/D5Y33xCaer0t5eXTCWZ+Gotdfzgr+wdZDmNtlvbep
 +S8etNvVXlWwdK2pJFwWID809TWCX3Qt2k531Zm5DVSTZF7EcH2T+R8y7MbAKKdfy7PL2f4CWui
 aMDL/LkQSOxAFQuk=
X-Received: by 2002:a1c:984d:: with SMTP id a74mr372601wme.140.1596477128556; 
 Mon, 03 Aug 2020 10:52:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8vS4dwLGtZWIp894gXtpn32KpBem/36ZeqCC8CWzTXuQC1BCstDJrk+OuYVrmOsu+V0SbCw==
X-Received: by 2002:a1c:984d:: with SMTP id a74mr372582wme.140.1596477128280; 
 Mon, 03 Aug 2020 10:52:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id b2sm434835wmj.47.2020.08.03.10.52.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 10:52:07 -0700 (PDT)
Subject: Re: Ping: [PATCH] Emulate dip switch language layout settings on SUN
 keyboard
To: Henrik Carlqvist <hc981@poolhem.se>
References: <20200710201911.3a3e336c.hc981@poolhem.se>
 <20200803192645.48513f57.hc981@poolhem.se>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <43e05cbb-14aa-80ed-d39a-1456f2a0e480@redhat.com>
Date: Mon, 3 Aug 2020 19:52:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200803192645.48513f57.hc981@poolhem.se>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 13:52:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/08/20 19:26, Henrik Carlqvist wrote:
> Would you please consider my patch which implements the honor of the -k switch
> for sparc as a sun keyboard language dip switch setting instead of a hard
> coded en-us keyboard layout?
> 
> The initial patch mail was sent to the mailing list and the listed maintainers
> of escc.c and is also available at
> http://patchwork.ozlabs.org/project/qemu-devel/patch/20200710201911.3a3e336c.hc981@poolhem.se/
> 
> This ping email is also sent to Gerd Hoffmann who many years ago
> (2014) selected the en-us keyboard layout as a hardcoded value in escc.c with
> commit 59e7a130054b55fe15cdfdebf284332b04d990ef.

Artyom, can you review?

Paolo

> Best regards Henrik
> 
> On Fri, 10 Jul 2020 20:19:11 +0200
> Henrik Carlqvist <hc981@poolhem.se> wrote:
> 
>> SUN Type 4, 5 and 5c keyboards have dip switches to choose the language
>> layout of the keyboard. Solaris makes an ioctl to query the value of the
>> dipswitches and uses that value to select keyboard layout. Also the SUN
>> bios like the one in the file ss5.bin uses this value to support at least
>> some keyboard layouts. However, the OpenBIOS provided with qemu is
>> hardcoded to allways use an US keyboard layout.
>>
>> Before this patch, qemu allways gave dip switch value 0x21 (US keyboard),
>> this patch uses the command line switch "-k" (keyboard layout) to select
>> dip switch value. A table is used to lookup values from arguments like:
>>
>> -k fr
>> -k es
>>
>> But the patch also accepts numeric dip switch values directly to the -k
>> switch:
>>
>> -k 0x2b
>> -k 43
>>
>> Both values above are the same and select swedish keyboard as explained in
>> table 3-15 at
>> https://docs.oracle.com/cd/E19683-01/806-6642/new-43/index.html
>>
>> Unless you want to do a full Solaris installation but happen to have
>> access to a bios file, the easiest way to test that the patch works is to:
>>
>> qemu-system-sparc -k sv -bios /path/to/ss5.bin
>>
>> If you already happen to have a Solaris installation in a qemu disk image
>> file you can easily try different keyboard layouts after this patch is
>> applied.
>>
>> Unfortunately my glib version is too old to compile later versions of qemu
>> so even though this patch is made from latest git I have only been able to
>> test it myself with qemu version 4.1.1. I think and hope that this patch
>> will compile and work also with the latest version of git as it only affects
>> one file and there hasn't been much changes to that file since tested
>> version 4.1.1.
>>
>> Best regards Henrik
>>
>> From 2f86bd60750d44206b9181f76115e77b58dff544 Mon Sep 17 00:00:00 2001
>> From: Henrik Carlqvist <hc1245@poolhem.se>
>> Date: Fri, 10 Jul 2020 19:21:08 +0200
>> Subject: [PATCH] Emulating sun keyboard languate layout dip switches, taking
>>  the value for the dip switches from the "-k" option to qemu.
>>
>> Signed-off-by: Henrik Carlqvist <hc1245@poolhem.se>
>> ---
>>  hw/char/escc.c | 74
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++- 1 file changed,
>> 73 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/char/escc.c b/hw/char/escc.c
>> index 7d16ee8688..7287056b5f 100644
>> --- a/hw/char/escc.c
>> +++ b/hw/char/escc.c
>> @@ -30,6 +30,8 @@
>>  #include "qemu/module.h"
>>  #include "hw/char/escc.h"
>>  #include "ui/console.h"
>> +#include "sysemu/sysemu.h"
>> +#include "qemu/cutils.h"
>>  #include "trace.h"
>>  
>>  /*
>> @@ -175,6 +177,7 @@
>>  #define R_MISC1I 14
>>  #define R_EXTINT 15
>>  
>> +static unsigned char sun_keyboard_layout_dip_switch(void);
>>  static void handle_kbd_command(ESCCChannelState *s, int val);
>>  static int serial_can_receive(void *opaque);
>>  static void serial_receive_byte(ESCCChannelState *s, int ch);
>> @@ -730,6 +733,75 @@ static QemuInputHandler sunkbd_handler = {
>>      .event = sunkbd_handle_event,
>>  };
>>  
>> +static unsigned char sun_keyboard_layout_dip_switch(void)
>> +{
>> +    /* Return the value of the dip-switches in a SUN Type 5 keyboard */
>> +    static unsigned char ret = 0xff;
>> +
>> +    if ((ret == 0xff) && keyboard_layout) {
>> +        int i;
>> +        struct layout_values {
>> +            const char *lang;
>> +            unsigned char dip;
>> +        } languages[] =
>> +    /* Dip values from table 3-16 Layouts for Type 4, 5, and 5c Keyboards
>> */+            {
>> +                {"en-us", 0x21}, /* U.S.A. (US5.kt) */
>> +                                 /* 0x22 is some other US (US_UNIX5.kt)*/
>> +                {"fr",    0x23}, /* France (France5.kt) */
>> +                {"da",    0x24}, /* Denmark (Denmark5.kt) */
>> +                {"de",    0x25}, /* Germany (Germany5.kt) */
>> +                {"it",    0x26}, /* Italy (Italy5.kt) */
>> +                {"nl",    0x27}, /* The Netherlands (Netherland5.kt) */
>> +                {"no",    0x28}, /* Norway (Norway.kt) */
>> +                {"pt",    0x29}, /* Portugal (Portugal5.kt) */
>> +                {"es",    0x2a}, /* Spain (Spain5.kt) */
>> +                {"sv",    0x2b}, /* Sweden (Sweden5.kt) */
>> +                {"fr-ch", 0x2c}, /* Switzerland/French (Switzer_Fr5.kt) */
>> +                {"de-ch", 0x2d}, /* Switzerland/German (Switzer_Ge5.kt) */
>> +                {"en-gb", 0x2e}, /* Great Britain (UK5.kt) */
>> +                {"ko",    0x2f}, /* Korea (Korea5.kt) */
>> +                {"tw",    0x30}, /* Taiwan (Taiwan5.kt) */
>> +                {"ja",    0x31}, /* Japan (Japan5.kt) */
>> +                {"fr-ca", 0x32}, /* Canada/French (Canada_Fr5.kt) */
>> +                {"hu",    0x33}, /* Hungary (Hungary5.kt) */
>> +                {"pl",    0x34}, /* Poland (Poland5.kt) */
>> +                {"cz",    0x35}, /* Czech (Czech5.kt) */
>> +                {"ru",    0x36}, /* Russia (Russia5.kt) */
>> +                {"lv",    0x37}, /* Latvia (Latvia5.kt) */
>> +                {"tr",    0x38}, /* Turkey-Q5 (TurkeyQ5.kt) */
>> +                {"gr",    0x39}, /* Greece (Greece5.kt) */
>> +                {"ar",    0x3a}, /* Arabic (Arabic5.kt) */
>> +                {"lt",    0x3b}, /* Lithuania (Lithuania5.kt) */
>> +                {"nl-be", 0x3c}, /* Belgium (Belgian5.kt) */
>> +                {"be",    0x3c}, /* Belgium (Belgian5.kt) */
>> +            };
>> +
>> +        for (i = 0;
>> +             i < sizeof(languages) / sizeof(struct layout_values);
>> +             i++) {
>> +            if (!strcmp(keyboard_layout, languages[i].lang)) {
>> +                ret = languages[i].dip;
>> +                return ret;
>> +            }
>> +        }
>> +        /* Found no known language code */
>> +
>> +        if ((keyboard_layout[0] >= '0') && (keyboard_layout[0] <= '9')) {
>> +            unsigned int tmp;
>> +            /* As a fallback we also accept numeric dip switch value */
>> +            if (!qemu_strtoui(keyboard_layout, NULL, 0, &tmp)) {
>> +                ret = (unsigned char)tmp;
>> +            }
>> +        }
>> +    }
>> +    if (ret == 0xff) {
>> +        /* Final fallback if keyboard_layout was not set or recognized */
>> +        ret = 0x21; /* en-us layout */
>> +    }
>> +    return ret;
>> +}
>> +
>>  static void handle_kbd_command(ESCCChannelState *s, int val)
>>  {
>>      trace_escc_kbd_command(val);
>> @@ -751,7 +823,7 @@ static void handle_kbd_command(ESCCChannelState *s, int
>> val)     case 0xf:
>>          clear_queue(s);
>>          put_queue(s, 0xfe);
>> -        put_queue(s, 0x21); /*  en-us layout */
>> +        put_queue(s, sun_keyboard_layout_dip_switch());
>>          break;
>>      default:
>>          break;
>> -- 
>> 2.14.5
> 


