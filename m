Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD1CC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:12:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9C502076A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dk76m2AA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="G/uD3i8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C502076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLzB-0006Gz-K0
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kNLyC-00059N-2d
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:11:28 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:40865)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kNLy9-0002Um-E6
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1601410285; x=1632946285;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mWcIuqPwGu9iRU2oU5jezL4u/sss1Dy2gHhYOCT1YdQ=;
 b=dk76m2AAAljlVN6DFsvIwpCB9pyZkxw0PkDv6iXOGDI+k3H78vTX3ROx
 op7L84QyAP/arZtlx4CRIzzs4gMT4ACVZxuyhCVAzbWupLut9rCwvwJaR
 IuHIe/QMHRzgqWlHIsTShrpIA9E2k3dytMcPVy/mR7REctG11mwVgxWUB 4=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Sep 2020 13:11:23 -0700
X-QCInternal: smtphost
Received: from nasanexm03a.na.qualcomm.com ([10.85.0.103])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 29 Sep 2020 13:11:23 -0700
Received: from nasanexm03b.na.qualcomm.com (10.85.0.98) by
 nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 29 Sep 2020 13:11:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03b.na.qualcomm.com (10.85.0.98) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Tue, 29 Sep 2020 13:11:22 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BY5PR02MB6657.namprd02.prod.outlook.com (2603:10b6:a03:211::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 29 Sep
 2020 20:11:20 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c%6]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 20:11:20 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v4 00/29] Hexagon patch series
Thread-Topic: [RFC PATCH v4 00/29] Hexagon patch series
Thread-Index: AQHWlbze9UuGeVhliU69LxBcqNXciKl/iuoAgAA551CAABQkAIAAJ9TQ
Date: Tue, 29 Sep 2020 20:11:20 +0000
Message-ID: <BYAPR02MB4886C114AAC9DDEF70300D23DE320@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1601314138-9930-1-git-send-email-tsimpson@quicinc.com>
 <c4307aa4-f194-a02f-a4db-90b546a6024a@amsat.org>
 <BYAPR02MB4886C5014B1012371DE0DCDFDE320@BYAPR02MB4886.namprd02.prod.outlook.com>
 <8f684258-8b41-ee3b-8921-41693113c1f1@amsat.org>
In-Reply-To: <8f684258-8b41-ee3b-8921-41693113c1f1@amsat.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amsat.org; dkim=none (message not signed)
 header.d=none;amsat.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc27328f-f9ba-4cde-f117-08d864b3d4c7
