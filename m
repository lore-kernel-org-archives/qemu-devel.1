Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4B5C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 22:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 219D321582
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 22:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="W8BtBdh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219D321582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihLE2-0001op-AC
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 17:21:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1ihLDK-0001NP-R9
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 17:21:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1ihLDH-0007RX-20
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 17:21:09 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:53430)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1ihLDG-0007Nd-NW
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 17:21:07 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBHMKFn8017098; Tue, 17 Dec 2019 14:20:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=PB8lnr4SJqoLKxDLX/LF3u4hQXJupIffzZ2C+V87kHk=;
 b=W8BtBdh05tMy8Yavjy+Gab5JaIptQbt3u3szpdInWvTGD78bUPK1W6s8JUdGTOXJ5CD6
 dVZHbdIvnU/UV/cp6XxhJkpRO/uKkaOu6IYXvn7IT/p7qaYh5SdTrjQEMhLzGVi2QakT
 Ua3OlEs4BeHmSZ5SRKk3aMccGepZPow3qula1cc4I63VOmLwaZl//ax4HodPncOjd80w
 mfIhu1QN/1Q6J1Y+uEyvchGLMDYVF/MQz3yMVOhS0rCSpX/ytvv7sIeirRjuvwHwNHUA
 I3V5mK2bMAhhnOmQjrXAszAwQQtJstbLznCJLy5XwFvNhx36P8D8LhdUzGtrdIIhYVCZ 8w== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2wvyppps7v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Dec 2019 14:20:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbR4hfb2xPrBOFCPgdyZCUgaiV4lY3wQc/I3iu/o6MkS/w6A4lISgPipMY2NxzruIJMlhA6+KPEua4CuR2kb2Ws/MfqWAy+dxO/f4oniePBTncNdLi3zWWO7J3WGBDecoN8HghUT7N/J7TBLSAxObzpniXRf4piv3+WJ2mO5BxK+me6VVY/OPbduUk58SswbctdB4miDx7scZapo5/DfvGTyb6ZukkBZL2++FMM4Fi9KDD0Tg4WEjucpcZ8rgW+nvEvmWgNIImg4XR7vyXx00O8XbeGbNoLUi26EUpwg0PsOnZ/MNCREhsCW/KLJ3FbhQXUBwqJxDijR/Y3Vp3rdkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PB8lnr4SJqoLKxDLX/LF3u4hQXJupIffzZ2C+V87kHk=;
 b=UzFBRLDGukUa2dZ+SewYjNLPrITNq/5H98Wmiggo1hNl953dayEYXp+mDqEp+hCVPMs5VnZhxti3sAPRReGEU0hgVNYilEyEF0IpFU9ur3uQEfK1bHjTXGRJ0DQwOJR9M5aPo3CrOmkMeC/zQSIcVDczqr8Sq65GlRXDaYVtEY+o7pxu3cYN5YM1AalPjFq0cmKX7R95qfxpVA8QpZ0fEw0JxtowcoHeflW5edGepDCY6UOD7fuC0swpB4f8I7TJLUNeZnnmuOzFfNcieXk098k1XBJX0A7teUuYisIrcCzWnMzOiiH9L3rsf5urH+ib3fsIbQOps9oUobJXbp+rrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2622.namprd02.prod.outlook.com (10.168.207.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Tue, 17 Dec 2019 22:19:10 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029%10]) with mapi id 15.20.2559.012; Tue, 17 Dec
 2019 22:19:09 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH v3 4/4] qom/object: Use common get/set uint helpers
Thread-Topic: [PATCH v3 4/4] qom/object: Use common get/set uint helpers
Thread-Index: AQHVptz985oxjq8vNkWSjwigP/vuiqemZqeAgAzvioCAC6wRgA==
Date: Tue, 17 Dec 2019 22:19:09 +0000
Message-ID: <5C28BA81-9EF0-4AA1-A04E-8F7B58E856FB@nutanix.com>
References: <20191129174630.6922-1-felipe@nutanix.com>
 <20191129174630.6922-5-felipe@nutanix.com>
 <ef90cc03-7e72-2238-72c5-b531032208e2@ozlabs.ru>
 <894244E2-85E3-4779-A6A2-EC5192D504B7@nutanix.com>
