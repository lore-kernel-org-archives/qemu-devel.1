Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FED8C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 05:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3618E20720
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 05:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="ZNHFsxvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3618E20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iza6t-0003wC-8k
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 00:53:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1iza6I-0003Xh-Bp
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 00:53:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ani.sinha@nutanix.com>) id 1iza6G-00013y-SR
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 00:53:17 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:59328)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ani.sinha@nutanix.com>)
 id 1iza6G-0000wd-Id
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 00:53:16 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0165ki2c006306; Wed, 5 Feb 2020 21:53:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=xa9s/t0g4fipSuvcLc5ZvnvCsOIF+3x1VfqmHAYl/Ps=;
 b=ZNHFsxvJ5fZtjLkxcAYrCg11v4IwL+pyvhY+2kdvyXH5eI9TARxgPwFlbhL+iY5m8xwN
 YNoPQXd1xLq4bVQpjsRxpDzwMvNjBoT4UO5s4OW/lydlvuLb6U+8xzz18Uphjy7Hp9a1
 T9igIRBX4TnncSXAT0oce8p9wousVE/sc2bjwRebXsybWlqYmPiFrDyzX5Wl97swnxH4
 BSIcBSQMbKygAAOfIKd98Xma6LDiVwOj692gob1UZaHDL0ElFah10oUXHQwAVgY5RiYr
 Q2PuXu2I24zzn8oRMDjHRmRrq1JyxvtoBDtRDZMlirN2dZRgo15wbfdfW6y3RLXrLxgn kw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2xyhnc3gq8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Feb 2020 21:53:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjGoIymBwWh6letAp4mqni4rlmdV/fPBA32lRz0pnyHk85zYyvcQFpr9yHNd1f17gKFkhLxzbmWLCgkXZyTZ3PLjWTcQJGzq/73nyLA542rZXxrW2cWzgPQ5VDCClv6BjksJERM8Ok/rHbzad2qCkNELNtKTmFnHXLjhlEGCga7Z3+azBzDqKUuPztuUltOxPaefcUwlafHLABv9rz71ykjGqg5B5OSiJzOyhUlHwQGkkOd1pqYxrZBDtbo3YQP0IXNfU7xJWQAYw954ndm3TaEloWuEx/V3gytMTsq1sLEHWroBwfOMJpRtl1yyVqnBA+WxgugIS0FwXLhIZhrRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xa9s/t0g4fipSuvcLc5ZvnvCsOIF+3x1VfqmHAYl/Ps=;
 b=nvj1Hfv+t61fwjoY9FzZJm4e2dlyrBQ2Laf2ebk781dxXwp+YK66XL+roBBDA+roty4hPfw8FeJWd6NV/iH2q+zzBkTlp25fLgnOBrBN/983DKi6ZtPG/y+8HsTH1fg8w1IH2gCa8lK+YGSyZGQ9pXDslayVXdRPqmwkC3MI99giB0Tsn2kpidBKCElTFnmnIKWTORF5rk5SZULO7YwPeppSvmg7gJcFfx+kVlkVS53TXvBE/XJ2TyR/jMHYzDxi5wMpAB9o6aBsnFV8wNTWAWy+Z9uClfNi7DXNB9eI6UFVJeQQgRCgL7lsjPxVOnbUDlMDIAk3Inhod/V6gsEcOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB6303.namprd02.prod.outlook.com (52.132.174.13) by
 MN2PR02MB5998.namprd02.prod.outlook.com (20.179.99.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Thu, 6 Feb 2020 05:53:08 +0000
Received: from MN2PR02MB6303.namprd02.prod.outlook.com
 ([fe80::38a1:eb0a:926a:20ad]) by MN2PR02MB6303.namprd02.prod.outlook.com
 ([fe80::38a1:eb0a:926a:20ad%5]) with mapi id 15.20.2707.023; Thu, 6 Feb 2020
 05:53:08 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: "Moger, Babu" <Babu.Moger@amd.com>
Subject: Re: [PATCH] i386: pass CLZERO to guests with EPYC CPU model on AMD
 ZEN platform
Thread-Topic: [PATCH] i386: pass CLZERO to guests with EPYC CPU model on AMD
 ZEN platform
Thread-Index: AQHVtYKm5uylcpuSJ0uEmLmhvuRW56e/yJSAgAA3UQCAM5WrAIAZ6R6AgAAXEQCAAGC8AIAAAeiA
Date: Thu, 6 Feb 2020 05:53:08 +0000
Message-ID: <60B21C9A-30BE-4DC0-8A1B-0BC7757BA9D7@nutanix.com>
References: <1576659933-37123-1-git-send-email-ani.sinha@nutanix.com>
 <2883fd0e-191a-c5a4-be1c-04442c8de1c9@redhat.com>
 <20191218151144.GN498046@habkost.net>
 <D67E411E-4398-4F1B-A397-E637BCD4F666@nutanix.com>
 <20200205223731.GY25446@habkost.net>
 <CY4PR12MB157489B70F2AD26C97779E40951D0@CY4PR12MB1574.namprd12.prod.outlook.com>
 <FD52354F-2038-4829-A7D8-7513D601A2FF@nutanix.com>
In-Reply-To: <FD52354F-2038-4829-A7D8-7513D601A2FF@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [115.110.205.85]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e41dbd83-2137-405d-a556-08d7aac8d7b2
x-ms-traffictypediagnostic: MN2PR02MB5998:
x-microsoft-antispam-prvs: <MN2PR02MB5998E350A1F953617BB018EBF11D0@MN2PR02MB5998.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:612;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(376002)(39860400002)(346002)(136003)(189003)(199004)(26005)(4326008)(2906002)(36756003)(6512007)(186003)(71200400001)(54906003)(66556008)(76116006)(66476007)(64756008)(66446008)(66946007)(91956017)(316002)(966005)(5660300002)(6486002)(478600001)(4744005)(2616005)(8936002)(44832011)(8676002)(6506007)(53546011)(86362001)(6916009)(81156014)(81166006)(33656002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR02MB5998;
 H:MN2PR02MB6303.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: goGUJ2SijYmUZ089uPLNWjuajD89/bjg1Ih3Cs7X6gCBz9kvuL3SMg6LF5ocDXMFTo8AM86d5YYPPJKGHdJfUJiiCMkJ/MWF+9wCV+Ub25yTYZu2Tbqk3x5KIcxU7MvmO0JwA0EIYHPlU5SgJAc6aa6Yq/NmC+iT/jArTrMWDwSml9nYpgviW0PQ9sJ8zIgPV621IyP5l9Khv5ujSEIsqBwBGm0vhPZd00JeHOhQvLcUDVTS3nUslfA2FRPmV6j/jJjqUhYxkWsDjRRiU6zfLDG+k27lbGImKb0ZM7CpDbPFSTyWYiLAcLGkdT8xQ6IcgaCKg6TqZOh3VHZh566+kAObdIP8KL5ZuhVh2W//Ip8Ich24rgqPx2jQBy4nbaqHRdCL+M6lr0xeEKFvP9Q+hC6erjCRhlHagOqSWso+YPDL+p7LzwkTFOndn6Ucb5Kp9uo4Vvy8w8f7Mx8H2jfdxDp6XR67WkHYmyYTVBwfJP8RVIOe8ChUI13JJQUjUQk5X65XeiQXaSfhjUcQX5/8VA==
x-ms-exchange-antispam-messagedata: AYjFFo76zd7x9/lvHSTS1+CMKMxk0ql/gqopUi3FkAOs3hAy+VXvxImYJOTlXljoC4tvMwb3rMg88G2fLIhhnctJiy5J21XWiMlNI4CslZlxBpdziSM1DQjM2wcPbz1w7yFAcO2yFFJaFyjr9TdN0w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B8F58FA4AAFB143BC24414A1EA544ED@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41dbd83-2137-405d-a556-08d7aac8d7b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 05:53:08.4475 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qpCGx7pvRHWpzLqkQS4V4opZEbgi2GyqqEhFwVyXMGT2h30D/+Zgj43c0D/YKbBu9udn/duEWoxvFz/gr4Gd5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5998
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-05_06:2020-02-04,
 2020-02-05 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Singh, Brijesh" <brijesh.singh@amd.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gT24gRmViIDYsIDIwMjAsIGF0IDExOjE2IEFNLCBBbmkgU2luaGEgPGFuaS5zaW5oYUBu
dXRhbml4LmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+PiBPbiBGZWIgNiwgMjAyMCwgYXQgNToz
MCBBTSwgTW9nZXIsIEJhYnUgPEJhYnUuTW9nZXJAYW1kLmNvbT4gd3JvdGU6DQo+PiANCj4+IEFu
aSwgSSBhbSBhbHJlYWR5IHdvcmtpbmcgb24gaXQuDQo+IA0KPiBXb3csIEkgc2VlIGEgd2hvbGUg
bmV3IEFNRC1Sb21lIENQVSBtb2RlbCB3aXRoIGl04oCZcyBvd24gY2FjaGUgaW5mbyBkYXRhIDog
DQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzE1NzMxNDk2NjMxMi4y
MzgyOC4xNzY4NDgyMTY2NjMzODA5MzkxMC5zdGdpdEBuYXBsZXMtYmFidS5hbWQuY29tLw0KDQpE
byB5b3UgdGhpbmsgdGhlIFJPTUUgc3BlY2lmaWMgZ3Vlc3QgY3B1IGNhY2hlIGRhdGEgd2lsbCBo
YXZlIHNpZ25pZmljYW50IGltcGFjdCBvbiBwZXJmb3JtYW5jZT8NCg0KPiANCj4gVGhhbmtzIQ0K
PiANCj4gYW5pDQo+IA0KDQo=

