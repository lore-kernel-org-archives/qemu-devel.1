Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532CBC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 12:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C79820828
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 12:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="HFsAwexr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C79820828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieeHF-0005XA-Rh
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 07:06:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1ieeFn-0004NO-US
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:04:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1ieeFk-0000Kd-Ed
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:04:35 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:11248)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1ieeFk-0000GO-18
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:04:32 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBAC45oC030412; Tue, 10 Dec 2019 04:04:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=noQUPaVNwXD4Mvmk9QxWqydAbjDR2Sz5vaGWQ8N4lH8=;
 b=HFsAwexrbR1CIm1SLaMmkZhoyhmqV5bu19CdtN2IZy8SKzAb+jsYlfdx6IUrIg9eCQ/B
 dlyc4O6RTpRzTWav4NVEAuWkwinAwv5AiDsU3yH+xIEy1LRvaYXIMQq7urmp+xUnCx+r
 i1OS4aWuL4ZFVs6e/iAedPtvaayF+BsZXGdaSElg3dMo8iskIFI7/B6l5WTorGoNXg/W
 +i5dueom8vabJfKwC4ZqFhk1JT8rcB7Fx8ei7gWGwJQIIq1GZ6Pu2bzBnkJji0lnqQKk
 IkywHFn5zcZsJj9mGMDHVWAz/qA9RHwqnlkdi3k37+iOd4oTi5FkDGeMjxLeAW789N7y Fg== 
Received: from nam04-co1-obe.outbound.protection.outlook.com
 (mail-co1nam04lp2058.outbound.protection.outlook.com [104.47.45.58])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2wrch2namj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2019 04:04:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=legS67GIq9PX8GEVtyPpgx2uLXij/39ILUiUCnTsVgipR6g8uVPrVveRbu8bXwKtgiYsewmUf0ChbTaKw4VFAVLcsr84jv4yEkwvHdHUGYSv7u9evarA6tFsEjV+Ie01iTlUOazRM92ZevKDW2kI0gggTNoC2tTrG2oNnQekHcwdTn42/2WntppyTfujJKrRf0sSDRts/YsY1+6z0QlddYxMk70WlqviK5/mUNfcWsFhxFLqJxhESsocIsu7+6IBQ+UUwuT5FW/l3JPRpfh/sqXaoJjhfM3+lR7Nhmkolm7+kbEFw00qmU1ao9UoK8Ol6oNl5QLez/WbdILNqjiF2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noQUPaVNwXD4Mvmk9QxWqydAbjDR2Sz5vaGWQ8N4lH8=;
 b=O4cs9JzJxjXRCM2bD7XJrYbVorTc+GqrIgweAMf8juHD2QE/DswYubSotGXi/9laiA5tzCGTygaMwkVEsVJ/aqnk+/TnqroVPE+PKnQPevPS3Bnt9adY9pcM6IVWqHDujk0+KC/5N0BblQQ8NGMPD5oSdvxRLuNUrOIhuafRt171eQJC4Jp5EkHTkSC+a13nvw257CJP9C4jVrzxZKE/6fMsdkmsdRibs9ItFgUI9QSRe1zjKYQb66wzJfZ2bzPOHD8VHJ/g9GdjWRNWVTZyxTB+1YS3WM7H5CgtVcsq5Fbpx5gGm/YmyMWdk7I/QHl6CeUdonCB0B5DYnVB8M85Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2573.namprd02.prod.outlook.com (10.168.206.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Tue, 10 Dec 2019 12:04:24 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f801:763d:e7fc:6bf]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f801:763d:e7fc:6bf%7]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 12:04:24 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH v3 4/4] qom/object: Use common get/set uint helpers
Thread-Topic: [PATCH v3 4/4] qom/object: Use common get/set uint helpers
Thread-Index: AQHVptz985oxjq8vNkWSjwigP/vuiqemZqeAgAzvioA=
Date: Tue, 10 Dec 2019 12:04:24 +0000
Message-ID: <894244E2-85E3-4779-A6A2-EC5192D504B7@nutanix.com>
References: <20191129174630.6922-1-felipe@nutanix.com>
 <20191129174630.6922-5-felipe@nutanix.com>
 <ef90cc03-7e72-2238-72c5-b531032208e2@ozlabs.ru>
