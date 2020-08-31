Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10722C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 23:11:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7AD82064B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 23:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VhQ+oxKO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="jytDpsPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7AD82064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCsxG-00044P-PH
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 19:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCswV-0003J2-2H
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 19:10:27 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:53803)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCswS-0005dk-D3
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 19:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598915424; x=1630451424;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=g6DKvyYdKWRjIgF8wQ3scpk/nGXRsIg593yvMyOuK2c=;
 b=VhQ+oxKO877gazFHNAfr2FbzPz0cqFAfGTRNWjZFkQFKcDxKLPFROAf9
 OjgpUMZqtVWM6OqVniBVXJNjujs3xX3ckb2TqPnYr81JX6FOjdTzvQgY+
 Y8DjI4ZrDY66Zkluo+hn294VnpN+t/HeZnqBHOAGuT0ylteVeZTXGQxXf s=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 31 Aug 2020 16:10:20 -0700
Received: from nasanexm03g.na.qualcomm.com ([10.85.0.49])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 31 Aug 2020 16:10:19 -0700
Received: from APSANEXR01A.ap.qualcomm.com (10.85.0.36) by
 nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 31 Aug 2020 16:10:19 -0700
Received: from nasanexm03c.na.qualcomm.com (10.85.0.106) by
 APSANEXR01A.ap.qualcomm.com (10.85.0.36) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 31 Aug 2020 16:10:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 31 Aug 2020 16:10:19 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4662.namprd02.prod.outlook.com (2603:10b6:a03:44::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Mon, 31 Aug
 2020 23:10:18 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01%7]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 23:10:17 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 30/34] Hexagon (target/hexagon) TCG for
 instructions with multiple definitions
Thread-Topic: [RFC PATCH v3 30/34] Hexagon (target/hexagon) TCG for
 instructions with multiple definitions