x-ms-traffictypediagnostic: BY5PR02MB6657:
x-microsoft-antispam-prvs: <BY5PR02MB6657763D60F1823FFFB81775DE320@BY5PR02MB6657.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:409;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 26kU5KrBe2L7bX8wanm+OlV/Ib+9vLaC2QhLXpcUkb74Pm+kOji3A2hcBD0SYXWBs5m7V75eHtnJapUEb90WKt70W8thE2+bquNRxfdpsHH0EPMAnSEbRdfZM3Gg43jJUZHpCVKeV/rmFlHArm3VEYk4S8OaghdXmVcgyIrxGwK39xiPBs13kZwMmivc+gMAoKjkULgsZF9oy4bBJWWn6G7zKSE6GKCDOqJ2ZoH92tw9r55Eto08zvw/ZfnOXWVOl4woMO5YY5U8CiuFROe1i4JfJlIsCXtWhDvWwpc9pzg7kIS2kuCd/l2ujZrSb62Va87oPgU8FRZGaogTwuZOkg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(136003)(396003)(39850400004)(366004)(376002)(33656002)(86362001)(71200400001)(54906003)(110136005)(7696005)(186003)(26005)(76116006)(5660300002)(66476007)(66946007)(66556008)(53546011)(66446008)(64756008)(6506007)(52536014)(316002)(2906002)(478600001)(8676002)(9686003)(4326008)(83380400001)(8936002)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 6DlD7B9nSxewlcsFXi4RGoctKe3meK78UKTG1E+yWMMwLaiPtaJS6F485Nn2SFniqNnpOjiI0J3IQ7JYqcQ5xqo6MnYtAfQP2i0ZDr/TeK/riMLiQ40H9/X3yuCx1zTsnjtlWEr+X7Daqxd1+DxFYsFiRkCZ0s/Zr750/EbZpnJzQXJVGoqej1LkV/xIKFEkWXbX2Df4Eo9QiWw5phgDd9g8CSUa9l/mqounL9hggLTAKiZMI5/8kS+b07hJpsRQnQFSOnROWYbIW8vRyAktqEziIkFT8e5d+2bVjeOGmjBX8fJ/E+5XTtoms9uRl8Y3HHWEPXI3Uq2D+p6K19pGswMRNlsEudsSRbt8NLMJ/o/Yi85BYs19o1pSAhPRoxLBVptbDDg6pBDdfnVn0WTMWBhuLzaKhakIPFkhpC3z5m3bm963fzrF7CES5FbRz2fhiw3ATVg+/ph1UWh/Gyvnc9lLO0qccYRIicOkCdbjLGPxOAmNpJ+1qo+vioGdEqRDI+MnqMoC7G6TpgMX6zEa1KASVPe7w+faUEfhGs+4MJrgSrC6N7j9tbXcn1cd/Kqjz/HKK2GdLlId+YdwmFLNGCQOaeajrz/ZnQUHwWqLkmzF8fVAzuTIYymivA2B5BjygXMA1giqcou+lFDGD2tqpA==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZvaYLBAg/FvglS2OeihGqFnIe8OP379NoVx1+CM5zyKI0LL7nJuj4aqHNPWNIY18zuGbhvsAk91i5N1RKJ0AFinV+Hi41ZdOJq0lq6AV/ZmHvdU+SlX6J96/fZKgDX677dlc+awSm6f0IlISbszWS67k7u7WCwy6AXUYc8CMFJLwbwcTCc1yYTyousDWfyBv9q7HL+L6+WEZSRMJHky450kG0AQh6DBkVOmuV4JcYxyXj4DzWAr6q8ZmbGFy04EMuVE6qUpzfA1urJNZA3uWPTBL4SyCAVfKTo/MVno05szTE64lstXddg4VvXAw50ANho3afh7qQnCOOv+e5caFA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Y7UXK7kLkEAA45P7wlWvaIKR3TJ02HlZMgnlnyj8Jg=;
 b=hZwa4GH7jupFj37aoSfIswH/J8g3DxdXT9MvTC8xlbZbi5okwG1Mr9mf1EsimUAZm6DTHSvpMKv96RykOADl6UN5pJCvqkrbu28Lk7JTuGnnVXTluYxSSKwo6SLfYYztovkRpE3YZYlPuc4HJFK2J8AoON2kiY6KwM+Pd8U9gTK2l7xcQLdr0C0AQ2MHjd1s6Cjx07+m5i8rPXBBt9jMinJOKKs5bJ3kmr5C8UNBqHTCT3YEkOk4FSYO3QWA9V2Z2FmFT7vyhisqZw97tkL8xT0WGVJ8CvkICtuTWMTUJX5VFnPY6DJZ3oHFrM19pSp/xz6DbkQ4c3VeLwlSkX58ZA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Y7UXK7kLkEAA45P7wlWvaIKR3TJ02HlZMgnlnyj8Jg=;
 b=G/uD3i8gs+NSCpIJW1UdR12w+5H80gyBHmsRleOM3H84eOpaWrxAhnZlYQ9zuTVxG8XbrQtqej/S6TSqqs65L72q5lc3tNDZjMxNO583Xyyq/uNyKiqmHaFtyVaJPA6J8g+MPug4OHlnNIXlSSB6HX5+Ob4RhmTH1YwWxDklzzA=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: bc27328f-f9ba-4cde-f117-08d864b3d4c7
