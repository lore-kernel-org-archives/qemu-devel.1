Return-Path: <SRS0=SBSl=35=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEF9C35250
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2020 05:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A04692072C
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2020 05:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="zNMSsbX9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="PwQFGdil"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04692072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0eqq-0002G8-RY
	for qemu-devel@archiver.kernel.org; Sun, 09 Feb 2020 00:09:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1j0eq4-0001Cj-9g
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 00:09:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1j0eq3-0001vz-5k
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 00:09:00 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:13950)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1j0eq2-0001ry-OA
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 00:08:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581224938; x=1612760938;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sZj4mFFX7BRjAETUieFTtBKsi5LJtnDok4RXc87d34w=;
 b=zNMSsbX9J0RrEq6s8kRiWR0AHaRHHah2C98mnap+HP81y2cjR4FAqtKM
 frtrUXCWbr6CzvlFiQRUrsja2zQunmmmO8FlwGWTNqan0BPTF0q6wCBDc
 kYfe4mwmYIuwm2TnH6fkaf+NRBvUK7HNhfeNDnKonq4jqPKnrOw7/Yt7p Y=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 08 Feb 2020 21:08:49 -0800
Received: from nasanexm01c.na.qualcomm.com ([10.85.0.83])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 08 Feb 2020 21:08:49 -0800
Received: from NASANEXM01C.na.qualcomm.com (10.85.0.83) by
 NASANEXM01C.na.qualcomm.com (10.85.0.83) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Sat, 8 Feb 2020 21:08:48 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01C.na.qualcomm.com (10.85.0.83) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Sat, 8 Feb 2020 21:08:48 -0800
Received: from SN6PR02MB4895.namprd02.prod.outlook.com (52.135.113.208) by
 SN6PR02MB4781.namprd02.prod.outlook.com (52.135.116.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Sun, 9 Feb 2020 05:08:46 +0000
Received: from SN6PR02MB4895.namprd02.prod.outlook.com
 ([fe80::4d4:4ae5:df44:3251]) by SN6PR02MB4895.namprd02.prod.outlook.com
 ([fe80::4d4:4ae5:df44:3251%4]) with mapi id 15.20.2707.024; Sun, 9 Feb 2020
 05:08:46 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <rth@twiddle.net>, Richard Henderson
 <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH] Add support for a helper with 7 arguments
Thread-Topic: [PATCH] Add support for a helper with 7 arguments
Thread-Index: AQHV3HWNrLXzUmuR802n/46fb+QBo6gPp2wAgAACx8CAADlQAIACaQnw
Date: Sun, 9 Feb 2020 05:08:46 +0000
Message-ID: <SN6PR02MB4895FE0821C3927B41636AB0DE1E0@SN6PR02MB4895.namprd02.prod.outlook.com>
References: <1580942510-2820-1-git-send-email-tsimpson@quicinc.com>
 <b308434a-1ee8-4fb5-0e60-4dfdd047c959@linaro.org>
 <BYAPR02MB4886E14CC87B1169B2F6BE2BDE1C0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <a01b3358-a598-9d01-f3c8-d9a84fb7dd28@twiddle.net>
