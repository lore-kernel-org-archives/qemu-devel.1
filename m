Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88402C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:39:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51BD92074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IlKZDuXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51BD92074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiYrS-0006kr-FT
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 03:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiYqU-0005Lu-FS
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:38:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37044
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiYqS-0008MU-Jo
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591688330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4Ch9oOk74h03S6rdhPc5Sn1JNVg2X81pXybbOpRQ4aU=;
 b=IlKZDuXozXxfbapJhOd83j8w6QNbm5gF1HTVgjZhDwWBo9qXImfuhfqAse070SYRlaXO9D
 0WG5OUSVZEQfkm/dSZP/PCXDK9f7gttNN9aFBusKzw0QBa4uxxiNf7RpIbUNGq9Z3nNhww
 IkAg6B2bEGiIIqs5CTh8hjtiuI+uMqw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-t4cfKihnNemiXMCoBogbmw-1; Tue, 09 Jun 2020 03:38:49 -0400
X-MC-Unique: t4cfKihnNemiXMCoBogbmw-1
Received: by mail-wr1-f70.google.com with SMTP id i6so6636610wrr.23
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 00:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=4Ch9oOk74h03S6rdhPc5Sn1JNVg2X81pXybbOpRQ4aU=;
 b=twOK/XKl4z4kVHjMTZngXMjzA65STXrHP62OypPiu5tqR7dHKl3B9/Lcz0QB8YxxRx
 DdrVzN/aGJMGDncWyM7uE34+Yr7N5+MewqFkbSG1/kF6kPp3roUco+PyoGPYOsN1Q7Xx
 qEqRdG43ORgswjdZnO3xeXyUeAtvwMYG9FN/5bosN4lFJ77TUD7jKSQDbxe8bbBQ4zVY
 /jl+O1fsToFL3wu0Vm39DPxa/vEiY9Xj2VKAVP37IrltVBjgqAZHgbRuG38Zc4JDist8
 mQfFuSmjn/OqV4ZPmcXzZIHiirMCu+UJ7V8bvXYnDvjvrdS8+ec0KE4W4MtHDa5/X3IH
 Xy0A==
X-Gm-Message-State: AOAM530KQaC8kMmUJXgBtaQSnYNPPBXCuJ5HWmNEB6qr4BcjCCVR7ow/
 vLXHFdd9qtvJsK9R4J77+mZ8+5dXe8rhpjNhlGRdA7XatA9hV0iBkvXtyu/siSstLGeGYlVauNw
 j73W17soQKEYrYjY=
X-Received: by 2002:a05:600c:4410:: with SMTP id
 u16mr2623078wmn.88.1591688327994; 
 Tue, 09 Jun 2020 00:38:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyS3kLqBDa1A3Oql9E451Pm8rgaRgjBU4QOGBmDfincaMzyjKYSzEG1KOuIOjGO3FlSifQ/8w==
X-Received: by 2002:a05:600c:4410:: with SMTP id
 u16mr2623060wmn.88.1591688327711; 
 Tue, 09 Jun 2020 00:38:47 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id u9sm1991202wme.16.2020.06.09.00.38.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 00:38:46 -0700 (PDT)
Subject: Re: [PATCH v2 23/24] sd: Hide the qdev-but-not-quite thing created by
 sd_init()