In-Reply-To: <894244E2-85E3-4779-A6A2-EC5192D504B7@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [46.189.28.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b739e37-9333-410d-4cd4-08d7833f2392
x-ms-traffictypediagnostic: MWHPR02MB2622:
x-microsoft-antispam-prvs: <MWHPR02MB262208DB30EFEEBFBB2502FED7500@MWHPR02MB2622.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(376002)(39860400002)(346002)(136003)(189003)(199004)(71200400001)(2906002)(6506007)(36756003)(186003)(53546011)(6916009)(30864003)(26005)(4326008)(5660300002)(478600001)(6512007)(66476007)(66556008)(64756008)(66446008)(91956017)(66946007)(76116006)(81166006)(81156014)(86362001)(33656002)(8676002)(8936002)(316002)(6486002)(2616005)(966005)(54906003)(64030200001)(579004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2622;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:3; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b+xVWC30RuV2BGaT6ccLx49JclYEBMZKc4SckZomaY4vmWM0AyEPB4MCR8mUtXSI8QF3URwS4b9qZzOtcPKM9q1ayLljM/t8DbyZRhlklfbgLbngb8P6q+ERsFQPQrWlw4i9P2vD0mQj43JX72ayhRyMhxSdsXrvGABmoUp/YZx70vgPHWTfJdy7iqCX7KPtc8bEQA35jcGldlpdCB53EbqznEHzA9xrP6c0PBk9XxzNiJQJvPDxQ2qvf7xcA1FLtMUUEs9YDNph4RkUhtahJarNIm+aQNlNDyjJgJOt0TQ+XcileVRRzTA1y2HcnU/b7D4UwlyaH8y1dX5KwC3oJovv6yRDgU4NmffxRiS9ssq6M1Io+AzDNygmtsdEH1bBFyioYrPS2TFGmsbBWt+yK3kXtOydlXZ7GLjSTuaWefl8ePYtaskf5dVV+7rumy3AaPMOdn4S87n8Kb8y2UJUlPAzKSD3eS8WsC7kJqyEZDrfoIW5Lj8lkeAlDglIe6/zmbBOLpFqb5bxJUdieeyD6YZsjCvHkzpWoVj05jLiGHE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7C8E2808F1C556488A97B03254939650@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b739e37-9333-410d-4cd4-08d7833f2392
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 22:19:09.7973 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f7QbM4VGrFk0LOPgsqRyqT2vXN7+wgAk2ZGPqz4IRvX0t1iO9GXsrO/R0TyxdjxCkz57kVdj2W1gTKbBCw3VxjdiQ4/g2AsgwaYbMBkoZi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2622
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_04:2019-12-17,2019-12-17 signatures=0
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

Hi Alexey,

I don't know how, but somehow I didn't receive your reply:
https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg02127.html

(I was about to follow up, then I decided to look at the archives to
make sure your response didn't get lost in my client somehow...)

Still not sure of what happened, lol, let's move on. :)

I'm top-posting as I couldn't pull your response in for a proper reply.

You said:
> The franciozzy/autosetters branch with this on top -
> https://github.com/aik/qemu/commit/94c33bb7debf
> - works fine. Thanks,

Your patch basically reverts a part of my commit and then makes the
change Marc-Andre recommended (by dropping the (void *) cast).

Is it ok for me to just drop that part of my patch and send the v4?

You can follow-up on the cast change afterwards.

Thanks,
F.


> On Dec 10, 2019, at 1:04 PM, Felipe Franciosi <felipe@nutanix.com> wrote:
>=20
> Hi
>=20
>> On Dec 2, 2019, at 6:31 AM, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>=20
>>=20
>>=20
>> On 30/11/2019 04:46, Felipe Franciosi wrote:
>>> Several objects implemented their own uint property getters and setters=
,
>>> despite them being straightforward (without any checks/validations on
>>> the values themselves) and identical across objects. This makes use of
>>> an enhanced API for object_property_add_uintXX_ptr() which offers
>>> default setters.
>>>=20
>>> Some of these setters used to update the value even if the type visit
>>> failed (eg. because the value being set overflowed over the given type)=
.
>>> The new setter introduces a check for these errors, not updating the
>>> value if an error occurred. The error is propagated.
>>>=20
>>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
>>> ---
>>> hw/acpi/ich9.c       |  95 ++++----------------------------------
>>> hw/isa/lpc_ich9.c    |  12 +----
>>> hw/misc/edu.c        |  13 ++----
>>> hw/pci-host/q35.c    |  14 ++----
>>> hw/ppc/spapr.c       |  18 ++------
>>> hw/vfio/pci-quirks.c |  20 +++-----
>>> memory.c             |  15 +-----
>>> target/arm/cpu.c     |  22 ++-------
>>> target/i386/sev.c    | 106 ++++---------------------------------------
>>> 9 files changed, 40 insertions(+), 275 deletions(-)
>>>=20
>>> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
>>> index 742fb78226..d9305be891 100644
>>> --- a/hw/acpi/ich9.c
>>> +++ b/hw/acpi/ich9.c
>>> @@ -357,81 +357,6 @@ static void ich9_pm_set_cpu_hotplug_legacy(Object =
*obj, bool value,
>>>    s->pm.cpu_hotplug_legacy =3D value;
>>> }
>>>=20
>>> -static void ich9_pm_get_disable_s3(Object *obj, Visitor *v, const char=
 *name,
>>> -                                   void *opaque, Error **errp)
>>> -{
>>> -    ICH9LPCPMRegs *pm =3D opaque;
>>> -    uint8_t value =3D pm->disable_s3;
>>> -
>>> -    visit_type_uint8(v, name, &value, errp);
>>> -}
>>> -
>>> -static void ich9_pm_set_disable_s3(Object *obj, Visitor *v, const char=
 *name,
>>> -                                   void *opaque, Error **errp)
>>> -{
>>> -    ICH9LPCPMRegs *pm =3D opaque;
>>> -    Error *local_err =3D NULL;
>>> -    uint8_t value;
>>> -
>>> -    visit_type_uint8(v, name, &value, &local_err);
>>> -    if (local_err) {
>>> -        goto out;
>>> -    }
>>> -    pm->disable_s3 =3D value;
>>> -out:
>>> -    error_propagate(errp, local_err);
>>> -}
>>> -
>>> -static void ich9_pm_get_disable_s4(Object *obj, Visitor *v, const char=
 *name,
>>> -                                   void *opaque, Error **errp)
>>> -{
>>> -    ICH9LPCPMRegs *pm =3D opaque;
>>> -    uint8_t value =3D pm->disable_s4;
>>> -
>>> -    visit_type_uint8(v, name, &value, errp);
>>> -}
>>> -
>>> -static void ich9_pm_set_disable_s4(Object *obj, Visitor *v, const char=
 *name,
>>> -                                   void *opaque, Error **errp)
>>> -{
>>> -    ICH9LPCPMRegs *pm =3D opaque;
>>> -    Error *local_err =3D NULL;
>>> -    uint8_t value;
>>> -
>>> -    visit_type_uint8(v, name, &value, &local_err);
>>> -    if (local_err) {
>>> -        goto out;
>>> -    }
>>> -    pm->disable_s4 =3D value;
>>> -out:
>>> -    error_propagate(errp, local_err);
>>> -}
>>> -
>>> -static void ich9_pm_get_s4_val(Object *obj, Visitor *v, const char *na=
me,
>>> -                               void *opaque, Error **errp)
>>> -{
>>> -    ICH9LPCPMRegs *pm =3D opaque;
>>> -    uint8_t value =3D pm->s4_val;
>>> -
>>> -    visit_type_uint8(v, name, &value, errp);
>>> -}
>>> -
>>> -static void ich9_pm_set_s4_val(Object *obj, Visitor *v, const char *na=
me,
>>> -                               void *opaque, Error **errp)
>>> -{
>>> -    ICH9LPCPMRegs *pm =3D opaque;
>>> -    Error *local_err =3D NULL;
>>> -    uint8_t value;
>>> -
>>> -    visit_type_uint8(v, name, &value, &local_err);
>>> -    if (local_err) {
>>> -        goto out;
>>> -    }
>>> -    pm->s4_val =3D value;
>>> -out:
>>> -    error_propagate(errp, local_err);
>>> -}
>>> -
>>> static bool ich9_pm_get_enable_tco(Object *obj, Error **errp)
>>> {
>>>    ICH9LPCState *s =3D ICH9_LPC_DEVICE(obj);
>>> @@ -468,18 +393,14 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCP=
MRegs *pm, Error **errp)
>>>                             ich9_pm_get_cpu_hotplug_legacy,
>>>                             ich9_pm_set_cpu_hotplug_legacy,
>>>                             NULL);
>>> -    object_property_add(obj, ACPI_PM_PROP_S3_DISABLED, "uint8",
>>> -                        ich9_pm_get_disable_s3,
>>> -                        ich9_pm_set_disable_s3,
>>> -                        NULL, pm, NULL);
>>> -    object_property_add(obj, ACPI_PM_PROP_S4_DISABLED, "uint8",
>>> -                        ich9_pm_get_disable_s4,
>>> -                        ich9_pm_set_disable_s4,
>>> -                        NULL, pm, NULL);
>>> -    object_property_add(obj, ACPI_PM_PROP_S4_VAL, "uint8",
>>> -                        ich9_pm_get_s4_val,
>>> -                        ich9_pm_set_s4_val,
>>> -                        NULL, pm, NULL);
>>> +    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S3_DISABLED,
>>> +                                  &pm->disable_s3, OBJ_PROP_FLAG_READW=
RITE,
>>> +                                  NULL);
>>> +    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_DISABLED,
>>> +                                  &pm->disable_s4, OBJ_PROP_FLAG_READW=
RITE,
>>> +                                  NULL);
>>> +    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_VAL,
>>> +                                  &pm->s4_val, OBJ_PROP_FLAG_READWRITE=
, NULL);
>>>    object_property_add_bool(obj, ACPI_PM_PROP_TCO_ENABLED,
>>>                             ich9_pm_get_enable_tco,
>>>                             ich9_pm_set_enable_tco,
>>> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
>>> index c40bb3c420..b99a613954 100644
>>> --- a/hw/isa/lpc_ich9.c
>>> +++ b/hw/isa/lpc_ich9.c
>>> @@ -627,13 +627,6 @@ static const MemoryRegionOps ich9_rst_cnt_ops =3D =
{
>>>    .endianness =3D DEVICE_LITTLE_ENDIAN
>>> };
>>>=20
>>> -static void ich9_lpc_get_sci_int(Object *obj, Visitor *v, const char *=
name,
>>> -                                 void *opaque, Error **errp)
>>> -{
>>> -    ICH9LPCState *lpc =3D ICH9_LPC_DEVICE(obj);
>>> -    visit_type_uint8(v, name, &lpc->sci_gsi, errp);
>>> -}
>>> -
>>> static void ich9_lpc_initfn(Object *obj)
>>> {
>>>    ICH9LPCState *lpc =3D ICH9_LPC_DEVICE(obj);
>>> @@ -641,9 +634,8 @@ static void ich9_lpc_initfn(Object *obj)
>>>    static const uint8_t acpi_enable_cmd =3D ICH9_APM_ACPI_ENABLE;
>>>    static const uint8_t acpi_disable_cmd =3D ICH9_APM_ACPI_DISABLE;
>>>=20
>>> -    object_property_add(obj, ACPI_PM_PROP_SCI_INT, "uint8",
>>> -                        ich9_lpc_get_sci_int,
>>> -                        NULL, NULL, NULL, NULL);
>>> +    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_SCI_INT,
>>> +                                  &lpc->sci_gsi, OBJ_PROP_FLAG_READ, N=
ULL);
>>>    object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABLE_=
CMD,
>>>                                  &acpi_enable_cmd, OBJ_PROP_FLAG_READ, =
NULL);
>>>    object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_DISABLE=
_CMD,
>>> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
>>> index d5e2bdbb57..ff10f5b794 100644
>>> --- a/hw/misc/edu.c
>>> +++ b/hw/misc/edu.c
>>> @@ -396,21 +396,14 @@ static void pci_edu_uninit(PCIDevice *pdev)
>>>    msi_uninit(pdev);
>>> }
>>>=20
>>> -static void edu_obj_uint64(Object *obj, Visitor *v, const char *name,
>>> -                           void *opaque, Error **errp)
>>> -{
>>> -    uint64_t *val =3D opaque;
>>> -
>>> -    visit_type_uint64(v, name, val, errp);
>>> -}
>>> -
>>> static void edu_instance_init(Object *obj)
>>> {
>>>    EduState *edu =3D EDU(obj);
>>>=20
>>>    edu->dma_mask =3D (1UL << 28) - 1;
>>> -    object_property_add(obj, "dma_mask", "uint64", edu_obj_uint64,
>>> -                    edu_obj_uint64, NULL, &edu->dma_mask, NULL);
>>> +    object_property_add_uint64_ptr(obj, "dma_mask",
>>> +                                   &edu->dma_mask, OBJ_PROP_FLAG_READW=
RITE,
>>> +                                   NULL);
>>> }
>>>=20
>>> static void edu_class_init(ObjectClass *class, void *data)
>>> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
>>> index 158d270b9f..f384ab95c6 100644
>>> --- a/hw/pci-host/q35.c
>>> +++ b/hw/pci-host/q35.c
>>> @@ -165,14 +165,6 @@ static void q35_host_get_pci_hole64_end(Object *ob=
j, Visitor *v,
>>>    visit_type_uint64(v, name, &value, errp);
>>> }
>>>=20
>>> -static void q35_host_get_mmcfg_size(Object *obj, Visitor *v, const cha=
r *name,
>>> -                                    void *opaque, Error **errp)
>>> -{
>>> -    PCIExpressHost *e =3D PCIE_HOST_BRIDGE(obj);
>>> -
>>> -    visit_type_uint64(v, name, &e->size, errp);
>>> -}
>>> -
>>> /*
>>> * NOTE: setting defaults for the mch.* fields in this table
>>> * doesn't work, because mch is a separate QOM object that is
>>> @@ -213,6 +205,7 @@ static void q35_host_initfn(Object *obj)
>>> {
>>>    Q35PCIHost *s =3D Q35_HOST_DEVICE(obj);
>>>    PCIHostState *phb =3D PCI_HOST_BRIDGE(obj);
>>> +    PCIExpressHost *pehb =3D PCIE_HOST_BRIDGE(obj);
>>>=20
>>>    memory_region_init_io(&phb->conf_mem, obj, &pci_host_conf_le_ops, ph=
b,
>>>                          "pci-conf-idx", 4);
>>> @@ -242,9 +235,8 @@ static void q35_host_initfn(Object *obj)
>>>                        q35_host_get_pci_hole64_end,
>>>                        NULL, NULL, NULL, NULL);
>>>=20
>>> -    object_property_add(obj, PCIE_HOST_MCFG_SIZE, "uint64",
>>> -                        q35_host_get_mmcfg_size,
>>> -                        NULL, NULL, NULL, NULL);
>>> +    object_property_add_uint64_ptr(obj, PCIE_HOST_MCFG_SIZE,
>>> +                                   &pehb->size, OBJ_PROP_FLAG_READ, NU=
LL);
>>>=20
>>>    object_property_add_link(obj, MCH_HOST_PROP_RAM_MEM, TYPE_MEMORY_REG=
ION,
>>>                             (Object **) &s->mch.ram_memory,
>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>> index e076f6023c..668f045023 100644
>>> --- a/hw/ppc/spapr.c
>>> +++ b/hw/ppc/spapr.c
>>> @@ -3227,18 +3227,6 @@ static void spapr_set_resize_hpt(Object *obj, co=
nst char *value, Error **errp)
>>>    }
>>> }
>>>=20
>>> -static void spapr_get_vsmt(Object *obj, Visitor *v, const char *name,
>>> -                                   void *opaque, Error **errp)
>>> -{
>>> -    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
>>> -}
>>> -
>>> -static void spapr_set_vsmt(Object *obj, Visitor *v, const char *name,
>>> -                                   void *opaque, Error **errp)
>>> -{
>>> -    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
>>> -}
>>> -
>>> static char *spapr_get_ic_mode(Object *obj, Error **errp)
>>> {
>>>    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
>>> @@ -3336,8 +3324,10 @@ static void spapr_instance_init(Object *obj)
>>>    object_property_set_description(obj, "resize-hpt",
>>>                                    "Resizing of the Hash Page Table (en=
abled, disabled, required)",
>>>                                    NULL);
>>> -    object_property_add(obj, "vsmt", "uint32", spapr_get_vsmt,
>>> -                        spapr_set_vsmt, NULL, &spapr->vsmt, &error_abo=
rt);
>>> +    object_property_add_uint32_ptr(obj, "vsmt",
>>> +                                   &spapr->vsmt, OBJ_PROP_FLAG_READWRI=
TE,
>>> +                                   &error_abort);
>>=20
>>=20
>> Ths looks alright but...
>=20
> Ok.
>=20
>>=20
>>=20
>>> +
>>>    object_property_set_description(obj, "vsmt",
>>>                                    "Virtual SMT: KVM behaves as if this=
 were"
>>>                                    " the host's SMT mode", &error_abort=
);
>>> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
>>> index 136f3a9ad6..d769c99bde 100644
>>> --- a/hw/vfio/pci-quirks.c
>>> +++ b/hw/vfio/pci-quirks.c
>>> @@ -2187,14 +2187,6 @@ int vfio_add_virt_caps(VFIOPCIDevice *vdev, Erro=
r **errp)
>>>    return 0;
>>> }
>>>=20
>>> -static void vfio_pci_nvlink2_get_tgt(Object *obj, Visitor *v,
>>> -                                     const char *name,
>>> -                                     void *opaque, Error **errp)
>>> -{
>>> -    uint64_t tgt =3D (uintptr_t) opaque;
>>> -    visit_type_uint64(v, name, &tgt, errp);
>>> -}
>>> -
>>> static void vfio_pci_nvlink2_get_link_speed(Object *obj, Visitor *v,
>>>                                                 const char *name,
>>>                                                 void *opaque, Error **e=
rrp)
>>> @@ -2240,9 +2232,9 @@ int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *=
vdev, Error **errp)
>>>                               nv2reg->size, p);
>>>    QLIST_INSERT_HEAD(&vdev->bars[0].quirks, quirk, next);
>>>=20
>>> -    object_property_add(OBJECT(vdev), "nvlink2-tgt", "uint64",
>>> -                        vfio_pci_nvlink2_get_tgt, NULL, NULL,
>>> -                        (void *) (uintptr_t) cap->tgt, NULL);
>>> +    object_property_add_uint64_ptr(OBJECT(vdev), "nvlink2-tgt",
>>> +                                   (void *)(uintptr_t)cap->tgt,
>>=20
>>=20
>> ... this does not seem equalent. The getter will assume cap->tgt is an
>> userspace address which it is not. &cap->tgt would be QOM-correct but
>> won't work because of the lifetime of @cap but this is another story.
>=20
> Maybe I just don't understand where this value comes from. It sounds
> like you know what you are talking about :) so I'll send a v4 and
> leave this method untouched, unless you have a chance to test this and
> tell me that it still works.
>=20
>>=20
>> btw what is this patchset based on? I tried applying it on top of 3 week
>> old and today upstream and it failed. Thanks,
>=20
> I'm not sure why there were problems. I just rebased my branch on top
> of latest master (without issues). I pushed it to Github so you can
> have a look. Let me know if you want to try it out or if I should just
> send a v4 straight away dropping the changes immediately above.
>=20
> https://github.com/franciozzy/qemu
>=20
> Thanks!
> F.
>=20
>>=20
>>=20
>>=20
>>=20
>>=20
>>> +                                   OBJ_PROP_FLAG_READ, NULL);
>>>    trace_vfio_pci_nvidia_gpu_setup_quirk(vdev->vbasedev.name, cap->tgt,
>>>                                          nv2reg->size);
>>> free_exit:
>>> @@ -2301,9 +2293,9 @@ int vfio_pci_nvlink2_init(VFIOPCIDevice *vdev, Er=
ror **errp)
>>>        QLIST_INSERT_HEAD(&vdev->bars[0].quirks, quirk, next);
>>>    }
>>>=20
>>> -    object_property_add(OBJECT(vdev), "nvlink2-tgt", "uint64",
>>> -                        vfio_pci_nvlink2_get_tgt, NULL, NULL,
>>> -                        (void *) (uintptr_t) captgt->tgt, NULL);
>>> +    object_property_add_uint64_ptr(OBJECT(vdev), "nvlink2-tgt",
>>> +                                   (void *)(uintptr_t)captgt->tgt,
>>> +                                   OBJ_PROP_FLAG_READ, NULL);
>>>    trace_vfio_pci_nvlink2_setup_quirk_ssatgt(vdev->vbasedev.name, captg=
t->tgt,
>>>                                              atsdreg->size);
>>>=20
>>> diff --git a/memory.c b/memory.c
>>> index 06484c2bff..7dac2aa059 100644
>>> --- a/memory.c
>>> +++ b/memory.c
>>> @@ -1158,15 +1158,6 @@ void memory_region_init(MemoryRegion *mr,
>>>    memory_region_do_init(mr, owner, name, size);
>>> }
>>>=20
>>> -static void memory_region_get_addr(Object *obj, Visitor *v, const char=
 *name,
>>> -                                   void *opaque, Error **errp)
>>> -{
>>> -    MemoryRegion *mr =3D MEMORY_REGION(obj);
>>> -    uint64_t value =3D mr->addr;
>>> -
>>> -    visit_type_uint64(v, name, &value, errp);
>>> -}
>>> -
>>> static void memory_region_get_container(Object *obj, Visitor *v,
>>>                                        const char *name, void *opaque,
>>>                                        Error **errp)
>>> @@ -1230,10 +1221,8 @@ static void memory_region_initfn(Object *obj)
>>>                             NULL, NULL, &error_abort);
>>>    op->resolve =3D memory_region_resolve_container;
>>>=20
>>> -    object_property_add(OBJECT(mr), "addr", "uint64",
>>> -                        memory_region_get_addr,
>>> -                        NULL, /* memory_region_set_addr */
>>> -                        NULL, NULL, &error_abort);
>>> +    object_property_add_uint64_ptr(OBJECT(mr), "addr",
>>> +                                   &mr->addr, OBJ_PROP_FLAG_READ, &err=
or_abort);
>>>    object_property_add(OBJECT(mr), "priority", "uint32",
>>>                        memory_region_get_priority,
>>>                        NULL, /* memory_region_set_priority */
>>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>>> index 7a4ac9339b..bbe25a73c4 100644
>>> --- a/target/arm/cpu.c
>>> +++ b/target/arm/cpu.c
>>> @@ -1039,22 +1039,6 @@ static void arm_set_pmu(Object *obj, bool value,=
 Error **errp)
>>>    cpu->has_pmu =3D value;
>>> }
>>>=20
>>> -static void arm_get_init_svtor(Object *obj, Visitor *v, const char *na=
me,
>>> -                               void *opaque, Error **errp)
>>> -{
>>> -    ARMCPU *cpu =3D ARM_CPU(obj);
>>> -
>>> -    visit_type_uint32(v, name, &cpu->init_svtor, errp);
>>> -}
>>> -
>>> -static void arm_set_init_svtor(Object *obj, Visitor *v, const char *na=
me,
>>> -                               void *opaque, Error **errp)
>>> -{
>>> -    ARMCPU *cpu =3D ARM_CPU(obj);
>>> -
>>> -    visit_type_uint32(v, name, &cpu->init_svtor, errp);
>>> -}
>>> -
>>> void arm_cpu_post_init(Object *obj)
>>> {
>>>    ARMCPU *cpu =3D ARM_CPU(obj);
>>> @@ -1165,9 +1149,9 @@ void arm_cpu_post_init(Object *obj)
>>>         * a simple DEFINE_PROP_UINT32 for this because we want to permi=
t
>>>         * the property to be set after realize.
>>>         */
>>> -        object_property_add(obj, "init-svtor", "uint32",
>>> -                            arm_get_init_svtor, arm_set_init_svtor,
>>> -                            NULL, NULL, &error_abort);
>>> +        object_property_add_uint32_ptr(obj, "init-svtor",
>>> +                                       &cpu->init_svtor,
>>> +                                       OBJ_PROP_FLAG_READWRITE, &error=
_abort);
>>>    }
>>>=20
>>>    qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
>>> diff --git a/target/i386/sev.c b/target/i386/sev.c
>>> index 024bb24e51..846018a12d 100644
>>> --- a/target/i386/sev.c
>>> +++ b/target/i386/sev.c
>>> @@ -266,94 +266,6 @@ qsev_guest_class_init(ObjectClass *oc, void *data)
>>>            "guest owners session parameters (encoded with base64)", NUL=
L);
>>> }
>>>=20
>>> -static void
>>> -qsev_guest_set_handle(Object *obj, Visitor *v, const char *name,
>>> -                      void *opaque, Error **errp)
>>> -{
>>> -    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
>>> -    uint32_t value;
>>> -
>>> -    visit_type_uint32(v, name, &value, errp);
>>> -    sev->handle =3D value;
>>> -}
>>> -
>>> -static void
>>> -qsev_guest_set_policy(Object *obj, Visitor *v, const char *name,
>>> -                      void *opaque, Error **errp)
>>> -{
>>> -    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
>>> -    uint32_t value;
>>> -
>>> -    visit_type_uint32(v, name, &value, errp);
>>> -    sev->policy =3D value;
>>> -}
>>> -
>>> -static void
>>> -qsev_guest_set_cbitpos(Object *obj, Visitor *v, const char *name,
>>> -                       void *opaque, Error **errp)
>>> -{
>>> -    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
>>> -    uint32_t value;
>>> -
>>> -    visit_type_uint32(v, name, &value, errp);
>>> -    sev->cbitpos =3D value;
>>> -}
>>> -
>>> -static void
>>> -qsev_guest_set_reduced_phys_bits(Object *obj, Visitor *v, const char *=
name,
>>> -                                   void *opaque, Error **errp)
>>> -{
>>> -    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
>>> -    uint32_t value;
>>> -
>>> -    visit_type_uint32(v, name, &value, errp);
>>> -    sev->reduced_phys_bits =3D value;
>>> -}
>>> -
>>> -static void
>>> -qsev_guest_get_policy(Object *obj, Visitor *v, const char *name,
>>> -                      void *opaque, Error **errp)
>>> -{
>>> -    uint32_t value;
>>> -    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
>>> -
>>> -    value =3D sev->policy;
>>> -    visit_type_uint32(v, name, &value, errp);
>>> -}
>>> -
>>> -static void
>>> -qsev_guest_get_handle(Object *obj, Visitor *v, const char *name,
>>> -                      void *opaque, Error **errp)
>>> -{
>>> -    uint32_t value;
>>> -    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
>>> -
>>> -    value =3D sev->handle;
>>> -    visit_type_uint32(v, name, &value, errp);
>>> -}
>>> -
>>> -static void
>>> -qsev_guest_get_cbitpos(Object *obj, Visitor *v, const char *name,
>>> -                       void *opaque, Error **errp)
>>> -{
>>> -    uint32_t value;
>>> -    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
>>> -
>>> -    value =3D sev->cbitpos;
>>> -    visit_type_uint32(v, name, &value, errp);
>>> -}
>>> -
>>> -static void
>>> -qsev_guest_get_reduced_phys_bits(Object *obj, Visitor *v, const char *=
name,
>>> -                                   void *opaque, Error **errp)
>>> -{
>>> -    uint32_t value;
>>> -    QSevGuestInfo *sev =3D QSEV_GUEST_INFO(obj);
>>> -
>>> -    value =3D sev->reduced_phys_bits;
>>> -    visit_type_uint32(v, name, &value, errp);
>>> -}
>>> -
>>> static void
>>> qsev_guest_init(Object *obj)
>>> {
>>> @@ -361,15 +273,15 @@ qsev_guest_init(Object *obj)
>>>=20
>>>    sev->sev_device =3D g_strdup(DEFAULT_SEV_DEVICE);
>>>    sev->policy =3D DEFAULT_GUEST_POLICY;
>>> -    object_property_add(obj, "policy", "uint32", qsev_guest_get_policy=
,
>>> -                        qsev_guest_set_policy, NULL, NULL, NULL);
>>> -    object_property_add(obj, "handle", "uint32", qsev_guest_get_handle=
,
>>> -                        qsev_guest_set_handle, NULL, NULL, NULL);
>>> -    object_property_add(obj, "cbitpos", "uint32", qsev_guest_get_cbitp=
os,
>>> -                        qsev_guest_set_cbitpos, NULL, NULL, NULL);
>>> -    object_property_add(obj, "reduced-phys-bits", "uint32",
>>> -                        qsev_guest_get_reduced_phys_bits,
>>> -                        qsev_guest_set_reduced_phys_bits, NULL, NULL, =
NULL);
>>> +    object_property_add_uint32_ptr(obj, "policy", &sev->policy,
>>> +                                   OBJ_PROP_FLAG_READWRITE, NULL);
>>> +    object_property_add_uint32_ptr(obj, "handle", &sev->handle,
>>> +                                   OBJ_PROP_FLAG_READWRITE, NULL);
>>> +    object_property_add_uint32_ptr(obj, "cbitpos", &sev->cbitpos,
>>> +                                   OBJ_PROP_FLAG_READWRITE, NULL);
>>> +    object_property_add_uint32_ptr(obj, "reduced-phys-bits",
>>> +                                   &sev->reduced_phys_bits,
>>> +                                   OBJ_PROP_FLAG_READWRITE, NULL);
>>> }
>>>=20
>>> /* sev guest info */
>>>=20
>>=20
>> --=20
>> Alexey
>=20


