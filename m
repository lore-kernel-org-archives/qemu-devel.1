Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97087C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 19:58:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6326C2146E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 19:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="0oqBGMdy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6326C2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igwVg-0004S0-Hc
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 14:58:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1igwV4-00041t-1d
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:57:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1igwV2-0004SE-0U
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:57:49 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:15336)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1igwV1-0004If-N5
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:57:47 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBGJsI5J021632; Mon, 16 Dec 2019 11:57:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=MKtYYzTP5QCib/wKvU95CCxb8QzQZ+WQ87DoVxfuPDA=;
 b=0oqBGMdy5Rvg74gP+UKgz8Ce4BLrvHpjToz50hblTmGHW9tctML+q8swyEO8KFo6ndpX
 Gz1EgJeLQEHKgJZ+biesKEn0FzY4A1mkpzEeZbJ9DAqCs7sBMDcKiTv7lTtIq6I0eOGY
 hnXh8Wdoj7yHXZAz7j9Cq9K9Ja4urBqqotpyFs6NNbBWSx3l/fMEWUg3wSHjsJvIouqu
 dL6XKdtsAoBqXIKz4EKC6X+8QJ/wk5GEDVmFdomHOaYE90SBuSW0pLlgFt3vTlUqX6fM
 CKFSVqoZJrKhU3QosNqrYI9Tu5sugmxOX91ARr5pRF2evlUVVNjPq/vUearUZJNTG9Gi jg== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2wvyppkx28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Dec 2019 11:57:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hn29vYxp2yOWn4VXvIRjDbOolBfs/gqb8NfHvBsI5YuzOJ0f7182MW7zshHhUxvHVdl/UBm4qu4Ne5B3ditAz227JKgohIruf79NFq0QbkOZvJvt27n8Hx99NqLUNXZXrkwSTUn64tTxF/v22yJLZ1aY7TssDtUK8VPXQSbduXw3UWJrO7Z2FVyRW38aWu8oQuwJ+OhQx186XDA+/eJHw6D1pEBvps6EfukQlel2FgGZgv8Fi/z7mcOiVjcWMW0K+Jie63KwFd/1w0QbfW5wCl+ast+Fjp1j8n/v3Y0fSeJbL3s3AoGHNQnp7i7eq7iFdK7fb2/AtlY/b7/31Ga7Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKtYYzTP5QCib/wKvU95CCxb8QzQZ+WQ87DoVxfuPDA=;
 b=b858MLuQaZk+oL2nQzf8fxK1pxXoFDg9g5AIIumKpL7HXy5Yj6jwK0AOyHkxy5U5KTpfEpXH77ziSs7xxFiw1mKTOoJnWOKGUv0iGNpUZcBjCy/pg0CrTbWeoHnoFa6VtV/CwNHeHXJWNlrU7pMJYD3CYVjh0GlD3UR6c5qBS9CfroG+3keKTJXGv7vg5Y9dxTCkDUtavHkuScWrJm/CaDpivWDJR1uhMytJBQiYrR8UktNQyC34qenYycRD/Uy+Nzp8f2QbqHpLex4MLxQqO0eMaKDTtd4FdPk9gnZ95sdGB+1J6xFohNPkYHiy1Dg56H/UeG/1IpegXeghx5b2/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB3376.namprd02.prod.outlook.com (10.164.187.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Mon, 16 Dec 2019 19:57:32 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029%10]) with mapi id 15.20.2538.019; Mon, 16 Dec
 2019 19:57:32 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Thread-Topic: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Thread-Index: AQHVryW4uEZJ1V/hTUic5+7Y9QnlRqe35WUAgAVPdACAAAL3CA==
Date: Mon, 16 Dec 2019 19:57:32 +0000
Message-ID: <AFBAD3A1-0E22-4E22-AF22-C56794929D87@nutanix.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <20191210064716.GA6401@flaka>
 <20191213104116.GB1180977@stefanha-x1.localdomain>,
 <20191216194655.GA5922@flaka>
