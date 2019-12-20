Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FBCC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 10:47:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91E542465E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 10:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="QVkcFqfX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E542465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiFof-0007xT-OU
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 05:47:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iiFnN-0006Z4-VI
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:46:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iiFnL-0007dI-Kk
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:46:08 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:39738)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iiFnL-0007Yw-7p
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:46:07 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBKAeMa1020121; Fri, 20 Dec 2019 02:46:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=B5JUyxzzZF4aLITocszqFAu6Ndb7Nwn69IZrU11ce04=;
 b=QVkcFqfX8SjpK0e2PYtZqHFWq6XoxpimGw/MZKNXibWW6BfeJ0ZDiviHNKA/Bz3/nGtR
 h9q4RxQaKWkNXs65UDRA2pcdLd4iIfn6VRNTm/ifwtoAJSRcGdtfwIAGKVHuY25Toe7I
 2FNlec7u4S/Q1GrHGbm+vymSJLidKQIu7X5oJqwaWDHo+ww7G6v3taaPZjjv3B4MGSBw
 euVpTKtbKLiF77iOf3f1lP4zUNwr1mJsdytKxWJC0WaXwpP7UjEr/Rm36uG4jUKfZo7Z
 2z/E/R3DuccdwwLzjGQd8kCH524KELkCIdsNODcc964PfiaU3c42mBQ8h6jBfBK/KE0K tA== 
Received: from nam02-bl2-obe.outbound.protection.outlook.com
 (mail-bl2nam02lp2052.outbound.protection.outlook.com [104.47.38.52])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2ww056n060-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Dec 2019 02:46:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duMN/PMdLQ0lOZj7lASnzr+ipHJzqpQUTHr7mz1XStCZtgPjwKwjoBmo0LpoSYYyb6Olto4H+EYiQVmrs6t9jUo3eT8Lxl7UTUNCtVQKuXmVlz3fOdinZcdG42Bx4fIW3sIaTcCbpyvJVWwI8w2HVeJXklG2kfQ4Q2K7uv4dSDLDeQ9GyZ12ZygNImfvf3iKJ/yIoD/qixYSfXB7zN25VGXU6nIkGems4nLQ+M8EBAa+YsPGjMHPmn/9wCt9txqLx9UPff1pl5d1MGZQbWFzZM+QRaUoC+rY5daByYK/3X/ZTUTe1odzhSW4o4zNrTjXmY72dNu9SGIGIjMI9XhP2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5JUyxzzZF4aLITocszqFAu6Ndb7Nwn69IZrU11ce04=;
 b=iikf41ARaKnmt6TIjumiVpu9fchOz7rQWTUhch/PlZSG0LYcfWwTQbCGJ0mBLMS8pDi0Kkg8U7yWWokZnt3KI0qcX9DAAORDskhuc4ZlEuaTqQS1yJG2P6wZQ7awcXHW+hWXBN9IotwT+V7y7nauJ3P0jhClwTIfOQW9dwXd9Sb1goLKjbVgAltJwZxf0Dw8BKM90Xx6Ad//Q/JofDeYbybEbi4s8GUOosJB7Pt3IMoX0PUWXEwt/U4K2Sho9m1eRlL0qFM0YhPMJ5T/QvSu6hz8wGje7Qzp3aLRcugB/Gn59CU6p6ERdPoQOhput06gwp6qo7a/+Yx2qCXkIdEPTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2685.namprd02.prod.outlook.com (10.175.50.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Fri, 20 Dec 2019 10:46:03 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029%10]) with mapi id 15.20.2559.016; Fri, 20 Dec
 2019 10:46:03 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH v4 0/4] Improve default object property_add uint helpers
Thread-Topic: [PATCH v4 0/4] Improve default object property_add uint helpers
Thread-Index: AQHVtpZ6lIuRGF0HJ0OIoqz7XKz+uqfCIrMAgAC1eYA=
Date: Fri, 20 Dec 2019 10:46:03 +0000
Message-ID: <834B69F1-93C5-40A6-915F-B0CE91BA2FCC@nutanix.com>
References: <20191219180205.25191-1-felipe@nutanix.com>
 <c6289c52-aa93-c403-57d0-7cfcfbc99d9b@ozlabs.ru>
