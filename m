Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5385EC35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:23:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D98B20702
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="jhQt0FT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D98B20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izLaM-0002g0-97
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:23:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1izLZW-0001Is-7C
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:22:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1izLZU-0001m6-VE
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:22:30 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:44856)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>)
 id 1izLZR-0001O9-CP; Wed, 05 Feb 2020 09:22:25 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 015EHVA9022941; Wed, 5 Feb 2020 06:22:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=kZf1T1tbBu8pWXfndxlsl3dz1WPAGis06strk+pND8c=;
 b=jhQt0FT7NSsGbqYLlKv5Ng8Z/Xd3E1YftdM9/jWo0TYlckpwDMDThXGAlzbxOZgo4FPP
 OwGHF0aC4iTAlUb4I6rC4KzDAhQ5p1oFXb0fCupW8LgNxJO2/SLfHuq5cOP/Fsm6Uf/H
 viHJjlghj6Dq+asjjaHXKiLJYUzYDebi3Wk2WOPbEJn5v2u1TYF5SuMGO2OmMPtc3z80
 +7i3KZasXhv2Gf8XPLwGK/ErDuxXhf+Qlp5O/L9mg+h7c3pbjZOPeHigkwkIJ+4p67IB
 KwAoRTfm7RrLt9yACUPZA6UpnUxKKW3c608ZyLNTN5fBmwP1XZh+DbIl7zxPyQPoVb8H hg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2xyhnt9qb4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Feb 2020 06:22:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/ihTaXPKA0cRiur9XWlNPf+veSpsWlu80BwzRUUA0agUqkNMdK1XcslSsW1uMdVq7Q/cPJhNb7p6wQQwosp7VjLACnp8xFyQQ8n8SsXumsHR5QEZFrwPSEuBdN9z5VoKgCze3fEG6PlhZlvqmzgGlRzYjhFQC71k7vkUli/HQzjni1pl0UMeSYdm9oClcBzHyb7QxSIfmbOjvsLxa7VumD604cRcnrur1lXZ1MGu7TSFKdQ8u1l+1748u71IXCmkEFNhlPw0n3PAB/X53bWDkB+Nv+dwo7eKUNZ+9S1Z0nmJzQ4Wh4X6Yd2idH6CQQJyj4+b1eFoMFF1gExOtpoFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZf1T1tbBu8pWXfndxlsl3dz1WPAGis06strk+pND8c=;
 b=XW+gsHpvYJa8EIV6bKNmXBgx4CdkZOnUB5jL0BwlnVngSNajQ66/jlq57xZZ8FlfDz0gjUEc92IYz1h7JZ2NXC6VdEtNBnKG47bB+hBlN/IYXhey2DsWPGB53Gp6POJaMgnYILwiSDTXc5wGhTLa7u8+3iiLCXCa5giNalwI3pXB/5Wlt+MB96CGLIP+p88zo9IyEUQ6hayrNlp+gbglxUhVR5rlo2omqwJN8Rl1JJBmrf0mwkbj++/V7TS88/MuCjof+1478TRCmFgE9QO9+77c4/vtfR5r5/03DKBazvDBiC+0F1mMF5bws9vLNsjVytK6U76Loz1tFfzFm9lyKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BN6PR02MB2643.namprd02.prod.outlook.com (10.173.145.9) by
 BN6PR02MB2850.namprd02.prod.outlook.com (10.175.102.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Wed, 5 Feb 2020 14:22:14 +0000
Received: from BN6PR02MB2643.namprd02.prod.outlook.com
 ([fe80::8401:9618:837d:d44b]) by BN6PR02MB2643.namprd02.prod.outlook.com
 ([fe80::8401:9618:837d:d44b%10]) with mapi id 15.20.2686.035; Wed, 5 Feb 2020
 14:22:14 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] iscsi: Cap block count from GET LBA STATUS (CVE-2020-1711)
Thread-Topic: [PATCH] iscsi: Cap block count from GET LBA STATUS
 (CVE-2020-1711)
