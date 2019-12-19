Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0BCC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:12:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A529B20716
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="EednW9U8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A529B20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvbP-0004o6-ID
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:12:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1ihv00-00037Q-4f
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:33:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1ihuzx-0003dQ-9t
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:33:46 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:56756)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1ihuzw-0003Wd-W5
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:33:45 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBJCU4Os023847; Thu, 19 Dec 2019 04:33:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=BITgrT2wWK0TR/bX1tKQwhEIYsRgg90HOPdB+AF1QQM=;
 b=EednW9U8M+MslBerNKV3t/rpE5cFoyyRJw+8qrUzLZB2elHiwfiuBTkU6EAFlf6Or8ye
 1/lbDF+QlQJhIuTlatlrM3EvNv6BpQxUw7i51C+GmAz6DwZ5gn68ttjN8Nsn9asi/s+V
 0hWNi2QnaTjsYAE+qm+VDyLDjGUYMbB5d/aWU/O6ww5HMRw1BK5Is3qHPIl4IPhrsJtj
 qHXW5iMPyIfiD1iMH2OXQl3iuBvwtG0cdZj6f/CThRygsFDKq/a4O1OI6csS9SMZsEuc
 1BnyDZY10A3j84fqX/NMgjTUMaTaedO1E4oPvReGNFlec969sV+vySWa4sA96tN2HcHa dQ== 
Received: from nam02-bl2-obe.outbound.protection.outlook.com
 (mail-bl2nam02lp2052.outbound.protection.outlook.com [104.47.38.52])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2ww056jjee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Dec 2019 04:33:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bt0XfC2K2DXdN0ZsEUEeQrXM5MF5jCVggpOMDjfoA9TXpzq+upmAXH7BO8rHrviAMsGFphP1/ZA1F1P/zqza9yBD/PT6ZpRNw7klHyLsk7lhH3YO/CguygyNhCyj2bw9gAw7F+2EmY9SbBOsNqAGBXClrOPzOR1vpJqxPM+tf2COnHb5oBJwlCQS6j1cbrCMwWBTwop11yfzd9OF2if0jAtvQU21CzxPepVkvrfys8xndlMunkYup0qmY4PVfnqayRltANv81m2YU4MqvNlcz/BJW0SIgHMuJ6vCn8eN8L671RAmKKWZTABOqUz3cXb6z+g/pH90m48GVIPOOoCBmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BITgrT2wWK0TR/bX1tKQwhEIYsRgg90HOPdB+AF1QQM=;
 b=PlHiHZsorgiylkhjK4UtU+9Vk94OBc3hwm1TwkAUjc1NTtNNQ6yf4Npc1EVTPmX5RIHteB2BCs14GFNChYPVeMfhym090Yyv6Y9szTRBJ81kTe+ezCBMfVCcz2RivtXeO93Vr1kNGa1wof0OoCDSdcjUJadgJfI2B5Ttabrns99xN5j6/DJzY2JEVQcBT93vafbdNqeEM/U4HEXAEeVxXIQG0QyUnJdQUQXyvJFAu4Kua38Tx9ZptNS8cfEkbiAo9FkYltGgkUH+pzT8m0pRfRT4msOYGZ92RW+Xv81K+zpteCv7gk4nc8xvKe1abbt/7eIRQP9s1kXDI7yUtl84Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2621.namprd02.prod.outlook.com (10.168.207.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Thu, 19 Dec 2019 12:33:16 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029%10]) with mapi id 15.20.2559.012; Thu, 19 Dec
 2019 12:33:15 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Thread-Topic: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Thread-Index: AQHVryW4uEZJ1V/hTUic5+7Y9QnlRqe35WUAgAVPdACAAAL3CIABWUIAgABrS4CAAmvVgIAACnqA
Date: Thu, 19 Dec 2019 12:33:15 +0000
Message-ID: <772D9CF3-D15D-42D1-B9CF-1279619D7C20@nutanix.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <20191210064716.GA6401@flaka>
 <20191213104116.GB1180977@stefanha-x1.localdomain>
 <20191216194655.GA5922@flaka>
 <AFBAD3A1-0E22-4E22-AF22-C56794929D87@nutanix.com>
 <20191217163316.GB1333385@stefanha-x1.localdomain>
 <DDE3DA62-31DD-437B-8392-CAD505253EED@nutanix.com>
 <20191219115545.GD1624084@stefanha-x1.localdomain>
