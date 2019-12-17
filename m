Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4513EC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 22:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F04162067C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 22:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="TRUgS7fp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04162067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihLno-0006h7-5I
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 17:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1ihLmb-0005WC-BR
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 17:57:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1ihLmZ-0001HY-7n
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 17:57:36 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:4454)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1ihLmZ-0001G9-1I
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 17:57:35 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBHMthej024616; Tue, 17 Dec 2019 14:57:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=+d9w92Klf/0XQaKcGOIAyCA3jZbYXVJ3TtP7X30Jaac=;
 b=TRUgS7fpziPZf9+XtW43PLA6mSe+zokGGYzCwZ86F3Tfa2i59M6al1GR93D0OvZCxqlu
 ZAr4tzql2X5PTELInEpPuXWCnuUtnftf4PsWP0DyFwzCMNeaVDS62tevJ5EMrFoBLup/
 SfLYd//3AAAT/T9W5++g+/VwdeZaVEQoVombTEGbk2ilEjEu8SFj7EbCOdntuXjOR1V2
 LBr6sWZaOEnkTOo+ARbnsOUCRZayvklHSbUBYiuVPnFWQ7AZynzSuNFOErTeNt92QiXV
 S5bVd/P5hFYnrqJjJN8GBlCdV1wpCjhhH4f166Cpqe7bgxedfjN0p+vRzHAXMSuwbIt7 Gg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2ww056erpb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Dec 2019 14:57:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ez27cE8bcseL+XtLNC0c0ZnVXVm/70ZUm3Xbx5NBwpJ4zwsKE2RSX8+3qd9OtSkbdCuxKGBtX+xN1XHWU4LM3qM1wEglV5+t/btNmDR/j4tOTx7ynMRLQhZyJ7reRo4mAY0fKbU9coA0RZUQjNOR3jOZvPtpmP5JaRz7Gv0IpqIRRO6DZdUfmlZbkVxMJC/UrHLL/i7/IrS827qwzFKiaUd1SfmYNT5k96DBGFtvrFZ28Jwk5tB9tj5GGHSiP9y1/v8qNEGg3pv9Y2C5vXn86ZEwD+ecTGxB1vC/HEHOYdZmNKKEhqf/ba131GTmoY2oQkufLmTMLdJgXfnCoBUeoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+d9w92Klf/0XQaKcGOIAyCA3jZbYXVJ3TtP7X30Jaac=;
 b=oBBd4BoDp4pEo6PxsPqo534zsTEJn/4EqHj/xb1JknBoKW0K1kxy0tRKxtP9w2iv3ivUYVfrlO0qQfCiQ6v7BlspHqC+agkEUvphhmOL7wfkl2DfPJaH71Vpd0oEgq3i3N5+6iv58odfOaxDQ2UlkZ+qQa5yISij7vZf+FBSs0ppb4xYH54MM+UX6tkzgOVe7vU3jg00J+yls5wRqBJoLvnmHF6z2aq9gtDPu2YmHAJvgQUycVbWxMWz2lCg2OtC+kXJmXc9/KqT52+rdAVEbIhIRLBpaMG9+wo6fRmTRnteFReXhbBOAIaZE36+bTmXLUZtyZgYBDayYoJUQr62Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2798.namprd02.prod.outlook.com (10.175.50.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.17; Tue, 17 Dec 2019 22:57:19 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029%10]) with mapi id 15.20.2559.012; Tue, 17 Dec
 2019 22:57:18 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Thread-Topic: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Thread-Index: AQHVryW4uEZJ1V/hTUic5+7Y9QnlRqe35WUAgAVPdACAAAL3CIABWUIAgABrS4A=
Date: Tue, 17 Dec 2019 22:57:17 +0000
Message-ID: <DDE3DA62-31DD-437B-8392-CAD505253EED@nutanix.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <20191210064716.GA6401@flaka>
 <20191213104116.GB1180977@stefanha-x1.localdomain>
 <20191216194655.GA5922@flaka>
 <AFBAD3A1-0E22-4E22-AF22-C56794929D87@nutanix.com>
 <20191217163316.GB1333385@stefanha-x1.localdomain>
