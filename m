Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D0DC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 20:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A1B420757
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 20:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SvXd1mHu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="Icmhtem1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1B420757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMdi1-0001dG-Ja
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 16:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1jMdhM-00018h-Np
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 16:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1jMdhL-0004Gz-0H
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 16:22:51 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:58582)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1jMdhK-0004Fn-IM
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 16:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1586463770; x=1617999770;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TRPjeP2kKGJGqa94zBmWwjqgr64QSTZaV7ZwuKpLfIw=;
 b=SvXd1mHuqDRrhN0edf+QqaEj5KWdqN/07lhny7Is5DwC0aSfzBtD3H1t
 oecKKdRbdEss1sUwNkrUwtmiQ7gSC3jFBVp5FNGLvaMnP+SmvWup2lJzn
 bjQFJVtKcEIovjl4yCWEJuLtkHYjydBP7YCR3IMwndDhXnPluvk421opT c=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Apr 2020 13:22:48 -0700
Received: from nasanexm03g.na.qualcomm.com ([10.85.0.49])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 09 Apr 2020 13:22:48 -0700
Received: from apsanexr02e.ap.qualcomm.com (10.85.0.28) by
 nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 9 Apr 2020 13:22:47 -0700
Received: from nasanexm03h.na.qualcomm.com (10.85.0.50) by
 apsanexr02e.ap.qualcomm.com (10.85.0.28) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 9 Apr 2020 13:22:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03h.na.qualcomm.com (10.85.0.50) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 9 Apr 2020 13:22:45 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB5656.namprd02.prod.outlook.com (2603:10b6:a03:96::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Thu, 9 Apr
 2020 20:22:44 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::f09d:8640:4c4e:9803]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::f09d:8640:4c4e:9803%6]) with mapi id 15.20.2900.015; Thu, 9 Apr 2020
 20:22:44 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: "bcain@codeaurora.org" <bcain@codeaurora.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v2 20/67] Hexagon instruction utility functions
Thread-Topic: [RFC PATCH v2 20/67] Hexagon instruction utility functions
Thread-Index: AQHV7lZiglbdn13CRkOt6bs3YimnOqhxY5GAgAAYjWA=
Date: Thu, 9 Apr 2020 20:22:44 +0000
Message-ID: <BYAPR02MB4886A123EB6D0DF1362F9003DEC10@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1582908244-304-1-git-send-email-tsimpson@quicinc.com>
 <1582908244-304-21-git-send-email-tsimpson@quicinc.com>
 <094101d60ea0$204c0ee0$60e42ca0$@codeaurora.org>
