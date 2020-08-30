Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C85EC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 20:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E23D206FA
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 20:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VJ7qQfz1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="L2aFIr/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E23D206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCUFp-0006V2-Ba
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 16:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCUEl-0005Wc-1O
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 16:47:39 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:52785)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCUEi-0004pi-3h
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 16:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598820456; x=1630356456;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LhlyHYIEHfDaJZdXaLxzH5o+0s49bfUcmRxNFgjm6zc=;
 b=VJ7qQfz19xB+JN9zoj40aMjeUB1HQK8kfmy+Y0iCQCJnkm6lv3QI4GVJ
 O0gDogrxSRAMojrAKOeh7CkmCczGalSuUxBSbgM8uBgBgd1PxhA9b71rv
 9k4oK9jMUwQ1+x3v6TseMVzDAQmDQ1EmPezt2IMFN2ClN8dpJU0KNLGeQ Q=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 30 Aug 2020 13:47:34 -0700
Received: from nasanexm03a.na.qualcomm.com ([10.85.0.103])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 30 Aug 2020 13:47:34 -0700
Received: from nasanexm03g.na.qualcomm.com (10.85.0.49) by
 nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 30 Aug 2020 13:47:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Sun, 30 Aug 2020 13:47:33 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4261.namprd02.prod.outlook.com (2603:10b6:a03:14::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Sun, 30 Aug
 2020 20:47:32 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01%7]) with mapi id 15.20.3326.025; Sun, 30 Aug 2020
 20:47:32 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 00/34] Hexagon patch series
