Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0505C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA7B2084A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="VNY4kIlv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA7B2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60334 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdHfT-0002ij-Vs
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 13:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59855)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cosmin.marin@nutanix.com>) id 1hdHLG-0005iu-Ac
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:52:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cosmin.marin@nutanix.com>) id 1hdHLF-0000cZ-3S
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:52:18 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:49588)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cosmin.marin@nutanix.com>)
 id 1hdHLE-0000VE-St
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:52:17 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5IGo0HU027631; Tue, 18 Jun 2019 09:52:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=cFixLCmECX+5uwcOeZ1nCyX/Tv2/tKMkF41ypOXOA6s=;
 b=VNY4kIlvkaIl6caWn4RmE1N1Ew0XpdTdWZPokxs62v1GkTTmwDWPoSkrGSn4WhF1LzYs
 3rSe3Vas+CFOyzIxmK+j6PRfait9B6uT0ULyNSjvedqSMuOrgQ9T2tDIB9jDIGesEgk6
 GEi5R77aApeJ2wGUfvWFBUeEAkGKeqgwCh1V/k5hSOXyQy6Fycc3t5FxzqMnHmj1/RaX
 O1HTKa2v9JURI9rFyUiC6LtBMH73fCfApIGCQeeTTatba51ftNSN60NgCggy4ShuQYCg
 gG936f906iuZj8cNp3tW66mGscULwSzCfF71HyjiF6xkKViZvPhx8F8G9cD4vUY/zlq6 1A== 
