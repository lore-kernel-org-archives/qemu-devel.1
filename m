Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14F5C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 21:39:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A9920738
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 21:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R7YieYeJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="N+7rAUoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A9920738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCV2p-00056X-Io
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 17:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCV2F-0004gO-SE
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 17:38:47 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:9893)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCV2D-0001fU-Lf
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 17:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598823525; x=1630359525;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4ayZBJWv0jXhOikxChuanrxb9MSy6VoF8s5yzg/zlbI=;
 b=R7YieYeJ/UmhzZXep8XLwTwaHzjg3b3jQ2LGVaAohE8wLBshS4Ih5o1p
 N8SCSqTCjrB8zwZWJrHouWNCKtbWZN68UXQpHb0EnQm/KhJNywwBZBlhW
 GaeP4sNQACYh1txiHjAuli5oTPQ0FtuSHDfF2OABC58l3jU1qFuwrep9U s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 30 Aug 2020 14:38:44 -0700
Received: from nasanexm03a.na.qualcomm.com ([10.85.0.103])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 30 Aug 2020 14:38:44 -0700
Received: from nasanexm03c.na.qualcomm.com (10.85.0.106) by
 nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 30 Aug 2020 14:38:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Sun, 30 Aug 2020 14:38:43 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4263.namprd02.prod.outlook.com (2603:10b6:a03:5b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Sun, 30 Aug
 2020 21:38:42 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01%7]) with mapi id 15.20.3326.025; Sun, 30 Aug 2020
 21:38:42 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 28/34] Hexagon (target/hexagon) TCG generation
 helpers
Thread-Topic: [RFC PATCH v3 28/34] Hexagon (target/hexagon) TCG generation
 helpers
Thread-Index: AQHWdXdfKU0DqHwuJkSki+Uj5hpxmqlOYhMAgALARqCAABGbAIAACqrw
Date: Sun, 30 Aug 2020 21:38:42 +0000
Message-ID: <BYAPR02MB4886279604B9FC78EBA51AF9DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-29-git-send-email-tsimpson@quicinc.com>
 <4c1cefd2-5e45-db8c-ec0f-917fcbbd3376@linaro.org>
 <BYAPR02MB488611B00AC7D19989B57FB4DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
 <ad500dbe-51fe-3c16-ed1d-3e0022ce12b3@linaro.org>