Thread-Topic: [RFC PATCH v3 00/34] Hexagon patch series
Thread-Index: AQHWdXdhC+P+V2qxTkGo6bPF07deGKlOfaQAgAKxJrA=
Date: Sun, 30 Aug 2020 20:47:31 +0000
Message-ID: <BYAPR02MB48862BC00AD7217B715EBFC7DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <fbb5a85b-6208-1791-0d3e-7e741e674a70@linaro.org>
In-Reply-To: <fbb5a85b-6208-1791-0d3e-7e741e674a70@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2dae801d-1005-44df-b26d-08d84d25eac4
x-ms-traffictypediagnostic: BYAPR02MB4261:
x-microsoft-antispam-prvs: <BYAPR02MB42619619C794237F5A512A8FDE500@BYAPR02MB4261.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4xDe072e9oB6VUkmC1kadSjb0OPbtUJVKgJ5/wYuD7Zw0vc8R6tg8DDdJwWP8WHfRd4PMeN0mqLpHjp0ECu8YcBAjj7/AO4KTVjGG0s//TtmGn/eExk+xCV6oBAjH13V5lWMsSjKRjDFKuTJkl1vbcs3VIqJRupQkowxpEDmrvDLyNabG+74FF218dSVAvWsY6zWdOsUTzyIRe6lEdahfmPBk/pd7RsMfoHWpBR94T+vO1w8pOwNaEtF5IUJwqUreR9zqGXaC2DsWh3Dz32ZtSelEPRMFN8EG3uAvevfI6G1HJx3tLYIFtUUyB4jrxwymjQw63Dac6kCOuIrBKYDwQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(136003)(366004)(396003)(39850400004)(346002)(5660300002)(316002)(52536014)(110136005)(54906003)(53546011)(8936002)(9686003)(8676002)(71200400001)(64756008)(66476007)(66446008)(66556008)(2906002)(76116006)(66946007)(55016002)(86362001)(478600001)(186003)(4326008)(33656002)(7696005)(6506007)(26005)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: ienRjR+CLBdTshK68+JHRtZiYTbj6WisVm7JmIVYDkWkG1HZP4Pe5JpzLHbs/HIgI0zbgPzrN4ahVJ7H8IHnBMQAtE01P9dsSL3WdGkmRvEMLcOYJ+hQiNJsdDwswDDeOGgca2K5POeRVHiCvIx4E6vqwOvVQQ3Nh74UGPuLAiHJ7Jvw7cA/ZarQUe6Ac0Q/kSjB1JwgSwdVxziEhQjfQa2ZakksBoCEAUEzRPOgtsAuYcPFd8tJuAKaTBEa4WEwlf1cJpXz3kfxZpMeI2UpXbWW+z6xwoNuPBYQ4lwXQBJweJl3nFM713zewY7jFxIHZVT/uJBZq0239UH1KSlnU8IA/qp61BsZg1AFloZRMJWSUNQysC6QI8DHtvzhb6FwI5CnYchKY+TvJTI5JWDvdTd2CO2kXVbx2sHS+Q6qcEM25IjRaqntZYO3yzzo271xrlLQey25cgPLTaMp4ASCUZJdIRc5bnvcgb99khs3gobu0hlzfI91ACoH2HEmXUBV6KA1h78HyD+xuOnPD5h775mQ0WC6qyaOpLsUEs1Yfi8Yw3qVOVR7FLHefxVrUPQ8/P2HIZ9TXD8dFtCO1gikVngTUKf8A6H9wP9i3xRgzutEnXvAMgBLsOfyBu3HY3Y0D6yl1nqafw2+3ZEGrLMuDQ==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWV8+TA5LI2J1gprCm1nHaX8pTSRp5wQktDjcSq2fP4m3X2gu7Uq75V1stzLfZUMRsL3qFIVJEQj2xilvYBEExQdCeLrHIHXARlXqk/2LpBpc/P2Vb25HQ0+c/QOMWjKGRkg2kRYCW3ydnnX6TX8lq5oWzn/afRYMBt+iOTqPF2JhWJXd8QnxisT/IabR52Z5JkCPzKKw3vRmUbOiUCHgZzS4Eyq8v5oHP+tcG4yX8TOhbXts3Y2tB0VI8SJ6M3uMLfZm7EhE+HeCC6A56w+BC/aBEgRtmg2lFORaw0+yIzeS8RGm+eXNJ8n0fipOOanQOXs7ulLKv0knobHVt4xWw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+nhk3COKhhwBEcPz4VUCxTzIirhCVa8+lQHlm1kK2g=;
 b=nGFCFgg74llC7KcPxEpCuOA90bMdv4YmE+a2kHUcKzCAxETEUr9sDG0l4XV7iiLreCh1tZSXpgOxYdAg2Gl0JnJ9d1LvNk8PAc8iOoFwb7UOHbkUe0GqOu7yWNYTpA5K0SGNjbuQKk/AWggisxM80mWA/eLdn1s2vye90S2klkhllROYUvZm3Vw08gsaalZsvq5Q30wjcwJpeY7yvkvZlPHdyWxtiXtqUUeKJKQGhjjzaAHyaccJ8oMMvFy9n4t0JRDF7AttOZt11H868qFtCgdPVrWphb010WyWfXDbDRuXdgHEJMn/rP7AEzVGIdmrw3ahwz6gERTuJsIt+NBVcw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+nhk3COKhhwBEcPz4VUCxTzIirhCVa8+lQHlm1kK2g=;
 b=L2aFIr/ik0ULl7357koK2k3tdhnBSmM/9vTW8hmPLZD37oFBIbsS3KR5o2GQKIwYTQC3qnghPpY5jIkhF4I4ZeiRbwJXy1eHe7/f45/jxD2epSUcbb45xXe2mfsv7cRzT3thTJxBeQRuAx+t2fk74TEvPG4/iUwwUDUA0jIU8k8=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 2dae801d-1005-44df-b26d-08d84d25eac4
x-ms-exchange-crosstenant-originalarrivaltime: 30 Aug 2020 20:47:31.9863 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 4KONl85ZvkRa4K4jZy5jYMTJGxgOpx2VXSgaMF/eKKKokv8DisBZezqXCE+EbGjaKA4VvPJqO5lMbC1WAolxBQ==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4261
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.39; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/30 15:48:04
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

