Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D853C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37B2620715
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n97QKspT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="ACZhx7H3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B2620715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0301-0005K0-EE
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 07:44:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1j02zF-0004XY-Fm
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:43:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1j02zE-0005uz-Fv
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:43:57 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:17508)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1j02zE-0005pZ-1c
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581079436; x=1612615436;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GgmupYRlbe3YCsT0jISnC4ouv8rAkp6F2rf8QyRlEGM=;
 b=n97QKspTf5ozY5tNChEv62GvDYRAMjaL2iqTjkqNwTJ0cdv0PZBPVN5U
 Yjwxrm5gYgfoWk/Ityfu6Gw+QeEnK+lBAIS59PsGPEcg8e74mFYxlgqdG
 SbDHzZ7PiAmZr6TiDfvgJbDWwBVtnjNs3pyvntpeNzRS1xr04zwj9sksm 4=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 07 Feb 2020 04:43:53 -0800
Received: from nasanexm03a.na.qualcomm.com ([10.85.0.103])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 07 Feb 2020 04:43:53 -0800
Received: from APSANEXR01B.ap.qualcomm.com (10.85.0.37) by
 nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Fri, 7 Feb 2020 04:43:53 -0800
Received: from nasanexm01a.na.qualcomm.com (10.85.0.81) by
 APSANEXR01B.ap.qualcomm.com (10.85.0.37) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Fri, 7 Feb 2020 04:43:50 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm01a.na.qualcomm.com (10.85.0.81) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Fri, 7 Feb 2020 04:43:49 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB4326.namprd02.prod.outlook.com (52.135.237.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Fri, 7 Feb 2020 12:43:49 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62%6]) with mapi id 15.20.2707.023; Fri, 7 Feb 2020
 12:43:48 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH] Add support for a helper with 7 arguments
Thread-Topic: [PATCH] Add support for a helper with 7 arguments
Thread-Index: AQHV3HWNrLXzUmuR802n/46fb+QBo6gPp2wAgAACx8A=
Date: Fri, 7 Feb 2020 12:43:48 +0000
Message-ID: <BYAPR02MB4886E14CC87B1169B2F6BE2BDE1C0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1580942510-2820-1-git-send-email-tsimpson@quicinc.com>
 <b308434a-1ee8-4fb5-0e60-4dfdd047c959@linaro.org>
