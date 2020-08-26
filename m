Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CA7C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 23:59:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D19A20679
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 23:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SzR1ubqP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="U0ZjI+fq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D19A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB5K4-0005oy-U7
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 19:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kB5JU-0005Aa-BK
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 19:58:44 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:33073)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kB5JS-000493-34
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 19:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598486322; x=1630022322;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=r8I/XrYhAgJfOsrSJsEsQ54JQVTnIxa91IgECHCS7KA=;
 b=SzR1ubqPujYYSRxTWDcRnGBcCj7XO6RNN6Pf+jwIGy5uL/NRvo22zbXU
 NcefL1oebEHfcF9RpukfGt5LHdRH6mwYUCz91zbHpqlG+AbY1k11VJFQy
 aP8GM0pVEeVBudPyhko+yyQPRgXJuXtMric0k8YPwsC5oyDNPXQZqv4HF Q=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Aug 2020 16:58:40 -0700
Received: from nasanexm01b.na.qualcomm.com ([10.85.0.82])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 26 Aug 2020 16:58:40 -0700
Received: from eusanexr01a.eu.qualcomm.com (10.85.0.97) by
 NASANEXM01B.na.qualcomm.com (10.85.0.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Aug 2020 16:56:23 -0700
Received: from nasanexm03d.na.qualcomm.com (10.85.0.91) by
 eusanexr01a.eu.qualcomm.com (10.85.0.97) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Aug 2020 16:52:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 26 Aug 2020 16:52:28 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4952.namprd02.prod.outlook.com (2603:10b6:a03:45::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 26 Aug
 2020 23:52:10 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::6ce3:79e4:9697:313e]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::6ce3:79e4:9697:313e%3]) with mapi id 15.20.3305.031; Wed, 26 Aug 2020
 23:52:10 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 09/34] Hexagon (target/hexagon) architecture types
Thread-Topic: [RFC PATCH v3 09/34] Hexagon (target/hexagon) architecture types
Thread-Index: AQHWdXdfAsdp4eGPLEOaaku3jDxqaalKfOKAgABtdFA=
Date: Wed, 26 Aug 2020 23:52:10 +0000
Message-ID: <BYAPR02MB4886063B26DC2D7A1D6BA17DDE540@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-10-git-send-email-tsimpson@quicinc.com>
 <264c9851-81c4-67e3-3e04-865b30c06ec1@linaro.org>
