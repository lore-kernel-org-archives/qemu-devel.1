Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883CAC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:00:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E83920715
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C0gL+zCP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="md96pEIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E83920715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j02JR-00030T-D4
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 07:00:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40301)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1j02IH-0001w3-Nt
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:59:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1j02IG-0000eD-D2
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:59:33 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:26819)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1j02IE-0000a9-Pt
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:59:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581076770; x=1612612770;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ORfoTk3W2IKl29LnumkrXshN6k3XSFvK745ZNxQv6Vw=;
 b=C0gL+zCPztKJ67ypJv+4vUHP9NyyomVW1WlOChdAftZyK3E0Jtb9T8n1
 c03K+SEmJAiRkNZGYCBoRLDOBMpZz130kYECm03EBY3giCeqBpEABM/bx
 ZSSjcOh9zvQJNvv/hEyU3B3aB+PnSLk/uYVSGD/hjE0GdaiJkfUIiEtqz A=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Feb 2020 03:59:17 -0800
Received: from nasanexm03g.na.qualcomm.com ([10.85.0.49])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 07 Feb 2020 03:59:17 -0800
Received: from apsanexr02e.ap.qualcomm.com (10.85.0.28) by
 nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Fri, 7 Feb 2020 03:59:16 -0800
Received: from NASANEXM01F.na.qualcomm.com (10.85.0.32) by
 apsanexr02e.ap.qualcomm.com (10.85.0.28) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Fri, 7 Feb 2020 03:59:14 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01F.na.qualcomm.com (10.85.0.32) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Fri, 7 Feb 2020 03:59:14 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB5480.namprd02.prod.outlook.com (20.177.230.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Fri, 7 Feb 2020 11:59:13 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62%6]) with mapi id 15.20.2707.023; Fri, 7 Feb 2020
 11:59:13 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, Richard Henderson
 <rth@twiddle.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] Add support for a helper with 7 arguments
Thread-Topic: [PATCH] Add support for a helper with 7 arguments
Thread-Index: AQHV3HWNrLXzUmuR802n/46fb+QBo6gNrT4AgABKNoCAABLgEIAAQsYAgAAS9GCAAIHOgIAAPQ3ggABQQoCAADK5MA==
Date: Fri, 7 Feb 2020 11:59:13 +0000
Message-ID: <BYAPR02MB488630A709B44AEB43ABBED9DE1C0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1580942510-2820-1-git-send-email-tsimpson@quicinc.com>
 <09def3cf-6833-ccf5-457e-1755a7fd0e04@twiddle.net>
 <640ffa37-a70b-dfa9-55ef-cde5c7f0dfcb@twiddle.net>
 <BYAPR02MB48863BDFCB4CB26717467579DE1D0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <3614849d-12a5-fa43-fb10-801e9648b40e@twiddle.net>
 <BYAPR02MB48864A309572E1347920CAF0DE1D0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <34caf794-85b7-c177-7951-d821ace5caa9@linaro.org>
 <BYAPR02MB488682AB2538F8EBE631EA80DE1C0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <858bff3f-6e24-20a7-a7f3-49bee2cb8e12@linaro.org>
