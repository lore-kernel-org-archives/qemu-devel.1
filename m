Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A06C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:28:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB3DC21721
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="S5XOGadH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3DC21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39404 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdcVa-0004no-Ts
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 11:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41600)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cosmin.marin@nutanix.com>) id 1hdcQy-0001XA-RJ
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:23:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cosmin.marin@nutanix.com>) id 1hdcQx-0000dH-LX
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:23:36 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:44608)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cosmin.marin@nutanix.com>)
 id 1hdcQx-0000ax-7Q
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:23:35 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5JFBQSL006980; Wed, 19 Jun 2019 08:23:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=TJQZ/HAh2PkMyqp+GzXbhGFcghB8FDpIqZQiTCroJDg=;
 b=S5XOGadH0okuCjK/kwzijXx8bjAz8juli2yeP/OPZJAx08khDBuMp21CzAv5E6ltdslj
 fVZNfa/04iqJgEeB3jSQ3b6T5y/M+ElwNZvsRydpN53e2xV/9di6vytwPeoH+ctSrou7
 qA2jjeNpEK1H6fKsCkG4/3sB5EnLZ6/MVEBBhDOsv3iG5xYTSHCbffuDHpE/eS/FEoVY
 xpt7qeKJg88FhHTg6Ntq3RzM8kC4Qk1Z7zDky3CWFPLMiDyZWGnxDproVOKOTrg/jrSL
 UMDFON3DI7Vux6yHP4OOStdm4o0auvV+4xkGJxtq/jglvyWTp+HBMC7KTDz19vkCvMsu sQ== 
Received: from nam03-by2-obe.outbound.protection.outlook.com
 (mail-by2nam03lp2059.outbound.protection.outlook.com [104.47.42.59])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2t7pd1g50y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 19 Jun 2019 08:23:30 -0700
