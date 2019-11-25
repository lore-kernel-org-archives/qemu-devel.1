Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E91DC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 16:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 590E120679
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 16:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="v0o64+26"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 590E120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZGoh-0004jL-4n
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 11:02:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iZGmQ-0003JN-MM
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:00:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iZGmO-0006lX-N5
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:00:02 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:60228)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iZGmO-0006l6-Cq
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:00:00 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAPFsbDd006205; Mon, 25 Nov 2019 07:59:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=LzSGSj9i137sqwgJ2Ruej5r5EwTkDjJrUvmPcss6994=;
 b=v0o64+26rrW8o23P00+8mjMaas/BDRrisuQVpT66Wdxl0Y8dX+yCxX7JZo35RrApTJdh
 mbevcGBQun7UwNbxER3ssH9YM4ya63s3/FMz8FRjA4bMHEMGIFHZV0zb1FJlj6Yoqvf1
 lcHOS5F72lTZqExSqlM06IsaFZLFuPaWWcv5TXoX6DQiZrOmqjf6NBoLB9wtkl/kYh/k
 /QXrZKjYoI26piJc4ooQewYEk5acxz7WFZiANZ+w7n1lhFQZx0AOoreA2JdY9NVBvutC
 Lj5tNyBNb40kaY4cav+QU8jLlnXyrwCPsWWvgTpfESaRwHRF1CZhpovf5wXTWDSTax3V dg== 
Received: from nam04-co1-obe.outbound.protection.outlook.com
 (mail-co1nam04lp2058.outbound.protection.outlook.com [104.47.45.58])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2wf4qpky97-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Nov 2019 07:59:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxfwvrU0tiLZZUMBrKmomQj4hHPkJI9SruRn6NE/YhlB7PAPJK5aQRE2PtneJbH6ou0TtjQ81GayE/u/OEDoNGan4wlq8+q6VROkGUHnAgqNZvql+CoIB1EpKHvp5TLk9ZwvcpWpDUqRZcbZ2VfTWcKVgr+hJxhDMKmaRQbk02yQrYz9BJTYWk219J/6xAMQG1IaaV+xSSbexyKU/psoDg7IlC94xH3sumbHfnt8VUn5z/bDNf0kbWahuTM09/lqnf15JVT88LnGMR6naG3Ul1fm2DVPR2Fg7hbK+h7GhsnUJojpW4zTA00XrvguVsI6OyEQrO7RJ/95nqf33m/24g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzSGSj9i137sqwgJ2Ruej5r5EwTkDjJrUvmPcss6994=;
 b=Opm/UgE4x8MrlRaVNw6puYPqPSmRqUaR7RetZ9m5rjbqQhK2fcouAXImMfdtTcb6sWj90nqRLIuHlxmaY9NREHjf73831hWz0FxF+h1pNLcVSM2SQaat7aSV3NroE1MHoAspHHo6deuLzjeuhhyuVy/utPIuvh1p9luUGTP0hMHO51zPj7VLezB3achWRWEOmoStV1qhSH8bKm47UZWGpkehZ91D+xVcvo0VKPn5toMO9w2kq2MVxwmstg+5FMsO+drO8n1z6OXjJ8Q4iLW+Cdqj7Tq7qWQ4opVFM2MNBRiRX9UomdSaFrcE7lsj9f+YrXvlW09gkR5TCK8qJosNHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2301.namprd02.prod.outlook.com (10.168.244.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Mon, 25 Nov 2019 15:59:57 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f801:763d:e7fc:6bf]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::f801:763d:e7fc:6bf%7]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 15:59:57 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] qom/object: enable setter for uint types
Thread-Topic: [PATCH] qom/object: enable setter for uint types
Thread-Index: AQHVnV6+rh+t6rwLkkm4RGhtQRwtaqeSRzoAgAnQywA=
Date: Mon, 25 Nov 2019 15:59:57 +0000
Message-ID: <6AB768BC-A65F-400F-B669-F3838A77DC52@nutanix.com>
References: <20191117072839.34390-1-felipe@nutanix.com>
 <20191119100618.GB82138@stefanha-x1.localdomain>
