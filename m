Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D0AC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 23:53:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67A9A20679
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 23:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TEG+pFJ4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="fjG+Vpk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A9A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB5EU-0005br-LU
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 19:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kB5DV-0004Kx-6X
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 19:52:33 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:40476)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kB5DT-0003Mb-GP
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 19:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598485951; x=1630021951;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=r/+fpRJcxQFgj8/WfelNbQw3FTa7idCWiwGKhhbN9D0=;
 b=TEG+pFJ4A6sRocaiIme0wRquE8dCYucAUGYJfXiSjsEzyVBPY9OUnYW7
 JklIke/spJwDyzhDs4iRsGEJYJGpfpYE1TkhjEP0cBZidZd6c//4ex2Wh
 Ku4T/z8x61yKMkq96WJAEUhEy0dlSaWhpzWxRAiP395vJ/R06d6E6oDiY o=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Aug 2020 16:52:30 -0700
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 26 Aug 2020 16:52:29 -0700
Received: from nasanexm03d.na.qualcomm.com (10.85.0.91) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Aug 2020 16:52:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 26 Aug 2020 16:52:29 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4952.namprd02.prod.outlook.com (2603:10b6:a03:45::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 26 Aug
 2020 23:52:16 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::6ce3:79e4:9697:313e]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::6ce3:79e4:9697:313e%3]) with mapi id 15.20.3305.031; Wed, 26 Aug 2020
 23:52:16 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 11/34] Hexagon (target/hexagon) register fields
Thread-Topic: [RFC PATCH v3 11/34] Hexagon (target/hexagon) register fields
Thread-Index: AQHWdXdgNcQCc4yNUEyOw6YH9VELlqlKf7KAgACGnpA=
Date: Wed, 26 Aug 2020 23:52:16 +0000
Message-ID: <BYAPR02MB4886E39B0134F22DFEC1A71DDE540@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-12-git-send-email-tsimpson@quicinc.com>
 <9116d651-9b54-1507-9723-d3a365812dc4@linaro.org>