In-Reply-To: <20191219115545.GD1624084@stefanha-x1.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.9.225.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6e7e3cb-488d-4716-8be2-08d7847f9f05
x-ms-traffictypediagnostic: MWHPR02MB2621:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB26218EB748CB0CBF3D97F560D7520@MWHPR02MB2621.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(396003)(366004)(346002)(39860400002)(189003)(199004)(316002)(8936002)(53546011)(6506007)(6916009)(86362001)(54906003)(186003)(7416002)(71200400001)(2906002)(6512007)(4326008)(76116006)(6486002)(8676002)(36756003)(5660300002)(81156014)(91956017)(81166006)(15650500001)(33656002)(2616005)(66476007)(26005)(64756008)(478600001)(66556008)(66446008)(66946007)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2621;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GJ8yWdffu/fJ+XwGMUE6qKx3S4ByeQ7RgE/vyQxY3bM3PX4pbZVlZoCaRqAorC7TWl4e1UN1mVPT4E0y8ijD7xsIjijVYEsQhUYDl8/ufT/RrvPPTSNAFVw08BUWK95v3Jjd89/66Dx+A85FhtgXFncgBrfW4N3qU9SbjQdpoGkj3Lb+vgRhm/2UPnqixrO3/Qi73ogSoOMbPjtdQAPoeFdPhE3F9bi/WOFBO4mb42vTD3Ej+/8jKsrKcvamUQjkIKouo61Hha5Tu3f3CYlgOiwJn5AImPhmC01FO6TvyBvHscTSC0nLzulPKDoR5mGsXUiuYmyvm79Y3n//Un94AJgyo0A98ZW9SD7wkVQNJAwQyJ7XkyECMRFHUQeIChPC9cRGeWjsBV1q5mmV1zj3/PovCpqJK5eT/43nvx7qAHApXE+cle5DvKGJvPGWzfH36lDBdWla5pcOfXftCXzK9tqj4pRYP99QF8tb+HYu4YjzUIf2c3o+2t3AZkDYnI1p
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDDC311808AB8240AE6EA297CB6B345F@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e7e3cb-488d-4716-8be2-08d7847f9f05
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 12:33:15.5280 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0BFqvHVOkRrUe7hVaLKVhwaSTEaJLUQCXOIoQNkTxaF93bIz1ddN+zUpugGll55U77nKziu2nzPN3Ojv6V3dZZVueByk+GMku+UA4OJASlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2621
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_01:2019-12-17,2019-12-19 signatures=0
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Walker,
 Benjamin" <benjamin.walker@intel.com>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>, "Harris,
 James R" <james.r.harris@intel.com>,
 "quintela@redhat.com" <quintela@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "liran.alon@oracle.com" <liran.alon@oracle.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGVsbG8sDQoNCihJJ3ZlIGFkZGVkIEppbSBhbmQgQmVuIGZyb20gdGhlIFNQREsgdGVhbSB0byB0
