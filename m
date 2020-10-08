Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED21C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 18:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A08D206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 18:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d3mAOYA3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="CjbUzzp8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A08D206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQb1x-00066O-2n
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 14:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kQb0s-0005Ay-To
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 14:51:38 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:27525)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kQb0q-0002ib-5t
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 14:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1602183096; x=1633719096;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4rTL4aQ44QspJPm7ct10jqA56FGSMyTy36Fi0dML+Qc=;
 b=d3mAOYA30nL5sU6CTqNSNovJk9tcaBF9iFmGjpX8aNIGCYPvNqHgKsdI
 Pjbes8K2aNaybOI6D1L6sC+QcXKPrGWL5CKrEn3an+MYp9T3fFNgEktdn
 j/g7wSk6fTy8paNxUrpSA5FV/mHLlvZVm94dJ2Ojjuwi39h0g34g7/4s6 s=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 08 Oct 2020 11:51:33 -0700
X-QCInternal: smtphost
Received: from nasanexm03a.na.qualcomm.com ([10.85.0.103])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 08 Oct 2020 11:51:32 -0700
Received: from nasanexm03d.na.qualcomm.com (10.85.0.91) by
 nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 8 Oct 2020 11:51:33 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 8 Oct 2020 11:51:33 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BY5PR02MB6388.namprd02.prod.outlook.com (2603:10b6:a03:1b4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Thu, 8 Oct
 2020 18:51:32 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c%6]) with mapi id 15.20.3455.025; Thu, 8 Oct 2020
 18:51:32 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 26/34] Hexagon (target/hexagon) macros referenced
 in instruction semantics
Thread-Topic: [RFC PATCH v3 26/34] Hexagon (target/hexagon) macros referenced
 in instruction semantics
Thread-Index: AQHWdXdf6p/vkS3v9UGs80VPN3oP2KlOWTUAgD+1nUCAADfPgIAAExFw
Date: Thu, 8 Oct 2020 18:51:31 +0000
Message-ID: <BYAPR02MB488658CFC0440D56F13F68D0DE0B0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-27-git-send-email-tsimpson@quicinc.com>
 <75d5275b-76e5-38a5-f9a3-f36d1ee08c74@linaro.org>
 <BYAPR02MB4886F48B7E22A43984D78A13DE0B0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <b77feb32-9170-0c19-8147-5a195a227cca@linaro.org>
