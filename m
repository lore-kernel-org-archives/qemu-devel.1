Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213ADC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 21:30:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA71521D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 21:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="DP0g7ekS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA71521D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuk3R-0006RA-Vj
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 16:30:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iuk2V-00059C-4x
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 16:29:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iuk2T-0000t8-Sa
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 16:29:23 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:26472)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>)
 id 1iuk2O-0000pe-53; Thu, 23 Jan 2020 16:29:16 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00NLSiLd010967; Thu, 23 Jan 2020 13:29:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=OfsJ6rELW0G6HeD9kEOlHZEFQPDvI0rH8FjS/EZ3ki8=;
 b=DP0g7ekST1LlQwquTiHu8QqcL9xSPOVDsU6LgGQU5CsGgMNjeWJWyt1hkb7wv71hB0QM
 WN2CKOc0rf/ShWrzlGueXKDby3tmkdj5A/jj7oaJ2HGxQaAeiU20lOKLOxkaWVBJPiwl
 eVtmgZbS8dAi4tkWnBRz16hwTv8xkDg85ImSRpt77Jj8tHGI1Y1JZS4ciwUnyi2nxM6x
 xUP8+3atHNFk7GA1c5y9tMQw7ckLqAPtYAndi/QlQck1tDiq3sDyqjKH9VCKty92LWDg
 CGdHbg5cIIypopsjfTzW+q1mSdDizzDrS5Y/TY8F1DOuVkoZqFdzpDTw6Uo5cqszLo0A 1g== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2xm27n3pw8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jan 2020 13:29:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+QZ/vyK2uh4HFANhn53OASnlo3aKwof2pEr0g6zo890jsQKgLx/93PuHBDVogN65AILq64Nn5eF83D9KVcN7rdG0mmWS/74+vVfp68h7a5A+Qu1xBwIGFDphhwj5ur1nTihCiQblR0t1YyWLM1ddNZ3ezpZFTbODqhsauWTVaEHZEj7+ElUYVymaD28RgZaKnr5ilxbABc9y18JVy4LyJ3dL/KQhoiNHnoVZaW+V10i/3HRlGrflLM18r5PTTIrolDyadIZMth0P3HLK8vM4McBHvGdcR1f/GCrBJcq+VLPn/f5iwYhZ75qq6BamqzArH7LFHoPJntk+rBD9/mjNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfsJ6rELW0G6HeD9kEOlHZEFQPDvI0rH8FjS/EZ3ki8=;
 b=h/p5Lkl9OjorsszNIgXAoT3DRt7zdyy58+txKECYbCSGNAx6nv+IMG95brs5yCjHEJ2jAJkJMmB5nVmWtxgtPdjqjnG0TUDm0r+wBHg9Ds+6/bTmcIAsT3lgVYXDBFP+j5s4NHCLW/J7hvW+Bxa8DCMuypcgJJ//EA3PIsrllv5hO41T4twfolYuY1Ivdldde22MRf5+s7yB/koMX1AurPssVJGZ/I0zJSELyE9BqLQ4JtU71185HMNsOOh67/PNFZybJQ32GfyAL9W7es1qanwUDGNF51eaTUcb9X/ohP5UwaonntA47EE3yKyHfxff9SVz1IXRsXCpboIEstHNdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2608.namprd02.prod.outlook.com (10.168.205.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 23 Jan 2020 21:29:05 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029%10]) with mapi id 15.20.2644.028; Thu, 23 Jan
 2020 21:29:05 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH] iscsi: Cap block count from GET LBA STATUS (CVE-2020-1711)
Thread-Topic: [PATCH] iscsi: Cap block count from GET LBA STATUS
 (CVE-2020-1711)
Thread-Index: AQHV0ersGiQprkLuikaxEpLUh3Oweaf4hjqAgAA+NQA=
Date: Thu, 23 Jan 2020 21:29:05 +0000
Message-ID: <B07CB62A-7860-4385-A6A4-4ECA211DBE42@nutanix.com>
References: <20200123124357.124019-1-felipe@nutanix.com>
 <3cb32404-e8ee-ba8c-3684-bfa6d0827d39@redhat.com>
