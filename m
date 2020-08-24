Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887ACC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 02:44:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52B63206F7
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 02:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Le6EqUgb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="JVL2yo1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B63206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA2T2-0005ig-JL
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 22:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kA2SM-0004q1-Ua
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 22:43:34 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:29173)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kA2SK-0006LW-7B
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 22:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598237012; x=1629773012;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=b9xFZESeWya0FEPGxIg7lCDu8UpdV+IQNdqWRADQa3M=;
 b=Le6EqUgbzSY0rQq+RlM+7Vexi0mkaJKpD1MtxQgq2rh6qozk0eRxnASe
 8WFq0i2YsJByEIP8qhsQweglMy48zW3o7BPctwqleHMtKK9HGmdAqVIJY
 2s+30uatOJXv7WEFlljTtR+flzkrOVMFWA+8JdvsOjyF6GtY2tPO1jI9+ 0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 23 Aug 2020 19:43:27 -0700
Received: from nasanexm01a.na.qualcomm.com ([10.85.0.81])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 23 Aug 2020 19:43:27 -0700
Received: from nasanexm03d.na.qualcomm.com (10.85.0.91) by
 nasanexm01a.na.qualcomm.com (10.85.0.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 23 Aug 2020 19:43:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Sun, 23 Aug 2020 19:43:27 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BY5PR02MB6387.namprd02.prod.outlook.com (2603:10b6:a03:1b5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Mon, 24 Aug
 2020 02:43:26 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::6ce3:79e4:9697:313e]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::6ce3:79e4:9697:313e%3]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 02:43:26 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, "Max
 Filippov" <jcmvbkbc@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PULL v2 00/24] target/xtensa updates for 5.2
Thread-Topic: [PULL v2 00/24] target/xtensa updates for 5.2
Thread-Index: AQHWd/zxIv/VqiETgE22bO5BJsKxz6lD688AgAKi28A=
Date: Mon, 24 Aug 2020 02:43:26 +0000
Message-ID: <BYAPR02MB4886C516B7A6DE2FECA05290DE560@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <20200821205050.29066-1-jcmvbkbc@gmail.com>
 <8b20adcd-97e9-0f8f-1854-b9809060d6cd@amsat.org>
In-Reply-To: <8b20adcd-97e9-0f8f-1854-b9809060d6cd@amsat.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amsat.org; dkim=none (message not signed)
 header.d=none;amsat.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 278d9736-cc7a-4781-675b-08d847d77a0b
