Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30423C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 17:04:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE3732080C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 17:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="skIkudHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3732080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyf9T-0001RE-3T
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 12:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iyf8O-0000cC-BQ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 12:03:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iyf8M-0003YT-41
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 12:03:39 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:56966)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iyf8L-0003XL-Tk
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 12:03:38 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 013H0xmd027965; Mon, 3 Feb 2020 09:03:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=S/hsNa05moSMD2tngh2+PMx1ezh1C8xyKCM/wJWHLN4=;
 b=skIkudHJ0HZhbvLIJ0vVtR1csfR83ITJ8lKAlwTf7IwmZ6boStV1bPgFVyLh2TASakjy
 1jMudEHlNWpgSaP2CHwrUTYGJidmt5hsqbfoQPpzymGdf+ZlmzMTgio/AYP+e9u2TUgY
 PIa+aUbgU/23d90tn/ZMHTNxL5hHoEIagk7ggc14bNZTVvfbIJluFNQIBcujBbpDZ87H
 IVQIDVVo8pEjtkzUJLq0iYILfNtpFFRGvxjLU5VPXub48/rWHAAlVmuNXKMCA5fwDZdX
 ObLXuBYnn5dEMZNe5ggEZ+unn9sgoTgp4jjPu/F1Y/HBohH8Zvb+IiqiPh8SDAtaSns/ lQ== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2057.outbound.protection.outlook.com [104.47.36.57])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2xw7rem0pb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Feb 2020 09:03:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODgyb4okOovKaQibbbchnYWfHk6MuSzNYYc+8mrQmnfm24Q4J67jyq1QF2vhV1yschzkbaRmRFxHzXg9NChrpmzGa3sSQ33QpV7Zhm+ePMi7b6aWQxjeF+unVqa4v7tYCaAs7UGSZCbk9xG0MzdmSpuoNx5kN6wWXankVr04j5s4D1hYaB2s8y/6N+RT+NQp+VFywGTFZZrJwyYFNLUFQTQ7PCxhe1MKU/XukXuZYeEs62uFXg3KQcz8GppKOufdGJ5qxwCbX0gb662BdMLM+HRtTYnrkqobAe9xny/vQKjckWqo0pL3PsIGEHftV1N1vw3fm3tnifM+JTK10DqbDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/hsNa05moSMD2tngh2+PMx1ezh1C8xyKCM/wJWHLN4=;
 b=FGfQrv7IZCP0TrKaazW3T/Hty7EEQmK6VqPWCqr17kHmPEPYuvXg+3cUKzoig0eYA/813ZzO9yGB0tXRH8Pc8Rto0f1yN3ea/437pxAc+Ze+qTDX9s2G+Dt6SX/3QkJHXgHizv/rXpHcTQrwEdpE02XRy04/Bw0Ly1OwT10B6c8b4h1Df71Lmg5UvCdBcKXPzrlqLK+11krIC00RErCs47jqYl+cXwy54+p/b3P5+1dR6PQ4GBskqzavGew/GcBUCPveCeEzLMKQHPapTrqzixsTtty/gjBczTW9LrkEZSq+Y4WAXB7x8LadjG6VjfBtD+QdlqoxE2hRgTru9B9ClA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2592.namprd02.prod.outlook.com (10.168.206.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Mon, 3 Feb 2020 17:03:34 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c4c8:b406:7827:8a2b]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c4c8:b406:7827:8a2b%6]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 17:03:34 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Subject: Re: [PATCH 0/4] Improve default object property_add uint helpers
Thread-Topic: [PATCH 0/4] Improve default object property_add uint helpers
Thread-Index: AQHV2qpB4YOPAuNSFkKomvr5MQ1voKgJoviAgAAAloCAAA7YgA==
Date: Mon, 3 Feb 2020 17:03:34 +0000
Message-ID: <047C4153-86E0-4479-83F2-79B2DC5EE1E1@nutanix.com>
References: <20200203155412.7706-1-felipe@nutanix.com>
 <22DFA157-0F41-4657-A165-D625210B87A7@nutanix.com>
 <CAJ+F1CL2kTSKTHW5VB=590mh+EJS=iu_at21HtvbbnuvYCBpSw@mail.gmail.com>
