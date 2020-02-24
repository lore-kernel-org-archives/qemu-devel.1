Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA28C38BF9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 658602176D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XC6bN25h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 658602176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6MIh-0007Ps-Jq
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 17:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1j6MD4-00065P-6R
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:28:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1j6MD3-0008Cn-0j
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:28:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56463
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1j6MD1-0008BX-PA
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582583294;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sfPB5TpnY3oGZn07xohGC7FCr3H98PkvPpnhvVa9Elg=;
 b=XC6bN25hivUtZPTnuMC0XK9SbTBkviEst3HbjsOMM97U6JL9KZWx6EDgU06/RHydUzMF0h
 Bs3Q+EII1poU9piQvWPnJZC/HCIrL2bM/O+k/z8dPULgd5p/ZI+i4aZjyKYFzQt1xulzVI
 A7niGDnnNRg12xMDqGS1RNhCaE/iKgs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-DVLYaDESO1myMv1glPgHwA-1; Mon, 24 Feb 2020 17:28:10 -0500
X-MC-Unique: DVLYaDESO1myMv1glPgHwA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 065841084420;
 Mon, 24 Feb 2020 22:28:09 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-79.bne.redhat.com [10.64.54.79])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 534911001902;
 Mon, 24 Feb 2020 22:28:06 +0000 (UTC)
Subject: Re: [PATCH] hw/arm: Use TYPE_PL011 to create serial port
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20200224041633.97345-1-gshan@redhat.com>
 <ea5d13ba-e736-2c73-f2c0-6e42e512afa2@redhat.com>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <1ac61bd1-024c-f596-73c7-6d9488c9fd50@redhat.com>
Date: Tue, 25 Feb 2020 09:28:04 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <ea5d13ba-e736-2c73-f2c0-6e42e512afa2@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: Gavin Shan <gshan@redhat.com>
Cc: peter.maydell@linaro.org, radoslaw.biernacki@linaro.org,
 alistair@alistair23.me, shan.gavin@gmail.com, edgar.iglesias@gmail.com,
 leif@nuviainc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/24/20 7:41 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/24/20 5:16 AM, Gavin Shan wrote:
>> This uses TYPE_PL011 when creating the serial port, to make the code
>> a bit more atomatic.
>=20
> Do you mean aUtomatic? I'm not sure this automate the code, but using the=
 TYPE definition is definitively cleaner.
>=20
> With description fixed:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20

Sure, v2 was just posted with the commit log improved according to
your comments.

Thanks,
Gavin

>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>> =C2=A0 hw/arm/sbsa-ref.c=C2=A0=C2=A0=C2=A0 | 3 ++-
>> =C2=A0 hw/arm/virt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 3 ++-
>> =C2=A0 hw/arm/xlnx-versal.c | 3 ++-
>> =C2=A0 3 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
>> index 9b5bcb5634..df0a165047 100644
>> --- a/hw/arm/sbsa-ref.c
>> +++ b/hw/arm/sbsa-ref.c
>> @@ -39,6 +39,7 @@
>> =C2=A0 #include "hw/pci-host/gpex.h"
>> =C2=A0 #include "hw/qdev-properties.h"
>> =C2=A0 #include "hw/usb.h"
>> +#include "hw/char/pl011.h"
>> =C2=A0 #include "net/net.h"
>> =C2=A0 #define RAMLIMIT_GB 8192
>> @@ -409,7 +410,7 @@ static void create_uart(const SBSAMachineState *sms,=
 int uart,
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwaddr base =3D sbsa_ref_memmap[uart].bas=
e;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int irq =3D sbsa_ref_irqmap[uart];
>> -=C2=A0=C2=A0=C2=A0 DeviceState *dev =3D qdev_create(NULL, "pl011");
>> +=C2=A0=C2=A0=C2=A0 DeviceState *dev =3D qdev_create(NULL, TYPE_PL011);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_prop_set_chr(dev, "chardev", chr);
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index f788fe27d6..d0da513737 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -71,6 +71,7 @@
>> =C2=A0 #include "hw/mem/pc-dimm.h"
>> =C2=A0 #include "hw/mem/nvdimm.h"
>> =C2=A0 #include "hw/acpi/generic_event_device.h"
>> +#include "hw/char/pl011.h"
>> =C2=A0 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 static void virt_##major##_##minor##_clas=
s_init(ObjectClass *oc, \
>> @@ -724,7 +725,7 @@ static void create_uart(const VirtMachineState *vms,=
 int uart,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int irq =3D vms->irqmap[uart];
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char compat[] =3D "arm,pl011\0arm,p=
rimecell";
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char clocknames[] =3D "uartclk\0apb=
_pclk";
>> -=C2=A0=C2=A0=C2=A0 DeviceState *dev =3D qdev_create(NULL, "pl011");
>> +=C2=A0=C2=A0=C2=A0 DeviceState *dev =3D qdev_create(NULL, TYPE_PL011);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_prop_set_chr(dev, "chardev", chr);
>> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
>> index 1cf3daaf4f..403fc7b881 100644
>> --- a/hw/arm/xlnx-versal.c
>> +++ b/hw/arm/xlnx-versal.c
>> @@ -22,6 +22,7 @@
>> =C2=A0 #include "hw/misc/unimp.h"
>> =C2=A0 #include "hw/intc/arm_gicv3_common.h"
>> =C2=A0 #include "hw/arm/xlnx-versal.h"
>> +#include "hw/char/pl011.h"
>> =C2=A0 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>> =C2=A0 #define GEM_REVISION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x=
40070106
>> @@ -144,7 +145,7 @@ static void versal_create_uarts(Versal *s, qemu_irq =
*pic)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceState *dev;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MemoryRegion *mr;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D qdev_create(NULL, "p=
l011");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D qdev_create(NULL, TY=
PE_PL011);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->lpd.iou.uart[i=
] =3D SYS_BUS_DEVICE(dev);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_prop_set_chr=
(dev, "chardev", serial_hd(i));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_a=
dd_child(OBJECT(s), name, OBJECT(dev), &error_fatal);
>>
>=20


