Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A72C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 04:17:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C102D2078B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 04:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n2Yy23WC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="Ax+gWY8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C102D2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCxk1-00008B-VA
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 00:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCxjR-00088N-6h
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 00:17:17 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:45610)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCxjO-0003U6-8R
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 00:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598933834; x=1630469834;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0/XAg0jW5yWfbWWr21KrMiDWRgmM2FXzJMOigKUTy0A=;
 b=n2Yy23WCCngO/U65XR0uTdqU+9DvP+Gk0uiq21s5SzgZMG9lo7ZYFrkY
 XpsX0zZNOMXNFnekAZwipT70TKX1I/pGUThAQdGuKxsCojm+VDwINoIrx
 t0lzmkBntWp5U3uBsNvq3aykRXKbNG6R+dJfsvOjVCv4TUL0rwUqQAG6g U=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 31 Aug 2020 21:17:11 -0700
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 31 Aug 2020 21:17:11 -0700
Received: from nasanexm03b.na.qualcomm.com (10.85.0.98) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 31 Aug 2020 21:17:11 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03b.na.qualcomm.com (10.85.0.98) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 31 Aug 2020 21:17:11 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB5320.namprd02.prod.outlook.com (2603:10b6:a03:61::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Tue, 1 Sep
 2020 04:17:09 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01%7]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 04:17:09 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 30/34] Hexagon (target/hexagon) TCG for
 instructions with multiple definitions
Thread-Topic: [RFC PATCH v3 30/34] Hexagon (target/hexagon) TCG for
 instructions with multiple definitions
Thread-Index: AQHWdXdjR65U8vNpmEiviytk7eiWcalOZgsAgAK5LuCAABqagIAAAiTQgAAjBACAASHoAIAADK2AgAAIhJCAABaEgIAAAzsAgAB3woCAAAq1sA==
Date: Tue, 1 Sep 2020 04:17:09 +0000
Message-ID: <BYAPR02MB488667B684F8CEC755CBFD72DE2E0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-31-git-send-email-tsimpson@quicinc.com>
 <10127f7e-a2df-2f19-e897-9a874f9a5d82@linaro.org>
 <BYAPR02MB488691F539AD3A2BFA1C819DDE500@BYAPR02MB4886.namprd02.prod.outlook.com>
 <a0987bce-409b-cd14-7559-c63413ff2b6f@linaro.org>
 <BYAPR02MB4886985CC5CBF78F7D5DBFE5DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
 <fca34122-160d-8c13-d237-a87a917f341b@linaro.org>
 <BYAPR02MB4886D48EDC604CEEF65FDAA7DE510@BYAPR02MB4886.namprd02.prod.outlook.com>
 <1cf57f2b-a2c8-6fbc-2c1c-9945a5d77dd8@linaro.org>
 <BYAPR02MB4886F055CBD52DBEE5F269AEDE510@BYAPR02MB4886.namprd02.prod.outlook.com>
 <0241f731-61de-41bc-9f58-bc43725eef74@linaro.org>
 <BYAPR02MB4886B33025BE2B65D6F5F5A8DE510@BYAPR02MB4886.namprd02.prod.outlook.com>
 <f0011ef6-014c-748b-7fc1-ea0f7878c281@linaro.org>
