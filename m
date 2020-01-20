Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AFAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:10:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ABE92073D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="fPE5zG/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABE92073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itUwz-0002vF-7E
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 06:10:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1itUjn-0001H1-RY
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:56:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ani.sinha@nutanix.com>) id 1itUjj-0003ri-Ln
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:56:55 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:65268)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ani.sinha@nutanix.com>)
 id 1itUjj-0003pY-Cg
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:56:51 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00KAsjnj018089; Mon, 20 Jan 2020 02:56:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=+KZ/56oi/TOHKHYvDrgzx1gvetRHvrT7eRyRzN02Ewk=;
 b=fPE5zG/WYL8nzCC3kuDOmZJjMREcPdf9HoLK0MPppFkmb+qmrRforNKpYXPB6ag5KVo1
 8y5/j9JZN1bH9uhuDgbwkKzL1B/YC6AHpyrNVJXj5nlnqCow031Yadzr+PEeEvexbFJy
 hlJkuRSnQqln8oVp0SMlWG7/PygGUYeuevO/j2cof/MfNuzRhvLTOK1zvamFkNHa5bpN
 vDoM4XZXyO6b6oe+iZsE4IZL0+2r5P7BkOYByV+4JaZA8QKm/nsWWlfPuHYdhUkVbXGQ
 pEsDLZIWrYGoe2Xcey6W8lXOH4u4vh3FtrN84APOFeYeAtRJs7c6AHKmfPWyg0CfNt6I AA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2xm2e62t4r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Jan 2020 02:56:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPWL+c6dn8cV0xQfezT3LNUbhmUkVyYy3/y+Zd6CxgFKMdqALrtDvE6RBvB6KPUDVJvfd0pphn7yeV1mLCD2wRXTXF2L5sp/1wQF5GqWGmbuJ6S4Sfw3xxLBMy45y0vzf/V3lZoOp5h2hCJlUX6TY5nfyxIir326iQo16o7jhlfLWu38Sx2T60w1Nm2KaqZTeM6IOhZPk0R85mOdktrF82ML44MrkcQ3Slx8Jem2uO8pNynXwMsEvXKMDZINLxS4dy0Xu6Y8KbDoqJngzTfh297H/RRLlFdanX8FDSYAkSxv/5VYfDYjaeF+T3m8nVxUWVJbFbHGCUOykOdcvw68/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KZ/56oi/TOHKHYvDrgzx1gvetRHvrT7eRyRzN02Ewk=;
 b=NlZddtiYAJ/vxl/rWsxrbN2Mcco1C9GotMb7RxgpvbL+kQmQjZ66PNQE0GgwkW9ocLFlc7UHVuKOZ4nTvGcUvS7JjObZ+B52S/BrPSSaChnJC7avVtDNRIWBtz1kYgVDwidbpRBsLhfAa+VKHZFuQe0qMiEbbSLZxWCr34dosGUOlPbKG2TWBOy83xwSBnUFgpXzZFmQblAaqTDuwC5WJy6TnwqfFg845nuEIJZoksIqIhi5JEW1vVy53MOSC+Vzx7zXrCbGRw56uVBA+/v0SIqoZTzYBwA4I3R0+6F2FjI5fmUvPzYmi9u1AHQvc+M5nbZi0h4Umf41cYa8PSdGGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB6303.namprd02.prod.outlook.com (52.132.174.13) by
 MN2PR02MB6720.namprd02.prod.outlook.com (52.135.50.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.21; Mon, 20 Jan 2020 10:56:43 +0000
Received: from MN2PR02MB6303.namprd02.prod.outlook.com
 ([fe80::38a1:eb0a:926a:20ad]) by MN2PR02MB6303.namprd02.prod.outlook.com
 ([fe80::38a1:eb0a:926a:20ad%5]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 10:56:43 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH] i386: pass CLZERO to guests with EPYC CPU model on AMD
 ZEN platform
Thread-Topic: [PATCH] i386: pass CLZERO to guests with EPYC CPU model on AMD
 ZEN platform
Thread-Index: AQHVtYKm5uylcpuSJ0uEmLmhvuRW56e/yJSAgAA3UQCAM5WrAA==
Date: Mon, 20 Jan 2020 10:56:43 +0000
Message-ID: <D67E411E-4398-4F1B-A397-E637BCD4F666@nutanix.com>
References: <1576659933-37123-1-git-send-email-ani.sinha@nutanix.com>
 <2883fd0e-191a-c5a4-be1c-04442c8de1c9@redhat.com>
 <20191218151144.GN498046@habkost.net>
In-Reply-To: <20191218151144.GN498046@habkost.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [115.110.205.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa51eb30-61fa-4844-820f-08d79d976f9f
x-ms-traffictypediagnostic: MN2PR02MB6720:
x-microsoft-antispam-prvs: <MN2PR02MB672013ECD4978B71F01911BDF1320@MN2PR02MB6720.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(376002)(366004)(396003)(39860400002)(189003)(199004)(5660300002)(2906002)(71200400001)(8676002)(76116006)(66946007)(91956017)(66446008)(44832011)(26005)(66476007)(186003)(64756008)(36756003)(54906003)(6506007)(8936002)(66556008)(53546011)(316002)(81166006)(81156014)(2616005)(6512007)(966005)(478600001)(4326008)(6486002)(86362001)(6916009)(33656002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR02MB6720;
 H:MN2PR02MB6303.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JKbXOezMW2tMFfWoqG75517btefIVgBQPxOwFHR9sPSan+X/gdqyPLkkqBWXGqbppG3HAlQpcQ7y7/+DAIBoxriVydmuC+voZkqXmVPbbOizbOhweQhXr2yiulCV+ccZPEZ6nDHB8bcn8eLXG1IlYFouUCHDsZkXblJGt1Cku5a22U0S9wt7LYBQD72M5CglP+t3EK43an9mPHOCP1+y3V+mqWLKfaL9oT2dOhhntJIFj4sEw+aUSrV0t3bBd9+qh2nwluvWxGB0PG67+FlfqEBm3AZllqD3zdYbWZ9i+1jeg4Qftx4Kd5uSnC/3cA9jTmcOaWjo7J0SM0iATljYUyJ22Q+aQDwkLJGRb5AJRLt3BztulcoMFEqMbAgcc+rNHR9nURLUhiS267o8UlK+170nkF5EYaGQp6KZtzSuN0yl1FivobIdJwJSwArZMmmz/RULo3KeTqsUV5xZVC8G7wOFsWbIyqpchaIVyj6cEijTQO7bdGR6dh5GWkageoHTjSUazstdtCNF/i5LF1vgdw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4FC46F379988E48BE3D48675B673A45@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa51eb30-61fa-4844-820f-08d79d976f9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 10:56:43.3442 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rm+0YSGm6LX1UV5xhZ/n/a2tVqOY3syGJwkeiW1josM6HprCGd1z3pEtW8YjdKhIN15u/EDSL+hp0hvSSONVPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6720
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-20_02:2020-01-20,
 2020-01-20 signatures=0
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

U29ycnkgRWR1YXJkbywgaXQgdG9vayBhIGxpdHRsZSB3aGlsZSBmb3IgbWUgdG8gZ2V0IHRvIHRo
aXMgdGhyZWFkIGFnYWluLg0KDQo+IE9uIERlYyAxOCwgMjAxOSwgYXQgODo0MSBQTSwgRWR1YXJk
byBIYWJrb3N0IDxlaGFia29zdEByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgRGVj
IDE4LCAyMDE5IGF0IDEyOjUzOjQ1UE0gKzAxMDAsIFBhb2xvIEJvbnppbmkgd3JvdGU6DQo+PiBP
biAxOC8xMi8xOSAxMDowNSwgQW5pIFNpbmhhIHdyb3RlOg0KPj4+IENMWkVSTyBDUFVJRCBzaG91
bGQgYmUgcGFzc2VkIG9uIHRvIHRoZSBndWVzdHMgdGhhdCB1c2UgRVBZQyBvciBFUFlDLUlCUEIg
Q1BVDQo+Pj4gbW9kZWwgd2hlbiB0aGUgQU1EIFpFTiBiYXNlZCBob3N0IHN1cHBvcnRzIGl0LiBU
aGlzIGNoYW5nZSBtYWtlcyBpdCByZWNvZ25pemUNCj4+PiB0aGlzIENQVUlEIGZvciBndWVzdHMg
d2hpY2ggdXNlIEVQWUMgb3IgRVBZQy1JQlBCIENQVSBtb2RlbC4NCj4gDQo+IENhbiB5b3UgY2xh
cmlmeSB3aGF0J3MgdGhlIGludGVuZGVkIHVzZSBjYXNlIGhlcmU/ICBXaHkgdGhlDQo+ICJpZiBo
b3N0IHN1cHBvcnRzIGl0IiBjb25kaXRpb25hbD8NCg0KTG9va2luZyBhdCBodHRwczovL3d3dy5h
bWQuY29tL3N5c3RlbS9maWxlcy9UZWNoRG9jcy8yNDU5NC5wZGYgLCBpdCBzYXlzIDoNCg0KIlRo
ZSBDTFpFUk8gaW5zdHJ1Y3Rpb24gaXMgc3VwcG9ydGVkIGlmIHRoZSBmZWF0dXJlIGZsYWcgQ1BV
SUQgRm44MDAwXzAwMDhfRUJYW0NMWkVST10gaXMgc2V0LuKAnQ0KDQpUaGlzIEkgaW50ZXJwcmV0
ZWQgdG8gbWVhbiB0aGF0IG5vdCBhbGwgQU1EIFplbiBhcmNoaXRlY3R1cmVzIHN1cHBvcnRzIGl0
LiBTbyB3aGVuIHRoZSBob3N0IGRvZXMgc3VwcG9ydCBpdCwgdGhpcyBDUFVJRCBzaG91bGQgYmUg
cGFzc2VkIG9uIHRvIHRoZSBndWVzdCBhcyB3ZWxsLg0KDQoNCj4gDQo+IElmIHlvdSBuZWVkIGhv
c3QtZGVwZW5kZW50IENQVSBjb25maWd1cmF0aW9uLCAiLWNwdSBob3N0IiAob3IgdGhlDQo+IGxp
YnZpcnQgImhvc3QtbW9kZWwiIG1vZGUpIGlzIHRoZSBtb3N0IGFwcHJvcHJpYXRlIHNvbHV0aW9u
Lg0KDQpZZXMgdGhhdCBpcyBhbiBvcHRpb24gYnV0IHdlIGFyZSBnb2luZyB0byB1c2UgRVBZQy1J
QlBCIG1vZGVsIGZvciBub3cuIA0KDQoNCj4gDQo+Pj4gDQo+Pj4gU2lnbmVkLW9mZi1ieTogQW5p
IFNpbmhhIDxhbmkuc2luaGFAbnV0YW5peC5jb20+DQo+Pj4gLS0tDQo+Pj4gdGFyZ2V0L2kzODYv
Y3B1LmMgfCAyICsrDQo+Pj4gMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPj4+IA0K
Pj4+IGRpZmYgLS1naXQgYS90YXJnZXQvaTM4Ni9jcHUuYyBiL3RhcmdldC9pMzg2L2NwdS5jDQo+
Pj4gaW5kZXggNjlmNTE4YS4uNTVmMDY5MSAxMDA2NDQNCj4+PiAtLS0gYS90YXJnZXQvaTM4Ni9j
cHUuYw0KPj4+ICsrKyBiL3RhcmdldC9pMzg2L2NwdS5jDQo+Pj4gQEAgLTM4MTMsNiArMzgxMyw4
IEBAIHN0YXRpYyBYODZDUFVEZWZpbml0aW9uIGJ1aWx0aW5feDg2X2RlZnNbXSA9IHsNCj4+PiAg
ICAgICAgICAgICBDUFVJRF9FWFQzX01JU0FMSUdOU1NFIHwgQ1BVSURfRVhUM19TU0U0QSB8IENQ
VUlEX0VYVDNfQUJNIHwNCj4+PiAgICAgICAgICAgICBDUFVJRF9FWFQzX0NSOExFRyB8IENQVUlE
X0VYVDNfU1ZNIHwgQ1BVSURfRVhUM19MQUhGX0xNIHwNCj4+PiAgICAgICAgICAgICBDUFVJRF9F
WFQzX1RPUE9FWFQsDQo+Pj4gKyAgICAgICAgLmZlYXR1cmVzW0ZFQVRfODAwMF8wMDA4X0VCWF0g
PQ0KPj4+ICsgICAgICAgICAgICBDUFVJRF84MDAwXzAwMDhfRUJYX0NMWkVSTywNCj4+PiAgICAg
ICAgIC5mZWF0dXJlc1tGRUFUXzdfMF9FQlhdID0NCj4+PiAgICAgICAgICAgICBDUFVJRF83XzBf
RUJYX0ZTR1NCQVNFIHwgQ1BVSURfN18wX0VCWF9CTUkxIHwgQ1BVSURfN18wX0VCWF9BVlgyIHwN
Cj4+PiAgICAgICAgICAgICBDUFVJRF83XzBfRUJYX1NNRVAgfCBDUFVJRF83XzBfRUJYX0JNSTIg
fCBDUFVJRF83XzBfRUJYX1JEU0VFRCB8DQo+Pj4gDQo+PiANCj4+IFRoaXMgbmVlZHMgdG8gYmUg
ZG9uZSBvbmx5IGZvciBuZXdlciBtYWNoaW5lIHR5cGUgKG9yIGlzIGl0IENQVSBtb2RlbA0KPj4g
dmVyc2lvbnMgbm93PyBuZWVkIEVkdWFyZG8gdG8gcmVzcG9uZCkuDQo+IA0KPiBJZiB3ZSB3YW50
IHRvIGFkZCBpdCwgaXQgaGFzIHRvIGJlIGRvbmUgYXMgYSBuZXcgQ1BVIG1vZGVsIHZlcnNpb24u
DQoNCkkgc2VlIHdoYXQgeW91IG1lYW4uIA0KDQo+IA0KPiBCdXQgSSBkb24ndCBrbm93IHlldCBp
ZiB3ZSB3YW50IHRvIGFkZCBpdC4gIERvIGFsbCBFUFlDIENQVXMgaGF2ZQ0KPiBDTFpFUk8gYXZh
aWxhYmxlPyAgSWYgbm90LCBpdCdzIHByb2JhYmx5IG5vdCBhZHZpc2FibGUgdG8gYWRkIGl0DQo+
IHRvIEVQWUMgKGV2ZW4gaWYgaXQncyBqdXN0IG9uIEVQWUMtdjMpLg0KDQpPayBzbyBJIHRoaW5r
IHdlIG5lZWQgdG8gZ2V0IHRoaXMgY2xhcmlmaWVkIGZyb20gQU1EIGlmIGFsbCB0aGVpciBFUFlD
IHBsYXRmb3JtcyBzdXBwb3J0cyB0aGlzIENQVUlEIG9yIG5vdC4gSXMgdGhlcmUgYW55IGNvbnRh
Y3QgcG9pbnQgd2l0aGluIEFNRCB3aGVyZSB3ZSBjYW4gZ2V0IHRoaXMgaW5mb3JtYXRpb24/DQoN
CkZvciBvdXIgdXNlIGNhc2UsIEkganVzdCB2ZXJpZmllZCB0aGF0IGV2ZW4gd2l0aG91dCB0aGlz
IHBhdGNoLCBpZiB3ZSBwYXNzIENMWkVSTyB0aHJvdWdoIGxpYnZpcnQgQ1BVIGRlZmluaXRpb24g
eG1sLCBsaWtlICIgPGZlYXR1cmUgcG9saWN5PSdyZXF1aXJlJyBuYW1lPSdjbHplcm/igJkvPuKA
nSwgaXQgZ2V0cyBwYXNzZWQgb24gdG8gdGhlIGd1ZXN0LiBTbyB0aGlzIHBhdGNoIGlzIG5vdCBz
dXBlciBjcml0aWNhbCBmb3IgdXMuDQoNClRoYW5rcywNCkFuaQ0KDQoNCj4gDQo+IC0tIA0KPiBF
ZHVhcmRvDQoNCg==