To: Markus Armbruster <armbru@redhat.com>
References: <20200528110444.20456-1-armbru@redhat.com>
 <20200528110444.20456-24-armbru@redhat.com>
 <9c298cfe-de78-0ee9-5fc0-c58598dd4b71@redhat.com>
 <87lfkwspxm.fsf@dusky.pond.sub.org>
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
Message-ID: <613cfd4d-2124-f69c-e20c-2e7a460fe4a5@redhat.com>
Date: Tue, 9 Jun 2020 09:38:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87lfkwspxm.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 23:42:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/9/20 8:39 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> On 5/28/20 1:04 PM, Markus Armbruster wrote:
>>> Commit 260bc9d8aa "hw/sd/sd.c: QOMify" QOMified only the device
>>> itself, not its users.  It kept sd_init() around for non-QOMified
>>> users.
>>>
>>> More than four years later, three such users remain: omap1 (machines
>>> cheetah, sx1, sx1-v1) and omap2 (machines n800, n810) are not
>>> QOMified, and pl181 (machines integratorcp, realview-eb,
>>> realview-eb-mpcore, realview-pb-a8 realview-pbx-a9, versatileab,
>>> versatilepb, vexpress-a15, vexpress-a9) is not QOMified properly.
>>>
>>> The issue I presently have with this: an "sd-card" device should plug
>>> into an "sd-bus" (its DeviceClass member bus_type says so), but
>>> sd_init() leaves it unplugged.  This is normally a bug (I just fixed
>>> some instances), and I'd like to assert proper pluggedness to prevent
>>> regressions.  However, the qdev-but-not-quite thing returned by
>>> sd_init() would fail the assertion.  Meh.
>>>
>>> Make sd_init() hide it from QOM/qdev.  Visible in "info qom-tree",
>>> here's the change for cheetah:
>>>
>>>      /machine (cheetah-machine)
>>>        [...]
>>>        /unattached (container)
>>>          [...]
>>>          /device[5] (serial-mm)
>>>            /serial (serial)
>>>            /serial[0] (qemu:memory-region)
>>>     -    /device[6] (sd-card)
>>>     -    /device[7] (omap-gpio)
>>>     +    /device[6] (omap-gpio)
>>>          [rest of device[*] renumbered...]
>>>
>>> Cc: "Philippe Mathieu-Daudé" <philmd@redhat.com>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>  hw/sd/sd.c | 40 ++++++++++++++++++++++++++++------------
>>>  1 file changed, 28 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>> index 3c06a0ac6d..7070a116ea 100644
>>> --- a/hw/sd/sd.c
>>> +++ b/hw/sd/sd.c
>>> @@ -83,6 +83,10 @@ enum SDCardStates {
>>>  struct SDState {
>>>      DeviceState parent_obj;
>>>  
>>> +    /* If true, created by sd_init() for a non-qdevified caller */
>>> +    /* TODO purge them with fire */
>>> +    bool me_no_qdev_me_kill_mammoth_with_rocks;
>>
>> Your next patch does not use me_no_qdev_me_kill_mammoth_with_rocks in
>> qdev_assert_realized_properly().
> 
> It doesn't have to, because this qdev-but-not-quite thing isn't visible
> there.
> 
>> Suggestion for less ugly hack:
>>
>> static int qdev_assert_realized_properly(Object *obj, void *opaque)
>> {
>>     DeviceState *dev = DEVICE(object_dynamic_cast(obj, TYPE_DEVICE));
>>     DeviceClass *dc;
>>
>>     if (dev) {
>>         if (object_dynamic_cast(OBJECT(obj), TYPE_SD_CARD)) {
>>             /* bla bla bla */
>>             return 17;
>>         }
>>         dc = DEVICE_GET_CLASS(dev);
>>         assert(dev->realized);
>>         assert(dev->parent_bus || !dc->bus_type);
>>     }
>>     return 0;
>> }
> 
> Now qdev_assert_realized_properly() knows about the caveman.  I don't
> like that.
> 
> My hack keeps the knowledge strictly local, and protects all users of
> QOM from getting exposed to the caveman, not just the "realized
> properly" assertion.  My hack is locally ugly, but I consider that a
> feature ;)

Understood.

> 
> My patch could be made smaller: @me_no_qdev_me_kill_mammoth_with_rocks
> exists only to make the parts supporting the caveman more immediately
> obvious.
> 
>>
>>> +
>>>      /* SD Memory Card Registers */
>>>      uint32_t ocr;
>>>      uint8_t scr[8];
>>> @@ -129,6 +133,8 @@ struct SDState {
>>>      bool cmd_line;
>>>  };
>>>  
>>> +static void sd_realize(DeviceState *dev, Error **errp);
>>> +
>>>  static const char *sd_state_name(enum SDCardStates state)
>>>  {
>>>      static const char *state_name[] = {
>>> @@ -590,7 +596,7 @@ static void sd_cardchange(void *opaque, bool load, Error **errp)
>>>  {
>>>      SDState *sd = opaque;
>>>      DeviceState *dev = DEVICE(sd);
>>> -    SDBus *sdbus = SD_BUS(qdev_get_parent_bus(dev));
>>> +    SDBus *sdbus;
>>>      bool inserted = sd_get_inserted(sd);
>>>      bool readonly = sd_get_readonly(sd);
>>>  
>>> @@ -601,19 +607,17 @@ static void sd_cardchange(void *opaque, bool load, Error **errp)
>>>          trace_sdcard_ejected();
>>>      }
>>>  
>>> -    /* The IRQ notification is for legacy non-QOM SD controller devices;
>>> -     * QOMified controllers use the SDBus APIs.
>>> -     */
>>> -    if (sdbus) {
>>> -        sdbus_set_inserted(sdbus, inserted);
>>> -        if (inserted) {
>>> -            sdbus_set_readonly(sdbus, readonly);
>>> -        }
>>> -    } else {
>>> +    if (sd->me_no_qdev_me_kill_mammoth_with_rocks) {
>>>          qemu_set_irq(sd->inserted_cb, inserted);
>>>          if (inserted) {
>>>              qemu_set_irq(sd->readonly_cb, readonly);
>>>          }
>>> +    } else {
>>> +        sdbus = SD_BUS(qdev_get_parent_bus(dev));
>>> +        sdbus_set_inserted(sdbus, inserted);
>>> +        if (inserted) {
>>> +            sdbus_set_readonly(sdbus, readonly);
>>> +        }
>>>      }
>>>  }
>>>  
>>> @@ -697,6 +701,7 @@ SDState *sd_init(BlockBackend *blk, bool is_spi)
>>>  {
>>>      Object *obj;
>>>      DeviceState *dev;
>>> +    SDState *sd;
>>>      Error *err = NULL;
>>>  
>>>      obj = object_new(TYPE_SD_CARD);
>>> @@ -707,13 +712,24 @@ SDState *sd_init(BlockBackend *blk, bool is_spi)
>>>          return NULL;
>>>      }
>>>      qdev_prop_set_bit(dev, "spi", is_spi);
>>> -    object_property_set_bool(obj, true, "realized", &err);
>>> +
>>> +    /*
>>> +     * Realizing the device properly would put it into the QOM
>>> +     * composition tree even though it is not plugged into an
>>> +     * appropriate bus.  That's a no-no.  Hide the device from
>>> +     * QOM/qdev, and call its qdev realize callback directly.
>>> +     */
>>> +    object_ref(obj);
>>> +    object_unparent(obj);
>>> +    sd_realize(dev, &err);
>>>      if (err) {
>>>          error_reportf_err(err, "sd_init failed: ");
>>>          return NULL;
>>>      }
>>>  
>>> -    return SD_CARD(dev);
>>> +    sd = SD_CARD(dev);
>>> +    sd->me_no_qdev_me_kill_mammoth_with_rocks = true;
>>> +    return sd;
>>>  }
>>>  
>>>  void sd_set_cb(SDState *sd, qemu_irq readonly, qemu_irq insert)
>>>
> 


