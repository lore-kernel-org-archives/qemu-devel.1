Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE81C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 167AE206C2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WqnX/vTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167AE206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHlUi-0001rL-Tl
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 05:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHlQi-0006AO-HF
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:05:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHlQg-0002S0-8p
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:05:16 -0400
Received: from mail-ve1eur02on0728.outbound.protection.outlook.com
 ([2a01:111:f400:fe06::728]:59027
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iHlQe-0002Gj-Tp; Tue, 08 Oct 2019 05:05:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtrlOhAdwXTZU/5Qy5wJSaRxWV5jU7F2QAzRgsjg9JfYbC57dRu58DqXaaTI3oVnCXfSjsg5gNfC/Eq0pBB0UnHUIvPxc28AGm8JHKnt6twdQlHPefxnFI4O5k1CJleHd7gyTzKXuW1JNgwjca7Kckz8t8QOpaR+Y7i2sG7RSeLfWcNAQi7Y7DiP3ba6hMYu48pEQ3+92qK0jb98XwQr8IIF1BWor864UBhFNpmtql5JFcNf1x/heEY80GU30zmuuyhZdP0sY7BKDNjkutoXrqVNX+bSBNHYVDT9kQXv0fYjRO4BKYVrXiM9BVSVs1yyduBJdBh+SPocPW6zUafUug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P24jhUD3Hw9E+e90cepoqOULGspHBqlSc26uMH3/gx4=;
 b=cIcArtQc7AUyM64zpuRWuxqQZTeRRnz8bMmxKuBKMHjTAm3pAlLqYQLQXUTmHeH8NfbKK4zE9G66lbHxC30ZDgBkpgms3P5Nj2keeQp9ymZ6IpVTlfAEbQRWM/G4VoKzodRyDQKBe3meuo/0pvbRVq0hD1HqSVZxxi3iZ8hnFLU/m69c81olecVH6FIWib9jEBwxcCPOwMn3b72Pem0+Xpy/008cE4ShE4ho4mTz0plBMo0qIat0n80rYPT7Y799ZN96vj6PCazFnvheiT8UbdcXS9eBWGjxsW76M7PYUAxYTPSxQ6tOtdClUTGf9OMQnvcrPc8WWw0+hISY8rAZjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P24jhUD3Hw9E+e90cepoqOULGspHBqlSc26uMH3/gx4=;
 b=WqnX/vTBh77xn2zZn6p9yJZOY2PE+0fNbbyEqOuG4egnKk/VL/FvtBGU0Htihh/I+9e5aGd/6EG7wc3ipuR5PqVcnJTRcHP5wirytljmnZ6Hh7tiJyMvw8UZ3Mm9s23bcy+swZe/8ucxawRorPtm+zoAEX05+Cr/spPflLFjtEs=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4010.eurprd08.prod.outlook.com (20.179.10.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Tue, 8 Oct 2019 09:05:05 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2327.023; Tue, 8 Oct 2019
 09:05:05 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v7 1/2] docs: improve qcow2 spec about extending image
 header
Thread-Topic: [PATCH v7 1/2] docs: improve qcow2 spec about extending image
 header
Thread-Index: AQHVfSj4NZxneckXjESRnSlwVfPCUadPn1aAgADVRwA=
Date: Tue, 8 Oct 2019 09:05:04 +0000
Message-ID: <90102485-ccbb-018c-c90d-b85a7b2f0392@virtuozzo.com>
References: <20191007160451.27334-1-vsementsov@virtuozzo.com>
 <20191007160451.27334-2-vsementsov@virtuozzo.com>
 <7afa803e-3efd-1186-2b37-7056d9a983f0@redhat.com>
In-Reply-To: <7afa803e-3efd-1186-2b37-7056d9a983f0@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0269.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::21) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191008120502281
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0d90db8-97ce-472e-8fbf-08d74bce9bfd
x-ms-traffictypediagnostic: DB8PR08MB4010:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB401074432DB5565AF485A474C19A0@DB8PR08MB4010.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(39850400004)(366004)(136003)(396003)(189003)(199004)(6486002)(6246003)(76176011)(305945005)(102836004)(36756003)(86362001)(6436002)(14454004)(6512007)(53546011)(229853002)(7736002)(52116002)(478600001)(4326008)(386003)(6506007)(71190400001)(71200400001)(256004)(99286004)(54906003)(5660300002)(66066001)(316002)(26005)(476003)(11346002)(66556008)(446003)(66946007)(66476007)(107886003)(64756008)(25786009)(3846002)(31686004)(66446008)(2616005)(2501003)(110136005)(6116002)(8676002)(186003)(2906002)(81166006)(81156014)(8936002)(31696002)(486006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4010;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UOPAu4OGdSzPG7lIy0EpH/XdcPA9d3RJwWeU8Re3R45ZSMeEzqZyKyi5cZRnEpF39C96xdI7uDGr884Tcto8PsaaLAxwXrTwZiPL4Prxxe3lgza7Q5ftr0NunWNHwmPA5Rl0GcRdpoLXApxDtYWdXIyvSZJVi9OMj3984E22p1ZJhaGk1Q6Ar3OBGSzwBeF6Ps1VHSIk60Yej7Dqnro8dCCts0fp2kIs5vJeQOwWGEXbf7TvF1qp4t3em2WPyBSdy2jnABAMkzn+KxwiYIKXAEZyevcSXuh3lT2cFXIXdcqKi7ef+vErqCV0g2eAEZffTTozCIN5719GG+gfNWMC4iZgZEAeK0eiLc5trM56oh8qDy+y/An0P553K2ZXZPvZotH1UwmoA6D3VVRibsagqYZG+yAaT6MJmNgnshl1CiM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36DB77E380C6F64F9B7F3C57C11F3707@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d90db8-97ce-472e-8fbf-08d74bce9bfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 09:05:04.9767 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xcYsthvnMbnpouZs6MEvwPUiyY40/N0wGXv3OTFcnrJIcOTT+La/WOImppMRas1QXZVz1kjuAgT0c5Hcea4ESord0Kv+/N62z+hdTSja9ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4010
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe06::728
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDcuMTAuMjAxOSAyMzoyMSwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMTAvNy8xOSAxMTowNCBB
TSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IE1ha2UgaXQgbW9yZSBv
YnZpb3VzIGhvdyB0byBhZGQgbmV3IGZpZWxkcyB0byB0aGUgdmVyc2lvbiAzIGhlYWRlciBhbmQN
Cj4+IGhvdyB0byBpbnRlcnByZXQgdGhlbS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1p
ciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+PiAtLS0N
Cj4+IMKgIGRvY3MvaW50ZXJvcC9xY293Mi50eHQgfCAyNiArKysrKysrKysrKysrKysrKysrKysr
Ky0tLQ0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RvY3MvaW50ZXJvcC9xY293Mi50eHQgYi9kb2NzL2lu
dGVyb3AvcWNvdzIudHh0DQo+PiBpbmRleCBhZjU3MTFlNTMzLi4zZjI4NTU1OTNmIDEwMDY0NA0K
Pj4gLS0tIGEvZG9jcy9pbnRlcm9wL3Fjb3cyLnR4dA0KPj4gKysrIGIvZG9jcy9pbnRlcm9wL3Fj
b3cyLnR4dA0KPj4gQEAgLTc5LDkgKzc5LDkgQEAgVGhlIGZpcnN0IGNsdXN0ZXIgb2YgYSBxY293
MiBpbWFnZSBjb250YWlucyB0aGUgZmlsZSBoZWFkZXI6DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgT2Zmc2V0IGludG8gdGhlIGltYWdlIGZpbGUgYXQgd2hp
Y2ggdGhlIHNuYXBzaG90IHRhYmxlDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgc3RhcnRzLiBNdXN0IGJlIGFsaWduZWQgdG8gYSBjbHVzdGVyIGJvdW5kYXJ5
Lg0KPj4gLUlmIHRoZSB2ZXJzaW9uIGlzIDMgb3IgaGlnaGVyLCB0aGUgaGVhZGVyIGhhcyB0aGUg
Zm9sbG93aW5nIGFkZGl0aW9uYWwgZmllbGRzLg0KPj4gLUZvciB2ZXJzaW9uIDIsIHRoZSB2YWx1
ZXMgYXJlIGFzc3VtZWQgdG8gYmUgemVybywgdW5sZXNzIHNwZWNpZmllZCBvdGhlcndpc2UNCj4+
IC1pbiB0aGUgZGVzY3JpcHRpb24gb2YgYSBmaWVsZC4NCj4+ICtGb3IgdmVyc2lvbiAyLCBoZWFk
ZXIgaXMgYWx3YXlzIDcyIGJ5dGVzIGxlbmd0aCBhbmQgZmluaXNoZXMgaGVyZS4NCj4+ICtGb3Ig
dmVyc2lvbiAzIG9yIGhpZ2hlciB0aGUgaGVhZGVyIGxlbmd0aCBpcyBhdCBsZWFzdCAxMDQgYnl0
ZXMgYW5kIGhhcyBhdA0KPj4gK2xlYXN0IG5leHQgZml2ZSBmaWVsZHMsIHVwIHRvIHRoZSBAaGVh
ZGVyX2xlbmd0aCBmaWVsZC4NCj4gDQo+IFRoaXMgaHVuayBzZWVtcyBva2F5Lg0KPiANCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDcyIC3CoCA3OTrCoCBpbmNvbXBhdGlibGVfZmVhdHVyZXMNCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCaXRtYXNrIG9mIGlu
Y29tcGF0aWJsZSBmZWF0dXJlcy4gQW4gaW1wbGVtZW50YXRpb24gbXVzdA0KPj4gQEAgLTE2NSw2
ICsxNjUsMjYgQEAgaW4gdGhlIGRlc2NyaXB0aW9uIG9mIGEgZmllbGQuDQo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTGVuZ3RoIG9mIHRoZSBoZWFkZXIgc3Ry
dWN0dXJlIGluIGJ5dGVzLiBGb3IgdmVyc2lvbiAyDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaW1hZ2VzLCB0aGUgbGVuZ3RoIGlzIGFsd2F5cyBhc3N1bWVk
IHRvIGJlIDcyIGJ5dGVzLg0KPj4gK0FkZGl0aW9uYWwgZmllbGRzICh2ZXJzaW9uIDMgYW5kIGhp
Z2hlcikNCj4+ICsNCj4+ICtUaGUgZm9sbG93aW5nIGZpZWxkcyBvZiB0aGUgaGVhZGVyIGFyZSBv
cHRpb25hbDogaWYgc29mdHdhcmUgZG9uJ3Qga25vdyBob3cgdG8NCj4+ICtpbnRlcnByZXQgdGhl
IGZpZWxkLCBpdCBtYXkgc2FmZWx5IGlnbm9yZSBpdC4gU3RpbGwgdGhlIGZpZWxkIG11c3QgYmUg
a2VwdCBhcyBpcw0KPj4gK3doZW4gcmV3cml0aW5nIHRoZSBpbWFnZS4NCj4gDQo+IGlmIHNvZnR3
YXJlIGRvZXNuJ3Qga25vdyBob3cgdG8gaW50ZXJwcmV0IHRoZSBmaWVsZCwgaXQgbWF5IGJlIHNh
ZmVseSBpZ25vcmVkLCBvdGhlciB0aGFuIHByZXNlcnZpbmcgdGhlIGZpZWxkIHVuY2hhbmdlZCB3
aGVuIHJld3JpdGluZyB0aGUgaW1hZ2UgaGVhZGVyLg0KPiANCj4gTWlzc2luZzoNCj4gDQo+IElm
IGhlYWRlcl9sZW5ndGggZXhjbHVkZXMgYW4gb3B0aW9uYWwgZmllbGQsIHRoZSB2YWx1ZSBvZiAw
IHNob3VsZCBiZSB1c2VkIGZvciB0aGF0IGZpZWxkLg0KDQpUaGlzIGlzIHdoYXQgSSBkaXNsaWtl
IGluIG9sZCB3b3JkaW5nLiBXaHkgZG8gd2UgbmVlZCB0aGlzIGRlZmF1bHQtemVybyB0aGluZ1sq
XT8gV2hhdCBpcyB0aGUgZGVmYXVsdD8NCg0KRGVmYXVsdCBpcyBhYnNlbmNlIG9mIHRoZSBmZWF0
dXJlLCB3ZSBkb24ndCBoYXZlIHRoZXNlIGZ1dHVyZSBmZWF0dXJlcyBub3cgYW5kIGRvbid0IGNh
cmUgb2YgdGhlbS4NCldoYXQgaXMgdGhpcyBkZWZhdWx0IDAgZm9yIHVzIG5vdz8gTm90aGluZy4N
Cg0KQ29uc2lkZXIgc29tZSBmdXR1cmUgdmVyc2lvbjogaWYgaXQgc2VlcyB0aGF0IGhlYWRlcl9s
ZW5ndGggZXhjbHVkZXMgc29tZSBmaWVsZHMsIGl0IHVuZGVyc3RhbmRzLA0KdGhhdCB0aGVyZSBp
cyBubyBzdWNoIGZlYXR1cmUgaGVyZS4gVGhhdCdzIGFsbC4gV29yayB3aXRob3V0IGl0LiBUaGUg
ZmVhdHVyZSBpdHNlbGYgc2hvdWxkIGRlY2xhcmUNCmJlaGF2aW9yIHdpdGhvdXQgdGhpcyBmZWF0
dXJlLCB3aGljaCBzaG91bGQgY29ycmVzcG9uZCB0byBiZWhhdmlvciBiZWZvcmUgdGhpcyBmZWF0
dXJlIGludHJvZHVjdGlvbi4uDQoNClNvIGF0IGxlYXN0LCBJIGRvbid0IGxpa2UgInRoZSB2YWx1
ZSBvZiAwIHNob3VsZCBiZSB1c2VkIGZvciB0aGF0IGZpZWxkIiwgYXMgaW5zdGFuY2VzIG9mIFFl
bXUgd2hpY2gNCmRvbid0IGtub3cgYWJvdXQgdGhlIGZlYXR1cmUgd2lsbCBpZ25vcmUgdGhpcyBy
ZXF1aXJlbWVudCwgYXMgdGhleSBkb24ndCBuZWVkIGFueSB2YWx1ZSBvZiB0aGF0DQpmaWVsZCBh
dCBhbGwuDQoNCldoYXQgeW91IGFjdHVhbGx5IG1lYW4sIElNSE8sIGlzOiBmb3IgYWxsIG9wdGlv
bmFsIGZpZWxkIDAgdmFsdWUgbXVzdCBiZSBlcXVhbCB0byBhYnNlbmNlIG9mIHRoZSBmZWF0dXJl
LA0KbGlrZSB3aGVuIGhlYWRlcl9sZW5ndGggZXhjbHVkZXMgdGhpcyBmaWVsZC4gSSBkb24ndCBz
ZWUsIGRvIHdlIHJlYWxseSBuZWVkIHRoaXMgcmVxdWlyZW1lbnQsIGJ1dA0Kc2VlbXMgaXQgd2Fz
IG1lbnRpb25lZCBiZWZvcmUgdGhpcyBwYXRjaCBhbmQgd2UnZCBiZXR0ZXIga2VlcCBpdC4uIEkg
anVzdCBkb24ndCBsaWtlIGNvbmNlcHQgb2YNCiJkZWZhdWx0IiB2YWx1ZSBrZWVwaW5nIGluIG1p
bmQgdmFsaWQgUWVtdSBpbnN0YW5jZXMgd2hpY2ggZG9uJ3Qga25vdyBhYm91dCBmaWVsZCBhdCBh
bGwuDQoNCj4gDQo+PiBAaGVhZGVyX2xlbmd0aCBtdXN0IGJlIGJvdW5kIHRvIHRoZSBlbmQgb2Yg
b25lIG9mDQo+PiArdGhlc2UgZmllbGRzIChvciB0byBAaGVhZGVyX2xlbmd0aCBmaWVsZCBlbmQg
aXRzZWxmLCB0byBiZSAxMDQgYnl0ZXMpLg0KPiANCj4gV2UgZG9uJ3QgdXNlIHRoZSBAaGVhZGVy
X2xlbmd0aCBtYXJrdXAgYW55d2hlcmUgZWxzZSBpbiB0aGlzIGZpbGUsIHN0YXJ0aW5nIHRvIGRv
IHNvIGhlcmUgaXMgb2RkLg0KPiANCj4gSSB3b3VsZCBzdWdnZXN0IGEgc3Ryb25nZXIgcmVxdWly
ZW1lbnQ6DQo+IA0KPiBoZWFkZXJfbGVuZ3RoIG11c3QgYmUgYSBtdWx0aXBsZSBvZiA0LCBhbmQg
bXVzdCBub3QgbGFuZCBpbiB0aGUgbWlkZGxlIG9mIGFueSBvcHRpb25hbCA4LWJ5dGUgZmllbGQu
DQo+IA0KPiBPciBtYXliZSBldmVuIGFkZCBvdXIgY29tcHJlc3Npb24gdHlwZSBleHRlbnNpb24g
d2l0aCA0IGJ5dGVzIG9mIHBhZGRpbmcsIHNvIHRoYXQgd2UgY291bGQgZ28gZXZlbiBzdHJvbmdl
cjoNCj4gDQo+IGhlYWRlcl9sZW5ndGggbXVzdCBiZSBhIG11bHRpcGxlIG9mIDguDQoNCkhtbSwg
aWYgd2UgaW1wbHkgdGhhdCBzb2Z0d2FyZSB3aWxsIGhhdmUgdG8gYWRkIHNvbWUgcGFkZGluZywg
dGhhbiByZXF1aXJlbWVudCBhYm92ZSBhYm91dCB6ZXJvID09PSBmZWF0dXJlLWFic2VuY2UNCmJl
Y29tZXMgbmVjZXNzYXJ5LiBbKl0NCg0KU3RpbGwgSSBoYXZlIHR3byBxdWVzdGlvbnM6DQoxLiBE
byB3ZSByZWFsbHkgbmVlZCBhbGwgZmllbGRzIHRvIGJlIDQgb3IgOCBieXRlcz8gV2h5IG5vdCB1
c2UgMSBieXRlIGZvciBjb21wcmVzc2lvbj8NCjIuIFdoYXQgaXMgdGhlIGJlbmVmaXQgb2YgcGFk
ZGluZywgd2hpY2ggeW91IHByb3Bvc2U/DQoNCj4gDQo+PiArVGhpcyBkZWZpbml0aW9uIGltcGxp
ZXMgdGhlIGZvbGxvd2luZzoNCj4+ICsxLiBTb2Z0d2FyZSBtYXkgc3VwcG9ydCBzb21lIG9mIHRo
ZXNlIG9wdGlvbmFsIGZpZWxkcyBhbmQgaWdub3JlIHRoZSBvdGhlcnMsDQo+PiArwqDCoCB3aGlj
aCBtZWFucyB0aGF0IGZlYXR1cmVzIG1heSBiZSBiYWNrcG9ydGVkIHRvIGRvd25zdHJlYW0gUWVt
dSBpbmRlcGVuZGVudGx5Lg0KPiANCj4gSSBkb24ndCB0aGluayB0aGlzIGJlbG9uZ3MgaW4gdGhl
IHNwZWMuDQoNCk1lIHRvby4gQnV0IGF0IGxlYXN0IEkgbm90ZWQgd2hhdCBJIHRyeSB0byBhY2hp
ZXZlLCBzbyBjb25zaWRlciBpdCBhIGJpdCBsaWtlIFJGQy4gQW5kIG9mIGNvdXJzZSBJIGhvcGVk
IGZvciB5b3VyIHJld29yZGluZ3MgKQ0KDQo+wqAgSWRlYWxseSwgd2UgYWRkIGZpZWxkcyBzbyBp
bmZyZXF1ZW50bHkgdGhhdCBiYWNrcG9ydGluZyBkb2Vzbid0IGhhdmUgdG8gd29ycnkgYWJvdXQg
YmFja3BvcnRpbmcgZmllbGQgMiB3aGlsZSBza2lwcGluZyBmaWVsZCAxLg0KDQpXaG8ga25vd3Mu
LiBFdmVuIGhhdmluZyBvbmx5IHR3byBmaWVsZHMgQSBhbmQgQiwgd2hlbiB3ZSBuZWVkIEIgd2hp
Y2ggYWN0dWFsbHkgbmVlZHMgMTAgcGF0Y2hlcyB0byBiYWNrcG9ydCBhbmQgQSBuZWVkcyAxMDAg
d291bGQgYmUNCmEgcHJvYmxlbSwgaWYgd2UgY2FuJ3QgYmFja3BvcnQgQiBpbiBzZXBhcmF0ZS4N
Cg0KSSByZW1lbWJlciBzaW1pbGFyIHRoaW5nIGFib3V0IE5CRDogSSBuZWVkZWQgQkxPQ0tfU1RB
VFVTLCBidXQgYmVjYXVzZSBvZiBzcGVjaWZpY2F0aW9uIEkgaGFkIHRvIGltcGxlbWVudA0Kc3Ry
dWN0dXJlZCByZWFkIGZpcnN0LCB3aGljaCB3YXNuJ3QgaW50ZXJlc3RpbmcgdG8gbWUgYXQgdGhh
dCBtb21lbnQuDQoNCj4gDQo+PiArMi4gU29mdHdhcmUgbWF5IGNoZWNrIEBoZWFkZXJfbGVuZ3Ro
LCBpZiBpdCBrbm93cyBvcHRpb25hbCBmaWVsZHMgc3BlY2lmaWNhdGlvbg0KPj4gK8KgwqAgZW5v
dWdoIChrbm93cyBhYm91dCB0aGUgZmllbGQgd2hpY2ggZXhjZWVkcyBAaGVhZGVyX2xlbmd0aCku
DQo+IA0KPiBBZ2FpbiwgSSBkb24ndCB0aGluayB0aGlzIGFkZHMgYW55dGhpbmcuwqAgU2luY2Ug
d2UgYWxyZWFkeSBkb2N1bWVudGVkIGZpZWxkcyBhcmUgb3B0aW9uYWwsIGFuZCB0aGF0IGlmIGhl
YWRlcl9sZW5ndGggaXMgdG9vIHNob3J0LCB0aGUgbWlzc2luZyBmaWVsZCBpcyB0cmVhdGVkIGFz
IDAsIHNvZnR3YXJlIHRoYXQga25vd3MgYWJvdXQgYSBsb25nZXIgaGVhZGVyX2xlbmd0aCB3aWxs
IGFscmVhZHkgaGFuZGxlIGl0IGNvcnJlY3RseS4NCg0KSSB0aGluaywgSSdsbCBtb3ZlIHRoZXNl
IHBvaW50cyB0byBjb21taXQgbWVzc2FnZSwgdG8ga2VlcCB0aGVtIHNvbWVob3cuDQoNCj4gDQo+
PiArMy4gSWYgQGhlYWRlcl9sZW5ndGggaXMgaGlnaGVyIHRoYW4gdGhlIGhpZ2hlc3QgZmllbGQg
ZW5kIHRoYXQgc29mdHdhcmUga25vd3MsDQo+PiArwqDCoCBpdCBzaG91bGQgYXNzdW1lIHRoYXQg
YWRkaXRpb25hbCBmaWVsZHMgYXJlIGNvcnJlY3QsIEBoZWFkZXJfbGVuZ3RoIGlzDQo+PiArwqDC
oCBjb3JyZWN0IGFuZCBrZWVwIEBoZWFkZXJfbGVuZ3RoIGFuZCBhZGRpdGlvbmFsIHVua25vd24g
ZmllbGRzIGFzIGlzIG9uDQo+PiArwqDCoCByZXdyaXRpbmcgdGhlIGltYWdlLg0KPj4gKzMuIElm
IHdlIHdhbnQgdG8gYWRkIGluY29tcGF0aWJsZSBmaWVsZCAob3IgYSBmaWVsZCwgZm9yIHdoaWNo
IHNvbWUgaXRzIHZhbHVlcw0KPj4gK8KgwqAgd291bGQgYmUgaW5jb21wYXRpYmxlKSwgaXQgbXVz
dCBiZSBhY2NvbXBhbmllZCBieSBpbmNvbXBhdGlibGUgZmVhdHVyZSBiaXQuDQo+PiArDQo+PiAr
wqDCoMKgwqDCoMKgwqAgPCAuLi4gTm8gYWRkaXRpb25hbCBmaWVsZHMgaW4gdGhlIGhlYWRlciBj
dXJyZW50bHkgLi4uID4NCj4+ICsNCj4gDQo+IEknbSBzdGlsbCBub3Qgc2VlaW5nIHRoZSB2YWx1
ZSBpbiBhZGRpbmcgYW55IG9mIHRoaXMgcGFyYWdyYXBoIHRvIHRoZSBzcGVjLsKgIE1heWJlIGlu
IHRoZSBjb21taXQgbWVzc2FnZSB0aGF0IGFjY29tcGFuaWVzIHRoZSBzcGVjIGNoYW5nZSwgYnV0
IHRoZSBzcGVjIGlzIGNsZWFyIGVub3VnaCBpZiBpdCBkb2N1bWVudHMgaG93IG9wdGlvbmFsIGhl
YWRlciBmaWVsZHMgYXJlIHRvIGJlIG1hbmFnZWQgKHRyZWF0IGFzIDAgaWYgbWlzc2luZywgcHJl
c2VydmUgb24gd3JpdGUgaWYgdW5rbm93biwgYW5kIHdpdGggYSBtYW5kYXRlZCBhbGlnbm1lbnQg
dG8gYXZvaWQgaGF2aW5nIHRvIHdvcnJ5IGFib3V0IG90aGVyIGlzc3VlcykuDQo+IA0KPj4gwqAg
RGlyZWN0bHkgYWZ0ZXIgdGhlIGltYWdlIGhlYWRlciwgb3B0aW9uYWwgc2VjdGlvbnMgY2FsbGVk
IGhlYWRlciBleHRlbnNpb25zIGNhbg0KPj4gwqAgYmUgc3RvcmVkLiBFYWNoIGV4dGVuc2lvbiBo
YXMgYSBzdHJ1Y3R1cmUgbGlrZSB0aGUgZm9sbG93aW5nOg0KPj4NCj4gDQoNCg0KLS0gDQpCZXN0
IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

