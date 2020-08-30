Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1221BC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 20:05:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A35206CD
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 20:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MXq2P4Aw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="eIYOKQwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A35206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCTZy-0001AN-W2
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 16:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCTZ9-0000id-OV
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 16:04:39 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:1898)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCTZ6-00008r-Mz
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 16:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598817876; x=1630353876;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VYZk6ACIcaut4hW5Rt8yJKKjLT3QHfKughf64ORqKBg=;
 b=MXq2P4AwXerDpfsJbPYTtp5tW2Yiid7vD7EBUOOToKOwk3YEqWgoh87w
 C/4zaWH2AoGSh9mFN/TPTXiq7IDreHnqqjVZHRkvZamR8uO9+zkt0iI5G
 1gEb/SJSyygCHZZcsGkea+KS7Z3EEX77PlTf6HURTUCTNHifuf0D3guoe s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Aug 2020 13:04:34 -0700
Received: from nasanexm03b.na.qualcomm.com ([10.85.0.98])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 30 Aug 2020 13:04:34 -0700
Received: from nasanexm03d.na.qualcomm.com (10.85.0.91) by
 nasanexm03b.na.qualcomm.com (10.85.0.98) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 30 Aug 2020 13:04:34 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Sun, 30 Aug 2020 13:04:33 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4454.namprd02.prod.outlook.com (2603:10b6:a03:5f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Sun, 30 Aug
 2020 20:04:31 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01%7]) with mapi id 15.20.3326.025; Sun, 30 Aug 2020
 20:04:31 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 27/34] Hexagon (target/hexagon) instruction classes
Thread-Topic: [RFC PATCH v3 27/34] Hexagon (target/hexagon) instruction classes
Thread-Index: AQHWdXdg9knK9BVDxk2hljYrwtzUgKlOXueAgALEpSA=
Date: Sun, 30 Aug 2020 20:04:31 +0000
Message-ID: <BYAPR02MB4886388669CF07A410A251DCDE500@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-28-git-send-email-tsimpson@quicinc.com>
 <e360439e-7d6b-72eb-e5dd-026623e498b5@linaro.org>
