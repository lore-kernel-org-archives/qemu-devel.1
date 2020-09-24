Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1699BC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 17:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 655F3238A1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 17:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B8UR+SJt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="MjZkmpR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 655F3238A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLUwz-0005QV-7P
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 13:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kLUsw-0003C0-F9
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 13:18:22 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:32025)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kLUsr-0006VN-Ch
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 13:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1600967897; x=1632503897;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yV7WC8g5ri8KwZg67iGWRT9P4l9BaG2f6hHvzYJowiw=;
 b=B8UR+SJt1ivQ8/tG591PseHCNTSa3cg4aLzeW4R5QuimRNjfJk2c750J
 dXhaKXca29MSl9wP2oRkTvEeT3UgDRFmgqnJHBHLbbk6Y+BkZBcs+YQYc
 RAGFRsB6qZrgZfprRPJDnm4HiZmTJhhjNIP3V5r++K4PGbiRRH8zQaUgH I=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Sep 2020 10:18:15 -0700
Received: from nasanexm03a.na.qualcomm.com ([10.85.0.103])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 24 Sep 2020 10:18:15 -0700
Received: from nasanexm03h.na.qualcomm.com (10.85.0.50) by
 nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 24 Sep 2020 10:18:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03h.na.qualcomm.com (10.85.0.50) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 24 Sep 2020 10:18:14 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4550.namprd02.prod.outlook.com (2603:10b6:a03:10::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Thu, 24 Sep
 2020 17:18:13 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01%7]) with mapi id 15.20.3391.025; Thu, 24 Sep 2020
 17:18:13 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 30/34] Hexagon (target/hexagon) TCG for
 instructions with multiple definitions
Thread-Topic: [RFC PATCH v3 30/34] Hexagon (target/hexagon) TCG for
 instructions with multiple definitions
Thread-Index: AQHWdXdjR65U8vNpmEiviytk7eiWcalOZgsAgAK5LuCAABqagIAAAiTQgAAjBACAASHoAIAADK2AgAAIhJCAABaEgIAAAzsAgAB3woCAAAq1sIAkG8kggADOwICAABEZgA==
Date: Thu, 24 Sep 2020 17:18:13 +0000
Message-ID: <BYAPR02MB4886EA66077760A6B43FC388DE390@BYAPR02MB4886.namprd02.prod.outlook.com>
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
 <BYAPR02MB488667B684F8CEC755CBFD72DE2E0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <BYAPR02MB48865179810F9248DE1280F8DE390@BYAPR02MB4886.namprd02.prod.outlook.com>
 <e279b41a-a815-ec0e-46e2-2adf8f0b3398@linaro.org>
