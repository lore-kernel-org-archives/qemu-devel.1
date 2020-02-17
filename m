Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31271C34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AECDE2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CV18VzPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AECDE2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3l6v-00055i-Ji
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 13:27:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j3l69-0003zn-Jw
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:26:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j3l68-0007Hn-7V
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:26:25 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53845
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j3l68-0007HV-3X
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:26:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581963983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RV6vxWpz8ujl5U8eswa/rusP/ZqilPhNxfNq2d+kKXU=;
 b=CV18VzPSbX49I7uBzPXYYAdvJL+L4PlrCdhJxjhCGQhK8XyeCI181R4Aq/FmMjPoS6XM5B
 6qKFJU4WJNxanK7HhWRTeaISa5MLAvDQnXrjxZ3FgCY+9Clo8yKs21ulId09cBRT82QeeR
 PwIvROqCH/AV9ZKCPolBOcyofcG7s6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-enDaQWXkP9a97-MBMTKaew-1; Mon, 17 Feb 2020 13:26:22 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC705800D50;
 Mon, 17 Feb 2020 18:26:20 +0000 (UTC)
Received: from [10.36.116.239] (ovpn-116-239.ams2.redhat.com [10.36.116.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CFF8D5C553;
 Mon, 17 Feb 2020 18:26:13 +0000 (UTC)
Subject: Re: [RFC v2 6/6] hw/arm/virt: vTPM support
To: Stefan Berger <stefanb@linux.ibm.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20200214183704.14389-1-eric.auger@redhat.com>
 <20200214183704.14389-7-eric.auger@redhat.com>
 <17dfaa9b-dd1a-9654-c59c-391a70d0327e@linux.ibm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <b640344f-ec88-ed79-3623-dcfc20d94541@redhat.com>
Date: Mon, 17 Feb 2020 19:26:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <17dfaa9b-dd1a-9654-c59c-391a70d0327e@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: enDaQWXkP9a97-MBMTKaew-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: marcandre.lureau@redhat.com, lersek@redhat.com, ardb@kernel.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

On 2/16/20 7:47 PM, Stefan Berger wrote:
> On 2/14/20 1:37 PM, Eric Auger wrote:
>> Let the TPM TIS SYSBUS device be dynamically instantiable
>> in ARM virt.=C2=A0 A device tree node is dynamically created
>> (TPM via MMIO).
>>
>> The TPM Physical Presence interface (PPI) is not supported.
>>
>> To run with the swtmp TPM emulator, the qemu command line must
>> be augmented with:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -chardev socket,id=3Dch=
rtpm,path=3Dswtpm-sock \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -tpmdev emulator,id=3Dt=
pm0,chardev=3Dchrtpm \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -device tpm-tis-device,=
tpmdev=3Dtpm0 \
>>
>> swtpm/libtpms command line example:
>>
>> swtpm socket --tpm2 -t -d --tpmstate dir=3D/tmp/tpm \
>> --ctrl type=3Dunixio,path=3Dswtpm-sock
>=20
>=20
> Can you also extend docs/spec/tpm.rst for the arm case?
Sure

 And the test
> cases should probably also cover the arm sysbus device.
Yes I agree. At the moment I have made sure existing x86-64 qtests were
running as before.

I will investigate what I can do to cover the sysbus device.

>=20
>=20
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>> =C2=A0 hw/arm/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0 hw/arm/sysbus-fdt.c | 36 ++++++++++++++++++++++++++++++++++++
>> =C2=A0 hw/arm/virt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +++++=
++
>> =C2=A0 3 files changed, 44 insertions(+)
>>
>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> index 3d86691ae0..b6f03f7f53 100644
>> --- a/hw/arm/Kconfig
>> +++ b/hw/arm/Kconfig
>> @@ -5,6 +5,7 @@ config ARM_VIRT
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imply VFIO_AMD_XGBE
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imply VFIO_PLATFORM
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imply VFIO_XGMAC
>> +=C2=A0=C2=A0=C2=A0 imply TPM_TIS_SYSBUS
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select A15MPCORE
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select ACPI
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select ARM_SMMUV3
>> diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
>> index 022fc97ecd..adf50444c2 100644
>> --- a/hw/arm/sysbus-fdt.c
>> +++ b/hw/arm/sysbus-fdt.c
>> @@ -30,6 +30,7 @@
>> =C2=A0 #include "hw/arm/sysbus-fdt.h"
>> =C2=A0 #include "qemu/error-report.h"
>> =C2=A0 #include "sysemu/device_tree.h"
>> +#include "sysemu/tpm.h"
>> =C2=A0 #include "hw/platform-bus.h"
>> =C2=A0 #include "hw/vfio/vfio-platform.h"
>> =C2=A0 #include "hw/vfio/vfio-calxeda-xgmac.h"
>> @@ -434,6 +435,40 @@ static bool vfio_platform_match(SysBusDevice *sbdev=
,
>> =C2=A0 #define VFIO_PLATFORM_BINDING(compat, add_fn) \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {TYPE_VFIO_PLATFORM, (compat), (add_fn), =
vfio_platform_match}
>> =C2=A0 +/*
>> + * add_tpm_tis_fdt_node: Create a DT node for TPM TIS
>> + *
>> + * See kernel documentation:
>> + * Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
>> + * Optional interrupt for command completion is not exposed
>> + */
>> +static int add_tpm_tis_fdt_node(SysBusDevice *sbdev, void *opaque)
>> +{
>> +=C2=A0=C2=A0=C2=A0 PlatformBusFDTData *data =3D opaque;
>> +=C2=A0=C2=A0=C2=A0 PlatformBusDevice *pbus =3D data->pbus;
>> +=C2=A0=C2=A0=C2=A0 void *fdt =3D data->fdt;
>> +=C2=A0=C2=A0=C2=A0 const char *parent_node =3D data->pbus_node_name;
>> +=C2=A0=C2=A0=C2=A0 int compat_str_len;
>> +=C2=A0=C2=A0=C2=A0 char *nodename;
>> +=C2=A0=C2=A0=C2=A0 uint32_t reg_attr[2];
>> +=C2=A0=C2=A0=C2=A0 uint64_t mmio_base;
>> +
>> +=C2=A0=C2=A0=C2=A0 mmio_base =3D platform_bus_get_mmio_addr(pbus, sbdev=
, 0);
>=20
> I suppose any conditional creation of this device tree entry is covered
> with the TYPE_BINDING below, meaning no device tree is created if the
> device wasn't added.
Yes exactly, the dt node is not created if the -device tpm-tis-device is
not passed in the qemu cmd line.
>=20
>=20
>> +=C2=A0=C2=A0=C2=A0 nodename =3D g_strdup_printf("%s/tpm_tis@%" PRIx64, =
parent_node,
>> mmio_base);
>> +=C2=A0=C2=A0=C2=A0 qemu_fdt_add_subnode(fdt, nodename);
>> +
>> +=C2=A0=C2=A0=C2=A0 compat_str_len =3D strlen("tcg,tpm-tis-mmio") + 1;
>> +=C2=A0=C2=A0=C2=A0 qemu_fdt_setprop(fdt, nodename, "compatible", "tcg,t=
pm-tis-mmio",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compat_str_len);
>=20
> You probably can use qemu_fdt_setprop_string()?
indeed!
>=20
>=20
>> +
>> +=C2=A0=C2=A0=C2=A0 reg_attr[0] =3D cpu_to_be32(mmio_base);
>> +=C2=A0=C2=A0=C2=A0 reg_attr[1] =3D cpu_to_be32(0x5000);
>> +=C2=A0=C2=A0=C2=A0 qemu_fdt_setprop(fdt, nodename, "reg", reg_attr, 2 *
>> sizeof(uint32_t));
>> +
>> +=C2=A0=C2=A0=C2=A0 g_free(nodename);
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> =C2=A0 #endif /* CONFIG_LINUX */
>> =C2=A0 =C2=A0 static int no_fdt_node(SysBusDevice *sbdev, void *opaque)
>> @@ -455,6 +490,7 @@ static const BindingEntry bindings[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TYPE_BINDING(TYPE_VFIO_CALXEDA_XGMAC,
>> add_calxeda_midway_xgmac_fdt_node),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TYPE_BINDING(TYPE_VFIO_AMD_XGBE, add_amd_=
xgbe_fdt_node),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VFIO_PLATFORM_BINDING("amd,xgbe-seattle-v=
1a",
>> add_amd_xgbe_fdt_node),
>> +=C2=A0=C2=A0=C2=A0 TYPE_BINDING(TYPE_TPM_TIS_SYSBUS, add_tpm_tis_fdt_no=
de),
>> =C2=A0 #endif
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_no=
de),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TYPE_BINDING("", NULL), /* last element *=
/
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index f788fe27d6..4b967e39d1 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -47,6 +47,7 @@
>> =C2=A0 #include "sysemu/numa.h"
>> =C2=A0 #include "sysemu/runstate.h"
>> =C2=A0 #include "sysemu/sysemu.h"
>> +#include "sysemu/tpm.h"
>> =C2=A0 #include "sysemu/kvm.h"
>> =C2=A0 #include "hw/loader.h"
>> =C2=A0 #include "exec/address-spaces.h"
>> @@ -2041,6 +2042,7 @@ static void virt_machine_class_init(ObjectClass
>> *oc, void *data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 machine_class_allow_dynamic_sysbus_dev(mc=
, TYPE_VFIO_AMD_XGBE);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 machine_class_allow_dynamic_sysbus_dev(mc=
, TYPE_RAMFB_DEVICE);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 machine_class_allow_dynamic_sysbus_dev(mc=
, TYPE_VFIO_PLATFORM);
>> +=C2=A0=C2=A0=C2=A0 machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_=
TIS_SYSBUS);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mc->block_default_type =3D IF_VIRTIO;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mc->no_cdrom =3D 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mc->pci_allow_0_address =3D true;
>> @@ -2153,6 +2155,11 @@ type_init(machvirt_machine_init);
>> =C2=A0 =C2=A0 static void virt_machine_5_0_options(MachineClass *mc)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 static GlobalProperty compat[] =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { TYPE_TPM_TIS_SYSBUS, "ppi"=
, "false" },
>> +=C2=A0=C2=A0=C2=A0 };
>> +
>> +=C2=A0=C2=A0=C2=A0 compat_props_add(mc->compat_props, compat, G_N_ELEME=
NTS(compat));
>> =C2=A0 }
>> =C2=A0 DEFINE_VIRT_MACHINE_AS_LATEST(5, 0)
>> =C2=A0=20
>=20
>=20
Thanks

Eric


