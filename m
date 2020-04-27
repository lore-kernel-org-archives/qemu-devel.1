Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3B5C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:07:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F8752064A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="EEWVY1lO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8752064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSzk3-0007lN-Oe
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 05:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jSziX-0006Vk-72
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jSziV-0008Nl-79
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:06:20 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:9274)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jSziU-00088f-G9
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:06:18 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03R92UVx023757; Mon, 27 Apr 2020 02:06:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=CH7EF7Dygdd5nzoUICkDq8ZYp+9U9AjyL+azceaA2gk=;
 b=EEWVY1lOZkPrLesL3NN1DynE5VqZspC6huDZVmhcbBDEwb2An7SacIwE2uD8O+PM0TJZ
 AZj2eCC6z5mSjLRsy79ecdVb/k61BJNAF5a8bhejI6SixseYMJoduisUcnUTWkk27o4f
 bhuP1XN9w/NS6jPUmpsvsj43FFXgUk2lOGI7c/HQQzrAMWT/+7h75tnxji51pLaSuTlU
 FtjlUlpv23+q3R3f9VmlaJ/iQXhpzauJixK3AHXOxjlN7Ahqm9/BY1RMm3qkPE5TKrVB
 VJFoucsscRA0qMGq8wrMXly491FKgS92ZcUYUNxpzqUcxBnisgZLZxsf2xBypTUuyd3f Gg== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
 by mx0b-002c1b01.pphosted.com with ESMTP id 30mkaju7ve-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Apr 2020 02:06:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUPRhU2AbbRUwqYmJoDvD4awnOpullI3oGMIY2YWNDpKhSjABz/+ocfm95EXVNnc7p/ffsoXwhpSD/7ex6tR8Bypy31S02RFeCxwA4dzKMn3Vf1bIScSFyYfo+lzLLX8TPhDyNQ5wS5zJqlIddqTZHdkmJB/rPA8cuEC0fKni196ZlmTpzrAZ5uafL2u+o66X1sG5NJQzudTYzsQrtYiPZGjnc9ASnHL9XnQLUtCbvyr6ofNIDYYy3l9SbIzACSTsogG7tUXm821eOEe5bs3UAyUIKMMjSYIpJGa147cqWAzpcC1OO7yvjmtLn+tKKJDlQHRJhSOn+RSs7XvKowTnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CH7EF7Dygdd5nzoUICkDq8ZYp+9U9AjyL+azceaA2gk=;
 b=cPuO7Q+F6Svl0Eg5gbTJMzZ/EJYHS1X1XEw2MQc87gRZ3mK0ssQqkI09YlR2K8rLD02iFj4+roABXCW6quEil0qPXXagoZZWB8F+zGa34s12SJxonr23FsZN9c6Gc43BxX+b9jyv+VfDjzWkKP9P+wPj7bgEXMZgNLc3CmAE0DmX7Un3/nI3QwS26y7oinex3zqk44gzshi4KlxJ0APNtJjcv7soNRBsYBSyKogEwBWDaNE+Unlbb6YocsWMEkqQ6Ocf6zGTC6PDonk1AvPdXfryfV85PrIwbn9vAvYXCO3vTZVr81AGuOTJYJySnezaQwcKLdqAuivpoBociDDohA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB6239.namprd02.prod.outlook.com (2603:10b6:208:1bf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 09:06:13 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a%7]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 09:06:12 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Topic: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Index: AQHWFMrLeCs/JzKNrUaCDY3Nn1YJmqh9b9kAgAACaICAAAksAIAERh2AgABeQwCAAY19AIAABL+AgAFKiACAA3KSgIAAOCMAgAQVL4A=
Date: Mon, 27 Apr 2020 09:06:12 +0000
Message-ID: <76AB39E0-C6AC-4117-8311-27498A3E7B3E@nutanix.com>
References: <1587136411-200885-1-git-send-email-ani.sinha@nutanix.com>
 <20200417112620-mutt-send-email-mst@kernel.org>
 <2A13ACCD-BD24-41FB-B6EA-2804F7C1FF1D@nutanix.com>
 <20200417120732-mutt-send-email-mst@kernel.org>
 <20200420092459.GF346737@redhat.com>
 <20200420105936-mutt-send-email-mst@kernel.org>
 <07BC06B8-34F6-4C46-ACCE-DD7A4CBA9BC7@nutanix.com>
 <20200421150201.GI479771@redhat.com>
 <A31A7DC2-E1FB-409B-9A99-324F8879E9AD@nutanix.com>
 <819DA747-F897-44A4-A238-B6F20C4C8B08@nutanix.com>
 <20200424184448.GS4952@habkost.net>