x-ms-exchange-crosstenant-originalarrivaltime: 29 Sep 2020 20:11:20.3322 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: N+6q3rqYlC4RbN0Tfpuv4sewxCUHg6K+47gEeUTF2+zX/AOeNXGY3wb4kKeRZE7kuCUNCycsM8zGsed5uoFH2g==
x-ms-exchange-transport-crosstenantheadersstamped: BY5PR02MB6657
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.39; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 16:11:23
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
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgPHBoaWxpcHBlLm1hdGhpZXUuZGF1ZGVAZ21haWwuY29tPiBPbg0KPiBCZWhhbGYg
T2YgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kNCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDI5
LCAyMDIwIDExOjAyIEFNDQo+IFRvOiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2luYy5j
b20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IGFsZUByZXYubmc7IHJpa3Uudm9pcGlv
QGlraS5maTsgcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZzsNCj4gbGF1cmVudEB2aXZpZXIu
ZXU7IGFsZWtzYW5kYXIubS5tYWlsQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRD
SCB2NCAwMC8yOV0gSGV4YWdvbiBwYXRjaCBzZXJpZXMNCj4NCj4gUUVNVSBhaW1zIHRvIHN1cHBv
cnQgdGhlIDIgbGF0ZXN0IHJlbGVhc2VzIG9mIHN1cHBvcnRlZCBkaXN0cmlidXRpb25zLg0KPiBG
cm9tIHRpbWUgdG8gdGltZSBhIGJyYXZlIGRldmVsb3BlciBsb29rIGF0IHRoZSBkaWZmZXJlbnQg
dmVyc2lvbnMNCj4gcGFja2FnZWQgYW5kIG1ha2Ugc29tZSBjbGVhbnVwIGluIHRoZSBjb2RlIGJh
c2UuIEl0IHVzZWQgdG8gYmUgdGVkaW91cywNCj4gbm93IHRoYXQgcmVwb2xvZ3kub3JnIGV4aXN0
cyBpdCBpcyBhIGJpdCBlYXNpZXIuDQo+DQo+IFRoZSBsYXN0IGVmZm9ydCBpcyBmcm9tIFRob21h
cywgc2VlIGNvbW1pdCBlZmM2YzA3MGFjYToNCj4NCj4gICAgIFRoZSBzdXBwb3J0ZWQgZGlzdHJp
YnV0aW9ucyB1c2UgdGhlIGZvbGxvd2luZyB2ZXJzaW9uDQo+ICAgICBvZiBHQ0M6DQo+DQo+ICAg
ICAgICAgICBSSEVMLTc6IDQuOC41DQo+ICAgICAgICAgICBEZWJpYW4gKFN0cmV0Y2gpOiA2LjMu
MA0KPiAgICAgICAgICAgRGViaWFuIChKZXNzaWUpOiA0LjguNA0KPiAgICAgICAgICAgT3BlbkJT
RCAocG9ydHMpOiA0LjkuNA0KPiAgICAgICAgICAgRnJlZUJTRCAocG9ydHMpOiA4LjIuMA0KPiAg
ICAgICAgICAgT3BlblNVU0UgTGVhcCAxNTogNy4zLjENCj4gICAgICAgICAgIFVidW50dSAoWGVu
aWFsKTogNS4zLjENCj4gICAgICAgICAgIG1hY09TIChIb21lYnJldyk6IDguMi4wDQo+DQo+ICAg
ICBTbyB3ZSBjYW4gc2FmZWx5IGFzc3VtZSBHQ0MgNC44IHRoZXNlIGRheXMuDQo+DQo+IFRoaXMg
aXMgdGhlICJtYW5kYXRlZCIgY29tcGlsZXIgdmVyc2lvbi4NCg0KT3VjaCEgIDQuOCBpcyBvbGQg
ZW5vdWdoIHRoYXQgaXQgZG9lc24ndCBzdXBwb3J0IEMxMSBfR2VuZXJpYyB3aGljaCBJIGFtIHVz
aW5nLiAgVGhhdCBuZWVkcyBhdCBsZWFzdCBHQ0MgNC45Lg0KDQpIZXJlIGFyZSBhIGNvdXBsZSBv
ZiBleGFtcGxlcy4gIEFzIHlvdSBjYW4gc2VlLCBfR2VuZXJpYyBpcyB1c2VkIHRvIGRpc3BhdGNo
IHRvIHNsaWdodGx5IGRpZmZlcmVudCBUQ0cgZ2VuZXJhdGlvbiBmdW5jdGlvbnMgZGVwZW5kaW5n
IG9uIHRoZSB0eXBlIG9mIHRoZSBvcGVyYW5kcy4gIEkgd2lsbCBzY3JhdGNoIG15IGhlYWQgYW5k
IGZpZ3VyZSBvdXQgYSBkaWZmZXJlbnQgd2F5IHRvIGRvIHRoaXMuDQoNCiNkZWZpbmUgTUVNX1NU
T1JFMV9GVU5DKFgpIFwNCiAgICBfR2VuZXJpYygoWCksIGludCA6IGdlbl9zdG9yZTFpLCBUQ0d2
X2kzMiA6IGdlbl9zdG9yZTEpDQojZGVmaW5lIE1FTV9TVE9SRTEoVkEsIERBVEEsIFNMT1QpIFwN
CiAgICBNRU1fU1RPUkUxX0ZVTkMoREFUQSkoY3B1X2VudiwgVkEsIERBVEEsIGN0eCwgU0xPVCkN
Cg0KI2RlZmluZSBHRVRCWVRFX0ZVTkMoWCkgXA0KICAgIF9HZW5lcmljKChYKSwgVENHdl9pMzIg
OiBnZW5fZ2V0X2J5dGUsIFRDR3ZfaTY0IDogZ2VuX2dldF9ieXRlX2k2NCkNCiNkZWZpbmUgZkdF
VEJZVEUoTiwgU1JDKSBHRVRCWVRFX0ZVTkMoU1JDKShCWVRFLCBOLCBTUkMsIHRydWUpDQojZGVm
aW5lIGZHRVRVQllURShOLCBTUkMpIEdFVEJZVEVfRlVOQyhTUkMpKEJZVEUsIE4sIFNSQywgZmFs
c2UpDQoNCg0KRldJVywgSSBoYXZlIGJlZW4gdXNpbmcgNS41Lg0KDQpUaGUgZXJyb3JzIHlvdSBz
YXcgc3RhcnRlZCBhcm91bmQgNy41IGFuZCBhcmUgZWFzeSB0byBmaXguDQoNCg0KVGF5bG9yDQoN
Cg==

