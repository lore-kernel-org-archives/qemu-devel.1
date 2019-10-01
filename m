Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4ED8C388F3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 11:39:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D08621906
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 11:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="XmrImnCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D08621906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFGVE-0007KC-MD
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 07:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iFGU5-0006s1-91
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 07:38:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iFGU2-0007mJ-Go
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 07:38:24 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:12698)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iFGU2-0007lS-98
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 07:38:22 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x91BZM0B020923; Tue, 1 Oct 2019 04:38:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=LJ96SdD2bJWCVy+wK5L4/U3yvlxiSA5ilFJzhiodWIw=;
 b=XmrImnCgF0stwtyiQ65FpAyslW5PgpTfhCKfnX4PqDcMgnMs+t0MypLcgRwA2qdEEy7x
 hD7x8aQ2quJda9ydyBXA/JsgJb6s9gT+Jctpunm5BXXa1e9+wlLVkoCJP02t3WnqjTc8
 o3f/R3vxEzi1PisE5UEJXjuIgRhoX0vMA8/ccOB2pcztZucA9Gplg3cOHamZIekpPz3n
 slttadVQgoTSU4gB4WdHqyhQGlXfvPC1kcF+phxr7Q1LyvtbKy477pgCFCdjoddEajcT
 +UmeqFiEya4Glb7QTu2C6DDxEmPL2lzU6eu38ygS5NMfUmaVqR6KB/7ROS+jossA/Mjd yg== 
Received: from nam01-bn3-obe.outbound.protection.outlook.com
 (mail-bn3nam01lp2057.outbound.protection.outlook.com [104.47.33.57])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2va6ufdqrv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 04:38:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eckck62GY1R/DwQa++HqEO5/whhDN1gYT4UzeHxqEhaYgv9ahuo/xmwYICUhVlUyZ9G2KuF4tfYheZONOUt3GFRoIh/P3JJgxET3HUlHfwDyhxElOdmlxNj19c0aHA++Ps3cWiQQcDXLBjeqEAqe6eAKCfVpIUopckUChdP4NNdoutj7WQuj3tb2Fz/Y/X59bMrwZWqYj2DApP67jQcfT+USWnQaB+O582Sgl6acZ4yB9F67oKJuOo/dAwRO5okqJ4db/SWQ+9izBp4Bz0oGt6fWgiUtQDvVQs2CbTdTjJKPUBHBSvdIt8TIuPfo81dkaMfGoES4BqX7Ms4ThX3mQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJ96SdD2bJWCVy+wK5L4/U3yvlxiSA5ilFJzhiodWIw=;
 b=RAr+PHyz0gHOWxIsQ/C22rufhK4eitAaJ0VzFYYBgXbWDI+KUUSrcuz2kCj7J0c1Ih/mnDjlrhBI4sJMvv/QfIwU2SpNpmdwS9w7MgfILfVAYfn0DElnzI6iNDHq/Gs7xbZ0ziv6TRRhObhjDFGUh0QGXU8V1U1Dt6DMy7knYYAGZ19VMjaqd3AskyiBRgwy44d/aN/e4iAxbz6dtISwlMoxIGGuPfOD5FaYPTX8Dr/8+aGsB6IabvJ03eAXu/F1o2XBrU3ThYHAl6yb3ZBLD48hcs4us2fi6q12vIMurIS07srAZXlKYOC7OIdDrwJ17YnhHRJ46oZd3xZhf7s0RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2720.namprd02.prod.outlook.com (10.175.51.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.16; Tue, 1 Oct 2019 11:38:14 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::2867:91aa:a3e:e278]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::2867:91aa:a3e:e278%2]) with mapi id 15.20.2305.022; Tue, 1 Oct 2019
 11:38:14 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Subject: Re: Thoughts on VM fence infrastructure
