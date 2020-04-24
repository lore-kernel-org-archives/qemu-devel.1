Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ED8C54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:13:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF7420736
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="e0MIevSi";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="KqO/4zd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF7420736
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS3lr-0008AH-7S
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 15:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=13837b4cf8=coreyw7@fb.com>) id 1jS3kW-0006t1-9v
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:12:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=13837b4cf8=coreyw7@fb.com>) id 1jS3kU-0005Wb-ML
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:12:31 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:30074)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=13837b4cf8=coreyw7@fb.com>)
 id 1jS3kR-0005Kl-TY; Fri, 24 Apr 2020 15:12:28 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03OJ9Uxh003787; Fri, 24 Apr 2020 12:12:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=h8L934ZE+mFPrZMlplNT6WJ84OfU28jEmBEHXhsDZIo=;
 b=e0MIevSiOTMagmp354lmk4mv3ufyR1dxIsmKVry1EK8AfT9sljPsVyXJFcUqhhjLmFRE
 8JvoHe33HcofQ4wXLY1wh7w6h/OQTBOs9yXXCG6LMO22+tZ2ugi2gvYpg0ay8f02EUDv
 ngdkNlx25zPfzlCtiVEemM53BzfbpNyJ2Q4= 
Received: from mail.thefacebook.com ([163.114.132.120])
 by mx0a-00082601.pphosted.com with ESMTP id 30kknkxhkp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 24 Apr 2020 12:12:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 24 Apr 2020 12:12:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9my4/tTzo08cY4O5+LiEdR1wCriw66bqV3uvxeANj8aNSEJRCpSZ13u4lr3KRP2u2YkwTbrd+0F6sAtkmg3YY1im4RdTwwQNooBM6F+fm3b3QR4xKGF3jXDfbIz8h0HEnLn6k182zcE+nmRB8nZAqqWzOUuWtb1uyp4Dl6XYwETkjT9hPalrtRZ9V5OwyqMwEaifqHmPtXLWFDkXIynKH03NNZYsjm40+ue+WpkOkmwZJVSIYnLRc6Wczo9EQp/B5WrX0N5cqnIlCfcv/GGs1WKOaaDc0X500fhu2ST7Ma/JMKEW+4XXGCclDSAX2slDmTFdLaYUX+Syfxbv9CqMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8L934ZE+mFPrZMlplNT6WJ84OfU28jEmBEHXhsDZIo=;
 b=duzCl28zGdDgWdORNnWMfmN5pJSbzHHyLhhuG27bKSwgCKI2PJhhPabvHxF/dawZPED24osP1cDWsdfdZbJXkBZCv6SzCKb5e6OeeMhprU1wP/fo2W+DtTDlwkKrTKx1W9jIfI0WfLniW8fLkYEOZmZlMkXA2D+1S2Tk2caKBZNZpopdtFoyMWZJa93+5uY6laYrUaPnqw6Ur8gRCnhxI0x1A0qAYmeLxDINmpaYMX85hQsCVP7hWPaqsN2Mxn4xHSu2S5MStGdahkH4+4knzRK0RrIhnoHcVYf7JKW453A8Ho7loAhLSL9W+YOvM6iIzs9IDn6/+rjdFYBEAtDGYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8L934ZE+mFPrZMlplNT6WJ84OfU28jEmBEHXhsDZIo=;
 b=KqO/4zd5N7cXhtvZRtxu6Ag2Nz7Rojq166l+TjXcGmVSi5meiTmPrxAnbCPVtLjeS560EPB03cqxzcSbG/MYCsHY/hA0eOyHcq9YPSzveAC3UOVzgfOI5looeQvyAGuh5CqHIfUP/aIUA3vvngKvhTjpOYQRR4LxcNSeKkqHfKQ=