In-Reply-To: <20191217163316.GB1333385@stefanha-x1.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [46.189.28.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c128585-2368-4a2e-d3a3-08d783447761
x-ms-traffictypediagnostic: MWHPR02MB2798:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB2798AE6F0FE6317BB4C52ED3D7500@MWHPR02MB2798.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(376002)(396003)(39860400002)(346002)(189003)(199004)(15650500001)(478600001)(316002)(107886003)(966005)(6512007)(5660300002)(8936002)(54906003)(6486002)(6916009)(71200400001)(4326008)(186003)(2616005)(66946007)(66476007)(64756008)(66556008)(66446008)(33656002)(8676002)(81166006)(26005)(81156014)(86362001)(53546011)(6506007)(91956017)(2906002)(76116006)(36756003)(7416002)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2798;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wnkrXBROyX7zIdI/8dw7ad0ryG8g9lM9/fb4ckw/J9swqOUnkLyyl4vw9RUOR60seq6n0TTw4KSWD4fo9SkVjA8R5Qj/9Sxb3VBrEZaI/E40bN3m95bt4j1/WELA4ECbnI8A1h+urIkAuWv9QgH+rjODHafZ4eFxQVXRlBfPz2IB1KAVcnvE4BxxJu8m7AsiIr4cCmBFwaPHY/TynXbCTr+5toVWVqdpCexueLXBA0i4bB9MZA5JKDtfJ3ATgEuHg4jQtlivxAf77005T9OsED3+l1qBJv1EsSgAwk8WdN40hfTJ8KVbKACtRPFYNXmDXjgcbPCEXPST+OGEwRzzn70UMhNXJ22nMZQojeefOLyk8jRvBAsqDlnnQpuFjgTnDvuUOsc1MSB4AvhYif3aQNPTNDQ8vAbvEUxGkS83V6SpyKldGjNWMIc+sBfYA7M8cz5bVHQizOd5IkHJ7luSwd8vs0+0UaNw3oRItN8cfZ7ftCmVozzNZpgwUMlM+ZKXT/eW+031XePz3Q6hGiYsovTRHufn0SanjMLtZMkKISs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <459E2FF8C643A8468FF7B7F73CD1C066@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c128585-2368-4a2e-d3a3-08d783447761
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 22:57:17.6051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AnTOLP5uTVjWS+dKNRW/IzzM6k5PBXS5S4IIETCfyNUOF44uBcUM2FmtVnAqD+SZ0zbSTMLszm7L6AO4XlFJPD+kOKLTERiBznXvtuVAJs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2798
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_04:2019-12-17,2019-12-17 signatures=0
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "fam@euphon.net" <fam@euphon.net>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "quintela@redhat.com" <quintela@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "liran.alon@oracle.com" <liran.alon@oracle.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gT24gRGVjIDE3LCAyMDE5LCBhdCA1OjMzIFBNLCBTdGVmYW4gSGFqbm9jemkgPHN0ZWZh
bmhhQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gTW9uLCBEZWMgMTYsIDIwMTkgYXQgMDc6
NTc6MzJQTSArMDAwMCwgRmVsaXBlIEZyYW5jaW9zaSB3cm90ZToNCj4+PiBPbiAxNiBEZWMgMjAx
OSwgYXQgMjA6NDcsIEVsZW5hIFVmaW10c2V2YSA8ZWxlbmEudWZpbXRzZXZhQG9yYWNsZS5jb20+
IHdyb3RlOg0KPj4+IO+7v09uIEZyaSwgRGVjIDEzLCAyMDE5IGF0IDEwOjQxOjE2QU0gKzAwMDAs
IFN0ZWZhbiBIYWpub2N6aSB3cm90ZToNCj4+Pj4gSXMgdGhlcmUgYSB3b3JrLWluLXByb2dyZXNz
IG11c2VyIHBhdGNoIHNlcmllcyB5b3UgY2FuIHBvc3QgdG8gc3RhcnQgdGhlDQo+Pj4+IGRpc2N1
c3Npb24gZWFybHk/ICBUaGF0IHdheSB3ZSBjYW4gYXZvaWQgcmV2aWV3ZXJzIGxpa2UgbXlzZWxm
IGFza2luZw0KPj4+PiB5b3UgdG8gbWFrZSBjaGFuZ2VzIGFmdGVyIHlvdSBoYXZlIGludmVzdGVk
IGEgbG90IG9mIHRpbWUuDQo+Pj4+IA0KPj4+IA0KPj4+IEFic29sdXRlbHksIHRoYXQgaXMgb3Vy
IHBsYW4uIEF0IHRoZSBtb21lbnQgd2UgZG8gbm90IGhhdmUgdGhlIHBhdGNoZXMNCj4+PiByZWFk
eSBmb3IgdGhlIHJldmlldy4gV2UgaGF2ZSBzZXR1cCBpbnRlcm5hbGx5IGEgbWlsZXN0b25lIGFu
ZCB3aWxsIGJlDQo+Pj4gc2VuZGluZyB0aGF0IGVhcmx5IHZlcnNpb24gYXMgYSB0YXJiYWxsIGFm
dGVyIHdlIGhhdmUgaXQgY29tcGxldGVkLg0KPj4+IFdvdWxkIGJlIGFsc28gYSBtZWV0aW5nIHNv
bWV0aGluZyB0aGF0IGNvdWxkIGhlbHAgdXMgdG8gc3RheSBvbiB0aGUgc2FtZQ0KPj4+IHBhZ2U/
DQo+PiANCj4+IFBsZWFzZSBsb29wIHVzIGluIGlmIHlvdSBzbyBzZXQgdXAgYSBtZWV0aW5nLg0K
PiANCj4gVGhlcmUgaXMgYSBiaS13ZWVrbHkgS1ZNIENvbW11bml0eSBDYWxsIHRoYXQgd2UgY2Fu
IHVzZSBmb3IgcGhvbmUNCj4gZGlzY3Vzc2lvbnM6DQo+IA0KPiAgaHR0cHM6Ly9jYWxlbmRhci5n
b29nbGUuY29tL2NhbGVuZGFyL2VtYmVkP3NyYz1kRzlpTVhScWNYQXpOM1k0Wlhad056Um9NSEU0
YTNCcWNYTkFaM0p2ZFhBdVkyRnNaVzVrWVhJdVoyOXZaMnhsTG1OdmJRDQo+IA0KPiBPciB3ZSBj
YW4gc2NoZWR1bGUgYSBvbmUtb2ZmIGNhbGwgYXQgYW55IHRpbWUgOikuDQoNClNvdW5kcyBnb29k
IGVpdGhlciB3YXksIHdoZW5ldmVyIGl0J3MgbmVlZGVkLg0KDQo+IA0KPiBRdWVzdGlvbnMgSSd2
ZSBzZWVuIHdoZW4gZGlzY3Vzc2luZyBtdXNlciB3aXRoIHBlb3BsZSBoYXZlIGJlZW46DQo+IA0K
PiAxLiBDYW4gdW5wcml2aWxlZ2VkIGNvbnRhaW5lcnMgY3JlYXRlIG11c2VyIGRldmljZXM/ICBJ
ZiBub3QsIHRoaXMgaXMgYQ0KPiAgIGJsb2NrZXIgZm9yIHVzZSBjYXNlcyB0aGF0IHdhbnQgdG8g
YXZvaWQgcm9vdCBwcml2aWxlZ2VzIGVudGlyZWx5Lg0KDQpZZXMgeW91IGNhbi4gTXVzZXIgZGV2
aWNlIGNyZWF0aW9uIGZvbGxvd3MgdGhlIHNhbWUgcHJvY2VzcyBhcyBnZW5lcmFsDQptZGV2IGRl
dmljZSBjcmVhdGlvbiAoaWUuIHlvdSB3cml0ZSB0byBhIHN5c2ZzIHBhdGgpLiBUaGF0IGNyZWF0
ZXMgYW4NCmVudHJ5IGluIC9kZXYvdmZpbyBhbmQgdGhlIGNvbnRyb2wgcGxhbmUgY2FuIGZ1cnRo
ZXIgZHJvcCBwcml2aWxlZ2VzDQp0aGVyZSAoc2V0IHNlbGludXggY29udGV4dHMsICZjLikNCg0K
PiANCj4gMi4gRG9lcyBtdXNlciBuZWVkIHRvIGJlIGluIHRoZSBrZXJuZWwgKGUuZy4gc2xvd2Vy
IHRvIGRldmVsb3Avc2hpcCwNCj4gICBzZWN1cml0eSByZWFzb25zKT8gIEEgc2ltaWxhciBsaWJy
YXJ5IGNvdWxkIGJlIGltcGxlbWVudGVkIGluDQo+ICAgdXNlcnNwYWNlIGFsb25nIHRoZSBsaW5l
cyBvZiB0aGUgdmhvc3QtdXNlciBwcm90b2NvbC4gIEFsdGhvdWdoIFZNTXMNCj4gICB3b3VsZCB0
aGVuIG5lZWQgdG8gdXNlIGEgbmV3IGxpYm11c2VyLWNsaWVudCBsaWJyYXJ5IGluc3RlYWQgb2YN
Cj4gICByZXVzaW5nIHRoZWlyIFZGSU8gY29kZSB0byBhY2Nlc3MgdGhlIGRldmljZS4NCg0KRG9p
bmcgaXQgaW4gdXNlcnNwYWNlIHdhcyB0aGUgZmxvdyB3ZSBwcm9wb3NlZCBiYWNrIGluIGxhc3Qg
eWVhcidzIEtWTQ0KRm9ydW0gKEVkaW5idXJnaCksIGJ1dCBpdCBnb3QgdHVybmVkIGRvd24uIFRo
YXQncyB3aHkgd2UgcHJvY3VyZWQgdGhlDQprZXJuZWwgYXBwcm9hY2gsIHdoaWNoIHR1cm5lZCBv
dXQgdG8gaGF2ZSBzb21lIGFkdmFudGFnZXM6DQotIE5vIGNoYW5nZXMgbmVlZGVkIHRvIFFlbXUN
Ci0gTm8gUWVtdSBuZWVkZWQgYXQgYWxsIGZvciB1c2Vyc3BhY2UgZHJpdmVycw0KLSBEZXZpY2Ug
ZW11bGF0aW9uIHByb2Nlc3MgcmVzdGFydCBpcyB0cml2aWFsDQogIChpdCB0aGVyZWZvcmUgbWFr
ZXMgZGV2aWNlIGNvZGUgdXBncmFkZXMgbXVjaCBlYXNpZXIpDQoNCkhhdmluZyBzYWlkIHRoYXQs
IG5vdGhpbmcgc3RvcHMgdXMgZnJvbSBlbmhhbmNpbmcgbGlibXVzZXIgdG8gdGFsaw0KZGlyZWN0
bHkgdG8gUWVtdSAoZm9yIHRoZSBRZW11IGNhc2UpLiBJIGVudmlzaW9uIGF0IGxlYXN0IHR3byB3
YXlzIG9mDQpkb2luZyB0aGF0Og0KLSBIb29raW5nIHVwIGxpYm11c2VyIHdpdGggUWVtdSBkaXJl
Y3RseSAoZWcuIG92ZXIgYSB1bml4IHNvY2tldCkNCi0gSG9va2luZyBRZW11IHdpdGggQ1VTRSBh
bmQgaW1wbGVtZW50aW5nIHRoZSBtdXNlci5rbyBpbnRlcmZhY2UNCg0KRm9yIHRoZSBsYXR0ZXIs
IGxpYm11c2VyIHdvdWxkIHRhbGsgdG8gYSBjaGFyYWN0ZXIgZGV2aWNlIGp1c3QgbGlrZSBpdA0K
dGFsa3MgdG8gdGhlIHZmaW8gY2hhcmFjdGVyIGRldmljZS4gV2UgImp1c3QiIG5lZWQgdG8gaW1w
bGVtZW50IHRoYXQNCmJhY2tlbmQgaW4gUWVtdS4gOikNCg0KPiANCj4gMy4gU2hvdWxkIHRoaXMg
ZmVhdHVyZSBiZSBMaW51eC1vbmx5PyAgdmhvc3QtdXNlciBjYW4gYmUgaW1wbGVtZW50ZWQgb24N
Cj4gICBub24tTGludXggT1Nlcy4uLg0KDQpUaGUgdXNlcnNwYWNlIGFwcHJvYWNoIGRpc2N1c3Nl
ZCBhYm92ZSBjZXJ0YWlubHkgY2FuIGJlIG1vcmUgcG9ydGFibGUuDQpDdXJyZW50bHksIG11c2Vy
IGRlcGVuZHMgb24gTURFVitWRklPIGFuZCB0aGF0J3Mgd2hlcmUgdGhlIHJlc3RyaWN0aW9uDQpj
b21lcyBmcm9tLg0KDQpGLg0KDQo+IA0KPiBTdGVmYW4NCg0K

