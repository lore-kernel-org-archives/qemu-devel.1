Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93AAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 937662065C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQzCS/W5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937662065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiZOH-0001iB-Si
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 04:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiZNP-0001GR-8V
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 04:12:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44591
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiZNM-00065O-P6
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 04:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591690371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kOhEG5HAulCqdHwuCHS8Yt+BPQrm022JFfRSBRVE7+M=;
 b=BQzCS/W57mBovqd1kVV/6Ks3tOKRxX1BrDzKc/G8BUyNAtiql16PyC9ZLMX1IfxDt5brSA
 EN6mEwgURuiVbVyAXj4lEQpJoBmZKcvLyfnuEZYugfvN575oTAnxb9N8oUK59ZODP5cNtM
 uRG01WB5m1fQXkvTKKS7LRdqmdzXpRM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-ipfszCI0OuevAexUPdPXDA-1; Tue, 09 Jun 2020 04:12:46 -0400
X-MC-Unique: ipfszCI0OuevAexUPdPXDA-1
Received: by mail-wm1-f69.google.com with SMTP id a7so405523wmf.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 01:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kOhEG5HAulCqdHwuCHS8Yt+BPQrm022JFfRSBRVE7+M=;
 b=tM17pa2ONyPWhdXHEzp7X0Key85//obHvth4OHgJg+kvuuI/rDXfXNhX0/UwDXJYxm
 jaEvGhB5CtiHrlEEj69YfNSpF+sDRAuuKq7PK6XXXFBpL22Us9R7VLvl69jm2dbImwW1
 Mi/QFpLZVhGdpWjLAlj194oK6ap297Gt0BBOFq+ZEou+t64fG8X0ls9YpYf2H04irR5r
 sJwG4KKkOODUUb+m2CRvjNAL/veHyHH3xMOnwPrCK5tt/+PqesiAbdstpwiq1ZS5KLxh
 iPiYFT7JAXZphwbR/t22DY/zAoN/Be5PgeJRhTfH+jyk5PWsQR3C89fv1AndnbYKklkk
 IkpQ==
X-Gm-Message-State: AOAM530OFK9/tOmzV8I1nY913qdlhNg61ymS/Nmdh3tvMPDdVt63LNJN
 vlP08dUuMa5TydbXea+iVZsjPtg4rp9OZuN3aHQYqfXPlpV/+lSNNmwYIc+NySz0vYt73CHSjLT
 O5eX/YH5cEHZ4Jzo=
X-Received: by 2002:adf:aa94:: with SMTP id h20mr2855790wrc.327.1591690364960; 
 Tue, 09 Jun 2020 01:12:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdJisOgmnLU6c1gFteYShiTTHThOvDCrJpWDpsEVCwqYTMfpGID1Q3SAbR52h05rQzXAylFg==
X-Received: by 2002:adf:aa94:: with SMTP id h20mr2855774wrc.327.1591690364737; 
 Tue, 09 Jun 2020 01:12:44 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id u12sm2463329wrq.90.2020.06.09.01.12.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 01:12:44 -0700 (PDT)