In-Reply-To: <f0011ef6-014c-748b-7fc1-ea0f7878c281@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06bb17cf-1384-44ad-d390-08d84e2de519
x-ms-traffictypediagnostic: BYAPR02MB5320:
x-microsoft-antispam-prvs: <BYAPR02MB5320405FA33D0EED518DA559DE2E0@BYAPR02MB5320.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oMZLthoeqnM4yhIT7mjEgSmF3dY/+0eWqCIHPCcsy6Ghv4HgCVyrmdSf0gfCKHNzc2cY+ZvaNB3I1X4FQRAA3XetGfQbmc+gF75PA3iFnKZNuMuoX7Ahs1+TYkU2PaIxs3VPJXEyEGQIGq1YeuiFx6DPsEywy0IrOn7U8JP8QeWCcIyVAARY5j8QhGcNJBE4yn1xm7MjcW+MR/sTpZoUQFurNWma+YyESbPHspufll8lTTTPzo9r4pfP5/QO68bkUbIxR4kDGxLcJ7bKKk/BHxiywn5Wo2Vymlpxf9cDLrcVVl2Y34vU0uwM6h5uEX26
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(39860400002)(376002)(366004)(346002)(396003)(66476007)(5660300002)(52536014)(64756008)(83380400001)(110136005)(7696005)(66446008)(76116006)(8936002)(54906003)(66556008)(66946007)(316002)(8676002)(33656002)(9686003)(4326008)(26005)(2906002)(71200400001)(6506007)(86362001)(478600001)(53546011)(186003)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: j1wxR9b1wDvGKCgt59wt5nO3w0C7sz9cMmsLS1m6ATJHJvqJ4aXc6m6YC7paOiRLdqf1EOqFX+k10nUFlgO+9UDcfVmjYs7SAjkDW5/QveHFWE33UizrU2oXix9gaOjxBcCtsn3vqWfNFmR/LjhuXei8Nnc6wUvpFq+U4qTJudSrTHxx1s9Hjf3mepttGvYmBWuWHV72A7YQi+1XRYA2Kqh8SAHV7e7yOGBnoY4KJf/qNWB4yvyGfYZN6kNDV5YSikHRqW4UAoWx1nBUAKAn2pG/LvmKDeu5/KBPd09j+ybfAzSiDjx2kYydpZgAKqxvxh5xGedXbwOVHdZCCozQw/+unEQV8+UszJ6gAJXM8rx2RsUnhiUYIA4R8Gw9QB5fgq0HKyUl3if7ysrM4/Kr/6dXiivY5ihjGExmlZD8+mTgioF/GBSpRJgjyxbB6J2Vl7/UPQoiwuW30S9FqpgBed4Io6kA+GR98EP/bPfVj/xNynVKulhQAW/dQnuj0wYX4VzWle3OP7GgeUXqFOkrTyEq1Sd2+kQSX6ZOnXI9g4dGC4g49d+96FQvxhrFf5p4aFe7kfes5+QnTe+qsoc4l2bdAAy6YnGfy0JT6vYTo5iKnrsSgRloIy2tzG/DA8eADrGJYVSeDRRCgAUFzlAtOQ==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VseqcRHDrJtPPST0BVXwcTAO0GRCEXn2+BC/rlAJWcUfUUGwGwaH55+Ab4xbHwV1N+D2BqxIaCpvfQpMIj/FQpyG4YytBPqAhAeHR7mSEufX79AuVvVWptNWzdEJXO5Kw95VO7xKGwEEjDxRnnDnIlb8Y+PVrGJTH0N9SJcHNCV44sTqKrkvFuZa6Kl8zXEocqkaW6szZ+NdYED7VsWQ2VHWpW3TmteMbhaMgtR8nsBpaZ8HLNE6zSYaB1gHKOS/gwk7XSPeIk9rx2zhn1CAzoM9y9WO+EQ8Olm6r9j5HqkewzBhrCwrscniJjlOXVBYO0CjIYbC60j7uxBSWv27QQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rggcTsiyPr3epsGtRM9d17AGi2L7kispHoaRypxrYQ=;
 b=D1XibPRMTdnO7xBtlDvm1pIAnsmtlETKW+lFAFktk/Q4L9jm/b869sxCZN/B1Y9oLhYy04F72BGUcj/gI6VJvYbg8we+VFdCs7Z9YV7CRLlejk65XLpIrcpvOdaUH8hQ04bL2aqJ/vvjuvO1RUYGQ04YYRbAAGyt8Z9Gr12+wvEMch3A+OkpG1gJCrXEj3Tljg+7hWv5K4d2eeDmpmBe2vaTBDAIe8UQguZbV9TEWXaLq2cecC4cXPoepjl9TzwBpYOoWJ4LQtg2f6CXHch0YhSsKLU0DKNWbyECtZ+MjMnpbahCFboK+Y1uH8uQZBjiFcnuE5SPYCqKq0193T8aKA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rggcTsiyPr3epsGtRM9d17AGi2L7kispHoaRypxrYQ=;
 b=Ax+gWY8KwGdxI0TTYtlybgjtcJkfTgpAVHNvrenPn1L2LjUHPu6NaZSssoIakn1n6EyKVIQA7XN+vCPph75LXD6R+GyGnfEOsuEOebItulronnakyTcfz7FEKWxNH0qZAkWLSPA7x+S9o0MlzX2mJ6XaIpSlwjtReWdyRIMwozg=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 06bb17cf-1384-44ad-d390-08d84e2de519