In-Reply-To: <ad500dbe-51fe-3c16-ed1d-3e0022ce12b3@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86f91e96-42a2-4d92-cdba-08d84d2d10d7
x-ms-traffictypediagnostic: BYAPR02MB4263:
x-microsoft-antispam-prvs: <BYAPR02MB4263C98E3CA90F2E5F9E2EEEDE500@BYAPR02MB4263.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GjYVCJiCVOaFDFv9E3lgXzGRVN2EaeDBZgP48cDw64kuP/KqnK0Gw2ZdHwS10rWh6Wqm3q7uAhktwKO5XSxONWjhaJyKqZYpViWEyKq8+PPfKPMyLEBjPbGnL9o5lo9E/V+3MOGmS/zJUMmY78U/4hMpdfpmqKvtmVbBcItIjZHh4PQIcidpX+vidqj2hD5m98CbsOYEXrUNFGNGqF520AQzaNdByngxbiQEtzLwxq2argKBfSGrCLwJpIYBGmA5uGvPiLwzrS2RSwxHyySly7UbDw8QQnZOOHku+hqwA0zb6/lhuDnJ9dqusRIa3cxIj6Ii+8pO0wEz3zwwTZTZ/g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(136003)(39850400004)(396003)(366004)(86362001)(4326008)(5660300002)(66476007)(52536014)(33656002)(66556008)(64756008)(66446008)(83380400001)(66946007)(76116006)(71200400001)(478600001)(2906002)(110136005)(8676002)(7696005)(54906003)(8936002)(26005)(186003)(6506007)(316002)(53546011)(9686003)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: jxw7eSUXxkNKCl7yta4PD+/BbtZ646sGiNjj5BLtwlp/Q2OVRHlFLIn5VIABu5a0sjtiufeLFkkk+Fh8Uld5XGNme/YtRfN99hRNx7Ib18Hbm1LGsx/4pH2R3wIv6kaOTgxm2ey+OnGZmncub0Tjra+5DEihVuHz3rHPDQhczDSyq/ImetzOJ1MVXJMp6uSAc97ZUeQXKDr22kpvQDFDGDRj1fKq3o+9D4oCDDOSVVe+SEfnFvdldXnqoNMznw7ICNO0h37Fc6nI6Cwd46LPiahvwJsfrva69u5UDNpV08GLjiTu/F/A3hEJuWDXsmhAPBnYVJ4iEIbQzT0N64pJ3WldAb5O30TWLtNi/+66/tq2FlQnYLNyzShbwafOrWA1sb3ScJwVQAnjxk2OT4ABQ5471RQ8ujhEpbh6yWHabQ+bPrXEy3iGlaLEwNjoPsaMEtdCONHO3wCS1UJeIhG8KCu5l0POdvgB3hKe7MpUhdcdrJwupqTNj0YxkZL9NwjQUzUyGJ518/lxWrxvsfNxZ8bwX0m8yoYmkrP6pV4VfGuSkFCJEObsnsNw+zvQ/G8Fv/Ls3rZbKoyAOOXi7sEoe6ZJN5c5m5fOUW9XrqsHgWxwSB5W5MADst9Sg4CcOMozlp5f6EJ1dI2VAAYpKRZ3Ig==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDtOWs3OVSatJfszpReISllja6/LoDnUrUNqhsNhARVuNMpah9CcSZ9snrwEy4OYGbssFUqJF501An5viFqHBBMClqSzhqLufrZMoJuVGjTSRpuFF27yiWeR6xnRJwVqUG/uhk+uZo3kFcCpxNmX+Awg+SriiIkdQAGD3Nma+ztguLkrV+7HeC51B4kn+ySlki1dNCR73fprYHwHoIZJkxnyxOKxcALn6OHQ03stBHsrV94LLY5NEB4kt+ig53WVvBOs1qLFdF/IrZdi7julIBpCN+lHSfcqgZLtcE4V+5ZMeRZJSqDsaZ/69igRAMv1JPS7YgrDiNyJ/FNS0/JRgg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F13pUzffjJl5/G/biGJ8sJNfnzoc9AoMedGtUaKfAps=;
 b=Op8Ki20Hf7Vp6RAADsPC2vQZzHZKUKQmXHswppGkm0jo/9heqHYThO8LmHMIA1XiFK1ZDUvLUsrnDPLkPRHCc4G0ZMiXVLgEl0aSUCtsrbuk0jIxCmMmIgdi85gN4iGgfyp94AElTQmWvefqPrWp4BhsQxw5bbLihxxMTbe4SitMYvX04uSNXpep80gBcnV2BMBAEFVxGM7367QAdN7Hjm3qzhwYUSUq4RhR2lhTzx5Q5XA2SgS0wid9P0z7f6TVgv+R0v83fatLTny0rZYEbgW6j5Ed7y8rHlLb/CM6QvHImDQ5jXL0X3Suzzn/bh2Kd5fiPBY7btCitoMj+2uaOA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F13pUzffjJl5/G/biGJ8sJNfnzoc9AoMedGtUaKfAps=;
 b=N+7rAUoTSQceSRevw75KDvGanvRuyIIcx5OF2rSK4viVhptDuD0pTuJ/M6SKzgatINCb8SyHqrEPKQVwHrjO/YhGoGUJoxNNVR9licWVSGK5K6hEUXDyokMDDPxdrTmBjV5FMNd8/kWmMfhd4/wFgsA44DxYgNGHdxsIwEhcIrg=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 86f91e96-42a2-4d92-cdba-08d84d2d10d7
