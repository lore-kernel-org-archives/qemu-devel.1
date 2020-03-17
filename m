Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935BBC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D2C920658
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKDUJaAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2C920658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9pR-0001hi-GK
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jE9nJ-0007Gd-Pn
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:49:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jE9nI-0007TL-F8
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:49:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:44050)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jE9nI-0007Rh-AU
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584442196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7N/RCnPpThro4ivC+YB5Aq4swc9VwC2D8U6V0un99f8=;
 b=iKDUJaAn3EkXlNNJMVZod8SBGYurCpv0nrTZbMP5C4eQh0clNrJnOBLbJgVLJrq60dSRSG
 2Lhn1RJWQ5lEqSk16hCspEJzJIqk1mY2EbtcP0DWK1O9VmDDXHe54cmWRIhBdxrx1Z2Rm5
 6hviED0RK63Me/AMHHrzR/YDAdCNPpc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-pbJOWZbxPreWtxs4c9HwYw-1; Tue, 17 Mar 2020 06:49:54 -0400
X-MC-Unique: pbJOWZbxPreWtxs4c9HwYw-1
Received: by mail-wr1-f69.google.com with SMTP id h17so819333wru.16
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 03:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pgCnV1ClBHNum8linnqGwHhkwzy1FtASqGHz1mJkAxc=;
 b=EufMsJU+AYZZyOOlZ7QdWLP5Z8MLmnGdz/4RpX2witBxagcgfVs3hxabQbfTf/PLcm
 zqidnCPkeNmCnbMl6J2JlIBHakb41pp+62OJqQQAr6WU6JTyf5Fx0+bZ5eE8y8J/52cl
 1Q25YUOrrXJVRBKNJ5I9KPH2y/fKj6XY5iWVY2x+VuyAWkGgXdSVUn+IgagKR1BgNXZJ
 aGWYfZAXOqzszBA5yXXJe9D8lfvSrURQ1RaY+pAZQW7oVOlTGdwe6vnmZEBPoMcAL53p
 IqN9zqba4avn3et+gfcPtWDNMJqeDLKTlGfHxTYbCoghPIBmywuQ0WoCF7zIeLnaWspe
 qsiw==
X-Gm-Message-State: ANhLgQ31e8GCnTr9c5FOMm29QOzpWmWMGFUbMdLbjn2USWuQF90l/QPg
 DTmYdU5N90irLd2VBmgRIuI1TBMbeIT0cJZoCGbzX4/ET2LU0DrO0QjpNpbv1JTqY0lrE3PsxlS
 XNuqHCcNSbLO886k=
X-Received: by 2002:a5d:6aca:: with SMTP id u10mr5074211wrw.99.1584442193352; 
 Tue, 17 Mar 2020 03:49:53 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtHZSPMkXTL1QjR/V4DMmESYK/IZk+QADYHe+7JRk0upu6PwAtoio/xtH++yoR2JA5BQZyUiQ==
X-Received: by 2002:a5d:6aca:: with SMTP id u10mr5074182wrw.99.1584442193101; 
 Tue, 17 Mar 2020 03:49:53 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id i67sm3982423wri.50.2020.03.17.03.49.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 03:49:52 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] hw/ide: Get rid of piix4_init function
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <cover.1584437957.git.balaton@eik.bme.hu>
 <3240656814c804513de08bdbbf318f2f590df241.1584437958.git.balaton@eik.bme.hu>
 <c43e2f9b-3002-32f0-08fa-7164a98f3b9f@redhat.com>
Message-ID: <f70ea487-c8e8-d76d-fbe5-9213284a8574@redhat.com>
Date: Tue, 17 Mar 2020 11:49:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <c43e2f9b-3002-32f0-08fa-7164a98f3b9f@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, hpoussin@reactos.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 11:41 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 3/17/20 10:39 AM, BALATON Zoltan wrote:
>> This removes pci_piix4_ide_init() function similar to clean up done to
>> other ide devices.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Please disregard this tag (I withdraw it), I mis-read the pci variable=20
was not assigned.