x-ms-exchange-crosstenant-originalarrivaltime: 01 Sep 2020 04:17:09.5945 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: qgYDY+xJVg3YNNmx/0NzcT6ZwnFMKHUuOoZsW7kCkbAkjVkNExqbOcz2q0TnV1iLvJRbGAeSnrKZzEUVSlDMrg==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB5320
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.38; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 00:17:12
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
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgQXVndXN0
IDMxLCAyMDIwIDg6NDEgUE0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5j
LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGhpbG1kQHJlZGhhdC5jb207IGxh
dXJlbnRAdml2aWVyLmV1OyByaWt1LnZvaXBpb0Bpa2kuZmk7DQo+IGFsZWtzYW5kYXIubS5tYWls
QGdtYWlsLmNvbTsgYWxlQHJldi5uZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAzMC8z
NF0gSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIFRDRyBmb3INCj4gaW5zdHJ1Y3Rpb25zIHdpdGgg
bXVsdGlwbGUgZGVmaW5pdGlvbnMNCj4NCj4gT24gOC8zMS8yMCA0OjEwIFBNLCBUYXlsb3IgU2lt
cHNvbiB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4+IEZyb206IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3Jn
Pg0KPiA+PiBTZW50OiBNb25kYXksIEF1Z3VzdCAzMSwgMjAyMCAxOjIwIFBNDQo+ID4+IFRvOiBU
YXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2luYy5jb20+OyBxZW11LWRldmVsQG5vbmdudS5v
cmcNCj4gPj4gQ2M6IHBoaWxtZEByZWRoYXQuY29tOyBsYXVyZW50QHZpdmllci5ldTsgcmlrdS52
b2lwaW9AaWtpLmZpOw0KPiA+PiBhbGVrc2FuZGFyLm0ubWFpbEBnbWFpbC5jb207IGFsZUByZXYu
bmcNCj4gPj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjMgMzAvMzRdIEhleGFnb24gKHRhcmdl
dC9oZXhhZ29uKSBUQ0cgZm9yDQo+ID4+IGluc3RydWN0aW9ucyB3aXRoIG11bHRpcGxlIGRlZmlu
aXRpb25zDQo+ID4+DQo+ID4+IFRoZSBmR0VOX1RDR19BMl9hZGQgbWFjcm8gZG9lcyBub3QgcmVx
dWlyZSBub3IgdXNlIHRoYXQgey4uLn0NCj4gYXJndW1lbnQuDQo+ID4NCj4gPiBUaGUgZkdFTl9U
Q0dfQTJfYWRkIG1hY3JvIGRvZXMgbmVlZCB0aGF0IGFyZ3VtZW50LCBidXQgdGhlcmUgYXJlDQo+
IGNhc2VzIHRoYXQNCj4gPiBkbyBuZWVkIGl0LiAgSGVyZSdzIGFuIGV4YW1wbGUgZnJvbSBnZW5f
dGNnLmgNCj4gPiAgICAgI2RlZmluZSBmR0VOX1RDR19MMl9sb2FkcnViX3ByKFNIT1JUQ09ERSkg
ICAgICBTSE9SVENPREUNCj4gPiBUaGlzIGlzIGV4cGxhaW5lZCBpbiB0aGUgUkVBRE1FLCBidXQg
YmFzaWNhbGx5IHRoZSBhcmd1bWVudCBpcyB1c2VmdWwgaWYgd2UNCj4gPiBjYW4gcHJvcGVybHkg
ZGVmaW5lIHRoZSBtYWNyb3MgdGhhdCBpdCBjb250YWlucyB0byBnZW5lcmF0ZSBUQ0cuDQo+IFdl
J3JlIGNlcnRhaW5seSBub3QgZ29pbmcgdG8gYmUgYWJsZSB0byBoYW5kbGUgZS5nLiAiKyIgb3Ig
ImlmIiwgc28gaXQgaXMgZ29pbmcNCj4gdG8gd29yayBvbmx5IGZvciB0aGUgbW9zdCB0cml2aWFs
IG9mIFNIT1JUQ09ERS4NCj4NCj4gVGhvdWdoIGluIGZhY3QgbG9hZHJ1Yl9wciBtYWtlcyB0aGF0
IGdyYWRlLi4uDQoNClRoZSBwcmlvciB2ZXJzaW9uIG9mIHRoaXMgc2VyaWVzIGluY2x1ZGVkIGFs
bCB0aGUgb3ZlcnJpZGVzIEkndmUgd3JpdHRlbiB0byBkYXRlLiAgVG8gcmVkdWNlIHRoZSBzaXpl
IG9mIHRoaXMgdmVyc2lvbiwgSSByZW1vdmVkIG1vc3Qgb2YgdGhlbSBhbmQgb25seSBsZWZ0IHRo
ZSBvbmVzIHRoYXQgYXJlIGVzc2VudGlhbCBmb3IgY29ycmVjdCBleGVjdXRpb24uICBJIHBsYW4g
dG8gc3VibWl0IHRoZSBvdGhlcnMgaW4gc3Vic2VxdWVudCBzZXJpZXMuICBBbnl3YXksIHRoZXJl
IGFyZSA+NTAgb3ZlcnJpZGVzIG9mIGxvYWQvc3RvcmUgaW5zdHJ1Y3Rpb25zIHRoYXQgbGV2ZXJh
Z2UgU0hPUlRDT0RFLg0KDQo+ID4gSU1PLCB3ZSBkb24ndCB3YW50IHRoZSBwZXJzb24gd2hvIHdy
aXRlcyBhbiBvdmVycmlkZSBoYXZpbmcgdG8NCj4gcmVwcm9kdWNlIHRoZQ0KPiA+IGdlbmVyYXRl
ZCBjb2RlLiAgQXNzdW1pbmcgd2UgaGF2ZSBhIGRlZmluaXRpb24gb2YgZkdFTl9UQ0dfQTJfYWRk
IGFuZA0KPiB3ZQ0KPiA+IGhhdmUgdGhlIGdlbmVyYXRvciBpbnRlbGxpZ2VudGx5IGV4cGFuZGlu
ZyB0aGUgbWFjcm9zLCB0aGlzIGlzIHdoYXQgd2lsbCBiZQ0KPiA+IGdlbmVyYXRlZC4NCj4gWW91
IG5lZWQgdG8gZ2l2ZSBtZSBhIGJldHRlciBleGFtcGxlIHRoYXQgQTJfYWRkLCB0aGVuLiAgQmVj
YXVzZSBJIHNlZSB0aGF0DQo+IGJlaW5nIGV4YWN0bHkgb25lIGxpbmUsIGNhbGxpbmcgYSBoZWxw
ZXIgdGhhdCBoYW5kbGVzIGFsbCBpbnN0cnVjdGlvbnMgb2YgdGhlDQo+IHNhbWUgZm9ybWF0LCBw
YXNzaW5nIHRjZ19nZW5fYWRkX3RsIGFzIGEgY2FsbGJhY2suDQoNCkhlcmUncyBhIG1vcmUgY29t
cGxpY2F0ZWQgZXhhbXBsZSBmb3IgYSBwcmVkaWNhdGVkIHBvc3QtaW5jcmVtZW50IGxvYWQNCg0K
U3RhdGljIHZvaWQgZ2VuZXJhdGVfTDJfcGxvYWRyaXRfcGkoQ1BVSGV4YWdvblN0YXRlICplbnYs
IERpc2FzQ29udGV4dCpjdHMsIGluc25fdCAqaW5zbiwgcGFja2V0X3QgKnBrdCkNCnsNCi8qIEwy
X3Bsb2Fkcml0X3BpICovDQpUQ0d2IEVBID0gdGNnX3RlbXBfbG9jYWxfbmV3KCk7DQppbnQgUHRO
ID0gaW5zbi0+cmVnbm9bMF07DQpUQ0d2IFB0ViA9IGhleF9wcmVkW1B0Tl07DQppbnQgUmROID0g
aW5zbi0+cmVnbm9bMV07DQpUQ0d2IFJkViA9IHRjZ190ZW1wX2xvY2FsX25ldygpOw0KaWYgKCFp
c19wcmVsb2FkZWQoY3R4LCBSZE4pKSB7DQogICAgdGNnX2dlbl9tb3ZfdGwoaGV4X2hld192YWx1
ZVtSZE5dLCBoZXhfZ3ByW1JkTl0pOw0KfQ0KaW50IFJ4TiA9IGluc24tPnJlZ25vWzJdOw0KVENH
diBSeFYgPSB0Y2dfdGVtcF9sb2NhbF9uZXcoKTsNCmlmICghaXNfcHJlbG9hZGVkKGN0eCwgUnhO
KSkgew0KICAgIHRjZ19nZW5fbW92X3RsKGhleF9uZXdfdmFsdWVbUmROXSwgaGV4X2dwcltSeE5d
KTsNCn0NCmludCBzaVYgPSBpbnNuLT5pbW1lZFswXTsNCnRjZ19nZW5fbW92X3RsKFJ4ViwgaGV4
X2dwcltSeE5dKTsNCmZHRU5fVENHX0wyX3Bsb2Fkcml0X3BpKHtmRUFfUkVHKFJ4Vik7IGlmKGZM
U0JPTEQoUHRWKSl7IGZQTV9JKFJ4VixzaVYpOyBmTE9BRCgxLDQsdSxFQSxSZFYpO30gZWxzZSB7
TE9BRF9DQU5DRUwoRUEpO319KTsNCmdlbl9sb2dfcmVnX3dyaXRlKFJkTiwgUmRWLCBpbnNuLT5z
bG90LCAxKTsNCmdlbl9sb2dfcmVnX3dyaXRlKFJ4TiwgUnhWLCBpbnNuLT5zbG90LCAxKTsNCnRj
Z190ZW1wX2ZyZWUoRUEpOw0KdGNnX3RlbXBfZnJlZShSZFYpOw0KdGNnX3RlbXBfZnJlZShSeFYp
Ow0KLyogTDJfcGxvYWRyaXRfcGkgKi8NCn0NCg0KDQo+IEhhdmUgYSBicm93c2UgdGhyb3VnaCBt
eSByZWNlbnQgbWljcm9ibGF6ZSBkZWNvZGV0cmVlIGNvbnZlcnNpb24uICBOb3RlDQo+IHRoYXQN
Cj4gdGhlIGJhc2ljIGxvZ2ljYWwgb3BlcmF0aW9ucyBhcmUgaW1wbGVtZW50ZWQgd2l0aCBleGFj
dGx5IG9uZSBzb3VyY2UgbGluZS4NCg0KV2l0aCBhIGhlbHBlciBmdW5jdGlvbiwgb3VyIGNvbXBh
cmVzIGFyZSBhbGwgb25lIGxpbmUgYWxzbw0KDQpzdGF0aWMgaW5saW5lIHZvaWQgZ2VuX2NvbXBh
cmUoVENHQ29uZCBjb25kLCBUQ0d2IHJlcywgVENHdiBhcmcxLCBUQ0d2IGFyZzIpDQp7DQogICAg
VENHdiBvbmUgPSB0Y2dfY29uc3RfdGwoMHhmZik7DQogICAgVENHdiB6ZXJvID0gdGNnX2NvbnN0
X3RsKDApOw0KDQogICAgdGNnX2dlbl9tb3Zjb25kX3RsKGNvbmQsIHJlcywgYXJnMSwgYXJnMiwg
b25lLCB6ZXJvKTsNCg0KICAgIHRjZ190ZW1wX2ZyZWUob25lKTsNCiAgICB0Y2dfdGVtcF9mcmVl
KHplcm8pOw0KfQ0KDQovKiBDb21wYXJlIGluc3RydWN0aW9ucyAqLw0KI2RlZmluZSBmR0VOX1RD
R19DMl9jbXBlcShTSE9SVENPREUpIFwNCiAgICBnZW5fY29tcGFyZShUQ0dfQ09ORF9FUSwgUGRW
LCBSc1YsIFJ0VikNCiNkZWZpbmUgZkdFTl9UQ0dfQzRfY21wbmVxKFNIT1JUQ09ERSkgXA0KICAg
IGdlbl9jb21wYXJlKFRDR19DT05EX05FLCBQZFYsIFJzViwgUnRWKQ0KI2RlZmluZSBmR0VOX1RD
R19DMl9jbXBndChTSE9SVENPREUpIFwNCiAgICBnZW5fY29tcGFyZShUQ0dfQ09ORF9HVCwgUGRW
LCBSc1YsIFJ0VikNCiNkZWZpbmUgZkdFTl9UQ0dfQzJfY21wZ3R1KFNIT1JUQ09ERSkgXA0KICAg
IGdlbl9jb21wYXJlKFRDR19DT05EX0dUVSwgUGRWLCBSc1YsIFJ0VikNCi4uLg0KDQoNCg0KPiA+
IFVubGlrZSB0aGUgZ2VuZXJhdGVfPHRhZz4gZnVuY3Rpb25zIHRoYXQgYWxsIGhhdmUgdGhlIHNh
bWUgc2lnbmF0dXJlLiAgVGhlDQo+IG92ZXJyaWRlcyB3b3VsZCBoYXZlIGRpZmZlcmVudCBzaWdu
YXR1cmVzLiAgVGhpcyB3b3VsZCBiZSBtb3JlIGRlZmVuc2l2ZQ0KPiBwcm9ncmFtbWluZyBiZWNh
dXNlIHlvdSBrbm93IGV4YWN0bHkgd2hlcmUgdGhlIHZhcmlhYmxlcyBjb21lIGZyb20gYnV0DQo+
IG1vcmUgdmVyYm9zZSB3aGVuIHdyaXRpbmcgdGhlIG92ZXJyaWRlcyBieSBoYW5kLiAgQWxzbywg
bm90ZSB0aGF0IHRoZXNlDQo+IG5lZWQgdG8gYmUgbWFjcm9zIGluIG9yZGVyIHRvIHRha2UgYWR2
YW50YWdlIG9mIHRoZSBTSE9SVENPREUuDQo+ID4NCj4gPiBJbiBvdGhlciB3b3JkcywgaW5zdGVh
ZCBvZg0KPiA+ICNkZWZpbmUgZkdFTl9UQ0dfQTJfYWRkKFNIT1JUQ09ERSkgICAgdGNnX2dlbl9h
ZGRfdGwoUmRWLCBSc1YsIFJ0VikNCj4gPg0KPiA+IFdlIHdvdWxkIHdyaXRlDQo+ID4gI2RlZmlu
ZSBmR0VOX1RDR19BMl9hZGQoZW52LCBjdHgsIGluc24sIHBrdCwgUmRWLCBSc1YsIFJ0ViwNCj4g
U0hPUlRDT0RFKSAgICB0Y2dfZ2VuX2FkZF90bChSZFYsIFJzViwgUnRWKTsNCj4gPg0KPiA+IFBl
cnNvbmFsbHksIEkgcHJlZmVyIHRoZSBmb3JtZXIsIGJ1dCB3aWxsIGNoYW5nZSB0byB0aGUgbGF0
dGVyIGlmIHlvdSBmZWVsDQo+IHN0cm9uZ2x5Lg0KPg0KPiBUaGlzIGNvbWVzIGZyb20gdHJ5aW5n
IHRvIGhhbmRsZSBpbnN0cnVjdGlvbnMgaW4gZGlmZmVyZW50IHdheXMsIGJ1dA0KPiByZXByZXNl
bnQNCj4gdGhlbSBhbGwgdGhlIHNhbWUuDQo+DQo+IEkgZ3Vlc3MgSSBzZWUgdGhlIGF0dHJhY3Rp
b24gb2YgdGhlIG1hZ2ljIG5vbi1wYXJhbWV0ZXJzIC0tIHlvdSBnZXQgYQ0KPiBjb21waWxhdGlv
biBlcnJvciBpZiB0aGUgdmFyaWFibGUgaXMgbm90IHByZXNlbnQsIGJ1dCBhcmUgbm90IHRpZWQg
dG8NCj4gcG9zaXRpb25hbCBwYXJhbWV0ZXJzLg0KPg0KPiBIbyBodW0uICBNYXliZSBJJ20gdHJ5
aW5nIHRvIG92ZXJ0aGluayB0aGlzIHRvbyBtdWNoIGJlZm9yZSB0YWNrbGluZyB0aGUNCj4gdWx0
aW1hdGUgZ29hbCBvZiBmdWxsIHBhcnNpbmcgb2YgdGhlIFNIT1JUQ09ERS4NCg0KQWxlc3NhbmRy
byAoYWxlQHJldi5uZykgYW5kIE5pY2NvbG8gKG5penpvQHJldi5uZykgYXJlIHdvcmtpbmcgb24g
dGhpcyDwn5iKDQoNCj4gUGVyaGFwcyB0aGUgb25seSB0aGluZyBmb3IgdGhlIHNob3J0IHRlcm0g
aXMgdG8gaGF2ZSB0aGUgZ2VuZXJhdG9yIGdyZXANCj4gZ2VucHRyLmMgZm9yICIjZGVmaW5lIGZH
RU4iLCB0byBjaG9vc2UgYmV0d2VlbiB0aGUgdHdvIGFsdGVybmF0aXZlczogaW5saW5lDQo+IGdl
bmVyYXRpb24gb3Igb3V0LW9mLWxpbmUgaGVscGVyIGdlbmVyYXRpb24uDQoNClRoYXQncyBjZXJ0
YWlubHkgZG9hYmxlLiAgSXQgd2lsbCBhbHNvIGJlIGdvb2QgdG8gaW1wbGVtZW50IHNvbWUgb2Yg
eW91ciBvdGhlciBpZGVhcw0KLSBIYXZlIHRoZSBnZW5lcmF0b3IgZXhwYW5kIHRoZSBERUNML1JF
QUQvV1JJVEUvRlJFRSBtYWNyb3Mgd2lsbCBtYWtlIHRoZSBnZW5lcmF0ZWQgY29kZSBtb3JlIHJl
YWRhYmxlIGFuZCB3ZSBjYW4gc3BlY2lhbGl6ZSB0aGVtIGZvciBwcmVkaWNhdGVkIHZzIG5vbi1w
cmVkaWNhdGVkIGluc3RydWN0aW9ucyB3aGljaCB3aWxsIG1ha2UgdHJhbnNsYXRpb24gZmFzdGVy
Lg0KLSBHZW5lcmF0ZSB0aGUgZW50aXJlIGdlbmVyYXRlXzx0YWc+IGZ1bmN0aW9uIGluc3RlYWQg
b2YganVzdCB0aGUgYm9keSB3aWxsIG1ha2UgdGhlIGdlbmVyYXRlZCBjb2RlIG1vcmUgcmVhZGFi
bGUuDQo=