In-Reply-To: <9116d651-9b54-1507-9723-d3a365812dc4@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49d248c8-f51c-49f1-da65-08d84a1b1017
x-ms-traffictypediagnostic: BYAPR02MB4952:
x-microsoft-antispam-prvs: <BYAPR02MB49524D510F2BA60FA00F2812DE540@BYAPR02MB4952.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dju7/6FUSw4LFb5MZgbPOHipGQX95f4Dz4daVmE8FtHmpGC5gZXyIxQH7QqITZhgZ+sGztALDCGpDze/vOLvl3qJ1taA5MToSM7ihNeMB/loFYmyr2Azv8Kfny/vHGDVd0LfbTWEc9KnDZxrntKrOlY0W2QfTe7k+E4k91fHE9hL8+ZWiKMYo4jgKyeejQWHECJ6IDV/rUoXosaTHdfBdf1wMSPtxttHpeY8wkLdzB7oBPtOhWb6Gv8ajOENxZz3Wt0WtmOubZIwNVoz5IB/Eomn4Qw8yGZtZpGdb4UdgqDy0jQmZQTNVTF6p4fOKu87
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(39860400002)(396003)(346002)(376002)(136003)(478600001)(6506007)(26005)(52536014)(71200400001)(5660300002)(83380400001)(186003)(86362001)(8936002)(53546011)(55016002)(54906003)(316002)(33656002)(9686003)(110136005)(7696005)(8676002)(64756008)(66946007)(2906002)(4326008)(66446008)(66476007)(66556008)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: w7uOKw+ULHT2zowsxNnewYGOHOxHDaR/0vlIcHesUVPziq+mqSMPocMp5lGFBr6x5t1sbCBX/FoEgYQYfbGpZiefYW+ifyrjFNGhNQgsE7g2E4TMNlf/+4dPMcZF89e35Fp/kqu3T+dWzlWsclQOB3dst5qSCJfHU/CollkJIJP+t6AjYcCswiTueyocmcYk6PfWRIwRk9vKLoPtAdf/n7Y3c4EocfEKYs+HKljAt+ryle8zqy5L9pIoRaxeZFgRd1nie1wYEcskA4atQYMUJM+moLK//QD75gQr9tpBu/Jk5tRrLr3JTtKTuL971qA79IM02aXTsS03N5EB5G/h4Sg1gbuxWDcN2sfnMbJvKeBdGGu7yPIvLGFBuQeYYtZ8MoePu55xgiX3MH4HcpzhpaPNjP2x0Dmnua+izm3UkIqktDHFH7DbBnrgnK39cOHHjuw1QvIv/3+oqHuZJOhJrWiYdWdK1XPcG3q6y0MqkhQ0ZUXegDeQvtwwOenjgpH1oLEsFYLk6FOXVaJkc1NFPexj93nqYvKXoeh/ZZIXe517E6RUEKQ3CHZo+WeliE8dxOplfpWLkldMwlNC4oqz0UQhF8Rqpg6erT8qYvDi7sc5OvwtPHwOLnBpmD4cTzSOJixr8Z+Iorjv2U70rwMyJQ==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Af0KzJGbbW/cZFtgNKMOIzoxxC+jT1znl2lzh7vO1yaRD1zKeTDpsoDHMK3NJJ3u/GdPRtjmcf7rLG5j6UGIto4E64QrGL/rBiJbu/557fHcaqYd60YeVZz1SMgSKJzUfFJwqFHM7w7dc8A2pBR7SQzL18OC1iDY0N9GzkYRBKlOxKkarJ7+6+j63xkXlpXWQ+ps8TCz5gPFRzbX9Bk+sO9Ejy9RF01Rn9fQEPH/0kXhfM/GCcLR3fZFEkczYqxtikDXfu92VOLT6J2OYZP3hAYurHl4JFId4rzjRw9kUn13eJpAiM4Lhzahtr2GKy8gjZdbYEAGABGIkB9KknzKnQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEln4UxtluhCqK7juM6zZKPYR6B4GUf3i35R0rCRqWM=;
 b=Q7LvrAVZJ14B8et35/vC0lyu1augsAv/Cbp1RI5sAyYlqXIA5DZv5ynKhpPay2TXnHh5456+OVIk+lAmMXb1dLi20+HfkKLaSj1h0xVZ8dX6UVzM9WBDs9dPl+39xAHJtYOi9ulPfCQrUYZLOCVKdljZYTtm0Hk9JXiGd2hQLaGWUHr8H1lEbGGGFCQvJ0uZMxqC7qv2yG1hOVdhiUazpjMM/RB8QHE6YVBwpxi56vWKydSjfQb0VHG10pnoR316JnqvOYfubo5anKmbdDvwp80hMIj7IRpJSltOtOVTj3MmUzXOgqiNiicQvipn7KwpqjLSAZGfM8AXlGUr3c/O1g==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEln4UxtluhCqK7juM6zZKPYR6B4GUf3i35R0rCRqWM=;
 b=fjG+Vpk+CysrCqnSZz9JdSKFiSE4whrjW58TIlyMHGWsOR1aczw4mMdYxErkwIwPWw1iG6JtRD1sMgcPX6VFrDXVoh05SSPDfP/6RdDjPdVg+PjGVCKQbi5o+P2Wwgj/IohmPiXUYbxW03+gl88RQ+QTy5J+iiEv//5/gnLAENY=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 49d248c8-f51c-49f1-da65-08d84a1b1017