In-Reply-To: <b77feb32-9170-0c19-8147-5a195a227cca@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c254ede-3315-46c8-d298-08d86bbb2c62
x-ms-traffictypediagnostic: BY5PR02MB6388:
x-microsoft-antispam-prvs: <BY5PR02MB6388A277F9C5B11740B5EACADE0B0@BY5PR02MB6388.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lTuHQfdMEb6IltDbAQdaMW68ENtnhbelY2yqcB8loZ+BjYNpuu9FpX33bAb2RYfaTP98mt8n74OV0BZteU1mHWHhNf62sUeHaVK0WfIEvBwPljZlwgq5ynNciNdKpNWdLkOBZM4rBktIuNZOONe3UsGKlCJU92rL+vFiUeqS3EHqbG0iRRF0SWSy/+JkYpolr0Bf1M4v8xIjcP+KUNESwTX12SdSxaSvw6oONtRtJk+6nxc9NgQbFt4858BTsmMiMIKzD+FLaWX8b5qjDIwBij8JQwUEuGLfNHsfsuI7vV4RfXlCPz28Zl5kPRipuUbNB4P4cAqic/9ueLG9LeCHrw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(366004)(39860400002)(396003)(346002)(376002)(55016002)(66446008)(66556008)(2906002)(71200400001)(83380400001)(9686003)(66476007)(33656002)(8936002)(52536014)(8676002)(478600001)(66946007)(76116006)(7696005)(5660300002)(6506007)(86362001)(53546011)(54906003)(110136005)(4326008)(316002)(64756008)(186003)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: amaf0An8gnuf/odY8OR12c420aecR12RNgfwwZmfqNZljs52fa/F/O6qpppC5p+Zv+RVAh7+Nl23OTXQFGVfd9Ktu5yrbSSnMutMEMsqVIjwjXBnw3XQLau9IiR5UPKGGEkLoLipS65OonG46b+u/YJXY2d3/azuax4eXKurenccKCxZnKtLrUwvFAmWAtFPo3zqjPn0Rikr/MFM3MWqsAKyZoj3JAlEyRTKgl5g7YbTIoooFcI5JbYhI/HwD8HhINuJFrhwLLnOVctfwbdeGpTRNTHB2Nou4IjyjGF8eTKlGkR2ycJFlF83A/FIilUsGaGEfBobsvrdANBcRx1oO6QB2c/JlQuxFX+oSN0tzskZQr30wafLbu0R+b8VjMbHNu1dngVNv1cy8e56QKYRUd/SxkeuF+jnqBIPjgb3bsenY3lOG5BctWO4Bk6IYgr2fvxqbMSopG9kJIjX4Kz9WuLsurORIudrsjqZWXslKCP4Szu6/uFDpoi/rK7OuXehcxgybWFx4ubBbLdGFgxVR+Rar1vh1ft0HqwbATVQ5JkKFFTCy7TV/mOP/zBFZKEXm8V5JSVvR9cic9ohU32i47wkdcf8VA7nXCDBGk1Li1KNWRcVMjhniosw7lTB6sk5Q32JkrPn3ARZx8+qX85sTA==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gly2/EOXaNbOETvvure26qzoEAmBXRxWIc4FeP5vsvRrjJ8B7rR8JJZZUF01acuHHfValTVmjwSztrMwKZiPjoKOIwck6GTIe2UD5osGsQmLOucGiujpbwuVtSwV7qQvIGY2w4WE52aMVRRH5EGeiQGxKCCmVtJnVQsLc1lmA3NUZV4EEL4jEt1PdGD+W57QAyk4jCCAialJbZiBPvNSZuvgwJjxzZkUwo8/xkqiaJacV09dKA6U4Wo7O5LzsjSytHru7K2NW2gTn8VQzTW31rudRCdN3LO6+TA7vzZo01w8XSGaexQDoDlHzwlTg4b2Q56qU3mI4/2eSp6Eg4ngfA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrjRerVm2zHwi2D/kOxfYl3HU9mjVLGgUKg5l1aKrk4=;
 b=nXInadrAuFFHjm3UwrZnbW7QVrMrfuxXXnySGODQCfTUbuwYDAkX+om5lvLv85sLS2vp+s6gHz9gjDcbO5mc+lNqBHKzTf1jP6d9+cN1fYJLfgt8vvRoDFNpucQGMHA/GPWDA8c76MGCfC3VC6V8EUrb2Cw1g9VA1HjJeZGyonkvERteRQdP1El0/ZPfKs376+DYHi8qxz/7ArgWO+RlNIkJgsdVnbePN/09dTuPHDrPo/tE+6r5LG5ymuPLJUaH2DC+zCPMBbUPWO8nE3/NP7LV6cC9aieT5ZjfN9LP2dV4QbP+d3ENqM/bwBbaSKElJji8G/YGjAZVm6tSFoO3Ug==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrjRerVm2zHwi2D/kOxfYl3HU9mjVLGgUKg5l1aKrk4=;
 b=CjbUzzp8ZE3OVHWntZDigAe4PtyKP6oLINVbXtEdhIsOVR4ByEvix6PmIgiHgnlf7ET6c3uq7ojuejcXPl6TmraVYNzi2fZSru1gFuOdEkWcQ3/Jb1fSrcoDpX3ruw56sCROwMfi30Ilja0wRKUDPMT+vCCusUX1m4bGQvDdm34=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 4c254ede-3315-46c8-d298-08d86bbb2c62
