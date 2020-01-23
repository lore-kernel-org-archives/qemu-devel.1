Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EC8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 21:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7467E21835
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 21:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="jtvj1fI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7467E21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iujj3-00061j-NU
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 16:09:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iujhu-0005A7-BH
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 16:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iujhs-0005cN-My
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 16:08:05 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:44730)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>)
 id 1iujhs-0005a9-GV; Thu, 23 Jan 2020 16:08:04 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00NL5bGq021738; Thu, 23 Jan 2020 13:07:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=XShNIlWzgvn3I74MY+da6WfmkwP+V6z3yPHWOVaVIVo=;
 b=jtvj1fI/fRFYxy+SkTghTT8IbLYLuBN4AuanVaBJyEdvqAiC4Gu6PqIAJ3smV+Sg9cSd
 sCgZObNOpnFq16o8XLD6EcZhBI5hIWoy0Om87L6JSYujQempkkpN7EcCsFFjy37xwRl7
 d4C6zcei474GA7Rgwl0auRJn7/R7lDwOTsQfPhg8VK4+s/smZ/TW9Pd+JFp8GjcYDMht
 ewrHRdrK8Q+AVjLB0Z+iq5EKQyZ69PeeQCLmMLYYwXsJA/OsOx8uJ5C5kW7YUvu7nWEg
 GImPCOQaglKIvoe5mTOId21LmzKQ4cXK7vQRO3neRelT/Aov4RvkSe+yXcwm7d0TNO6r ew== 
Received: from nam04-co1-obe.outbound.protection.outlook.com
 (mail-co1nam04lp2057.outbound.protection.outlook.com [104.47.45.57])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2xm2e6bpd4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jan 2020 13:07:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAmYxX6nWeObyaNvsGw6uIcvsOQNQvVip3Jr4gFu+LyEV5mm60DCwCa04V9iyjmmhOA7/IYhPImapXP/jdsU7CzrmnrtSLpP1zgco2kRAne5rDEqARzZLHumGEahbeaSTL/TxcQxE43jIrhJnQfUKZrPbocpL+jdH4vlmnGSZ6jOVys06f6UAe5+zjObuIQvv90RFr3/5pcU8HJE3Py/2XvO1J7wEEJ/Zv3lFKb7HadngGXNyXOS0Z3QC2yNuXjn2CjgoL+he/JvRb7+yoVAE6NDe2uYU4UuGn7Hv9onQC0IoAePoFWvrktwnyWO4KoRoX0XHNSwm67mkQNjxtAuOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XShNIlWzgvn3I74MY+da6WfmkwP+V6z3yPHWOVaVIVo=;
 b=dvHurl7QCPWFb+iSX2SP+RncMJs//4r8DM1ZyRLyzVOLFzmKrF032DJeuLyrK/PTG8Nk/24fbYCWE82qy7rxuAPzQRhpGDmZ3ZAQNZ9F8fqSKEwnClO/Zbllnv0yk2EPrnBKXpzs4mWpDx3pI5CfvJ8in3wGc678oEGOmFBrHqzqQ9K5YDacNmrZNycKFSiGLRW8syR89Vq9aUaMljOjKeYT7nGGOEsqpry3Ho7xmLW4TcLAwpPeTnwtUDZYxWIOKZt3elB+OBpCJbl9Nz2V3iSFjkdJ2j3FwODsSEr+iN00QTVRDo65AyHZ4ypSfaHNWnHIPFKsR2m7ylPv8no0AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2671.namprd02.prod.outlook.com (10.175.49.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.24; Thu, 23 Jan 2020 21:07:53 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029%10]) with mapi id 15.20.2644.028; Thu, 23 Jan
 2020 21:07:53 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH] iscsi: Don't access non-existent
 scsi_lba_status_descriptor
Thread-Topic: [PATCH] iscsi: Don't access non-existent
 scsi_lba_status_descriptor
Thread-Index: AQHV0hW67ghj9TBwskeYoa3E4EVIUKf4tdAAgAAIXIA=
Date: Thu, 23 Jan 2020 21:07:53 +0000
Message-ID: <BC9F83B4-E47C-43E5-9319-A40F7E771CC4@nutanix.com>
References: <20200123170544.30117-1-kwolf@redhat.com>
 <dd893da2-2c1a-ff9f-a176-dfda1cc229c4@redhat.com>
