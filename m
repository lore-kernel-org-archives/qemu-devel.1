Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458E8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:14:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1027B207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvWbbJHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1027B207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiZPB-0002bx-CC
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 04:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiZOb-0002AJ-5b
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 04:14:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46068
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiZOa-0006At-Bw
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 04:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591690447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1c4a6pGXWDwXuEQjeY8RMC8yi8va+DtYv0TlEg7VX90=;
 b=hvWbbJHRSt8jr8xz6rjRPDgk1LfvH2IwMlTezCcLzcDdeBYuVFEbYuKeasv1reUW6WIstP
 2ca6nkI0600DnMY1xD4vO9sFHN81xinxBbCOaXp3oHIRBic+wdc6Jp3F0Yas6A/n5jceW+
 B7jjucKTxHRauh8/iOOmCggekXamcas=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-E62USc9bNcqxZ6mzULycqg-1; Tue, 09 Jun 2020 04:13:50 -0400
X-MC-Unique: E62USc9bNcqxZ6mzULycqg-1
Received: by mail-wm1-f72.google.com with SMTP id t145so458381wmt.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 01:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1c4a6pGXWDwXuEQjeY8RMC8yi8va+DtYv0TlEg7VX90=;
 b=spzW/E4yGWu2cNY98tst1cyKQiR+sKIPV17wi0p2nTWVXpj9lCMObpHWpkBIBTFvDI
 pYNMpf0LYc26sxdYFzbFFjD8di28jfrikERN9bbKbXlz+iHDkZ9ZV7MJLe+f9DyCDCS3
 6a/QkZmY0Isa8Ryqbz5NRxJvHEiD8aksfUpqpsWMQzILM0bkVthGl/zeNxfextH1RhpO
 NrMR3Rc684LXEqML5JaWD3Ekm8ZTaraEr+9KZlHBCdGAhaOmaTciFG3usI92mHPKkjER
 9XvjiNCP507JHycsuGbh5S2r215gOGGlxJSbNrKbjDvPvzy4nwEMV645gSiCJlzeS38C
 SKOQ==
X-Gm-Message-State: AOAM532Ylqi/TvOHbKdi0/wvbdB/IJsTV0cWVGnaPjA/whvCQ1gXIqVJ
 HC2+Sk/48tENuNLV1v5P8HoS2wk+OH4ldlMAVQYeVLYkwJq6CGkX0LUWxjmlyvP9xGN72moWB5g
 UI3E0h05uWmf4ZUo=
X-Received: by 2002:adf:f207:: with SMTP id p7mr3064075wro.206.1591690429177; 
 Tue, 09 Jun 2020 01:13:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBmouzHmU4vzSOZT5Mx2sk1m5qooLse/7/2iZScZUurIkhN6ACO1Br/H2Bqn2p/t+lye66JQ==
X-Received: by 2002:adf:f207:: with SMTP id p7mr3064066wro.206.1591690428963; 
 Tue, 09 Jun 2020 01:13:48 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id f9sm2264938wre.65.2020.06.09.01.13.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 01:13:48 -0700 (PDT)
Subject: Re: [PATCH v2 06/58] qdev: Convert to qbus_realize(), qbus_unrealize()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200529134523.8477-1-armbru@redhat.com>
 <20200529134523.8477-7-armbru@redhat.com>
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
Message-ID: <d777f406-de56-0c4b-f0fa-e038276b57ef@redhat.com>
Date: Tue, 9 Jun 2020 10:13:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200529134523.8477-7-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 3:44 PM, Markus Armbruster wrote:
> I'm going to convert device realization to qdev_realize() with the
> help of Coccinelle.  Convert bus realization to qbus_realize() first,
> to get it out of Coccinelle's way.  Readability improves.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/core/qdev.c | 10 +++-------
>  hw/pci/pci.c   |  2 +-
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index f2c5cee278..b7355fbcd0 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -1024,9 +1024,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
>          resettable_state_clear(&dev->reset);
>  
>          QLIST_FOREACH(bus, &dev->child_bus, sibling) {
> -            object_property_set_bool(OBJECT(bus), true, "realized",
> -                                         &local_err);
> -            if (local_err != NULL) {
> +            if (!qbus_realize(bus, errp)) {
>                  goto child_realize_fail;
>              }
>          }
> @@ -1051,8 +1049,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
>  
>      } else if (!value && dev->realized) {
>          QLIST_FOREACH(bus, &dev->child_bus, sibling) {
> -            object_property_set_bool(OBJECT(bus), false, "realized",
> -                                     &error_abort);
> +            qbus_unrealize(bus);
>          }
>          if (qdev_get_vmsd(dev)) {
>              vmstate_unregister(VMSTATE_IF(dev), qdev_get_vmsd(dev), dev);
> @@ -1070,8 +1067,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
>  
>  child_realize_fail:
>      QLIST_FOREACH(bus, &dev->child_bus, sibling) {
> -        object_property_set_bool(OBJECT(bus), false, "realized",
> -                                 &error_abort);
> +        qbus_unrealize(bus);
>      }
>  
>      if (qdev_get_vmsd(dev)) {
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 70c66965f5..6947c741c3 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -456,7 +456,7 @@ void pci_root_bus_cleanup(PCIBus *bus)
>  {
>      pci_bus_uninit(bus);
>      /* the caller of the unplug hotplug handler will delete this device */
> -    object_property_set_bool(OBJECT(bus), false, "realized", &error_abort);
> +    qbus_unrealize(BUS(bus));
>  }
>  
>  void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