In-Reply-To: <e279b41a-a815-ec0e-46e2-2adf8f0b3398@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e05692e-c802-40be-8e77-08d860add173
x-ms-traffictypediagnostic: BYAPR02MB4550:
x-microsoft-antispam-prvs: <BYAPR02MB4550829F21E8BB4761D6FB76DE390@BYAPR02MB4550.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aP5Vk0F4MpML/oIOYb8IqITT2Yrm31c0yqODfghSc1MgusD3DilIR/PzEFEg69bb7QHuMygJE9hI/tqCQZxFq6yF7sJxmFRWqKd9iCCt8x0Opa6LEoWnzBJFAw2747kMEvU71mr5v+u7FrIo9EoehMjH8U6G9DPRXClV9z6ayHCY9AGTT4ofCKLV6QYsSN2UgXGAw9aYpjtXLVuJjbNFtz/IBh2Rmw+/hk8WdlOCIgvW2Sb3Ii3Ek4pq3BZbmGD7PRVi2tgx5pkVBl8kxpp/bHvMXV5dXqwXis2Y+A3UcJSamaDb0Ksy6A7+BAzfwqGJoCSNYGe7Dt4h3P1Kcys2d/VqEkL5il3RnNqfo2Hv9f9/DOSN2OQs8ulPpbAmDxGX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(39860400002)(396003)(136003)(346002)(376002)(64756008)(66946007)(66446008)(8676002)(4326008)(83380400001)(478600001)(55016002)(9686003)(8936002)(53546011)(2906002)(26005)(7696005)(6506007)(52536014)(76116006)(66476007)(66556008)(54906003)(71200400001)(110136005)(186003)(86362001)(316002)(33656002)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: fqYRhSsaXqS5h0WJ2uyy2znQtyW3oB1P4BGPxvvMFlBq7ON+eg/0SehGRcD0GVJDs2HuYqmth7nnJ2maa12+8mOsSfNeoXUHGnkjQCyblbdFJMs07qyR7lktrBCXekPboDMVFiTyz+GlAdMjO56+jLN1Wi+iIBEpHG3+yfvMoNfv3qMNU8R9tWnB8TQ8BYw0bnLh4MxxvABR2J5yi3SVcZB8gK4EXWthLQQWVBH+MZcrlmiVM3ZHXnPkJPqDKAhMDtaPNF/z9zqh7JtGtCNO5GQsj4pCpkuQNX4HFU3nGWBqiw43ZhWTX7NXmrSlQXNU2tbQ3mrJnTE7gKUdK+0n3koH5OZSUppFZyzINhdkuRHNQuHq6XIUCK/Qkx1AJ86v14VGaRYoJefL5Z3R7OageyOlRuYxfwLnUyxDKEMqh1edNK2NYhld3J3nfJj7nT/DJNdFm/dI/RPdR/ft/SgHN0/xhvfb//Gxx4rtpZFOIhxcnFMaxxGRuzysiUxiKWe1pvhJZNQP79cp9H4io0iEXfWNqav9WtoD6hs2XggjfvFk9VIbTMvMUJtOYbxwo83lNT/iSXZENrtAZ9fwfYH4lcm/ANg9KZaltqogOL2CpbSiTq/8tHp1nM9Nj+7PhUZJ82B13hIorfU9Z9Czxqffkg==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kw9LHdCanHlIcklp+9CCeBG0THYL8+OdeevokEVY2gp4qYie94xeuMg2oSI9PDWPxuzhsA0dOBIKWfQEuZ5TjLwR1+kmcGNsUYNP8dGdTgtp/lE17AxD7fQof/sTJqAgcQFMK/vvUQ192qVGSJDjo3l9vPqv03BEVKThUbDSAsQ/8EHJwdOTFK4IA0j2hY26cmlh3Y59yrykzknQPVxmVLtCcchpzjljWgGbekv7Yzjvg8dGZB8rxOWxzCHwbnQMHO72Sp6J4RYc75FU9iRNdjSsx8rRyjrm3duEWoc2cQ+ppKDS2gUXdVx6Svmo4rOc49zKlXu5Cn2GltxeOBp2hg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohmKTxRSI/EnopsaGjumnREnLK6Q3ON1QXYvctzoCb4=;
 b=ASQwvLDWe8KZXgTsCwTgDU9yRhKhrdiv317TGxJl44UV4R3O4Usx1nR40kRaM2hMVR5rSZ5/0PySGAkamH+7p609RBJK/mmSrSN4wb4eBvIbRNMjqGE+mS2nLA0ZwuevmQm/sVdANvGcYz9bKuRFDpWHBzYh4qdhop8XwzXtUeoAZ13FDafW+Vggpg3/BmZMjIEPyVzbg0Eyum2L+gs3zdXK/vuNzQ+a8nSNXm4dBOTfIlMM2+DjjbE4ouC9dQOVE6wdKOFSZopnRioSXP2NOKpNduZwyzFsulZLRyZuI0/EEaxpcdC/NugwXslsdy76JEwsaBe0IrazURF4XgF1Lg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohmKTxRSI/EnopsaGjumnREnLK6Q3ON1QXYvctzoCb4=;
 b=MjZkmpR+h9s2J9cxzTQbdVwj0jp/AmCqVuudnR3Yb+xLg2ffSu8IbAGAgwl99U1FD6rc7TBnYUdCi4QDUaR2XGKTeuScP+JV2yEJsfGNPIcavYhREx+1AHl4PThej5sPqywbj2gUAQDyLg/16azLHlWjKdLWc75t7nRyTx4mXuk=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 3e05692e-c802-40be-8e77-08d860add173