In-Reply-To: <ef90cc03-7e72-2238-72c5-b531032208e2@ozlabs.ru>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de51739e-ac83-4fad-f1fa-08d77d691961
x-ms-traffictypediagnostic: MWHPR02MB2573:
x-microsoft-antispam-prvs: <MWHPR02MB2573D11CCFE220F618489F06D75B0@MWHPR02MB2573.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(396003)(136003)(376002)(39860400002)(199004)(189003)(316002)(8676002)(26005)(5660300002)(966005)(4326008)(2616005)(66946007)(2906002)(186003)(81166006)(33656002)(71200400001)(36756003)(91956017)(66476007)(76116006)(66446008)(66556008)(6916009)(64756008)(6512007)(8936002)(6506007)(53546011)(86362001)(81156014)(6486002)(478600001)(54906003)(30864003)(64030200001)(579004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2573;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JEozyyl5SnHr0mE8K34hKuGp4ePPY07h88+RaamuaPT6V9ObgZC/dtoiUnr3wswe2do/SHx1dJyWJtfzrbDMOSWxUFSvFFXkhVsXsp/9tBIaMN50sBC76Gs59nhcF/1eVktCsuub3y6HOU4CIaHhdAKF4SVdxLElPgop1e7hnATeqGm3V5pBTyvN/B85f+bO8MuwxNyH6zxbwpQLo2JD5VJ18Y4uL4apBuNcJ2BJckHA0pwYzjVed4JZAdTTs0Ysrak4Xcd0XW70jpb/EZlNoC5MpWd64EnRtE7oL+2Y9E3+qOHq/VKIARe72gC5bBu2EAl7ekB60NgbewC6DXszwgUmo+OSxnHgp5GmhnLpoV3dZdlEESgd9OdN0wLgluwmx0s21ifuKctDfo72YGveOsBh7AIW092fmxWPy950+hDhiBbHw7puWaVB8E+1YR+JgsBfOU2qAXGj/UFj/8d4gb/dglvSX76Tca2/IuhOdAhpcpEMVoHWhPB0ztDgJRWcOd/FuG9J2ljEIlQEJM+Vtl/kRVrUq9yZia9Jc79D80Q=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11203B3188A2204B99C12819519259C4@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de51739e-ac83-4fad-f1fa-08d77d691961
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 12:04:24.4393 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w4JTeNo7nlR2/US+UR1QsRHOy6F9n85Toab618xJ2ZA/A8s80k5wDjoSsDLjsY6Hyr9Ugd5mA7EYIN4Dh9iOBtUM+BcnZWotFjlb/zs5WJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2573
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_02:2019-12-10,2019-12-10 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.151.68
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe Mathieu-Daude <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

> On Dec 2, 2019, at 6:31 AM, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>=20
>=20
>=20
> On 30/11/2019 04:46, Felipe Franciosi wrote:
>> Several objects implemented their own uint property getters and setters,
>> despite them being straightforward (without any checks/validations on
>> the values themselves) and identical across objects. This makes use of
>> an enhanced API for object_property_add_uintXX_ptr() which offers
>> default setters.
>>=20
>> Some of these setters used to update the value even if the type visit
>> failed (eg. because the value being set overflowed over the given type).
>> The new setter introduces a check for these errors, not updating the
>> value if an error occurred. The error is propagated.
>>=20
>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
>> ---
>> hw/acpi/ich9.c       |  95 ++++----------------------------------
>> hw/isa/lpc_ich9.c    |  12 +----
>> hw/misc/edu.c        |  13 ++----
>> hw/pci-host/q35.c    |  14 ++----
>> hw/ppc/spapr.c       |  18 ++------
>> hw/vfio/pci-quirks.c |  20 +++-----
>> memory.c             |  15 +-----
>> target/arm/cpu.c     |  22 ++-------
>> target/i386/sev.c    | 106 ++++---------------------------------------
>> 9 files changed, 40 insertions(+), 275 deletions(-)
>>=20
>> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
>> index 742fb78226..d9305be891 100644
>> --- a/hw/acpi/ich9.c
>> +++ b/hw/acpi/ich9.c
>> @@ -357,81 +357,6 @@ static void ich9_pm_set_cpu_hotplug_legacy(Object *=
obj, bool value,
>>     s->pm.cpu_hotplug_legacy =3D value;
>> }
>>=20
>> -static void ich9_pm_get_disable_s3(Object *obj, Visitor *v, const char =
*name,
>> -                                   void *opaque, Error **errp)
>> -{
>> -    ICH9LPCPMRegs *pm =3D opaque;
>> -    uint8_t value =3D pm->disable_s3;
>> -
>> -    visit_type_uint8(v, name, &value, errp);
>> -}
>> -
>> -static void ich9_pm_set_disable_s3(Object *obj, Visitor *v, const char =
*name,
>> -                                   void *opaque, Error **errp)
>> -{
>> -    ICH9LPCPMRegs *pm =3D opaque;
>> -    Error *local_err =3D NULL;
>> -    uint8_t value;
>> -
>> -    visit_type_uint8(v, name, &value, &local_err);
>> -    if (local_err) {
>> -        goto out;
>> -    }
>> -    pm->disable_s3 =3D value;
>> -out:
>> -    error_propagate(errp, local_err);
>> -}
>> -
>> -static void ich9_pm_get_disable_s4(Object *obj, Visitor *v, const char =
*name,
>> -                                   void *opaque, Error **errp)
>> -{
>> -    ICH9LPCPMRegs *pm =3D opaque;
>> -    uint8_t value =3D pm->disable_s4;
>> -
>> -    visit_type_uint8(v, name, &value, errp);
>> -}
>> -
>> -static void ich9_pm_set_disable_s4(Object *obj, Visitor *v, const char =
*name,
>> -                                   void *opaque, Error **errp)
>> -{
>> -    ICH9LPCPMRegs *pm =3D opaque;
>> -    Error *local_err =3D NULL;
>> -    uint8_t value;
>> -
>> -    visit_type_uint8(v, name, &value, &local_err);
>> -    if (local_err) {
>> -        goto out;
>> -    }
>> -    pm->disable_s4 =3D value;
>> -out:
>> -    error_propagate(errp, local_err);
>> -}
>> -
>> -static void ich9_pm_get_s4_val(Object *obj, Visitor *v, const char *nam=
e,
>> -                               void *opaque, Error **errp)
>> -{
>> -    ICH9LPCPMRegs *pm =3D opaque;
>> -    uint8_t value =3D pm->s4_val;
>> -
>> -    visit_type_uint8(v, name, &value, errp);
>> -}
>> -
>> -static void ich9_pm_set_s4_val(Object *obj, Visitor *v, const char *nam=
e,
>> -                               void *opaque, Error **errp)
>> -{
>> -    ICH9LPCPMRegs *pm =3D opaque;
>> -    Error *local_err =3D NULL;
>> -    uint8_t value;
>> -
>> -    visit_type_uint8(v, name, &value, &local_err);
>> -    if (local_err) {
>> -        goto out;
>> -    }
>> -    pm->s4_val =3D value;
>> -out:
>> -    error_propagate(errp, local_err);
>> -}
>> -
>> static bool ich9_pm_get_enable_tco(Object *obj, Error **errp)
>> {
>>     ICH9LPCState *s =3D ICH9_LPC_DEVICE(obj);
>> @@ -468,18 +393,14 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPM=
Regs *pm, Error **errp)
>>                              ich9_pm_get_cpu_hotplug_legacy,
>>                              ich9_pm_set_cpu_hotplug_legacy,
>>                              NULL);
>> -    object_property_add(obj, ACPI_PM_PROP_S3_DISABLED, "uint8",
>> -                        ich9_pm_get_disable_s3,
>> -                        ich9_pm_set_disable_s3,
>> -                        NULL, pm, NULL);
>> -    object_property_add(obj, ACPI_PM_PROP_S4_DISABLED, "uint8",
>> -                        ich9_pm_get_disable_s4,
>> -                        ich9_pm_set_disable_s4,
>> -                        NULL, pm, NULL);
>> -    object_property_add(obj, ACPI_PM_PROP_S4_VAL, "uint8",
>> -                        ich9_pm_get_s4_val,
>> -                        ich9_pm_set_s4_val,
>> -                        NULL, pm, NULL);
>> +    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S3_DISABLED,
>> +                                  &pm->disable_s3, OBJ_PROP_FLAG_READWR=
ITE,
>> +                                  NULL);
>> +    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_DISABLED,
>> +                                  &pm->disable_s4, OBJ_PROP_FLAG_READWR=
ITE,
>> +                                  NULL);
>> +    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_VAL,
>> +                                  &pm->s4_val, OBJ_PROP_FLAG_READWRITE,=
 NULL);
