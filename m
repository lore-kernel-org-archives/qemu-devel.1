Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8DAC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 17:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A8B52054F
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 17:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZjCw2bDX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="C4wyq2tC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8B52054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCnJ5-0007tb-6x
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 13:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCnIP-0007OY-I7
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 13:08:41 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:43584)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCnIM-0005CG-QF
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 13:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598893718; x=1630429718;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mTeZk0245+5N3Rg2sz/yrxEyyJlyqFMx6QdA/AV+ooY=;
 b=ZjCw2bDXMjIdwIl44McoyUA4rl1QolJNuq/9tHEr4YgbezlJwtZDS6fd
 tQxm5sHwHxxKxdjjEDMu0Eiu4uizONQ8eVzJmqG1sdKSDTpgFKJnGKydB
 QMSd+Qow4RNiZlOaXg4jABZDfl3w/J0ZxZq0WmftVPbTuoOkBcuWk4gP9 E=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 31 Aug 2020 10:08:36 -0700
Received: from nasanexm03g.na.qualcomm.com ([10.85.0.49])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 31 Aug 2020 10:08:36 -0700
Received: from nasanexm03d.na.qualcomm.com (10.85.0.91) by
 nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 31 Aug 2020 10:08:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 31 Aug 2020 10:08:35 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4887.namprd02.prod.outlook.com (2603:10b6:a03:50::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Mon, 31 Aug
 2020 17:08:34 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01%7]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 17:08:34 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 30/34] Hexagon (target/hexagon) TCG for
 instructions with multiple definitions
Thread-Topic: [RFC PATCH v3 30/34] Hexagon (target/hexagon) TCG for
 instructions with multiple definitions
Thread-Index: AQHWdXdjR65U8vNpmEiviytk7eiWcalOZgsAgAK5LuCAABqagIAAAiTQgAAjBACAASHoAA==
Date: Mon, 31 Aug 2020 17:08:34 +0000
Message-ID: <BYAPR02MB4886D48EDC604CEEF65FDAA7DE510@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-31-git-send-email-tsimpson@quicinc.com>
 <10127f7e-a2df-2f19-e897-9a874f9a5d82@linaro.org>
 <BYAPR02MB488691F539AD3A2BFA1C819DDE500@BYAPR02MB4886.namprd02.prod.outlook.com>
 <a0987bce-409b-cd14-7559-c63413ff2b6f@linaro.org>
 <BYAPR02MB4886985CC5CBF78F7D5DBFE5DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
 <fca34122-160d-8c13-d237-a87a917f341b@linaro.org>