Thread-Index: AQHWdXdjR65U8vNpmEiviytk7eiWcalOZgsAgAK5LuCAABqagIAAAiTQgAAjBACAASHoAIAADK2AgAAIhJCAABaEgIAAAzsA
Date: Mon, 31 Aug 2020 23:10:17 +0000
Message-ID: <BYAPR02MB4886B33025BE2B65D6F5F5A8DE510@BYAPR02MB4886.namprd02.prod.outlook.com>
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
In-Reply-To: <0241f731-61de-41bc-9f58-bc43725eef74@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07cb56fd-6525-412a-f4b3-08d84e0306cc
x-ms-traffictypediagnostic: BYAPR02MB4662:
x-microsoft-antispam-prvs: <BYAPR02MB4662CBA7FD407D28AA646DB1DE510@BYAPR02MB4662.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q8uRp6vmjhBDZ0cYO3UlDJUykNclprQUSch4xQUA/XBk/yfU8DBaz9bGpZmAXX1b8qsqTcNvJ73Gi7ljkRLrSLAzZPzLUXQqbpe9YFoCi9jzgBtfrVf2zhx/n3tiK0IsB0vYEP2Uj8ATcDShDxSTosZjAOMkeAzG9TqC93lFBSrqbzw+IQTsDoYlaC+lPxFEiky0uSkSYOhwYfvUjGQMd45LH2frvIFaVhNDxHjiqXCInvJ1VeatXefKoQdru/EDt4sHLI47JnRd29XDamD6rUdKHPj4SIyzRQgcwTGwGQ38JqA6nDVCK26E5MWwhbrolIsfMeSz0wsAuQfrARPWmA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(366004)(396003)(346002)(39860400002)(136003)(4326008)(66446008)(71200400001)(9686003)(33656002)(55016002)(83380400001)(8676002)(8936002)(478600001)(64756008)(66556008)(66476007)(76116006)(6506007)(2906002)(53546011)(186003)(66946007)(86362001)(52536014)(26005)(316002)(5660300002)(7696005)(110136005)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: mKu+T2lqq3G5eLWk8SfGensFlGSxrLtaG+iCKiTZFT2YUe/F4mRXZz0oXdRZ8OWSUSbhQQQjD7kotFM4E/roXviMCDy5GIFr10ta29/Qt0D/nY/8fAestauJi2KmR62FIik7Mwu27UcHCzsjz4ZHnm4J4XMW3R4acX5eghVC98ghqlhehShiQJuKPffA1grv1eCvHxBJCRTcwj/cwSWQiiQLLE1SxHUvfrh74Us2L//IHCKL0tzlioK5qYZl/oPUrv2+uw9aQGv/MLghGMiPr5zU8PfuOXHeL3U7ehCqvMzebAwy7AlXovPUUxWclR9Q1HfkU9GWV2TcvY4VenG6QBRvTYzyeHaJkYkEagEKJxV0gR+WOxb4l9CBUxjdtE/8LNP2VNtM14IoPOctfhstJ4cFeBiLx5TlY1YhWkvOpz8blwFl6Kdl3klEDFb2It8vvM+atVez0/qn6soZR+draaT2gFLq3XyOXAQhEAx1JOVfxCLZt1hrWHUsmbdz4HEtl7jzxN9qEcHfnu9ysca/mVMoUJCu5VDI5hhx/kEHDhxQnUpj6GCPdVhF8IuYt/4YPq4Hn5woKIXXP2QKPxLrF1c2nVbtGDlRgyRSI0RUWCvocdVFInR21V1eeeF6Yt3iLgyladXOxMhcfVqhjmo3/g==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQMtBgd7U4ZvD78x7GXGHD1B20xvQQ0ClGK9bH6nYoAo2PZCtpWW/J3SKMkNFqU08v9CUmAMg4+exsRu2atiq/b9tOOZmz4X3UT6HuaYc5PXZGNRpKgywKpo3p6dEzESn6egw+3kCoj1tIhUQLveOkJbl7bk503cxzLcKCbdCzsdc30b/ZJCXbJN57wCikx3srmk+dHJ73MQSeEH9+qUmCW3TlVNd02wlaVHoDLqfa+iC2BLYiEVv3EqPf4JX3iin65InHyRIlN+8AzN6NesFgcqzN3CNQY9iFd5X7WBjeseP7VbaKr5zr+BZUEQVxTOigMKEU2koTkPycMsowFHeA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odboJ8r3kTcbzy617aJsQ8sWTHskpL+TSOVOebMkZak=;
 b=AyEld4Kimvi8xAuQzT0F/t9E3dHtSt7/dsRk3+Sz/BAUgDZ3nX7KlTNXo65U6+0rIJYBa7lPWozE7YqgfBUlRMVbRCEXDMCtqTXQ4esavioMqF926y0KTo7gKcVyDwMz9/5yaOwGZ3q3mVgyI8oBcZyxhXYehsb5ek+mZHHd4gaeXaVPifV2eFiXRXJseAzvZ8Bk4uxcDYjIBxMCViPJD11VKtSHzaFA39UJ1g9++hJbwXVicj+LhaAyxmD+90aZdiEjfXX3avBabcK1T06cJMxW2iEmgpoxyLqwGnl0HV96f5Zwp7YzXAX7LmHd7DbWzZ4apTLdJdSnEKwmhaPXDQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odboJ8r3kTcbzy617aJsQ8sWTHskpL+TSOVOebMkZak=;
 b=jytDpsPwbehYBf4EkFWj5fvBQeBm25wOoWuA/4/U1B4erV0PRaXL1mJzdUcounDZTmmxD3Zb9ATmyCLw0MZWYnyRR9lfv58hWfeQXAJ1UHw0KRmlZ8bxLASO7KSQinLnPEziycbduQ2P/XIaZvhW7INrON0UWF7u56XP22NXe/k=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 07cb56fd-6525-412a-f4b3-08d84e0306cc