Received: from BL0PR02MB4450.namprd02.prod.outlook.com (10.167.179.27) by
 BL0PR02MB4625.namprd02.prod.outlook.com (10.167.181.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Wed, 19 Jun 2019 15:23:29 +0000
Received: from BL0PR02MB4450.namprd02.prod.outlook.com
 ([fe80::e5c5:13c4:aa5e:32b6]) by BL0PR02MB4450.namprd02.prod.outlook.com
 ([fe80::e5c5:13c4:aa5e:32b6%7]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 15:23:29 +0000
From: Cosmin Marin <cosmin.marin@nutanix.com>
To: Peter Xu <peterx@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH] migration: Improve accuracy of vCPU
 throttling with per-vCPU timers
Thread-Index: AQHVIsvLxMtqZNDTbEaTy7clKx/n56afOOUAgAI0KgCAABfqgIAAMocAgACBewCAAPgQgA==
Date: Wed, 19 Jun 2019 15:23:28 +0000
Message-ID: <2D8771C7-51F3-4C9A-9E89-2E2A75686BF9@nutanix.com>
References: <20190614161106.218854-1-cosmin@nutanix.com>
 <20190617034628.GA12456@xz-x1>
 <ACBDA5C2-CC9B-416F-AB54-D4A98CAF2F8A@nutanix.com>
 <20190618145116.GA3793@xz-x1>
 <903D206C-0B8E-4113-A8B4-B8AC571F840A@nutanix.com>
 <20190619013534.GA8761@xz-x1>
In-Reply-To: <20190619013534.GA8761@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.146.154.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b96b1044-9191-4cb8-e2c2-08d6f4ca1506
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BL0PR02MB4625; 
x-ms-traffictypediagnostic: BL0PR02MB4625:
x-proofpoint-crosstenant: true
x-microsoft-antispam-prvs: <BL0PR02MB46259FA4890D4B21393FA28086E50@BL0PR02MB4625.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0073BFEF03
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(136003)(39860400002)(366004)(376002)(189003)(199004)(6512007)(3846002)(256004)(66446008)(6916009)(102836004)(14444005)(229853002)(36756003)(76116006)(44832011)(91956017)(99286004)(476003)(66556008)(486006)(73956011)(54906003)(446003)(6246003)(305945005)(6116002)(53936002)(26005)(4326008)(33656002)(81156014)(66476007)(68736007)(66946007)(76176011)(8676002)(8936002)(81166006)(5660300002)(2906002)(316002)(186003)(6486002)(6506007)(7736002)(64756008)(11346002)(53546011)(2616005)(66066001)(14454004)(71190400001)(71200400001)(478600001)(86362001)(25786009)(6436002)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BL0PR02MB4625;
 H:BL0PR02MB4450.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j/RHYpMZh0J45Yl3u1XMQfs/2hIwANLntZffJ003z1lBGbm3vDseNDzH0WAKWCPK1YVLmfPJj6c5TQMDFiiljZwCH5g5yUvrEc8fuX0MltvDPRdEgGCrjLkn7OySIiNAt0+0rfMArf/787Pt29pcuwre5OtN8tNrOGPlUiV98LLYz/sdkzyEjpJ0Xo8pQruaaKsztNP62sVuyX4tNQ20vKUOleuUJgfRps5zaBhumXi2tm3l2Bo58cswYBucZRnQCnL8XjqUWznPjiGwwjvp/z4lkyqhxDledfMY7LJZ3MWJX65ehJLk3Sa46eZjG0nW+Uz0KifvUr73qsplTP5KmbcgH+noJSCwy2c7JcFWCdjfiMdQVwSaVu4Yp83yXQf8vpLBiySyu7Mw892/cWVherINjBOCp+X48uWL+NmCcRs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E5C8B522787EC4A8EF39FA89BB28AD3@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96b1044-9191-4cb8-e2c2-08d6f4ca1506
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 15:23:29.1488 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cosmin.marin@nutanix.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4625
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-19_09:, , signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.151.68
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

DQoNCu+7v09uIDE5LzA2LzIwMTksIDAyOjM1LCAiUGV0ZXIgWHUiIDxwZXRlcnhAcmVkaGF0LmNv
bT4gd3JvdGU6DQoNCiAgICBPbiBUdWUsIEp1biAxOCwgMjAxOSBhdCAwNDo1MjowOVBNICswMDAw
LCBDb3NtaW4gTWFyaW4gd3JvdGU6DQogICAgPiANCiAgICA+IA0KICAgID4gT24gMTgvMDYvMjAx
OSwgMTU6NTEsICJQZXRlciBYdSIgPHBldGVyeEByZWRoYXQuY29tPiB3cm90ZToNCiAgICA+IA0K
ICAgID4gICAgIE9uIFR1ZSwgSnVuIDE4LCAyMDE5IGF0IDEyOjI1OjQzUE0gKzAwMDAsIENvc21p
biBNYXJpbiB3cm90ZToNCiAgICA+ICAgICA+IAlIaSBQZXRlciwNCiAgICA+ICAgICA+IA0KICAg
ID4gICAgID4gCXRoYW5rcyBmb3IgcmV2aWV3aW5nIHRoZSBwYXRjaC4gSW5kZWVkLCBJIGFncmVl
IHRoYXQgaXQncyBhbG1vc3QgaW1wb3NzaWJsZSB0byBkZXRlcm1pbmUgd2hpY2ggc29sdXRpb24g
aXQncyBiZXR0ZXIgZnJvbSB0aGUgc2NhbGFiaWxpdHkgcGVyc3BlY3RpdmUuIEhvd2V2ZXIsIEkg
ZmVlbCB0aGF0IHVzaW5nIHBlci12Q1BVIHRpbWVycyBpcyB0aGUgb25seSB3YXkgZm9yIGVuc3Vy
aW5nIGNvcnJlY3RuZXNzIG9mIHRoZSB0aHJvdHRsaW5nIHJhdGlvLg0KICAgID4gICAgIA0KICAg
ID4gICAgIFRoZSB0aGluZyBpcyB0aGF0IHlvdXIgcGF0Y2ggYWN0dWFsbHkgY29udGFpbnMgdHdv
IGNoYW5nZXM6DQogICAgPiAgICAgDQogICAgPiAgICAgMS4gdXNlIE4gdGltZXJzIGluc3RlYWQg
b2Ygb25lLg0KICAgID4gICAgIA0KICAgID4gICAgIDIuIHJlbW92ZSB0aHJvdHRsZV90aHJlYWRf
c2NoZWR1bGVkIGNoZWNrLCBzbyB3ZSBkbyB0aGUgdGhyb3R0bGUNCiAgICA+ICAgICAgICBhbHdh
eXMNCiAgICA+ICAgICANCiAgICA+ICAgICBIZXJlIHdoYXQgSSdtIHdvcnJpZWQgaXMgdGhhdCBf
bWF5YmVfIHRoZSAybmQgaXRlbSBpcyB0aGUgb25lIHRoYXQNCiAgICA+ICAgICByZWFsbHkgaGVs
cGVkLg0KICAgID4gICAgIA0KICAgID4gCUM6IFRoZSByZW1vdmFsIG9mICp0aHJvdHRsZV90aHJl
YWRfc2NoZWR1bGVkKiBpcyBhIGNvbnNlcXVlbmNlIG9mIHRoZSBwZXItdkNQVSBtb2RlbCBvbmx5
LiBJbiB0aGlzIG1vZGVsLCBlYWNoIG9mIHRoZSB2Q1BVcyBzY2hlZHVsZXMgd29yayBqdXN0IGZv
ciBpdHNlbGYgKGFzIHBhcnQgb2YgdGhlIHRpbWVyJ3MgZmlyaW5nIGNhbGxiYWNrKSAtIHRoZXJl
J3Mgbm8gZ2xvYmFsIHBvaW50IG9mIGNvbnRyb2wgLSB0aGVyZWZvcmUsIHRoZSB2YXJpYWJsZSBp
c24ndCBoZWxwZnVsIGZvciBzY2hlZHVsaW5nIGFueW1vcmUuDQogICAgPiANCiAgICA+ICAgICBO
b3RlIHRoYXQgdGhlcmUgaXMgYSBzaWRlIGVmZmVjdCB0aGF0IHdlIG1pZ2h0IHF1ZXVlIG1vcmUg
dGhhbiBvbmUNCiAgICA+ICAgICB3b3JrIG9uIG9uZSBzcGVjaWZpYyBjcHUgaWYgd2UgcXVldWUg
aXQgdG9vIGZhc3QsIGJ1dCBpdCBkb2VzIG5vdA0KICAgID4gICAgIGJsb2NrIHVzIGZyb20gdHJ5
aW5nIGl0IG91dCB0byBpZGVudGlmeSB3aGljaCBpdGVtICgxIG9yIDIgb3IgYm90aCkNCiAgICA+
ICAgICByZWFsbHkgaGVscGVkIGhlcmUuICBUaGVuIGlmIHdlIHRoaW5rIHRoYXQgKHF1ZXVpbmcg
dG9vIG11Y2gpIGlzIGFuDQogICAgPiAgICAgaXNzdWUgdGhlbiB3ZSBjYW4gZGlzY3VzcyBvbiBo
b3cgdG8gZml4IGl0IHNpbmNlIGN1cnJlbnQgcGF0Y2ggd2lsbA0KICAgID4gICAgIGhhdmUgdGhp
cyBwcm9ibGVtIGFzIHdlbGwuDQogICAgPiAgICAgDQogICAgPiAJQzogSSBiZWxpZXZlIHRoYXQg
aW4gdGhlIHBlci12Q1BVIHRpbWVyIGltcGxlbWVudGF0aW9uIHdlIGNhbm5vdCBxdWV1ZSBtb3Jl
IHRoYW4gb25lIHBpZWNlIG9mIHdvcmsgYmVjYXVzZSwgaGVyZSwgdGhlIHZDUFUgcXVldWVzIHdv
cmsgZm9yIGl0c2VsZiBhbmQgdGhhdCBoYXBwZW5zIG9ubHkgd2hlbiB0aGUgdGltZXIgZmlyZXMg
LSBzbywgdGhlIHR3byAic3RhdGVzIiAtIHNjaGVkdWxpbmcgYW5kIHNsZWVwaW5nIC0gYXJlIG11
dHVhbGx5IGV4Y2x1c2l2ZSBydW5uaW5nIGZyb20gdGhlIHNhbWUgdGhyZWFkIGNvbnRleHQuIA0K
ICAgIA0KICAgIEkgdGhpbmsgdGhpcyBpcyB0aGUgcGxhY2Ugd2hlcmUgSSdtIGluIHF1ZXN0aW9u
IHdpdGggLSBJIGRvbid0IHRoaW5rDQogICAgdGhleSBhcmUgdXNpbmcgdGhlIHNhbWUgY29udGV4
dC4gIElNTyB0aGUgdGltZXIgd2lsbCBhbHdheXMgYmUgcnVuIGluDQogICAgdGhlIG1haW4gdGhy
ZWFkIG5vIG1hdHRlciB5b3UgdXNlIHBlci1jcHUgdGltZXIgb3Igbm90LCBob3dldmVyIHRoZQ0K
ICAgIHNsZWVwaW5nIHBhcnQgc2hvdWxkIGJlIHJ1biBvbiBwZXItY3B1Lg0KICAgIA0KICAgIEEg
c2ltcGxlIHdheSB0byB2ZXJpZnkgaXQgd291bGQgYmU6IGJyZWFrIGF0IGNwdV90aHJvdHRsZV90
aW1lcl90aWNrKCkNCiAgICB0byBzZWUgd2hpY2ggdGhyZWFkIGl0IGlzIHJ1bm5pbmcgaW4uDQog
ICAgDQoJWW91J3JlIGFic29sdXRlbHkgcmlnaHQsIGl0IHdhcyBpbmRlZWQgYSBjb25mdXNpb24g
SSBtYWRlIChJJ3ZlIHJ1biBhIHRlc3QgaW4gd2hpY2ggSSBwcmludGVkIHRoZSB0aHJlYWQgSURz
IHRvIGNvbmZpcm0gYXMgd2VsbCkuIEhvd2V2ZXIsIEkgYmVsaWV2ZSB0aGF0IHRoZXJlIGFyZSB0
d28gY29udHJpYnV0aW5nIGZhY3RvcnMgcHJldmVudGluZyB0aGUgc2NoZWR1bGluZyBvZiBtb3Jl
IHRoYW4gb25lIHBpZWNlIG9mIHdvcms6IA0KCQktIHRoZSB0aW1lcidzIGZpcmluZyBwZXJpb2Qg
aXMgYWx3YXlzIGdyZWF0ZXIgdGhhbiB0aGUgdkNQVSdzIHNsZWVwaW5nIGludGVydmFsLCB0aGVy
ZWZvcmUgdGhlIHRpbWVyIHdvbid0IGZpcmUgd2hpbGUgYSB2Q1BVIGlzIHNsZWVwaW5nIGFuZCBh
cyBhIGNvbnNlcXVlbmNlIG5vIGFkZGl0aW9uYWwgd29yayBpcyBzY2hlZHVsZWQgKGFzIGxvbmcg
YXMgdGhlIHN0YXJ0IG9mIHRoZSBzbGVlcGluZyB0aW1lIGRvZXMgbm90ICJtb3ZlIHRvIHRoZSBy
aWdodCIgdG93YXJkcyB0aGUgbmV4dCBmaXJpbmcgb2YgdGhlIHRpbWVyKQ0KCQktIHRoZSB0aW1l
cidzIGNhbGxiYWNrIHNjaGVkdWxlcyB3b3JrIGZvciBvbmUgdkNQVSBvbmx5IChzaW1wbGUgJiBm
YXN0KSBwcmV2ZW50aW5nIGFkZGl0aW9uYWwgZGVsYXlzIGJldHdlZW4gd29yayBleGVjdXRpb25z
IG9uIGRpZmZlcmVudCB2Q1BVcyBvciBwb3RlbnRpYWwgb3ZlcmxhcHBpbmcgb2YgdGltZXIgZmly
aW5nIHdpdGggdkNQVSBzbGVlcHMgDQoNCiAgICA+ICAgICA+IA0KICAgID4gICAgID4gCUl0J3Mg
YSBiaXQgdW5jbGVhciB0byBtZSBob3cgdGhlIHRocm90dGxpbmcgcmF0aW8gaW5jb25zaXN0ZW5j
eSBjYW4gYmUgZml4ZWQgYnkgdXNpbmcgYSBzaW5nbGUgdGltZXIgZXZlbiBhdm9pZGluZyB0aGUg
Y29uZGl0aW9uYWwgdGltZXIgcmUtYXJtaW5nLiAgQ291bGQgeW91IHByb3ZpZGUgbW9yZSBkZXRh
aWxzIGFib3V0IHRoZSB1c2Ugb2YgYSBzaW5nbGUgdGltZXIgPw0KICAgID4gDQogICAgPiAJQzog
SSBmZWVsIGxpa2UgaW4gdGhpcyBjYXNlIGl0IHdpbGwgc2xlZXAgdG9vIG11Y2ggcnVubmluZyBp
bnRvIGEgcHJvYmxlbSBzaW1pbGFyIHRvIHRoZSBvbmUgc29sdmVkIGJ5IDkwYmIwYzA7IHVuZGVy
IGhlYXZ5IHRocm90dGxpbmcgbW9yZSB0aGFuIG9uZSB3b3JrIGl0ZW0gbWF5IGJlIHNjaGVkdWxl
ZC4NCiAgICANCiAgICBSaWdodC4gIFNvIEkgZmVlbCBsaWtlIHdlIG5lZWQgYSBzb2x1dGlvbiB0
aGF0IHdpbGwgYXZvaWQgdGhpcyBwcm9ibGVtDQogICAgYnV0IGF0IHRoZSBzYW1lIHRpbWUga2Vl
cCB0aGUgcHJvcGVyIGFjY3VyYWN5IG9mIHRoZSB0aHJvdHRsaW5nLg0KICAgIA0KCUlNTyB0aGUg
cGF0Y2ggYWNoaWV2ZXMgYm90aCBnb2FscyB3aXRob3V0IHB1dHRpbmcgdG9vIG11Y2ggcHJlc3N1
cmUgb24gdGhlIG1haW4gdGhyZWFkIHdoZW4gcnVubmluZyB0aGUgY2FsbGJhY2tzOyB3ZSBjb3Vs
ZCBzZWUgbm8gcHJvYmxlbSByZWxhdGVkIHRvIHRoZSBtYWluIHRocmVhZC9jYWxsYmFja3MgaW4g
YW55IG9mIHRoZSB0ZXN0cyB3ZSByYW4uDQoNCiAgICBUaGFua3MsDQogICAgDQogICAgLS0gDQog
ICAgUGV0ZXIgWHUNCiAgICANClRoYW5rcywNCkNvc21pbg0KDQo=