>=20
>> ---
>> =C2=A0 hw/ide/piix.c=C2=A0=C2=A0=C2=A0 | 12 +-----------
>> =C2=A0 hw/isa/piix4.c=C2=A0=C2=A0 |=C2=A0 5 ++++-
>> =C2=A0 include/hw/ide.h |=C2=A0 1 -
>> =C2=A0 3 files changed, 5 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/ide/piix.c b/hw/ide/piix.c
>> index 8bcd6b72c2..3b2de4c312 100644
>> --- a/hw/ide/piix.c
>> +++ b/hw/ide/piix.c
>> @@ -208,17 +208,6 @@ static void pci_piix_ide_exitfn(PCIDevice *dev)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>> -/* hd_table must contain 4 block drivers */
>> -/* NOTE: for the PIIX4, the IRQs and IOports are hardcoded */
>> -PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int=20
>> devfn)
>> -{
>> -=C2=A0=C2=A0=C2=A0 PCIDevice *dev;
>> -
>> -=C2=A0=C2=A0=C2=A0 dev =3D pci_create_simple(bus, devfn, "piix4-ide");
>> -=C2=A0=C2=A0=C2=A0 pci_ide_create_devs(dev, hd_table);
>> -=C2=A0=C2=A0=C2=A0 return dev;
>> -}
>> -
>> =C2=A0 /* NOTE: for the PIIX3, the IRQs and IOports are hardcoded */
>> =C2=A0 static void piix3_ide_class_init(ObjectClass *klass, void *data)
>> =C2=A0 {
>> @@ -247,6 +236,7 @@ static const TypeInfo piix3_ide_xen_info =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .class_init=C2=A0=C2=A0=C2=A0 =3D piix3_i=
de_class_init,
>> =C2=A0 };
>> +/* NOTE: for the PIIX4, the IRQs and IOports are hardcoded */
>> =C2=A0 static void piix4_ide_class_init(ObjectClass *klass, void *data)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);
>> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
>> index 7edec5e149..0ab4787658 100644
>> --- a/hw/isa/piix4.c
>> +++ b/hw/isa/piix4.c
>> @@ -35,6 +35,7 @@
>> =C2=A0 #include "hw/timer/i8254.h"
>> =C2=A0 #include "hw/rtc/mc146818rtc.h"
>> =C2=A0 #include "hw/ide.h"
>> +#include "hw/ide/pci.h"
>> =C2=A0 #include "migration/vmstate.h"
>> =C2=A0 #include "sysemu/reset.h"
>> =C2=A0 #include "sysemu/runstate.h"
>> @@ -255,10 +256,12 @@ DeviceState *piix4_create(PCIBus *pci_bus,=20
>> ISABus **isa_bus,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *isa_bus =3D ISA_=
BUS(qdev_get_child_bus(dev, "isa.0"));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 pci =3D pci_create_simple(pci_bus, pci->devfn + 1, "=
piix4-ide");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hd =3D g_new(DriveInfo *, ide_drives);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ide_drive_get(hd, ide_drives);
>> -=C2=A0=C2=A0=C2=A0 pci_piix4_ide_init(pci_bus, hd, pci->devfn + 1);
>> +=C2=A0=C2=A0=C2=A0 pci_ide_create_devs(pci, hd);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(hd);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_create_simple(pci_bus, pci->devfn + 2=
, "piix4-usb-uhci");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (smbus) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *smbus =3D piix4_=
pm_init(pci_bus, pci->devfn + 3, 0x1100,
>> diff --git a/include/hw/ide.h b/include/hw/ide.h
>> index 883bbaeb9b..21bd8f23f1 100644
>> --- a/include/hw/ide.h
>> +++ b/include/hw/ide.h
>> @@ -12,7 +12,6 @@ ISADevice *isa_ide_init(ISABus *bus, int iobase, int=
=20
>> iobase2, int isairq,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 DriveInfo *hd0, DriveInfo *hd1);
>> =C2=A0 /* ide-pci.c */
>> -PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int=20
>> devfn);
>> =C2=A0 int pci_piix3_xen_ide_unplug(DeviceState *dev, bool aux);
>> =C2=A0 /* ide-mmio.c */
>>


