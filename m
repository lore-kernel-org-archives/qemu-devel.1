Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76085C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:49:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F1532070A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="hwHrscGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1532070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuwWT-0004KT-BV
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:49:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iuwVn-0003iW-B1
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:48:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iuwVl-0004jN-Np
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:48:27 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:61932)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>)
 id 1iuwVe-0004Yn-OR; Fri, 24 Jan 2020 05:48:18 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00OAg87J007760; Fri, 24 Jan 2020 02:48:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=q/vsVTB+WFtd+6d8i5M/zeHYaPbxVDH9KAZ0Sw6jHS8=;
 b=hwHrscGbojy5NiEx4aPuxpa3LS36Vu2CKmNIC61s3c5/xiLf/Kjt44Pp7YnDJ5njAnmP
 1MYnvdkpHJtz84chdFXL2sy5vc0bnJUd1b4CFq5J/77V5zjH9NZcfAgfRANAeACTHUwK
 ybh7bxZEh7ZPut891jHxwfUGot7OXt9ULCr60/FQ0ju+xcjlWxLQiBV9FMHRnrModL2m
 wx/nP8JjvHJoJB+Z/qTSNIjNgfMlic3l1ods8uzC5MnnWwCTkNDwg3irnF+puq8ZqP2y
 nvT+q19vFPKt6YNfJ93HcCH5h0uA7tOVlUQowjDG+2DwP+XYAntPwh5ppiFEfG0yUF9M Ng== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2xky80nagr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jan 2020 02:48:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYLjmR/2UK0RCdwHcThi+tmp3ttvnb0K7ZQGIhFcqix15XpxemC7sXIvWEIu7ZG+jS5U5+dYG+uE156UWW8P517I0T1PWeLF+XurioT9FhnPSgAI2A+m9P+omAtC9yVa1HxHC/3BWZjHiBZiYigkg/rN0i8sX3Sj4x9aTA3iPl5L7vGI+f3ZDUXrXMqRZKivg/X3ImIzlNqOBoH6PXu8Tohqa58BtoUzqbTgrKdN2nGBJd8bAOkGGyJIiYtATEj4NZ8qSHxQS/KRZCT//JgfJu9TX3UtH48cot2kds2edcEfxcynK8K5LDRkoU9RCGA31bxIdfso0vYsiDEYMlwIyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/vsVTB+WFtd+6d8i5M/zeHYaPbxVDH9KAZ0Sw6jHS8=;
 b=ftngW9DhVBw8Fdf76F5T3luP4ALStK2BWrIcN1Am/fqc52ob8+ozsWewBgdj72aVmsBdnfY5PtRqi4a3t2kGevu4jbnuNtlAwN8TrKIpvw/+IGv9x1DNvGGWEX0q4GYI9Oe0OjFI8nWsE0OI/QSIb2XACEevjUWh6GSRa7OOTf6AiI5iCtxrpSOs0YasjXp5Ebd+C4vY1EjT5KzF5LNLdAlklRkEvKqge7ZujvgCXOGLBCtiP4WB49OEfCvjrfCW0eUAgaWCTtS71Z0verWqXZiyHK+9+cJyRNzM/b8uNAqfsANzArnv9LPqPvnG8GCGMhizf/fTkOUftxo8F2se4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2383.namprd02.prod.outlook.com (10.168.244.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Fri, 24 Jan 2020 10:48:07 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029%10]) with mapi id 15.20.2644.028; Fri, 24 Jan
 2020 10:48:07 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH] iscsi: Cap block count from GET LBA STATUS (CVE-2020-1711)
Thread-Topic: [PATCH] iscsi: Cap block count from GET LBA STATUS
 (CVE-2020-1711)
Thread-Index: AQHV0ersGiQprkLuikaxEpLUh3Oweaf4hjqAgAA+NQCAABkDgIAAug2AgAAMLwA=
Date: Fri, 24 Jan 2020 10:48:06 +0000
Message-ID: <6C861A00-A30A-4CED-85F7-412A13760C4B@nutanix.com>
References: <B07CB62A-7860-4385-A6A4-4ECA211DBE42@nutanix.com>
 <9F93582E-139B-45B2-8630-FDD331F09DEF@kamp.de>
 <c00fc076-3a46-7a52-a539-66751fb2943a@redhat.com>