In-Reply-To: <fca34122-160d-8c13-d237-a87a917f341b@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96997479-e6a3-421a-85fe-08d84dd07edb
x-ms-traffictypediagnostic: BYAPR02MB4887:
x-microsoft-antispam-prvs: <BYAPR02MB4887CC9067C47ABE5EF32B37DE510@BYAPR02MB4887.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zvC0634wtPh1fvWVgT+qC0c1gX57U6ySnJgE2/56/1C4yWiabIsugSTKsLXn1R7BpXSLC3EnaVMFsF0ueSi5QJnaqXzUBS+eU28hVxZjE1jK0v1f+gPh52DufiXJWyvagWt4FTMntskprC+06de3OKrO3w3pIAby7Ba2Fs0JFaTo4Cp96gSMh498f0+SBI/4hZiU7VAYc++baeNy+SvxAKm7w9J664TznxEpDjbevZyGPjHgiB4JJ/UKFORyayCwckKeL/SIT7IebuXTfm983g0HOQHidukmVVkDBwR6NYegSOQ9jRB4Xe6jXxOHb4Pok9xi7WseSCPQtoa+p4I1xQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(366004)(346002)(136003)(39860400002)(396003)(186003)(26005)(7696005)(54906003)(64756008)(53546011)(6506007)(33656002)(110136005)(66446008)(316002)(5660300002)(9686003)(478600001)(71200400001)(55016002)(52536014)(2906002)(86362001)(8676002)(66556008)(66476007)(4326008)(76116006)(83380400001)(66946007)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: qya1xmv1yuJ/YnCKtPIhAdPCVEmCxxbMuyNgThxApfr7Gl1hi7s8MBrOXfRKDiPHb9BQnghkj6irEJ1gc1wkRE+GLd/vs+LfP1uhUXsT/C/2mQNLApHoT2MGTLMfejEHOB13d/Uvj7tH7yk6obJ6FZiLfyF+rh+k2AtHIjdRuygJGNEQT1Y3Ib1ECNkcP/incovoebkPT9lhrz3kyBSZo3X1czWydZAX0c+SSFnPsDQu97F4TlvntDpRm+sjOFU+tymwa2L7paNlzsUmzJY1BPW7gchWU+8F/z+9GfQ1XEtfXoo76k2gdCPC4AahPD5XmreaZwUTUQQHXgyWA/dmKy6XKu0im7c19hcccV5UHNseFTFgSIGTSR78Y+n6GHP5IO0prUK5IEVy1bfDCI9cpxoOWFiDde9QcSkllSQVQiqf2Q8nzawQhy5bEQW+aTFFKvGFtRfvl3VNyrnDwlI1nDgX4l5j3E4R/w2w7X67g5+7TIafx84hblBIhz9iJoJ4AEsy4ARFuz/lg9BGPDsBzbg/KnFF45KgmfDgZninCq2zGCipwPRoTLoqVHdn0xRnuKvgiH55TpgoH/pogQXNNOE9lSVR+KvMJnGAluRdEszj8NneqauVjPPkKKtQgChNJ+V+4MAZYuXl4V4JKODBXw==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ih7U3IZRyw+BvS6SKtkmw6dcqcSM8yYsX/aC/pIp+lXrli74HX4EMbFDECnOmD/qNMDG2JKp2DcXQwmikj6gRLgJd69EmCQCg2thAGfPGaviV69IqzKGWigpU0g0rn4qqALrhtGxlshxKUbIIVzEI/ddY38Ps71dWg0HV63zKSArzKxZA+dU1BI54pZ/qQl9YQC/G9RpGUV3Wf5rnwxk20yb+VANVca2sLuFcXjqZCb1+60vc/3f5fRfjcOum+nhbxPeyn4mCnSgXu4ltLJ72LcfO4O2KAYUYwY5jgAirbNd5Fr8wOOYMu66P7xe8ynH7iWuuzgUedrNWh9siPCwcA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGABKzGUtZEpXr16VVHOl7I94TbZa2JmK75a0M2rzNE=;
 b=UAL4W09nkMuYyUvLHm9A/oztc1kxMPhsZXHnIaIyS4lTo2VixoHLA21JD2LdKvKoFLDQW46SCeLcl6mqxE2YDCIEWu67dj9owJugLJuyyW452kQ6lUl9Ql5C8RaYA6oM0kcDbWOncxXNr3t4G4AtXcv5omJTp11gtLwhvZQESOw9DS/pv2pb+5aCJrKZPvPCrYTg5QTftB6jtq/NFS+lyhz8F43dExGfqVWRdSVTtqToQoJCRkK81BkN4BUog4de9iRhiR3n7UsYSp+sOUreB80rv2E8ECE9FtuW5PdoE/KvNi+ns/3te+bzsZe7zJcTFpHO65UId/PiCBOun5B+0g==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGABKzGUtZEpXr16VVHOl7I94TbZa2JmK75a0M2rzNE=;
 b=C4wyq2tCywT/2At0zRxMu6ZwHw864MayYIIDa1Qu0Rxolev1Ud71nWvkayso/Q0k9GP+vJGpWZwyQL4YbjcT/RKfZg9fH5evwh23kIgOD9vaxp3EQmoRAKLmZInxYWcINRklZqW8VsSUfAQ6isjrqRwCRslQ5fjuWULzd2sC8JA=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 96997479-e6a3-421a-85fe-08d84dd07edb