x-ms-exchange-crosstenant-originalarrivaltime: 24 Sep 2020 17:18:13.0776 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: DTTlxNl4+qz/7oGfHoBX8Zj65WuHkafdE8GTNeEY234DUEDmJRlqCXterle38O/PYAR7rF1sEWZryojWMKcYVA==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4550
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.39; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 13:18:15
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
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBTZXB0
ZW1iZXIgMjQsIDIwMjAgOTowNCBBTQ0KPiBUbzogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1
aWNpbmMuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwaGlsbWRAcmVkaGF0LmNv
bTsgbGF1cmVudEB2aXZpZXIuZXU7IHJpa3Uudm9pcGlvQGlraS5maTsNCj4gYWxla3NhbmRhci5t
Lm1haWxAZ21haWwuY29tOyBhbGVAcmV2Lm5nDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYz
IDMwLzM0XSBIZXhhZ29uICh0YXJnZXQvaGV4YWdvbikgVENHIGZvcg0KPiBpbnN0cnVjdGlvbnMg
d2l0aCBtdWx0aXBsZSBkZWZpbml0aW9ucw0KPg0KPiA+DQo+ID4gSSd2ZSBtYWRlIHRoZXNlIGNo
YW5nZXMgdG8gdGhlIGdlbmVyYXRvci4gIEkgaG9wZSB5b3UgbGlrZSB0aGUgcmVzdWx0cy4gIEFz
DQo+IGFuIGV4YW1wbGUsIGhlcmUgaXMgd2hhdCB3ZSBnZW5lcmF0ZSBmb3IgdGhlIGFkZCBpbnN0
cnVjdGlvbg0KPiA+DQo+ID4gREVGX1RDR19GVU5DKEEyX2FkZCwNCj4gPiBzdGF0aWMgdm9pZCBn
ZW5lcmF0ZV9BMl9hZGQoDQo+ID4gICAgICAgICAgICAgICAgIENQVUhleGFnb25TdGF0ZSAqZW52
LA0KPiA+ICAgICAgICAgICAgICAgICBEaXNhc0NvbnRleHQgKmN0eCwNCj4gPiAgICAgICAgICAg
ICAgICAgaW5zbl90ICppbnNuLA0KPiA+ICAgICAgICAgICAgICAgICBwYWNrZXRfdCAqcGt0KQ0K
PiA+IHsNCj4gPiAgICAgVENHdiBSZFYgPSB0Y2dfdGVtcF9sb2NhbF9uZXcoKTsNCj4gPiAgICAg
Y29uc3QgaW50IFJkTiA9IGluc24tPnJlZ25vWzBdOw0KPiA+ICAgICBUQ0d2IFJzViA9IGhleF9n
cHJbaW5zbi0+cmVnbm9bMV1dOw0KPiA+ICAgICBUQ0d2IFJ0ViA9IGhleF9ncHJbaW5zbi0+cmVn
bm9bMl1dOw0KPiA+ICAgICBnZW5faGVscGVyX0EyX2FkZChSZFYsIGNwdV9lbnYsIFJzViwgUnRW
KTsNCj4gPiAgICAgZ2VuX2xvZ19yZWdfd3JpdGUoUmROLCBSZFYpOw0KPiA+ICAgICBjdHhfbG9n
X3JlZ193cml0ZShjdHgsIFJkTik7DQo+ID4gICAgIHRjZ190ZW1wX2ZyZWUoUmRWKTsNCj4gPiB9
KQ0KPg0KPiBJIHdvdWxkIGJlIGhhcHBpZXIgaWYgdGhlIGVudGlyZSBmdW5jdGlvbiBib2R5IHdl
cmUgbm90IGluIGEgbWFjcm8uICBIYXZlIHlvdQ0KPiB0cmllZCB0byBzZXQgYSBnZGIgYnJlYWtw
b2ludCBpbiBvbmUgb2YgdGhlc2U/ICBPbmNlIHVwb24gYSB0aW1lIGF0IGxlYXN0LCB0aGlzDQo+
IHdvdWxkIGhhdmUgcmVzdWx0ZWQgaW4gYWxsIGxpbmVzIG9mIHRoZSBmdW5jdGlvbiBiZWNvbWlu
ZyBvbmUgInNvdXJjZSBsaW5lIiBpbg0KPiB0aGUgZGVidWcgaW5mby4NCg0KR29vZCBwb2ludC4g
IEl0IHN0aWxsIGNvbWVzIG91dCBhcyBhIHNpbmdsZSBsaW5lLg0KDQo+IEkgYWxzbyB0aGluayB0
aGUgZnVsbCBmdW5jdGlvbiBwcm90b3R5cGUgaXMgdW5uZWNlc3NhcnksIGFuZCB0aGUgcmVwbGlj
YXRpb24gb2YNCj4gIkEyX2FkZCIgdW5kZXNpcmFibGUuDQo+DQo+IEkgd291bGQgcHJlZmVyIHRo
ZSBmdW5jdGlvbiBwcm90b3R5cGUgaXRzZWxmIHRvIGJlIG1hY3JvLWl6ZWQuDQo+DQo+IEUuZy4N
Cj4NCj4gREVGX1RDR19GVU5DKEEyX2FkZCkNCj4gew0KPiAgICAgVENHdiBSZFYgPSB0Y2dfdGVt
cF9sb2NhbF9uZXcoKTsNCj4gICAgIGNvbnN0IGludCBSZE4gPSBpbnNuLT5yZWdub1swXTsNCj4g
ICAgIFRDR3YgUnNWID0gaGV4X2dwcltpbnNuLT5yZWdub1sxXV07DQo+ICAgICBUQ0d2IFJ0ViA9
IGhleF9ncHJbaW5zbi0+cmVnbm9bMl1dOw0KPiAgICAgZ2VuX2hlbHBlcl9BMl9hZGQoUmRWLCBj
cHVfZW52LCBSc1YsIFJ0Vik7DQo+ICAgICBnZW5fbG9nX3JlZ193cml0ZShSZE4sIFJkVik7DQo+
ICAgICBjdHhfbG9nX3JlZ193cml0ZShjdHgsIFJkTik7DQo+ICAgICB0Y2dfdGVtcF9mcmVlKFJk
Vik7DQo+IH0NCj4NCj4gd2l0aA0KPg0KPiAjZGVmaW5lIERFRl9UQ0dfRlVOQyhUQUcpICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBcDQo+ICAgICBzdGF0aWMgdm9pZCBnZW5lcmF0ZV8jI1RB
RyhDUFVIZXhhZ29uU3RhdGUgKmVudiwgIFwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIERpc2FzQ29udGV4dCAqY3R4LCAgICAgXA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaW5zbl90ICppbnNuLCAgICAgICAgICBcDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBwYWNrZXRfdCAqcGt0KQ0KPg0KPiA+IEFuZCBoZXJlIGlzIGhvdyB0aGUgZ2VuZXJh
dGVkIGZpbGUgZ2V0cyB1c2VkIGluIGdlbnB0ci5jDQo+ID4NCj4gPiAjZGVmaW5lIERFRl9UQ0df
RlVOQyhUQUcsIEdFTkZOKSBcDQo+ID4gICAgIEdFTkZODQo+ID4gI2luY2x1ZGUgInRjZ19mdW5j
c19nZW5lcmF0ZWQuaCINCj4gPiAjdW5kZWYgREVGX1RDR19GVU5DDQo+ID4NCj4gPiAvKg0KPiA+
ICAqIE5vdCBhbGwgb3Bjb2RlcyBoYXZlIGdlbmVyYXRlXzx0YWc+IGZ1bmN0aW9ucywgc28gaW5p
dGlhbGl6ZQ0KPiA+ICAqIHRoZSB0YWJsZSBmcm9tIHRoZSB0Y2dfZnVuY3NfZ2VuZXJhdGVkLmgg
ZmlsZS4NCj4gPiAgKi8NCj4gPiBjb25zdCBzZW1hbnRpY19pbnNuX3Qgb3Bjb2RlX2dlbnB0cltY
WF9MQVNUX09QQ09ERV0gPSB7DQo+ID4gI2RlZmluZSBERUZfVENHX0ZVTkMoVEFHLCBHRU5GTikg
XA0KPiA+ICAgICBbVEFHXSA9IGdlbmVyYXRlXyMjVEFHLA0KPiA+ICNpbmNsdWRlICJ0Y2dfZnVu
Y3NfZ2VuZXJhdGVkLmgiDQo+ID4gI3VuZGVmIERFRl9UQ0dfRlVOQw0KPiA+IH07DQo+DQo+IE9i
dmlvdXNseSwgdGhlIG1hY3JvIEkgcHJvcG9zZSBhYm92ZSBjYW5ub3QgYmUgZGlyZWN0bHkgcmV1
c2VkLCBhcyB5b3UgZG8NCj4gaGVyZS4NCj4gIEJ1dCBJIGFsc28gdGhpbmsgd2Ugc2hvdWxkIG5v
dCB0cnkgdG8gZG8gc28uDQo+DQo+IFlvdSd2ZSBnb3QgYSBzY3JpcHQgZ2VuZXJhdGluZyBzdHVm
Zi4gIEl0IGNhbiBqdXN0IGFzIGVhc2lseSBnZW5lcmF0ZSB0d28NCj4gZGlmZmVyZW50IGxpc3Rz
LiAgWW91J3JlIHRyeWluZyB0byBkbyB0b28gbXVjaCB3aXRoIHRoZSBDIHByZXByb2Nlc3NvciBh
bmQgdG9vDQo+IGxpdHRsZSB3aXRoIHB5dGhvbi4NCg0KU3VyZSwgZ2VuZXJhdGluZyB0d28gbGlz
dHMgd2FzIGFsc28gc3VnZ2VzdGVkIGJ5IEFsZXNzYW5kcm8gKGFsZUByZXYubmcpLiAgQWx0aG91
Z2ggZG9pbmcgbW9yZSBpbiBweXRob24gYW5kIGxlc3Mgd2l0aCB0aGUgQyBwcmVwcm9jZXNzb3Ig
d291bGQgbGVhZCB0byB0aGUgY29uY2x1c2lvbiB3ZSBzaG91bGRuJ3QgZGVmaW5lIHRoZSBmdW5j
dGlvbiBwcm90b3R5cGUgaW4gYSBtYWNyby4gIElmIHdlIGdlbmVyYXRlIHR3byBsaXN0cywgd2hh
dCBpcyB0aGUgYWR2YW50YWdlIG9mIHB1dHRpbmcgdGhlIGZ1bmN0aW9uIHNpZ25hdHVyZSBpbiBh
IG1hY3JvIHZzIGdlbmVyYXRpbmc/DQoNCj4NCj4gQXQgc29tZSBwb2ludCBpbiB0aGUgdjMgdGhy
ZWFkLCBJIGhhZCBzdWdnZXN0ZWQgZ3JlcHBpbmcgZm9yIHNvbWUgbWFjcm8gaW4NCj4gb3JkZXIg
dG8gaW5kaWNhdGUgdG8gdGhlIHB5dGhvbiBzY3JpcHQgd2hpY2ggdGFncyBhcmUgaW1wbGVtZW50
ZWQgbWFudWFsbHkuDQo+IE15DQo+IGRlZmluaXRpb24gYWJvdmUgaXMgZWFzeSB0byBsb29rIGZv
cjogZXhhY3RseSBvbmUgdGhpbmcgb24gdGhlIGxpbmUsIGVhc3kNCj4gcmVnZXhwLg0KDQpUaGlz
IGlzIGFscmVhZHkgZG9uZSBhcyB3ZWxsLiAgQXMgeW91IG1heSByZWNhbGwsIHdlIHdlcmUgcHJl
dmlvdXNseSBnZW5lcmF0aW5nDQogICAgI2lmZGVmIGZHRU5fVENHX0EyX2FkZA0KICAgIGZHRU5f
VENHX0EyX2FkZCh7IFJkVj1Sc1YrUnRWO30pOw0KICAgICNlbHNlDQogICAgZG8gew0KICAgIGdl
bl9oZWxwZXJfQTJfYWRkKFJkViwgY3B1X2VudiwgUnNWLCBSdFYpOw0KICAgIH0gd2hpbGUgKDAp
Ow0KDQpUaGUgZ2VuZXJhdG9yIG5vdyBzZWFyY2hlcyBmb3IgIiNkZWZpbmUgZkdFTl9UQ0dfPHRh
Zz4iIGFuZCBnZW5lcmF0ZXMgZGlmZmVyZW50IGNvZGUgZGVwZW5kaW5nIG9uIHdoYXQgaXQgZmlu
ZHMuICBUaGlzIHZlcnNpb24gb2YgdGhlIHNlcmllcyBvbmx5IGNvbnRhaW5zIG92ZXJyaWRlcyB0
aGF0IGFyZSByZXF1aXJlZCBmb3IgY29ycmVjdCBleGVjdXRpb24uICBTbywgQTJfYWRkIGlzbid0
IHRoZXJlLiAgV2hlbiB3ZSBkbyBvdmVycmlkZSBpdCwgdGhlIGdlbmVyYXRvciBwcm9kdWNlcyB0
aGlzDQoNCnN0YXRpYyB2b2lkIGdlbmVyYXRlX0EyX2FkZCgNCiAgICAgICAgICAgICAgICBDUFVI
ZXhhZ29uU3RhdGUgKmVudiwNCiAgICAgICAgICAgICAgICBEaXNhc0NvbnRleHQgKmN0eCwNCiAg
ICAgICAgICAgICAgICBpbnNuX3QgKmluc24sDQogICAgICAgICAgICAgICAgcGFja2V0X3QgKnBr
dCkNCnsNCiAgICBUQ0d2IFJkViA9IHRjZ190ZW1wX2xvY2FsX25ldygpOw0KICAgIGNvbnN0IGlu
dCBSZE4gPSBpbnNuLT5yZWdub1swXTsNCiAgICBUQ0d2IFJzViA9IGhleF9ncHJbaW5zbi0+cmVn
bm9bMV1dOw0KICAgIFRDR3YgUnRWID0gaGV4X2dwcltpbnNuLT5yZWdub1syXV07DQogICAgZkdF
Tl9UQ0dfQTJfYWRkKHsgUmRWPVJzVitSdFY7fSk7ICAgICAgICAgICAgICAgICAgPC0tLS0gVGhp
cyBsaW5lIGlzIGRpZmZlcmVudA0KICAgIGdlbl9sb2dfcmVnX3dyaXRlKFJkTiwgUmRWKTsNCiAg
ICBjdHhfbG9nX3JlZ193cml0ZShjdHgsIFJkTik7DQogICAgdGNnX3RlbXBfZnJlZShSZFYpOw0K
fQ0KDQpBbHNvLCBpZiBpdCBmaW5kcyB0aGUgb3ZlcnJpZGUsIGl0IGRvZXNuJ3QgZ2VuZXJhdGUg
dGhlIERFRl9IRUxQRVIgb3IgdGhlIGhlbHBlciBmdW5jdGlvbi4gIFRoYXQgbWVhbnMgd2UgZG9u
J3QgaW5jbHVkZSB0Y2dfZ2VuLmggaW4gaGVscGVyLmggYXMgeW91IHN1Z2dlc3RlZC4NCg0KDQpU
aGFua3MsDQpUYXlsb3INCg0K