In-Reply-To: <094101d60ea0$204c0ee0$60e42ca0$@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [70.115.140.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6149a29d-15b6-48cb-2be2-08d7dcc3c30b
x-ms-traffictypediagnostic: BYAPR02MB5656:
x-microsoft-antispam-prvs: <BYAPR02MB5656C5110E4102726FEC8BB6DEC10@BYAPR02MB5656.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0368E78B5B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(136003)(396003)(39860400002)(376002)(366004)(346002)(76116006)(66946007)(66556008)(66446008)(64756008)(66476007)(5660300002)(52536014)(26005)(86362001)(186003)(81166007)(478600001)(110136005)(54906003)(7696005)(53546011)(6506007)(4326008)(71200400001)(33656002)(2906002)(316002)(8936002)(55016002)(9686003)(8676002)(81156014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JSJSxDqBTakD2dtyozAN8pbU/bMVUhW2khRRj4uUv+O+cF3/D4lGauMSkbeOH2M4jvAFAHl/HBRN8aEjz6CSi5SnJC27rhpepQ4nmgdaBElbqNQmUZJQSon9puLzIxC9lt/aztxKnoTgFJ6fU4bypEmPAtwyuSK7xCx2JUu95fhAgIsfr4YzCQbtuin4ft1Tp04O0sUv1MiTxFQDH/QDWYwASe+TVrI3UggbOs7me7kO+4XgLwe9TiyK2PT+20JRiT7hGJwALXaLJi2upObc3W/tStyPb6gIGyxXpVANNMZqj3QXS0ZCzPYffbG1d1hxNeNWMMsYpf9g6fCV/BQXGY4A7VIQ3R3yadyZ5ukVmUKpOeX/zzBXfsgBh4ZCOvAR1RX/4XsrFuMqDay5CTHAbup3vikzw6B90w96l3mxeNvlaziJF/7u/BKCkVCeZ7Tg
x-ms-exchange-antispam-messagedata: Qj4fCpyAl+yNbeIVXL5Y+BOS5Rvv/4cfmNlLIMRqlO1aOlKzOAe9iV5XemAJvZNkjLN+dp24jmPMiwNuBjHtw7C9/ASNxfv3MeQVk9iv1fbHgPAoD75Mu3XlIQwmEHbazzzo6WPKSi038tiyq/1MiA==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3OP7/pKUctbvNiK/202rpYrpzA5+PndutFnn6AgYE8DNrE9b/ANPalyH+4Z/jtY9cZNv1uRtos7OjTd2+GzVhzAgP4KuBopv5HUF11AdbrK73BK5NaBW+nKjiwVbm6kqFZObPdhJMaPGrW07wNxi7pOlzNnTJX3/5uf4+ZVevOVbjtuG19Zlf2rkLMiehXjETkaQOHobriRRuI1DcXQ+XWvRlpZzwJ6iWj3csWM9vYTehyfYJQznrwKhOX46l+vmYxoPLRUT5BvstHcoy/ppkqogIH3wbnRe96bUgqYowkaGPRxK01fh9AT/kSjGwaxlOy3mAjHi7couz/81un5OQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPdSNuqKmzPImKYJMkly8e1bKEZvlZte7lYPytUZZCg=;
 b=guq6Wq2JlMj8PLCCOK9Boblk0x/mUpwwBkeyFLhC7NQdz5Bq/znBBWpBQfYG70QsSEJmeRJZiku3VkXP4oQkNAVAKki4ZQiCVT5Jo6qrpmsg21XmY08K4vQBapYDObzZdbGbqXVd6qergHEXJPgP/WA6a+cYTetwWO/J70bAy91gUnJ2X9PYi7QKFNFwq9CvpwMiZZSkmpTVc6eFxYlwG7nHdxAlFWrgWQ9kIj8fDpgESc+EY+vR0IHW12r0d4jSumv/65a+A5VInxsC3sxFBmVPr1ka5QxBN0RrhQMoZJyxa4HO7VHP6SNVGfp6jgBQIT8ts/BxbgTUSgV62Ul0Jg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPdSNuqKmzPImKYJMkly8e1bKEZvlZte7lYPytUZZCg=;
 b=Icmhtem1ONtg2Ea5o/lyF3SuH34l7PCZEhmq7oBT5mtgKrYT/BglJewQ+DXiN0/aFJKgcFeYhGlS1FzLkGmEVMop1IsIj0jt1w44/vWp8sa9SgVXKdWftaad3dxKTqiA2yFkyePSGkUfEcytx7sNw7T6Z4R8zdHNupGZP+PmjMI=
x-ms-exchange-crosstenant-network-message-id: 6149a29d-15b6-48cb-2be2-08d7dcc3c30b
x-ms-exchange-crosstenant-originalarrivaltime: 09 Apr 2020 20:22:44.3628 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 34FefAVrLJ0npYEsP6vfDVVIvc0WwLys5tIC2Bi6DzL5ENzKmVM6OyeVIQKO7jGscUiAnz+U2PQsddeNR/vfVQ==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB5656
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.39
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
Cc: "philmd@redhat.com" <philmd@redhat.com>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYmNhaW49Y29kZWF1cm9y
YS5vcmdAbWcuY29kZWF1cm9yYS5vcmcNCj4gPGJjYWluPWNvZGVhdXJvcmEub3JnQG1nLmNvZGVh
dXJvcmEub3JnPiBPbiBCZWhhbGYgT2YgQnJpYW4gQ2Fpbg0KPiBTZW50OiBUaHVyc2RheSwgQXBy
aWwgOSwgMjAyMCAxOjUzIFBNDQo+IFRvOiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2lu
Yy5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHJpa3Uudm9pcGlvQGlraS5maTsg
cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZzsgbGF1cmVudEB2aXZpZXIuZXU7DQo+IHBoaWxt
ZEByZWRoYXQuY29tOyBhbGVrc2FuZGFyLm0ubWFpbEBnbWFpbC5jb20NCj4gU3ViamVjdDogUkU6
IFtSRkMgUEFUQ0ggdjIgMjAvNjddIEhleGFnb24gaW5zdHJ1Y3Rpb24gdXRpbGl0eSBmdW5jdGlv
bnMNCj4NCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFFlbXUtZGV2
ZWwgPHFlbXUtZGV2ZWwtDQo+ID4gYm91bmNlcytiY2Fpbj1jb2RlYXVyb3JhLm9yZ0Bub25nbnUu
b3JnPiBPbiBCZWhhbGYgT2YgVGF5bG9yDQo+IFNpbXBzb24NCj4gPiBTZW50OiBGcmlkYXksIEZl
YnJ1YXJ5IDI4LCAyMDIwIDEwOjQzIEFNDQo+ID4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0K
PiA+IENjOiByaWt1LnZvaXBpb0Bpa2kuZmk7IHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc7
IGxhdXJlbnRAdml2aWVyLmV1Ow0KPiA+IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5j
LmNvbT47IHBoaWxtZEByZWRoYXQuY29tOw0KPiA+IGFsZWtzYW5kYXIubS5tYWlsQGdtYWlsLmNv
bQ0KPiA+IFN1YmplY3Q6IFtSRkMgUEFUQ0ggdjIgMjAvNjddIEhleGFnb24gaW5zdHJ1Y3Rpb24g
dXRpbGl0eSBmdW5jdGlvbnMNCj4gLi4uDQo+ID4gK2ludCBhcmNoX3NmX2ludnNxcnRfY29tbW9u
KHNpemU0c190ICpScywgc2l6ZTRzX3QgKlJkLCBpbnQgKmFkanVzdCkNCj4gPiArew0KPiAuLi4N
Cj4gPiArICAgIH0gZWxzZSBpZiAocl9jbGFzcyA9PSBGUF9JTkZJTklURSkgew0KPiA+ICsgICAg
ICAgIC8qIEVKUDogb3IgcHV0IEluZiBpbiBudW0gZml4dXA/ICovDQo+ID4gKyAgICAgICAgUnNW
ID0gZlNGSU5GVkFMKC0xKTsNCj4gPiArICAgICAgICBSZFYgPSBmU0ZJTkZWQUwoLTEpOw0KPiA+
ICsgICAgfSBlbHNlIGlmIChyX2NsYXNzID09IEZQX1pFUk8pIHsNCj4gPiArICAgICAgICAvKiBF
SlA6IG9yIHB1dCB6ZXJvIGluIG51bSBmaXh1cD8gKi8NCj4gPiArICAgICAgICBSc1YgPSBSc1Y7
DQo+ID4gKyAgICAgICAgUmRWID0gZlNGT05FVkFMKDApOw0KPiAuLi4NCj4NCj4gVGhpcyAiUnNW
ID0gUnNWIiBsb29rcyBsaWtlIGEgbG9naWMgZXJyb3I/ICBQcmVzdW1hYmx5IGl0J3Mgc2FmZSB0
byByZW1vdmUgLS0NCj4gdW5sZXNzIHRoZXJlJ3Mgc29tZSBvdGhlciBmaWVsZCB0aGF0IHNob3Vs
ZCBnZXQgaW5pdGlhbGl6ZWQgaGVyZT8gIFBlViBtYXliZT8NCg0KUHJvYmFibHkgYSBjb3B5L3Bh
c3RlIGVycm9yLiAgSSB3aWxsIHJlbW92ZSBpdC4NCg0KVGhhbmtzLA0KVGF5bG9yDQoNCg==

