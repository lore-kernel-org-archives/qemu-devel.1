Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A74C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:58:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 391FF2072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M32cbTwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391FF2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDooW-0004C8-Ct
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDonj-0003MY-CM
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:57:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53684)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDonh-0003HJ-Kp
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599137832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=w/8bfxvJrL60azUJvVwI707RU5tzNuWHApAA0ggsuko=;
 b=M32cbTwMD0wXH5fxeBkB9DChFCupf+jv0WP+6vDP9nw7UvX/uGxpGcO6OLnbcoTXR+FDul
 3klt9mGv4TSNWdZ8/xVJspD2VoWYnNTBfBawIF3QGQE/A6Q3Aj4K4InCsu27rPgxJHbGsk
 7ZrECfbBTcQ//13+RmPxAubn6orv6+I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-64sZirosMOmxhhs9ytddTg-1; Thu, 03 Sep 2020 08:57:11 -0400
X-MC-Unique: 64sZirosMOmxhhs9ytddTg-1
Received: by mail-wr1-f70.google.com with SMTP id m7so1035110wrb.20
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=w/8bfxvJrL60azUJvVwI707RU5tzNuWHApAA0ggsuko=;
 b=WH/kS7MKc3CFpJfMyiZ3Lf1gHAbZF6KwTDR7a/ui6WrE7VbaSlA7SkPL/ouk30vrrQ
 UXDua5YZImHMTanFAsjmiuDNJXNR/1Ww8umGsFgQ0NlmSSDA2KvM1wy4J8D5sBBZvhvS
 5Sq00nidQd0ZoAMrXwUFceOJo14GdheOejiVM9gu5ZT9vxMsc3ndqxWPdDN/B4FCu6AK
 vnyJSGsWsP94/xAiLK/U+mSooR/Zc2MO/7PCgnmxBUvkt6hqtUjueL4zZN4wbfcBLWKA
 EijsQ3ktgywz/rGZAWaav6Fr8X2eMWhl1GkrYoLxj4JlvK4EL/S8NMgA2UkgGIpibOtC
 XoRw==
X-Gm-Message-State: AOAM532TOvx1KfBqqxYZmynTl4mCOTua/0P0ppNX8cTHMrzW92eeDwQz
 asIW1kbtVii43/W11sVmb9OKxmqVKeC4dPkbyrlXWqaJ9yNJ/Tc0deIJ8RVB0pQLTrCVPshwac5
 n2FHeM66dwbnheV4=
X-Received: by 2002:a05:6000:12c3:: with SMTP id
 l3mr2504205wrx.164.1599137829967; 
 Thu, 03 Sep 2020 05:57:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAd1KMsKjsErsfrLTYr9wpNytoTcMUyxjq+AzjxkRvzvuj2j3M1mWgq+cupZMCYExtw1zxZQ==
X-Received: by 2002:a05:6000:12c3:: with SMTP id
 l3mr2504193wrx.164.1599137829812; 
 Thu, 03 Sep 2020 05:57:09 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id t16sm4360861wrm.57.2020.09.03.05.57.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 05:57:09 -0700 (PDT)
Subject: Re: [PATCH 32/63] ahci: Rename ICH_AHCI to ICH9_AHCI
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-33-ehabkost@redhat.com>
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
Message-ID: <f8225852-ec2f-3355-c57e-a29719f286ff@redhat.com>
Date: Thu, 3 Sep 2020 14:57:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902224311.1321159-33-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: berrange@redhat.com, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 12:42 AM, Eduardo Habkost wrote:
> Make the type checking macro name consistent with the TYPE_*
> constant.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> Cc: John Snow <jsnow@redhat.com>
> Cc: qemu-block@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  include/hw/ide/ahci.h | 2 +-
>  hw/ide/ahci.c         | 4 ++--
>  hw/ide/ich.c          | 8 ++++----
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
> index 4cf6813d80..da3cddcc65 100644
> --- a/include/hw/ide/ahci.h
> +++ b/include/hw/ide/ahci.h
> @@ -54,7 +54,7 @@ typedef struct AHCIState {
>  typedef struct AHCIPCIState AHCIPCIState;
>  
>  #define TYPE_ICH9_AHCI "ich9-ahci"
> -DECLARE_INSTANCE_CHECKER(AHCIPCIState, ICH_AHCI,
> +DECLARE_INSTANCE_CHECKER(AHCIPCIState, ICH9_AHCI,
>                           TYPE_ICH9_AHCI)
>  
>  int32_t ahci_get_num_ports(PCIDevice *dev);
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index b696c6291a..ee1d47ff75 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -1819,7 +1819,7 @@ type_init(sysbus_ahci_register_types)
>  
>  int32_t ahci_get_num_ports(PCIDevice *dev)
>  {
> -    AHCIPCIState *d = ICH_AHCI(dev);
> +    AHCIPCIState *d = ICH9_AHCI(dev);
>      AHCIState *ahci = &d->ahci;
>  
>      return ahci->ports;
> @@ -1827,7 +1827,7 @@ int32_t ahci_get_num_ports(PCIDevice *dev)
>  
>  void ahci_ide_create_devs(PCIDevice *dev, DriveInfo **hd)
>  {
> -    AHCIPCIState *d = ICH_AHCI(dev);
> +    AHCIPCIState *d = ICH9_AHCI(dev);
>      AHCIState *ahci = &d->ahci;
>      int i;
>  
> diff --git a/hw/ide/ich.c b/hw/ide/ich.c
> index eff3188fff..51cd2f38b7 100644
> --- a/hw/ide/ich.c
> +++ b/hw/ide/ich.c
> @@ -91,14 +91,14 @@ static const VMStateDescription vmstate_ich9_ahci = {
>  
>  static void pci_ich9_reset(DeviceState *dev)
>  {
> -    AHCIPCIState *d = ICH_AHCI(dev);
> +    AHCIPCIState *d = ICH9_AHCI(dev);
>  
>      ahci_reset(&d->ahci);
>  }
>  
>  static void pci_ich9_ahci_init(Object *obj)
>  {
> -    struct AHCIPCIState *d = ICH_AHCI(obj);
> +    struct AHCIPCIState *d = ICH9_AHCI(obj);
>  
>      ahci_init(&d->ahci, DEVICE(obj));
>  }
> @@ -108,7 +108,7 @@ static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
>      struct AHCIPCIState *d;
>      int sata_cap_offset;
>      uint8_t *sata_cap;
> -    d = ICH_AHCI(dev);
> +    d = ICH9_AHCI(dev);
>      int ret;
>  
>      ahci_realize(&d->ahci, DEVICE(dev), pci_get_address_space(dev), 6);
> @@ -154,7 +154,7 @@ static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
>  static void pci_ich9_uninit(PCIDevice *dev)
>  {
>      struct AHCIPCIState *d;
> -    d = ICH_AHCI(dev);
> +    d = ICH9_AHCI(dev);
>  
>      msi_uninit(dev);
>      ahci_uninit(&d->ahci);
> 


