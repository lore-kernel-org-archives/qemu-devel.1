Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87534C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 23:58:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50F1620679
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 23:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="esckN8SN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="dr0yjXDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F1620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB5JN-0004vj-Jq
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 19:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kB5DW-0004Mx-U3
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 19:52:34 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:54800)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kB5DV-0003Mm-7W
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 19:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598485953; x=1630021953;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=o8UszHrQt7YVYCl1dEiAkHbftPA9rgSuKdfF9VBM0bE=;
 b=esckN8SNa4RrkyaFGQvlil1CcW9PL5oHJUHA4I+z2JrVc5BqzhZEx2JM
 qjPsrmUWmQFwBTd/rKe/jW1SpFOzonNGNlbjbJwn9AV5pJgBYDPv9iKC9
 H4rO+QRDj2fMf/S/BrfdFj3bIuppoebzs5+ioqFa8NfCrdFbzeG5FLBkA w=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 26 Aug 2020 16:52:31 -0700
Received: from nasanexm01e.na.qualcomm.com ([10.85.0.31])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 26 Aug 2020 16:52:31 -0700
Received: from nasanexm03d.na.qualcomm.com (10.85.0.91) by
 NASANEXM01E.na.qualcomm.com (10.85.0.31) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Aug 2020 16:52:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 26 Aug 2020 16:52:30 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4952.namprd02.prod.outlook.com (2603:10b6:a03:45::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 26 Aug
 2020 23:52:29 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::6ce3:79e4:9697:313e]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::6ce3:79e4:9697:313e%3]) with mapi id 15.20.3305.031; Wed, 26 Aug 2020
 23:52:29 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 16/34] Hexagon (target/hexagon) utility functions
Thread-Topic: [RFC PATCH v3 16/34] Hexagon (target/hexagon) utility functions
Thread-Index: AQHWdXdicesFPIv0/EWfa8c16e4rnalKiymAgACHJDA=
Date: Wed, 26 Aug 2020 23:52:29 +0000
Message-ID: <BYAPR02MB488661B9F520E73B5664626ADE540@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-17-git-send-email-tsimpson@quicinc.com>
 <3f188d8d-811b-76da-a6d6-d2eab3dc5da5@linaro.org>
