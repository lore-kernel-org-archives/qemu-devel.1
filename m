Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EC6C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 08:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 251F3206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 08:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="KPqoKVMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251F3206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijJQz-0002bL-92
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 03:51:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44143)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1ijJQL-0002AC-TC
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 03:50:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ani.sinha@nutanix.com>) id 1ijJQK-0000iT-1p
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 03:50:45 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:1750)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ani.sinha@nutanix.com>)
 id 1ijJQJ-0000ey-Pk
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 03:50:43 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBN8mTqL027664; Mon, 23 Dec 2019 00:50:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=6mOaKe5lgOgorUxVZRgDO5GTjPv2bXMwHUAP2wQHGhc=;
 b=KPqoKVMp5JinUfVTHAEVMmAVGAWCLvmefVELQUD0zuI5xj96ajKNLWCRqaNHA1P5bZy9
 WlEkyrzzFhkY3SDlqCrfz2/0HWz8u71bAfclt69sn0TJJoU0xsLe6Y1H69WWm68J0adh
 A7eHkN5tvo8qeFge7jevzhRnEM/eNi4pQAo/WE0PXTc3+Ab4shsqgGxy1QbXY8fz6sZj
 WseBjC5xPETIzAlX8ynvG87JkmFcr52meaJA8rDcDeJK4E8Zdu8oeWsw99rBa8LcSWkb
 hjOoHlHIzXn012UHrpHY4gOHqD/lRhIgPvtYif2N1w67nF/66x9co7jTqpYf6l0Fl0v1 Fw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2x1kt6amca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Dec 2019 00:50:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xudv/+mRivvRaY/H74OlRk8NNSviVvOvrO9JEurJCxejfXI6eGYJ2o3owcn7HOqVsz8e49dWWey9c77FS1XMNURBuqs5MrwvtR3edBmNBYpl3PKCVQnMXzQd1mEgSk3Lluls1EwE09gXRuPB88LSYzpOl8FxfGzELSMlCC1xIYtdi9SntYK8y+QNklqVI8j+X1ZNVqq3ZwHJLWoC+MLERKwzFaHXJSLi7uWEDXjx+J4T5iPmWpD/guXF4PLlg9xK0U5qXz1dBUmtKtXa85fjZgP1dYJtIo0+EOgOvX86+U4SIEt3WOpTAh5byCcimBpF210lezXjcoPolKcHqC+fvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mOaKe5lgOgorUxVZRgDO5GTjPv2bXMwHUAP2wQHGhc=;
 b=AGXjTgRuqiIS+4iHuMKoAHuBuZp0ilXqYjy2/mrKqVj2SDNxn/byo2nyVtUoLixeCRFHTRtX4qK7y0c+YoGfvrmwkupO7T5MP640hSqvznG80R57HWBek3kvJl+ZedI9uokbjVENynt/l5/wjd9pfwSBwe4mgvKyrg25XTMFDldJt4bxpih3o/Y2JEOey12e7WCr3t1/IEvdaqca0ZSQZH9HyvKwzuIu0OF6pBTrvePCg/hnRJDSaMfS8YH0uC08Ucgpj8F5UarqwxjaZIKFoevWIc4s2Q74kOr1a+FcQ/y3nBpkb110KF+ZtNq8VMt6kDPaS04ClefpK0Lt5yaccA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB6303.namprd02.prod.outlook.com (52.132.175.28) by
 MN2PR02MB6640.namprd02.prod.outlook.com (10.255.224.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.20; Mon, 23 Dec 2019 08:50:40 +0000
Received: from MN2PR02MB6303.namprd02.prod.outlook.com
 ([fe80::e506:4fa8:c846:e53c]) by MN2PR02MB6303.namprd02.prod.outlook.com
 ([fe80::e506:4fa8:c846:e53c%3]) with mapi id 15.20.2559.017; Mon, 23 Dec 2019
 08:50:40 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] i386: pass CLZERO to guests with EPYC CPU model on AMD
 ZEN platform
Thread-Topic: [PATCH] i386: pass CLZERO to guests with EPYC CPU model on AMD
 ZEN platform
Thread-Index: AQHVtYKm5uylcpuSJ0uEmLmhvuRW56e/yJSAgAYAW4CAAAvdAIABkhyAgAAKKYA=
Date: Mon, 23 Dec 2019 08:50:40 +0000
Message-ID: <DC7E39B8-A4F7-4DA0-B93B-C755C0C1D886@nutanix.com>
References: <1576659933-37123-1-git-send-email-ani.sinha@nutanix.com>
 <2883fd0e-191a-c5a4-be1c-04442c8de1c9@redhat.com>
 <7452FAE9-ACDF-495E-AE5A-8A8ED9488B03@nutanix.com>
 <CABgObfaNtUsDiQ8SrwzsTmJEkqa14RiDyUmxeeAgNwYHUm2F7w@mail.gmail.com>
 <1E885A11-2534-4801-B54E-F8E68A514ACA@nutanix.com>
