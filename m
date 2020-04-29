Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601D0C83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29FB220787
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IuyDMJyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FB220787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThkO-00038x-9Z
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 04:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jThGX-0007gr-G4
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:37:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jThFl-0008JH-H8
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:36:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28183
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jThFl-0008Iw-1L
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588145732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bn031hu9FuB+hQDcncldDV7O7zumKkeKonc8xXgOjJg=;
 b=IuyDMJypIQ3ovKtWXhuaqRKJg2/es0PXoVufuGn5dudfDxyCEC91fDC1YwKFtHrwTbRYfq
 JQveJYaqxXbQ4mkrmA/MY6lughy4glIDv/BFYVCQXX4Gk06pYDQQEUqBXWYtflsBy+IIyx
 EFIc3+1Ebv/5YTU8ym6YIpL4iqMf75s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-ukRg9_LRO1KHbY917G3DGA-1; Wed, 29 Apr 2020 03:35:30 -0400
X-MC-Unique: ukRg9_LRO1KHbY917G3DGA-1
Received: by mail-wm1-f69.google.com with SMTP id 71so660419wmb.8
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 00:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qrOy8jSEtT2CwsIuD9tAV5omsz0ophXWymW3wRqWZ6c=;
 b=qd9tNvn1pedVWL/k9xD/OnULVvVDPKpZFveTkdSp3YDfaG51T/qaV+PH3oh+z1EQ3a
 Cpv/NJX003drxRhM+Os97h9vz0TxC/+/slgGBQT8w1L1wYinmkZAD12eVSauQ05F7IBm
 UP2in6brNpNvsLZmbYpJ98oHSB/KriMvAhqzlFaNuyYXT3ZOR6WByBRAUgfXnYuJ0wto
 ihOAx3eQ3Swe4G3kJYE62Bn9IgovDtP8DVZM1fa+W9uhiJ0EAeaJXgSQmESpIlw8hKel
 CX8UB6S9bml69pfkkTHTjZnJwweraX5FUd2e/0ftw7GFHw2RC1NwPDl4qoHfPka5WJIa
 05pA==
X-Gm-Message-State: AGi0PuaLSETACd/ojcndWy/O87QnTpHNPH7u9wD7C6ewd8RvBqRg3P1o
 Vc3zxsP113HE0GLnSQ3CAyulIcASc5Xxl2zwjyCTo2e0agYmUxIZQi2gzcAagNybXuibMzTZf1i
 PK6I+lBEp3Ft6E/M=
X-Received: by 2002:adf:f881:: with SMTP id u1mr36777527wrp.348.1588145729233; 
 Wed, 29 Apr 2020 00:35:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypIX/8ORmATcXFniftZNkoqwfWbCSu7FhKLKm3BRyGMcX5KuYLTpXB4bFdlkxaUlDyl56pge4g==
X-Received: by 2002:adf:f881:: with SMTP id u1mr36777499wrp.348.1588145728943; 
 Wed, 29 Apr 2020 00:35:28 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id g25sm6383889wmh.24.2020.04.29.00.35.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2020 00:35:28 -0700 (PDT)
Subject: Re: [PATCH 16/17] spapr_pci: Drop some dead error handling
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200428163419.4483-1-armbru@redhat.com>
 <20200428163419.4483-17-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <12c0d93f-672a-41e7-4374-6b2d8a35bf53@redhat.com>
Date: Wed, 29 Apr 2020 09:35:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200428163419.4483-17-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: pbonzini@redhat.com, David Gibson <david@gibson.dropbear.id.au>,
 qemu-ppc@nongnu.org, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 6:34 PM, Markus Armbruster wrote:
> chassis_from_bus() uses object_property_get_uint() to get property
> "chassis_nr" of the bridge device.  Failure would be a programming
> error.  Pass &error_abort, and simplify its callers.
>=20
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/ppc/spapr_pci.c | 86 ++++++++++------------------------------------
>   1 file changed, 18 insertions(+), 68 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 1d73d05a0a..b6036be51c 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1203,46 +1203,36 @@ static SpaprDrc *drc_from_devfn(SpaprPhbState *ph=
b,
>                              drc_id_from_devfn(phb, chassis, devfn));
>   }
>  =20
> -static uint8_t chassis_from_bus(PCIBus *bus, Error **errp)
> +static uint8_t chassis_from_bus(PCIBus *bus)
>   {
>       if (pci_bus_is_root(bus)) {
>           return 0;
>       } else {
>           PCIDevice *bridge =3D pci_bridge_get_device(bus);
>  =20
> -        return object_property_get_uint(OBJECT(bridge), "chassis_nr", er=
rp);
> +        return object_property_get_uint(OBJECT(bridge), "chassis_nr",
> +                                        &error_abort);
>       }
>   }
>  =20
>   static SpaprDrc *drc_from_dev(SpaprPhbState *phb, PCIDevice *dev)
>   {
> -    Error *local_err =3D NULL;
> -    uint8_t chassis =3D chassis_from_bus(pci_get_bus(dev), &local_err);
> -
> -    if (local_err) {
> -        error_report_err(local_err);
> -        return NULL;
> -    }
> +    uint8_t chassis =3D chassis_from_bus(pci_get_bus(dev));
>  =20
>       return drc_from_devfn(phb, chassis, dev->devfn);
>   }
>  =20
> -static void add_drcs(SpaprPhbState *phb, PCIBus *bus, Error **errp)
> +static void add_drcs(SpaprPhbState *phb, PCIBus *bus)
>   {
>       Object *owner;
>       int i;
>       uint8_t chassis;
> -    Error *local_err =3D NULL;
>  =20
>       if (!phb->dr_enabled) {
>           return;
>       }
>  =20
> -    chassis =3D chassis_from_bus(bus, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> +    chassis =3D chassis_from_bus(bus);
>  =20
>       if (pci_bus_is_root(bus)) {
>           owner =3D OBJECT(phb);
> @@ -1256,21 +1246,16 @@ static void add_drcs(SpaprPhbState *phb, PCIBus *=
bus, Error **errp)
>       }
>   }
>  =20
> -static void remove_drcs(SpaprPhbState *phb, PCIBus *bus, Error **errp)
> +static void remove_drcs(SpaprPhbState *phb, PCIBus *bus)
>   {
>       int i;
>       uint8_t chassis;
> -    Error *local_err =3D NULL;
>  =20
>       if (!phb->dr_enabled) {
>           return;
>       }
>  =20
> -    chassis =3D chassis_from_bus(bus, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> +    chassis =3D chassis_from_bus(bus);
>  =20
>       for (i =3D PCI_SLOT_MAX * PCI_FUNC_MAX - 1; i >=3D 0; i--) {
>           SpaprDrc *drc =3D drc_from_devfn(phb, chassis, i);
> @@ -1488,17 +1473,11 @@ int spapr_pci_dt_populate(SpaprDrc *drc, SpaprMac=
hineState *spapr,
>   }
>  =20
>   static void spapr_pci_bridge_plug(SpaprPhbState *phb,
> -                                  PCIBridge *bridge,
> -                                  Error **errp)
> +                                  PCIBridge *bridge)
>   {
> -    Error *local_err =3D NULL;
>       PCIBus *bus =3D pci_bridge_get_sec_bus(bridge);
>  =20
> -    add_drcs(phb, bus, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> +    add_drcs(phb, bus);
>   }
>  =20
>   static void spapr_pci_plug(HotplugHandler *plug_handler,
> @@ -1529,11 +1508,7 @@ static void spapr_pci_plug(HotplugHandler *plug_ha=
ndler,
>       g_assert(drc);
>  =20
>       if (pc->is_bridge) {
> -        spapr_pci_bridge_plug(phb, PCI_BRIDGE(plugged_dev), &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> +        spapr_pci_bridge_plug(phb, PCI_BRIDGE(plugged_dev));
>       }
>  =20
>       /* Following the QEMU convention used for PCIe multifunction
> @@ -1560,12 +1535,7 @@ static void spapr_pci_plug(HotplugHandler *plug_ha=
ndler,
>           spapr_drc_reset(drc);
>       } else if (PCI_FUNC(pdev->devfn) =3D=3D 0) {
>           int i;
> -        uint8_t chassis =3D chassis_from_bus(pci_get_bus(pdev), &local_e=
rr);
> -
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> +        uint8_t chassis =3D chassis_from_bus(pci_get_bus(pdev));
>  =20
>           for (i =3D 0; i < 8; i++) {
>               SpaprDrc *func_drc;
> @@ -1587,17 +1557,11 @@ out:
>   }
>  =20
>   static void spapr_pci_bridge_unplug(SpaprPhbState *phb,
> -                                    PCIBridge *bridge,
> -                                    Error **errp)
> +                                    PCIBridge *bridge)
>   {
> -    Error *local_err =3D NULL;
>       PCIBus *bus =3D pci_bridge_get_sec_bus(bridge);
>  =20
> -    remove_drcs(phb, bus, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> +    remove_drcs(phb, bus);
>   }
>  =20
>   static void spapr_pci_unplug(HotplugHandler *plug_handler,
> @@ -1619,11 +1583,7 @@ static void spapr_pci_unplug(HotplugHandler *plug_=
handler,
>       pci_device_reset(PCI_DEVICE(plugged_dev));
>  =20
>       if (pc->is_bridge) {
> -        Error *local_err =3D NULL;
> -        spapr_pci_bridge_unplug(phb, PCI_BRIDGE(plugged_dev), &local_err=
);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -        }
> +        spapr_pci_bridge_unplug(phb, PCI_BRIDGE(plugged_dev));
>           return;
>       }
>  =20
> @@ -1654,13 +1614,7 @@ static void spapr_pci_unplug_request(HotplugHandle=
r *plug_handler,
>           SpaprDrcClass *func_drck;
>           SpaprDREntitySense state;
>           int i;
> -        Error *local_err =3D NULL;
> -        uint8_t chassis =3D chassis_from_bus(pci_get_bus(pdev), &local_e=
rr);
> -
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> +        uint8_t chassis =3D chassis_from_bus(pci_get_bus(pdev));
>  =20
>           if (pc->is_bridge) {
>               error_setg(errp, "PCI: Hot unplug of PCI bridges not suppor=
ted");
> @@ -1741,7 +1695,7 @@ static void spapr_phb_unrealize(DeviceState *dev)
>           }
>       }
>  =20
> -    remove_drcs(sphb, phb->bus, &error_abort);
> +    remove_drcs(sphb, phb->bus);
>  =20
>       for (i =3D PCI_NUM_PINS - 1; i >=3D 0; i--) {
>           if (sphb->lsi_table[i].irq) {
> @@ -1980,11 +1934,7 @@ static void spapr_phb_realize(DeviceState *dev, Er=
ror **errp)
>       }
>  =20
>       /* allocate connectors for child PCI devices */
> -    add_drcs(sphb, phb->bus, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        goto unrealize;
> -    }
> +    add_drcs(sphb, phb->bus);
>  =20
>       /* DMA setup */
>       for (i =3D 0; i < windows_supported; ++i) {
>=20

Very nice cleanup.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