In-Reply-To: <c6289c52-aa93-c403-57d0-7cfcfbc99d9b@ozlabs.ru>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d6dbab8-a7c3-4768-0015-08d78539cf6a
x-ms-traffictypediagnostic: MWHPR02MB2685:
x-microsoft-antispam-prvs: <MWHPR02MB26855D1BB349C3B05D34C6D2D72D0@MWHPR02MB2685.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(376002)(396003)(39860400002)(366004)(52314003)(40764003)(199004)(189003)(71200400001)(8936002)(66574012)(86362001)(36756003)(66946007)(2616005)(66446008)(64756008)(186003)(66556008)(66476007)(966005)(5660300002)(76116006)(4326008)(91956017)(478600001)(316002)(54906003)(6506007)(53546011)(26005)(6916009)(2906002)(8676002)(6512007)(6486002)(81156014)(81166006)(33656002)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2685;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9J4R9uv0MyAw+8HBPF2/wyMW3WjIzPJzVYPVmP49xd7c3H+WqO0PSx9utx5eGJMA8QS3Lx5QRi/Xy/HfxfnCy8jeiu43eHZMO+suaUZMA/L524pquaYqHNTRh+cqKiPNeGB3XHX4vM/ok+oQJJX+0TYR6aYb7auKm46q+nScTlchkpqf1IyIfyFfW6L9+MMqSA46Hp2cOEfyYhqPUY+lQ8BCyfW2VQpRIdSE6mQzp0gO64zzjWS2Y15rQjB1KclKODgFO/d4NrxKm6C/nWOhQhjQtjweEheKbfkQvvENIiEp5bJgTOJKoViuSPCwot5RdJx7LJvg0gDQ9GpYyQqiI6gxnDRjWd4BO2aW69VdgWyydwwVHz+3Rmk3DkRj6XHPGBHb1pVJ1lX+6yLtu3roucO3ODQdGZqav77E6aSvZS4vitF+11Esk+ck7sBHZij0dKCqHYYXBDV59X2VZS2TFuBT9juvZCLTV8Cg8xPdngMc+YMcyprKz8QzqZ4i+p1xqonyiIMrcCh3qELVxjz3TCbRa5qSpHs68A2AHeipYCSozRG3vYS+mNwN+xM2PQEDqIrfyNFzOUlM3rz1VPhizg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0ACCC6E341311D49A6F023B7C41A8318@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6dbab8-a7c3-4768-0015-08d78539cf6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 10:46:03.3995 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mEVifQo1/7zkH+TCe73Zua5YELZuiNKR/bWRWHtQDO7pyvNa7tBJE7cox49wHbIPa/aW0j7r47lBQEqvADYPcm5fWrfki2okLrJ7uaKGuDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2685
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-20_01:2019-12-17,2019-12-20 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Phillipe Mathieu-Daude <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

> On Dec 19, 2019, at 11:56 PM, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>=20
>=20
>=20
> On 20/12/2019 05:02, Felipe Franciosi wrote:
>> This improves the family of object_property_add_uintXX_ptr helpers by en=
abling
>> a default getter/setter only when desired. To prevent an API behavioural=
 change
>> (from clients that already used these helpers and did not want a setter)=
, we
>> add a OBJ_PROP_FLAG_READ flag that allow clients to only have a getter. =
Patch 1
>> enhances the API and modify current users.
>>=20
>> While modifying the clients of the API, a couple of improvement opportun=
ities
>> were observed in ich9. These were added in separate patches (2 and 3).
>>=20
>> Patch 3 cleans up a lot of existing code by moving various objects to th=
e
>> enhanced API. Previously, those objects had their own getters/setters th=
at only
>> updated the values without further checks. Some of them actually lacked =
a check
>> for setting overflows, which could have resulted in undesired values bei=
ng set.
>> The new default setters include a check for that, not updating the value=
s in
>> case of errors (and propagating them). If they did not provide an error
>> pointer, then that behaviour was maintained.
>=20
> A weird thing happens - when I apply patches from my mailer (thunderbird
> -> open the source -> cut-n-paste to "git am") - they fail to apply. And
> the mails themselves look suspicious - too many "MS-Exchange" and
> "X-Proofpoint" :)

I apologise for that... as you can see from below, our company's
"anti-spam" / "anti-virus" mail servers tend to mangle incoming
e-mails in ways that make it challenging to work with MLs:

>=20
> A bundle from
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__patchwork.ozlabs.o=
rg_project_qemu-2Ddevel_list_-3Fseries-3D149673&d=3DDwICaQ&c=3Ds883GpUCOChK=
OHiocYtGcg&r=3DCCrJKVC5zGot8PrnI-iYe00MdX4pgdQfMRigp14Ptmk&m=3DTxZxCvPIyfiA=
MkXeqOwUO_oYhAWFHAG66jA3SeEldzU&s=3DvMLzvHMGCJ9VeW3wSKvJVPrthKmVoud-ACf5eh6=
w2Rg&e=3D=20
> applies fine though.

Now I know why both you and Marc-Andre had problems applying my
patches: apparently our servers also mangle with outgoing e-mails too.

I heard that pulling the patches from mbox work, but I'll make sure to
post patches on Github in the future to make things easier for others.
I've already asked them to look into this and whitelist e-mails on
various criteria.

Thanks for your help in making sure these patches work for you despite
the extra hurdles!

F.

>=20
>=20
> Anyway, this works on powerpc. Thanks,
>=20
>=20
>=20
>>=20
>> Felipe Franciosi (4):
>>  qom/object: enable setter for uint types
>>  ich9: fix getter type for sci_int property
>>  ich9: Simplify ich9_lpc_initfn
>>  qom/object: Use common get/set uint helpers
>>=20
>> hw/acpi/ich9.c       |  99 ++------------------
>> hw/acpi/pcihp.c      |   7 +-
>> hw/acpi/piix4.c      |  12 +--
>> hw/isa/lpc_ich9.c    |  27 ++----
>> hw/misc/edu.c        |  13 +--
>> hw/pci-host/q35.c    |  14 +--
>> hw/ppc/spapr.c       |  18 +---
>> hw/ppc/spapr_drc.c   |   3 +-
>> include/qom/object.h |  44 +++++++--
>> memory.c             |  15 +--
>> qom/object.c         | 216 ++++++++++++++++++++++++++++++++++++++-----
>> target/arm/cpu.c     |  22 +----
>> target/i386/sev.c    | 106 ++-------------------
>> ui/console.c         |   4 +-
>> 14 files changed, 282 insertions(+), 318 deletions(-)
>>=20
>=20
> --=20
> Alexey


