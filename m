Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF7DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 940DB2053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lal+t5y6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940DB2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiIrV-0004Z2-Ss
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 10:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiIhT-0002m4-Vw
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 10:24:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25621
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiIhS-0005Ra-AK
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 10:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591626269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GupZWDNv07RZ4fNCjRCHyZPREd78OwoIByKB/Rya2iQ=;
 b=Lal+t5y6BrthwoxVvmwZV9i6+IKJM0cAl4d20JpAndu4qWSAlio1ELaE9XxgHcKCNFG5FW
 c8B7tVopzkB9+9MFvVUEWgqiS3cNLM6m7lo6Ln8p6ElEBJ9cxI9PQXtvq7rudwNGeJz+wX
 63kyQrHltQf6CESZ7DDDOlA7s5reSFo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-gtzab4wTMYS8IugRiGynkw-1; Mon, 08 Jun 2020 10:24:27 -0400
X-MC-Unique: gtzab4wTMYS8IugRiGynkw-1
Received: by mail-wr1-f72.google.com with SMTP id n6so7248415wrv.6
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 07:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=GupZWDNv07RZ4fNCjRCHyZPREd78OwoIByKB/Rya2iQ=;
 b=SQiDRJ8JQGQJDQJxYP/Nem5fGDqnmTqbooEzHxjdepA+Hyuo9+1sGWBHnMl2awL89H
 jL29DJMsHA0kn44E6DNzmhE20B5rB6kwJF8ZXR0i/uagOSKuGdicU+C2Ec2la6RHlSSM
 PJdG8R6iCM2bY7t0uQND6jpTctjQLxcjIUSn9h5/kSyQUA1rUxqZI9Dl0LQBvnQD3Ps+
 C5uH2agDAsOOIk9n0kr/InEcBp3EtijjbaAf6zah68mugRCqlzFcBsz0XZc8xmXlyBJo
 LZUd5l3CNXmKEk7EG1vuHnHWlOSbsBJgXYw9S4F5deYLLcl36k5e1aoJWbsa29Yg6QJs
 yQKg==
X-Gm-Message-State: AOAM530kaBQYV/cy7D6p3B+LliJ64TxQHofFsotLoNIe2wiL7gLA10od
 kkMA1mhESrgMjue3KDHuUudyzIBNmZ74sca+9FdLafhMTFPc5jKy+Mmijit6IcTdJnHK2YI1dQV
 bTVOzyuMevyTjD80=
X-Received: by 2002:adf:f988:: with SMTP id f8mr25680499wrr.81.1591626266532; 
 Mon, 08 Jun 2020 07:24:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfywioNEaVEg7jUHovrlNBKA63H5Yx3R3UVVBmKqN5Xq6Eo0ylAmlIW581VFfSiZvgGEH4NQ==
X-Received: by 2002:adf:f988:: with SMTP id f8mr25680469wrr.81.1591626266242; 
 Mon, 08 Jun 2020 07:24:26 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id k21sm24521116wrd.24.2020.06.08.07.24.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 07:24:25 -0700 (PDT)