x-ms-exchange-crosstenant-originalarrivaltime: 31 Aug 2020 23:10:17.6820 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: AXVoSEjWRXHz6eqNZ6s2LFX5e4uRBYD1yXvcRweGNNbMb158kGo2sorxo15fF9ms+fDWvMpF89X137gx9ypRgg==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4662
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.38; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 19:10:21
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
IDMxLCAyMDIwIDE6MjAgUE0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5j
LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGhpbG1kQHJlZGhhdC5jb207IGxh
dXJlbnRAdml2aWVyLmV1OyByaWt1LnZvaXBpb0Bpa2kuZmk7DQo+IGFsZWtzYW5kYXIubS5tYWls
QGdtYWlsLmNvbTsgYWxlQHJldi5uZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAzMC8z
NF0gSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIFRDRyBmb3INCj4gaW5zdHJ1Y3Rpb25zIHdpdGgg
bXVsdGlwbGUgZGVmaW5pdGlvbnMNCj4NCj4gVGhlIGZHRU5fVENHX0EyX2FkZCBtYWNybyBkb2Vz
IG5vdCByZXF1aXJlIG5vciB1c2UgdGhhdCB7Li4ufSBhcmd1bWVudC4NCg0KVGhlIGZHRU5fVENH
X0EyX2FkZCBtYWNybyBkb2VzIG5lZWQgdGhhdCBhcmd1bWVudCwgYnV0IHRoZXJlIGFyZSBjYXNl
cyB0aGF0IGRvIG5lZWQgaXQuICBIZXJlJ3MgYW4gZXhhbXBsZSBmcm9tIGdlbl90Y2cuaA0KICAg
ICNkZWZpbmUgZkdFTl9UQ0dfTDJfbG9hZHJ1Yl9wcihTSE9SVENPREUpICAgICAgU0hPUlRDT0RF
DQpUaGlzIGlzIGV4cGxhaW5lZCBpbiB0aGUgUkVBRE1FLCBidXQgYmFzaWNhbGx5IHRoZSBhcmd1
bWVudCBpcyB1c2VmdWwgaWYgd2UgY2FuIHByb3Blcmx5IGRlZmluZSB0aGUgbWFjcm9zIHRoYXQg
aXQgY29udGFpbnMgdG8gZ2VuZXJhdGUgVENHLg0KDQoNCj4gV2hhdCBpdCAqZG9lcyogbmVlZCBh
cmUgdGhlIHNhbWUgYXJndW1lbnRzIGFzIGFyZSBnaXZlbiB0byBnZW5lcmF0ZV88cnRhZz4uICBJ
DQo+IGFzc3VtZSB5b3UgYXJlIHVzaW5nIHRob3NlIGFyZ3VtZW50cyBpbXBsaWNpdGx5IGluIHlv
dXIgY3VycmVudA0KPiBmR0VOX1RDR188cnRhZz4NCj4gaW5zdGFuY2VzPw0KDQpZZXMNCg0KPg0K
PiBJdCB3b3VsZCBiZSBjbGVhbmVzdCB0byBvbmx5IGhhdmUgdGhlIGdlbmVyYXRlXyogZnVuY3Rp
b25zLg0KPg0KPiBFaXRoZXIgdGhleSBhcmUgd3JpdHRlbiBieSBoYW5kIChyZXBsYWNpbmcgdGhl
IGN1cnJlbnQgZkdFTl9UQ0dfKiksIG9yIHRoZXkNCj4gYXJlDQo+IGdlbmVyYXRlZC4gIEluIGVp
dGhlciBjYXNlLCB0aGVyZSdzIGp1c3QgdGhlIG9uZSBsZXZlbCBvZiBpbmRpcmVjdGlvbiBmcm9t
DQo+IG9wY29kZV9nZW5wdHJbXS4NCj4NCj4gSSdkIGltYWdpbmUNCj4NCj4gLS0tIGdlbnB0ci5j
DQo+DQo+ICNkZWZpbmUgREVGX1RDR19GVU5DKFRBRykgXA0KPiBzdGF0aWMgdm9pZCBnZW5lcmF0
ZV8jI1RBRyhDUFVIZXhhZ29uU3RhdGUgKmVudiwgXA0KPiAgICAgRGlzYXNDb250ZXh0ICpjdHgs
IGluc25fdCAqaW5zbiwgcGFja2V0X3QgKnBrdCkNCj4NCj4gLyoNCj4gICogQWxsIElJRHMgd2l0
aCBhbiBleHBsaWNpdCBpbXBsZW1lbnRhdGlvbiwNCj4gICogb3ZlcnJpZGluZyB0aGUgYXV0by1n
ZW5lcmF0ZWQgaGVscGVyIGZ1bmN0aW9ucy4NCj4gICovDQo+DQo+IERFRl9UQ0dfRlVOQyhBMl9h
ZGQpDQo+IHsNCj4gICAgIC8qIHsgUmRWPVJzVitSdFY7fSAqLw0KPiAgICAgdGNnX2dlbl9hZGRf
dGwoYXJncy4uLik7DQo+IH0NCg0KVGhlcmUncyBhZGRpdGlvbmFsIGdlbmVyYXRlZCBjb2RlIGJl
Zm9yZSBhbmQgYWZ0ZXIgdGhlIHRjZ19nZW5fYWRkX3RsLiAgSU1PLCB3ZSBkb24ndCB3YW50IHRo
ZSBwZXJzb24gd2hvIHdyaXRlcyBhbiBvdmVycmlkZSBoYXZpbmcgdG8gcmVwcm9kdWNlIHRoZSBn
ZW5lcmF0ZWQgY29kZS4gIEFzc3VtaW5nIHdlIGhhdmUgYSBkZWZpbml0aW9uIG9mIGZHRU5fVENH
X0EyX2FkZCBhbmQgd2UgaGF2ZSB0aGUgZ2VuZXJhdG9yIGludGVsbGlnZW50bHkgZXhwYW5kaW5n
IHRoZSBtYWNyb3MsIHRoaXMgaXMgd2hhdCB3aWxsIGJlIGdlbmVyYXRlZC4NCg0Kc3RhdGljIHZv
aWQgZ2VuZXJhdGVfQTJfYWRkKENQVUhleGFnb25TdGF0ZSAqZW52LCBEaXNhc0NvbnRleHQgKmN0
eCwgaW5zbl90ICppbnNuLCBwYWNrZXRfdCAqcGt0KQ0Kew0KLyogQTJfYWRkICovDQppbnQgUmRO
ID1pbnNuLT5yZWdub1swXTsNClRDR3YgUmRWID0gdGNnX3RlbXBfbG9jYWxfbmV3KCk7DQppbnQg
UnNOID0gaW5zbi0+cmVnbm9bMV07DQpUQ0d2IFJzViA9IGhleF9ncHJbUnNOXTsNCmludCBSdE4g
PSBpbnNuLT5yZWdub1syXTsNClRDR3YgUnRWID0gaGV4X2dwcltSdE5dOw0KDQpmR0VOX1RDR19B
Ml9hZGQoeyBSZFY9UnNWK1J0Vjt9KTsNCg0KZ2VuX2xvZ19yZWdfd3JpdGUoUmROLCBSZFYsIGlu
c24tPnNsb3QsIDApOw0KY3R4X2xvZ19yZWdfd3JpdGUoY3R4LCBSZE4pOw0KDQp0Y2dfdGVtcF9m
cmVlKFJkVik7DQovKiBBMl9hZGQgKi8NCn0NCg0KSWYgdGhlcmUgd2VyZW4ndCBhbiBvdmVycmlk
ZSwgd2UnZCBnZXQgdGhpcw0KDQpzdGF0aWMgdm9pZCBnZW5lcmF0ZV9BMl9hZGQoQ1BVSGV4YWdv
blN0YXRlICplbnYsIERpc2FzQ29udGV4dCAqY3R4LCBpbnNuX3QgKmluc24sIHBhY2tldF90ICpw
a3QpDQp7DQovKiBBMl9hZGQgKi8NCmludCBSZE4gPWluc24tPnJlZ25vWzBdOw0KVENHdiBSZFYg
PSB0Y2dfdGVtcF9sb2NhbF9uZXcoKTsNCmludCBSc04gPSBpbnNuLT5yZWdub1sxXTsNClRDR3Yg
UnNWID0gaGV4X2dwcltSc05dOw0KaW50IFJ0TiA9IGluc24tPnJlZ25vWzJdOw0KVENHdiBSdFYg
PSBoZXhfZ3ByW1J0Tl07DQoNCmdlbl9oZWxwZXJfQTJfYWRkKFJkViwgY3B1X2VudiwgUnNWLCBS
dFYpOyAgICAgICAgICAgICAgICAgICAgLyogT25seSBkaWZmZXJlbmNlIGlzIHRoaXMgbGluZSAq
Lw0KDQpnZW5fbG9nX3JlZ193cml0ZShSZE4sIFJkViwgaW5zbi0+c2xvdCwgMCk7DQpjdHhfbG9n
X3JlZ193cml0ZShjdHgsIFJkTik7DQoNCnRjZ190ZW1wX2ZyZWUoUmRWKTsNCi8qIEEyX2FkZCAq
Lw0KfQ0KDQpUaGUgZkdFTl9UQ0dfPHRhZz4gbWFjcm8gY2FuIGFsc28gbWVudGlvbiB0aGUgb3Bl
cmFuZHMgb2YgdGhlIGluc3RydWN0aW9uIChSZFYsIFJzViwgUnRWIGluIHRoaXMgZXhhbXBsZSku
DQoNClVubGlrZSB0aGUgZ2VuZXJhdGVfPHRhZz4gZnVuY3Rpb25zIHRoYXQgYWxsIGhhdmUgdGhl
IHNhbWUgc2lnbmF0dXJlLiAgVGhlIG92ZXJyaWRlcyB3b3VsZCBoYXZlIGRpZmZlcmVudCBzaWdu
YXR1cmVzLiAgVGhpcyB3b3VsZCBiZSBtb3JlIGRlZmVuc2l2ZSBwcm9ncmFtbWluZyBiZWNhdXNl
IHlvdSBrbm93IGV4YWN0bHkgd2hlcmUgdGhlIHZhcmlhYmxlcyBjb21lIGZyb20gYnV0IG1vcmUg
dmVyYm9zZSB3aGVuIHdyaXRpbmcgdGhlIG92ZXJyaWRlcyBieSBoYW5kLiAgQWxzbywgbm90ZSB0
aGF0IHRoZXNlIG5lZWQgdG8gYmUgbWFjcm9zIGluIG9yZGVyIHRvIHRha2UgYWR2YW50YWdlIG9m
IHRoZSBTSE9SVENPREUuDQoNCkluIG90aGVyIHdvcmRzLCBpbnN0ZWFkIG9mDQojZGVmaW5lIGZH
RU5fVENHX0EyX2FkZChTSE9SVENPREUpICAgIHRjZ19nZW5fYWRkX3RsKFJkViwgUnNWLCBSdFYp
DQoNCldlIHdvdWxkIHdyaXRlDQojZGVmaW5lIGZHRU5fVENHX0EyX2FkZChlbnYsIGN0eCwgaW5z
biwgcGt0LCBSZFYsIFJzViwgUnRWLCBTSE9SVENPREUpICAgIHRjZ19nZW5fYWRkX3RsKFJkViwg
UnNWLCBSdFYpOw0KDQpQZXJzb25hbGx5LCBJIHByZWZlciB0aGUgZm9ybWVyLCBidXQgd2lsbCBj
aGFuZ2UgdG8gdGhlIGxhdHRlciBpZiB5b3UgZmVlbCBzdHJvbmdseS4NCg0KSSdtIG5vdCBtYXJy
aWVkIHRvIHRoZSBmR0VOX1RDR188dGFnPiBuYW1lLiAgREVGX1RDR188dGFnPiB3b3VsZCBhbHNv
IGJlIGZpbmUuDQoNCj4NCj4gLyoNCj4gICogR2VuZXJhdGUgY2FsbHMgdG8gdGhlIGF1dG8tZ2Vu
ZXJhdGUgaGVscGVycywNCj4gICogYW5kIHNsb3QgZXZlcnl0aGluZyBpbnRvIHRoZSBvcGNvZGVf
Z2VucHRyIHRhYmxlLg0KPiAgKi8NCj4gI2luY2x1ZGUgImdlbnB0cl9nZW5lcmF0ZWQuYy5pbmMi
DQo+DQo+IC0tLSBnZW5wdHJfZ2VuZXJhdGVkLmMuaW5jDQo+DQo+IERFRl9UQ0dfRlVOQyhBNF90
bGJtYXRjaCkNCj4gew0KPiAgICBnZW5faGVscGVyX0E0X3RsYm1hdGNoKGFyZ3MuLi4pOw0KPiB9
DQo+DQo+IC8vIGV0Yw0KPg0KPiBjb25zdCBTZW1hbnRpY0luc24gb3Bjb2RlX2dlbnB0cltdID0g
ew0KPiAgICAgLy8gQWxsIElJRCdzLCBnZW5lcmF0ZWQgb3Igbm90Lg0KPiB9Ow0KPg0KPiAtLS0N
Cj4NCj4gVGhpcyBsZWF2ZXMgZ2VucHRyLmMgYXMgdGhlIGZpbGUgdG8gZ3JlcCBmb3IgJ15ERUZf
VENHX0ZVTkMnLg0KPg0KPg0KPiByfg0K