In-Reply-To: <20191216194655.GA5922@flaka>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.197.121.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a775e90f-5b8a-43d4-30e4-08d78262308a
x-ms-traffictypediagnostic: MWHPR02MB3376:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB3376184AA4224C7F1ED3708ED7510@MWHPR02MB3376.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(396003)(366004)(39860400002)(136003)(189003)(199004)(6512007)(33656002)(478600001)(26005)(6506007)(2616005)(5660300002)(81166006)(81156014)(316002)(8936002)(36756003)(6486002)(66946007)(91956017)(76116006)(66476007)(66556008)(64756008)(66446008)(71200400001)(8676002)(6916009)(54906003)(4326008)(186003)(7416002)(2906002)(53546011)(86362001)(107886003)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB3376;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ezashc7ruvCHORo4QJ/Elb5DgcBWsYg+YMmqNiTMU6w6+pmOOnB05JbBMs0qrHwfaCU9kXu6RJsRYwg0hdg9zmGkwfN9CC7ymtG7XmByLcE+DLOlBm6Qncq3p99NAoiyF7h6IOyLVzACPbmH5k8Q/LghrMNhy+aPKneZBgPNRxfvFA+YRaYoMDc8yuLJ5VoG0uNbwblrVdPAg+pQKVz9ZnUvWIGgCx6SMhD5gY13tMkrcSLsONjH7rDwsoWVDVU4ueLZGRWxraEzJzFRXX2Ye+d+jQYMnnrXcThC4pyorVKEG8gsnp1bu/hPVj/FvHNcU6HOk12OsvenMmjuVAbQrMV7+MZ/Yque84HFQJERYU0xkrZ72s1BITY12AJEk6nNPrgim7Qamo8Vl8xzQGTXtDrKyh3gAwbPloMBw1S5RuRP9K+VT4GTV1kQb7Aw83AhhLW+3XUc7bmqojMoNMV/dOVPny6dDZwyQL6WTb+CyrBaf226h+MCKMcgYZ8qNqxh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a775e90f-5b8a-43d4-30e4-08d78262308a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 19:57:32.6359 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7bEhRZVDUpXwJOvuX1uKWq4A1Btk9IzXpwd5cSmpJsIFt9VPeqhZrlGDbfFv7A7DpiJK+kekXnPoLY0uQ/d9Geb/VoDf0Nck6yRgGjcyOHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3376
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-16_07:2019-12-16,2019-12-16 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>, "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "liran.alon@oracle.com" <liran.alon@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
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

