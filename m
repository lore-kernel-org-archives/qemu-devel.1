Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF952C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:13:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B808206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fno3Mjl/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B808206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kONgm-00086j-76
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 12:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kONcg-0003vH-Lj
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 12:09:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kONce-0000L3-O5
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 12:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601654967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=v77O4D+B1h106BOw8BG714KC3w9llPv2M4ws/EzNo94=;
 b=fno3Mjl/VFIDi3cRTRGXDAQ3821iN8kX9ZbcJacOFBJu6lgiQMRApGKrS1ts/mYLujCpET
 cKs9K5KD4nIPwa7zKSRQIYMSld9OF7xrxCXalGDHczeYp2PMJiKN9wf6YJdzUy41zuPtgP
 BosT9D4NRhvQTJvRSBkjWzUubl90prc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-LJKdkCDJMSOM8AsRLIL1uw-1; Fri, 02 Oct 2020 12:09:25 -0400
X-MC-Unique: LJKdkCDJMSOM8AsRLIL1uw-1
Received: by mail-wr1-f72.google.com with SMTP id f18so717490wrv.19
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 09:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=v77O4D+B1h106BOw8BG714KC3w9llPv2M4ws/EzNo94=;
 b=UZO23oyaIgfzckA8WH7aedwzio3U/i2iQVLtPVVcxc8SP5FD91va3rCBjUQ1cZ70JR
 JRPW5OW2dYOBEtJoI1QQ3vasfJqyM33qCnKqTuz2CYjRH8cR6ot2XCz8C3ZbFn5zutel
 Y29ofUFXHcfcVqeE70DU1efznSOKkI3byLtahzyRvrupi/8+Ic/f7ZDQjdgJVQ+ocqD6
 ngGMR/RlEXfTnjbk7KJoSBBAZCnmFLpZz8mC6zgCLOGaope4oH5Bsj8ebcNjPd6R1QDm
 2YYK/st/NNpBTHvGCpdv8ihZmEP52JVom+tSgmwgDV9yJ/HcgEr+UDmqyL14Yr5sM3LN
 etEA==
X-Gm-Message-State: AOAM530Pc5s6htkZo0KGquo+VKZK+6b7/J4+9ldidcGmWXiYum9HKcas
 /CL74sSRfLIYxMrRMOwcCGN510z4h+nED9gBbXuXUlZpJ/eLfRpUQ2dOrf7Zcqda/uk9e5SE5pR
 wXpiq3DxSjx3hJJE=
X-Received: by 2002:adf:ec4d:: with SMTP id w13mr4026106wrn.334.1601654964349; 
 Fri, 02 Oct 2020 09:09:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwj8ap4BRD7ejoxqSu+bLlkV22KLPynezKWzsXm2ZYeqCwQVkG+E4lyeZeRVZRINzY9TuSQOA==
X-Received: by 2002:adf:ec4d:: with SMTP id w13mr4026063wrn.334.1601654964007; 
 Fri, 02 Oct 2020 09:09:24 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id a5sm2325376wrp.37.2020.10.02.09.09.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 09:09:23 -0700 (PDT)
Subject: Re: [PATCH] hw/acpi/piix4: Rename piix4_pm_add_propeties() to
 piix4_pm_add_properties()
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
References: <160165476743.57452.2128307974125615413.stgit@bahia.lan>
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
Message-ID: <9fc9a729-f806-52a9-3583-df2b5602ed19@redhat.com>
Date: Fri, 2 Oct 2020 18:09:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <160165476743.57452.2128307974125615413.stgit@bahia.lan>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.256, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/2/20 6:06 PM, Greg Kurz wrote:

Maybe add "Fix a typo" to make it obvious.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/acpi/piix4.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index 894d357f8c35..67a1ea41914f 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -437,7 +437,7 @@ static void piix4_pm_machine_ready(Notifier *n, void *opaque)
>          (memory_region_present(io_as, 0x2f8) ? 0x90 : 0);
>  }
>  
> -static void piix4_pm_add_propeties(PIIX4PMState *s)
> +static void piix4_pm_add_properties(PIIX4PMState *s)
>  {
>      static const uint8_t acpi_enable_cmd = ACPI_ENABLE;
>      static const uint8_t acpi_disable_cmd = ACPI_DISABLE;
> @@ -509,7 +509,7 @@ static void piix4_pm_realize(PCIDevice *dev, Error **errp)
>                                     pci_get_bus(dev), s);
>      qbus_set_hotplug_handler(BUS(pci_get_bus(dev)), OBJECT(s));
>  
> -    piix4_pm_add_propeties(s);
> +    piix4_pm_add_properties(s);
>  }
>  
>  I2CBus *piix4_pm_init(PCIBus *bus, int devfn, uint32_t smb_io_base,
> 
> 
> 