>>     object_property_add_bool(obj, ACPI_PM_PROP_TCO_ENABLED,
>>                              ich9_pm_get_enable_tco,
>>                              ich9_pm_set_enable_tco,
>> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
>> index c40bb3c420..b99a613954 100644
>> --- a/hw/isa/lpc_ich9.c
>> +++ b/hw/isa/lpc_ich9.c
>> @@ -627,13 +627,6 @@ static const MemoryRegionOps ich9_rst_cnt_ops =3D {
>>     .endianness =3D DEVICE_LITTLE_ENDIAN
>> };
>>=20
>> -static void ich9_lpc_get_sci_int(Object *obj, Visitor *v, const char *n=
ame,
>> -                                 void *opaque, Error **errp)
>> -{
>> -    ICH9LPCState *lpc =3D ICH9_LPC_DEVICE(obj);
>> -    visit_type_uint8(v, name, &lpc->sci_gsi, errp);
>> -}
>> -
>> static void ich9_lpc_initfn(Object *obj)
>> {
>>     ICH9LPCState *lpc =3D ICH9_LPC_DEVICE(obj);
>> @@ -641,9 +634,8 @@ static void ich9_lpc_initfn(Object *obj)
>>     static const uint8_t acpi_enable_cmd =3D ICH9_APM_ACPI_ENABLE;
>>     static const uint8_t acpi_disable_cmd =3D ICH9_APM_ACPI_DISABLE;
>>=20
>> -    object_property_add(obj, ACPI_PM_PROP_SCI_INT, "uint8",
>> -                        ich9_lpc_get_sci_int,
>> -                        NULL, NULL, NULL, NULL);
>> +    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_SCI_INT,
>> +                                  &lpc->sci_gsi, OBJ_PROP_FLAG_READ, NU=
LL);
>>     object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABLE_=
CMD,
>>                                   &acpi_enable_cmd, OBJ_PROP_FLAG_READ, =
NULL);
>>     object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_DISABLE=
_CMD,
>> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
>> index d5e2bdbb57..ff10f5b794 100644
>> --- a/hw/misc/edu.c
>> +++ b/hw/misc/edu.c
>> @@ -396,21 +396,14 @@ static void pci_edu_uninit(PCIDevice *pdev)
>>     msi_uninit(pdev);
>> }
>>=20
>> -static void edu_obj_uint64(Object *obj, Visitor *v, const char *name,
>> -                           void *opaque, Error **errp)
>> -{
>> -    uint64_t *val =3D opaque;
>> -
>> -    visit_type_uint64(v, name, val, errp);
>> -}
>> -
>> static void edu_instance_init(Object *obj)
>> {
>>     EduState *edu =3D EDU(obj);
>>=20
>>     edu->dma_mask =3D (1UL << 28) - 1;
>> -    object_property_add(obj, "dma_mask", "uint64", edu_obj_uint64,
>> -                    edu_obj_uint64, NULL, &edu->dma_mask, NULL);
>> +    object_property_add_uint64_ptr(obj, "dma_mask",
>> +                                   &edu->dma_mask, OBJ_PROP_FLAG_READWR=
ITE,
>> +                                   NULL);
>> }
>>=20
>> static void edu_class_init(ObjectClass *class, void *data)
>> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
>> index 158d270b9f..f384ab95c6 100644
>> --- a/hw/pci-host/q35.c
>> +++ b/hw/pci-host/q35.c
>> @@ -165,14 +165,6 @@ static void q35_host_get_pci_hole64_end(Object *obj=
, Visitor *v,
>>     visit_type_uint64(v, name, &value, errp);
>> }
>>=20
>> -static void q35_host_get_mmcfg_size(Object *obj, Visitor *v, const char=
 *name,
>> -                                    void *opaque, Error **errp)
>> -{
>> -    PCIExpressHost *e =3D PCIE_HOST_BRIDGE(obj);
>> -
>> -    visit_type_uint64(v, name, &e->size, errp);
>> -}
>> -
>> /*
>>  * NOTE: setting defaults for the mch.* fields in this table
>>  * doesn't work, because mch is a separate QOM object that is
>> @@ -213,6 +205,7 @@ static void q35_host_initfn(Object *obj)
>> {
>>     Q35PCIHost *s =3D Q35_HOST_DEVICE(obj);
>>     PCIHostState *phb =3D PCI_HOST_BRIDGE(obj);
>> +    PCIExpressHost *pehb =3D PCIE_HOST_BRIDGE(obj);
>>=20
>>     memory_region_init_io(&phb->conf_mem, obj, &pci_host_conf_le_ops, ph=
b,
>>                           "pci-conf-idx", 4);
>> @@ -242,9 +235,8 @@ static void q35_host_initfn(Object *obj)
>>                         q35_host_get_pci_hole64_end,
>>                         NULL, NULL, NULL, NULL);
>>=20
>> -    object_property_add(obj, PCIE_HOST_MCFG_SIZE, "uint64",
>> -                        q35_host_get_mmcfg_size,
>> -                        NULL, NULL, NULL, NULL);
>> +    object_property_add_uint64_ptr(obj, PCIE_HOST_MCFG_SIZE,
>> +                                   &pehb->size, OBJ_PROP_FLAG_READ, NUL=
L);
>>=20
>>     object_property_add_link(obj, MCH_HOST_PROP_RAM_MEM, TYPE_MEMORY_REG=
ION,
>>                              (Object **) &s->mch.ram_memory,
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index e076f6023c..668f045023 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -3227,18 +3227,6 @@ static void spapr_set_resize_hpt(Object *obj, con=
st char *value, Error **errp)
>>     }
>> }
>>=20
>> -static void spapr_get_vsmt(Object *obj, Visitor *v, const char *name,
>> -                                   void *opaque, Error **errp)
>> -{
>> -    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
>> -}
>> -
>> -static void spapr_set_vsmt(Object *obj, Visitor *v, const char *name,
>> -                                   void *opaque, Error **errp)
>> -{
>> -    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
>> -}
>> -
>> static char *spapr_get_ic_mode(Object *obj, Error **errp)
>> {
>>     SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
>> @@ -3336,8 +3324,10 @@ static void spapr_instance_init(Object *obj)
>>     object_property_set_description(obj, "resize-hpt",
>>                                     "Resizing of the Hash Page Table (en=
abled, disabled, required)",
>>                                     NULL);
>> -    object_property_add(obj, "vsmt", "uint32", spapr_get_vsmt,
>> -                        spapr_set_vsmt, NULL, &spapr->vsmt, &error_abor=
t);
>> +    object_property_add_uint32_ptr(obj, "vsmt",
>> +                                   &spapr->vsmt, OBJ_PROP_FLAG_READWRIT=
E,
>> +                                   &error_abort);
>=20
>=20
> Ths looks alright but...

Ok.

>=20
>=20
>> +
>>     object_property_set_description(obj, "vsmt",
>>                                     "Virtual SMT: KVM behaves as if this=
 were"
>>                                     " the host's SMT mode", &error_abort=
);
>> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
>> index 136f3a9ad6..d769c99bde 100644
>> --- a/hw/vfio/pci-quirks.c
>> +++ b/hw/vfio/pci-quirks.c
>> @@ -2187,14 +2187,6 @@ int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error=
 **errp)
>>     return 0;
>> }
>>=20
>> -static void vfio_pci_nvlink2_get_tgt(Object *obj, Visitor *v,
>> -                                     const char *name,
>> -                                     void *opaque, Error **errp)
>> -{
>> -    uint64_t tgt =3D (uintptr_t) opaque;
>> -    visit_type_uint64(v, name, &tgt, errp);
>> -}
>> -
>> static void vfio_pci_nvlink2_get_link_speed(Object *obj, Visitor *v,
>>                                                  const char *name,
>>                                                  void *opaque, Error **e=
rrp)
>> @@ -2240,9 +2232,9 @@ int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *v=
dev, Error **errp)
>>                                nv2reg->size, p);
>>     QLIST_INSERT_HEAD(&vdev->bars[0].quirks, quirk, next);
>>=20
>> -    object_property_add(OBJECT(vdev), "nvlink2-tgt", "uint64",
>> -                        vfio_pci_nvlink2_get_tgt, NULL, NULL,
>> -                        (void *) (uintptr_t) cap->tgt, NULL);
>> +    object_property_add_uint64_ptr(OBJECT(vdev), "nvlink2-tgt",
>> +                                   (void *)(uintptr_t)cap->tgt,
>=20
>=20
> ... this does not seem equalent. The getter will assume cap->tgt is an
> userspace address which it is not. &cap->tgt would be QOM-correct but
> won't work because of the lifetime of @cap but this is another story.

Maybe I just don't understand where this value comes from. It sounds
like you know what you are talking about :) so I'll send a v4 and
leave this method untouched, unless you have a chance to test this and
tell me that it still works.

>=20
> btw what is this patchset based on? I tried applying it on top of 3 week
> old and today upstream and it failed. Thanks,

I'm not sure why there were problems. I just rebased my branch on top
of latest master (without issues). I pushed it to Github so you can
have a look. Let me know if you want to try it out or if I should just
send a v4 straight away dropping the changes immediately above.

https://github.com/franciozzy/qemu

Thanks!
F.

>=20
>=20
>=20
>=20
>=20
>> +                                   OBJ_PROP_FLAG_READ, NULL);
>>     trace_vfio_pci_nvidia_gpu_setup_quirk(vdev->vbasedev.name, cap->tgt,
>>                                           nv2reg->size);
>> free_exit:
>> @@ -2301,9 +2293,9 @@ int vfio_pci_nvlink2_init(VFIOPCIDevice *vdev, Err=
or **errp)
>>         QLIST_INSERT_HEAD(&vdev->bars[0].quirks, quirk, next);
>>     }
>>=20
>> -    object_property_add(OBJECT(vdev), "nvlink2-tgt", "uint64",
>> -                        vfio_pci_nvlink2_get_tgt, NULL, NULL,
>> -                        (void *) (uintptr_t) captgt->tgt, NULL);
>> +    object_property_add_uint64_ptr(OBJECT(vdev), "nvlink2-tgt",
>> +                                   (void *)(uintptr_t)captgt->tgt,
>> +                                   OBJ_PROP_FLAG_READ, NULL);
>>     trace_vfio_pci_nvlink2_setup_quirk_ssatgt(vdev->vbasedev.name, captg=
t->tgt,
>>                                               atsdreg->size);
>>=20
>> diff --git a/memory.c b/memory.c
>> index 06484c2bff..7dac2aa059 100644
>> --- a/memory.c
>> +++ b/memory.c
>> @@ -1158,15 +1158,6 @@ void memory_region_init(MemoryRegion *mr,
>>     memory_region_do_init(mr, owner, name, size);
>> }
>>=20
>> -static void memory_region_get_addr(Object *obj, Visitor *v, const char =
*name,
>> -                                   void *opaque, Error **errp)
>> -{
>> -    MemoryRegion *mr =3D MEMORY_REGION(obj);
>> -    uint64_t value =3D mr->addr;
>> -
>> -    visit_type_uint64(v, name, &value, errp);
>> -}
>> -
>> static void memory_region_get_container(Object *obj, Visitor *v,
>>                                         const char *name, void *opaque,
>>                                         Error **errp)
>> @@ -1230,10 +1221,8 @@ static void memory_region_initfn(Object *obj)
>>                              NULL, NULL, &error_abort);
>>     op->resolve =3D memory_region_resolve_container;
>>=20
>> -    object_property_add(OBJECT(mr), "addr", "uint64",
>> -                        memory_region_get_addr,
>> -                        NULL, /* memory_region_set_addr */
>> -                        NULL, NULL, &error_abort);
>> +    object_property_add_uint64_ptr(OBJECT(mr), "addr",
>> +                                   &mr->addr, OBJ_PROP_FLAG_READ, &erro=
r_abort);
>>     object_property_add(OBJECT(mr), "priority", "uint32",
>>                         memory_region_get_priority,
>>                         NULL, /* memory_region_set_priority */
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index 7a4ac9339b..bbe25a73c4 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -1039,22 +1039,6 @@ static void arm_set_pmu(Object *obj, bool value, =
Error **errp)
>>     cpu->has_pmu =3D value;
>> }
>>=20
>> -static void arm_get_init_svtor(Object *obj, Visitor *v, const char *nam=
e,
>> -                               void *opaque, Error **errp)
>> -{
>> -    ARMCPU *cpu =3D ARM_CPU(obj);
>> -
>> -    visit_type_uint32(v, name, &cpu->init_svtor, errp);
>> -}
>> -
>> -static void arm_set_init_svtor(Object *obj, Visitor *v, const char *nam=
e,
>> -                               void *opaque, Error **errp)
>> -{
>> -    ARMCPU *cpu =3D ARM_CPU(obj);
>> -
>> -    visit_type_uint32(v, name, &cpu->init_svtor, errp);
>> -}
>> -
>> void arm_cpu_post_init(Object *obj)
>> {
>>     ARMCPU *cpu =3D ARM_CPU(obj);
>> @@ -1165,9 +1149,9 @@ void arm_cpu_post_init(Object *obj)
>>          * a simple DEFINE_PROP_UINT32 for this because we want to permi=
t
>>          * the property to be set after realize.
>>          */
>> -        object_property_add(obj, "init-svtor", "uint32",
>> -                            arm_get_init_svtor, arm_set_init_svtor,
>> -                            NULL, NULL, &error_abort);
>> +        object_property_add_uint32_ptr(obj, "init-svtor",
>> +                                       &cpu->init_svtor,
>> +                                       OBJ_PROP_FLAG_READWRITE, &error_=
abort);
>>     }
>>=20
>>     qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
>> diff --git a/target/i386/sev.c b/target/i386/sev.c
>> index 024bb24e51..846018a12d 100644
>> --- a/target/i386/sev.c
>> +++ b/target/i386/sev.c
>> @@ -266,94 +266,6 @@ qsev_guest_class_init(ObjectClass *oc, void *data)
>>             "guest owners session parameters (encoded with base64)", NUL=
L);
>> }
>>=20
>> -static void
>> -qsev_guest_set_handle(Object *obj, Visitor *v, const char *name,
>> -                      void *opaque, Error **errp)
>> -{
>> -    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
>> -    uint32_t value;
>> -
>> -    visit_type_uint32(v, name, &value, errp);
>> -    sev->handle =3D value;
>> -}
>> -
>> -static void
>> -qsev_guest_set_policy(Object *obj, Visitor *v, const char *name,
>> -                      void *opaque, Error **errp)
>> -{
>> -    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
>> -    uint32_t value;
>> -
>> -    visit_type_uint32(v, name, &value, errp);
>> -    sev->policy =3D value;
>> -}
>> -
>> -static void
>> -qsev_guest_set_cbitpos(Object *obj, Visitor *v, const char *name,
>> -                       void *opaque, Error **errp)
>> -{
>> -    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
>> -    uint32_t value;
>> -
>> -    visit_type_uint32(v, name, &value, errp);
>> -    sev->cbitpos =3D value;
>> -}
>> -
>> -static void
>> -qsev_guest_set_reduced_phys_bits(Object *obj, Visitor *v, const char *n=
ame,
>> -                                   void *opaque, Error **errp)
>> -{
>> -    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
>> -    uint32_t value;
>> -
>> -    visit_type_uint32(v, name, &value, errp);
>> -    sev->reduced_phys_bits =3D value;
>> -}
>> -
>> -static void
>> -qsev_guest_get_policy(Object *obj, Visitor *v, const char *name,
>> -                      void *opaque, Error **errp)
>> -{
>> -    uint32_t value;
>> -    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
>> -
>> -    value =3D sev->policy;
>> -    visit_type_uint32(v, name, &value, errp);
>> -}
>> -
>> -static void
>> -qsev_guest_get_handle(Object *obj, Visitor *v, const char *name,
>> -                      void *opaque, Error **errp)
>> -{
>> -    uint32_t value;
>> -    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
>> -
>> -    value =3D sev->handle;
>> -    visit_type_uint32(v, name, &value, errp);
>> -}
>> -
>> -static void
>> -qsev_guest_get_cbitpos(Object *obj, Visitor *v, const char *name,
>> -                       void *opaque, Error **errp)
>> -{
>> -    uint32_t value;
>> -    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
>> -
>> -    value =3D sev->cbitpos;
>> -    visit_type_uint32(v, name, &value, errp);
>> -}
>> -
>> -static void
>> -qsev_guest_get_reduced_phys_bits(Object *obj, Visitor *v, const char *n=
ame,
>> -                                   void *opaque, Error **errp)
>> -{
>> -    uint32_t value;
>> -    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
>> -
>> -    value =3D sev->reduced_phys_bits;
>> -    visit_type_uint32(v, name, &value, errp);
>> -}
>> -
>> static void
>> qsev_guest_init(Object *obj)
>> {
>> @@ -361,15 +273,15 @@ qsev_guest_init(Object *obj)
>>=20
>>     sev->sev_device =3D g_strdup(DEFAULT_SEV_DEVICE);
>>     sev->policy =3D DEFAULT_GUEST_POLICY;
>> -    object_property_add(obj, "policy", "uint32", qsev_guest_get_policy,
>> -                        qsev_guest_set_policy, NULL, NULL, NULL);
>> -    object_property_add(obj, "handle", "uint32", qsev_guest_get_handle,
>> -                        qsev_guest_set_handle, NULL, NULL, NULL);
>> -    object_property_add(obj, "cbitpos", "uint32", qsev_guest_get_cbitpo=
s,
>> -                        qsev_guest_set_cbitpos, NULL, NULL, NULL);
>> -    object_property_add(obj, "reduced-phys-bits", "uint32",
>> -                        qsev_guest_get_reduced_phys_bits,
>> -                        qsev_guest_set_reduced_phys_bits, NULL, NULL, N=
ULL);
>> +    object_property_add_uint32_ptr(obj, "policy", &sev->policy,
>> +                                   OBJ_PROP_FLAG_READWRITE, NULL);
>> +    object_property_add_uint32_ptr(obj, "handle", &sev->handle,
>> +                                   OBJ_PROP_FLAG_READWRITE, NULL);
>> +    object_property_add_uint32_ptr(obj, "cbitpos", &sev->cbitpos,
>> +                                   OBJ_PROP_FLAG_READWRITE, NULL);
>> +    object_property_add_uint32_ptr(obj, "reduced-phys-bits",
>> +                                   &sev->reduced_phys_bits,
>> +                                   OBJ_PROP_FLAG_READWRITE, NULL);
>> }
>>=20
>> /* sev guest info */
>>=20
>=20
> --=20
> Alexey