In-Reply-To: <20191119100618.GB82138@stefanha-x1.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40778687-f1bd-42d7-399a-08d771c084c9
x-ms-traffictypediagnostic: MWHPR02MB2301:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR02MB23010D4086C7F82E9DD32859D74A0@MWHPR02MB2301.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39860400002)(346002)(366004)(396003)(376002)(199004)(189003)(11346002)(2616005)(53546011)(71190400001)(36756003)(6506007)(478600001)(71200400001)(2906002)(6306002)(256004)(6486002)(446003)(14454004)(102836004)(6512007)(7736002)(66066001)(8936002)(99286004)(54906003)(6246003)(186003)(26005)(4326008)(81166006)(81156014)(66446008)(64756008)(5660300002)(3846002)(316002)(966005)(6916009)(76176011)(66556008)(66476007)(305945005)(229853002)(66946007)(6436002)(25786009)(76116006)(91956017)(86362001)(8676002)(33656002)(6116002)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2301;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KlveGoXU+59dnyo67NuE/Hta/SMEDAGzvWyn7lhNJlM9CSLl/fVg3l3AJ4fNAjv1OT2x9hsZhxyTsps6uxr+3y26lLaUcz8Q6Ca/q4RtPYTY2GXpUJiPenNDEremSZP5UqtSUie/Gfxcj63nYvdSj3rDN7BNATchea5Hye1K5Xlrhuz58n10iiTu1j1RxL32Vxn5JqcZAaQaALFVrCwmkEQ3/iv0+5u4L2IT3B9rGaUI7ZzauJMAWUTtScB1VtMVdyU15ZDITg0Ek+sxKO02/41uv2X1gkGlgRNygVA76ZMGJI2Kr8AylonyEWJttDNr+H5/xvwCEzGTymp9HZ/Up4XBm6lnI67T4sXoM7zh1/jD2cJUFXPewTcQqtizwKqNwGwUDTyzDutUj/2+Cqp2W1F8YX5HT4LuzdGwh8RYBuU2rl/+lm7qLkGyHHOHHurivWCrl2I5zndmHYThmEnmCb4vRrTxhgivRKipilINhtU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27374716D0EE054D8883D1C1CC91A6C6@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40778687-f1bd-42d7-399a-08d771c084c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 15:59:57.1374 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EOdWSO0zHvtje/xYi5iq/3GgkCG4gaLS3gkSyuXs0h/ML3eQSEptByalldSpWVn3HY2g6wFTviLmm7O45HdkBRY/79a2GLVJzBfdzQFj6l0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2301
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-25_04:2019-11-21,2019-11-25 signatures=0
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Daniel Berrange <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On Nov 19, 2019, at 10:06 AM, Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
>=20
> On Sun, Nov 17, 2019 at 03:50:32PM +0000, Felipe Franciosi wrote:
>> Traditionally, the uint-specific property helpers only offer getters.
>> When adding object (or class) uint types, one must therefore use the
>> generic property helper if a setter is needed.
>>=20
>> This enhances the uint-specific property helper APIs by adding a
>> 'readonly' field and modifying all users of that API to set this
>> parameter to true. If 'readonly' is false, though, the helper will add
>> an automatic setter for the value.
>>=20
>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
>> ---
>> hw/acpi/ich9.c       |   4 +-
>> hw/acpi/pcihp.c      |   6 +--
>> hw/acpi/piix4.c      |  12 +++---
>> hw/isa/lpc_ich9.c    |   4 +-
>> hw/ppc/spapr_drc.c   |   2 +-
>> include/qom/object.h |  28 ++++++++----
>> qom/object.c         | 100 ++++++++++++++++++++++++++++++++-----------
>> ui/console.c         |   3 +-
>> 8 files changed, 111 insertions(+), 48 deletions(-)
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

While cleaning up more code to use these helpers, I realised that some
setters included a check to ensure values were not overflowing. I
therefore decided to improve on this setter and send other related
changes together in the following patchset:

https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg04136.html

Please don't merge this patch and look at the patchset instead.

F.

