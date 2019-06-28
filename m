Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DE5C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:25:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ED5C2064A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GtGljRtn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED5C2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgskg-00014a-Ot
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 11:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50056)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <den@virtuozzo.com>) id 1hgsPT-00035J-8d
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:03:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <den@virtuozzo.com>) id 1hgsPR-0005HW-6R
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:03:31 -0400
Received: from mail-eopbgr50093.outbound.protection.outlook.com
 ([40.107.5.93]:57505 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <den@virtuozzo.com>)
 id 1hgsPK-0005D2-L9; Fri, 28 Jun 2019 11:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56xNMO7l9tCtPNA1pOxFKv6zO22e+gXTr/PmISOqsFo=;
 b=GtGljRtn/wAcKlWC/TsK/1juGoZ5s1M3LX/qtqjQHEr1xJOPEczvYCoR54NV9RoLwawhzuniaJ6zi0ZGJVNNsCsjGivERzeTcC7H9K/fT+PZqidwiUqpZ3jQJ67PjTfnHniA76TR7EWKyJFWO/k0HoC2rR0eOKIatnYohIbbJQ8=
Received: from DBBPR08MB4250.eurprd08.prod.outlook.com (20.179.40.149) by
 DBBPR08MB4693.eurprd08.prod.outlook.com (10.255.79.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Fri, 28 Jun 2019 15:03:13 +0000
Received: from DBBPR08MB4250.eurprd08.prod.outlook.com
 ([fe80::1d8b:7420:f966:e881]) by DBBPR08MB4250.eurprd08.prod.outlook.com
 ([fe80::1d8b:7420:f966:e881%3]) with mapi id 15.20.2008.014; Fri, 28 Jun 2019
 15:03:13 +0000
From: Denis Lunev <den@virtuozzo.com>
To: Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [RFC] Re-evaluating subcluster allocation for qcow2 images
Thread-Index: AQHVLPCb4B1OTPiTIEWxN+ewhowOEKavjMGAgAAWOgCAADnRAIABSSKAgAADtACAAAFrgIAAAEQA
Date: Fri, 28 Jun 2019 15:03:13 +0000
Message-ID: <7452ca4a-c552-a912-a865-d99aaad99488@virtuozzo.com>
References: <20190627135914.xlzohrdwr6mz2aq3@perseus.local>
 <4453cfc4-cff7-c004-1f4c-7cab462e4661@virtuozzo.com>
 <w51a7e3domn.fsf@maestria.local.igalia.com>
 <434b102d-9d8e-ccc2-cb53-7f49a3fbd6fb@virtuozzo.com>
 <w51r27dixcm.fsf@maestria.local.igalia.com>
 <20190628145708.GN5179@dhcp-200-226.str.redhat.com>
 <w51o92hiwi2.fsf@maestria.local.igalia.com>
In-Reply-To: <w51o92hiwi2.fsf@maestria.local.igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR08CA0060.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::31) To DBBPR08MB4250.eurprd08.prod.outlook.com
 (2603:10a6:10:c2::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=den@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1e926f0-ca11-4a59-5316-08d6fbd9bdb4
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4693; 
x-ms-traffictypediagnostic: DBBPR08MB4693:
x-microsoft-antispam-prvs: <DBBPR08MB4693DA775539489FA90580DBB6FC0@DBBPR08MB4693.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(376002)(136003)(366004)(346002)(199004)(189003)(51444003)(2906002)(31696002)(36756003)(14454004)(14444005)(446003)(476003)(486006)(11346002)(5660300002)(99286004)(2616005)(256004)(71200400001)(71190400001)(31686004)(6436002)(68736007)(66446008)(66476007)(66946007)(64756008)(73956011)(229853002)(7736002)(3846002)(6116002)(26005)(305945005)(25786009)(66556008)(107886003)(6246003)(6486002)(6512007)(53936002)(186003)(53546011)(81156014)(8936002)(81166006)(6506007)(102836004)(66066001)(386003)(110136005)(8676002)(316002)(76176011)(478600001)(54906003)(4326008)(52116002)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4693;
 H:DBBPR08MB4250.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k+NFeFSfIoO4uqqiNNYei9SeRsXADCYi7C+VnYpcufeGSV6DxPx0lZbzVDyRKfESRZEQS8DK7rR5/YYu8ipiJb+0gkYCXpL/gUgiaZDPxAKVyPP/+rYj3adEmRc7XI0VfQsYqgLwtAVgzMabF17RHtlR1yGLeEaHIbusMTw64XUwo29uiQmOZKlPa3n9DXmT7kj7LJR6BhcZs7/rqAR4H6YhIQnSTx6d8257NSs3I8kxz3DIUSevb0sZATkL2rDlMWpEGvhAt/aZtmHRizK8IOf5wpHWXRf2pgdDnigIlT7+MfmobRC7qPzO4m/XWPCZdWx1ANwpL69KAHMmnoKLiaHtLZ/LHSkH5uJ0jwVd3IeGTWz1/wL+peqZHVjw+ConTzyavunt9bDSAl+CKri8+hcgaANvClU8aO69kz+CVng=
Content-Type: text/plain; charset="utf-8"
Content-ID: <366EB6F02521C34F959CB57B637315EE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e926f0-ca11-4a59-5316-08d6fbd9bdb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 15:03:13.1458 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: den@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4693
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.93
Subject: Re: [Qemu-devel] [RFC] Re-evaluating subcluster allocation for
 qcow2 images
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
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gNi8yOC8xOSA2OjAyIFBNLCBBbGJlcnRvIEdhcmNpYSB3cm90ZToNCj4gT24gRnJpIDI4IEp1
biAyMDE5IDA0OjU3OjA4IFBNIENFU1QsIEtldmluIFdvbGYgd3JvdGU6DQo+PiBBbSAyOC4wNi4y
MDE5IHVtIDE2OjQzIGhhdCBBbGJlcnRvIEdhcmNpYSBnZXNjaHJpZWJlbjoNCj4+PiBPbiBUaHUg
MjcgSnVuIDIwMTkgMDY6MDU6NTUgUE0gQ0VTVCwgRGVuaXMgTHVuZXYgd3JvdGU6DQo+Pj4+IFBs
ZWFzZSBub3RlLCBJIGFtIG5vdCB0YWxraW5nIG5vdyBhYm91dCB5b3VyIGNhc2Ugd2l0aCBDT1cu
IEhlcmUgdGhlDQo+Pj4+IGFsbG9jYXRpb24gaXMgcGVyZm9ybWVkIG9uIHRoZSBzdWItY2x1c3Rl
ciBiYXNpcywgaS5lLiB0aGUgYWJzY2VuY2Ugb2YNCj4+Pj4gdGhlIHN1Yi1jbHVzdGVyIGluIHRo
ZSBpbWFnZSBtZWFucyBob2xlIG9uIHRoYXQgb2Zmc2V0LiBUaGlzIGlzDQo+Pj4+IGltcG9ydGFu
dCBkaWZmZXJlbmNlLg0KPj4+IEkgbWVudGlvbmVkIHRoZSBwb3NzaWJpbGl0eSB0aGF0IGlmIHlv
dSBoYXZlIGEgY2FzZSBsaWtlIDJNQiAvIDY0S0INCj4+PiBhbmQgeW91IHdyaXRlIHRvIGFuIGVt
cHR5IGNsdXN0ZXIgdGhlbiB5b3UgY291bGQgYWxsb2NhdGUgdGhlDQo+Pj4gbmVjZXNzYXJ5IHN1
YmNsdXN0ZXJzLCBhbmQgYWRkaXRpb25hbGx5IGZhbGxvY2F0ZSgpIHRoZSBzcGFjZSBvZiB0aGUN
Cj4+PiB3aG9sZSBjbHVzdGVyICgyTUIpIGluIG9yZGVyIHRvIHRyeSB0byBrZWVwIGl0IGNvbnRp
Z3VvdXMuDQo+Pj4NCj4+PiBXaXRoIHRoaXMgd2Ugd291bGQgbG9zZSB0aGUgc3BhY2Ugc2F2aW5n
IGFkdmFudGFnZSBvZiBoYXZpbmcNCj4+PiBzdWJjbHVzdGVycy4gQnV0IHBlcmhhcHMgdGhhdCB3
b3VsZCB3b3JrIGZvciBzbWFsbGVyIGNsdXN0ZXIgc2l6ZXMNCj4+PiAoaXQgd291bGQgbWl0aWdh
dGUgdGhlIGZyYWdtZW50YXRpb24gcHJvYmxlbSkuDQo+PiBUaGVyZSBzZWVtIHRvIGJlIHVzZSBj
YXNlcyBmb3IgYm90aCB3YXlzLiBTbyBkb2VzIHRoaXMgbmVlZCB0byBiZSBhbg0KPj4gb3B0aW9u
Pw0KPiBQcm9iYWJseSBhIHJ1bnRpbWUgb3B0aW9uLCBvciBhIGhldXJpc3RpYyB0aGF0IGRlY2lk
ZXMgd2hhdCB0byBkbw0KPiBkZXBlbmRpbmcgb24gdGhlIGNsdXN0ZXIgc2l6ZS4NCm5vLCBJIHRo
aW5rIHRoYXQgdGhpcyBzaG91bGQgYmUgb24tZGlzayBvcHRpb24gYXMgdGhpcyBhZmZlY3RzDQph
bGxvY2F0aW9uIHN0cmF0ZWd5Lg0KDQpEZW4NCg==