In-Reply-To: <20200424184448.GS4952@habkost.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.146.154.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfe56036-bca9-4398-146c-08d7ea8a3bf7
x-ms-traffictypediagnostic: MN2PR02MB6239:
x-microsoft-antispam-prvs: <MN2PR02MB623926DD600A79AF92D13370F1AF0@MN2PR02MB6239.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0386B406AA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(366004)(39860400002)(136003)(376002)(396003)(4326008)(6486002)(26005)(186003)(6512007)(8936002)(81156014)(76116006)(316002)(54906003)(64756008)(66476007)(91956017)(53546011)(6506007)(66556008)(66946007)(66446008)(2906002)(71200400001)(2616005)(5660300002)(478600001)(86362001)(36756003)(33656002)(8676002)(44832011)(6916009);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VoWXRVd8Voq1bsTAp34oq3vOqN2BzbNqXopBFxT7imEWeNc+3sYLvNw1oU+cnKyMwBGRf/kaiHLYEMe+S3mtc6+W54O2iuE20QnREeqqigGUJltrrKQoP6gykbfW/tYzS9i7F9aJ9EEJCquMasDKvZNoxSSwYgjS9LzIlVhzrMJgiFndtDAYE8NldTP9AOuOrrvwzabMl2DmbeeuNHymMBdlGx/7B5VnrnlX4voLB04TMkGK0NTEFac8rjX3JLLZN68XYHjtN7g4zPhp67bZP9b7IGDQri1UKIpIc0oKMJp4RgspRTEbsulW3Yerysp2MU/qtz9CU4sa2T59H2sfnnGEioBUBiTjTR8bk54BVXb67wtETNMZmWydwNyNCX7ZSQK0w2NmaK0eznHGmhPlAQUiXlnsoYMWWTqDAnw08Ch/VpR6N+RF3ac1zHkn0NF4
x-ms-exchange-antispam-messagedata: 8iFqh6OW/5RXtG+/K1f1NiAcTMGuGD86Pjp3CLGC9Z+MMbtIcBpJins5GM5OSGVrf80AASU4+AlAuhnvlrTKIa/BQNwEKM7Fck7lMrhPHTQmX2eR5vN3OTpM/Y0Wi/em1vRWMNiQvzPFEpg/UwiSevVJ91b4ZpiMFqe5lbiRF4I3KgR1Pemo1FUj1M1/1o684F+d0z+UIB5CTJxBGADDtR46IQOIpcj+2kID5LLINB/DUbeJMoVfT4MxOQetkkyadMjQ6BT2Jo1PEGEaIsmTF3/xyO9+zsfhARtM2FK04F6r44vSvvcRdwHpxtMCpmjKaxDggagTZnl7gaaYdxrE8ZrV5HsH0s2g6Oo8Px0HgADdBr0Y0oZE+2AmZIq9i0GDZcRfD/tMoyCN+sBXwTao+nVls/SduidiqDbwh0eu03iTnt1gTv0Xt//4k8P8LYjtQ7eCF5SIWoDN578pWVpyErN1eWo4tAx5YBGgy81DfvmXMPVTwenm9RAmy39L6Q/WNwjSi5unMWFdQnArJueeNZ4UPk5SwyYFJbehAkQSZbv457aviAjz5zU6q/CuohZZ6bjzbymGVoVoy4t2rj3XA4GpE2wLFLwTdzPwCZFp6/ZLLA4h7dfoCLZGIewxGeP8y1Xntgx6EXGUVG0FulOgzeeijN8wPxISd8didg+Ks69d/WCv6ZI1R0ype64OpxwwQbq5jgSYtkb3idd0WAQiquj9jSN4LwmDAUrD/ch+xcnUltw/75Xbir8wCs74hOQ3VzoJ4LitvRRewvZTq23TxvpEgDRYea/EPYVXTLu9H+Q=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8966B8BD47A81840976A751810301425@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe56036-bca9-4398-146c-08d7ea8a3bf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 09:06:12.7240 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m30xxFboMzRs0dbAB1Ii2qcPeye/PI/Vx3KrV/yMfRcM0r6rwPW4RZOKmPFsfpqP9E/CDQA2O9JKiBvx+3SrKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6239
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-27_05:2020-04-24,
 2020-04-27 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=ani.sinha@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 05:06:15
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
Cc: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gT24gQXByIDI1LCAyMDIwLCBhdCAxMjoxNCBBTSwgRWR1YXJkbyBIYWJrb3N0IDxlaGFi
a29zdEByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgQXByIDI0LCAyMDIwIGF0IDAz
OjIzOjU2UE0gKzAwMDAsIEFuaSBTaW5oYSB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gQXByIDIy
LCAyMDIwLCBhdCA0OjE1IFBNLCBBbmkgU2luaGEgPGFuaS5zaW5oYUBudXRhbml4LmNvbT4gd3Jv
dGU6DQo+Pj4gDQo+Pj4gDQo+Pj4gDQo+Pj4+IE9uIEFwciAyMSwgMjAyMCwgYXQgODozMiBQTSwg
RGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4gd3JvdGU6DQo+Pj4+IA0K
Pj4+PiBPbiBUdWUsIEFwciAyMSwgMjAyMCBhdCAwMjo0NTowNFBNICswMDAwLCBBbmkgU2luaGEg
d3JvdGU6DQo+Pj4+PiANCj4+Pj4+IA0KPj4+Pj4+IE9uIEFwciAyMCwgMjAyMCwgYXQgODozMiBQ
TSwgTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6DQo+Pj4+Pj4gDQo+
Pj4+Pj4gQnV0IEkgZm9yIG9uZSB3b3VsZCBsaWtlIHRvIGZvY3VzIG9uIGtlZXBpbmcgUElJWCBz
dGFibGUNCj4+Pj4+PiBhbmQgZm9jdXMgZGV2ZWxvcG1lbnQgb24gcTM1LiAgTm90IGJsb2F0aW5n
IFBJSVggd2l0aCBsb3RzIG9mIG5ldw0KPj4+Pj4+IGZlYXR1cmVzIGlzIElNSE8gYSBnb29kIHdh
eSB0byBkbyB0aGF0Lg0KPj4+Pj4gDQo+Pj4+PiBEb2VzIHRoaXMgbWVhbiB0aGlzIHBhdGNoIGlz
IGEgbm8tZ28gdGhlbj8gOigNCj4+Pj4gDQo+Pj4+IEknZCBzdXBwb3J0IHRoaXMgcGF0Y2gsIGFz
IEkgZG9uJ3QgdGhpbmsgaXQgY2FuIHJlYWxseSBiZSBkZXNjcmliZWQgYXMNCj4+Pj4gYmxvYXQg
b3IgZGVzdGFiYWxpemluZy4gSXQgaXMganVzdCBhZGRpbmcgYSBzaW1wbGUgcHJvcGVydHkgdG8N
Cj4+Pj4gY29uZGl0aW9uYWxpemUgZXhpc3RpbmcgZnVuY3Rpb25hbGl0eS4gIFRlbGxpbmcgcGVv
cGxlIHRvIHN3aXRjaCB0byBRMzUNCj4+Pj4gaXMgdW5yZWFzb25hYmxlIGFzIGl0IGlzIG5vdCBh
IHNpbXBsZSAxLTEgY29udmVyc2lvbiBmcm9tIGV4aXN0aW5nIHVzZQ0KPj4+PiBvZiBQSUlYLiBR
MzUgaGFzIG11Y2ggaGlnaGVyIGNvbXBsZXhpdHkgaW4gaXRzIGNvbmZpZ3VyYXRpb24sIGhhcyBo
aWdoZXINCj4+Pj4gbWVtb3J5IG92ZXJoZWFkIHBlciBWTSB0b28sIGFuZCBsYWNrcyBjZXJ0YWlu
IGZlYXR1cmVzIG9mIFBJSVggdG9vLg0KPj4+IA0KPj4+IENvb2wuIEhvdyBkbyB3ZSBnbyBmb3J3
YXJkIGZyb20gaGVyZT8NCj4+PiANCj4+IA0KPj4gV2Ugd291bGQgcmVhbGx5IGFwcHJlY2lhdGUg
aWYgd2UgY2FuIGFkZCB0aGlzIGV4dHJhIGtub2IgaW4NCj4+IFFlbXUuIE1heWJlIHNvbWVvbmUg
ZWxzZSBhbHNvIGluIHRoZSBjb21tdW5pdHkgd2lsbCBmaW5kIHRoaXMNCj4+IHVzZWZ1bC4gV2Ug
ZG9u4oCZdCB3YW50IHRvIG1haW50YWluIHRoaXMgcGF0Y2ggaW50ZXJuYWxseSBmb3JldmVyDQo+
PiBidXQgcmF0aGVyIHByZWZlciB3ZSBtYWludGFpbiB0aGlzIGFzIGEgUWVtdSBjb21tdW5pdHku
DQo+IA0KPiBNaWNoYWVsLCBJIGFncmVlIHdpdGggRGFuaWVsIGhlcmUgYW5kIEkgZG9uJ3QgdGhp
bmsgd2Ugc2hvdWxkDQo+IHN0YXJ0IHJlZnVzaW5nIFBJSVggZmVhdHVyZXMgaWYgdGhleSBhcmUg
dXNlZnVsIGZvciBhIHBvcnRpb24gb2YNCj4gdGhlIFFFTVUgY29tbXVuaXR5Lg0KPiANCj4gV291
bGQgeW91IHJlY29uc2lkZXIgYW5kIG1lcmdlIHRoaXMgcGF0Y2g/DQoNClRoYW5rcyE=