x-ms-exchange-crosstenant-originalarrivaltime: 26 Aug 2020 23:52:16.5727 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: BVrPX3nItBj6G9hfQW9Sut8VC4Gk6qEGnEiYOV5aY1GnG1bg9cCpHLNOINRl8H8aX524bsrhArfbmYdNfeSgBg==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4952
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.39; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 19:52:04
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
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVn
dXN0IDI2LCAyMDIwIDg6MzAgQU0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWlj
aW5jLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGhpbG1kQHJlZGhhdC5jb207
IGxhdXJlbnRAdml2aWVyLmV1OyByaWt1LnZvaXBpb0Bpa2kuZmk7DQo+IGFsZWtzYW5kYXIubS5t
YWlsQGdtYWlsLmNvbTsgYWxlQHJldi5uZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAx
MS8zNF0gSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIHJlZ2lzdGVyIGZpZWxkcw0KPg0KPiA+ICsj
ZGVmaW5lIE5VTV9HRU5fUkVHUyAzMg0KPg0KPiBXaGF0J3MgdGhpcz8gIEl0IGRvZXNuJ3QgYXBw
ZWFyIHRvIGJlIGZpZWxkIHJlbGF0ZWQuDQoNCk5vdCBuZWVkZWQsIHdpbGwgcmVtb3ZlIGl0Lg0K
DQo+ID4gK2V4dGVybiByZWdfZmllbGRfdCByZWdfZmllbGRfaW5mb1tdOw0KPg0KPiBjb25zdC4N
Cg0KT0sNCg0KPiA+ICtlbnVtIHJlZ19maWVsZHNfZW51bSB7DQo+DQo+IERvZXNuJ3QgZm9sbG93
IG5hbWluZyBndWlkZWxpbmVzLiAgQnV0IHlvdSBkb24ndCBhY3R1YWxseSB1c2UgdGhlIG5hbWUg
YXQgYWxsLA0KPiBzbyBiZXR0ZXIgdG8ganVzdCBkcm9wIHRoZSBuYW1lIGVudGlyZWx5Pw0KDQpP
Sw0KDQo+ID4gKy8qIFVTUiBmaWVsZHMgKi8NCj4gPiArREVGX1JFR19GSUVMRChVU1JfT1ZGLA0K
PiA+ICsgICAgIm92ZiIsIDAsIDEsDQo+ID4gKyAgICAiU3RpY2t5IFNhdHVyYXRpb24gT3ZlcmZs
b3cgLSAiDQo+ID4gKyAgICAiU2V0IHdoZW4gc2F0dXJhdGlvbiBvY2N1cnMgd2hpbGUgZXhlY3V0
aW5nIGluc3RydWN0aW9uIHRoYXQgc3BlY2lmaWVzICINCj4gPiArICAgICJvcHRpb25hbCBzYXR1
cmF0aW9uLCByZW1haW5zIHNldCB1bnRpbCBleHBsaWNpdGx5IGNsZWFyZWQgYnkgYSBVU1I9UnMg
Ig0KPiA+ICsgICAgImluc3RydWN0aW9uLiIpDQo+DQo+IElzIHRoZSBkZXNjcmlwdGlvbiBhcyBh
IHN0cmluZyByZWFsbHkgdXNlZnVsLCBvciBldmVuIHVzZWQ/DQo+IEEgY29tbWVudCB3b3VsZCBz
ZWVtIHRvIGRvIGp1c3QgYXMgd2VsbCwgbm90IGNvbnN1bWUgc3BhY2UgaW4gdGhlIGZpbmFsDQo+
IGJpbmFyeSwNCj4gYW5kIGV2ZW4gdGhlbiBzZWVtcyByZWR1bmRhbnQgd2l0aCB0aGUgYWN0dWFs
IGFyY2hpdGVjdHVyZSBtYW51YWwuDQoNCkkgdGhvdWdodCB0aGV5IGhlbHAgbWFrZSB0aGUgY29k
ZSBtb3JlIHJlYWRhYmxlLiAgWW91IGFyZSByaWdodCB0aGF0IHRoZXkgc2hvdWxkbid0IHRha2Ug
c3BhY2UgaW4gdGhlIGJpbmFyeS4NCg0KSSBjYW4gZWl0aGVyIGNoYW5nZSBzbyB0aGV5IGRvbid0
IGdvIGludG8gdGhlIGJpbmFyeSBvciByZW1vdmUgdGhlbSBhbHRvZ2V0aGVyIC0gZ3Vlc3MgSSds
bCByZW1vdmUgdGhlbSBhbHRvZ2V0aGVyLg0K

