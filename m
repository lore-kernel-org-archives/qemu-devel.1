Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85938C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 05:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ED1120838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 05:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="TIBH4qZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED1120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iza0j-0002K7-G1
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 00:47:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38482)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1izZzk-0001ko-F6
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 00:46:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ani.sinha@nutanix.com>) id 1izZzj-0005mY-11
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 00:46:32 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:63476)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ani.sinha@nutanix.com>)
 id 1izZzi-0005Y8-Mv
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 00:46:30 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0165gR2B021288; Wed, 5 Feb 2020 21:46:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=/yVxvBs/Q7PGzJuiEGckN7nCmf2JI0CoMrqpxDHD26E=;
 b=TIBH4qZHQO4dEiy+mHBuPoI/m05SSXBXTDbYjG1h/o6AIRvJW/kA/eBed++meSx9uEkz
 9+V5UieAHsQjpJ57fyjLQlIR3lkU9nexxL/X/eFjMZOX/RdQ13MBByN8XsiXYPaPqx0Z
 V9Xx84dJTvwMC5j0a89uI4UXKJNSKwH8YglKH+ScqHo22q0FZXgsZCsh5RIRn9zKLMwG
 rWdqZgtzbhz8A2FpIxZK1mX4gJNs/1Krh0MTMeEW1oPuxtYZa4i+DDZL+SfLv5Cv45b3
 klct30ZM6g4Wi13onsTH8KJVMW5OfxcrnnVVIVLcKZ+F3ed6WDog4Knoa72F/h7m3x9/ Sw== 