x-ms-traffictypediagnostic: BY5PR02MB6387:
x-microsoft-antispam-prvs: <BY5PR02MB6387407B37AB13F8620E60FDDE560@BY5PR02MB6387.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rwIwzqNFMpPK1UwpLuKkU0JwhcJvH2ARTwkFKsXrObFamP2zao/Peasr+5YwIF3UeJtsDW+9X3d6/zkVIcNhSe73bZ5vn7k+YMos7NHdwnCBh7yBtMzbvjEQCR7MKVSw3piAp1p9OdiXQKdDOQXvFxNktaDCBUva2RWMRJE1+E8/AERuwyyw0LY8OFmkKX610sF7FvZyJCm8Wq7KtjoonPmpAW33kMxEOTR4TIkmFT8CK1YQJm1CyGX7p3JZcbdIV9L9gh3645W81d96kJYNmDhGLfD1g9HMq1drul/qE6HKO1iFsc+bqrHPC0gsEK4JbvMWHVgALQFM9cFkte7DrQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(136003)(39860400002)(346002)(366004)(376002)(52536014)(6506007)(53546011)(26005)(186003)(55016002)(33656002)(7696005)(15650500001)(5660300002)(4744005)(71200400001)(110136005)(4326008)(83380400001)(76116006)(316002)(2906002)(66446008)(66556008)(66946007)(64756008)(66476007)(8676002)(478600001)(86362001)(9686003)(54906003)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: LSx7t+Vuhc4oQ9Ida0t82lrOptfsKf859YjFgHe7VTAiqhO5+xwo46mgQAGhnlucIeuDTETLHTLPhENOZZfMigYAxP42Q9F1aK+qLdRW/rywBlsnUvuwp+6zvwHfuXnvtZEkkkK6qN6THxbMJKADfU17VERtI1923oUpyHas5p1qKWIXyQSO+fKYcis2AMXwxwqm+LQOYV5YMp74ThBRtP4CCYquol1pOqQOyqWtA8NY6PLbmo82qYvD6DdiqB7rAatf2LdCtC1N3hoLbCj7r/X9dlHSHEF2HoitfeHLwMzrrzMimh1KyK8CoQWuBTi5C6qBGA5WFeJzhS0TYkglTYAvjUAnEWRckczxI33jKGbDlpznQUM6j4oF7w5Wacslp/4K4hKretiGqW4yXxRYeICat/u2YAHn7kXPbuHn1SilmR6mzff2n0lHFG+Kd8WM8jk++PjLsE+Z5h2otk701c9RS6hktWVT1EkTAGToA2XR7Z/UZ9brLd8XMlJn9yvvTOeYEck4OQc4k9vAS186L5Phe7twmpavNTKqOHZFYEfnWBQKYRNXmiNOqFPPaFCnELbL94Wru/59CShaWAJt51RAPKNXq4x74x9+Xo3p9cEq7ZOqfj5PJEUI0AB8Nw+SI6icT5d/NDHwjLfmCYUWlg==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYDNrqyzMlj+jMhpGhu9RdrCUkX+vtbAIIh1yCCiuzqgPSnk+AM7qVfFepj0dNX/upNcAcQKcWzrFm9DqejLnXbwJhIHDdr4EQ0B89hnq6IArxRFkMC+NlfCyIFwLGuP6yuIxTjELk2602NRe1qkEqGkDyLlnUfLUdiq830h9YUPoGoEMM22lsZ6PUZmkFCYYfMUYX2ApyByJWho3BmxuJ2MIQDd/Tsn4yyMHQKSBkP22YVPRLNbI/1hf2Xl35JAfn42jGMZDSviSoCVy8F6S1+ZT2U+QQCS89uLGzIPde1OYmn2sr2BQjMZknPjUmOa7GruK+uM5y8lmby/kKxXLw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgcOJNSBMXjQ0xPL0Pg3kFHV6GrKrw/9SDVoGojMINg=;
 b=Y6j1h9I4jm+uTRsuGXdaH4KIBT2kY6pJJkIC6qjSAm2aHuqrW/yl/oEdcVCE51LkggqQIm7DJYzH0zbU58gmmDf9b23r2xJr7WWt+orrDJQMr/NNdq0MZB0moCsYg3JV/DjfuNN7DGfe6nUKPW6ezp6ElojpgG0vd0WAIIyCLDndae+l9QcMcEYUVr//QHsN4MRgZvivx0I1JugKLT8ra5aZEQp+TZy3n99gDSVUCwO+g0kS/ZDnYFYFGjOOp/izzEXSe2065L87p4jTRxw2jWOLcS6YOuZIOzrUumuqmqYY8CbB8ImfSVwPRGpB25LAUwR/ZtQ+RGtV0mSXHi3RaQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgcOJNSBMXjQ0xPL0Pg3kFHV6GrKrw/9SDVoGojMINg=;
 b=JVL2yo1xoCfVQwP1MOzr/NULA0/SZ//U8iXLXBjMb9l0rv7nwhYNQtPt95huqsGmtBIbUADrqLyzUk6lkn6SYuExhhyrIam1QlGy5UVTntoLJ98OfrkUrE+ZYobvpjKXqiDuMc7rbYVNMjNKEu268HdJzavUVgzDeh9e4deuRVE=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 278d9736-cc7a-4781-675b-08d847d77a0b
x-ms-exchange-crosstenant-originalarrivaltime: 24 Aug 2020 02:43:26.2344 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: aPNygLWu0UeP4CGd+Q3rt4Bit6aOQWRIbnJ2XfMqEi/cy60Y8jVSmyowSOFHKSiwqkXhClg5+++tyPi4zZs56A==
x-ms-exchange-transport-crosstenantheadersstamped: BY5PR02MB6387
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.39; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 22:43:28
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgPHBoaWxpcHBlLm1hdGhpZXUuZGF1ZGVAZ21haWwuY29tPiBPbg0KPiBCZWhhbGYg
T2YgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kNCj4gU2VudDogU2F0dXJkYXksIEF1Z3VzdCAyMiwg
MjAyMCA0OjIxIEFNDQo+IFRvOiBNYXggRmlsaXBwb3YgPGpjbXZia2JjQGdtYWlsLmNvbT47IHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBs
aW5hcm8ub3JnPjsgUmljaGFyZCBIZW5kZXJzb24NCj4gPHJ0aEB0d2lkZGxlLm5ldD47IFRheWxv
ciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQVUxMIHYy
IDAwLzI0XSB0YXJnZXQveHRlbnNhIHVwZGF0ZXMgZm9yIDUuMg0KPg0KPg0KPiBJJ20gYXNraW5n
IGJlY2F1c2UgSUlSQyB3ZSBoYXZlIGJlZW4gcmVsdWN0YW50IHRvIGFjY2VwdCB0aGUgaGV4YWdv
bg0KPiBwb3J0IGR1ZSB0byBpdHMgYmlnIGdlbmVyYXRlZCBpbXBvcnRlZCBkYXRhIChiZXNpZGUg
dGhlIGxpY2Vuc2luZw0KPiBpc3N1ZXMpLg0KPg0KDQpJIHdhc24ndCBhd2FyZSBvZiBhbnkgbGlj
ZW5zaW5nIGlzc3VlcyB3aXRoIHRoZSBIZXhhZ29uIHBvcnQuICBDb3VsZCB5b3UgZWxhYm9yYXRl
Pw0KDQpUaGFua3MsDQpUYXlsb3INCg0K

