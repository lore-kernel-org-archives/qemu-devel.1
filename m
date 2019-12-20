Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B641C2D0C0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 491C321D7E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="0ynoRu1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491C321D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiKdV-0006Ri-Cg
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 10:56:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iiKcr-0005xo-AE
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:55:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iiKco-0005ZH-Sh
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:55:36 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:61038)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iiKco-0005Xz-Lb
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:55:34 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBKFshvq018396; Fri, 20 Dec 2019 07:55:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=DC/lC8IYcG0na4od7nvGHEYLcnHnZVJicZ0y3o5y+Lc=;
 b=0ynoRu1AyFV2LvFFYR34st0SC/jAr5tQjbDnPJaq1znm7oBWYUaOz/IwvI9lOlyVX/m6
 EhS07f/hhq5DEEecWw7i7KwDah3aO7y2B1mnn5pHwDf6Cx9kUeEIKVtvGDZsvBqs3win
 8AgcV1PYIZQDEb2cZxDF6Zo8Z1atY1z2jGyXxT+/yrxwlbbFwrFZeLuB3belJ/YoJP+4
 0u8u2dNNx8EmOOPZwNw8ZIZw5MEiHi7wBmZNN5WNtG2yd9rVot1VI5XHsxVWkAGWJkFW
 vMUblrxHhjbsFAG1H2ySbVO0mE3wFoCz5Q1HHIlXAee5K8Zd667zYVo+x4rnN4OeQxlP Ww== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2wvxqqdmk7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Dec 2019 07:55:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0fMcLgM20Jp9lTAAYJBp92pV7VdrwXGh0iAQR1SV6B+7dYZi8ahdVN126JNjjum+2sftnMt1UDnLIaQKekTO8kHgDiSRFfWwsbz4WPs7VY+Vv/2/TdCCt86W4gGfRqopQzHg4xVTBPjL4XTPbzsrkOJYVvVLRi93M9TKdcInG08/4MX7jwIwMEOm7uNUQBULwyQI8DIYgz84NA/PqWwYqhfifL22SH13v+QNCKKZ0TE4XyDDbofanOX9U63f/xIdKGnD/kPKZX1PjJH0jpMJJtpOh9qPXmVIJVsRVA09ZYdK1JZwOP2IDWLurvVfdC+TaBlvucGiBOLUvC32RX8JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DC/lC8IYcG0na4od7nvGHEYLcnHnZVJicZ0y3o5y+Lc=;
 b=GX9NHqpOWHHpxKCnetVXJnlumeSeH/1+IyLufZWYByKNhML/bRYYjpzNxNxnZas7Puwapnbpz6eM3OLhvNBLf2fLwCBsmOnWU/lhwas7fhLKz0B5dLvW2YgzCYmwRV+cY25wqRAY+RFjg+wOQWZiIowjPbSonPSfUlEhmT16ZOipotyW0MiDAXiP5rJA6FWhub81oumiuBQzHg6OvVIq7UQX9oCSbPg+STaK4xsC17LJxEAFQfAuhNntLD/36PDxs32eMdvWuvwTEUh/o8Kh8WnPh5FRx9axi84rZ2zUTSAtpQxyYJ7ro3LfjMH+REI6kVocEnG3oEh+zrEz5nXjsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB3327.namprd02.prod.outlook.com (10.164.187.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Fri, 20 Dec 2019 15:55:30 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029%10]) with mapi id 15.20.2559.016; Fri, 20 Dec
 2019 15:55:30 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Subject: Re: [PATCH v4 0/4] Improve default object property_add uint helpers
Thread-Topic: [PATCH v4 0/4] Improve default object property_add uint helpers
Thread-Index: AQHVtpZ6lIuRGF0HJ0OIoqz7XKz+uqfDI2WAgAALO4A=
Date: Fri, 20 Dec 2019 15:55:30 +0000
Message-ID: <191778FA-1A75-4D23-8A41-732FDE2C3AAA@nutanix.com>
References: <20191219180205.25191-1-felipe@nutanix.com>
 <CAJ+F1C+YmQFnMmWrJOZpKrqp9pEzUqLF7yP-yB2hwsz6h3L3cA@mail.gmail.com>