SGV5YSwNCg0KPiBPbiAxNiBEZWMgMjAxOSwgYXQgMjA6NDcsIEVsZW5hIFVmaW10c2V2YSA8ZWxl
bmEudWZpbXRzZXZhQG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4g77u/T24gRnJpLCBEZWMgMTMs
IDIwMTkgYXQgMTA6NDE6MTZBTSArMDAwMCwgU3RlZmFuIEhham5vY3ppIHdyb3RlOg0KPj4+IE9u
IE1vbiwgRGVjIDA5LCAyMDE5IGF0IDEwOjQ3OjE3UE0gLTA4MDAsIEVsZW5hIFVmaW10c2V2YSB3
cm90ZToNCj4+PiBBdCB0aGlzIG1vbWVudCB3ZSBhcmUgd29ya2luZyBvbiB0aGUgZmlyc3Qgc3Rh
Z2Ugb2YgdGhlIHByb2plY3Qgd2l0aCBoZWxwIG9mDQo+Pj4gdGhlIE51dGFuaXggZGV2ZWxvcGVy
cy4NCj4+PiBUaGUgcXVlc3Rpb25zIHdlIGhhdmUgZ2F0aGVyZWQgc28gZmFyIHdpbGwgYmUgYWRk
cmVzc2VkIHdpdGggbXVzZXINCj4+PiBhbmQgUWVtdSBkZXZlbG9wZXJzIGFmdGVyIHdlIGZpbmlz
aCB0aGUgZmlyc3Qgc3RhZ2UgYW5kIG1ha2Ugc3VyZSB3ZSB1bmRlcnN0YW5kDQo+Pj4gd2hhdCBp
dCB3aWxsIHRha2UgZm9yIHVzIHRvIG1vdmUgb250byB0aGUgbmV4dCBzdGFnZS4NCj4+PiANCj4+
PiBXZSB3aWxsIGFsc28gaW5jb3Jwb3JhdGUgcmVsZXZhbnQgcmV2aWV3IGZyb20gU3RlZmFuIHRo
YXQgaGUgcHJvdmlkZWQNCj4+PiBvbiB0aGUgc2VyaWVzIDQgb2YgdGhlIHBhdGNoc2V0LiBUaGFu
ayB5b3UgU3RlZmFuLg0KPj4+IA0KPj4+IElmIGFueW9uZSBoYXZlIGFueSBmdXJ0aGVyIHN1Z2dl
c3Rpb25zIG9yIHF1ZXN0aW9ucyBhYm91dCB0aGUgc3RhdHVzLA0KPj4+IHBsZWFzZSByZXBseSB0
byB0aGlzIGVtYWlsLg0KPj4gDQo+PiBIaSBFbGVuYSwNCj4+IEF0IEtWTSBGb3J1bSB3ZSBkaXNj
dXNzZWQgc3BlbmRpbmcgMSBvciAyIHdlZWtzIHRyeWluZyBvdXQgbXVzZXIuICBBIGZldw0KPj4g
d2Vla3MgaGF2ZSBwYXNzZWQgYW5kIGZyb20geW91ciBlbWFpbCBpdCBzb3VuZHMgbGlrZSB0aGlz
ICJuZXh0IHN0YWdlIg0KPj4gbWlnaHQgYmUgYSBsb3Qgb2Ygd29yay4NCj4+IA0KPiANCj4gSGkg
U3RlZmFuDQo+IA0KPiBQZXJoYXBzIHdlIHdlcmUgbm90IHRvbyBjbGVhciBhYm91dCBvdXIgd29y
ayBpbiB0aGUgcHJldmlvdXMgZW1haWwuDQo+IE91ciBhc3N1bXB0aW9uIHdhcyB0aGF0IHRoZSBx
dWVzdGlvbiB0aGF0IGNhbWUgZnJvbSBLVk0gRm9ydW0gd2FzDQo+IGlmIG11c2VyIGNhbiBiZSB1
c2VkIHRvIGFjaGlldmUgdGhlIHNhbWUgd2hhdCB3ZSBoYXZlIG5vdy4NCj4gV2Ugc2hvdWxkIGhh
dmUgYW5zd2VyZWQgY2xlYXJseSB5ZXMgdG8gdGhpcyBxdWVzdGlvbi4gIFdlIGhhdmUgbm90IHll
dA0KPiBkaXNjb3ZlcmVkIG1ham9yIHJvYWQgYmxvY2tzLg0KPiBBdCB0aGUgbW9tZW50LCB3ZSBh
cmUgbW9zdGx5IGVuZ2FnZWQgaW4gbGVhcm5pbmcgdGhlIGNvZGUgYW5kIGRpc2N1c3NpbmcNCj4g
dGhlIGRlc2lnbiwgcGx1cyBzb21lIGNvZGluZyB0byBhbnN3ZXIgdGhlIHNwZWNpZmljIHF1ZXN0
aW9ucy4NCj4gV2UgdW5kZXJzdGFuZCB0aGF0IHRoZSBiZXN0IHdheSB0byBtYWtlIGEgcHJvZ3Jl
c3MgaXMgdG8gd29yayB3aXRoIHRoZQ0KPiB1cHN0cmVhbSBjb21tdW5pdHkgb24gZWFybHkgc3Rh
Z2VzIGFuZCB3ZSBhZ3JlZSB3aXRoIHRoaXMgYW5kIHdpbGwgcHJlc2VudA0KPiB0aGUgcHJvcG9z
YWwgc2hvcnRseSBmb3IgZGlzY3Vzc2lvbi4NCj4gDQo+PiBJcyB0aGVyZSBhIHdvcmstaW4tcHJv
Z3Jlc3MgbXVzZXIgcGF0Y2ggc2VyaWVzIHlvdSBjYW4gcG9zdCB0byBzdGFydCB0aGUNCj4+IGRp
c2N1c3Npb24gZWFybHk/ICBUaGF0IHdheSB3ZSBjYW4gYXZvaWQgcmV2aWV3ZXJzIGxpa2UgbXlz
ZWxmIGFza2luZw0KPj4geW91IHRvIG1ha2UgY2hhbmdlcyBhZnRlciB5b3UgaGF2ZSBpbnZlc3Rl
ZCBhIGxvdCBvZiB0aW1lLg0KPj4gDQo+IA0KPiBBYnNvbHV0ZWx5LCB0aGF0IGlzIG91ciBwbGFu
LiBBdCB0aGUgbW9tZW50IHdlIGRvIG5vdCBoYXZlIHRoZSBwYXRjaGVzDQo+IHJlYWR5IGZvciB0
aGUgcmV2aWV3LiBXZSBoYXZlIHNldHVwIGludGVybmFsbHkgYSBtaWxlc3RvbmUgYW5kIHdpbGwg
YmUNCj4gc2VuZGluZyB0aGF0IGVhcmx5IHZlcnNpb24gYXMgYSB0YXJiYWxsIGFmdGVyIHdlIGhh
dmUgaXQgY29tcGxldGVkLg0KPiBXb3VsZCBiZSBhbHNvIGEgbWVldGluZyBzb21ldGhpbmcgdGhh
dCBjb3VsZCBoZWxwIHVzIHRvIHN0YXkgb24gdGhlIHNhbWUNCj4gcGFnZT8NCg0KUGxlYXNlIGxv
b3AgdXMgaW4gaWYgeW91IHNvIHNldCB1cCBhIG1lZXRpbmcuDQoNCj4gDQo+PiBJdCdzIGdvb2Qg
dGhhdCB5b3UgYXJlIGluIHRvdWNoIHdpdGggdGhlIG11c2VyIGRldmVsb3BlcnMgKHZpYSBwcml2
YXRlDQo+PiBkaXNjdXNzaW9uPyAgSSBoYXZlbid0IHNlZW4gbXVjaCBhY3Rpdml0eSBvbiAjbXVz
ZXIgSVJDKS4NCj4+IA0KPiANCj4gV2UgdXNlIElSQyAoSSBrbm93IEphZyBnb3Qgc29tZSBhbnN3
ZXJzIHRoZXJlKSBhbmQgZ2l0aHViIGZvciBpc3N1ZXMNCj4gKG9uZSBvZiB3aGljaCB3YXMgYWRk
cmVzc2VkKS4NCg0KSSB0aG91Z2h0IHRoZXJlIHdhcyBvbmx5IHRoZSBvbmUuIExldCB1cyBrbm93
IGlmIHlvdSBydW4gaW50byBhbnkgb3RoZXIgYnVncy4gV2UgYXJlIGxvb2tpbmcgZm9yd2FyZCB0
byBoZWFyaW5nIGFib3V0IHBlb3BsZeKAmXMgZXhwZXJpZW5jZSBhbmQgYWRkcmVzc2luZyBpc3N1
ZXMgdGhhdCBjb21lIHdpdGggdXNlcyB3ZSBkaWRu4oCZdCBmb3Jlc2VlIG9yIHRlc3QuDQoNCkNo
ZWVycywNCkZlbGlwZQ0KDQo+IFdlIGFyZSBob3BpbmcgdG8gZ2V0IHRoZSBjb252ZXJzYXRpb24g
Z29pbmcgb3Zlcg0KPiB0aGUgZW1haWwuDQo+IA0KPiBKSiwgSmFnIGFuZCBFbGVuYSANCj4+IFN0
ZWZhbg0KPiANCj4gDQo=