In-Reply-To: <3f188d8d-811b-76da-a6d6-d2eab3dc5da5@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8efce5bb-ab55-4690-817e-08d84a1b17d6
x-ms-traffictypediagnostic: BYAPR02MB4952:
x-microsoft-antispam-prvs: <BYAPR02MB4952B8026CD5EE81C39D668ADE540@BYAPR02MB4952.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /VhOLF/bpIOu4Lq0suJoIkRzcuYcaYLCWhdEDUugH3qFcUy2/T66KldtcGCdS1LCG+YgxiTSgdbtZ2J+NbSqEVfAOKDgOYNfiE2vq84Ntw514I9W/HwMjmojLJaDeKlhSle5BPFOkD1YNNza948tyl3HPiHbQQ0ilHZuB2DPOEX41vh8tM7p0TOpXSP2pC8PLAz6VpRxjujDG2S+PCPW0mGpaG3wZO/V8yMzuVcykQoGAzZlVjMiSht7/BgFpL/kaIII9hY0Vanxoy7rchNPwKtYR9RT3TVz8pguXclejH/NiTm1eZ/6De+mWyAYV5WBFap3pZMKKvn1hsJgNQLduQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(39860400002)(396003)(346002)(376002)(136003)(478600001)(6506007)(26005)(52536014)(71200400001)(5660300002)(4744005)(83380400001)(186003)(86362001)(8936002)(53546011)(55016002)(54906003)(316002)(33656002)(9686003)(110136005)(7696005)(8676002)(64756008)(66946007)(2906002)(4326008)(66446008)(66476007)(66556008)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: aEGOWRlR7tB+CuNZX0GokKCXdauaBRNCqGbtXE9dkCyOVsAhFehcoLjEzlNv+BiMDv9jr/4A+Ee6zO2njH90WbcXETzFQft6bHoW+jZFoxjudji9NzxRwEyyqX1TlM+1t7fsxyz4UgbNi0EvDHREAMzPEDKIx4rhAjj2BtYEjgQl31BslnkrmmNK5xlFa/gHs22g1ipuTsckLUOXZQ2f4SUOPKz1YITt5QttcuIGoVulv5fbCrW/w+pz0z9mSbir5OVQrQiR4OL55LUS5NICGkgkTbuT2b73caDRk+iGz+biC+Xsl72xs78wMUtUOrRnVpXjAb9JH5uYWXpDP006hzFRQdcyBpKqeFAIMnAgKxz8CaO9SyRjR0LYVTTufObXzcCv6x8ehp5sSuwE8VAF7axUZjFTadj0lnsv4n4Ira01+MBhDq1ffe/UYoGuYZ5eGo8EfCoVP/o+DUJY/L0sE7t14VMzFzZgReC3KXBHIaHb4Ant5XcfhXHTucYf35V76/4zS7PZDq7TJoUKeVmh33SOBZYfuY1TWxXch2NDVYy9U1tqMiHpQAj6Z/Rw37qeL2pzhq6liiXATdmvHeHDIi4IlveB0VinTpr0qjkVuXHGgsf0VJ4ygno9AUykMEz/rQGuOJH/NVgUezvsB+72kA==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLJEA4wtyKEIeIItQwYnlID5V9rg9+f/l/ZvKIpbWKE/xEuXlSfHmMvT++uS6z4FigRzw0pk7XhRjC3ZRkrB117zi5DdAAIqCyUlwyO2v9o1Pd+wWqd24qzMBBjTxMP4DBWd/VwN3RlBZDCOPV8BvXrZwpOfo6IYM9sVhovk0aeOD1db2Wfb1uwUAhPA+bpcoHaMr2atamMMVnIxBEUWpNQyL+1UFhJbl9az9FqWFN20MKKiQ4uF8e7k8S9Wz7+/ML7RC4y0lLzd3y3a4M7bHHcns6WU9tDanWJzIUVBAhkRr83MyDtpgOEYG1Qk1fXdjcKXSkF3IiOmTe35b7qCYg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2+clsYHMnIDDUC5S1p4DDuiRZ1O/Rqmf7bRRisNiqY=;
 b=E/D4Jv+uQ1tMEloeza1m/aJ2OOXo+NJg+ulvJwSSsrpdI+PfDx6SLbCiKb6Y6bscpIp1zD4BCQSKfegAkyzj3SXogavb08aMHSDFctkSsEuJmZ7Qzxa+lkge64gJ5qSiG1tf71YBTdsivfS2rAOTxgaP26BoriH10XkP5agvOxzdklIUk1qJ0HfbEbAptr7Tnu5TzOP1sS894XiIZSMOY1GVRNl4BrPMNSt8IMvd6lT2QJYwISnLMyvJH9jIyvuy6U29pA9fVL+3iGq5bttm3OaVvBe4w6vpkm/2LIVvjVPPhIZ1yXhUV+8TW3vCudwR8OMTCclxDeb8Vf5moUvXWQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2+clsYHMnIDDUC5S1p4DDuiRZ1O/Rqmf7bRRisNiqY=;
 b=dr0yjXDz65S4S0wRDzPV9UL0d5SuHyLaNdZLL2IUmUaKS0gfoeW+T1S/YtU/cYl4f922U1258RL7rxESrA0MYqv00Yv5lA+hNgBmT1PVdTiZIc0Tbb+bv9AOTNN7HSAe0yNUPD0n7TtD6TwbtspNqYP7P41BU+2phYsyBZYzNVE=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 8efce5bb-ab55-4690-817e-08d84a1b17d6
x-ms-exchange-crosstenant-originalarrivaltime: 26 Aug 2020 23:52:29.5562 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 49dewCipRdT86a4NXOM78LBV/1Jx1DAwRNkCZiPCBucInxKJTzRXvErKlZpC3hS+Hm4Dz9Db/BNRwVBdsrNKKA==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4952
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.38; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 19:52:00
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
dXN0IDI2LCAyMDIwIDk6MTEgQU0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWlj
aW5jLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGhpbG1kQHJlZGhhdC5jb207
IGxhdXJlbnRAdml2aWVyLmV1OyByaWt1LnZvaXBpb0Bpa2kuZmk7DQo+IGFsZWtzYW5kYXIubS5t
YWlsQGdtYWlsLmNvbTsgYWxlQHJldi5uZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAx
Ni8zNF0gSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIHV0aWxpdHkgZnVuY3Rpb25zDQo+DQo+IERp
ZCB5b3UgcmVhbGx5IG5lZWQgdG8gcmVpbnZlbnQgcWVtdS9pbnQxMjguaD8NCg0KSSByZW1lbWJl
ciBsb29raW5nIGF0IHFlbXUvaW50MTI4LmggYnJpZWZseSBidXQgY2FuJ3QgcmVtZW1iZXIgd2h5
IEkgZW5kZWQgdXAgbm90IHVzaW5nIGl0LiAgSSdsbCB0YWtlIGFub3RoZXIgbG9vay4NCg==