In-Reply-To: <dd893da2-2c1a-ff9f-a176-dfda1cc229c4@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.9.225.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c9d61de-e1eb-4806-c2ae-08d7a048500c
x-ms-traffictypediagnostic: MWHPR02MB2671:
x-microsoft-antispam-prvs: <MWHPR02MB2671E9ECBA34213A250AA941D70F0@MWHPR02MB2671.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39860400002)(136003)(346002)(376002)(366004)(189003)(199004)(8936002)(76116006)(53546011)(8676002)(91956017)(64756008)(66476007)(26005)(5660300002)(4326008)(2616005)(6506007)(66556008)(66946007)(186003)(2906002)(66446008)(81156014)(81166006)(6512007)(6486002)(54906003)(966005)(478600001)(71200400001)(36756003)(33656002)(316002)(6916009)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2671;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ezyi3jpUD8t+iP1C6dXrpxCPz4r4w5V6L+WpNUkm6kR7zkc17BY7mDdcdGAVCowZxhPtSdw81mo/NQJvfuxr42HxdthZIxQxH/LaRIcSqzvCvIScyFDBtFJ6pzH1v2/GyNKStbL6R3cYYdsKDsyS+xm5biEtF35A1c8nQpVvC+GIIixr1P4+9o9aPBdy+2UpH4JKvqD1QA8mTp8kRXZonA4O4zXxQRnL4a2Gpa+zn5piUGCabCXutkMubaMgqNAt/33jS/dEg5iKH1gDHUESLEjAnmGd/aawZ+GxwO034oPAevuMsTHZqGYrYBLjqbZolj1b2KMg56wX2K0psqun5ggcjD1WF2xmz20IjVXU+ATm0CqgDpK/VSQHaT3BSLrsV7w/9w32JM0nbUW7XaOyc6P85V/YCvapq1RhxwZB46GGfo0F0RIC+nkrWWfjkTQJE7gjauOl7yYNU3HMTqndLniJdPSayrIya55/wXf2DWg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4AB4151168D56C4EAE148188B6D01BF0@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9d61de-e1eb-4806-c2ae-08d7a048500c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 21:07:53.6098 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +EHBfh6EscPexA5Rvsn/p3Z71lMLOfsEWHXuDvBv8yhEywv71mREXnVv5JylpKMIRF/r6QlRr3s7O0XiEoE2eRkYL9jRqpq9S2BD968hSh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2671
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-23_12:2020-01-23,
 2020-01-23 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "pl@kamp.de" <pl@kamp.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ronniesahlberg@gmail.com" <ronniesahlberg@gmail.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Jan 23, 2020, at 8:37 PM, John Snow <jsnow@redhat.com> wrote:
>=20
>=20
>=20
> On 1/23/20 12:05 PM, Kevin Wolf wrote:
>> In iscsi_co_block_status(), we may have received num_descriptors =3D=3D =
0
>> from the iscsi server. Therefore, we can't unconditionally access
>> lbas->descriptors[0]. Add the missing check.
>>=20
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>> block/iscsi.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/block/iscsi.c b/block/iscsi.c
>> index cbd57294ab..c8feaa2f0e 100644
>> --- a/block/iscsi.c
>> +++ b/block/iscsi.c
>> @@ -753,7 +753,7 @@ retry:
>>     }
>>=20
>>     lbas =3D scsi_datain_unmarshall(iTask.task);
>> -    if (lbas =3D=3D NULL) {
>> +    if (lbas =3D=3D NULL || lbas->num_descriptors =3D=3D 0) {
>>         ret =3D -EIO;
>>         goto out_unlock;
>>     }
>>=20
>=20
> Naive question: Does the specification allow for such a response? Is
> this inherently an error?

The spec doesn't say, but libiscsi (which Qemu should trust) may
return zero for num_descriptors with certain server responses (which
no one should trust).

https://github.com/sahlberg/libiscsi/blob/master/lib/scsi-lowlevel.c#L845

F.

>=20
> Anyway, this is better than accessing junk memory, so:
>=20
> Reviewed-by: John Snow <jsnow@redhat.com>