In-Reply-To: <3cb32404-e8ee-ba8c-3684-bfa6d0827d39@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.9.225.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d6ce09a-2081-4cec-026e-08d7a04b4635
x-ms-traffictypediagnostic: MWHPR02MB2608:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB26089F4A5477B055E155EA55D70F0@MWHPR02MB2608.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(39860400002)(376002)(136003)(396003)(199004)(189003)(71200400001)(36756003)(6512007)(6486002)(7416002)(86362001)(8936002)(81156014)(81166006)(33656002)(8676002)(478600001)(6916009)(2906002)(66946007)(76116006)(2616005)(91956017)(5660300002)(66556008)(26005)(6506007)(53546011)(66446008)(64756008)(66476007)(186003)(4326008)(316002)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2608;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t84kaYtegifCZkq3PhJV4EaLxWxjuDmUY0wIQwhSwcG6fELK/SnZAaW0/Dzk3KLNXjYSaBqv2Um3723968CmQnRlQiuh0VvUW4LOYtMuPoXwgewqObErq2PnemLgvcxGz4W2VHZfxI1PdVTfbMc7HptNivAmuEJMp6HmaRgTrZYLmYzQLehkf1hJXo6EAwDp4C1ctZTGyMxMRSu/36sS8/dM9dmgmtYRTcaqLEqet49XM9nJcMPjDM1bctwGjpBBviIyFmFlXW4nyrpt6LxzvWgbweiBR94yN1Kaw4Xa280ZWjrcjtauYklNpxdZqscI9+8RwBVmMPWACfO6j1FCtMDcST7X+OlAYI8BvMfChFtBLbpi1Naf2JNsrSj6YuOmjL402stWSJZ4pwvh1kQFyb/3Tn4Z0KGokLLIczaJe4MViU5E2sWWw0UomfAUmES1
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A4FA6A0B418E3409E952D5615C55AF8@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6ce09a-2081-4cec-026e-08d7a04b4635
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 21:29:05.4036 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ekux7EeatFBLGSpvIrbhhtWb7l2dsQ0krjSUOFKN+/eUojrqhhPZN48jO7gqI6qCmWChKXnUgXh3w632v+y2WGy/sdOx7VnNiwxtkfrXO0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2608
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-23_13:2020-01-23,
 2020-01-23 signatures=0
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Turschmid <peter.turschm@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Peter Lieven <pl@kamp.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, P J P <ppandit@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGksDQoNCj4gT24gSmFuIDIzLCAyMDIwLCBhdCA1OjQ2IFBNLCBQaGlsaXBwZSBNYXRoaWV1LURh
dWTDqSA8cGhpbG1kQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gMS8yMy8yMCAxOjQ0IFBN
LCBGZWxpcGUgRnJhbmNpb3NpIHdyb3RlOg0KPj4gV2hlbiBxdWVyeWluZyBhbiBpU0NTSSBzZXJ2
ZXIgZm9yIHRoZSBwcm92aXNpb25pbmcgc3RhdHVzIG9mIGJsb2NrcyAodmlhDQo+PiBHRVQgTEJB
IFNUQVRVUyksIFFlbXUgb25seSB2YWxpZGF0ZXMgdGhhdCB0aGUgcmVzcG9uc2UgZGVzY3JpcHRv
ciB6ZXJvJ3MNCj4+IExCQSBtYXRjaGVzIHRoZSBvbmUgcmVxdWVzdGVkLiBHaXZlbiB0aGUgU0NT
SSBzcGVjIGFsbG93cyBzZXJ2ZXJzIHRvDQo+PiByZXNwb25kIHdpdGggdGhlIHN0YXR1cyBvZiBi
bG9ja3MgYmV5b25kIHRoZSBlbmQgb2YgdGhlIExVTiwgUWVtdSBtYXkNCj4+IGhhdmUgaXRzIGhl
YXAgY29ycnVwdGVkIGJ5IGNsZWFyaW5nL3NldHRpbmcgdG9vIG1hbnkgYml0cyBhdCB0aGUgZW5k
IG9mDQo+PiBpdHMgYWxsb2NtYXAgZm9yIHRoZSBMVU4uDQo+PiBBIG1hbGljaW91cyBndWVzdCBp
biBjb250cm9sIG9mIHRoZSBpU0NTSSBzZXJ2ZXIgY291bGQgY2FyZWZ1bGx5IHByb2dyYW0NCj4+
IFFlbXUncyBoZWFwIChieSBzZWxlY3RpdmVseSBzZXR0aW5nIHRoZSBiaXRtYXApIGFuZCB0aGVu
IHNtYXNoIGl0Lg0KPj4gVGhpcyBsaW1pdHMgdGhlIG51bWJlciBvZiBiaXRzIHRoYXQgaXNjc2lf
Y29fYmxvY2tfc3RhdHVzKCkgd2lsbCB0cnkgdG8NCj4+IHVwZGF0ZSBpbiB0aGUgYWxsb2NtYXAg
c28gaXQgY2FuJ3Qgb3ZlcmZsb3cgdGhlIGJpdG1hcC4NCj4gDQo+IFBsZWFzZSBhZGQ6DQo+IA0K
PiBGaXhlczogQ1ZFLTIwMjAtMTcxMSAodGl0bGUgb2YgQ1ZFIGlmIHBvc3NpYmxlKQ0KDQpJIHdh
c24ndCBzdXJlIHdlIGhhZCBvbmUgeWV0LiBLZXZpbjogY2FuIHlvdSBkbyB0aGUgbmVlZGZ1bCBp
biB5b3VyIGJyYW5jaD8NCg0KPiBDYzogcWVtdS1zdGFibGVAbm9uZ251Lm9yZw0KDQpZZWFoLCB0
aGF0J3MgdGhlcmUuDQoNCj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBGZWxpcGUgRnJhbmNpb3NpIDxm
ZWxpcGVAbnV0YW5peC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBUdXJzY2htaWQgPHBl
dGVyLnR1cnNjaG1AbnV0YW5peC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBSYXBoYWVsIE5vcndp
dHogPHJhcGhhZWwubm9yd2l0ekBudXRhbml4LmNvbT4NCj4+IC0tLQ0KPj4gIGJsb2NrL2lzY3Np
LmMgfCA1ICsrKy0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4+IGRpZmYgLS1naXQgYS9ibG9jay9pc2NzaS5jIGIvYmxvY2svaXNjc2kuYw0K
Pj4gaW5kZXggMmFlYTdlM2YxMy4uY2JkNTcyOTRhYiAxMDA2NDQNCj4+IC0tLSBhL2Jsb2NrL2lz
Y3NpLmMNCj4+ICsrKyBiL2Jsb2NrL2lzY3NpLmMNCj4+IEBAIC03MDEsNyArNzAxLDcgQEAgc3Rh
dGljIGludCBjb3JvdXRpbmVfZm4gaXNjc2lfY29fYmxvY2tfc3RhdHVzKEJsb2NrRHJpdmVyU3Rh
dGUgKmJzLA0KPj4gICAgICBzdHJ1Y3Qgc2NzaV9nZXRfbGJhX3N0YXR1cyAqbGJhcyA9IE5VTEw7
DQo+PiAgICAgIHN0cnVjdCBzY3NpX2xiYV9zdGF0dXNfZGVzY3JpcHRvciAqbGJhc2QgPSBOVUxM
Ow0KPj4gICAgICBzdHJ1Y3QgSXNjc2lUYXNrIGlUYXNrOw0KPj4gLSAgICB1aW50NjRfdCBsYmE7
DQo+PiArICAgIHVpbnQ2NF90IGxiYSwgbWF4X2J5dGVzOw0KPj4gICAgICBpbnQgcmV0Ow0KPj4g
ICAgICAgIGlzY3NpX2NvX2luaXRfaXNjc2l0YXNrKGlzY3NpbHVuLCAmaVRhc2spOw0KPj4gQEAg
LTcyMSw2ICs3MjEsNyBAQCBzdGF0aWMgaW50IGNvcm91dGluZV9mbiBpc2NzaV9jb19ibG9ja19z
dGF0dXMoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+PiAgICAgIH0NCj4+ICAgICAgICBsYmEgPSBv
ZmZzZXQgLyBpc2NzaWx1bi0+YmxvY2tfc2l6ZTsNCj4+ICsgICAgbWF4X2J5dGVzID0gKGlzY3Np
bHVuLT5udW1fYmxvY2tzIC0gbGJhKSAqIGlzY3NpbHVuLT5ibG9ja19zaXplOw0KPj4gICAgICAg
IHFlbXVfbXV0ZXhfbG9jaygmaXNjc2lsdW4tPm11dGV4KTsNCj4+ICByZXRyeToNCj4+IEBAIC03
NjQsNyArNzY1LDcgQEAgcmV0cnk6DQo+PiAgICAgICAgICBnb3RvIG91dF91bmxvY2s7DQo+PiAg
ICAgIH0NCj4+ICAtICAgICpwbnVtID0gKGludDY0X3QpIGxiYXNkLT5udW1fYmxvY2tzICogaXNj
c2lsdW4tPmJsb2NrX3NpemU7DQo+PiArICAgICpwbnVtID0gTUlOKChpbnQ2NF90KSBsYmFzZC0+
bnVtX2Jsb2NrcyAqIGlzY3NpbHVuLT5ibG9ja19zaXplLCBtYXhfYnl0ZXMpOw0KPj4gICAgICAg
IGlmIChsYmFzZC0+cHJvdmlzaW9uaW5nID09IFNDU0lfUFJPVklTSU9OSU5HX1RZUEVfREVBTExP
Q0FURUQgfHwNCj4+ICAgICAgICAgIGxiYXNkLT5wcm92aXNpb25pbmcgPT0gU0NTSV9QUk9WSVNJ
T05JTkdfVFlQRV9BTkNIT1JFRCkgew0KPiANCj4gV2hhdCBhYm91dCB0aGlzPw0KPiANCj4gLS0g
PjggLS0NCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2lzY3NpLmMgYi9ibG9jay9pc2NzaS5jDQo+IGlu
ZGV4IDJhZWE3ZTNmMTMuLjI1NTk4YWNjYmIgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL2lzY3NpLmMN
Cj4gKysrIGIvYmxvY2svaXNjc2kuYw0KPiBAQCAtNTA2LDYgKzUwNiwxMSBAQCBpc2NzaV9hbGxv
Y21hcF91cGRhdGUoSXNjc2lMdW4gKmlzY3NpbHVuLCBpbnQ2NF90IG9mZnNldCwNCj4gICAgIC8q
IHNocmluayB0byB0b3VjaCBvbmx5IGNvbXBsZXRlbHkgY29udGFpbmVkIGNsdXN0ZXJzICovDQo+
ICAgICBjbF9udW1fc2hydW5rID0gRElWX1JPVU5EX1VQKG9mZnNldCwgaXNjc2lsdW4tPmNsdXN0
ZXJfc2l6ZSk7DQo+ICAgICBuYl9jbHNfc2hydW5rID0gKG9mZnNldCArIGJ5dGVzKSAvIGlzY3Np
bHVuLT5jbHVzdGVyX3NpemUgLSBjbF9udW1fc2hydW5rOw0KPiArICAgIGlmIChuYl9jbHNfZXhw
YW5kZWQgPj0gaXNjc2lsdW4tPmFsbG9jbWFwX3NpemUNCj4gKyAgICAgICAgfHwgbmJfY2xzX3No
cnVuayA+PSBpc2NzaWx1bi0+YWxsb2NtYXBfc2l6ZSkgew0KPiArICAgICAgICBlcnJvcl9yZXBv
cnQoImlTQ1NJIGludmFsaWQgcmVxdWVzdDogLi4uIiAvKiBUT0RPICovKTsNCj4gKyAgICAgICAg
cmV0dXJuOw0KPiArICAgIH0NCj4gICAgIGlmIChhbGxvY2F0ZWQpIHsNCj4gICAgICAgICBiaXRt
YXBfc2V0KGlzY3NpbHVuLT5hbGxvY21hcCwgY2xfbnVtX2V4cGFuZGVkLCBuYl9jbHNfZXhwYW5k
ZWQpOw0KPiAgICAgfSBlbHNlIHsNCj4gLS0tDQoNCkknbSBub3Qgc3VyZSB0aGUgYWJvdmUgaXMg
Y29ycmVjdCBiZWNhdXNlIChpZiBJIHJlYWQgdGhpcyByaWdodCkNCm5iX2Nsc18qIHJlcHJlc2Vu
dHMgdGhlIG51bWJlciBvZiBjbHVzdGVycywgbm90IHRoZSBsYXN0IGNsdXN0ZXIuDQoNClBlcnNv
bmFsbHksIEkgd291bGQgaGF2ZSB0aGUgY2hlY2tzIChvciAidHJpbSJzKSBjbG9zZXIgdG8gd2hl
cmUgdGhleQ0Kd2VyZSBpc3N1ZWQgKHRvIGZhaWwgc29vbmVyKSBhbmQgYXNzZXJ0KClzIGNsb3Nl
ciB0byBiaXRtYXAgKGFzIG5vIG9vYg0KYWNjZXNzZXMgc2hvdWxkIGJlIGhhcHBlbmluZyBhdCB0
aGlzIHBvaW50KS4gVGhlcmUgd2VyZSBhbHNvDQpkaXNjdXNzaW9ucyBhYm91dCB1c2luZyBzYWZl
ciAoaGlnaGVyIGxldmVsKSBiaXRtYXBzIGZvciB0aGlzLiBJJ20NCmFsd2F5cyBpbiBmYXZvdXIg
b2YgYWRkaW5nIGFsbCByZWFzb25hYmxlIGNoZWNrcy4gOikNCg0KQ2hlZXJzLA0KRmVsaXBl