In-Reply-To: <e360439e-7d6b-72eb-e5dd-026623e498b5@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d96dde6a-96e8-4b7f-2942-08d84d1fe8c7
x-ms-traffictypediagnostic: BYAPR02MB4454:
x-microsoft-antispam-prvs: <BYAPR02MB4454A44143CC52CCFA1FA317DE500@BYAPR02MB4454.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MLQmPfrbvYpzVLkvornr21RmoLHgf+EsdZHp7t2Xcv4kOE7VjuJ+TLZWDgQettrH0DLBUZhw3C/iCg99B/+2v/Yg+o+znfmz/9LPVZtj+o+gCOQcxMDio8Af4W7t3rlmqomHcbq649cjPjVUFu4Qdra/cqHL67FzYpvlXBcW+zZwMaMuofEo2Vg0y2pUdzQE19UaOJ+dCClodBFzUBQU+PVtQ2Rm3yFfGv+hEv/wdqu6Y56CfvoLDoiOTqvTtC24690jTU+goukDJwX2hgsOjwmxBwKkxvcAJzyoaAns+OcrtZzuPiMA5Uh3yNNTY2uGYx/ymMqD2UPrgatP19iPPw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39850400004)(396003)(136003)(376002)(346002)(366004)(4326008)(186003)(33656002)(7696005)(52536014)(8676002)(55016002)(53546011)(26005)(66476007)(6506007)(5660300002)(86362001)(8936002)(64756008)(66446008)(76116006)(66946007)(66556008)(2906002)(9686003)(71200400001)(316002)(478600001)(110136005)(54906003)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: RBS+/2Rniu11TsI2alS6/CJ2tTnmdwypttV4nBcCz0A/ra6q0S84A4kkQ2rHEK0p4YA5KSxx/hiUXIi+MgFK0OLBONWcbFnRxQ8nlAUQhl+zONA1fMeBdYUyKFihxOEjzECqFbYZ8KaiIzTglst4bESNVFq4ZJHwAHGNw8Y6lhj18ZslC/rVKKIriTMtMybIjSZ/NwrgWAQuJL9ZDKF9Yfq5YcCKC8s73nM5PWY3+vEleq4taUnsnwvUW1QTqePGgRnxqT4lT4nARF+i3wIbC214dTM/zLb3g9a6sp3dw72+t/M1KUV2PYb8MsDjp4GoAACb325g9ne+0pekB68Hlf3aCIHnPD15g2TQJTR75p/ZmiOKAZ0BBLFqr+gKJ4FOFK4Eexf7e23egx91x2/keZtDvLUGmFbNvZ/ntB+OGJ2SwC+swZKZbUXOtVIESzUgUbrRlneFILakQ3LAKiNlsXTzk14R8nl/gMQ4apy8CY6mfLGZgH2ubBBLgXVNX13H6XKiVG+9zcWHSCHWJV+iPB09et8LvUCgavJLdtg3f4QSI03sGpB0mnWokCkkuWdsEWtCMmqLQA0lQBH6C1YEB3qMXbR7FwZ1GhJ5nHMr/yc7ljuKCgVnFcUC1uZvAjXn6A+ahvSQ9lisn50l0rl+jg==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNpjG3P5HWDT3klk42YXVkv0lf5LxrcVGhmGF30tGSKE2ITuDE/7peWmqqIJkRH+MlCsOlqkujOzuzIt+pWsXzOStdYrg5CddLGKVWKxPMc+tEc+RVIQyq12Ea17+w8yEr6v5L7J3FksMu4xLNYrD1et7kobmm8uDJUDHho7FMmfit48fgeJTcNHGaubLasYGH+d5es9O0g26HsxeoFZm5Bka0d0QeQJ8zsABLPREweiLs3bSz/A3miQxigvcznyXet14wmeDsZAiYc4yBeKogN/pe00/AHw00u6SipZeqkFMxZSSEHTroTrSuXikm9tccNgNYXDfXgNiU4X/LOFBQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqBCm0ycWh24PiDgl4Q3s1ntl+l9SWcou+RKTgFz5Ww=;
 b=ODPAryaTPodSZ9gseKZSAENmGdcj/ZEv60l4rCS7BCnMljyNXUa/1cQJ/ayhJatn9J/keOqvJRXa122XVgcpb+5YYbGvQfE6CJCsf4zrce3my8ABd9BL6tRKg+Hc7bxJOtJnHT3cW+BQgPjdAm5Zebd1VmfS3Y6I113I7zDNCHhFjHEI2aZ57toFxK6dsrdXOKc/sfxMHG4l6eevXz4gdrDnsao9MtfhgriTYw0eHqDYsD7pFS4lhAdvkcwMgqNzwf6qeU+kjp9OYGxhF//pNxcXd72cbAK/QIW0VDXfdNNqrONLvPT0PCWamcUKVG04r+FdM9YIt5rSwe8b2HOUcA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqBCm0ycWh24PiDgl4Q3s1ntl+l9SWcou+RKTgFz5Ww=;
 b=eIYOKQwY2MyzBOkAMHZo3dQS7cilC/H5B2UzthH8WZ2ooox1G11+c7SWNVs3swd/22iYRkejiEMNGQ0hdxpQ+HxFeQMLl/8+mH3bNnw/tLjaXEwqMSSUN60UcBrkEEHgrqozSEnwSGpi9+iw2R5iRY9KgOvMUxmfz06TCLJJDto=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: d96dde6a-96e8-4b7f-2942-08d84d1fe8c7