In-Reply-To: <b308434a-1ee8-4fb5-0e60-4dfdd047c959@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [199.106.103.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85be8268-edff-4651-a90c-08d7abcb60f3
x-ms-traffictypediagnostic: BYAPR02MB4326:
x-microsoft-antispam-prvs: <BYAPR02MB4326A5F9D958D92CA04782F5DE1C0@BYAPR02MB4326.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0306EE2ED4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(39860400002)(376002)(396003)(366004)(189003)(199004)(186003)(4326008)(8676002)(81166006)(81156014)(86362001)(33656002)(71200400001)(26005)(478600001)(6506007)(55016002)(2906002)(76116006)(64756008)(9686003)(66446008)(66946007)(66556008)(66476007)(54906003)(7696005)(5660300002)(110136005)(8936002)(316002)(52536014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB4326;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yExg7KEJpj7Bb2XM4cNKADdlGMofm4x4tXgPUFa8TQQh7x0lJehHkDrksAjxly6n9CrIb2l8uc9sbNUb/7o2TC2npxlPT05zeFiEjD2myQ8R3Jy3R1RgsLO0Azf1XKRCLQMgdbwwZrnKXsBeQhAhxULZWTGzvPXs+egPriTQAHJbR4jSNos4t/qEeMQcShVS2m1hV/ZKml6GsM0vxqQKtB/YKvcslTJvQbdKHMWYHY2966GzFA195jnKTuA7+pdUK7MwzSJUhj7Rf1NhvKvDrwZMLl+y//sYkykerAtdU7fD6I+cVfJdcouO1TSJP2bwWSWEiBQ6VDEpo9KahIqx0y7URv/EyqP18lslS0oE5ubxJGhxqSS40yyRwthPzq2Lo86fxE073z7I6qKrN3B8tJvw6RWACgnOB6EVahg5G3RSjrjYMLuNXEQgVXiRZXw/
x-ms-exchange-antispam-messagedata: E2sjsSYoXLYygJ3npPBz23VaNHn3vM0QKSfgHbhbsu6xX/LXPZJ2n80vq8FHwcoJBSJ66v/c0jvHOiwwL8JVwXooM49cm4Qo3Ml/BLFdyTYt3GzedZlEw68T0Q93K0QKA2/Zb7tWA3fQkETw9GIZag==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgXNx0qAjjIAo4E8wHhVp/5knqlFV2uKm3DFgE8vZml18ShccG0N6SKHVcyKTf2FVO7PG8nERGkMYqYrkZAmBNYA6eMUrD1OKGbGmmRP2wutG4j0/lZUwkjNvdp5rKPJK7vR9Bo9HzLuUf4sjEckFMM29sfBtO29zhIWjrR/meVZB4IOXfItbajENrLvIhThl4KcV1Igaw4k7Csfx2XLPgwazCmto4eHFteuPWP1Wj9K1ut1rQh4B8eVI9r2yJcOIucj9hNPNAEqkn4DTQhzTYAJXUfe93A6nvYIEh1hdwpC8LblBaK/pwG5gehy7QVw2iDtIMdqz0RMvZ6T/dHsEQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4F+WPDLaYjD49d0OXP6KelEuyjFLFOacIOsIZx8eKY=;
 b=eNOz5TWdWucF8JXv4Hm5rOWLfAK7JGHiRc20ARQaYnljKetHMFkLvmJgrlF5bwNWi9Ae2StYnqz+rpRq1O9KPz5TeQ3DO2vdqZ3O5ZRor2YLK8/xRERqfe0ET82420h5pFbExnkfAczgUyMCAQE4dK44uuxMjLI09FhVQaDsjKhLw1mb6ZNRoMirroGV6iBJKRxvkapO3DcAraBYCyq3rPVQyMSGxtLE91oW6K6ckHRUcQ54Grh3Z4pKS3nS7rDB+D7GTtwyqG2rSTdpizKyErXwmOi+fqTYQLEed1rBPbfMUZvcakZ6zkkO/dcVRMSb4EFDLJsQvTjP++fIBjXqjw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4F+WPDLaYjD49d0OXP6KelEuyjFLFOacIOsIZx8eKY=;
 b=ACZhx7H3qBmbuPZAWZ5Ugy7EWVriIfDmFzFz4RU4jwaxEYRCY6We20T50NENDoI3rpGTNCKLvfM8uRYlUgcYxLvye3ZQzzKNodB0itAQb1EOq6ZfUcHvkd0S0BOuqIZQGmHZIHsRCOYoe1GnwsjB4llzqK0zuif581QShBfrNq0=
x-ms-exchange-crosstenant-network-message-id: 85be8268-edff-4651-a90c-08d7abcb60f3
x-ms-exchange-crosstenant-originalarrivaltime: 07 Feb 2020 12:43:48.7947 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: TQw07Beya16igVA3zQKmmnKiTBG3olkI8+bDGeOmsBpnjeLUQMGqr1vWlN4QgoG2lpBl9O6yHLq/+unLu2d/YQ==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4326
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJpY2hhcmQgSGVuZGVyc29u
IDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPg0KPg0KPiBCdXQgSSBlbmNvdXJhZ2UgeW91
IHRvIHJlLXRoaW5rIHlvdXIgcHVyZWx5IG1lY2hhbmljYWwgYXBwcm9hY2ggdG8gdGhlDQo+IGhl
eGFnb24NCj4gcG9ydC4gIEl0IHNlZW1zIHRvIG1lIHRoYXQgeW91IHNob3VsZCBiZSBkb2luZyBt
dWNoIG1vcmUgZHVyaW5nIHRoZQ0KPiB0cmFuc2xhdGlvbg0KPiBwaGFzZSBzbyB0aGF0IHlvdSBj
YW4gbWluaW1pemUgdGhlIG51bWJlciBvZiBoZWxwZXJzIHRoYXQgeW91IHJlcXVpcmUuDQo+DQoN
ClRoZXJlIGFyZSBhIGNvdXBsZSBvZiB0aGluZ3Mgd2UgY291bGQgZG8NCi0gU2hvcnQgdGVybTog
QWRkICNpZmRlZidzIHRvIHRoZSBnZW5lcmF0ZWQgY29kZSBzbyB0aGF0IHRoZSBoZWxwZXIgaXNu
J3QgY29tcGlsZWQgd2hlbiB0aGVyZSBpcyBhIGZXUkFQXzx0YWc+IGRlZmluZWQuICBUaGVyZSBh
cmUgY3VycmVudGx5IH41MDAgaW5zdHJ1Y3Rpb25zIHdoZXJlIHRoaXMgaXMgdGhlIGNhc2UuDQot
IExvbmcgdGVybTogSW50ZWdyYXRlIHJldi5uZydzIGFwcHJvYWNoIHRoYXQgdXNlcyBmbGV4L2Jp
c29uIHRvIHBhcnNlIHRoZSBzZW1hbnRpY3MgYW5kIGdlbmVyYXRlIFRDRyBjb2RlLg0KLSBMb25n
IGxvbmcgdGVybTogQSBtdWNoIG1vcmUgZ2VuZXJhbCBhcHByb2FjaCB3aWxsIGJlIHRvIHR1cm4g
dGhlIEMgc2VtYW50aWNzIGNvZGUgaW50byBMTFZNIElSIGFuZCBnZW5lcmF0ZSBUQ0cgZnJvbSB0
aGUgSVIuDQoNCkFsc28sIG5vdGUgdGhhdCBiZWluZyBhYmxlIHRvIHVzZSBlaXRoZXIgYSBoZWxw
ZXIgb3IgVENHIGNvZGUgaXMgZXh0cmVtZWx5IHVzZWZ1bCBmb3IgZGVidWdnaW5nIHFlbXUtaGV4
YWdvbi4gIFdoZW4gYSB0ZXN0IGlzIGZhaWxpbmcgYW5kIHlvdSBzdXNwZWN0IGEgYnVnIGluIFRD
RyBnZW5lcmF0aW9uLCB5b3UgY2FuIHN3aXRjaCB0byB0aGUgaGVscGVyIHZlcnNpb24gYW5kIHNl
ZSBpZiB0aGUgdGVzdCBwYXNzZXMuICBUaGVyZSBoYXZlIGJlZW4gY2FzZXMgd2hlcmUgSSB1c2Vk
IGJpbmFyeSBzZWFyY2ggb3ZlciB0aGUgZldSQVAgZGVmaW5pdGlvbnMgdG8gZmlndXJlIG91dCB3
aGljaCBvbmUgb2YgdGhlbSBoYXMgdGhlIGJ1Zy4gIEFsc28sIGl0IGNhbiBiZSB2ZXJ5IGhhbmR5
IHRvIGJlIGFibGUgdG8gc2V0IGEgYnJlYWtwb2ludCBpbnNpZGUgdGhlIGhlbHBlciBhbmQgZXhh
bWluZSB0aGUgQ1BVIHN0YXRlIGluIHRoZSBtaWRkbGUgb2YgVENHIGV4ZWN1dGlvbi4NCg0KVGF5
bG9yDQoNCg==