In-Reply-To: <CAJ+F1C+YmQFnMmWrJOZpKrqp9pEzUqLF7yP-yB2hwsz6h3L3cA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfa92cd2-1043-4899-3811-08d785650a10
x-ms-traffictypediagnostic: MWHPR02MB3327:
x-microsoft-antispam-prvs: <MWHPR02MB332730D74DCEA04996806966D72D0@MWHPR02MB3327.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39860400002)(346002)(136003)(396003)(366004)(189003)(199004)(54534003)(36756003)(5660300002)(71200400001)(186003)(26005)(54906003)(53546011)(316002)(6506007)(8936002)(6512007)(81166006)(6916009)(86362001)(8676002)(2616005)(66476007)(91956017)(66556008)(76116006)(33656002)(66446008)(81156014)(64756008)(478600001)(66946007)(2906002)(4326008)(6486002)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB3327;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g0TtF0tF6UY/L8Ks+UjHvEPh8sA5KCDC/f5nOZyrhfSbeOMHmwQQbKsbKK9eyoXgGOpzYTnT924bRa6T3JH78h5Z+xhXAI3VwkmkxDlfSGjPHYdiw0Jl2vkurnPasR4UFhQFesAI/XHmublbo4WY/4o3Q36AO0xyDIwxLUH2jE044a1hp7vA5ZZ6SZPd8PZ5rvPDryyGVYf9GOqH4fUTu9h0+8vJUBAsvt1diwOt9Nd08ntqbbbqKrS9PwNdXE+YcrDcMkhXxH4cFjRA39wA285YzyifyVwhBCkn3UrkJsvv6KUYcKIfiJr38b48QiBl5I9ydpVS9XNbizFcz8Pl9dXqdM12ZZpDSIoBI+p1oCMZ0qpWR06miQjStCGjA3BFoHEnowhtUpZvrpQdUXMXC+NUjrZDcXu+VTcfwHGVStv03EMuOPHBGawF3wEbspCqhaVKSCjfioAniYr2u2ranJXYjTnZGAswmS41yq1qTxSYoB35CWLk/ybZmOMbWCCi7S8zhYAqhn27u5S5nJegSw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8F04387A7F9AD46934BF16D156E9EF9@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa92cd2-1043-4899-3811-08d785650a10
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 15:55:30.0721 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7tDsjBcP+VQxSaFjVZGcwduGOLjQ1Dkj1uFeE/cHlsok/V4luaWjwQ0VDSyz07z0/RucUCYtq6jTIS46PgVYEMofTKLqJ1zUPoCg4aVLzCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3327
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-20_03:2019-12-17,2019-12-20 signatures=0
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phillipe Mathieu-Daude <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gT24gRGVjIDIwLCAyMDE5LCBhdCAzOjE1IFBNLCBNYXJjLUFuZHLDqSBMdXJlYXUgPG1h
cmNhbmRyZS5sdXJlYXVAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IEhpDQo+IA0KPiBPbiBUaHUs
IERlYyAxOSwgMjAxOSBhdCAxMDowMiBQTSBGZWxpcGUgRnJhbmNpb3NpIDxmZWxpcGVAbnV0YW5p
eC5jb20+IHdyb3RlOg0KPj4gDQo+PiBUaGlzIGltcHJvdmVzIHRoZSBmYW1pbHkgb2Ygb2JqZWN0
X3Byb3BlcnR5X2FkZF91aW50WFhfcHRyIGhlbHBlcnMgYnkgZW5hYmxpbmcNCj4+IGEgZGVmYXVs
dCBnZXR0ZXIvc2V0dGVyIG9ubHkgd2hlbiBkZXNpcmVkLiBUbyBwcmV2ZW50IGFuIEFQSSBiZWhh
dmlvdXJhbCBjaGFuZ2UNCj4+IChmcm9tIGNsaWVudHMgdGhhdCBhbHJlYWR5IHVzZWQgdGhlc2Ug
aGVscGVycyBhbmQgZGlkIG5vdCB3YW50IGEgc2V0dGVyKSwgd2UNCj4+IGFkZCBhIE9CSl9QUk9Q
X0ZMQUdfUkVBRCBmbGFnIHRoYXQgYWxsb3cgY2xpZW50cyB0byBvbmx5IGhhdmUgYSBnZXR0ZXIu
IFBhdGNoIDENCj4+IGVuaGFuY2VzIHRoZSBBUEkgYW5kIG1vZGlmeSBjdXJyZW50IHVzZXJzLg0K
Pj4gDQo+PiBXaGlsZSBtb2RpZnlpbmcgdGhlIGNsaWVudHMgb2YgdGhlIEFQSSwgYSBjb3VwbGUg
b2YgaW1wcm92ZW1lbnQgb3Bwb3J0dW5pdGllcw0KPj4gd2VyZSBvYnNlcnZlZCBpbiBpY2g5LiBU
aGVzZSB3ZXJlIGFkZGVkIGluIHNlcGFyYXRlIHBhdGNoZXMgKDIgYW5kIDMpLg0KPj4gDQo+PiBQ
YXRjaCAzIGNsZWFucyB1cCBhIGxvdCBvZiBleGlzdGluZyBjb2RlIGJ5IG1vdmluZyB2YXJpb3Vz
IG9iamVjdHMgdG8gdGhlDQo+PiBlbmhhbmNlZCBBUEkuIFByZXZpb3VzbHksIHRob3NlIG9iamVj
dHMgaGFkIHRoZWlyIG93biBnZXR0ZXJzL3NldHRlcnMgdGhhdCBvbmx5DQo+PiB1cGRhdGVkIHRo
ZSB2YWx1ZXMgd2l0aG91dCBmdXJ0aGVyIGNoZWNrcy4gU29tZSBvZiB0aGVtIGFjdHVhbGx5IGxh
Y2tlZCBhIGNoZWNrDQo+PiBmb3Igc2V0dGluZyBvdmVyZmxvd3MsIHdoaWNoIGNvdWxkIGhhdmUg
cmVzdWx0ZWQgaW4gdW5kZXNpcmVkIHZhbHVlcyBiZWluZyBzZXQuDQo+PiBUaGUgbmV3IGRlZmF1
bHQgc2V0dGVycyBpbmNsdWRlIGEgY2hlY2sgZm9yIHRoYXQsIG5vdCB1cGRhdGluZyB0aGUgdmFs
dWVzIGluDQo+PiBjYXNlIG9mIGVycm9ycyAoYW5kIHByb3BhZ2F0aW5nIHRoZW0pLiBJZiB0aGV5
IGRpZCBub3QgcHJvdmlkZSBhbiBlcnJvcg0KPj4gcG9pbnRlciwgdGhlbiB0aGF0IGJlaGF2aW91
ciB3YXMgbWFpbnRhaW5lZC4NCj4+IA0KPj4gRmVsaXBlIEZyYW5jaW9zaSAoNCk6DQo+PiAgcW9t
L29iamVjdDogZW5hYmxlIHNldHRlciBmb3IgdWludCB0eXBlcw0KPj4gIGljaDk6IGZpeCBnZXR0
ZXIgdHlwZSBmb3Igc2NpX2ludCBwcm9wZXJ0eQ0KPj4gIGljaDk6IFNpbXBsaWZ5IGljaDlfbHBj
X2luaXRmbg0KPj4gIHFvbS9vYmplY3Q6IFVzZSBjb21tb24gZ2V0L3NldCB1aW50IGhlbHBlcnMN
Cj4+IA0KPj4gaHcvYWNwaS9pY2g5LmMgICAgICAgfCAgOTkgKystLS0tLS0tLS0tLS0tLS0tLS0N
Cj4+IGh3L2FjcGkvcGNpaHAuYyAgICAgIHwgICA3ICstDQo+PiBody9hY3BpL3BpaXg0LmMgICAg
ICB8ICAxMiArLS0NCj4+IGh3L2lzYS9scGNfaWNoOS5jICAgIHwgIDI3ICsrLS0tLQ0KPj4gaHcv
bWlzYy9lZHUuYyAgICAgICAgfCAgMTMgKy0tDQo+PiBody9wY2ktaG9zdC9xMzUuYyAgICB8ICAx
NCArLS0NCj4+IGh3L3BwYy9zcGFwci5jICAgICAgIHwgIDE4ICstLS0NCj4+IGh3L3BwYy9zcGFw
cl9kcmMuYyAgIHwgICAzICstDQo+PiBpbmNsdWRlL3FvbS9vYmplY3QuaCB8ICA0NCArKysrKysr
LS0NCj4+IG1lbW9yeS5jICAgICAgICAgICAgIHwgIDE1ICstLQ0KPj4gcW9tL29iamVjdC5jICAg
ICAgICAgfCAyMTYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQ0K
Pj4gdGFyZ2V0L2FybS9jcHUuYyAgICAgfCAgMjIgKy0tLS0NCj4+IHRhcmdldC9pMzg2L3Nldi5j
ICAgIHwgMTA2ICsrLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gdWkvY29uc29sZS5jICAgICAgICAg
fCAgIDQgKy0NCj4+IDE0IGZpbGVzIGNoYW5nZWQsIDI4MiBpbnNlcnRpb25zKCspLCAzMTggZGVs
ZXRpb25zKC0pDQo+IA0KPiBJdCBjb25mbGljdHMgd2l0aCBzb21lIHJlY2VudCBjaGFuZ2VzLCBz
byB5b3UnbGwgbmVlZCB0byBzZW5kIGEgbmV3DQo+IHZlcnNpb24sIGJ1dCB0aGF0IG9uZSBsb29r
cyBnb29kIHRvIG1lOg0KPiBSZXZpZXdlZC1ieTogTWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5k
cmUubHVyZWF1QHJlZGhhdC5jb20+DQoNCkFoLCBubyB3b3JyaWVzLg0KDQpJIGRpZCBkbyBhIHJl
YmFzZSBvbiB0b3Agb2YgbWFzdGVyIGJlZm9yZSBzZW5kaW5nIG91dCB2NCwgdGhvdWdoLg0KV2hp
Y2ggY29uZmxpY3QgZGlkIHlvdSBzZWU/IEkgY2FuIHJlYmFzZSBsYXRlciBvciBtYXliZSB3aG9t
ZXZlciBpcw0KcHVsbGluZyBjYW4gZml4IHRoZSBtZXJnZSBpZiBpdCdzIHN0cmFpZ2h0Zm9yd2Fy
ZD8NCg0KRi4NCg0KDQo+IA0KPiBQYW9sbywgaXMgaXQgZ29pbmcgdGhyb3VnaCB5b3VyIHF1ZXVl
Pw0KPiANCj4+IA0KPj4gLS0NCj4+IDIuMjAuMQ0KPj4gDQo+PiBDaGFuZ2Vsb2c6DQo+PiB2MS0+
djI6DQo+PiAtIFVwZGF0ZSBzY2lfaW50IGRpcmVjdGx5IGluc3RlYWQgb2YgdXNpbmcgc3RhY2sg
dmFyaWFibGUNCj4+IC0gRGVmaW5pbmcgYW4gZW5oYW5jZWQgT2JqZWN0UHJvcGVydHlGbGFncyBp
bnN0ZWFkIG9mIGp1c3QgJ3JlYWRvbmx5Jw0KPj4gLSBFcnJvcmluZyBvdXQgZGlyZWN0bHkgKGlu
c3RlYWQgb2YgdXNpbmcgZ290b3MpIG9uIGRlZmF1bHQgc2V0dGVycw0KPj4gLSBSZXRhaW5pbmcg
bGFjayBvZiBlcnJwIHBhc3Npbmcgd2hlbiBpdCB3YXNuJ3QgdGhlcmUNCj4+IHYyLT52MzoNCj4+
IC0gUmVuYW1lIGZsYWdzIF9SRCB0byBfUkVBRCBhbmQgX1dSIHRvIF9XUklURQ0KPj4gLSBBZGQg
YSBjb252ZW5pZW5jZSBfUkVBRFdSSVRFIGZsYWcNCj4+IC0gRHJvcCB0aGUgdXNhZ2Ugb2YgVUwg
aW4gdGhlIGJpdCBmbGFnIGRlZmluaXRpb25zDQo+PiB2My0+djQ6DQo+PiAtIERyb3AgY2hhbmdl
cyB0byBody92ZmlvL3BjaS1xdWlya3MuYw0KPiANCj4gDQo+IA0KPiAtLSANCj4gTWFyYy1BbmRy
w6kgTHVyZWF1DQoNCg==