x-ms-exchange-crosstenant-originalarrivaltime: 08 Oct 2020 18:51:31.9436 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: U5d4g2pCkDAVg0G8bpd9+89iUSCiXpGcNLlF2hHbAP/3aBBHycld5a2gmbuczrM5QyLFmCqwIF+l4gSAPgAZOw==
x-ms-exchange-transport-crosstenantheadersstamped: BY5PR02MB6388
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.38; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 14:51:34
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "ale@rev.ng" <ale@rev.ng>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmljaGFyZCBIZW5kZXJz
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBPY3Rv
YmVyIDgsIDIwMjAgMTE6MzEgQU0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWlj
aW5jLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGhpbG1kQHJlZGhhdC5jb207
IGxhdXJlbnRAdml2aWVyLmV1OyByaWt1LnZvaXBpb0Bpa2kuZmk7DQo+IGFsZWtzYW5kYXIubS5t
YWlsQGdtYWlsLmNvbTsgYWxlQHJldi5uZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAy
Ni8zNF0gSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIG1hY3Jvcw0KPiByZWZlcmVuY2VkIGluIGlu
c3RydWN0aW9uIHNlbWFudGljcw0KPg0KPiA+PiBBaCwgc28gSSBzZWUgd2hhdCB5b3UncmUgdHJ5
aW5nIHRvIGRvIHdpdGggdGhlIG1lcmdlIHRoaW5nLCB3aGljaCBoYWQgdGhlDQo+ID4+IGhvc3Qt
ZW5kaWFuIHByb2JsZW1zLg0KPiA+Pg0KPiA+PiBJIHRoaW5rIHRoZSBtZXJnZSBzdHVmZiBpcyBh
IG1pc3Rha2UuICBJIHRoaW5rIHlvdSBjYW4gZ2V0IHRoZSBzZW1hbnRpY3MgdGhhdA0KPiA+PiB5
b3Ugd2FudCB3aXRoDQo+ID4+DQo+ID4+IHByb2JlX3JlYWQobGRfYWRkciwgbGRfbGVuKQ0KPiA+
PiBxZW11X3N0KHN0X3ZhbHVlLCBzdF9hZGRyKQ0KPiA+PiBxZW11X2xkKGxkX3ZhbHVlLCBsZF9h
ZGRyKQ0KPiA+Pg0KPiA+PiBJbiB0aGlzIHdheSwgYWxsIGV4Y2VwdGlvbnMgYXJlIHJlY29nbml6
ZWQgYmVmb3JlIHRoZSBzdG9yZSBpcyBjb21wbGV0ZSwNCj4gdGhlDQo+ID4+IG5vcm1hbCBtZW1v
cnkgb3BlcmF0aW9ucyBoYW5kbGUgYW55IHBvc3NpYmxlIG92ZXJsYXAuDQo+ID4NCj4gPiBGb2xs
b3dpbmcgdXAgb24gdGhpcy4uLg0KPiA+DQo+ID4gMSkgV2UgZG9uJ3QgbmVlZCB0byBkbyB0aGUg
cHJvYmVfcmVhZCBiZWNhdXNlIHRoZSBsb2FkIGhhcyBhbHJlYWR5DQo+IGhhcHBlbmVkIGF0IHRo
aXMgcG9pbnQuDQo+DQo+DQo+IFdoYXQgZG8geW91IG1lYW4gImhhcyBhbHJlYWR5IGhhcHBlbmVk
Ij8NCj4gSG93IGNhbiBpdCBoYXZlIGRvbmUgd2l0aG91dCBkb2luZyB0aGUgbWVyZ2luZyBieSBo
YW5kLiAgV2hpY2ggdGhpcyBvcGVyYXRpb24gb3JkZXJpbmcgaXMgaW50ZW5kZWQgdG8gbWFrZSB1
bm5lY2Vzc2FyeS4NCj4NCj4gSSB0aGluayB5b3UncmUgbWlzc2luZyB0aGUgcG9pbnQuDQoNClNv
cnJ5IEkgd2Fzbid0IGNsZWFyLiAgV2UgaGF2ZSBkb25lIHRoZSBsb2FkIGZyb20gbWVtb3J5IGFz
IGl0IHdhcyBhdCB0aGUgYmVnaW5uaW5nIG9mIHRoZSBwYWNrZXQuICBUaGUgcmVzdWx0IG9mIHRo
ZSBzdG9yZSBpcyBpbiBtZW1fbG9nX3N0b3JlcyBpbiBDUFVIZXhhZ29uU3RhdGUuICBUaGlzIGNv
ZGUgdXBkYXRlcyB0aGUgYnl0ZXMgdGhhdCB3ZXJlIGxvYWRlZCB3aXRoIGFueSBvdmVybGFwcGlu
ZyBieXRlcyBmcm9tIHRoZSBzdG9yZSB0aGF0IGhhc24ndCBiZWVuIGNvbW1pdHRlZCB5ZXQuDQoN
Cj4NCj4NCj4gPiAyKSBJJ20gbm90IGZhbWlsaWFyIHdpdGggcWVtdV9zdC9xZW11X2xkLiAgQXJl
IHRoZXNlIHNob3J0aGFuZCBmb3INCj4gdGNnX2dlbl9xZW11X3N0Ki90Y2dfZ2VuX3FlbXVfbGQq
Pw0KPg0KPiBZZXMuDQo+DQo+ID4gV2UgY2FuJ3QgYWN0dWFsbHkgZG8gdGhlIHN0b3JlIGF0IHRo
aXMgcG9pbnQgYmVjYXVzZSBpdCB3b3VsZCBhbHRlciB0aGUNCj4gbWVtb3J5IGJlZm9yZSB3ZSBh
cmUgc3VyZSB0aGUgcGFja2V0IHdpbGwgY29tbWl0IChpLmUuLCB0aGVyZSBtaWdodCBiZSBzdGls
bA0KPiBiZSBhbiBleGNlcHRpb24gcmFpc2VkIGJ5IGFub3RoZXIgaW5zdHJ1Y3Rpb24gaW4gdGhl
IHBhY2tldCkuDQo+DQo+IFdoYXQgb3RoZXIgaW5zdHJ1Y3Rpb24/ICBHaXZlIG1lIGEgY29uY3Jl
dGUgZXhhbXBsZSBzbyB0aGF0IEkgY2FuIGdpdmUgeW91IGENCj4gY29uY3JldGUgYW5zd2VyLg0K
DQpSZW1lbWJlciwgdGhlcmUgY2FuIGJlIDQgaW5zdHJ1Y3Rpb25zIGluIGEgcGFja2V0LiAgVGhp
cyBjb2RlIGlzIG9ubHkgZGVhbGluZyB3aXRoIHR3byBvZiB0aGVtIChhIGxvYWQgYW5kIGEgc3Rv
cmUpLiAgSGVyZSdzIGFuIGV4YW1wbGUgd2hlcmUgYSBkaWZmZXJlbnQgaW5zdHJ1Y3Rpb24gaW4g
dGhlIHBhY2tldCBjYW4gZmF1bHQuDQoNCiAgICA2N2Y4OiAgICAgICBjMCA0MCAyMSAxZiAgICAg
MWYyMTQwYzAgeyAgICAgIHYwLnVoID0gdnNhdCh2MC51dyx2MS51dykNCiAgICA2N2ZjOiAgICAg
ICAwMCA0NSAwMiBhMSAgICAgYTEwMjQ1MDAgICAgICAgIG1lbWIocjIrIzApID0gcjUNCiAgICA2
ODAwOiAgICAgICAwMiBjMCAwNCA5MSAgICAgOTEwNGMwMDIgICAgICAgIHIyID0gbWVtYihyNCsj
MCkgfQ0KDQpUaGUgdnNhdCBpbnN0cnVjdGlvbiByZXF1aXJlcyBhIHZlY3RvciBjb250ZXh0LiAg
SWYgdGhlIHRocmVhZCBkb2Vzbid0IGhhdmUgYSB2ZWN0b3IgY29udGV4dCwgYW4gZXhjZXB0aW9u
IHdpbGwgYmUgcmFpc2VkLiAgVGhlIE9TIGNhbiBwcm92aWRlIGEgY29udGV4dCBhbmQgcmVwbGF5
IHRoZSBwYWNrZXQuDQoNCj4gSSB0aGluayB5b3UgbWF5IG5lZWQgdG8gZG8gbW9yZSBwcmVwcm9j
ZXNzaW5nIG9mIHRoZSBlbnRpcmUgcGFja2V0IHNvIHRoYXQNCj4geW91DQo+IGNhbiBhbnN3ZXIg
dGhpcyBzb3J0IG9mIHF1ZXN0aW9uIChpcyB0aGVyZSBhbnkgb3RoZXIgcG9zc2libGUgZXhjZXB0
aW9uKSB3aGVuDQo+IGdlbmVyYXRpbmcgY29kZS4NCj4NCj4gPiAzKSBIb3cgaW1wb3J0YW50IGlz
IGl0IHRvIHN1cHBvcnQgYmlnIGVuZGlhbiBob3N0cz8gIFdvdWxkIGl0IGJlIE9LIHRvIHB1dA0K
PiBzb21ldGhpbmcgbGlrZSB0aGlzIHRvIGRlY2xhcmUgaXQgaXNuJ3Qgc3VwcG9ydGVkIGZvciBI
ZXhhZ29uPw0KPiA+ICNpZiBkZWZpbmVkKEhPU1RfV09SRFNfQklHRU5ESUFOKQ0KPiA+ICNlcnJv
ciBIZXhhZ29uIGd1ZXN0IG5vdCBzdXBwb3J0ZWQgb24gYmlnIGVuZGlhbiBob3N0DQo+ID4gI2Vu
ZGlmDQo+DQo+IFRoYXQgd291bGQgbWFrZSAuL2NvbmZpZ3VyZSAmJiBtYWtlIGZhaWwgb24gc3Vj
aCBhIGhvc3QuDQo+IFNvLCBubywgeW91IGNhbid0IGRvIHRoYXQuDQo+DQo+ID4NCj4gPiA0KSBJ
ZiB0aGUgYWJvdmUgaXMgbm90IE9LLCBhcmUgdGhlIG1hY3JvcyBpbiBic3dhcC5oIHRoZSBjb3Jy
ZWN0IG9uZXMgdG8NCj4gdXNlPyAgSXMgdGhpcyBwc2V1ZG8tY29kZSBjb3JyZWN0Pw0KPiA+IHN0
b3JlX3ZhbCA9IGxlMzJfdG9fY3B1KHN0b3JlX3ZhbCk7DQo+ID4gbG9hZF92YWwgPSBsZTMyX3Rv
X2NwdShsb2FkX3ZhbCk7DQo+ID4gPG1lcmdlIGJ5dGVzPg0KPiA+IC8qIHN0b3JlX3ZhbCBpcyBk
ZWFkIHNvIG5vIG5lZWQgdG8gY29udmVydCBiYWNrICovDQo+ID4gbG9hZF92YWwgPSBjcHVfdG9f
bGUzMihsb2FkX3ZhbCkNCj4NCj4gVGhlcmUncyBzb21lIG1pc3VzZSBvZiBjcHVfdG9fbGUzMiB2
cyBsZTMyX3RvX2NwdSB0aGVyZSAoSSd2ZSBuZXZlciBsaWtlZA0KPiB0aG9zZQ0KPiBuYW1lcywg
YnV0IGl0IGhlbHBzIHRvIHRoaW5rIGFib3V0IHdoYXQgZm9ybSB0aGUgZGF0YSBpcyBhbHJlYWR5
IGluKS4NCg0KU28sIHdoYXQgaXMgdGhlIHJpZ2h0IHNlcXVlbmNlPw0KDQoNClRoYW5rcywNClRh
eWxvcg0KDQo=