Subject: Re: [PATCH v2 23/24] sd: Hide the qdev-but-not-quite thing created by
 sd_init()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200528110444.20456-1-armbru@redhat.com>
 <20200528110444.20456-24-armbru@redhat.com>
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
Message-ID: <9c298cfe-de78-0ee9-5fc0-c58598dd4b71@redhat.com>
Date: Mon, 8 Jun 2020 16:24:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200528110444.20456-24-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/20 1:04 PM, Markus Armbruster wrote:
> Commit 260bc9d8aa "hw/sd/sd.c: QOMify" QOMified only the device
> itself, not its users.  It kept sd_init() around for non-QOMified
> users.
> 
> More than four years later, three such users remain: omap1 (machines
> cheetah, sx1, sx1-v1) and omap2 (machines n800, n810) are not
> QOMified, and pl181 (machines integratorcp, realview-eb,
> realview-eb-mpcore, realview-pb-a8 realview-pbx-a9, versatileab,
> versatilepb, vexpress-a15, vexpress-a9) is not QOMified properly.
> 
> The issue I presently have with this: an "sd-card" device should plug
> into an "sd-bus" (its DeviceClass member bus_type says so), but
> sd_init() leaves it unplugged.  This is normally a bug (I just fixed
> some instances), and I'd like to assert proper pluggedness to prevent
> regressions.  However, the qdev-but-not-quite thing returned by
> sd_init() would fail the assertion.  Meh.
> 
> Make sd_init() hide it from QOM/qdev.  Visible in "info qom-tree",
> here's the change for cheetah:
> 
>      /machine (cheetah-machine)
>        [...]
>        /unattached (container)
>          [...]
>          /device[5] (serial-mm)
>            /serial (serial)
>            /serial[0] (qemu:memory-region)
>     -    /device[6] (sd-card)
>     -    /device[7] (omap-gpio)
>     +    /device[6] (omap-gpio)
>          [rest of device[*] renumbered...]
> 
> Cc: "Philippe Mathieu-Daudé" <philmd@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/sd/sd.c | 40 ++++++++++++++++++++++++++++------------
>  1 file changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 3c06a0ac6d..7070a116ea 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -83,6 +83,10 @@ enum SDCardStates {
>  struct SDState {
>      DeviceState parent_obj;
>  
> +    /* If true, created by sd_init() for a non-qdevified caller */
> +    /* TODO purge them with fire */
> +    bool me_no_qdev_me_kill_mammoth_with_rocks;

Your next patch does not use me_no_qdev_me_kill_mammoth_with_rocks in
qdev_assert_realized_properly().

Suggestion for less ugly hack:

static int qdev_assert_realized_properly(Object *obj, void *opaque)
{
    DeviceState *dev = DEVICE(object_dynamic_cast(obj, TYPE_DEVICE));
    DeviceClass *dc;

    if (dev) {
        if (object_dynamic_cast(OBJECT(obj), TYPE_SD_CARD)) {
            /* bla bla bla */
            return 17;
        }
        dc = DEVICE_GET_CLASS(dev);
        assert(dev->realized);
        assert(dev->parent_bus || !dc->bus_type);
    }
    return 0;
}

> +
>      /* SD Memory Card Registers */
>      uint32_t ocr;
>      uint8_t scr[8];
> @@ -129,6 +133,8 @@ struct SDState {
>      bool cmd_line;
>  };
>  
> +static void sd_realize(DeviceState *dev, Error **errp);
> +
>  static const char *sd_state_name(enum SDCardStates state)
>  {
>      static const char *state_name[] = {
> @@ -590,7 +596,7 @@ static void sd_cardchange(void *opaque, bool load, Error **errp)
>  {
>      SDState *sd = opaque;
>      DeviceState *dev = DEVICE(sd);
> -    SDBus *sdbus = SD_BUS(qdev_get_parent_bus(dev));
> +    SDBus *sdbus;
>      bool inserted = sd_get_inserted(sd);
>      bool readonly = sd_get_readonly(sd);
>  
> @@ -601,19 +607,17 @@ static void sd_cardchange(void *opaque, bool load, Error **errp)
>          trace_sdcard_ejected();
>      }
>  
> -    /* The IRQ notification is for legacy non-QOM SD controller devices;
> -     * QOMified controllers use the SDBus APIs.
> -     */
> -    if (sdbus) {
> -        sdbus_set_inserted(sdbus, inserted);
> -        if (inserted) {
> -            sdbus_set_readonly(sdbus, readonly);
> -        }
> -    } else {
> +    if (sd->me_no_qdev_me_kill_mammoth_with_rocks) {
>          qemu_set_irq(sd->inserted_cb, inserted);
>          if (inserted) {
>              qemu_set_irq(sd->readonly_cb, readonly);
>          }
> +    } else {
> +        sdbus = SD_BUS(qdev_get_parent_bus(dev));
> +        sdbus_set_inserted(sdbus, inserted);
> +        if (inserted) {
> +            sdbus_set_readonly(sdbus, readonly);
> +        }
>      }
>  }
>  
> @@ -697,6 +701,7 @@ SDState *sd_init(BlockBackend *blk, bool is_spi)
>  {
>      Object *obj;
>      DeviceState *dev;
> +    SDState *sd;
>      Error *err = NULL;
>  
>      obj = object_new(TYPE_SD_CARD);
> @@ -707,13 +712,24 @@ SDState *sd_init(BlockBackend *blk, bool is_spi)
>          return NULL;
>      }
>      qdev_prop_set_bit(dev, "spi", is_spi);
> -    object_property_set_bool(obj, true, "realized", &err);
> +
> +    /*
> +     * Realizing the device properly would put it into the QOM
> +     * composition tree even though it is not plugged into an
> +     * appropriate bus.  That's a no-no.  Hide the device from
> +     * QOM/qdev, and call its qdev realize callback directly.
> +     */
> +    object_ref(obj);
> +    object_unparent(obj);
> +    sd_realize(dev, &err);
>      if (err) {
>          error_reportf_err(err, "sd_init failed: ");
>          return NULL;
>      }
>  
> -    return SD_CARD(dev);
> +    sd = SD_CARD(dev);
> +    sd->me_no_qdev_me_kill_mammoth_with_rocks = true;
> +    return sd;
>  }
>  
>  void sd_set_cb(SDState *sd, qemu_irq readonly, qemu_irq insert)
> 