x-ms-exchange-crosstenant-originalarrivaltime: 30 Aug 2020 20:04:31.6617 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: bEXYmSS4Yl++z5TKgLYg/Z9+0f2dmnrtsqxj5JNpK1dpdMIy65y4vpIfIaBX00CLbDAbGrhwOujzfTetm0ortA==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4454
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.38; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/30 15:37:55
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
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0
IDI4LCAyMDIwIDc6MzcgUE0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5j
LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGhpbG1kQHJlZGhhdC5jb207IGxh
dXJlbnRAdml2aWVyLmV1OyByaWt1LnZvaXBpb0Bpa2kuZmk7DQo+IGFsZWtzYW5kYXIubS5tYWls
QGdtYWlsLmNvbTsgYWxlQHJldi5uZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAyNy8z
NF0gSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIGluc3RydWN0aW9uDQo+IGNsYXNzZXMNCj4NCj4g
T24gOC8xOC8yMCA4OjUwIEFNLCBUYXlsb3IgU2ltcHNvbiB3cm90ZToNCj4gPiArfSBpY2xhc3Nf
dDsNCj4gLi4uDQo+ID4gK2V4dGVybiBjb25zdCBjaGFyICpmaW5kX2ljbGFzc19zbG90cyhvcGNv
ZGVfdCBvcGNvZGUsIGludCBpdHlwZSk7DQo+IC4uLg0KPiA+ICt0eXBlZGVmIHN0cnVjdCB7DQo+
ID4gKyAgICBjb25zdCBjaGFyICogY29uc3Qgc2xvdHM7DQo+ID4gK30gaWNsYXNzX2luZm9fdDsN
Cj4NCj4gSSdsbCBub3RlIHRoYXQgeW91IGFyZW4ndCBmb2xsb3dpbmcgb3VyIENPRElOR19TVFlM
RSBmb3IgdHlwZXMuICBXaGljaCBvZg0KPiB0aGVzZQ0KPiBuZWVkIHRvIG1hdGNoIGltcG9ydGVk
LyBhbmQgd2hpY2ggY2FuIHlvdSBmaXguDQoNClNvLCB0aGlzIHNob3VsZCBiZSBDYW1lbENhc2U/
ICBJIHNob3VsZCBiZSBhYmxlIHRvIGZpeCBhbGwgb2YgdGhlbS4NCg0KPg0KPiA+ICt0eXBlZGVm
IGVudW0gew0KPiA+ICsNCj4gPiArI2RlZmluZSBERUZfUFBfSUNMQVNTMzIoVFlQRSwgU0xPVFMs
IFVOSVRTKQ0KPiBJQ0xBU1NfRlJPTV9UWVBFKFRZUEUpLA0KPiA+ICsjZGVmaW5lIERFRl9FRV9J
Q0xBU1MzMihUWVBFLCBTTE9UUywgVU5JVFMpICAgIC8qIG5vdGhpbmcgKi8NCj4gPiArI2luY2x1
ZGUgImltcG9ydGVkL2ljbGFzcy5kZWYiDQo+ID4gKyN1bmRlZiBERUZfUFBfSUNMQVNTMzINCj4g
PiArI3VuZGVmIERFRl9FRV9JQ0xBU1MzMg0KPiA+ICsNCj4gPiArI2RlZmluZSBERUZfRUVfSUNM
QVNTMzIoVFlQRSwgU0xPVFMsIFVOSVRTKQ0KPiBJQ0xBU1NfRlJPTV9UWVBFKFRZUEUpLA0KPiA+
ICsjZGVmaW5lIERFRl9QUF9JQ0xBU1MzMihUWVBFLCBTTE9UUywgVU5JVFMpICAgIC8qIG5vdGhp
bmcgKi8NCj4gPiArI2luY2x1ZGUgImltcG9ydGVkL2ljbGFzcy5kZWYiDQo+ID4gKyN1bmRlZiBE
RUZfUFBfSUNMQVNTMzINCj4gPiArI3VuZGVmIERFRl9FRV9JQ0xBU1MzMg0KPg0KPiBBbnkgcGFy
dGljdWxhciByZWFzb24gd2h5IHlvdSdyZSBkZWZpbmluZyBvbmUgYXMgbm90aGluZywgYW5kIGRv
aW5nIHRoaXMNCj4gZGFuY2UNCj4gdHdpY2U/DQoNCldpbGwgaW52ZXN0aWdhdGUuDQoNCj4gPiAr
Y29uc3QgY2hhciAqZmluZF9pY2xhc3Nfc2xvdHMob3Bjb2RlX3Qgb3Bjb2RlLCBpbnQgaXR5cGUp
DQo+ID4gK3sNCj4gPiArICAgIC8qIFRoZXJlIGFyZSBzb21lIGV4Y2VwdGlvbnMgdG8gd2hhdCB0
aGUgaWNsYXNzIGRpY3RhdGVzICovDQo+ID4gKyAgICBpZiAoR0VUX0FUVFJJQihvcGNvZGUsIEFf
SUNPUCkpIHsNCj4gPiArICAgICAgICByZXR1cm4gIjIiOw0KPg0KPiBXaHkgYXJlIHlvdSByZXR1
cm5pbmcgYSBzdHJpbmcgYW5kIG5vdCBhIHNpbXBsZSBiaXRtYXNrPw0KDQpXaWxsIGZpeA0KDQo+
ID4gKyAgICBbSUNMQVNTX0ZST01fVFlQRShUWVBFKV0gPSB7IC5zbG90cyA9ICNTTE9UUyB9LA0K
Pg0KPiBUaGlzIGNvdWxkIGJlIGNvbnZlcnRlZCB0byB0aGUgYml0bWFzayB3aXRoDQo+DQo+IGVu
dW0gew0KPiAgICAgU0xPVFNfMCAgPSAoMSA8PCAwKSwNCj4gICAgIFNMT1RTXzEgID0gKDEgPDwg
MSksDQo+ICAgICBTTE9UU18yMyA9ICgxIDw8IDIpIHwgKDEgPDwgMyksDQo+ICAgICAuLi4NCj4g
fTsNCj4NCj4gc3RhdGljIGNvbnN0IHVpbnQ4X3QgaWNsYXNzX2luZm9bXSA9IHsNCj4NCj4gI2Rl
ZmluZSBERUZfSUNMQVNTKFRZUEUsIFNMT1RTKSBcDQo+ICAgICBbSUNMQVNTXyMjVFlQRV0gPSBT
TE9UU18jI1NMT1RTDQo+ICNkZWZpbmUgREVGX1BQX0lDTEFTUzMyKFRZUEUsIFNMT1RTLCBVTklU
UykgXA0KPiAgICAgREVGX0lDTEFTUyhUWVBFLCBTTE9UUykNCj4gI2RlZmluZSBERUZfRUVfSUNM
QVNTMzIoVFlQRSwgU0xPVFMsIFVOSVRTKSBcDQo+ICAgICBERUZfSUNMQVNTKFRZUEUsIFNMT1RT
KQ0KPg0KPiBBdCB3aGljaCBwb2ludCB0aGUgdWx0aW1hdGUgY29uc3VtZXIsDQo+DQo+ID4gICAg
IGZvciAoaSA9IDAsIHNsb3QgPSAzOyBpIDwgcGt0LT5udW1faW5zbnM7IGkrKykgew0KPiA+ICAg
ICAgICAgdmFsaWRfc2xvdF9zdHIgPSBnZXRfdmFsaWRfc2xvdF9zdHIocGt0LCBpKTsNCj4gPg0K
PiA+ICAgICAgICAgd2hpbGUgKHN0cmNocih2YWxpZF9zbG90X3N0ciwgJzAnICsgc2xvdCkgPT0g
TlVMTCkgew0KPiA+ICAgICAgICAgICAgIHNsb3QtLTsNCj4gPiAgICAgICAgIH0NCj4gPiAgICAg
ICAgIHBrdC0+aW5zbltpXS5zbG90ID0gc2xvdDsNCj4NCj4gYmVjb21lcyBhIHNpbXBsZSBpbnRl
Z2VyIG1hc2sgY2hlY2suDQoNCldpbGwgZml4DQo=