Received: from MW3PR15MB4041.namprd15.prod.outlook.com (2603:10b6:303:47::20)
 by MW3PR15MB3817.namprd15.prod.outlook.com (2603:10b6:303:4d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Fri, 24 Apr
 2020 19:12:00 +0000
Received: from MW3PR15MB4041.namprd15.prod.outlook.com
 ([fe80::3036:d208:efd2:f6f5]) by MW3PR15MB4041.namprd15.prod.outlook.com
 ([fe80::3036:d208:efd2:f6f5%3]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 19:12:00 +0000
From: Corey Wharton <coreyw7@fb.com>
To: Alistair Francis <alistair23@gmail.com>
CC: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "open
 list:RISC-V" <qemu-riscv@nongnu.org>, Sagar Karandikar
 <sagark@eecs.berkeley.edu>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>, Alistair Francis
 <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng
 <bmeng.cn@gmail.com>
Subject: RE: [PATCH v2 1/2] riscv: sifive_e: Support changing CPU type
Thread-Topic: [PATCH v2 1/2] riscv: sifive_e: Support changing CPU type
Thread-Index: AQHV+W6H8JK85FucOkKPYiO0hRqPjqiIsPuAgAAtHfA=
Date: Fri, 24 Apr 2020 19:12:00 +0000
Message-ID: <MW3PR15MB4041DC49872DE4C92E982FE993D00@MW3PR15MB4041.namprd15.prod.outlook.com>
References: <20200313193429.8035-1-coreyw7@fb.com>
 <20200313193429.8035-2-coreyw7@fb.com>
 <CAKmqyKNGLOE_UKWVuJzrBDRkRXj74XfOace+K5ab4-5HTWg_KA@mail.gmail.com>
In-Reply-To: <CAKmqyKNGLOE_UKWVuJzrBDRkRXj74XfOace+K5ab4-5HTWg_KA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:601:c980:28be:4d1b:bc42:820d:b3a2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b807fa57-cb7f-49d4-6a00-08d7e8835dc8
x-ms-traffictypediagnostic: MW3PR15MB3817:
x-microsoft-antispam-prvs: <MW3PR15MB3817A966C09ECA37BFD4468893D00@MW3PR15MB3817.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:473;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR15MB4041.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(366004)(376002)(396003)(346002)(39860400002)(52536014)(5660300002)(4326008)(81156014)(316002)(8676002)(8936002)(6916009)(66446008)(66556008)(64756008)(66476007)(66946007)(33656002)(86362001)(76116006)(2906002)(71200400001)(478600001)(9686003)(7696005)(6506007)(53546011)(54906003)(186003)(55016002);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b0f4Yb+mhZowmUosrE10Kho+Cso5LROcQcdI9LLFq6yi9TiH8xKp0sRrKlqZr9cng3Ok5n/B5VQicr2LgxUf0DHVLSjaxRxQk7H1uLYva9G+69c/wgamiH57ny6hHbj6eXqDAyAfTyt6s/Mv2NoVkuLC72pseYVOaoy30pXgeF9JNnMEK4k/ULP/+WdKf5QsNWtXVwXEbKL/xdvUjGx26ApN6QNbOoJnohtCgWJpY/B6J6gnBr2PAMrtNOIGnhBTA73NROr/qSFrFleih/Fp8xnr0JchOPWD1Mzg819LH+CuT345fIFPH9CaPB1KQT95T2DkIuIA+nMkVj4auHPcpygiDHZndrOesXeclNojq1rAX/YBfp2r3jCI5t6f6ndSfk4VZ4zdrpp4Bs7TtuP6qPM4k6by9bW4LUuEboam+KXQ3bBHTrG7+qkAT/JHlwHf
x-ms-exchange-antispam-messagedata: 1s8r8YGQCqqV0J9O4vuh51xrByqqjP26tYPzM2Tp2Ad1RRegsiS6ZBeTpyIN/LNpcoCK83Kmhee/0yYp4s7t/5rwnbDy+dgfmn5LB9OPoaEfSWMDR2/szOMrsyBXOU2vk9wGPj3BdF0J4uWSa8y63sh8x/R0OBEdBtTpnfUE4yvaP5iRlVNcmBK5h4gGLsnHDqBQB5atGjL1AAOI2a+PSg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b807fa57-cb7f-49d4-6a00-08d7e8835dc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 19:12:00.5864 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6X0OcMX7E8SE2fAxppk8psP/M5af+XOK/rwfjMyFzIHptK2EZ/rBlAS477C4tAjz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3817
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-24_11:2020-04-24,
 2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 priorityscore=1501
 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 clxscore=1011 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240145
X-FB-Internal: deliver
Received-SPF: pass client-ip=67.231.145.42;
 envelope-from=prvs=13837b4cf8=coreyw7@fb.com; helo=mx0a-00082601.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 15:12:23
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Received-From: 67.231.145.42
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxpc3RhaXIgRnJhbmNp
cyA8YWxpc3RhaXIyM0BnbWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgQXByaWwgMjQsIDIwMjAg
OTowNCBBTQ0KPiBUbzogQ29yZXkgV2hhcnRvbiA8Y29yZXl3N0BmYi5jb20+DQo+IENjOiBxZW11
LWRldmVsQG5vbmdudS5vcmcgRGV2ZWxvcGVycyA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsgb3Bl
bg0KPiBsaXN0OlJJU0MtViA8cWVtdS1yaXNjdkBub25nbnUub3JnPjsgU2FnYXIgS2FyYW5kaWth
cg0KPiA8c2FnYXJrQGVlY3MuYmVya2VsZXkuZWR1PjsgQmFzdGlhbiBLb3BwZWxtYW5uIDxrYmFz
dGlhbkBtYWlsLnVuaS0NCj4gcGFkZXJib3JuLmRlPjsgQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3Rh
aXIuZnJhbmNpc0B3ZGMuY29tPjsgUGFsbWVyIERhYmJlbHQNCj4gPHBhbG1lckBkYWJiZWx0LmNv
bT47IEJpbiBNZW5nIDxibWVuZy5jbkBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djIgMS8yXSByaXNjdjogc2lmaXZlX2U6IFN1cHBvcnQgY2hhbmdpbmcgQ1BVIHR5cGUNCj4gDQo+
IE9uIEZyaSwgTWFyIDEzLCAyMDIwIGF0IDEyOjM1IFBNIENvcmV5IFdoYXJ0b24gPGNvcmV5dzdA
ZmIuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFsbG93cyB0aGUgQ1BVIHRvIGJlIGNoYW5nZWQgZnJv
bSB0aGUgZGVmYXVsdCB2aWEgdGhlIC1jcHUgY29tbWFuZA0KPiA+IGxpbmUgb3B0aW9uLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogQ29yZXkgV2hhcnRvbiA8Y29yZXl3N0BmYi5jb20+DQo+ID4g
UmV2aWV3ZWQtYnk6IEJpbiBNZW5nIDxibWVuZy5jbkBnbWFpbC5jb20+DQo+ID4gUmV2aWV3ZWQt
Ynk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCj4gDQo+IFRo
YW5rcyBmb3IgdGhlIHBhdGNoLg0KPiANCj4gVW5mb3J0dW5hdGVseSB0aGlzIGZhaWxzIGBtYWtl
IGNoZWNrYC4NCj4gDQo+IFRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlIG1hY2hpbmUgaGFzIHRoZSBg
ZGVmYXVsdF9jcHVfdHlwZWAgc2V0IGJ1dCB0aGVuIHlvdQ0KPiBzZXQgImNwdS10eXBlIiBmcm9t
IHRoZSBTb0MuDQo+IA0KPiBUaGlzIGRpZmYgZml4ZXMgdGhlIG1ha2UgY2hlY2sgZmFpbHVyZSBm
b3IgbWU6DQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvcmlzY3Yvc2lmaXZlX2UuYyBiL2h3L3Jpc2N2
L3NpZml2ZV9lLmMgaW5kZXgNCj4gMWZkMDhmMzI1Yy4uYjUzMTA5NTIxZSAxMDA2NDQNCj4gLS0t
IGEvaHcvcmlzY3Yvc2lmaXZlX2UuYw0KPiArKysgYi9ody9yaXNjdi9zaWZpdmVfZS5jDQo+IEBA
IC0xMjMsOCArMTIzLDYgQEAgc3RhdGljIHZvaWQgcmlzY3Zfc2lmaXZlX2Vfc29jX2luaXQoT2Jq
ZWN0ICpvYmopDQo+ICAgICAgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQob2JqLCAiY3B1cyIsICZz
LT5jcHVzLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihzLT5jcHVzKSwg
VFlQRV9SSVNDVl9IQVJUX0FSUkFZLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZl
cnJvcl9hYm9ydCwgTlVMTCk7DQo+IC0gICAgb2JqZWN0X3Byb3BlcnR5X3NldF9zdHIoT0JKRUNU
KCZzLT5jcHVzKSwgbXMtPmNwdV90eXBlLCAiY3B1LXR5cGUiLA0KPiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICZlcnJvcl9hYm9ydCk7DQo+ICAgICAgb2JqZWN0X3Byb3BlcnR5X3NldF9p
bnQoT0JKRUNUKCZzLT5jcHVzKSwgbXMtPnNtcC5jcHVzLCAibnVtLWhhcnRzIiwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAmZXJyb3JfYWJvcnQpOw0KPiAgICAgIHN5c2J1c19pbml0
X2NoaWxkX29iaihvYmosICJyaXNjdi5zaWZpdmUuZS5ncGlvMCIsIEBAIC0xNDEsNiArMTM5LDgg
QEANCj4gc3RhdGljIHZvaWQgcmlzY3Zfc2lmaXZlX2Vfc29jX3JlYWxpemUoRGV2aWNlU3RhdGUN
Cj4gKmRldiwgRXJyb3IgKiplcnJwKQ0KPiAgICAgIFNpRml2ZUVTb0NTdGF0ZSAqcyA9IFJJU0NW
X0VfU09DKGRldik7DQo+ICAgICAgTWVtb3J5UmVnaW9uICpzeXNfbWVtID0gZ2V0X3N5c3RlbV9t
ZW1vcnkoKTsNCj4gDQo+ICsgICAgb2JqZWN0X3Byb3BlcnR5X3NldF9zdHIoT0JKRUNUKCZzLT5j
cHVzKSwgbXMtPmNwdV90eXBlLCAiY3B1LXR5cGUiLA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICZlcnJvcl9hYm9ydCk7DQo+ICAgICAgb2JqZWN0X3Byb3BlcnR5X3NldF9ib29sKE9C
SkVDVCgmcy0+Y3B1cyksIHRydWUsICJyZWFsaXplZCIsDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgJmVycm9yX2Fib3J0KTsNCj4gDQo+IA0KPiBJJ20gaGFwcHkgdG8ganVzdCBzcXVh
c2ggdGhhdCBpbnRvIHRoZSBwYXRjaC4gTGV0IG1lIGtub3cgaWYgeW91IGRvbid0IHdhbnQNCj4g
bWUgdG8gZG8gdGhhdCBhbmQgSSdsbCBkcm9wIHRoZXNlIHBhdGNoZXMgYW5kIGxldCB5b3UgcmUt
c2VuZCB0aGVtLg0KPiANCj4gQWxpc3RhaXINCj4gDQoNClRoYW5rcyBmb3IgZml4aW5nIHRoaXMg
aXNzdWUuIEkgdGVzdGVkIHlvdXIgcGF0Y2ggYW5kIGl0IHNlZW1zIHRvIHdvcmsgYXMNCkludGVu
ZGVkIGFuZCAgSSdtIGZpbmUgd2l0aCB5b3Ugc3F1YXNoaW5nIGl0IGludG8gdGhlIHBhdGNoLg0K
DQpDb3JleQ0KDQo+ID4gLS0tDQo+ID4gIGh3L3Jpc2N2L3NpZml2ZV9lLmMgfCAzICsrLQ0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvaHcvcmlzY3Yvc2lmaXZlX2UuYyBiL2h3L3Jpc2N2L3NpZml2ZV9lLmMg
aW5kZXgNCj4gPiBhMjU0Y2FkNDg5Li5iMGE2MTFhZGI5IDEwMDY0NA0KPiA+IC0tLSBhL2h3L3Jp
c2N2L3NpZml2ZV9lLmMNCj4gPiArKysgYi9ody9yaXNjdi9zaWZpdmVfZS5jDQo+ID4gQEAgLTEy
Myw3ICsxMjMsNyBAQCBzdGF0aWMgdm9pZCByaXNjdl9zaWZpdmVfZV9zb2NfaW5pdChPYmplY3Qg
Km9iaikNCj4gPiAgICAgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKG9iaiwgImNwdXMiLCAmcy0+
Y3B1cywNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihzLT5jcHVzKSwg
VFlQRV9SSVNDVl9IQVJUX0FSUkFZLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
JmVycm9yX2Fib3J0LCBOVUxMKTsNCj4gPiAtICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfc3RyKE9C
SkVDVCgmcy0+Y3B1cyksIFNJRklWRV9FX0NQVSwgImNwdS10eXBlIiwNCj4gPiArICAgIG9iamVj
dF9wcm9wZXJ0eV9zZXRfc3RyKE9CSkVDVCgmcy0+Y3B1cyksIG1zLT5jcHVfdHlwZSwNCj4gPiAr
ICJjcHUtdHlwZSIsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmZXJyb3JfYWJv
cnQpOw0KPiA+ICAgICAgb2JqZWN0X3Byb3BlcnR5X3NldF9pbnQoT0JKRUNUKCZzLT5jcHVzKSwg
bXMtPnNtcC5jcHVzLCAibnVtLQ0KPiBoYXJ0cyIsDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAmZXJyb3JfYWJvcnQpOyBAQCAtMjIwLDYgKzIyMCw3IEBAIHN0YXRpYw0KPiA+IHZv
aWQgcmlzY3Zfc2lmaXZlX2VfbWFjaGluZV9pbml0KE1hY2hpbmVDbGFzcyAqbWMpDQo+ID4gICAg
ICBtYy0+ZGVzYyA9ICJSSVNDLVYgQm9hcmQgY29tcGF0aWJsZSB3aXRoIFNpRml2ZSBFIFNESyI7
DQo+ID4gICAgICBtYy0+aW5pdCA9IHJpc2N2X3NpZml2ZV9lX2luaXQ7DQo+ID4gICAgICBtYy0+
bWF4X2NwdXMgPSAxOw0KPiA+ICsgICAgbWMtPmRlZmF1bHRfY3B1X3R5cGUgPSBTSUZJVkVfRV9D
UFU7DQo+ID4gIH0NCj4gPg0KPiA+ICBERUZJTkVfTUFDSElORSgic2lmaXZlX2UiLCByaXNjdl9z
aWZpdmVfZV9tYWNoaW5lX2luaXQpDQo+ID4gLS0NCj4gPiAyLjIxLjENCj4gPg0KPiA+DQo=