Thread-Topic: Thoughts on VM fence infrastructure
Thread-Index: AQHVd3oUrA00x04Zc0W5TGhiZaAe96dESBkAgAAVQwCAAATTAIAAD5wAgAADW4CAAAYcgIAAB1MAgAAXoICAANnrgIAAGdoAgAAJwYCAAAQ+AIAABr+AgAAHvoA=
Date: Tue, 1 Oct 2019 11:38:14 +0000
Message-ID: <696F04C1-D3FD-4E03-86B1-1C926306D43E@nutanix.com>
References: <20190930160316.GH2759@work-vm>
 <417D4B96-2641-4DA8-B00B-3302E211E939@nutanix.com>
 <20190930171109.GL2759@work-vm>
 <CA2CBDDF-99ED-4693-8622-89D4F2E71DE9@nutanix.com>
 <20190930175914.GM2759@work-vm>
 <DE224DBA-FEFF-42C4-8F04-43BA75DF26AA@nutanix.com>
 <20191001082345.GA2781@work-vm>
 <2248E813-102F-4E60-AF9B-A5A2F21C1687@nutanix.com>
 <20191001103111.GF26133@redhat.com>
 <E1A62EE3-9EC0-49DC-A871-C6424F5FD807@nutanix.com>
 <20191001111031.GH26133@redhat.com>
In-Reply-To: <20191001111031.GH26133@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23ca8eff-690f-442b-efba-08d74663d876
x-ms-traffictypediagnostic: MWHPR02MB2720:
x-ms-exchange-purlcount: 6
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB27207F6EBCDB647551CF163AD79D0@MWHPR02MB2720.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(39860400002)(396003)(366004)(376002)(52054003)(199004)(189003)(26005)(102836004)(33656002)(4326008)(229853002)(66946007)(91956017)(76116006)(71200400001)(478600001)(71190400001)(86362001)(66476007)(6486002)(66556008)(64756008)(66446008)(99286004)(8936002)(54906003)(8676002)(6246003)(81156014)(81166006)(966005)(6506007)(53546011)(2906002)(76176011)(316002)(186003)(5660300002)(7736002)(6306002)(6916009)(305945005)(6512007)(36756003)(6116002)(3846002)(66066001)(25786009)(486006)(11346002)(14444005)(256004)(2616005)(476003)(6436002)(14454004)(446003)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2720;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NVlPZM56lsURescKfxzW7zQsqBkFtKT2hYjodXH1zul5PyCZAvNiOZLe9rJEG1mYdd2Uo7uDqSDFGrunJ06JtxT7zrY/L1YO11X+QLmnOe9pY47tImq8cGdoQlMRCFmNNU6DkrSicx8QnKEixJSW4E1M/A19YpTRlASh9rwlzKGeSjgry9seDMpsahVkny+IEZHm6qbpDnTCEkIJbm3Ptukk5yd0t/9f7SIY0o2ez3uuHRYEP3NPjLRGOrvmlhGpzTEwMUkh10T9q6xK3sqc22NzwuUczBaMTiUSDkne6JMnYzDbag+DZ7umLvBXBxHC7SfFla+NUgoGeJ/cdFhv9FMoMjqPiLbBKT0urO3Tb/njFG/kl5BONIH/w5r4PGb6JDtFdHyDZ7eKdtKt8WBpV34styxbre2ObYcTv1jb6g5R2nFTiFTDfgj9+UUIoKGh+vcoquDktFbqxOvHtNy5pQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FD5BE7B7B02A947ACBC812B655E9DC1@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ca8eff-690f-442b-efba-08d74663d876
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 11:38:14.2255 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yyX+NaqJzL1ZHQ5y5CzvhJq3po2njRO4s4RzgUn18EUS6CTe8pjVmaA+Hme3XMNR1hasp4Tn0uZ67Nd6Rn6d6Z77O8vMqFHCzcZFcAG1A4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2720
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-01_06:2019-10-01,2019-10-01 signatures=0
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
Cc: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>,
 Aditya Ramesh <aramesh@nutanix.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gT24gT2N0IDEsIDIwMTksIGF0IDEyOjEwIFBNLCBEYW5pZWwgUC4gQmVycmFuZ8OpIDxi