In-Reply-To: <CAJ+F1CL2kTSKTHW5VB=590mh+EJS=iu_at21HtvbbnuvYCBpSw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2802be0d-35ae-44c1-1211-08d7a8cb013f
x-ms-traffictypediagnostic: MWHPR02MB2592:
x-microsoft-antispam-prvs: <MWHPR02MB2592B2CB75F04F4F152A5AC0D7000@MWHPR02MB2592.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(136003)(39860400002)(396003)(366004)(189003)(199004)(6916009)(2906002)(6486002)(71200400001)(66946007)(186003)(53546011)(66446008)(6512007)(66556008)(76116006)(66476007)(64756008)(6506007)(91956017)(2616005)(81156014)(81166006)(8936002)(8676002)(26005)(54906003)(966005)(316002)(5660300002)(4326008)(36756003)(33656002)(86362001)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2592;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TW/okiuiSr5Jc71MNdbH7SgW7e8vP/RXUjwrw/6lGx+LL3H3exOV0J8rrRvxf3csqmcAjBTx3v8V41NkyNoKdP2CmU4GCDPvRd4u7RjoE2UBILbakQAjx4FhH8lh7KQYdwVQ4D3f3DMbHvN5/dZlyUKtxBRjU5j6R9q9Dgak/QBu/2Az4PAmZUaav0X5bU8tEnqmsjSBQDDrLg3qbE0AOLu1udE97i6pBT7iqBo+tj0Y2doVMR0QxXwzVb5qVj+RxOdYsavBlZg8CQCaX3sdfKb8UPch4lKLlUyWtPkNCmtlZABsH9arOTtbyZHq3U1ouFDJ70w9ga/XZ2IdeNR3NIhTzY0aV0c4pDFYKnFDuKnrMxdXK3afT37+eYAgQsiBkAT4L5bqbooYxAia3fIrkqrBHytgWARefr4isjmTXQ8oR8UtRDmOQ84Rw8ShuXd4WW7kTeWkWv1ZFvjjNqaknzwkAiqq1gFoEtDFBIl6x0qHKKME350ORn3pXetIzgcSjY9aHPxMapWpX/KPJJNhRA==
x-ms-exchange-antispam-messagedata: wX+TR3GhO13KGz9Ujxszcj14K2tS6iwBrSHWXz7rBaEO0AIwvznS70kgwfgCt1+g7G5yiMX9aZLA/QVJ0zoxvZI6UCcerUO2ZXE1BocWBpSk1B7l4LPGrFCSKYjrF1MYqorVBOrNQ13p/cb2BE6EiQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4154E7CC30FEE64889B68E21F5EDF86A@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2802be0d-35ae-44c1-1211-08d7a8cb013f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 17:03:34.7353 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nPXrXCyWS5VK34W+wbPtJbNq+c8rPw/xPuffbbOUPYQT7e9NHrjk+w8WTVhDWteTa5YCNje1uMr0VunBF/9IpXwK/NYf9bRljCp5N1RLpPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2592
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-03_06:2020-02-02,
 2020-02-03 signatures=0
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Phillipe Mathieu-Daude <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gT24gRmViIDMsIDIwMjAsIGF0IDQ6MTAgUE0sIE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFy
Y2FuZHJlLmx1cmVhdUBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gSGkNCj4gDQo+IE9uIE1vbiwg
RmViIDMsIDIwMjAgYXQgNTowOCBQTSBGZWxpcGUgRnJhbmNpb3NpIDxmZWxpcGVAbnV0YW5peC5j
b20+IHdyb3RlOg0KPj4gDQo+PiBPb3BzLCBJIGNvbXBsZXRlbHkgZm9yZ290IHRvIGFkZCBhICJ2
NSIgb24gdGhlIHN1YmplY3QgbGluZS4NCj4+IA0KPj4gKFRoZSBjaGFuZ2Vsb2cgaXMgdGhlcmUu
KQ0KPj4gDQo+PiBMZXQgbWUga25vdyBpZiBJIHNob3VsZCByZXNlbmQuDQo+PiANCj4+IEYuDQo+
PiANCj4+PiBPbiBGZWIgMywgMjAyMCwgYXQgMzo1NCBQTSwgRmVsaXBlIEZyYW5jaW9zaSA8ZmVs
aXBlQG51dGFuaXguY29tPiB3cm90ZToNCj4+PiANCj4+PiBUaGlzIGltcHJvdmVzIHRoZSBmYW1p
bHkgb2Ygb2JqZWN0X3Byb3BlcnR5X2FkZF91aW50WFhfcHRyIGhlbHBlcnMgYnkgZW5hYmxpbmcN
Cj4+PiBhIGRlZmF1bHQgZ2V0dGVyL3NldHRlciBvbmx5IHdoZW4gZGVzaXJlZC4gVG8gcHJldmVu
dCBhbiBBUEkgYmVoYXZpb3VyYWwgY2hhbmdlDQo+Pj4gKGZyb20gY2xpZW50cyB0aGF0IGFscmVh
ZHkgdXNlZCB0aGVzZSBoZWxwZXJzIGFuZCBkaWQgbm90IHdhbnQgYSBzZXR0ZXIpLCB3ZQ0KPj4+
IGFkZCBhIE9CSl9QUk9QX0ZMQUdfUkVBRCBmbGFnIHRoYXQgYWxsb3cgY2xpZW50cyB0byBvbmx5
IGhhdmUgYSBnZXR0ZXIuIFBhdGNoIDENCj4+PiBlbmhhbmNlcyB0aGUgQVBJIGFuZCBtb2RpZnkg
Y3VycmVudCB1c2Vycy4NCj4+PiANCj4+PiBXaGlsZSBtb2RpZnlpbmcgdGhlIGNsaWVudHMgb2Yg
dGhlIEFQSSwgYSBjb3VwbGUgb2YgaW1wcm92ZW1lbnQgb3Bwb3J0dW5pdGllcw0KPj4+IHdlcmUg
b2JzZXJ2ZWQgaW4gaWNoOS4gVGhlc2Ugd2VyZSBhZGRlZCBpbiBzZXBhcmF0ZSBwYXRjaGVzICgy
IGFuZCAzKS4NCj4+PiANCj4+PiBQYXRjaCA0IGNsZWFucyB1cCBhIGxvdCBvZiBleGlzdGluZyBj
b2RlIGJ5IG1vdmluZyB2YXJpb3VzIG9iamVjdHMgdG8gdGhlDQo+Pj4gZW5oYW5jZWQgQVBJLiBQ
cmV2aW91c2x5LCB0aG9zZSBvYmplY3RzIGhhZCB0aGVpciBvd24gZ2V0dGVycy9zZXR0ZXJzIHRo
YXQgb25seQ0KPj4+IHVwZGF0ZWQgdGhlIHZhbHVlcyB3aXRob3V0IGZ1cnRoZXIgY2hlY2tzLiBT
b21lIG9mIHRoZW0gYWN0dWFsbHkgbGFja2VkIGEgY2hlY2sNCj4+PiBmb3Igc2V0dGluZyBvdmVy
Zmxvd3MsIHdoaWNoIGNvdWxkIGhhdmUgcmVzdWx0ZWQgaW4gdW5kZXNpcmVkIHZhbHVlcyBiZWlu
ZyBzZXQuDQo+Pj4gVGhlIG5ldyBkZWZhdWx0IHNldHRlcnMgaW5jbHVkZSBhIGNoZWNrIGZvciB0
aGF0LCBub3QgdXBkYXRpbmcgdGhlIHZhbHVlcyBpbg0KPj4+IGNhc2Ugb2YgZXJyb3JzIChhbmQg
cHJvcGFnYXRpbmcgdGhlbSkuIElmIHRoZXkgZGlkIG5vdCBwcm92aWRlIGFuIGVycm9yDQo+Pj4g
cG9pbnRlciwgdGhlbiB0aGF0IGJlaGF2aW91ciB3YXMgbWFpbnRhaW5lZC4NCj4+PiANCj4+PiBG
ZWxpcGUgRnJhbmNpb3NpICg0KToNCj4+PiBxb20vb2JqZWN0OiBlbmFibGUgc2V0dGVyIGZvciB1
aW50IHR5cGVzDQo+Pj4gaWNoOTogZml4IGdldHRlciB0eXBlIGZvciBzY2lfaW50IHByb3BlcnR5
DQo+Pj4gaWNoOTogU2ltcGxpZnkgaWNoOV9scGNfaW5pdGZuDQo+Pj4gcW9tL29iamVjdDogVXNl
IGNvbW1vbiBnZXQvc2V0IHVpbnQgaGVscGVycw0KPj4+IA0KPj4+IGh3L2FjcGkvaWNoOS5jICAg
ICAgIHwgIDk5ICsrLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4gaHcvYWNwaS9wY2locC5jICAgICAg
fCAgIDcgKy0NCj4+PiBody9hY3BpL3BpaXg0LmMgICAgICB8ICAxMiArLS0NCj4+PiBody9pc2Ev
bHBjX2ljaDkuYyAgICB8ICAyNyArKy0tLS0NCj4+PiBody9taXNjL2VkdS5jICAgICAgICB8ICAx
MyArLS0NCj4+PiBody9wY2ktaG9zdC9xMzUuYyAgICB8ICAxNCArLS0NCj4+PiBody9wcGMvc3Bh
cHIuYyAgICAgICB8ICAxOCArLS0tDQo+Pj4gaHcvcHBjL3NwYXByX2RyYy5jICAgfCAgIDMgKy0N
Cj4+PiBpbmNsdWRlL3FvbS9vYmplY3QuaCB8ICA0OCArKysrKysrKy0tDQo+Pj4gbWVtb3J5LmMg
ICAgICAgICAgICAgfCAgMTUgKy0tDQo+Pj4gcW9tL29iamVjdC5jICAgICAgICAgfCAyMTQgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQ0KPj4+IHRhcmdldC9hcm0v
Y3B1LmMgICAgIHwgIDIyICstLS0tDQo+Pj4gdGFyZ2V0L2kzODYvc2V2LmMgICAgfCAxMDYgKyst
LS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4gdWkvY29uc29sZS5jICAgICAgICAgfCAgIDQgKy0NCj4+
PiAxNCBmaWxlcyBjaGFuZ2VkLCAyODMgaW5zZXJ0aW9ucygrKSwgMzE5IGRlbGV0aW9ucygtKQ0K
Pj4+IA0KPj4+IC0tDQo+Pj4gMi4yMC4xDQo+Pj4gDQo+Pj4gQ2hhbmdlbG9nOg0KPj4+IHYxLT52
MjoNCj4+PiAtIFVwZGF0ZSBzY2lfaW50IGRpcmVjdGx5IGluc3RlYWQgb2YgdXNpbmcgc3RhY2sg
dmFyaWFibGUNCj4+PiAtIERlZmluaW5nIGFuIGVuaGFuY2VkIE9iamVjdFByb3BlcnR5RmxhZ3Mg
aW5zdGVhZCBvZiBqdXN0ICdyZWFkb25seScNCj4+PiAtIEVycm9yaW5nIG91dCBkaXJlY3RseSAo
aW5zdGVhZCBvZiB1c2luZyBnb3Rvcykgb24gZGVmYXVsdCBzZXR0ZXJzDQo+Pj4gLSBSZXRhaW5p
bmcgbGFjayBvZiBlcnJwIHBhc3Npbmcgd2hlbiBpdCB3YXNuJ3QgdGhlcmUNCj4+PiB2Mi0+djM6
DQo+Pj4gLSBSZW5hbWUgZmxhZ3MgX1JEIHRvIF9SRUFEIGFuZCBfV1IgdG8gX1dSSVRFDQo+Pj4g
LSBBZGQgYSBjb252ZW5pZW5jZSBfUkVBRFdSSVRFIGZsYWcNCj4+PiAtIERyb3AgdGhlIHVzYWdl
IG9mIFVMIGluIHRoZSBiaXQgZmxhZyBkZWZpbml0aW9ucw0KPj4+IHYzLT52NDoNCj4+PiAtIERy
b3AgY2hhbmdlcyB0byBody92ZmlvL3BjaS1xdWlya3MuYw0KPj4+IHY0LT52NToNCj4+PiAtIFJl
YmFzZSBvbiBsYXRlc3QgbWFzdGVyDQo+Pj4gLSBBdmFpbGFibGUgaGVyZTogaHR0cHM6Ly9naXRo
dWIuY29tL2ZyYW5jaW96enkvcWVtdS90cmVlL2F1dG9zZXR0ZXJzDQo+IA0KPiBUaGFua3MgZm9y
IHRoZSByZWJhc2UsIGl0IGxvb2tzIGdvb2Qgb3ZlcmFsbCwgYnV0Og0KPiANCj4gcW9tL29iamVj
dC5jOjI3MDc6MTogZXJyb3I6IGNvbnRyb2wgcmVhY2hlcyBlbmQgb2Ygbm9uLXZvaWQgZnVuY3Rp
b24NCj4gWy1XZXJyb3I9cmV0dXJuLXR5cGVdDQoNClRoYXQgd2FzIGFuIG92ZXJzaWdodC4gOikN
Cg0KTGV0IG1lIGZpeCBpdCBhbmQgc2VuZCBhIGNvcnJlY3RlZCAodjYpIHN1YmplY3QgbGluZS4N
Cg0KRmVsaXBlDQoNCj4gDQo+IA0KPiAtLSANCj4gTWFyYy1BbmRyw6kgTHVyZWF1DQoNCg==