aGUgdGhyZWFkLikNCg0KPiBPbiBEZWMgMTksIDIwMTksIGF0IDExOjU1IEFNLCBTdGVmYW4gSGFq
bm9jemkgPHN0ZWZhbmhhQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIERlYyAxNywg
MjAxOSBhdCAxMDo1NzoxN1BNICswMDAwLCBGZWxpcGUgRnJhbmNpb3NpIHdyb3RlOg0KPj4+IE9u
IERlYyAxNywgMjAxOSwgYXQgNTozMyBQTSwgU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRo
YXQuY29tPiB3cm90ZToNCj4+PiBPbiBNb24sIERlYyAxNiwgMjAxOSBhdCAwNzo1NzozMlBNICsw
MDAwLCBGZWxpcGUgRnJhbmNpb3NpIHdyb3RlOg0KPj4+Pj4gT24gMTYgRGVjIDIwMTksIGF0IDIw
OjQ3LCBFbGVuYSBVZmltdHNldmEgPGVsZW5hLnVmaW10c2V2YUBvcmFjbGUuY29tPiB3cm90ZToN
Cj4+Pj4+IO+7v09uIEZyaSwgRGVjIDEzLCAyMDE5IGF0IDEwOjQxOjE2QU0gKzAwMDAsIFN0ZWZh
biBIYWpub2N6aSB3cm90ZToNCj4+PiBRdWVzdGlvbnMgSSd2ZSBzZWVuIHdoZW4gZGlzY3Vzc2lu
ZyBtdXNlciB3aXRoIHBlb3BsZSBoYXZlIGJlZW46DQo+Pj4gDQo+Pj4gMS4gQ2FuIHVucHJpdmls
ZWdlZCBjb250YWluZXJzIGNyZWF0ZSBtdXNlciBkZXZpY2VzPyAgSWYgbm90LCB0aGlzIGlzIGEN
Cj4+PiAgYmxvY2tlciBmb3IgdXNlIGNhc2VzIHRoYXQgd2FudCB0byBhdm9pZCByb290IHByaXZp
bGVnZXMgZW50aXJlbHkuDQo+PiANCj4+IFllcyB5b3UgY2FuLiBNdXNlciBkZXZpY2UgY3JlYXRp
b24gZm9sbG93cyB0aGUgc2FtZSBwcm9jZXNzIGFzIGdlbmVyYWwNCj4+IG1kZXYgZGV2aWNlIGNy
ZWF0aW9uIChpZS4geW91IHdyaXRlIHRvIGEgc3lzZnMgcGF0aCkuIFRoYXQgY3JlYXRlcyBhbg0K
Pj4gZW50cnkgaW4gL2Rldi92ZmlvIGFuZCB0aGUgY29udHJvbCBwbGFuZSBjYW4gZnVydGhlciBk
cm9wIHByaXZpbGVnZXMNCj4+IHRoZXJlIChzZXQgc2VsaW51eCBjb250ZXh0cywgJmMuKQ0KPiAN
Cj4gSW4gdGhpcyBjYXNlIHRoZXJlIGlzIHN0aWxsIGEgcHJpdmlsZWdlZCBzdGVwIGR1cmluZyBz
ZXR1cC4gIFdoYXQgYWJvdXQNCj4gY29tcGxldGVseSB1bnByaXZpbGVnZWQgc2NlbmFyaW9zIGxp
a2UgYSByZWd1bGFyIHVzZXIgd2l0aG91dCByb290IG9yIGENCj4gcm9vdGxlc3MgY29udGFpbmVy
Pw0KDQpPaCwgSSBzZWUgd2hhdCB5b3UgYXJlIHNheWluZy4gSSBzdXBwb3NlIHdlIG5lZWQgdG8g
aW52ZXN0aWdhdGUNCmFkanVzdGluZyB0aGUgcHJpdmlsZWdlcyBvZiB0aGUgc3lzZnMgcGF0aCBj
b3JyZWN0bHkgYmVmb3JlaGFuZCB0bw0KYWxsb3cgZGV2aWNlcyB0byBiZSBjcmVhdGVkIGJ5IG5v
bi1yb290IHVzZXJzLiBUaGUgY3JlZGVudGlhbHMgdXNlZCBvbg0KY3JlYXRpb24gc2hvdWxkIGJl
IHJlZmxlY3RlZCBvbiB0aGUgdmZpbyBlbmRwb2ludCAoaWUuIC9kZXYvZmlvLzxncm91cD4pLg0K
DQpJIG5lZWQgdG8gbG9vayBpbnRvIHRoYXQgYW5kIGdldCBiYWNrIHRvIHlvdS4NCg0KPiANCj4+
PiAyLiBEb2VzIG11c2VyIG5lZWQgdG8gYmUgaW4gdGhlIGtlcm5lbCAoZS5nLiBzbG93ZXIgdG8g
ZGV2ZWxvcC9zaGlwLA0KPj4+ICBzZWN1cml0eSByZWFzb25zKT8gIEEgc2ltaWxhciBsaWJyYXJ5
IGNvdWxkIGJlIGltcGxlbWVudGVkIGluDQo+Pj4gIHVzZXJzcGFjZSBhbG9uZyB0aGUgbGluZXMg
b2YgdGhlIHZob3N0LXVzZXIgcHJvdG9jb2wuICBBbHRob3VnaCBWTU1zDQo+Pj4gIHdvdWxkIHRo
ZW4gbmVlZCB0byB1c2UgYSBuZXcgbGlibXVzZXItY2xpZW50IGxpYnJhcnkgaW5zdGVhZCBvZg0K
Pj4+ICByZXVzaW5nIHRoZWlyIFZGSU8gY29kZSB0byBhY2Nlc3MgdGhlIGRldmljZS4NCj4+IA0K
Pj4gRG9pbmcgaXQgaW4gdXNlcnNwYWNlIHdhcyB0aGUgZmxvdyB3ZSBwcm9wb3NlZCBiYWNrIGlu
IGxhc3QgeWVhcidzIEtWTQ0KPj4gRm9ydW0gKEVkaW5idXJnaCksIGJ1dCBpdCBnb3QgdHVybmVk
IGRvd24uIFRoYXQncyB3aHkgd2UgcHJvY3VyZWQgdGhlDQo+PiBrZXJuZWwgYXBwcm9hY2gsIHdo
aWNoIHR1cm5lZCBvdXQgdG8gaGF2ZSBzb21lIGFkdmFudGFnZXM6DQo+PiAtIE5vIGNoYW5nZXMg
bmVlZGVkIHRvIFFlbXUNCj4+IC0gTm8gUWVtdSBuZWVkZWQgYXQgYWxsIGZvciB1c2Vyc3BhY2Ug
ZHJpdmVycw0KPj4gLSBEZXZpY2UgZW11bGF0aW9uIHByb2Nlc3MgcmVzdGFydCBpcyB0cml2aWFs
DQo+PiAgKGl0IHRoZXJlZm9yZSBtYWtlcyBkZXZpY2UgY29kZSB1cGdyYWRlcyBtdWNoIGVhc2ll
cikNCj4+IA0KPj4gSGF2aW5nIHNhaWQgdGhhdCwgbm90aGluZyBzdG9wcyB1cyBmcm9tIGVuaGFu
Y2luZyBsaWJtdXNlciB0byB0YWxrDQo+PiBkaXJlY3RseSB0byBRZW11IChmb3IgdGhlIFFlbXUg
Y2FzZSkuIEkgZW52aXNpb24gYXQgbGVhc3QgdHdvIHdheXMgb2YNCj4+IGRvaW5nIHRoYXQ6DQo+
PiAtIEhvb2tpbmcgdXAgbGlibXVzZXIgd2l0aCBRZW11IGRpcmVjdGx5IChlZy4gb3ZlciBhIHVu
aXggc29ja2V0KQ0KPj4gLSBIb29raW5nIFFlbXUgd2l0aCBDVVNFIGFuZCBpbXBsZW1lbnRpbmcg
dGhlIG11c2VyLmtvIGludGVyZmFjZQ0KPj4gDQo+PiBGb3IgdGhlIGxhdHRlciwgbGlibXVzZXIg
d291bGQgdGFsayB0byBhIGNoYXJhY3RlciBkZXZpY2UganVzdCBsaWtlIGl0DQo+PiB0YWxrcyB0
byB0aGUgdmZpbyBjaGFyYWN0ZXIgZGV2aWNlLiBXZSAianVzdCIgbmVlZCB0byBpbXBsZW1lbnQg
dGhhdA0KPj4gYmFja2VuZCBpbiBRZW11LiA6KQ0KPiANCj4gV2hhdCBhYm91dDoNCj4gKiBsaWJt
dXNlcidzIEFQSSBzdGF5cyBtb3N0bHkgdW5jaGFuZ2VkIGJ1dCB0aGUgbGlicmFyeSBzcGVha3Mg
YQ0KPiAgIFZGSU8tb3Zlci1VTklYIGRvbWFpbiBzb2NrZXRzIHByb3RvY29sIGluc3RlYWQgb2Yg
dGFsa2luZyB0bw0KPiAgIG1kZXYvdmZpbyBpbiB0aGUgaG9zdCBrZXJuZWwuDQoNCkFzIEkgc2Fp
ZCBhYm92ZSwgdGhlcmUgYXJlIGFkdmFudGFnZXMgdG8gdGhlIGtlcm5lbCBtb2RlbC4gVGhlIGtl
eSBvbmUNCmlzIHRyYW5zcGFyZW50IGRldmljZSBlbXVsYXRpb24gcmVzdGFydHMuIFRvZGF5LCBt
dXNlci5rbyBrZWVwcyB0aGUNCiJkZXZpY2UgbWVtb3J5IiBpbnRlcm5hbGx5IGluIGEgcHJlZml4
IHRyZWUuIFVwb24gcmVzdGFydCwgYSBuZXcNCmRldmljZSBlbXVsYXRvciBjYW4gcmVjb3ZlciBz
dGF0ZSAoZWcuIGZyb20gYSBzdGF0ZSBmaWxlIGluIC9kZXYvc2htDQpvciBzaW1pbGFyKSBhbmQg
cmVtYXAgdGhlIHNhbWUgbWVtb3J5IHRoYXQgaXMgYWxyZWFkeSBjb25maWd1cmVkIHRvDQp0aGUg
Z3Vlc3QgdmlhIFFlbXUuIFdlIGhhdmUgYSBwZW5kaW5nIHdvcmsgaXRlbSBmb3IgbXVzZXIua28g
dG8gYWxzbw0Ka2VlcCB0aGUgZXZlbnRmZHMgc28gd2UgY2FuIHJlY292ZXIgdGhvc2UsIHRvby4g
QW5vdGhlciBhZHZhbnRhZ2UgaXMNCndvcmtpbmcgd2l0aCBhbnkgdXNlcnNwYWNlIGRyaXZlciBh
bmQgbm90IHJlcXVpcmluZyBhIFZNTSBhdCBhbGwuDQoNCklmIGRvbmUgZW50aXJlbHkgaW4gdXNl
cnNwYWNlLCB0aGUgZGV2aWNlIGVtdWxhdG9yIG5lZWRzIHRvIGFsbG9jYXRlDQp0aGUgZGV2aWNl
IG1lbW9yeSBzb21ld2hlcmUgdGhhdCByZW1haW5zIGFjY2Vzc2libGUgKGVnLiB0bXBmcyksIHdp
dGgNCnRoZSBkaWZmZXJlbmNlIHRoYXQgbm93IHdlIG1heSBiZSB0YWxraW5nIGFib3V0IG5vbi10
cml2aWFsIGFtb3VudHMgb2YNCm1lbW9yeS4gQWxzbywgdGhhdCBtYXkgbm90IGJlIHRoZSBraW5k
IG9mIGNvbnRlbnQgeW91IHdhbnQgbGluZ2VyaW5nDQphcm91bmQgdGhlIGZpbGVzeXN0ZW0gKGZv
ciB0aGUgc2FtZSByZWFzb25zIFFlbXUgdW5saW5rcyBtZW1vcnkgZmlsZXMNCmZyb20gL2Rldi9o
dWdlcGFnZXMgYWZ0ZXIgbW1hcCdpbmcgaXQpLg0KDQpUaGF0J3Mgd2h5IEknZCBwcmVmZXIgdG8g
cmVwaHJhc2Ugd2hhdCB5b3Ugc2FpZCB0byAiaW4gYWRkaXRpb24iDQppbnN0ZWFkIG9mICJpbnN0
ZWFkIi4NCg0KPiAqIFZNTXMgY2FuIGltcGxlbWVudCB0aGlzIHByb3RvY29sIGRpcmVjdGx5IGZv
ciBQT1NJWC1wb3J0YWJsZSBhbmQNCj4gICB1bnByaXZpbGVnZWQgb3BlcmF0aW9uLg0KPiAqIEEg
Q1VTRSBWRklPIGFkYXB0ZXIgc2ltdWxhdGVzIC9kZXYvdmZpbyBzbyB0aGF0IFZGSU8tb25seSBW
TU1zIGNhbg0KPiAgIHN0aWxsIHRha2UgYWR2YW50YWdlIG9mIGxpYm11c2VyIGRldmljZXMuDQoN
CkknbSBoYXBweSB3aXRoIHRoYXQuDQpXZSBuZWVkIHRvIHRoaW5rIHRoZSBjcmVkZW50aWFsIGFz
cGVjdCB0aHJvdWdob3V0IHRvIGVuc3VyZSBub2RlcyBjYW4NCmJlIGNyZWF0ZWQgaW4gdGhlIHJp
Z2h0IHBsYWNlcyB3aXRoIHRoZSByaWdodCBwcml2aWxlZ2VzLg0KDQo+IA0KPiBBc3N1bWluZyB0
aGlzIGlzIGZlYXNpYmxlLCB3b3VsZCB5b3UgbG9zZSBhbnkgaW1wb3J0YW50DQo+IGZlYXR1cmVz
L2FkdmFudGFnZXMgb2YgdGhlIG11c2VyLmtvIGFwcHJvYWNoPyAgSSBkb24ndCBrbm93IGVub3Vn
aCBhYm91dA0KPiBWRklPIHRvIGlkZW50aWZ5IGFueSBibG9ja2VyIG9yIG9idmlvdXMgcGVyZm9y
bWFuY2UgcHJvYmxlbXMuDQoNClRoYXQncyB3aGF0IEkgZWxhYm9yYXRlZCBhYm92ZS4gVGhlIGZh
Y3QgdGhhdCBtdXNlci5rbyBjYW4ga2VlcA0KdmFyaW91cyBtZXRhZGF0YSAoYW5kIG90aGVyIHJl
c291cmNlcykgYWJvdXQgdGhlIGRldmljZSBpbiB0aGUga2VybmVsDQphbmQgZ3JhbnQgaXQgYmFj
ayB0byB1c2Vyc3BhY2UgYXMgbmVlZGVkLiBUaGVyZSBhcmUgd2F5cyBhcm91bmQgaXQsDQpidXQg
aXQgcmVxdWlyZXMgc29tZSBvcmNoZXN0cmF0aW9uIHdpdGggdG1wZnMgYW5kIHRoZSBWTU0gKG9u
bHkgc28NCm11Y2ggY2FuIGJlIGtlcHQgaW4gdG1wZnM7IHRoZSBldmVudGZkcyBuZWVkIHRvIGJl
IHJldHJhbnNtaXR0ZWQgZnJvbQ0KdGhlIG1hY2hpbmUgZW11bGF0b3Igb24gcmVxdWVzdCkuDQoN
ClJlc3RhcnRpbmcgaXMgYSBjcml0aWNhbCBhc3BlY3Qgb2YgdGhpcy4gT25lIGtleSB1c2UgY2Fz
ZSBmb3IgdGhlDQpwcm9qZWN0IGlzIHRvIGJlIGFibGUgdG8gZW11bGF0ZSB2YXJpb3VzIGRldmlj
ZXMgZnJvbSBvbmUgcHJvY2VzcyAoZm9yDQpwb2xsaW5nKS4gVGhhdCBtdXN0IGJlIGFibGUgdG8g
cmVzdGFydCBmb3IgdXBncmFkZXMgb3IgcmVjb3ZlcnkuDQoNCj4gDQo+IFJlZ2FyZGluZyByZWNv
dmVyeSwgaXQgc2VlbXMgc3RyYWlnaHRmb3J3YXJkIHRvIGtlZXAgc3RhdGUgaW4gYSB0bXBmcw0K
PiBmaWxlIHRoYXQgY2FuIGJlIHJlb3BlbmVkIHdoZW4gdGhlIGRldmljZSBpcyByZXN0YXJ0ZWQu
ICBJIGRvbid0IHRoaW5rDQo+IGtlcm5lbCBjb2RlIGlzIG5lY2Vzc2FyeT8NCg0KSXQgYWRkcyBh
IGRlcGVuZGVuY3ksIGJ1dCBpc24ndCBhIHNob3cgc3RvcHBlci4gSWYgd2UgY2FuIHdvcmsgdGhy
b3VnaA0KcGVybWlzc2lvbiBpc3N1ZXMsIG1ha2luZyBzdXJlIHRoZSBWTU0gY2FuIHJlY29ubmVj
dCBhbmQgcmV0cmFuc21pdA0KZXZlbnRmZHMgYW5kIG90aGVyIHN0YXRlLCB0aGVuIGl0IHNob3Vs
ZCBiZSBvay4NCg0KVG8gYmUgY2xlYXI6IEknbSB2ZXJ5IGhhcHB5IHRvIGhhdmUgYSB1c2Vyc3Bh
Y2Utb25seSBvcHRpb24gZm9yIHRoaXMsDQpJIGp1c3QgZG9uJ3Qgd2FudCB0byBkaXRjaCB0aGUg
a2VybmVsIG1vZHVsZSAoeWV0LCBhbnl3YXkpLiA6KQ0KDQpGLg0KDQo+IA0KPiBTdGVmYW4NCg0K