UmljaGFyZCwNCg0KVGhhbmsgeW91IHNvIG11Y2ggZm9yIHRoZSBmZWVkYmFjay4gIEkgcmVhbGx5
IGFwcHJlY2lhdGUgaXQuDQoNCkknbGwgZ2V0IHRvIHdvcmsgYWRkcmVzc2luZyB0aGUgaXNzdWVz
LiAgU2luY2Ugc29tZSBvZiB0aGUgaXRlbXMgd2lsbCB0YWtlIGxvbmdlciB0aGFuIG90aGVycywg
cGxlYXNlIGFkdmlzZSB3aGV0aGVyIGl0J3MgcHJlZmVycmVkIHRvIHNlbmQgaW50ZXJtZWRpYXRl
IHVwZGF0ZXMgb3Igd2FpdCB1bnRpbCB0aGV5IGFyZSBhbGwgYWRkcmVzc2VkLg0KDQpUYXlsb3IN
Cg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJpY2hhcmQgSGVuZGVy
c29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlkYXksIEF1Z3Vz
dCAyOCwgMjAyMCA5OjI3IFBNDQo+IFRvOiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2lu
Yy5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBoaWxtZEByZWRoYXQuY29tOyBs
YXVyZW50QHZpdmllci5ldTsgcmlrdS52b2lwaW9AaWtpLmZpOw0KPiBhbGVrc2FuZGFyLm0ubWFp
bEBnbWFpbC5jb207IGFsZUByZXYubmcNCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjMgMDAv
MzRdIEhleGFnb24gcGF0Y2ggc2VyaWVzDQo+DQo+IE9uIDgvMTgvMjAgODo1MCBBTSwgVGF5bG9y
IFNpbXBzb24gd3JvdGU6DQo+ID4gVGhpcyBzZXJpZXMgYWRkcyBzdXBwb3J0IGZvciB0aGUgSGV4
YWdvbiBwcm9jZXNzb3Igd2l0aCBMaW51eCB1c2VyIHN1cHBvcnQNCj4gPg0KPiA+IFNlZSBwYXRj
aCAwMi8zNCBIZXhhZ29uIFJFQURNRSBmb3IgZGV0YWlsZWQgaW5mb3JtYXRpb24uDQo+ID4NCj4g
PiBPbmNlIHRoZSBzZXJpZXMgaXMgYXBwbGllZCwgdGhlIEhleGFnb24gcG9ydCB3aWxsIHBhc3Mg
Im1ha2UgY2hlY2stdGNnIi4NCj4gPiBUaGUgc2VyaWVzIGFsc28gaW5jbHVkZXMgSGV4YWdvbi1z
cGVjaWZpYyB0ZXN0cyBpbiB0Y2cvdGVzdHMvaGV4YWdvbi4NCj4gPg0KPiA+IFdlIGhhdmUgYSBw
YXJhbGxlbCBlZmZvcnQgdG8gbWFrZSB0aGUgSGV4YWdvbiBMaW51eCB0b29sY2hhaW4gaW5zaWRl
IGENCj4gZG9ja2VyDQo+ID4gY29udGFpbmVyIHB1YmxpY2FsbHkgYXZhaWxhYmxlLg0KPg0KPiBP
aCwgZXhjZWxsZW50Lg0KPg0KPiA+ICoqKiBGdXR1cmUgaXRlbXMgdW5kZXIgY29uc2lkZXJhdGlv
biAqKioNCj4gPiBVc2UgcWVtdSBzb2Z0ZmxvYXQNCj4NCj4gVGhpcyBpcyBhIGJsb2NrZXIuICBJ
dCdzIGRlZmluaXRlbHkgbm90IGhhcmQuDQo+DQo+ID4gVXNlIHFlbXUgZGVjb2RldHJlZQ0KPg0K
PiBUaGlzIHdvdWxkIGNlcnRhaW5seSBjbGVhbiB1cCBhbGwgb2YgdGhlIHN0cmluZyBwcm9jZXNz
aW5nIHRoYXQgSSBtZW50aW9uZWQuDQo+IEl0IHNlZW1zIGxpa2UgaXQgd291bGQgYmUganVzdCBh
cyBlYXN5IHRvIGNvbnZlcnQgaW50byB0aGUgZGVjb2RldHJlZSBmb3JtYXQNCj4gYXMNCj4gd2hh
dCB5b3UncmUgY3VycmVudGx5IGRvaW5nIGZvciBkZWN0cmVlX2dlbmVyYXRlZC5oLiAgSW5kZWVk
LCBlYXNpZXIsIHNpbmNlDQo+IHlvdQ0KPiBvbmx5IG5lZWQgdGhlIG9uZXMgdGhhdCBhcmUgVEVS
TUlOQUwoKS4gIEFsbCBvZiB0aGUgb3RoZXIgdGhpbmdzIGxhYmVsZWQNCj4gVEFCTEVfTElOSyBh
cmUgaGFuZGxlZCBieSBkZWNvZGV0cmVlIGl0c2VsZi4NCj4NCj4gQW55d2F5LCBJJ3ZlIGNvbXBs
ZXRlZCB3aGF0IHJldmlldyBJIHBsYW5lZCB0byBkbyBhZ2FpbnN0IHRoaXMgdmVyc2lvbi4NCj4N
Cj4NCj4gcn4NCg==