In-Reply-To: <264c9851-81c4-67e3-3e04-865b30c06ec1@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6d52d9d-937d-4771-954c-08d84a1b0c43
x-ms-traffictypediagnostic: BYAPR02MB4952:
x-microsoft-antispam-prvs: <BYAPR02MB495299133C963E98E65827C4DE540@BYAPR02MB4952.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D9z9T3qtMjGibDSTC4GnDbfZx0c4zACFoGq6nb39KU0vv+cuycFxXBrVXl+o40EYjytAD0Rd1klhc+G226Z9rYF5ddUMKGmjulmeoRlnKSz9DcyvOXBzPAZtEprw7ve9bCwcVLyEmSbJAPq3GbSYp1Qh/FiMsMWwaHAck177tAS76zt1XkRgG3+AbZr3kP3XIzWyrQA1x09pZrr1BpHGKJlBxvmBj7gv99dpO3i1FPQiw6vUMSVUyFhVtdPPxSf3HLrLl0CVIU4SMvAr+/CyOtKAQCtXHw6LDcDo9KIxVbEWxS0nf7LbNFes9N37Dm+1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(39860400002)(396003)(346002)(376002)(136003)(478600001)(6506007)(26005)(52536014)(71200400001)(5660300002)(4744005)(83380400001)(186003)(86362001)(8936002)(53546011)(55016002)(54906003)(316002)(33656002)(9686003)(110136005)(7696005)(8676002)(64756008)(66946007)(2906002)(4326008)(66446008)(66476007)(66556008)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 8peoCGKWA/QM77U/CoXx3XS6QLcwa5ZGILZCq6x3wQKfVJioLtuaMfziBwjpxgO372McoSQ006YE2/dbznKqlb5J2J5sqtBMdct6LGIn9aXZbkesdEQpEN7/iGBvXm7qaRLoa9ObaxL1iKso+NzI8FGnPpFQy33Q2icBffo9AA+P0fgyuCL+rHfjkAXEL0vXhanTkht1xuftZuplHiqGB8fyds528ZBZs0SuXTU+jtF0iPG1gY417q6XrsGl9SxbtZtKuy72aHhwqEaD2ySJDqLovu6KQkgBXOu4u33sz7bes9CiFPorrHI0ABAr3BUIbOFsltU+wFgYWI3f8hwds3O29hKYtuGwlkJMgsuuVzJlejUPQ7nBuJuEY8Sx4P1pIYyjbb/7/WvGEaI1AQEGgax//Dk8xGcUwVAP6mzekqeFsUQG+PAkhFEyrpQY5cRewr0ouBeTfBKbmNLRWSXn8+12HMs8zSl+/yJv0WNyfdMacfurs6R9abDaksXe/sHli7Hbfa0cNon8k0Sg0ZwNuQ4FI9smH8KMc71PLeTPMJgTO9D9DjvK9Ed8T2pVw5gLz43c56IClEVxoNd7QLPvTd0qVqdL93VLBRiu9Vgwq8CYbR9o2cFiuv3hSRTLOeb0EOGcGDcNjBUpQ6BhIW7FVw==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrrZDO5YUuQQyIocGob5qJVp/C98qmQBT4mNGw+BZl7s+v8d+Uol5uxd6npExc21dw2DMuJ7mEN5Xpz8asTdIrFqcGwbq8wNAZsGR+ZV7OntCIIUPHZXQ3tG1fs7d8UGQe85pu7tmY0pFuo5uRLdX7/y2wHa2k3rO+br29RN1Kg5gMhjCE+lGQpmPet11UXJMvy6WOVICS3ilG0TG2K3bfB7Ig+2wBzKA6N3/0P/jXBDiPFRoAphaot6eMt4qRlyStL9JDybaabBLQE+P7aErUToy4SJM44GM6vHDtc9Z9Qa8VX6VKw6YTXdznLr/YtGJt6wjn9wJgTY/lOxnvndWQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZo74xdD5mx7WBE6+H/jvJxEiBC2Ug6tQOqNm9zaZAo=;
 b=IQlWuTwCbrfdvWHjyXbhG09bySzu5+r/19afOysaWYEAIlBmx5/IsQ14dyMIazhC4O2GwTrdk18VYaN47O8wpgZeN0B8qv0i5/FHIl42UYxKXWReq0Op5yjXSljx1tS0fg2+BUpMcNRCCVJ2pUksvOg++sOheeiv8GLc8v0hgDXhRbQjdcdU9/Nycfqis7EPlQ65fSjeHzPJICCv8awt5+beJkwb0zk8KCBq52dK/uJEvM0QvZpn5aGTNA0yi/eU6c1/nhex2vkQ0+/HsdzsBcwmgK+ebsFqLSPue/wJ4+vXoyWHMG4Vub1Jd6UxJIgunNbd5DAoxSuruY80vxw3vg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZo74xdD5mx7WBE6+H/jvJxEiBC2Ug6tQOqNm9zaZAo=;
 b=U0ZjI+fqniI5+yEsx6Us2fTekAc2wm8gzi0WgB4lF5IZzLY0eF8Us3+bahfIB06fh6wjKTq3NCXKhgawooNnXOcbx1iPPSUEuUqbx9RsC1FovvYmtsZPsZjB2GHbH1hKXAS1ARDhDb0ANTCCDFy06T463eoZqeF1r95lz0gxJ6g=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: f6d52d9d-937d-4771-954c-08d84a1b0c43
x-ms-exchange-crosstenant-originalarrivaltime: 26 Aug 2020 23:52:10.1854 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: hR3509x8lneg3AlCNCZIw7imkn2NMAZckKgDFI5DvnR8zg29M74U/dHS0RYf8dedumAv8Jtl+9qAFTERW6mg4g==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4952
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
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
dXN0IDI2LCAyMDIwIDg6MTkgQU0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWlj
aW5jLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGhpbG1kQHJlZGhhdC5jb207
IGxhdXJlbnRAdml2aWVyLmV1OyByaWt1LnZvaXBpb0Bpa2kuZmk7DQo+IGFsZWtzYW5kYXIubS5t
YWlsQGdtYWlsLmNvbTsgYWxlQHJldi5uZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAw
OS8zNF0gSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIGFyY2hpdGVjdHVyZQ0KPiB0eXBlcw0KPg0K
PiA+ICsjaW5jbHVkZSA8c3RkaW50Lmg+DQo+DQo+IERvIHlvdSByZWFsbHkgbmVlZCB0byByZS1p
bmNsdWRlIHRoaXM/DQo+IFRoaXMgd2FzIGRvbmUgaW4gInFlbXUvb3NkZXAuaCIuDQo+DQo+IElu
IGdlbmVyYWwsIG9zZGVwLmggbXVzdCBiZSBpbmNsdWRlZCBmaXJzdCwgYW5kIGl0IHRha2VzIGNh
cmUgb2YgYWxsIG9mIHRoZQ0KPiBiYXNpYyBzeXN0ZW0gaW5jbHVkZXMuDQoNCk9LDQo=