Subject: Re: [PATCH v2 12/58] qdev: Convert uses of qdev_set_parent_bus()
 manually
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200529134523.8477-1-armbru@redhat.com>
 <20200529134523.8477-13-armbru@redhat.com>
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
Message-ID: <2f9d71a7-1e18-a92c-8351-d59a8a9a4298@redhat.com>
Date: Tue, 9 Jun 2020 10:12:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200529134523.8477-13-armbru@redhat.com>
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
> Same transformation as in the previous commit.  Manual, because
> convincing Coccinelle to transform these cases is somewhere between
> not worthwhile and infeasible (at least for me).
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/pci-host/prep.c |  3 +--
>  hw/ppc/pnv.c       |  6 ++----
>  hw/s390x/sclp.c    | 10 ++++------
>  3 files changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
> index c821ef889d..42c7e63a60 100644
> --- a/hw/pci-host/prep.c
> +++ b/hw/pci-host/prep.c
> @@ -268,7 +268,7 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>      memory_region_add_subregion(address_space_mem, 0xbffffff0, &s->pci_intack);
>  
>      /* TODO Remove once realize propagates to child devices. */
> -    object_property_set_bool(OBJECT(&s->pci_dev), true, "realized", errp);
> +    qdev_realize(DEVICE(&s->pci_dev), BUS(&s->pci_bus), errp);
>  }
>  
>  static void raven_pcihost_initfn(Object *obj)
> @@ -308,7 +308,6 @@ static void raven_pcihost_initfn(Object *obj)
>  
>      object_initialize(&s->pci_dev, sizeof(s->pci_dev), TYPE_RAVEN_PCI_DEVICE);
>      pci_dev = DEVICE(&s->pci_dev);
> -    qdev_set_parent_bus(pci_dev, BUS(&s->pci_bus));
>      object_property_set_int(OBJECT(&s->pci_dev), PCI_DEVFN(0, 0), "addr",
>                              NULL);
>      qdev_prop_set_bit(pci_dev, "multifunction", false);
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 8562af3fe0..e0588285a2 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1212,12 +1212,11 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
>          object_property_set_int(OBJECT(phb), i, "index", &error_fatal);
>          object_property_set_int(OBJECT(phb), chip->chip_id, "chip-id",
>                                  &error_fatal);
> -        object_property_set_bool(OBJECT(phb), true, "realized", &local_err);
> +        qdev_realize(DEVICE(phb), NULL, &local_err);
>          if (local_err) {
>              error_propagate(errp, local_err);
>              return;
>          }
> -        qdev_set_parent_bus(DEVICE(phb), sysbus_get_default());
>  
>          /* Populate the XSCOM address space. */
>          pnv_xscom_add_subregion(chip,
> @@ -1422,12 +1421,11 @@ static void pnv_chip_power9_phb_realize(PnvChip *chip, Error **errp)
>              object_property_set_int(obj, PNV_PHB4_DEVICE_ID, "device-id",
>                                      &error_fatal);
>              object_property_set_link(obj, OBJECT(stack), "stack", &error_abort);
> -            object_property_set_bool(obj, true, "realized", &local_err);
> +            qdev_realize(DEVICE(obj), NULL, &local_err);
>              if (local_err) {
>                  error_propagate(errp, local_err);
>                  return;
>              }
> -            qdev_set_parent_bus(DEVICE(obj), sysbus_get_default());
>  
>              /* Populate the XSCOM address space. */
>              pnv_xscom_add_subregion(chip,
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 20aca30ac4..40e27a8cb4 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -333,17 +333,15 @@ static void sclp_realize(DeviceState *dev, Error **errp)
>      uint64_t hw_limit;
>      int ret;
>  
> -    object_property_set_bool(OBJECT(sclp->event_facility), true, "realized",
> -                             &err);
> -    if (err) {
> -        goto out;
> -    }
>      /*
>       * qdev_device_add searches the sysbus for TYPE_SCLP_EVENTS_BUS. As long
>       * as we can't find a fitting bus via the qom tree, we have to add the
>       * event facility to the sysbus, so e.g. a sclp console can be created.
>       */
> -    qdev_set_parent_bus(DEVICE(sclp->event_facility), sysbus_get_default());
> +    qdev_realize(DEVICE(sclp->event_facility), NULL, &err);

I agree with the API change, but I find using sysbus_get_default() way
clearer than using NULL. I'v go the other way around, replace bus=NULL
by an explicit bus=sysbus_get_default() in our codebase.

Can be done later, I know... But we can also keep sysbus_get_default()
in this patch ;)

Whichever you prefer (mine is keeping it):
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +    if (err) {
> +        goto out;
> +    }
>  
>      ret = s390_set_memory_limit(machine->maxram_size, &hw_limit);
>      if (ret == -E2BIG) {
> 