Received: from nam02-bl2-obe.outbound.protection.outlook.com
 (mail-bl2nam02lp2050.outbound.protection.outlook.com [104.47.38.50])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2xyhn8bgwy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Feb 2020 21:46:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/D8ic0cajkISZZEEz8hJMhbeV6SXd8tCVgfCJ9HUujWX1yV9Qhj+ntvtoP5b2G9D+8O9KdFxnYRDnX2NqRQDcDbH1PS6C3/vNS2MJuOPxK+8SakeZe763Uv0NAyfdBQZAx1qA9e3/oTAW4L2Z2WECwHY6cdIrgtl8v/4WJ7Qc9Yd6QAGx/eJpjrov4mqLxmp8fTSuv6el4bazZIb15OwoGLtC1+lf5Id6u/YXfWAmCvUlyeqXCLAm1Nwwq6RyRWAm/BiR8d4NAG81xyuISAIPZqmCs3BayyW0/i46yMN1yv0WVoe594P2deRTwwUhM9VSKyU/UCuk4z/T7YJoMhbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yVxvBs/Q7PGzJuiEGckN7nCmf2JI0CoMrqpxDHD26E=;
 b=XUb3KK/1amCH9ee1IYD3T7mrgnT6kbIOgAPFoRb5iCvjLpk6628eYUXTPy+nMQ0ywx+aJMREffFOiQMvvwmN5FJOyNciIhhPZ0N5zyE8eAxgjJQqbLnmZcsqGO+sYqMw9v82RPanwzWbXuqhUxwKtZXG8l/vc5IG0+3x79QFStKx7XlggzUq0TY4Pt1/Z8zHynVCTPuyrRZU/4RL7pvvzmRL4HtwSwDe3Hq+ZS5ZQ/iqhTSR6D+lYllOanz2xbbBKdUFRiNEonhdHFBhpcXwxcJk4vhs0PyFKatqdKVxoNzNaTacF7R5XY35fBDaJCq2JwMXAef4W2G+SrdWJvmuUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB6303.namprd02.prod.outlook.com (52.132.174.13) by
 MN2PR02MB7085.namprd02.prod.outlook.com (20.180.26.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Thu, 6 Feb 2020 05:46:19 +0000
Received: from MN2PR02MB6303.namprd02.prod.outlook.com
 ([fe80::38a1:eb0a:926a:20ad]) by MN2PR02MB6303.namprd02.prod.outlook.com
 ([fe80::38a1:eb0a:926a:20ad%5]) with mapi id 15.20.2707.023; Thu, 6 Feb 2020
 05:46:19 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: "Moger, Babu" <Babu.Moger@amd.com>
Subject: Re: [PATCH] i386: pass CLZERO to guests with EPYC CPU model on AMD
 ZEN platform
Thread-Topic: [PATCH] i386: pass CLZERO to guests with EPYC CPU model on AMD
 ZEN platform
Thread-Index: AQHVtYKm5uylcpuSJ0uEmLmhvuRW56e/yJSAgAA3UQCAM5WrAIAZ6R6AgAAXEQCAAGC8AA==
Date: Thu, 6 Feb 2020 05:46:19 +0000
Message-ID: <FD52354F-2038-4829-A7D8-7513D601A2FF@nutanix.com>
References: <1576659933-37123-1-git-send-email-ani.sinha@nutanix.com>
 <2883fd0e-191a-c5a4-be1c-04442c8de1c9@redhat.com>
 <20191218151144.GN498046@habkost.net>
 <D67E411E-4398-4F1B-A397-E637BCD4F666@nutanix.com>
 <20200205223731.GY25446@habkost.net>
 <CY4PR12MB157489B70F2AD26C97779E40951D0@CY4PR12MB1574.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB157489B70F2AD26C97779E40951D0@CY4PR12MB1574.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [115.110.205.85]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ee2630f-a71d-4d89-ee9e-08d7aac7e413
x-ms-traffictypediagnostic: MN2PR02MB7085:
x-microsoft-antispam-prvs: <MN2PR02MB7085BF3A683C128216FA5A6AF11D0@MN2PR02MB7085.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:514;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(396003)(39860400002)(376002)(346002)(199004)(189003)(4326008)(36756003)(186003)(6506007)(53546011)(54906003)(558084003)(26005)(316002)(6916009)(81166006)(8676002)(8936002)(81156014)(5660300002)(6512007)(2906002)(86362001)(71200400001)(66446008)(66556008)(33656002)(91956017)(66476007)(66946007)(6486002)(64756008)(76116006)(2616005)(44832011)(478600001)(966005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR02MB7085;
 H:MN2PR02MB6303.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5rfJCo6iI1v/T2TqPhcP2TNlu3HCXWazG1LXJJHFvqRZ142ROBHdPmMRtSRheEQGMP//HkO8pRqe/ZG5xmRj9dpiLyXSwf3oxeu/o1T/crL1zx52Xho2NlPt6QUtdqE7UQssC94Jm080/RgshbI4evGgmKDvapvDOz2J6m6SNJw+J1XeaZ6Q3w6t6Jt1HEPo3kuFTZ89/S6EGiV2XFPs0Fd4XmJd8JNPVY1X71HwKxYMHqWWYFVa46L0GHaLuWh02CuD/qKZeLmAr9OSCOjlZIqgewngldsM8P5FPqytqOvVcmRNU3r+gI11Scgtu34TPMoN5Nd+I3IjnYpgvSf3vioKaI0IyfFPesESmCriXk4dt0vwarY1kFTD6celODBfexux6b3Wyf905T7ATaqSp4+elZ2Q2CRvFgwLLXGqdiOho9AZwAM0HwbJ7xp6EjhuK4WKGVFWgpDB6KIqDFN7czCl3/RTei/a+1LPcJZjRBFEUMSiQECiAnIg/BIkro7iZ+hbJhgfh8rytrrChLJ4mQ==
x-ms-exchange-antispam-messagedata: yRS9jgPWUJeAxx3I4mbpuMZiWKN0mMgzfBocAXL0x9EwRhrQVqnyTm+FM8WA1leeSwlm9cZ1fZaQnaY0wLr3yUVc29PxoMh7aAWmedRL22K2LvFhgnSlPLQri8ywKQoV4tS/xr/XEDoCHYo8vT7KMw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE487CAF22C9C049A5F36450E49AE16B@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee2630f-a71d-4d89-ee9e-08d7aac7e413
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 05:46:19.5501 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /IWcVESg8RmvK+LAJky6bUYh3Lom92oYato5UOtb6Bz31gQsr/jxy3Clo0nIL1ZjWwoZ7zZ4FHTTbPfpNkMfKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7085
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

DQoNCj4gT24gRmViIDYsIDIwMjAsIGF0IDU6MzAgQU0sIE1vZ2VyLCBCYWJ1IDxCYWJ1Lk1vZ2Vy
QGFtZC5jb20+IHdyb3RlOg0KPiANCj4gQW5pLCBJIGFtIGFscmVhZHkgd29ya2luZyBvbiBpdC4N
Cg0KV293LCBJIHNlZSBhIHdob2xlIG5ldyBBTUQtUm9tZSBDUFUgbW9kZWwgd2l0aCBpdOKAmXMg
b3duIGNhY2hlIGluZm8gZGF0YSA6IA0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRl
dmVsLzE1NzMxNDk2NjMxMi4yMzgyOC4xNzY4NDgyMTY2NjMzODA5MzkxMC5zdGdpdEBuYXBsZXMt
YmFidS5hbWQuY29tLw0KDQpUaGFua3MhDQoNCmFuaQ0KDQo=