x-ms-exchange-crosstenant-originalarrivaltime: 30 Aug 2020 21:38:42.3261 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: pEg4oHkWE+JRaPn+nihYeIfCY0hJDbNtCYZCNfOFKJHfJspXHnkmfjEzPK7+RCgmv4MxlF7czy1mADbxmCujug==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4263
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmljaGFyZCBIZW5kZXJz
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFN1bmRheSwgQXVndXN0
IDMwLCAyMDIwIDI6NTIgUE0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5j
LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGhpbG1kQHJlZGhhdC5jb207IGxh
dXJlbnRAdml2aWVyLmV1OyByaWt1LnZvaXBpb0Bpa2kuZmk7DQo+IGFsZWtzYW5kYXIubS5tYWls
QGdtYWlsLmNvbTsgYWxlQHJldi5uZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAyOC8z
NF0gSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIFRDRw0KPiBnZW5lcmF0aW9uIGhlbHBlcnMNCj4N
Cj4gT24gOC8zMC8yMCAxMjo1MyBQTSwgVGF5bG9yIFNpbXBzb24gd3JvdGU6DQo+ID4+PiArKysg
Yi90YXJnZXQvaGV4YWdvbi9nZW5wdHJfaGVscGVycy5oDQo+ID4+PiBAQCAtMCwwICsxLDI0NCBA
QA0KPiA+Pj4gKw0KPiA+Pj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBnZW5fbG9nX3JlZ193cml0ZShp
bnQgcm51bSwgVENHdiB2YWwsIGludCBzbG90LA0KPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBpbnQgaXNfcHJlZGljYXRlZCkNCj4gPj4NCj4gPj4gVGhlc2UgYXJl
IHF1aXRlIGxhcmdlLiAgV2h5IGFyZSB0aGV5IG1hcmtlZCBpbmxpbmU/DQo+ID4NCj4gPiBTaW5j
ZSB0aGlzIGlzIGEgaGVhZGVyIGZpbGUsIGl0IHByZXZlbnRzIHRoZSBjb21waWxlciBmcm9tIGNv
bXBsYWluaW5nIHdoZW4NCj4gdGhleSBhcmVuJ3QgdXNlZC4NCj4NCj4gT2ssIHdoeSBhcmUgdGhl
eSBpbiBhIGhlYWRlciBmaWxlPw0KPiBXaHkgd291bGQgdGhleSBiZSB1bnVzZWQsIGNvbWUgdG8g
dGhhdD8NCj4NCj4gVGhlIGhlYWRlciBmaWxlIGlzIHVzZWQgZXhhY3RseSBvbmNlLCBieSBnZW5w
dHIuYy4gIFNlZW1zIHRvIG1lIHRoZXkgY291bGQNCj4ganVzdA0KPiBhcyB3ZWxsIGJlICppbiog
Z2VucHRyLmMuDQo+DQo+IElmIHRoZSBmdW5jdGlvbnMgYXJlIG5vdCB1c2VkLCBqdXN0IHJlbW92
ZSB0aGVtPw0KDQpJIGNvdWxkIGhhdmUgc3dvcm4gaXQgd2FzIGluY2x1ZGVkIGluIG1vcmUgdGhh
biBvbmUgQyBmaWxlLiAgSSdsbCBtb3ZlIHRoZSBjb250ZW50cyB0byBnZW5wdHIuYy4NCg0KDQo+
ID4+PiArc3RhdGljIGlubGluZSB2b2lkIGxvZ19zdG9yZTMyKENQVUhleGFnb25TdGF0ZSAqZW52
LCB0YXJnZXRfdWxvbmcNCj4gYWRkciwNCj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaW50MzJfdCB2YWwsIGludCB3aWR0aCwgaW50IHNsb3QpDQo+ID4+PiArew0KPiA+Pj4g
KyAgICBIRVhfREVCVUdfTE9HKCJsb2dfc3RvcmUlZCgweCV4LCAlZCBbMHgleF0pXG4iLCB3aWR0
aCwgYWRkciwNCj4gdmFsLA0KPiA+PiB2YWwpOw0KPiA+Pj4gKyAgICBlbnYtPm1lbV9sb2dfc3Rv
cmVzW3Nsb3RdLnZhID0gYWRkcjsNCj4gPj4+ICsgICAgZW52LT5tZW1fbG9nX3N0b3Jlc1tzbG90
XS53aWR0aCA9IHdpZHRoOw0KPiA+Pj4gKyAgICBlbnYtPm1lbV9sb2dfc3RvcmVzW3Nsb3RdLmRh
dGEzMiA9IHZhbDsNCj4gPj4+ICt9DQo+ID4+PiArDQo+ID4+PiArc3RhdGljIGlubGluZSB2b2lk
IGxvZ19zdG9yZTY0KENQVUhleGFnb25TdGF0ZSAqZW52LCB0YXJnZXRfdWxvbmcNCj4gYWRkciwN
Cj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50NjRfdCB2YWwsIGludCB3
aWR0aCwgaW50IHNsb3QpDQo+ID4+PiArew0KPiA+Pj4gKyAgICBIRVhfREVCVUdfTE9HKCJsb2df
c3RvcmUlZCgweCV4LCAlbGQgWzB4JWx4XSlcbiIsIHdpZHRoLCBhZGRyLA0KPiA+PiB2YWwsIHZh
bCk7DQo+ID4+PiArICAgIGVudi0+bWVtX2xvZ19zdG9yZXNbc2xvdF0udmEgPSBhZGRyOw0KPiA+
Pj4gKyAgICBlbnYtPm1lbV9sb2dfc3RvcmVzW3Nsb3RdLndpZHRoID0gd2lkdGg7DQo+ID4+PiAr
ICAgIGVudi0+bWVtX2xvZ19zdG9yZXNbc2xvdF0uZGF0YTY0ID0gdmFsOw0KPiA+Pj4gK30NCj4g
Pj4NCj4gPj4gLi4uIG9yIGZvbGQgdGhpcyByZS1hZGRpdGlvbiBiYWNrIGludG8gd2hlcmUgaXQg
d2FzIGFjY2lkZW50YWxseSByZW1vdmVkLiAgOy0pDQo+ID4NCj4gPiBDb3VsZCB5b3UgZWxhYm9y
YXRlPw0KPg0KPiBZb3UgYWRkZWQgdGhpcyBjb2RlIGluIG9uZSBwYXRjaCAoZGlkbid0IGNoZWNr
IHdoaWNoKSwgcmVtb3ZlZCBpdCBpbiBwYXRjaA0KPiAyNiwNCj4gYW5kIHJlLWFkZGVkIGl0IGhl
cmUgaW4gcGF0Y2ggMjguDQoNCk15IGFwb2xvZ2llcywgdGhpcyBpcyBteSBzY3Jld2luZyB1cCB0
aGUgZ2l0IHJlYmFzZS4gIEknbGwgZml4IGl0Lg0KDQo+DQo+DQo+IHJ+DQo=

