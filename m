Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBC9C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 10:21:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496E4206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 10:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="mpYCx6Pn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496E4206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTNN0-0002GP-Dp
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 06:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jTNLy-0000Xr-01
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 06:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jTNLs-0003Mf-RG
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 06:20:37 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:48182)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jTNLs-0003K7-3P
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 06:20:32 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03SAFhG3027023; Tue, 28 Apr 2020 03:20:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=gNZs/xxIFpVFYpdJZ7mB9TWY7QMYWtsdtEdj9hVOCNE=;
 b=mpYCx6Pn42rDVuBspSkbcq53yhbXNK87/sjRpZWDrWt0hkFkXsC3EyteU7sQYKmsBcOv
 njH2E7kluNeDP9YD4+f0x02TEHr1jmpBpW8E2zaDlX3YumtuuFyTArIHX5RNDHKGtRc9
 Y+1n/n3lWK0tLhXMOu2MT8ZGXlXaf984glT4h72wlmK6tSg4LDBlnnDmHUsaF5fx/+Gx
 sspfH8EtqtNkotRfHgNwsfTIX6ZYU4RjOljnH4oUqj7ZJ0d4LSevscUUCfGLyoF2L+k/
 +l1BQyeI8smBmvn2wDhoDl298gdOn8sv/UHmPiM8RUZjsj8YPUy26+pCIajQoP5iIxoX QA== 
Received: from nam04-co1-obe.outbound.protection.outlook.com
 (mail-co1nam04lp2057.outbound.protection.outlook.com [104.47.45.57])
 by mx0b-002c1b01.pphosted.com with ESMTP id 30mjr9dxqs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2020 03:20:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIHKTqxslpdQgyhLpD9hzlkGqbflWpxlBRHcg7DoNbGppRyHhh5zgPC4pyWoAiLvA6azCe0IWeBAjJrWoLJe+dFbqf0nl3WDuzEpndyrrJL0B2Ng4RWEMCyy5EEvAChH9blHgzQvW6OmhnCxH4p4Z9Y0hWnm8P7aBXebE/A9O3bLvIhUpxNMbGzvEnBZ3HkAh/cHXNP1+Vvl6+iYZbapjkET5k70g9z5nL0HCehwSZfzlcXWLgCX4l+Yb7yT3VOndu1QR/JiG1s2T+2I+Rr+uOQYAGHCLIhEYJOReVZsR+Pq6i6dexPt1IDlBEs4CuUsHRGBa7i8gO0ovpkLQ7SsDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNZs/xxIFpVFYpdJZ7mB9TWY7QMYWtsdtEdj9hVOCNE=;
 b=OHbaHnu2guAdRH/OLMAaDdz9YwUrQqudVDFhlImf/jzV8msFjYhzVaiDX/a/SUXUEDtZiH8/Q8DX9VSY/78FYOcpzCnhO3U9BorqKaNGwzS/rPp/rSWCsITNlbU826Wo1gw+eR3YV+L/sAuG/WtUN1WJSbWPz/Qh/FhLntMh4SJYyXqIbmvOY6RjARfYL8hI3K3pvkVF1IoFdr6q0PKA5A1QXu5tzWMUVn+cbjzl/rmJizeQOYXMgSoI0cAoL+yidpdxhtvczPVQsZ8JCkMXs1ErAgshwQeDqrLMsq+vun/CrLA8omDMM/l30gGuOV0HwH/sx1UXPUEgKI8qrQmmCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB7087.namprd02.prod.outlook.com (2603:10b6:208:205::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Tue, 28 Apr
 2020 10:20:11 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a%7]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 10:20:10 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Topic: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Thread-Index: AQHWHUYvMyDNYIpa20C9378Nh0w8t6iOUn+A