In-Reply-To: <858bff3f-6e24-20a7-a7f3-49bee2cb8e12@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [199.106.103.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8c968d8-8a38-4c39-cbf3-08d7abc5264f
x-ms-traffictypediagnostic: BYAPR02MB5480:
x-microsoft-antispam-prvs: <BYAPR02MB5480C2BADF973A67419FB370DE1C0@BYAPR02MB5480.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-forefront-prvs: 0306EE2ED4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(376002)(366004)(396003)(39860400002)(199004)(189003)(4326008)(186003)(6506007)(53546011)(110136005)(26005)(81166006)(4744005)(316002)(52536014)(55016002)(81156014)(8676002)(5660300002)(8936002)(2906002)(86362001)(66446008)(66556008)(33656002)(66946007)(66476007)(64756008)(76116006)(71200400001)(7696005)(478600001)(9686003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB5480;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dltvQnGA1UYhN6VEXvd5KmOYdOTnMer+ci4OUuCKY3igvUQFvjEB4OqG9ydS4iGs78UJFihZMhVn7obnsbky5LgnRUttoob4V9bzUbT4bfQBf4ywdU+CUjWcRw6TeKxb+Dem3e1mBn07tvWb3rP9+WRKK7IlqoEeU0+SrXRrvQj7VrVv/VlYJT7VAmshxJOc9QrsAwFJA+3ZRKtm/fLzSw47DpSanQtRxOwBvpnKhd9qaZZDPljjFQdNsmDDJUO4hebZiLpGH+RGzcST5W0L238joGH7J+3a06fZTsnP+Z7Q8TAgwWWXXJDUH/fuf/zP6fxw335oBRznXJN45H8wNiLfx9bFRffGDT/xrSzk3BqmifnkMp8tcviECLpp4aBMYTBo6ZG/JXk52T3tATteVcdqRHsBwpyuCgeziV0mqaoySTm5HGyGLqkAtP1ad73t
x-ms-exchange-antispam-messagedata: 6Eu5v+y1h12xN7n5N15soFyVHaE/z+5s484dVnZNP7m/zZXjRmCTemZIBXrcPNqojeHrrbQx41bpiNeTlfwKM6Q17lsyqUCrxMog1E0rJNO1jUylEf3tSfmtHzN0Wwk9Lf5lK82JRPOlTrq0OdCnHA==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JT+yU8GOvdVFiY+DeLsr44w1rzDh3/z+ePexTjIvf5YRvqovxyv726s8xoy4ybfSaV6bRyHwxkwA3WvFdbILHeKrJ7Lk6TKA1hD3bStjkKzlaRCwAlYNRvMtkJ00NEst2JM17icyuUvjCx2BdPEwJvAHCCAebrWIOs1JmyDR7Foe6/qQXrUqakrS6YXMi1UMbL99Bema36Peel07AdpJQ+SKFEh8aqaMHnDIeNkSZacD43KMjnPvqKIad11QgIi5JJYracvbsfrP5b6+ou/UZwelgLy7gNNJkjftH4SdsMRKYMQESwAokBykpDMv7LciugGyeXh4BIq/pb6FxJ04Hw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4z2DJgD/l8ZO1Aw0+7Z1uEKxAoPzJ0aEkXGrhuVaZw=;
 b=mTC+O+DW6zRrv+rZBqPGTJc/UafV11R275AZ/484B4aDY3ZV5JFy+A/9BhIwRl53mysvc7R8B6oPk+IS+1UUjC+XuIPJxHRXANdtTnFrYvcTqhmhPDIonj2sXQqqhu9IFsNcVHjTdJJOVyb1/npYB+tsdlzox3ro7lwI/LvOgzz/PFnr46ffc+Gw0+7aaJRpgUGzceZMMusp5aIzoU5pEuUdHyPeqnYisuzggggVHuN4P8Su6E7g6rYTdtn5TA6t1u/8YEuNz17JFrkcYsaF9FCuA5bW8at5YC+1SuCEdHMrMx1l76ZNS4e9f9KUI98slq1IV7Ztopu4qgWeea1JrA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4z2DJgD/l8ZO1Aw0+7Z1uEKxAoPzJ0aEkXGrhuVaZw=;
 b=md96pEIoWzzWW+eWsY5mYgu+n1PA5/fZUqcaQNjHpoPUf+2vwExjrSjtEvADFXS2A22+ulB5LjxT8wkzM8y045YxtInscEarYRjUMUTzaXHgZyRipit8M8W86wF6FQQTOY5mv0KaR5NSDMwreW2AC1Qbs/tgtkhcB2V/qqV8KYc=
x-ms-exchange-crosstenant-network-message-id: f8c968d8-8a38-4c39-cbf3-08d7abc5264f
x-ms-exchange-crosstenant-originalarrivaltime: 07 Feb 2020 11:59:13.4046 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 7fkFOHHLHt/QS1RUigX+zm8PAj5tn51onIJf9Bi75RG3Cap+GYyWbUSZbSMxBKBPBcjmNhtW9sS5bl1VujQPeg==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB5480
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.38
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmljaGFyZCBIZW5kZXJz
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgRmVicnVh
cnkgNywgMjAyMCAyOjUzIEFNDQo+IFRvOiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2lu
Yy5jb20+OyBSaWNoYXJkIEhlbmRlcnNvbg0KPiA8cnRoQHR3aWRkbGUubmV0PjsgcWVtdS1kZXZl
bEBub25nbnUub3JnDQo+IENjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBBZGQgc3VwcG9ydCBmb3IgYSBoZWxwZXIgd2l0aCA3IGFy
Z3VtZW50cw0KPg0KPiBPbiAyLzcvMjAgNDo0NiBBTSwgVGF5bG9yIFNpbXBzb24gd3JvdGU6DQo+
ID4+IEkgdGhpbmsgdGhhdCB3ZSBjYW4gZG8gdGhlIHN0b3JlIGltbWVkaWF0ZWx5IC0tIEkgZ2l2
ZSBzcGVjaWZpY3MgYWJvdmUuICBEbw0KPiB5b3UNCj4gPj4gaGF2ZSBhIGNvdW50ZXItZXhhbXBs
ZT8gIEFkbWl0dGVkbHkgSSdtIG5ldyB0byBicm93c2luZyB0aGUNCj4gYXJjaGl0ZWN0dXJlLA0K
PiA+PiBidXQgSQ0KPiA+PiBkb24ndCBzZWUgYSBsZWdhbCBwYWNrZXQgZm9yIHdoaWNoIHlvdSBj
YW4ndCBqdXN0IFN0b3JlIE5vdy4NCj4gPg0KPiA+IFlvdSBjYW4gaGF2ZSB0d28gc3RvcmVzIGlu
IGEgcGFja2V0LCBhbmQgdGhlIHNlY29uZCBvbmUgY291bGQgZmF1bHQuICBJZg0KPiBhbnl0aGlu
ZyBpbiB0aGUgcGFja2V0IGZhdWx0cywgbm9uZSBvZiB0aGUgaW5zdHJ1Y3Rpb25zIGNvbW1pdC4N
Cj4NCj4gVGhlbiB3aGF0IGRvZXMgdGhlIG1hbnVhbCBtZWFuIHdoZW4gaXQgc2F5cyAiZHVhbCBz
dG9yZXMgaGF2ZSBub24tDQo+IHBhcmFsbGVsDQo+IHNlbWFudGljcyI/ICBJcyB0aGF0IHNvbGVs
eSBhYm91dCB0aGUgc2VtYW50aWNzIG9mIHRoZSBieXRlcyBpbiBtZW1vcnk/DQoNCkNvcnJlY3Qu
ICBGb3IgZXhhbXBsZSwgdGhpcyBwYWNrZXQNCiAgICB7DQogICAgICAgIG1lbXcocjUpID0gcjYN
CiAgICAgICAgbWVtYihyNSkgPSByNw0KICAgIH0NCldpbGwgc3RvcmUgdGhlIHdvcmQgaW4gbWVt
b3J5IHdpdGggcjYgYW5kIHRoZW4gb3ZlcndyaXRlIHRoZSBmaXJzdCBieXRlIHdpdGggdGhlIGJ5
dGUgZnJvbSByNy4NCg0KDQo=