In-Reply-To: <c00fc076-3a46-7a52-a539-66751fb2943a@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.9.225.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab6a9a62-a5b6-43dd-a1dc-08d7a0bae5a6
x-ms-traffictypediagnostic: MWHPR02MB2383:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB2383E87C8DA66767E34A4284D70E0@MWHPR02MB2383.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-forefront-prvs: 02929ECF07
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39860400002)(396003)(346002)(136003)(376002)(199004)(189003)(6486002)(2616005)(33656002)(8936002)(54906003)(2906002)(5660300002)(86362001)(316002)(186003)(26005)(478600001)(36756003)(4326008)(53546011)(6506007)(6916009)(91956017)(76116006)(7416002)(66476007)(64756008)(66446008)(81156014)(71200400001)(8676002)(81166006)(66946007)(66556008)(6512007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2383;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ye6P4uyxjsYHCSq8+2YdFtc2eRfMBoM8HOXVx0oMaFjlgR+p6WI6mz6BSDe3run808Ddogq7jurMtwnHhDLngv9OPLNAY+v/sgOYqCCPBbOzxjDKd1v3lSg1YX8j6iRNnN+IadGETNeTnX7BykLEmsui3Dtc5VlzUq+RTTY1A4k9KTlsqr7swFq1m++i0E3XB+AHJnk1pb3AtRO0wzs1BAgJGth8lNWBTG6e360tTs1sYu5bngmyaKpl6wOFCSHaw61BY4mRjyF4KKp+aldUi8pSlyPH/vQIKnRd5GkG8G464TYLo7QnFH/tisfI8hsWglzvNJG14tqF2tzyMP0KX7UfHd8TNwJvw17UWYyUnWTGp2qXSeaauWMReEOhNlMD8Z0Ys9HdD8p0RzyMcuZlpfmSAxbE5JDfkCCiDYG9UnCXdrZp1R89IlerZTRgMSsR
x-ms-exchange-antispam-messagedata: //f3vz3T/FWV+5kCibddzAi4LZeZiFA06NxgfnXyGDZxfRYfTNMLO89gHzr7eVSGDJ7nAEUtwycY3FevjRkDJleeS/I/bQrxO6nJBqsxRODpqmyKtGFlUUjV+319MQyM90nW5S+Qg3XjgYQK2HXYTw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <14F590AC3A8F4343B892F30CB6FF7FA5@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6a9a62-a5b6-43dd-a1dc-08d7a0bae5a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2020 10:48:07.0570 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VMMUT7UlTpiLxgG/kGFbEc2cmZ25VOIacd9YCUwROP7ASXihRI20fz7P1D53/GL9W76bM8Y6XoKvib/OgZoqO7e0AwZEa+qGzIR0Vi24b1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2383
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-24_03:2020-01-24,
 2020-01-24 signatures=0
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Turschmid <peter.turschm@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Peter Lieven <pl@kamp.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, P J P <ppandit@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gT24gSmFuIDI0LCAyMDIwLCBhdCAxMDowNCBBTSwgUGhpbGlwcGUgTWF0aGlldS1EYXVk
w6kgPHBoaWxtZEByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIDEvMjMvMjAgMTE6NTggUE0s
IFBldGVyIExpZXZlbiB3cm90ZToNCj4+PiBBbSAyMy4wMS4yMDIwIHVtIDIyOjI5IHNjaHJpZWIg
RmVsaXBlIEZyYW5jaW9zaSA8ZmVsaXBlQG51dGFuaXguY29tPjoNCj4+Pj4gT24gSmFuIDIzLCAy
MDIwLCBhdCA1OjQ2IFBNLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5j
b20+IHdyb3RlOg0KPj4+Pj4gT24gMS8yMy8yMCAxOjQ0IFBNLCBGZWxpcGUgRnJhbmNpb3NpIHdy
b3RlOg0KPj4+Pj4gV2hlbiBxdWVyeWluZyBhbiBpU0NTSSBzZXJ2ZXIgZm9yIHRoZSBwcm92aXNp
b25pbmcgc3RhdHVzIG9mIGJsb2NrcyAodmlhDQo+Pj4+PiBHRVQgTEJBIFNUQVRVUyksIFFlbXUg
b25seSB2YWxpZGF0ZXMgdGhhdCB0aGUgcmVzcG9uc2UgZGVzY3JpcHRvciB6ZXJvJ3MNCj4+Pj4+
IExCQSBtYXRjaGVzIHRoZSBvbmUgcmVxdWVzdGVkLiBHaXZlbiB0aGUgU0NTSSBzcGVjIGFsbG93
cyBzZXJ2ZXJzIHRvDQo+Pj4+PiByZXNwb25kIHdpdGggdGhlIHN0YXR1cyBvZiBibG9ja3MgYmV5
b25kIHRoZSBlbmQgb2YgdGhlIExVTiwgUWVtdSBtYXkNCj4+Pj4+IGhhdmUgaXRzIGhlYXAgY29y
cnVwdGVkIGJ5IGNsZWFyaW5nL3NldHRpbmcgdG9vIG1hbnkgYml0cyBhdCB0aGUgZW5kIG9mDQo+
Pj4+PiBpdHMgYWxsb2NtYXAgZm9yIHRoZSBMVU4uDQo+Pj4+PiBBIG1hbGljaW91cyBndWVzdCBp
biBjb250cm9sIG9mIHRoZSBpU0NTSSBzZXJ2ZXIgY291bGQgY2FyZWZ1bGx5IHByb2dyYW0NCj4+
Pj4+IFFlbXUncyBoZWFwIChieSBzZWxlY3RpdmVseSBzZXR0aW5nIHRoZSBiaXRtYXApIGFuZCB0
aGVuIHNtYXNoIGl0Lg0KPj4+Pj4gVGhpcyBsaW1pdHMgdGhlIG51bWJlciBvZiBiaXRzIHRoYXQg
aXNjc2lfY29fYmxvY2tfc3RhdHVzKCkgd2lsbCB0cnkgdG8NCj4+Pj4+IHVwZGF0ZSBpbiB0aGUg
YWxsb2NtYXAgc28gaXQgY2FuJ3Qgb3ZlcmZsb3cgdGhlIGJpdG1hcC4NCj4+Pj4gDQo+Pj4+IFBs
ZWFzZSBhZGQ6DQo+Pj4+IA0KPj4+PiBGaXhlczogQ1ZFLTIwMjAtMTcxMSAodGl0bGUgb2YgQ1ZF
IGlmIHBvc3NpYmxlKQ0KPj4+IA0KPj4+IEkgd2Fzbid0IHN1cmUgd2UgaGFkIG9uZSB5ZXQuIEtl
dmluOiBjYW4geW91IGRvIHRoZSBuZWVkZnVsIGluIHlvdXIgYnJhbmNoPw0KPj4+IA0KPj4+PiBD
YzogcWVtdS1zdGFibGVAbm9uZ251Lm9yZw0KPj4+IA0KPj4+IFllYWgsIHRoYXQncyB0aGVyZS4N
Cj4+PiANCj4+Pj4gDQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBGZWxpcGUgRnJhbmNpb3NpIDxmZWxp
cGVAbnV0YW5peC5jb20+DQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBUdXJzY2htaWQgPHBl
dGVyLnR1cnNjaG1AbnV0YW5peC5jb20+DQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBSYXBoYWVsIE5v
cndpdHogPHJhcGhhZWwubm9yd2l0ekBudXRhbml4LmNvbT4NCj4+Pj4+IC0tLQ0KPj4+Pj4gYmxv
Y2svaXNjc2kuYyB8IDUgKysrLS0NCj4+Pj4+IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+Pj4+PiBkaWZmIC0tZ2l0IGEvYmxvY2svaXNjc2kuYyBiL2Js
b2NrL2lzY3NpLmMNCj4+Pj4+IGluZGV4IDJhZWE3ZTNmMTMuLmNiZDU3Mjk0YWIgMTAwNjQ0DQo+
Pj4+PiAtLS0gYS9ibG9jay9pc2NzaS5jDQo+Pj4+PiArKysgYi9ibG9jay9pc2NzaS5jDQo+Pj4+
PiBAQCAtNzAxLDcgKzcwMSw3IEBAIHN0YXRpYyBpbnQgY29yb3V0aW5lX2ZuIGlzY3NpX2NvX2Js
b2NrX3N0YXR1cyhCbG9ja0RyaXZlclN0YXRlICpicywNCj4+Pj4+ICAgICBzdHJ1Y3Qgc2NzaV9n
ZXRfbGJhX3N0YXR1cyAqbGJhcyA9IE5VTEw7DQo+Pj4+PiAgICAgc3RydWN0IHNjc2lfbGJhX3N0
YXR1c19kZXNjcmlwdG9yICpsYmFzZCA9IE5VTEw7DQo+Pj4+PiAgICAgc3RydWN0IElzY3NpVGFz
ayBpVGFzazsNCj4+Pj4+IC0gICAgdWludDY0X3QgbGJhOw0KPj4+Pj4gKyAgICB1aW50NjRfdCBs
YmEsIG1heF9ieXRlczsNCj4+Pj4+ICAgICBpbnQgcmV0Ow0KPj4+Pj4gICAgICAgaXNjc2lfY29f
aW5pdF9pc2NzaXRhc2soaXNjc2lsdW4sICZpVGFzayk7DQo+Pj4+PiBAQCAtNzIxLDYgKzcyMSw3
IEBAIHN0YXRpYyBpbnQgY29yb3V0aW5lX2ZuIGlzY3NpX2NvX2Jsb2NrX3N0YXR1cyhCbG9ja0Ry
aXZlclN0YXRlICpicywNCj4+Pj4+ICAgICB9DQo+Pj4+PiAgICAgICBsYmEgPSBvZmZzZXQgLyBp
c2NzaWx1bi0+YmxvY2tfc2l6ZTsNCj4+Pj4+ICsgICAgbWF4X2J5dGVzID0gKGlzY3NpbHVuLT5u
dW1fYmxvY2tzIC0gbGJhKSAqIGlzY3NpbHVuLT5ibG9ja19zaXplOw0KPj4+Pj4gICAgICAgcWVt
dV9tdXRleF9sb2NrKCZpc2NzaWx1bi0+bXV0ZXgpOw0KPj4+Pj4gcmV0cnk6DQo+Pj4+PiBAQCAt
NzY0LDcgKzc2NSw3IEBAIHJldHJ5Og0KPj4+Pj4gICAgICAgICBnb3RvIG91dF91bmxvY2s7DQo+
Pj4+PiAgICAgfQ0KPj4+Pj4gLSAgICAqcG51bSA9IChpbnQ2NF90KSBsYmFzZC0+bnVtX2Jsb2Nr
cyAqIGlzY3NpbHVuLT5ibG9ja19zaXplOw0KPj4+Pj4gKyAgICAqcG51bSA9IE1JTigoaW50NjRf
dCkgbGJhc2QtPm51bV9ibG9ja3MgKiBpc2NzaWx1bi0+YmxvY2tfc2l6ZSwgbWF4X2J5dGVzKTsN
Cj4+Pj4+ICAgICAgIGlmIChsYmFzZC0+cHJvdmlzaW9uaW5nID09IFNDU0lfUFJPVklTSU9OSU5H
X1RZUEVfREVBTExPQ0FURUQgfHwNCj4+Pj4+ICAgICAgICAgbGJhc2QtPnByb3Zpc2lvbmluZyA9
PSBTQ1NJX1BST1ZJU0lPTklOR19UWVBFX0FOQ0hPUkVEKSB7DQo+Pj4+IA0KPj4+PiBXaGF0IGFi
b3V0IHRoaXM/DQo+Pj4+IA0KPj4+PiAtLSA+OCAtLQ0KPj4+PiBkaWZmIC0tZ2l0IGEvYmxvY2sv
aXNjc2kuYyBiL2Jsb2NrL2lzY3NpLmMNCj4+Pj4gaW5kZXggMmFlYTdlM2YxMy4uMjU1OThhY2Ni
YiAxMDA2NDQNCj4+Pj4gLS0tIGEvYmxvY2svaXNjc2kuYw0KPj4+PiArKysgYi9ibG9jay9pc2Nz
aS5jDQo+Pj4+IEBAIC01MDYsNiArNTA2LDExIEBAIGlzY3NpX2FsbG9jbWFwX3VwZGF0ZShJc2Nz
aUx1biAqaXNjc2lsdW4sIGludDY0X3Qgb2Zmc2V0LA0KPj4+PiAgICAvKiBzaHJpbmsgdG8gdG91
Y2ggb25seSBjb21wbGV0ZWx5IGNvbnRhaW5lZCBjbHVzdGVycyAqLw0KPj4+PiAgICBjbF9udW1f
c2hydW5rID0gRElWX1JPVU5EX1VQKG9mZnNldCwgaXNjc2lsdW4tPmNsdXN0ZXJfc2l6ZSk7DQo+
Pj4+ICAgIG5iX2Nsc19zaHJ1bmsgPSAob2Zmc2V0ICsgYnl0ZXMpIC8gaXNjc2lsdW4tPmNsdXN0
ZXJfc2l6ZSAtIGNsX251bV9zaHJ1bms7DQo+Pj4+ICsgICAgaWYgKG5iX2Nsc19leHBhbmRlZCA+
PSBpc2NzaWx1bi0+YWxsb2NtYXBfc2l6ZQ0KPj4+PiArICAgICAgICB8fCBuYl9jbHNfc2hydW5r
ID49IGlzY3NpbHVuLT5hbGxvY21hcF9zaXplKSB7DQo+Pj4+ICsgICAgICAgIGVycm9yX3JlcG9y
dCgiaVNDU0kgaW52YWxpZCByZXF1ZXN0OiAuLi4iIC8qIFRPRE8gKi8pOw0KPj4+PiArICAgICAg
ICByZXR1cm47DQo+Pj4+ICsgICAgfQ0KPj4+PiAgICBpZiAoYWxsb2NhdGVkKSB7DQo+Pj4+ICAg
ICAgICBiaXRtYXBfc2V0KGlzY3NpbHVuLT5hbGxvY21hcCwgY2xfbnVtX2V4cGFuZGVkLCBuYl9j
bHNfZXhwYW5kZWQpOw0KPj4+PiAgICB9IGVsc2Ugew0KPj4+PiAtLS0NCj4+PiANCj4+PiBJJ20g
bm90IHN1cmUgdGhlIGFib3ZlIGlzIGNvcnJlY3QgYmVjYXVzZSAoaWYgSSByZWFkIHRoaXMgcmln
aHQpDQo+Pj4gbmJfY2xzXyogcmVwcmVzZW50cyB0aGUgbnVtYmVyIG9mIGNsdXN0ZXJzLCBub3Qg
dGhlIGxhc3QgY2x1c3Rlci4NCj4+PiANCj4+PiBQZXJzb25hbGx5LCBJIHdvdWxkIGhhdmUgdGhl
IGNoZWNrcyAob3IgInRyaW0icykgY2xvc2VyIHRvIHdoZXJlIHRoZXkNCj4+PiB3ZXJlIGlzc3Vl
ZCAodG8gZmFpbCBzb29uZXIpIGFuZCBhc3NlcnQoKXMgY2xvc2VyIHRvIGJpdG1hcCAoYXMgbm8g
b29iDQo+Pj4gYWNjZXNzZXMgc2hvdWxkIGJlIGhhcHBlbmluZyBhdCB0aGlzIHBvaW50KS4gVGhl
cmUgd2VyZSBhbHNvDQo+Pj4gZGlzY3Vzc2lvbnMgYWJvdXQgdXNpbmcgc2FmZXIgKGhpZ2hlciBs
ZXZlbCkgYml0bWFwcyBmb3IgdGhpcy4gSSdtDQo+Pj4gYWx3YXlzIGluIGZhdm91ciBvZiBhZGRp
bmcgYWxsIHJlYXNvbmFibGUgY2hlY2tzLiA6KQ0KPj4gSSB3b3VsZCBhZGQgYXNzZXJ0aW9ucyB0
aGF0IGNsX251bSArIG5iX2NscyA8PSBhbGxvY21hcF9zaXplIGJlZm9yZSBldmVyeSBzZXQgYW5k
IGNsZWFyLg0KPiANCj4gVGhlIGRlc2NyaXB0aW9uIHN0YXJ0cyB3aXRoICJBIG1hbGljaW91cyBn
dWVzdCBpbiBjb250cm9sIG9mIHRoZSBpU0NTSSBzZXJ2ZXIgLi4uIiBzbyBhc3NlcnRpbmcgKGFu
ZCBraWxsaW5nIHRoZSBWTSkgZG9lc24ndCBzZWVtIGNvcnJlY3QuLi4NCg0KQ29ycmVjdC4gVGhh
dCdzIHdoeSBJIHdvdWxkIGhhdmUgdGhlIHByb3BlciBjaGVja3MgKG9yICJ0cmltInMpIGNsb3Nl
cg0KdG8gd2hlcmUgdGhleSB3ZXJlIGlzc3VlZCB0byBmYWlsIHNvb25lci4gV2hhdCBJIG1lYW50
IGlzIHRoYXQgaWYgYQ0KZ3Vlc3QgaXNzdWVzIGFueSBvcGVyYXRpb24gdGhhdCBzcGFucyBwYXN0
IHRoZSBlbmQgb2YgdGhlIGRyaXZlLCB0aGVuDQp0aGUgb3BlcmF0aW9uIHN0b3BzIHRoZXJlIGFu
ZCBhbiBlcnJvciBpcyByZXR1cm5lZCBhY2NvcmRpbmdseS4NCg0KVGhpcyBtZWFucyBub3RoaW5n
IHNob3VsZCBldmVyIHRyeSB0byB0b3VjaCB0aGVzZSBiaXRtYXBzIG91dCBvZg0KYm91bmRzLiBO
ZXZlcnRoZWxlc3MsIGFuZCBmdXJ0aGVyIHRvIHRoYXQsIGFzc2VydCgpcyBjYW4gYmUgdXNlZA0K
Y2xvc2VyIHRvIHdoZXJlIHRoZSBiaXRtYXAgaXMgdG91Y2hlZCB0byBjYXRjaCBwcm9ncmFtbWlu
ZyBlcnJvcnMuDQoNCj4gSSBzdXBwb3NlIHRoZSBpU0NTSSBwcm90b2NvbCBoYXMgc29tZSBlcnJv
ciB0byByZXR1cm4gZm9yIGludmFsaWQgcmVxdWVzdHMuDQoNCldoaWNoIGludmFsaWQgeW91IGFy
ZSByZWZlcnJpbmcgdG8/IEZyb20gdGhlIGluaXRpYXRvciBvciB0aGUgdGFyZ2V0Pw0KQUZBSUNU
IHRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlIFNDU0kgU1BFQyBkb2Vzbid0IGxpbWl0IGEgdGFyZ2V0
IHRvDQpyZXNwb25kIHByb3Zpc2lvbmluZyBzdGF0dXMgcGFzdCB0aGUgKGN1cnJlbnQpIGVuZCBv
ZiB0aGUgTFVOIChlaXRoZXINCmJlY2F1c2UgdGhpcyB3YXMgbm90IGRlZW1lZCBpbXBvcnRhbnQg
dG8gc3RyZXNzLCB3YXMgZm9yZ290dGVuLCBvciBpcw0KaW50ZW50aW9uYWxseSBhbGxvd2VkKS4N
Cg0KPiANCj4gQWxzbyBzaG91bGRuJ3Qgd2UgcmVwb3J0IHNvbWUgd2FybmluZyBpbiBjYXNlIG9m
IHN1Y2ggaW52YWxpZCByZXF1ZXN0PyBTbyB0aGUgbWFuYWdlbWVudCBzaWRlIGNhbiBsb29rIGF0
IHRoZSAnbWFsaWNpb3VzIGlTQ1NJIHNlcnZlcic/DQo+IA0KDQpJIHRoaW5rIGhhdmluZyB0aGUg
b3B0aW9uIHRvIGRvIHNvIGlzIGEgZ29vZCBpZGVhLiBUaGVyZSBhcmUgdHdvIGNhc2VzDQpJIGNh
biB0aGluayBvZiB0aGF0IHlvdSBydW4gaW50byBhICJtYWxpY2lvdXMiIHN0b3JhZ2Ugc2VydmVy
Og0KMSkgU29tZW9uZSBoYWNrZWQgeW91ciBzdG9yYWdlIHNlcnZlcg0KMikgWW91ciBjb250cm9s
IHBsYW5lIGFsbG93cyB5b3VyIGNvbXB1dGUgdG8gY29ubmVjdCB0byBhIHVzZXINCnByb3ZpZGVk
IHN0b3JhZ2Ugc2VydmljZQ0KDQpUaGlua2luZyBhcyBhbiBhZG1pbiwgaWYgSSBvbmx5IGFsbG93
IHN0b3JhZ2Ugc2VydmVycyBJIHByb3ZpZGUsIHRoZW4NCkkgd2FudCB0byBzZWUgc3VjaCB3YXJu
aW5ncy4gSWYgSSBsZXQgcGVvcGxlIHBvaW50IHRoZSBWTU0gdG8gZG9kZ3kNCnNlcnZlcnMsIHRo
ZW4gSSBwcm9iYWJseSBkb24ndCB3YW50IHRoZSBsb2cgc3BhbS4NCg0KRi4NCg0KDQoNCg==