In-Reply-To: <1E885A11-2534-4801-B54E-F8E68A514ACA@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [115.96.107.217]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 336b905f-d5af-43f1-036a-08d787853018
x-ms-traffictypediagnostic: MN2PR02MB6640:
x-microsoft-antispam-prvs: <MN2PR02MB66406DE046E3A571D95F9325F12E0@MN2PR02MB6640.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0260457E99
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39860400002)(27584003)(199004)(189003)(66446008)(66556008)(91956017)(64756008)(8936002)(8676002)(81156014)(2616005)(66946007)(66476007)(76116006)(81166006)(186003)(966005)(5660300002)(2906002)(4744005)(26005)(86362001)(33656002)(316002)(6512007)(36756003)(478600001)(53546011)(6506007)(6486002)(54906003)(44832011)(71200400001)(4326008)(6916009)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR02MB6640;
 H:MN2PR02MB6303.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k186acngM6k6NqUeKRTylTQnlm/tcFbLC3eRdkPZ4L0XhXbZxTZ58F/YH9QuaZB5wDZNF1sxQZWex9Bhcxk/4KdhvAhEyWf70WuYNVjY8MT0SDdg5mUrUxN3CpKBPXUaSaWKbruhZBuUZtKaNBhijQWHq09xbQ5hks9Nnfg97A7oftD85BXaGa0kPF/abKupZu5GJTwxQyP9+cvyPvQt5KUcxoiHOSsKBHVPYeddQeXuR5rU8CftWIZvqfHdN7ex8FbuLVDQY9sETCsBbKSUkW8h+Jfyth3xb0QTcB/WHtYZ29dUa5zkbLy7oYikTNxy0c5iSbGbHAUuSKiAInTUvm6WfAZMD9/LlxswUgAMQYT2OGZ4mcOCAkgcbGADKKHDLuvWq/tNIZHumqH7//gVpmhR23vjBAe4szHFbCPjk2/cBRXXyu+opEgvhzbePcDokjeE8TtvMH4oVCRm7vPDpDoZwChte/9F1rZTxLXNuy/VuvzZ/Ot6Dfsc4KvPQClr3i2YSCjIgenbaoG12Hr9Uef0hCUfYbpRib2jEQydiLHiiZG1Ai+RX9Fab9UCcZS8
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <26E9BA921F59D54D9721D9E3AD14EE02@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 336b905f-d5af-43f1-036a-08d787853018
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2019 08:50:40.1795 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IUsOmKS0yPnAGpVIYdxGHLNxwTpklGOrBOS/Wxi/jstcgbTWEr46QIxwgDiynUcMdlFkRiqQk8L77OWadRpiww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6640
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-23_03:2019-12-17,2019-12-23 signatures=0
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Habkost,
 Eduardo" <ehabkost@redhat.com>, rth <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gT24gRGVjIDIzLCAyMDE5LCBhdCAxOjQ0IFBNLCBBbmkgU2luaGEgPGFuaS5zaW5oYUBu
dXRhbml4LmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+PiBPbiBEZWMgMjIsIDIwMTksIGF0IDE6
NDUgUE0sIFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4gDQo+
PiANCj4+IA0KPj4gSWwgZG9tIDIyIGRpYyAyMDE5LCAwODo0OSBBbmkgU2luaGEgPGFuaS5zaW5o
YUBudXRhbml4LmNvbT4gaGEgc2NyaXR0bzoNCj4+IA0KPj4gUGluZyDigKYNCj4+IA0KPj4gV2h5
IHBpbmc/IFlvdSBnb3QgcXVlc3Rpb25zIGZyb20gRWR1YXJkbywgc28geW91IG5lZWQgdG8gYW5z
d2VyIHRoZW0gYW5kL29yIHNlbmQgYSBmaXhlZCB2ZXJzaW9uIG9mIHRoZSBwYXRjaC4NCj4+IA0K
PiANCj4gDQo+IE1heWJlIGhlIHJlc3BvbmRlZCBwcml2YXRlbHkgYnV0IEkgZGlkIG5vdCBnZXQg
YW55IHF1ZXN0aW9ucyBmcm9tIEVkdWFyZG8uDQo+IA0KDQpPayBJIHNlZSBoaXMgcmVzcG9uc2Ug
aW4gdGhlIG1haWxpbmcgbGlzdCBhcmNoaXZlczoNCmh0dHBzOi8vbGlzdHMuZ251Lm9yZy9hcmNo
aXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE5LTEyL21zZzAzOTI3Lmh0bWwNCg0KSSBnZW5lcmFsbHkg
ZG8gbm90IHBheSBhdHRlbnRpb24gdG8gZW1haWxzIHNlbnQgdG8gQHFlbXUtZGV2IGFuZCB0aGV5
IGFycml2ZSBhcyBhIGRpZ2VzdCBhbmQgZ2V0IGZpbHRlcmVkIG91dC4gU28gcGxlYXNlIGRvIHNl
bmQgdGhlIHJlc3BvbnNlcyB3aXRoIG1lIGluIHRoZSBDQyBvciBUbyBsaXN0LiBUaGF0IHdheSwg
SSB3b27igJl0IG1pc3MgdGhlbS4NCg0KdGhhbmtzDQphbmkNCiANCg0K