ZXJyYW5nZUByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgT2N0IDAxLCAyMDE5IGF0
IDEwOjQ2OjI0QU0gKzAwMDAsIEZlbGlwZSBGcmFuY2lvc2kgd3JvdGU6DQo+PiBIaSBEYW5pZWwh
DQo+PiANCj4+IA0KPj4+IE9uIE9jdCAxLCAyMDE5LCBhdCAxMTozMSBBTSwgRGFuaWVsIFAuIEJl
cnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gT24gVHVlLCBP
Y3QgMDEsIDIwMTkgYXQgMDk6NTY6MTdBTSArMDAwMCwgRmVsaXBlIEZyYW5jaW9zaSB3cm90ZToN
Cj4+IA0KPj4gKEFwb2xvZ2llcyBmb3IgdGhlIG1hbmdsZWQgVVJMLCBub3RoaW5nIEkgY2FuIGRv
IGFib3V0IHRoYXQuKSA6KA0KPj4gDQo+PiBUaGVyZSBhcmUgc2V2ZXJhbCBwb2ludHMgd2hpY2gg
ZmF2b3VyIGFkZGluZyB0aGlzIHRvIFFlbXU6DQo+PiAtIE5vdCBhbGwgZW52aXJvbm1lbnRzIHVz
ZSBzeXN0ZW1kLg0KPiANCj4gU3VyZSwgaWYgeW91IHdhbnQgdG8gY29wZSB3aXRoIHRoYXQgeW91
IGNhbiBqdXN0IHVzZSB0aGUgSFcgd2F0Y2hkb2cNCj4gZGlyZWN0bHkgaW5zdGVhZCBvZiB2aWEg
c3lzdGVtZC4gDQo+IA0KPj4gLSBIVyB3YXRjaGRvZ3MgYWx3YXlzIHJlYm9vdCB0aGUgaG9zdCwg
d2hpY2ggaXMgdG9vIGRyYXN0aWMuDQo+PiAtIFlvdSBtYXkgbm90IHdhbnQgdG8gcHJvdGVjdCBh
bGwgVk1zIGluIHRoZSBzYW1lIHdheS4NCj4gDQo+IFNhbWUgcG9pbnRzIHJlcGVhdGVkIGJlbG93
LCBzbyBJJ2xsIHJlc3BvbmQgdGhlcmUuLi4uDQo+IA0KPj4+IElNSE8gZG9pbmcgdGhpcyBhdCB0
aGUgaG9zdCBPUyBsZXZlbCBpcyBnb2luZyB0byBiZSBtb3JlIHJlbGlhYmxlIGluDQo+Pj4gdGVy
bXMgb2YgZGV0ZWN0aW5nIHRoZSBwcm9ibGVtIGluIHRoZSBmaXJzdCBwbGFjZSwgYXMgd2VsbCBh
cyBtb3JlDQo+Pj4gcmVsaWFibGUgaW4gdGFraW5nIHRoZSBhY3Rpb24gLSBpdHMgdmVyeSBkaWZm
aWN1bHQgZm9yIGEgaGFyZHdhcmUgQ1BVDQo+Pj4gcmVzZXQgdG8gZmFpbCB0byB3b3JrLg0KPj4g
DQo+PiBBYnNvbHV0ZWx5LCBidXQgaXQncyBhIHZlcnkgZHJhc3RpYyBtZWFzdXJlIHRoYXQ6DQo+
PiAtIE1heSBiZSB1bm5lY2Vzc2FyeS4NCj4gDQo+IE9mIGNvdXJzZSwgdGhlIGluYWJpbGl0eSB0
byBwcmVkaWN0IGZ1dHVyZSBjb25zZXF1ZW5jZXMgaXMgd2hhdA0KPiBmb3JjZXMgdXMgaW50byBh
c3N1bWluZyB0aGUgd29yc3QgY2FzZSAmIHRha2luZyBhY3Rpb25zIHRvDQo+IG1pdGlnYXRlIHRo
YXQuIEl0IHdpbGwgZGVmaW5pdGVseSByZXN1bHQgaW4gdW5jY2Vzc2FyeSBraWxsaW5nDQo+IG9m
IGhvc3RzLCBidXQgdGhhdCBpcyB3aGF0IGdpdmVzIHlvdSB0aGUgc2FmZXR5IGd1YXJhbnRlZXMg
eW91DQo+IGNhbid0IG90aGVyd2lzZSBhY2hpZXZlLg0KDQpUaGUgYXJndW1lbnQgaXMgdGhhdCBt
YW55IGNvbmZpZ3VyYXRpb25zIGhhdmUgY29udHJvbGxlZCBzZXR0aW5ncyB0aGF0DQpkbyBub3Qg
cmVxdWlyZSB0aGF0IGRyYXN0aWMgbGV2ZWwgb2YgcHJvdGVjdGlvbi4gQW5kIHRoZSBmZWF0dXJl
IHdlJ3JlDQpkaXNjdXNzaW5nIG9mZmVyIGEgc29mdGVyIHdheSBvZiBkZWFsaW5nIHdpdGggdGhl
c2UuDQoNCj4gSSBnYXZlIHRoZSBleGFtcGxlIGVsc2V3aGVyZSB0aGF0IGV2ZW4gaWYgeW91IGtp
bGwgUUVNVSwgdGhlIGtlcm5lbA0KPiBjYW4gaGF2ZSBwZW5kaW5nIEkvTyBhc3NvY2lhdGVkIHdp
dGggUUVNVSB0aGF0IGNhbiBiZSBzZW50IGlmIHRoZQ0KPiBob3N0IGxhdGVyIHJlY292ZXJzLg0K
DQpFdmVuIGlmIGFuIEkvTyBpcyBzZW50IG91dCBvZiB0aGUgaG9zdCwgdGhlcmUgYXJlIG5vIGd1
YXJhbnRlZXMgdGhhdA0KaXQgaXNuJ3QgcXVldWVkIHNvbWV3aGVyZSBhbmQgd2lsbCByZWFjaCBp
dHMgZGVzdGluYXRpb24gZXZlbiBhZnRlcg0KeW91IHB1bGxlZCB0aGUgcG93ZXIgb2YgYSBob3N0
LiBTdWNoIGRpc2N1c3Npb25zIHdlcmUgaGVsZCBzZXBhcmF0ZWx5DQphIHdoaWxlIGJhY2sgd2hl
biB3ZSB3ZXJlIHRhbGtpbmcgYWJvdXQgdGFzayBjYW5jZWxsYXRpb24uDQoNClRvIHRoYXQgcG9p
bnQsIEkndmUgcGVyc29uYWxseSBzZWVuIGNvcnJ1cHRpb24gd2l0aCBuZXR3b3JrIHN0b3JhZ2UN
CndoaWNoIHdhcyBkZWJ1Z2dlZCBhczoNCg0KMSkgd3JpdGUobGJhPTAsIHZhbHVlPSdhJykNCjIp
IGhvc3QgY3Jhc2hlZCAoaGFyZCByZXNldCkNCjMpIHZtIHJlc3RhcnRlZCBlbHNld2hlcmUNCjQp
IHdyaXRlKGxiYT0wLCB2YWx1ZT0nYScpIChyZXN1Ym1pdHRlZCBmcm9tICIxIikNCjUpIHdyaXRl
KGxiYT0wLCB2YWx1ZT0nYicpDQo2KSBJL08gZnJvbSBzdGVwICIxIiByZWFjaGVkIGNvbnRyb2xs
ZXINCjcpIHJlYWQobGJhPTApID09ICdhJw0KDQpNeSBhcmd1bWVudCBpcyB0aGF0IHlvdSBuZWVk
IHRvIGxvb2sgaW50byBwcm90ZWN0aW9uIHdoZXJlIHByb3RlY3Rpb24NCmlzIG5lZWRlZC4gUGVy
aGFwcyB0aGUgZXhhbXBsZSBhYm92ZSBjb3VsZCBiZSBhdm9pZGVkIHdpdGggYSBzZXNzaW9uDQpk
aXN0aW5jdGlvbiBzbyB0aGF0IG9uY2UgSS9PIGZyb20gc3RlcCAiNCIgd2FzIHNlZW4gKGNvbWlu
ZyBmcm9tIHRoZQ0KbmV3IHNlc3Npb24pLCBJL09zIGZyb20gb2xkZXIgc2Vzc2lvbnMgc2hvdWxk
IGJlIHJlamVjdGVkIGJ5IHRoZQ0Kc3RvcmFnZSBjb250cm9sbGVyLg0KDQpJbiBhbnkgY2FzZSwg
YWxsIEknbSBzYXlpbmcgaXMgdGhhdCB0aGVyZSBhcmUgZGlmZmVyZW50IGxldmVscyBvZg0KcHJv
dGVjdGlvbi4gVGhlIGZlYXR1cmUgd2UncmUgZGlzY3Vzc2luZyBoZXJlIG9mZmVycyBvbmUgb2Yg
dGhlbS4NCg0KPiANCj4+IC0gV2lsbCBmZW5jZSBldmVyeXRoaW5nIGV2ZW4gcGVyaGFwcyBvbmx5
IHNvbWUgVk1zIG5lZWQgcHJvdGVjdGlvbi4NCj4gDQo+IEkgZG9uJ3QgYmVsaWV2ZSBpdHMgdmlh
YmxlIHRvIGhhdmUgb2ZmZXIgcmVhbCBwcm90ZWN0aW9uIHRvIG9ubHkNCj4gYSBzdWJzZXQgb2Yg
Vk1zLCBwcmluY2lwYWxseSBiZWNhdXNlIHRoZSBrZXJuZWwgaXMgZG9pbmcgSS9PIHdvcmsNCj4g
b24gYmVoYWxmIG9mIHRoZSBWTSwgc28gdG8gcHJvdGVjdCBqdXN0IDEgVk0geW91IG11c3QgZmVu
Y2UgdGhlDQo+IGtlcm5lbC4NCg0KWW91IGFyZSBhc3N1bWluZyB0aGF0IGFsbCB1c2VycyBvZiBR
ZW11IG91dCB0aGVyZSBkbyBJL08gdGhyb3VnaCB0aGUNCmtlcm5lbC4gV2hhdCBpZiB0aGV5IGRv
bid0Pw0KDQo+IA0KPj4gV2hhdCBhcmUgeW91ciB0aG91Z2h0cyBvbiB0aGlzIDMtbGV2ZWwgYXBw
cm9hY2g/DQo+PiAxKSBRZW11IHRyaWVzIHRvIGxvZygpICsgYWJvcnQoKSAoZGVhZGxpbmUpDQo+
IA0KPiBKdXN0IGFib3J0KCknaW5nIGlzbid0IGdvaW5nIHRvIGJlIGEgdmlhYmxlIHN0cmF0ZWd5
IHdpdGggUUVNVSdzIG1vdmUNCj4gdG93YXJkcyBhIG11bHRpLXByb2Nlc3MgYXJjaGl0ZWN0dXJl
LiBUaGlzIGludHJvZHVjZXMgdGhlIHByb2JsZW0gdGhhdA0KPiB0aGUgIm1haW4iIFFFTVUgcHJv
Y2VzcyBoYXMgdG8gZW51bWVyYXRlIGFsbCB0aGUgaGVscGVycyBpdCBpcyBkZWFsaW5nDQo+IHdp
dGggYW5kIGtpbGwgdGhlbSBhbGwgb2ZmIGluIHNvbWUgd2F5LiBUaGlzIGlzIG5vbi10cml2aWFs
IGVzcGVjaWFsbHkNCj4gaWYgc29tZSBvZiB0aGUgaGVscGVycyBhcmUgcnVubmluZyB1bmRlciBk
aWZmZXJlbnQgcHJpdmlsZWdlIGxldmVscy4NCg0KSWYgdGhpcyBpcyB0byBleHRlbmQgdG8gYSBt
dWx0aS1wcm9jZXNzIG1vZGVsLCBJIGRvbid0IHRoaW5rIGl0IHNob3VsZA0KYmUgb25lIHByb2Nl
c3Mga2lsbGluZyBvdGhlcnMuIEl0J3MgY2FsbGVkICJzZWxmLWZlbmNpbmciIGJlY2F1c2UgZWFj
aA0KcHJvY2VzcyBzaG91bGQgYmUgcmVzcG9uc2libGUgZm9yIGtpbGxpbmcgaXRzZWxmIGJhc2Vk
IG9uIGEgaGVhcnRiZWF0Lg0KKE9yIGNvbmZpZ3VyaW5nIHRoZSBrZXJuZWwgdG8gZG8gaXQuKQ0K
DQo+IA0KPiBZb3UgY291bGQgZGVjbGFyZSB0aGF0IG11bHRpLXByb2Nlc3MgUUVNVSBpcyBvdXQg
b2Ygc2NvcGUsIGJ1dCBJIHRoaW5rDQo+IFFFTVUgc2VsZi1mZW5jaW5nIHdvdWxkIG5lZWQgdG8g
b2ZmZXIgY29tcGVsbGluZyBiZW5lZml0cyBvdmVyIGhvc3QgT1MNCj4gc2VsZi1mZW5jaW5nIHRv
IGp1c3RpZnkgdGhhdCBleGNlcHRpb24uIFBlcnNvbmFsbHkgSSdtIG5vdCBzZWVpbmcgaXQuDQoN
Ckkgd291bGQgbGltaXQgdGhlIGZlYXR1cmUgZm9yIGEgbW9ub2xpdGhpYyBtb2RlbCB0byBiZWdp
biB3aXRoLCBidXQNCmRlZmluaXRlbHkga2VlcCBhbiBleWUgb24gd2F5cyB0byBleHRlbmQgaXQg
dG8gYSBtdWx0aS1wcm9jZXNzIG1vZGVsLg0KDQpUaGUgYmVuZWZpdCBpcyBhcyBkZXNjcmliZWQg
YmVmb3JlLCB3aXRoIHRoZSBhZGRlZCBhcmd1bWVudHMgaW4gdGhpcyBlLW1haWw6DQotIE1heSBu
b3Qgd2FudCB0byBwcm90ZWN0IGFsbCBWTXMuDQotIE1heSBub3Qgd2FudCB0byBraWxsIHRoZSBl
bnRpcmUgaG9zdCBmb3IgYSB0ZW1wb3JhcnkgbmV0d29yayBvdXRhZ2UuDQotIEtpbGxpbmcgUWVt
dSBpcyBzdWZmaWNpZW50IGluIHZhcmlvdXMgY29uZmlndXJhdGlvbnMuDQoNCj4gDQo+PiAyKSBL
ZXJuZWwgc2VuZHMgU0lHS0lMTCAoaGFyZGRlYWRsaW5lKQ0KPiANCj4gVGhpcyBpcyBzbGlnaHRs
eSBlYXNpZXIgdG8gZGVhbCB3aXRoIG11bHRpcGxlIHByb2Nlc3NlcyBpbiB0aGF0IGl0DQo+IGlz
bid0IHJlc3RyaWN0ZWQgYnkgdGhlIHByaXZpbGVnZXMgb2YgdGhlIG1haW4gUUVNVSB2cyBoZWxw
ZXJzIGFuZA0KPiBjb3VsZCB0YWtlIGFkdmFudGFnZSBvZiBjZ3JvdXBzIHBlcmhhcHMuDQoNClJp
Z2h0LCBhbmQgaXQgc2hvdWxkIGJlIGFuIG9wdGlvbiBmcm9tIHRoZSBzdGFydC4gVGhhbmtzIGZv
ciB3ZWlnaHRpbmcNCmluIHdpdGggZXh0cmEgaWRlYXMgYXJvdW5kIGNncm91cC4NCg0KRi4NCg0K
PiANCj4+IDMpIEhXIHdhdGNoZG9nIGtpY2tzIGluIChoYXJkZXJkZWFkbGluZSkNCj4gDQo+IA0K
PiBSZWdhcmRzLA0KPiBEYW5pZWwNCj4gLS0gDQo+IHw6IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9v
ZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fYmVycmFuZ2UuY29tJmQ9RHdJRGFRJmM9czg4
M0dwVUNPQ2hLT0hpb2NZdEdjZyZyPUNDckpLVkM1ekdvdDhQcm5JLWlZZTAwTWRYNHBnZFFmTVJp
Z3AxNFB0bWsmbT1ZQy1xcWFHNmtvZEZLVk1OWDBKMGtqejlYNlZfLUZKQXdKcDdWNkliLXd3JnM9
Z0h5bG1pbGZBMmVVSW5McGp6bUhxb2FHbnB5UjhHU1FMbU84RUF3NGVSOCZlPSAgICAgICAtby0g
ICAgaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX193
d3cuZmxpY2tyLmNvbV9waG90b3NfZGJlcnJhbmdlJmQ9RHdJRGFRJmM9czg4M0dwVUNPQ2hLT0hp
b2NZdEdjZyZyPUNDckpLVkM1ekdvdDhQcm5JLWlZZTAwTWRYNHBnZFFmTVJpZ3AxNFB0bWsmbT1Z
Qy1xcWFHNmtvZEZLVk1OWDBKMGtqejlYNlZfLUZKQXdKcDdWNkliLXd3JnM9ODBRaVlBZnBLeUFQ
Q1RLQXBqbThLWUxUeDFYN002cEo1M0dCYkpuY3k5byZlPSAgOnwNCj4gfDogaHR0cHM6Ly91cmxk
ZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19saWJ2aXJ0Lm9yZyZkPUR3
SURhUSZjPXM4ODNHcFVDT0NoS09IaW9jWXRHY2cmcj1DQ3JKS1ZDNXpHb3Q4UHJuSS1pWWUwME1k
WDRwZ2RRZk1SaWdwMTRQdG1rJm09WUMtcXFhRzZrb2RGS1ZNTlgwSjBrano5WDZWXy1GSkF3SnA3
VjZJYi13dyZzPXlZdlpYOVJiZzNvZW1jS0szaFVGZVE1dmJnT2taWTdJNDNUaVRIZFRxSHcmZT0g
ICAgICAgICAgLW8tICAgICAgICAgICAgaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29t
L3YyL3VybD91PWh0dHBzLTNBX19mc3RvcDEzOC5iZXJyYW5nZS5jb20mZD1Ed0lEYVEmYz1zODgz
R3BVQ09DaEtPSGlvY1l0R2NnJnI9Q0NySktWQzV6R290OFBybkktaVllMDBNZFg0cGdkUWZNUmln
cDE0UHRtayZtPVlDLXFxYUc2a29kRktWTU5YMEowa2p6OVg2Vl8tRkpBd0pwN1Y2SWItd3cmcz0y
ZWpER1RjTUlEeVdCTTV4bTVONHJaYjF1WE9qOVlXcHZUUjFETlpMc3pNJmU9ICA6fA0KPiB8OiBo
dHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX2VudGFu
Z2xlLTJEcGhvdG8ub3JnJmQ9RHdJRGFRJmM9czg4M0dwVUNPQ2hLT0hpb2NZdEdjZyZyPUNDckpL
VkM1ekdvdDhQcm5JLWlZZTAwTWRYNHBnZFFmTVJpZ3AxNFB0bWsmbT1ZQy1xcWFHNmtvZEZLVk1O
WDBKMGtqejlYNlZfLUZKQXdKcDdWNkliLXd3JnM9QlVsaHJNRFliM2s1Q3pVLUNtajIyel9QbjRW
ZWx5dWVEQzNTeDBKUmJXRSZlPSAgICAgLW8tICAgIGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBv
aW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fd3d3Lmluc3RhZ3JhbS5jb21fZGJlcnJhbmdlJmQ9
RHdJRGFRJmM9czg4M0dwVUNPQ2hLT0hpb2NZdEdjZyZyPUNDckpLVkM1ekdvdDhQcm5JLWlZZTAw
TWRYNHBnZFFmTVJpZ3AxNFB0bWsmbT1ZQy1xcWFHNmtvZEZLVk1OWDBKMGtqejlYNlZfLUZKQXdK
cDdWNkliLXd3JnM9Ymk3RHFkMFFadDZvVUkzZGw2VFlSZmhGM21DYzhXcTdyWGc1NTR5OVlnYyZl
PSAgOnwNCg0K