Thread-Index: AQHV0ersGiQprkLuikaxEpLUh3Oweaf4eTyAgAeQfACAAAM0AIAMro+A
Date: Wed, 5 Feb 2020 14:22:13 +0000
Message-ID: <145163A2-1E9B-4974-B405-760E98DDC950@nutanix.com>
References: <20200123124357.124019-1-felipe@nutanix.com>
 <20200123165955.GB5021@linux.fritz.box>
 <bfb7c669-19dc-5693-8afe-1f70b61c48f3@redhat.com>
 <20200128124220.GE6431@linux.fritz.box>
In-Reply-To: <20200128124220.GE6431@linux.fritz.box>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf74eff1-4294-41af-6802-08d7aa46cbd0
x-ms-traffictypediagnostic: BN6PR02MB2850:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR02MB285000ACEFB276EAC3AA7FADD7020@BN6PR02MB2850.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0304E36CA3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(396003)(346002)(366004)(39860400002)(189003)(199004)(66476007)(81156014)(316002)(81166006)(6486002)(8676002)(478600001)(54906003)(66556008)(2616005)(66446008)(7416002)(5660300002)(2906002)(66946007)(64756008)(33656002)(36756003)(76116006)(91956017)(6512007)(6916009)(53546011)(4326008)(6506007)(26005)(8936002)(86362001)(186003)(71200400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR02MB2850;
 H:BN6PR02MB2643.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1hBVzTik/ZArquvjkLGVUZ3DMQ10Qdl5LLKzAbLVryd5MyT4jq0xHlAKklHE0IIGw8et5Qk+Ywih5gZ+4qjJwizUVjcHZ+75fXaKETqwEeuax1S3YzFNoVptX9nUftTZOuKtukyIjNrz27c/hlStywevXljDdMDOUzR2UUYXooTvMBBXkgziv/dDx73whYqwE/T6VehUMc+OYyvhVfPtl03s5Rrj5iHN/+caJUKEMBtxJ2xVOpFcpiTljP3TfASmW4CBwGuqiJzVQegpY4ule8b0YHOG2muIPFKj0gDzWrQiaquPGJ6EJNyrauY7ONytgMKUNmDR2ML/ceyxrR07pd/0j8dmJYov2PSJ1GDc0cNwLz07G4Vwpl9lZjN0oNFEXZIBYyJRguhy/Bzq7Yqa+7VyOaRLLdIx4GHIHKZ1cRCd99aYCbPVgT4F5KnFll37
x-ms-exchange-antispam-messagedata: iK3Z91dZ5R29SgQ/LS/H77CTyrNTt2gIjAc/vyHF+dbCFpBX6TK4vftySxylKXsuA28IA2dDsNIDfCwxmBaBoOA7CV1qekMTqOqT1vfsosUG94nuwUkOwfPo2fsQsOzIaoPESkdnMZ0oX1jlT/whfQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <46FF1D9E83F75248AC4C900A7DCFCEBB@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf74eff1-4294-41af-6802-08d7aa46cbd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2020 14:22:13.8560 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 52W4qcRo/jGuZnvDuLjFQli0hyhLvcGiwvIhga4u6yVEtLSpurcYnqBOYZTzn090AVZDR8rysOo4lcKyO1q+yUhbjP5zU67JdIuyPZXg0PE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2850
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-05_04:2020-02-04,
 2020-02-05 signatures=0
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
Cc: Peter Turschmid <peter.turschm@nutanix.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Peter Lieven <pl@kamp.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 Jon Maloy <jmaloy@redhat.com>, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, P J P <ppandit@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgYW5kIHNvcnJ5IGZvciB0aGUgZGVsYXksIHRoaXMgZ290IGxvc3QgaW4gbXkgaW5ib3guDQoN
Cj4gT24gSmFuIDI4LCAyMDIwLCBhdCAxMjo0MiBQTSwgS2V2aW4gV29sZiA8a3dvbGZAcmVkaGF0
LmNvbT4gd3JvdGU6DQo+IA0KPiBBbSAyOC4wMS4yMDIwIHVtIDEzOjMwIGhhdCBQaGlsaXBwZSBN
YXRoaWV1LURhdWTDqSBnZXNjaHJpZWJlbjoNCj4+IEhpIGd1eXMsDQo+PiANCj4+IChDYydpbmcg
Sm9uKQ0KPj4gDQo+PiBPbiAxLzIzLzIwIDU6NTkgUE0sIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4g
QW0gMjMuMDEuMjAyMCB1bSAxMzo0NCBoYXQgRmVsaXBlIEZyYW5jaW9zaSBnZXNjaHJpZWJlbjoN
Cj4+Pj4gV2hlbiBxdWVyeWluZyBhbiBpU0NTSSBzZXJ2ZXIgZm9yIHRoZSBwcm92aXNpb25pbmcg
c3RhdHVzIG9mIGJsb2NrcyAodmlhDQo+Pj4+IEdFVCBMQkEgU1RBVFVTKSwgUWVtdSBvbmx5IHZh
bGlkYXRlcyB0aGF0IHRoZSByZXNwb25zZSBkZXNjcmlwdG9yIHplcm8ncw0KPj4+PiBMQkEgbWF0
Y2hlcyB0aGUgb25lIHJlcXVlc3RlZC4gR2l2ZW4gdGhlIFNDU0kgc3BlYyBhbGxvd3Mgc2VydmVy
cyB0bw0KPj4+PiByZXNwb25kIHdpdGggdGhlIHN0YXR1cyBvZiBibG9ja3MgYmV5b25kIHRoZSBl
bmQgb2YgdGhlIExVTiwgUWVtdSBtYXkNCj4+Pj4gaGF2ZSBpdHMgaGVhcCBjb3JydXB0ZWQgYnkg
Y2xlYXJpbmcvc2V0dGluZyB0b28gbWFueSBiaXRzIGF0IHRoZSBlbmQgb2YNCj4+Pj4gaXRzIGFs
bG9jbWFwIGZvciB0aGUgTFVOLg0KPj4+PiANCj4+Pj4gQSBtYWxpY2lvdXMgZ3Vlc3QgaW4gY29u
dHJvbCBvZiB0aGUgaVNDU0kgc2VydmVyIGNvdWxkIGNhcmVmdWxseSBwcm9ncmFtDQo+Pj4+IFFl
bXUncyBoZWFwIChieSBzZWxlY3RpdmVseSBzZXR0aW5nIHRoZSBiaXRtYXApIGFuZCB0aGVuIHNt
YXNoIGl0Lg0KPj4+PiANCj4+Pj4gVGhpcyBsaW1pdHMgdGhlIG51bWJlciBvZiBiaXRzIHRoYXQg
aXNjc2lfY29fYmxvY2tfc3RhdHVzKCkgd2lsbCB0cnkgdG8NCj4+Pj4gdXBkYXRlIGluIHRoZSBh
bGxvY21hcCBzbyBpdCBjYW4ndCBvdmVyZmxvdyB0aGUgYml0bWFwLg0KPj4+PiANCj4+Pj4gU2ln
bmVkLW9mZi1ieTogRmVsaXBlIEZyYW5jaW9zaSA8ZmVsaXBlQG51dGFuaXguY29tPg0KPj4+PiBT
aWduZWQtb2ZmLWJ5OiBQZXRlciBUdXJzY2htaWQgPHBldGVyLnR1cnNjaG1AbnV0YW5peC5jb20+
DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFJhcGhhZWwgTm9yd2l0eiA8cmFwaGFlbC5ub3J3aXR6QG51
dGFuaXguY29tPg0KPj4+IA0KPj4+IFRoYW5rcywgYXBwbGllZCB0byB0aGUgYmxvY2sgYnJhbmNo
Lg0KPj4gDQo+PiBXZSBhcmUgdHJ5aW5nIHRvIHJlcHJvZHVjZSB0aGlzLCBkbyB5b3UgYWxyZWFk
eSBoYXZlIHNvbWUgY29kZSB0aGF0DQo+PiB0cmlnZ2VyZWQgdGhpcyBpc3N1ZT8NCj4gDQo+IEkg
ZG9uJ3QsIG1heWJlIEZlbGlwZSBoYXMgYSByZXByb2R1Y2VyIHRoYXQgd291bGQgY3Jhc2ggUUVN
VS4NCg0KSXQncyBub3QgaGFyZC4NCg0KMSkgQXR0YWNoIGFuIGlTQ1NJIExVTiB0byBRZW11LiBE
byBub3QgcmVhZCBkYXRhIGZyb20gaXQgKHNvIFFlbXUNCiAgIHdvbid0IHBvcHVsYXRlIHRoZSBi
aXRtYXApLg0KMikgSXNzdWUgYSByZWFkIGxhcmdlciB0aGFuIDY0IGJsb2NrcyB0b3dhcmRzIHRo
ZSBlbmQgb2YgdGhlIExVTi4NCiAgIFFlbXUgd2lsbCBhdHRlbXB0IGEgR0VUIExCQSBTVEFUVVMg
dG8gZmluZCBvdXQgaWYgdGhlIHByb3Zpc2lvbmluZw0KICAgc3RhdHVzIG9mIHRoZSBibG9ja3Mu
DQozKSBHZXQgeW91ciBpU0NTSSBzZXJ2ZXIgdG8gcmVzcG9uZCB3aXRoIG1vcmUgYmxvY2tzIHRo
YW4gaXMgYXZhaWxhYmxlDQogICBvbiB0aGUgTFVOIGZvciB0aGF0IExCQS4NCg0KV2UgZGlkIHRo
YXQgd2l0aCBhbiBpU0NTSSBzZXJ2ZXIgd3JpdHRlbiBleGNsdXNpdmVseSBmb3Igc3VjaCB0ZXN0
cy4NCkFsbCB0aGUgcmVzcG9uc2VzIGNhbiBiZSBjb250cm9sbGVkIG9yIGZ1enplZC4gQnV0IGl0
IHNob3VsZCBiZSBlYXN5DQp0byBtb2RpZnkgYW55IGV4aXN0aW5nIHNlcnZlciAoZWcuIGlldCku
DQoNCkYuDQoNCj4gDQo+PiBJIGFtIG5ldyB0byB0aGUgYmxvY2sgQVBJLCBJIG5vdGljZWQgdGhl
IGJsb2NrL2Jsa2RlYnVnLmMgZmlsZSB3aXRoDQo+PiAnYmxrZGVidWcnIG9wdGlvbiwgaXMgaXQg
aGVscGZ1bCB0byByZXByb2R1Y2UgdGhpcyBpc3N1ZSB2aWEgSE1QPw0KPj4gDQo+PiBBbnkgc3Vn
Z2VzdGlvbiB3aGF0IHdvdWxkIGJlIHRoZSBlYXNpZXIvcXVpY2tlciB3YXkgdG8gdGVzdCB0aGlz
Pw0KPiANCj4gT24gdGhlIFFFTVUgc2lkZSwgeW91IGp1c3QgbmVlZCB0byBjb25uZWN0IHRvIGFu
IGlzY3NpIGJhY2tlbmQuIFRoZQ0KPiBtYWxpY2lvdXMgcmVzcG9uc2UgbXVzdCBjb21lIGZyb20g
dGhlIHNlcnZlciwgd2hpY2ggaXMgbm90IHBhcnQgb2YgUUVNVS4NCj4gU28gbm8sIGJsa2RlYnVn
IHdvbid0IGhlbHAgeW91Lg0KPiANCj4+IExvb2tpbmcgZm9yIGlvdGVzdHMgZXhhbXBsZXMgSSBz
ZWUgdGVzdHMvcWVtdS1pb3Rlc3RzLzE0NyBwcm92aWRpbmcgYQ0KPj4gQnVpbHRpbk5CRCBjbGFz
cy4gSXMgaXQgdGhlIHJlY29tbWVuZGVkIHdheSB0byBnbywgdG8gbW9jayBhIGlTQ1NJIHNlcnZl
cj8NCj4gDQo+IFRoYXQgQnVpbHRpbk5CRCBjbGFzcyBkb2Vzbid0IGltcGxlbWVudCBhbiBOQkQg
c2VydmVyLCBidXQgaXQganVzdA0KPiBzdGFydHMgdGhlIGJ1aWx0LWluIE5CRCBzZXJ2ZXIgaW4g
UUVNVSBhbmQgcnVucyBzb21lIHRlc3RzIGFnYWluc3QgaXQuDQo+IFFFTVUgZG9lc24ndCBoYXZl
IGEgYnVpbHQtaW4gaXNjc2kgc2VydmVyLg0KPiANCj4gS2V2aW4NCg0K