Received: from nam01-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam01lp2057.outbound.protection.outlook.com [104.47.32.57])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2t729qg5v0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Tue, 18 Jun 2019 09:52:10 -0700
Received: from BL0PR02MB4450.namprd02.prod.outlook.com (10.167.179.27) by
 BL0PR02MB4852.namprd02.prod.outlook.com (52.132.14.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Tue, 18 Jun 2019 16:52:09 +0000
Received: from BL0PR02MB4450.namprd02.prod.outlook.com
 ([fe80::e5c5:13c4:aa5e:32b6]) by BL0PR02MB4450.namprd02.prod.outlook.com
 ([fe80::e5c5:13c4:aa5e:32b6%7]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 16:52:09 +0000
From: Cosmin Marin <cosmin.marin@nutanix.com>
To: Peter Xu <peterx@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH] migration: Improve accuracy of vCPU
 throttling with per-vCPU timers
Thread-Index: AQHVIsvLxMtqZNDTbEaTy7clKx/n56afOOUAgAI0KgCAABfqgIAAMocA
Date: Tue, 18 Jun 2019 16:52:09 +0000
Message-ID: <903D206C-0B8E-4113-A8B4-B8AC571F840A@nutanix.com>
References: <20190614161106.218854-1-cosmin@nutanix.com>
 <20190617034628.GA12456@xz-x1>
 <ACBDA5C2-CC9B-416F-AB54-D4A98CAF2F8A@nutanix.com>
 <20190618145116.GA3793@xz-x1>
In-Reply-To: <20190618145116.GA3793@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [37.235.116.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96be460f-68c1-420a-09d5-08d6f40d4d96
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BL0PR02MB4852; 
x-ms-traffictypediagnostic: BL0PR02MB4852:
x-proofpoint-crosstenant: true
x-microsoft-antispam-prvs: <BL0PR02MB4852CBB3751C18AD5712E2B686EA0@BL0PR02MB4852.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(376002)(366004)(136003)(346002)(396003)(189003)(199004)(71200400001)(14444005)(8936002)(486006)(256004)(476003)(316002)(68736007)(102836004)(7736002)(305945005)(6506007)(6512007)(76176011)(186003)(2616005)(26005)(478600001)(2906002)(54906003)(44832011)(5660300002)(86362001)(14454004)(99286004)(91956017)(446003)(71190400001)(6246003)(25786009)(36756003)(66066001)(6916009)(53936002)(66446008)(11346002)(66476007)(73956011)(229853002)(6116002)(3846002)(76116006)(6436002)(66556008)(64756008)(81156014)(8676002)(6486002)(33656002)(81166006)(66946007)(4326008)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BL0PR02MB4852;
 H:BL0PR02MB4450.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8Gn3O251XCpGp0l3tYwYubAXtZsYG6uK2heSudqtrkdzI2gHkXGxVj3j7Jug3yEs48gF06+J4wFpH9zLFMsZ7VZNEsQF9/YCG5ovSfnjGUOenAwG6E3MMtIULYwd9arglVUDAcoogTcDRl0lHknc4+GYKWsguz9JMdUKGSoaiCcQ11Gr80Z/nHd3+670pji4h01hRXh9pUQonMbnGGBsSi51FcmS/syWrbZTqc1LhvIFrZ9OGYqUfby5EwXFnaLUmfERxiDMtXGufYwzVdUcFM/NQQ/J/HqweChuvozZIAFEoFJojzPbTe6YbkubDTl4JOcVv9OBq+Br5F0iSgR7MRqnLWVETrsdhJEEca89iolFM4OsH83sB3AL6aUUsbNvEcFKY4PlQHUErcOYJBiBTXPNd9qx36SUqCoZw6WJ57A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF6809F7F9BC45449377F929A23B318B@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96be460f-68c1-420a-09d5-08d6f40d4d96
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 16:52:09.2055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cosmin.marin@nutanix.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4852
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-18_08:, , signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.155.12
Subject: Re: [Qemu-devel] [PATCH] migration: Improve accuracy of vCPU
 throttling with per-vCPU timers
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
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCu+7v09uIDE4LzA2LzIwMTksIDE1OjUxLCAiUGV0ZXIgWHUiIDxwZXRlcnhAcmVkaGF0LmNv
bT4gd3JvdGU6DQoNCiAgICBPbiBUdWUsIEp1biAxOCwgMjAxOSBhdCAxMjoyNTo0M1BNICswMDAw
LCBDb3NtaW4gTWFyaW4gd3JvdGU6DQogICAgPiAJSGkgUGV0ZXIsDQogICAgPiANCiAgICA+IAl0
aGFua3MgZm9yIHJldmlld2luZyB0aGUgcGF0Y2guIEluZGVlZCwgSSBhZ3JlZSB0aGF0IGl0J3Mg
YWxtb3N0IGltcG9zc2libGUgdG8gZGV0ZXJtaW5lIHdoaWNoIHNvbHV0aW9uIGl0J3MgYmV0dGVy
IGZyb20gdGhlIHNjYWxhYmlsaXR5IHBlcnNwZWN0aXZlLiBIb3dldmVyLCBJIGZlZWwgdGhhdCB1
c2luZyBwZXItdkNQVSB0aW1lcnMgaXMgdGhlIG9ubHkgd2F5IGZvciBlbnN1cmluZyBjb3JyZWN0
bmVzcyBvZiB0aGUgdGhyb3R0bGluZyByYXRpby4NCiAgICANCiAgICBUaGUgdGhpbmcgaXMgdGhh
dCB5b3VyIHBhdGNoIGFjdHVhbGx5IGNvbnRhaW5zIHR3byBjaGFuZ2VzOg0KICAgIA0KICAgIDEu
IHVzZSBOIHRpbWVycyBpbnN0ZWFkIG9mIG9uZS4NCiAgICANCiAgICAyLiByZW1vdmUgdGhyb3R0
bGVfdGhyZWFkX3NjaGVkdWxlZCBjaGVjaywgc28gd2UgZG8gdGhlIHRocm90dGxlDQogICAgICAg
YWx3YXlzDQogICAgDQogICAgSGVyZSB3aGF0IEknbSB3b3JyaWVkIGlzIHRoYXQgX21heWJlXyB0
aGUgMm5kIGl0ZW0gaXMgdGhlIG9uZSB0aGF0DQogICAgcmVhbGx5IGhlbHBlZC4NCiAgICANCglD
OiBUaGUgcmVtb3ZhbCBvZiAqdGhyb3R0bGVfdGhyZWFkX3NjaGVkdWxlZCogaXMgYSBjb25zZXF1
ZW5jZSBvZiB0aGUgcGVyLXZDUFUgbW9kZWwgb25seS4gSW4gdGhpcyBtb2RlbCwgZWFjaCBvZiB0
aGUgdkNQVXMgc2NoZWR1bGVzIHdvcmsganVzdCBmb3IgaXRzZWxmIChhcyBwYXJ0IG9mIHRoZSB0
aW1lcidzIGZpcmluZyBjYWxsYmFjaykgLSB0aGVyZSdzIG5vIGdsb2JhbCBwb2ludCBvZiBjb250
cm9sIC0gdGhlcmVmb3JlLCB0aGUgdmFyaWFibGUgaXNuJ3QgaGVscGZ1bCBmb3Igc2NoZWR1bGlu
ZyBhbnltb3JlLg0KDQogICAgTm90ZSB0aGF0IHRoZXJlIGlzIGEgc2lkZSBlZmZlY3QgdGhhdCB3
ZSBtaWdodCBxdWV1ZSBtb3JlIHRoYW4gb25lDQogICAgd29yayBvbiBvbmUgc3BlY2lmaWMgY3B1
IGlmIHdlIHF1ZXVlIGl0IHRvbyBmYXN0LCBidXQgaXQgZG9lcyBub3QNCiAgICBibG9jayB1cyBm
cm9tIHRyeWluZyBpdCBvdXQgdG8gaWRlbnRpZnkgd2hpY2ggaXRlbSAoMSBvciAyIG9yIGJvdGgp
DQogICAgcmVhbGx5IGhlbHBlZCBoZXJlLiAgVGhlbiBpZiB3ZSB0aGluayB0aGF0IChxdWV1aW5n
IHRvbyBtdWNoKSBpcyBhbg0KICAgIGlzc3VlIHRoZW4gd2UgY2FuIGRpc2N1c3Mgb24gaG93IHRv
IGZpeCBpdCBzaW5jZSBjdXJyZW50IHBhdGNoIHdpbGwNCiAgICBoYXZlIHRoaXMgcHJvYmxlbSBh
cyB3ZWxsLg0KICAgIA0KCUM6IEkgYmVsaWV2ZSB0aGF0IGluIHRoZSBwZXItdkNQVSB0aW1lciBp
bXBsZW1lbnRhdGlvbiB3ZSBjYW5ub3QgcXVldWUgbW9yZSB0aGFuIG9uZSBwaWVjZSBvZiB3b3Jr
IGJlY2F1c2UsIGhlcmUsIHRoZSB2Q1BVIHF1ZXVlcyB3b3JrIGZvciBpdHNlbGYgYW5kIHRoYXQg
aGFwcGVucyBvbmx5IHdoZW4gdGhlIHRpbWVyIGZpcmVzIC0gc28sIHRoZSB0d28gInN0YXRlcyIg
LSBzY2hlZHVsaW5nIGFuZCBzbGVlcGluZyAtIGFyZSBtdXR1YWxseSBleGNsdXNpdmUgcnVubmlu
ZyBmcm9tIHRoZSBzYW1lIHRocmVhZCBjb250ZXh0LiANCiAgICA+IA0KICAgID4gCUl0J3MgYSBi
aXQgdW5jbGVhciB0byBtZSBob3cgdGhlIHRocm90dGxpbmcgcmF0aW8gaW5jb25zaXN0ZW5jeSBj
YW4gYmUgZml4ZWQgYnkgdXNpbmcgYSBzaW5nbGUgdGltZXIgZXZlbiBhdm9pZGluZyB0aGUgY29u
ZGl0aW9uYWwgdGltZXIgcmUtYXJtaW5nLiAgQ291bGQgeW91IHByb3ZpZGUgbW9yZSBkZXRhaWxz
IGFib3V0IHRoZSB1c2Ugb2YgYSBzaW5nbGUgdGltZXIgPw0KDQoJQzogSSBmZWVsIGxpa2UgaW4g
dGhpcyBjYXNlIGl0IHdpbGwgc2xlZXAgdG9vIG11Y2ggcnVubmluZyBpbnRvIGEgcHJvYmxlbSBz
aW1pbGFyIHRvIHRoZSBvbmUgc29sdmVkIGJ5IDkwYmIwYzA7IHVuZGVyIGhlYXZ5IHRocm90dGxp
bmcgbW9yZSB0aGFuIG9uZSB3b3JrIGl0ZW0gbWF5IGJlIHNjaGVkdWxlZC4NCiAgICAgIA0KDQog
ICAgSXQnbGwgYmUgc2ltcGx5IGEgcGF0Y2ggb25seSBjb250YWlucyB0aGUgY2hhbmdlcyBmb3Ig
aXRlbSAoMikgYWJvdmUuDQogICAgVG8gYmUgZXhwbGljaXQsIGl0IGlzOg0KICAgIA0KICAgIC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCiAgICBkaWZmIC0tZ2l0IGEvY3B1cy5jIGIvY3B1cy5jDQogICAgaW5kZXggZGRl
M2I3Yjk4MS4uYmI1OTY3NWI5OCAxMDA2NDQNCiAgICAtLS0gYS9jcHVzLmMNCiAgICArKysgYi9j
cHVzLmMNCiAgICBAQCAtNzkyLDcgKzc5Miw2IEBAIHN0YXRpYyB2b2lkIGNwdV90aHJvdHRsZV90
aHJlYWQoQ1BVU3RhdGUgKmNwdSwgcnVuX29uX2NwdV9kYXRhIG9wYXF1ZSkNCiAgICAgICAgIHFl
bXVfbXV0ZXhfdW5sb2NrX2lvdGhyZWFkKCk7DQogICAgICAgICBnX3VzbGVlcChzbGVlcHRpbWVf
bnMgLyAxMDAwKTsgLyogQ29udmVydCBucyB0byB1cyBmb3IgdXNsZWVwIGNhbGwgKi8NCiAgICAg
ICAgIHFlbXVfbXV0ZXhfbG9ja19pb3RocmVhZCgpOw0KICAgIC0gICAgYXRvbWljX3NldCgmY3B1
LT50aHJvdHRsZV90aHJlYWRfc2NoZWR1bGVkLCAwKTsNCiAgICAgfQ0KICAgIA0KICAgICBzdGF0
aWMgdm9pZCBjcHVfdGhyb3R0bGVfdGltZXJfdGljayh2b2lkICpvcGFxdWUpDQogICAgQEAgLTgw
NSwxMCArODA0LDcgQEAgc3RhdGljIHZvaWQgY3B1X3Rocm90dGxlX3RpbWVyX3RpY2sodm9pZCAq
b3BhcXVlKQ0KICAgICAgICAgICAgIHJldHVybjsNCiAgICAgICAgIH0NCiAgICAgICAgIENQVV9G
T1JFQUNIKGNwdSkgew0KICAgIC0gICAgICAgIGlmICghYXRvbWljX3hjaGcoJmNwdS0+dGhyb3R0
bGVfdGhyZWFkX3NjaGVkdWxlZCwgMSkpIHsNCiAgICAtICAgICAgICAgICAgYXN5bmNfcnVuX29u
X2NwdShjcHUsIGNwdV90aHJvdHRsZV90aHJlYWQsDQogICAgLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgUlVOX09OX0NQVV9OVUxMKTsNCiAgICAtICAgICAgICB9DQogICAgKyAgICAgICAg
YXN5bmNfcnVuX29uX2NwdShjcHUsIGNwdV90aHJvdHRsZV90aHJlYWQsIFJVTl9PTl9DUFVfTlVM
TCk7DQogICAgICAgICB9DQogICAgDQogICAgICAgICBwY3QgPSAoZG91YmxlKWNwdV90aHJvdHRs
ZV9nZXRfcGVyY2VudGFnZSgpLzEwMDsNCiAgICBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xb20vY3B1
LmggYi9pbmNsdWRlL3FvbS9jcHUuaA0KICAgIGluZGV4IDVlZTAwNDZiNjIuLjBiZDM0ZmJiNzAg
MTAwNjQ0DQogICAgLS0tIGEvaW5jbHVkZS9xb20vY3B1LmgNCiAgICArKysgYi9pbmNsdWRlL3Fv
bS9jcHUuaA0KICAgIEBAIC00MzksMTEgKzQzOSw2IEBAIHN0cnVjdCBDUFVTdGF0ZSB7DQogICAg
ICAgICAvKiBzaGFyZWQgYnkga3ZtLCBoYXggYW5kIGh2ZiAqLw0KICAgICAgICAgYm9vbCB2Y3B1
X2RpcnR5Ow0KICAgIA0KICAgIC0gICAgLyogVXNlZCB0byBrZWVwIHRyYWNrIG9mIGFuIG91dHN0
YW5kaW5nIGNwdSB0aHJvdHRsZSB0aHJlYWQgZm9yIG1pZ3JhdGlvbg0KICAgIC0gICAgICogYXV0
b2NvbnZlcmdlDQogICAgLSAgICAgKi8NCiAgICAtICAgIGJvb2wgdGhyb3R0bGVfdGhyZWFkX3Nj
aGVkdWxlZDsNCiAgICAtDQogICAgICAgICBib29sIGlnbm9yZV9tZW1vcnlfdHJhbnNhY3Rpb25f
ZmFpbHVyZXM7DQogICAgDQogICAgICAgICBzdHJ1Y3QgaGF4X3ZjcHVfc3RhdGUgKmhheF92Y3B1
Ow0KICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCiAgICANCiAgICBSZWdhcmRzLA0KICAgIA0KICAgIC0tIA0KICAg
IFBldGVyIFh1DQogICAgDQoNCg==