x-ms-exchange-crosstenant-originalarrivaltime: 31 Aug 2020 17:08:34.7958 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: +V/D7SJn4RQWHqF+UM9wQmDORdL4c+y2CwsFB07l5yRc2ADKE8SbMsP74wFnxCmTreL527VCDgUj6F9wNMqSOg==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4887
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.38; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 13:08:37
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

DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IFJpY2hhcmQgSGVu
ZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPg0KPiA+PiBTZW50OiBTdW5kYXks
IEF1Z3VzdCAzMCwgMjAyMCAzOjEzIFBNDQo+ID4+IFRvOiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBz
b25AcXVpY2luYy5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gPj4gQ2M6IHBoaWxtZEBy
ZWRoYXQuY29tOyBsYXVyZW50QHZpdmllci5ldTsgcmlrdS52b2lwaW9AaWtpLmZpOw0KPiA+PiBh
bGVrc2FuZGFyLm0ubWFpbEBnbWFpbC5jb207IGFsZUByZXYubmcNCj4gPj4gU3ViamVjdDogUmU6
IFtSRkMgUEFUQ0ggdjMgMzAvMzRdIEhleGFnb24gKHRhcmdldC9oZXhhZ29uKSBUQ0cgZm9yDQo+
ID4+IGluc3RydWN0aW9ucyB3aXRoIG11bHRpcGxlIGRlZmluaXRpb25zDQo+ID4+DQo+ID4+IE9u
IDgvMzAvMjAgMTI6NDggUE0sIFRheWxvciBTaW1wc29uIHdyb3RlOg0KPiA+Pj4gSSdsbCBhZGQg
dGhlIGZvbGxvd2luZyBjb21tZW50IHRvIGluZGljYXRlIHdoYXQncyBnb2luZyBvbg0KPiA+Pj4N
Cj4gPj4+IC8qDQo+ID4+PiAgICogRWFjaCBvZiB0aGUgZ2VuZXJhdGVkIGhlbHBlcnMgaXMgd3Jh
cHBlZCB3aXRoICNpZm5kZWYNCj4gPj4gZkdFTl9UQ0dfPHRhZz4uDQo+ID4+PiAgICogRm9yIGV4
YW1wbGUNCj4gPj4+ICAgICogICAgICNpZm5kZWYgZkdFTl9UQ0dfQTJfYWRkDQo+ID4+PiAgICAq
ICAgICBERUZfSEVMUEVSXzMoQTJfYWRkLCBzMzIsIGVudiwgczMyLCBzMzIpDQo+ID4+PiAgICAq
ICAgICAjZW5kaWYNCj4gPj4+ICAgKiBXZSBpbmNsdWRlIGdlbl90Y2cuaCBoZXJlIHRvIHByb3Zp
ZGUgZGVmaW5pdGlvbnMgb2YgZkdFTl9UQ0cgZm9yDQo+IGFueQ0KPiA+PiBpbnN0cnVjdGlvbnMg
dGhhdA0KPiA+Pj4gICAqIGFyZSBvdmVycmlkZGVuLg0KPiA+Pj4gICAqDQo+ID4+PiAgICogVGhp
cyBwcmV2ZW50cyB1bnVzZWQgaGVscGVycyBmcm9tIHRha2luZyB1cCBzcGFjZSBpbiB0aGUgZXhl
Y3V0YWJsZS4NCj4gPj4+ICAgKi8NCj4gPj4NCj4gPj4gQWgsIGh1bS4gIFdlbGwuDQo+ID4+DQo+
ID4+IEhvdyBhYm91dCB3ZSBmaWd1cmUgb3V0IGEgd2F5IHRvIGNvbW11bmljYXRlIHRvIHRoZSBn
ZW5lcmF0b3Igc2NyaXB0cw0KPiA+PiB3aGljaA0KPiA+PiBmdW5jdGlvbnMgaGF2ZSBiZWVuIGlt
cGxlbWVudGVkICJkaXJlY3RseSIsIGFuZCBkb24ndCBuZWVkIHRvIGJlDQo+ID4+IGdlbmVyYXRl
ZCBhdCBhbGw/DQo+ID4+DQo+ID4+IEkgZG9uJ3Qgc2VlIHdoeSB3ZSBoYXZlIHRvIHdhaXQgdW50
aWwgdGhlIGMgcHJlcHJvY2Vzc29yIHRvIHJlbW92ZSB0aGlzDQo+ID4+IHVudXNlZA0KPiA+PiBj
b2RlLCBhbmQgdGhlIGxlc3Mgd2UgaGF2ZSBvZiBpdCwgdGhlIGJldHRlci4NCj4gPj4NCj4gPg0K
PiA+IEEgZmV3IHJlYXNvbnMNCj4gPiAtIE1ha2VzIGl0IGVhc3kgdG8gb3ZlcnJpZGUgaW5zdHJ1
Y3Rpb24gaGVscGVycy4gIEFsbCBvbmUgaGFzIHRvIGRvIGlzICNkZWZpbmUNCj4gZkdFTl9UQ0df
PHRhZz4uDQo+DQo+IElmIHRoZSBnZW5lcmF0b3IgY2FuIGV4YW1pbmUsIHNheSwgZ2VucHRyX292
ZXJyaWRlLmMuaW5jLCB0aGVuIHlvdSBkb24ndA0KPiBldmVuDQo+IGhhdmUgdG8gYWRkIGEgI2Rl
ZmluZS4gIEp1c3QgYWRkIHRoZSBjb2RlLg0KPg0KPiBQZXJoYXBzIHNvbWV0aGluZyBsaWtlDQo+
DQo+IERFRklORV9GR0VOKHRhZykNCj4gew0KPiAgICAgLy8gc29tZSBjb2RlDQo+IH0NCj4NCj4g
d2hlcmUgREVGSU5FX0ZHRU4gZXhwYW5kcyB0byB0aGUgYXBwcm9wcmlhdGUgZnVuY3Rpb24gZGVj
bGFyYXRpb24uICBUaGUNCj4gZ2VuZXJhdG9yIHRoZW4gbmVlZCBvbmx5IGdyZXAgJ15ERUZJTkVf
RkdFTicgYW5kIGV4dHJhY3QgdGhlIGxpc3Qgb2YNCj4gb3ZlcnJpZGRlbg0KPiB0YWdzLg0KPg0K
Pg0KPiA+IC0gV2hlbiBkZWJ1Z2dpbmcgdGhlIG92ZXJyaWRlLCBzb21ldGltZXMgeW91IHdhbnQg
dG8gcXVpY2tseSByZXZlcnQgYmFjaw0KPiB0byB0aGUgaGVscGVyLiAgT3IgaWYgeW91J3ZlIHdy
aXR0ZW4gYSBidW5jaCBvZiBvdmVycmlkZXMgaW4gb25lIHNob3QgYW5kIHRoZW4NCj4gZmluZCB0
aGF0IGEgdGVzdCBjYXNlIGlzIGZhaWxpbmcsIHlvdSBjYW4gYmluYXJ5IHNlYXJjaCB3aGljaCBv
bmUgdG8gdHVybiBvZmYgYW5kDQo+IGdldCB0aGUgdGVzdCB0byBwYXNzLiAgVGhpcyBpcyB0aGUg
b25lIHdpdGggdGhlIGJ1ZyB0byBmaXguDQo+DQo+IE5vIGRpZmZlcmVuY2UgdGhlcmUsIGp1c3Qg
YmluYXJ5IHNlYXJjaGluZyBvbiBkaWZmZXJlbnQgdGV4dC4NCj4NCj4gPiAtIFJlZHVjZXMgdGlt
ZSBmb3IgYW4gaW5jcmVtZW50YWwgYnVpbGQuICBXaGVuIHdlIGFkZCBvciBkZWxldGUgYW4NCj4g
b3ZlcnJpZGUsIHdlIGRvbid0IGhhdmUgdG8gcmUtcnVuIHRoZSBnZW5lcmF0b3IuDQo+DQo+IEFi
b3V0IHRoaXMgSSBjYXJlIG5vdCBhdCBhbGwuICBJIGNhbid0IGltYWdpbmUgdGhhdCBtb3JlIHRo
YW4gZnJhY3Rpb25zIG9mIGENCj4gc2Vjb25kIGFyZSBhdCBzdGFrZS4NCg0KSSBjYW4gbW9kaWZ5
IHRoZSBnZW5lcmF0b3IgdG8gc2tpcCBpbnN0cnVjdGlvbnMgd2l0aCBvdmVycmlkZXMuDQoNClRo
ZXJlIGFyZSBzb21lIGFzc3VtcHRpb25zIGhlcmUgSSdkIGxpa2UgdG8gY2xhcmlmeS4gIFdoZW4g
SSBzdGFydGVkIHRoaXMgZGlzY3Vzc2lvbiwgdGhlcmUgc2VlbWVkIHRvIGJlIGdlbmVyYWwgcmVz
aXN0YW5jZSB0byB0aGUgY29uY2VwdCBvZiBhIGdlbmVyYXRvci4gIEJlY2F1c2Ugb2YgdGhpcywg
SSBtYWRlIHRoZSBnZW5lcmF0b3IgYXMgc2ltcGxlIGFzIHBvc3NpYmxlIGFuZCBwdXNoZWQgdGhl
IGNvbXBsZXhpdHkgYW5kIG9wdGltaXphdGlvbiBpbnRvIGNvZGUgdGhhdCBjb25zdW1lcyB0aGUg
b3V0cHV0IG9mIHRoZSBnZW5lcmF0b3IuICBBbHNvLCBJIGFzc3VtZWQgcGVvcGxlIHdvdWxkbid0
IHJlYWQgdGhlIG91dHB1dCBvZiB0aGUgZ2VuZXJhdG9yLCBzbyBJIGRpZG4ndCBmb2N1cyBvbiBt
YWtpbmcgaXQgcmVhZGFibGUuDQoNCk5vdywgaXQgc291bmRzIGxpa2UgbXkgYXNzdW1wdGlvbnMg
d2VyZSBub3QgY29ycmVjdC4gIFlvdSBwb2ludGVkIG91dCB0d28gdGhpbmdzIHRvIGRvIGluIHRo
ZSBnZW5lcmF0b3INCi0gRXhwYW5kIHRoZSBtYWNyb3MgaW5saW5lDQotIFNraXAgdGhlIGluc3Ry
dWN0aW9ucyB0aGF0IGhhdmUgb3ZlcnJpZGVzDQpJIGFkZGl0aW9uLCB0aGVyZSBvdGhlciB0aGlu
Z3MgSSBzaG91bGQgZG8gaWYgd2Ugd2FudCB0aGUgZ2VuZXJhdGVkIGZpbGVzIHRvIGJlIG1vcmUg
cmVhZGFibGUNCi0gSW5kZW50IHRoZSBjb2RlDQotIE9ubHkgZ2VuZXJhdGUgb25lIG9mIHRoZSBm
R0VOX1RDR188dGFnPiBvciBnZW5faGVscGVyXzx0YWc+DQotIEdlbmVyYXRlIHRoZSBkZWNsYXJh
dGlvbiBvZiB0aGUgZ2VuZXJhdGVfPHRhZz4gZnVuY3Rpb24gaW5zdGVhZCBvZiBqdXN0IHRoZSBi
b2R5DQoNClRob3VnaHRzPw0KDQpUaGFua3MsDQpUYXlsb3INCg0K