In-Reply-To: <a01b3358-a598-9d01-f3c8-d9a84fb7dd28@twiddle.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [70.115.140.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed78c5f4-0a20-4e34-c330-08d7ad1e244e
x-ms-traffictypediagnostic: SN6PR02MB4781:
x-microsoft-antispam-prvs: <SN6PR02MB47811C508D09357D920C2D3BDE1E0@SN6PR02MB4781.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0308EE423E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(376002)(346002)(136003)(39860400002)(189003)(199004)(5660300002)(26005)(110136005)(52536014)(66446008)(2906002)(7696005)(64756008)(66556008)(66476007)(66946007)(478600001)(86362001)(316002)(8676002)(8936002)(81166006)(81156014)(76116006)(186003)(9686003)(71200400001)(6506007)(55016002)(4326008)(53546011)(33656002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR02MB4781;
 H:SN6PR02MB4895.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OEA1l0cB/S1QyC7yD2dm4oQZ1nBJEbT0eFX9OUBYkHCNfj0kLVlxPtdX1lz/D18Cdwqfhop1o+zu55vjP0ZgoAslAjsa/cngUg4F+QB3Xi7jALDzJ4mXSydSNWUPq9c3EkCrmf6+cHnR6EjT5qmCVQW936OEMRVoEB0lxJo5A8ho6FkvoeAZCHSo+UW1bcn11a5SDUO2aDT1Ki7dPS2a6c64yd+73ZLv1xYEcvZVv8MtHRWF6A78hPUuMAX+7diCXM1clKpWV/KjGLEc+KKboS8DRzVpiNHswgP8ggZ1Evpj5XV0kxcO2G6IHdZadtI0mTrqod5gnwolwZH5wetNUaxZK3+vIue3bEshnQLpLwn4uQepHLNm3FjthjsCDKddxI7TbA71BYbwTFxyznCdft3tmXPaOt4QpbMBT87pNDVcn1/jfXCjDg/igIULRUbQ
x-ms-exchange-antispam-messagedata: SLWO5G/dGy60zjBtqzi4nCgtfuLw8AayPq0QgzRcF5u8yi5bUiUTbX77iAFaQmm3MfBxntLosYzheO9bRwx+ScvJCKTe+l44cMsCHzRu92HXFvOvdCGD0QDMnJwpJvata/nfMpDPd+GXgPaUyObyew==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeWLXXY4PUuuKufyzH53YAAPlg2R0cMTznlIXjKBbl9T7gEyui12fJ0xmsj9F2tOfp4arVE05remmJ1DnWfiECehjPei4jx3lheUS1cXKXzDq89rRRKaHHcNfxSEOeNlAYQbKLRxoArgJgJftnLhMynqufV66BouikUZupEit0h/wYE0VldLSwU/EXwZctvwrMQgnVuoMQj+XjCAIvjImxdqklh8QYAY8Y08BNdGZVQG7Giaj0DhM9V5XAyuByCNMHPM5y4Mct1x0XPQDxqZxoZQ9AoBKBrlIoT6vnObJZTwgutkk3Y1LebloC7QAfmh3bB+e4OkncxEUf7lBqld8A==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmSqGiy3ccXqMpH078u9S+tJJWHf0NT16LbpuEihHmE=;
 b=dLiE1uSFrbSi2Kf/WgIfYd4j+Z2El/868+VGa6f5x/3fJNtKBPs+XcWzIqBLk0CAk8D71fm2PCBFjOLX4v4GxJCiMShzM7JA7o1wLrplAYfUICyCU+gJLQw7bksPHJ3kV2Pih2KXhey5qFskyJbRpcc/WvJpp+FYRoR5VJ+pmekGJ8HoLOH3JDWrzVxX/nnuaFSZRrU6h/gB8IDutJEqr6vF+5AU5c3N/Fve9o70g7GGuzaDNSmfyKvMqmJrOxY3oohaihfHqpj47D6O/+fC8y6W0wbwb2jd4v3QgTi+Eu5ymUFpiwlH8X92Xjl+WxRwxQC+2g2UOJSjd8Sfx4u7CA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmSqGiy3ccXqMpH078u9S+tJJWHf0NT16LbpuEihHmE=;
 b=PwQFGdilw1/Qod2XW7shy+59VKpqM8wBSzNHiVQwURvjAsEjJR4jRKPy79jiGS7DKxyuKvakR5reHP2bZaB8qMzUzQFRGZzu0YAQzdITK9ULPactXwr2o4yANlReeDsNdYNQP8F6QQl7XCXJeJWyvKOzGmPYdgDyEG5X2Fou0Wo=
x-ms-exchange-crosstenant-network-message-id: ed78c5f4-0a20-4e34-c330-08d7ad1e244e
x-ms-exchange-crosstenant-originalarrivaltime: 09 Feb 2020 05:08:46.3971 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: /q4i1JiGkw8/P4pUv2c3F6/PpHvMgYW5XmqdSEGTRYgvL0XS2pZJOKoqeHUd6WdA4mEKu4ajbQY/Qkx43Xdpcg==
x-ms-exchange-transport-crosstenantheadersstamped: SN6PR02MB4781
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.38
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gT24gMi83LzIwIDEyOjQzIFBNLCBUYXlsb3IgU2ltcHNvbiB3cm90ZToNCj4gPg0KPiA+
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBSaWNoYXJkIEhlbmRlcnNv
biA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4NCj4gPj4NCj4gPj4gQnV0IEkgZW5jb3Vy
YWdlIHlvdSB0byByZS10aGluayB5b3VyIHB1cmVseSBtZWNoYW5pY2FsIGFwcHJvYWNoIHRvIHRo
ZQ0KPiA+PiBoZXhhZ29uIHBvcnQuICBJdCBzZWVtcyB0byBtZSB0aGF0IHlvdSBzaG91bGQgYmUg
ZG9pbmcgbXVjaCBtb3JlDQo+IGR1cmluZw0KPiA+PiB0aGUgdHJhbnNsYXRpb24gcGhhc2Ugc28g
dGhhdCB5b3UgY2FuIG1pbmltaXplIHRoZSBudW1iZXIgb2YgaGVscGVycyB0aGF0DQo+ID4+IHlv
dSByZXF1aXJlLg0KPiA+DQo+ID4gVGhlcmUgYXJlIGEgY291cGxlIG9mIHRoaW5ncyB3ZSBjb3Vs
ZCBkbw0KPiA+IC0gU2hvcnQgdGVybTogQWRkICNpZmRlZidzIHRvIHRoZSBnZW5lcmF0ZWQgY29k
ZSBzbyB0aGF0IHRoZSBoZWxwZXIgaXNuJ3QNCj4gPiAgIGNvbXBpbGVkIHdoZW4gdGhlcmUgaXMg
YSBmV1JBUF88dGFnPiBkZWZpbmVkLiAgVGhlcmUgYXJlIGN1cnJlbnRseSB+NTAwDQo+ID4gICBp
bnN0cnVjdGlvbnMgd2hlcmUgdGhpcyBpcyB0aGUgY2FzZS4NCj4NCj4gRGVmaW5pdGVseS4NCg0K
T0ssIGRvbmUuDQoNCj4NCj4gPiAtIExvbmcgdGVybTogSW50ZWdyYXRlIHJldi5uZydzIGFwcHJv
YWNoIHRoYXQgdXNlcyBmbGV4L2Jpc29uIHRvIHBhcnNlIHRoZQ0KPiA+IHNlbWFudGljcyBhbmQg
Z2VuZXJhdGUgVENHIGNvZGUuDQo+IFRoZXJlIGlzIHBlcmhhcHMgYW4gaW50ZXJtZWRpYXRlIHN0
ZXAgdGhhdCBtZXJlbHkgc3BlY2lhbC1jYXNlcyB0aGUNCj4gbG9hZC9zdG9yZQ0KPiBpbnNucy4g
IFdpdGggcmFyZSBleGNlcHRpb25zIChoYWghKSB0aGVzZSBhcmUgdGhlIGNhc2VzIHRoYXQgd2ls
bCBtb3N0IG9mdGVuDQo+IHJhaXNlIGFuIGV4Y2VwdGlvbi4gIE1vcmVvdmVyLCB0aGV5IGFyZSB0
aGUgKm9ubHkqIGNhc2VzIHRoYXQgY2FuIHJhaXNlIGFuDQo+IGV4Y2VwdGlvbiB3aXRob3V0IHJl
cXVpcmluZyBhIGhlbHBlciBjYWxsIGFueXdheS4NCj4NCj4gVGhlcmUgYXJlIGEgbnVtYmVyIG9m
IGNhc2VzIHRoYXQgSSBjYW4gdGhpbmsgb2Y6DQo+DQo+IHsNCj4gICByNiA9IG1lbWIocjEpDQo+
ICAgcjcgPSBtZW1iKHIyKQ0KPiB9DQo+DQo+IHFlbXVfbGQgICB0MCwgcjEsIE1PX1VCLCBtbXVf
aWR4DQo+IHFlbXVfbGQgICB0MSwgcjIsIE1PX1VCLCBtbXVfaWR4DQo+IG1vdiAgICAgICByNiwg
dDANCj4gbW92ICAgICAgIHI3LCB0MQ0KPg0KDQpIZXJlIGlzIHRoZSBUQ0cgd2UgZ2VuZXJhdGUg
Y3VycmVudGx5Lg0KIG1vdmlfaTMyIHRtcDAsJDB4MA0KIGFkZF9pMzIgbG9jMixyMSx0bXAwDQog
cWVtdV9sZF9pMzIgbG9jMyxsb2MyLHNiLDANCiBtb3ZfaTMyIG5ld192YWx1ZSxsb2MzDQogbW92
aV9pMzIgdG1wMCwkMHgwDQogYWRkX2kzMiBsb2MyLHIyLHRtcDANCiBxZW11X2xkX2kzMiBsb2Mz
LGxvYzIsc2IsMA0KIG1vdl9pMzIgbmV3X3ZhbHVlLGxvYzMNCiBtb3ZfaTMyIHI2LG5ld192YWx1
ZQ0KIG1vdl9pMzIgcjcsbmV3X3ZhbHVlDQpJIGNvdWxkIHdvcmsgb24gZWxpbWluYXRpbmcgdGhl
IGFkZCBvZiB6ZXJvIGFuZCB0aGUgZXh0cmEgY29waWVzLiAgSXMgVENHIGFibGUgdG8gb3B0aW1p
emUgdGhlc2UgYmVmb3JlIGVtaXR0aW5nIHRoZSBob3N0IGNvZGU/DQoNCg0KPiB7DQo+ICAgcjYg
PSBtZW1iKHIxKQ0KPiAgIG1lbWIocjIpID0gcjcNCj4gfQ0KPg0KPiBxZW11X2xkICAgdDAsIHIx
LCBNT19VQiwgbW11X2lkeA0KPiBxZW11X3N0ICAgcjcsIHIyLCBNT19VQiwgbW11X2lkeA0KPiBt
b3YgICAgICAgcjYsIHQwDQo+DQo+IFRoZXNlIGJlaW5nIHRoZSAibm9ybWFsIiBjYXNlIHdoZXJl
aW4gdGhlIG1lbW9wcyBhcmUgdW5jb25kaXRpb25hbCwgYW5kDQo+IGNhbg0KPiBzaW1wbHkgdXNl
IGEgdGVtcCBmb3Igc2VtYW50aWNzLiAgU2ltaWxhcmx5IGZvciBNRU1PUCwgTlYsIG9yIFNZU1RF
TSBpbnNucw0KPiBpbg0KPiBzbG90MC4NCj4NCj4gew0KPiAgIHI2ID0gbWVtYihyMSkNCj4gICBp
ZiAocDApIHI3ID0gbWVtYihyNykNCj4gfQ0KPg0KPiBxZW11X2xkICAgbDAsIHIxLCBNT19VQiwg
bW11X2lkeA0KPiBhbmRpICAgICAgdDEsIHAwLCAxDQo+ICAgICAgICAgYnJjb25kaSAgIHQxLCAw
LCBMMQ0KPiAgICAgICAgIHFlbXVfbGQgICByNywgcjIsIE1PX1VCLCBtbXVfaWR4DQo+ICBMMToN
Cj4gbW92ICAgICAgIHI2LCBsMA0KPg0KPiBGb3IgYSBjb25kaXRpb25hbCBsb2FkIGluIHNsb3Qg
MCwgd2UgY2FuIGxvYWQgZGlyZWN0bHkgaW50byB0aGUgZmluYWwNCj4gZGVzdGluYXRpb24gcmVn
aXN0ZXIgYW5kIHNraXAgdGhlIHRlbXBvcmFyeS4NCg0KSW4gZ2VuZXJhbCwgdGhlcmUgd2lsbCBi
ZSBsb3RzIG9mIGNoZWNrcyB3ZSB3b3VsZCBuZWVkIHRvIHBlcmZvcm0gYmVmb3JlIGNvbmNsdWRp
bmcgdGhhdCBhbiBpbnN0cnVjdGlvbiBjYW4gd3JpdGUgZGlyZWN0bHkgaW50byB0aGUgZGVzdGlu
YXRpb24uICBGb3IgZXhhbXBsZSwgd2UgaGF2ZSB0byBtYWtlIHN1cmUgbm8gb3RoZXIgaW5zdHJ1
Y3Rpb24gbGF0ZXIgaW4gdGhlIHBhY2tldCByZWFkcyByNy4gIEFsc28sIHdlIGhhdmUgdG8gY2hl
Y2sgaWYgdGhlcmUgYXJlIGFueSAubmV3IHJlZmVyZW5jZXMgdG8gcjcgLSB0aGVzZSB3aWxsIHJl
YWQgZnJvbSBuZXdfdmFsdWVbN10uDQoNCg==