Date: Tue, 28 Apr 2020 10:20:10 +0000
Message-ID: <400E269A-75AE-4445-841C-B004B98727EC@nutanix.com>
References: <1588069012-211196-1-git-send-email-ani.sinha@nutanix.com>
In-Reply-To: <1588069012-211196-1-git-send-email-ani.sinha@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [192.146.154.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c28d4faa-d127-439f-5a24-08d7eb5dbbaf
x-ms-traffictypediagnostic: MN2PR02MB7087:
x-microsoft-antispam-prvs: <MN2PR02MB7087B2C5B7602470E7368B3BF1AC0@MN2PR02MB7087.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0387D64A71
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(366004)(136003)(39860400002)(346002)(396003)(186003)(316002)(66446008)(66476007)(6506007)(478600001)(66556008)(44832011)(76116006)(91956017)(66946007)(6916009)(64756008)(5660300002)(26005)(54906003)(36756003)(6486002)(71200400001)(7416002)(53546011)(8936002)(8676002)(6512007)(81156014)(4326008)(33656002)(86362001)(2906002)(2616005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G0h2YUgld5nalJe1e7qd5pDvPH55WR/Qh7Rwqi1GkWpE4eAYM9iiRhm5uARYyhPbVuvzaapbOm3uiDBFYMnAnG7bi9C+nkZVc4mgKyLBRuiTK99JZO1MeSeSCspwScOwGHNZsVtQIEe5TPwpoXZYH3/Xkug9dnZfrValsmUGkhD5Ef5Jigs7QhZG+dPpNze7yi5CSQjTJCSvVpTUfTtVI4oYJpzSP9gg6BEMKPeo+sMsFRzj6/JKqnfZ5laXlK1E7hk/lzk/6j9lKaU+44ldjA21H4NTP1ptY3ZkR/zNzPX9NVdLLfpm2VsmXCn4PqUcSZOdEhc/Bx5PiHVRH6kf0c9ITvE7+8M0/n1gz6Nhv2yb1WY42Fco3Y/JdttJffJFjJlQlDEINsVmuxCCW912759tbhbS/OITyXtKFsCLg/TpZK1ZcpUrHPMgtAWpGm7O
x-ms-exchange-antispam-messagedata: t6QV+QDkjgnHP+NBEx0PtkUf1jcUZ15+544sK8mMSf2hNW7H+bgidjKEAh/pIL9ANt72XsRnBg3ir/xhxvun3mGiVaQQsX6zGL9j93aCqMM/Kqx1LIhlAxPuRqfSqcTPBvWJDHwR4px9QTYJW0/kJhpMhjrFGznUZz16J2+3hkbeNT65MiJnhjlzghzKThCP/hSnZPD4U0ymPadtZ2/mGtt5wTknghbXGsB3OgBi4oiGTScwbKsWK7ANA3sVMpuVk7roym2U8vsfy9pUyIhK2uKUsNwo5Ab2f87Tq2G2wHfR8iQHwP4TpSl7sUXuvBFIGEaJkY9Jiqj9bMS0o4jyitkDSw1lJE4r0KmQLg5ktfIeNCk14cZDaZvb8Pv+g066qgvopwKD+MVeQhZ6Cg+prQvcI1IasKUXezhTdUtPA5lMiJw22s3w0Pm13Jc2rvYd/7heqa0uQZp67W+ZC140eIaV+m9aT5a4xNE61NkAFUXRTOTup349d0ZMmbNxnLRfFyQatwUZkHWBh0HFJCuDBOO+L3AdkXmEdCmN52UO1zi/gX+iNfnHIEQ/TjhsfI66mYoEI1GEoj1v3Sce8riuZ87IxjDKlyvDodhOsvf+wU9DoNk8lVMppxLjR+M/hJiO5DzrcEdPK/1rY1vcMddNYXimluT9qDFAwJuwk9Fi0rhXJQhw2oUhj5qjVq49NUGaz4OvliZHzpatf9Y5LuWCJOEf/9rws1FzqbhDGJpfEPBGiCmnj1t7Fg5Jzj6HKP3VoCHR1dpoG4PsTch6dpMBwmM0kJw1NoRzVvtZ4gvVRPc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <9A13C6DDF798CF4E9E26695FC39DCD6C@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c28d4faa-d127-439f-5a24-08d7eb5dbbaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 10:20:10.4884 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nlki6aKk0IJsopXNxPyef6+p8wN5V9k61znmRxtLys8u6k0bTT7qkjZDhk/smmVCZcpxhDkj+gfUb8PO3jRkww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7087
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-28_06:2020-04-28,
 2020-04-28 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=ani.sinha@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 06:20:28
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Received-From: 148.163.155.12
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
 "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Laine Stump <laine@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "ani@anisinha.ca" <ani@anisinha.ca>, Igor Mammedov <imammedo@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+julie
+ laine

Rebased patch to latest Qemu master. Only minimal changes.


> On Apr 28, 2020, at 3:46 PM, Ani Sinha <ani.sinha@nutanix.com> wrote:
>=20
> A new option "use_acpi_unplug" is introduced for PIIX which will
> selectively only disable hot unplugging of both hot plugged and
> cold plugged PCI devices on non-root PCI buses. This will prevent
> hot unplugging of devices from Windows based guests from system
> tray but will not prevent devices from being hot plugged into the
> guest.
>=20
> It has been tested on Windows guests.
>=20
> Signed-off-by: Ani Sinha <ani.sinha@nutanix.com>
> ---
> hw/acpi/piix4.c      |  3 +++
> hw/i386/acpi-build.c | 40 ++++++++++++++++++++++++++--------------
> 2 files changed, 29 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index 964d6f5..59fa707 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
>=20
>     AcpiPciHpState acpi_pci_hotplug;
>     bool use_acpi_pci_hotplug;
> +    bool use_acpi_unplug;
>=20
>     uint8_t disable_s3;
>     uint8_t disable_s4;
> @@ -633,6 +634,8 @@ static Property piix4_pm_properties[] =3D {
>     DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
>     DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMState=
,
>                      use_acpi_pci_hotplug, true),
> +    DEFINE_PROP_BOOL("acpi-pci-hotunplug-enable-bridge", PIIX4PMState,
> +                     use_acpi_unplug, true),
>     DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
>                      acpi_memory_hotplug.is_enabled, true),
>     DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 23c77ee..71b3ac3 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -96,6 +96,7 @@ typedef struct AcpiPmInfo {
>     bool s3_disabled;
>     bool s4_disabled;
>     bool pcihp_bridge_en;
> +    bool pcihup_bridge_en;
>     uint8_t s4_val;
>     AcpiFadtData fadt;
>     uint16_t cpu_hp_io_base;
> @@ -240,6 +241,9 @@ static void acpi_get_pm_info(MachineState *machine, A=
cpiPmInfo *pm)
>     pm->pcihp_bridge_en =3D
>         object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-suppo=
rt",
>                                  NULL);
> +    pm->pcihup_bridge_en =3D
> +        object_property_get_bool(obj, "acpi-pci-hotunplug-enable-bridge"=
,
> +                                 NULL);
> }
>=20
> static void acpi_get_misc_info(AcpiMiscInfo *info)
> @@ -451,7 +455,8 @@ static void build_append_pcihp_notify_entry(Aml *meth=
od, int slot)
> }
>=20
> static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> -                                         bool pcihp_bridge_en)
> +                                         bool pcihp_bridge_en,
> +                                         bool pcihup_bridge_en)
> {
>     Aml *dev, *notify_method =3D NULL, *method;
>     QObject *bsel;
> @@ -479,11 +484,14 @@ static void build_append_pci_bus_devices(Aml *paren=
t_scope, PCIBus *bus,
>                 dev =3D aml_device("S%.02X", PCI_DEVFN(slot, 0));
>                 aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
>                 aml_append(dev, aml_name_decl("_ADR", aml_int(slot << 16)=
));
> -                method =3D aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> -                aml_append(method,
> -                    aml_call2("PCEJ", aml_name("BSEL"), aml_name("_SUN")=
)
> -                );
> -                aml_append(dev, method);
> +                if (pcihup_bridge_en || pci_bus_is_root(bus)) {
> +                    method =3D aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> +                    aml_append(method,
> +                               aml_call2("PCEJ", aml_name("BSEL"),
> +                                         aml_name("_SUN"))
> +                        );
> +                    aml_append(dev, method);
> +                }
>                 aml_append(parent_scope, dev);
>=20
>                 build_append_pcihp_notify_entry(notify_method, slot);
> @@ -537,12 +545,14 @@ static void build_append_pci_bus_devices(Aml *paren=
t_scope, PCIBus *bus,
>             /* add _SUN/_EJ0 to make slot hotpluggable  */
>             aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
>=20
> -            method =3D aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> -            aml_append(method,
> -                aml_call2("PCEJ", aml_name("BSEL"), aml_name("_SUN"))
> -            );
> -            aml_append(dev, method);
> -
> +            if (pcihup_bridge_en || pci_bus_is_root(bus)) {
> +                method =3D aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> +                aml_append(method,
> +                           aml_call2("PCEJ", aml_name("BSEL"),
> +                                     aml_name("_SUN"))
> +                    );
> +                aml_append(dev, method);
> +            }
>             if (bsel) {
>                 build_append_pcihp_notify_entry(notify_method, slot);
>             }
> @@ -553,7 +563,8 @@ static void build_append_pci_bus_devices(Aml *parent_=
scope, PCIBus *bus,
>              */
>             PCIBus *sec_bus =3D pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
>=20
> -            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en);
> +            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en,
> +                                         pcihup_bridge_en);
>         }
>         /* slot descriptor has been composed, add it into parent context =
*/
>         aml_append(parent_scope, dev);
> @@ -2196,7 +2207,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>         if (bus) {
>             Aml *scope =3D aml_scope("PCI0");
>             /* Scan all PCI buses. Generate tables to support hotplug. */
> -            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en=
);
> +            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en=
,
> +                                         pm->pcihup_bridge_en);
>=20
>             if (TPM_IS_TIS_ISA(tpm)) {
>                 if (misc->tpm_version =3D=3D TPM_VERSION_2_0) {
> --=20
> 1.9.4
>=20


