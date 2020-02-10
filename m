Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702B5C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 04:55:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34EF5208C4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 04:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JqgaNoN7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="ju3PQHFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EF5208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j116H-00074o-9U
	for qemu-devel@archiver.kernel.org; Sun, 09 Feb 2020 23:55:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1j115a-0006ar-Px
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 23:54:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1j115Y-0007mR-SB
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 23:54:30 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:45723)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1j115Y-0007hx-Bt
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 23:54:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581310468; x=1612846468;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=n1/t7bwcvbD+yuclPqEoqkWsaF1Pk9l1z/zlPuWYnuo=;
 b=JqgaNoN7TBGcAjBf9/j0RGRqWyfgJkO5E9lGYdJlM+JqJ7UgWCpl5kL0
 PlzM83JWZfgV+Ivgw0mx0uV5siq6OU0yMPmGhj50SU1wcadCzrlsyIziA
 9hJGyzlDW1rAqSthrWxOGcMZ3nPRc0eDPb5KddsAz9NUxTWsPlt3xSrHo s=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Feb 2020 20:54:26 -0800
Received: from nasanexm01h.na.qualcomm.com ([10.85.0.34])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 09 Feb 2020 20:54:26 -0800
Received: from apsanexr02e.ap.qualcomm.com (10.85.0.28) by
 NASANEXM01H.na.qualcomm.com (10.85.0.34) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Sun, 9 Feb 2020 20:54:26 -0800
Received: from nasanexm03e.na.qualcomm.com (10.85.0.48) by
 apsanexr02e.ap.qualcomm.com (10.85.0.28) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Sun, 9 Feb 2020 20:54:24 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Sun, 9 Feb 2020 20:54:24 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB5894.namprd02.prod.outlook.com (20.179.63.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.29; Mon, 10 Feb 2020 04:54:21 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62%6]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 04:54:21 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, Richard Henderson
 <rth@twiddle.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] Add support for a helper with 7 arguments
Thread-Topic: [PATCH] Add support for a helper with 7 arguments
Thread-Index: AQHV3HWNrLXzUmuR802n/46fb+QBo6gPp2wAgAACx8CAADlQAIACaQnwgADlCQCAACYs8IAAidow
Date: Mon, 10 Feb 2020 04:54:21 +0000
Message-ID: <BYAPR02MB4886B8437B6D20F8F6F60DDADE190@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1580942510-2820-1-git-send-email-tsimpson@quicinc.com>
 <b308434a-1ee8-4fb5-0e60-4dfdd047c959@linaro.org>
 <BYAPR02MB4886E14CC87B1169B2F6BE2BDE1C0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <a01b3358-a598-9d01-f3c8-d9a84fb7dd28@twiddle.net>
 <SN6PR02MB4895FE0821C3927B41636AB0DE1E0@SN6PR02MB4895.namprd02.prod.outlook.com>
 <fc6876dc-1a15-152c-5585-4ab06deb60fc@linaro.org>
 <BYAPR02MB488629639A76A15DAE7FBEC4DE1E0@BYAPR02MB4886.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB488629639A76A15DAE7FBEC4DE1E0@BYAPR02MB4886.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [70.115.140.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17da254c-bc7d-45a3-a7ae-08d7ade54b43
x-ms-traffictypediagnostic: BYAPR02MB5894:
x-microsoft-antispam-prvs: <BYAPR02MB5894453746878897834371F3DE190@BYAPR02MB5894.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03094A4065
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(396003)(346002)(366004)(39860400002)(199004)(189003)(52536014)(316002)(110136005)(33656002)(4744005)(186003)(7696005)(6506007)(26005)(5660300002)(86362001)(53546011)(8936002)(2906002)(478600001)(8676002)(81156014)(81166006)(71200400001)(4326008)(76116006)(9686003)(66476007)(64756008)(55016002)(66556008)(66446008)(66946007)(21314003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB5894;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D3/u9equdglYnT9RnEkCiAy5ftnVkwEuJmMeOm0QNMMFeLti4ZRFNzlwix942jlHvc4Ohbqa7XNgoUmwkJcEGdgLIwxHqDby1XJhwVm2mRhpGRWpCcZvqziZqBZmc7xQPA2xB5enmWgMLgxTGhsriHEsdeigrL4AW54ps0/EAzBZUAMj5jT0YljC5WAidxTXGlsH6f5EndpK9JisJwaEqBckLTFJfU+wcnvmu0TO/NYHsirIkfbXLu46Qr0VPnnGyxNq88sJtShmtJvKT4Z5vE8gxACCi+NlldjOO+ZMKwWvXdWn3LaePmint14RJTW+nDgl07V5cLZ+N5kAr4sC+wWir1spqE+0RrkLt7QRPnvMp+inewKbVWGnu0lQb96uFKiv18jU48Vqx44X8DC6rlGqj8UUC8ly5Y4wzaVchoJchlQHq7q+jgbncBWrfn86WZnmGJPn/0nwkx9ThzStq5UwXaXLLnOzaSg7AODQAJ3py7I8+6N7Gof2E3yh9skq
x-ms-exchange-antispam-messagedata: vPOOGppL8673aQheGSSbEedNQJBgb0pObBoaHuS1bwIn3DNMUmQmQsyNGbywByEvJhO0Lik9djS3YiTmPzp2Jb86Akzr5KWDU0o6fTqlJex5/OLwQW7Rc8ap7h4L07XFaVvPcmDGKzgK9jURrMkmEQ==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpyGJjZf0fd70kmAsvf8K9F7ieF9qCCYdeKw4xMNYnEwGP1FLft06Xhouv/y5OTSgkMvDMrVZw3c1UAWVQUsOspJTGaXwXHPllsuPEZC1wiIYzcO1WntoQN0dzkY8dx29qlf9oNSoXwN0eA7tuWv/lb+T5YbHAJuUov/9PjfmjGIvqiI3ycPPRW1M000aBGEaQVoXzxxTNYuI9BnwOZDDOmrBlJcTZX+bMrThGFt090jSSe/nPErbmVmlTyE96o6c1ZbDmNFvkEOVqg+VoWgHLjvRbREj6S3UfRhHJgfwlZrQodoaC87ChD5kyP4iyiOSxqyShwhXAn1rHcUc4b7KQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swkFcdpx1pb9DE5Rr/MA1G5tsLGHy+K5DqtBhckpBGA=;
 b=FObUZoQqy7MFlt40XVnq2lhBFqRFcQsHIsgaMOlTI/vf0XX8EFmYrUMAV9vAVXDeVpeaZIz3NVl1EcRHZ7LqW77OzSr7G4wpdsVr8OAuNXjP9SP+C7Vnrc9j/kZROekzocoDL5uUL5wKD41tBAg/ppqghHezea4U7dIWJpS3ilKP6PA5E8nMr8bWEOiAnxBMToHkZ4X+1SDY9TKjp/wMnVXOctWeoJ6BFUs/aJcs/Gueqiqanf5mli7J6pV5k+7XzZ4wRE4ereQER1mw/GI7n0NOvZnmLDMKeIFL3VSiejsX4D4JtjjsHidj8S0afUaBc4AnhEvLj1DrShqQCJquuw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swkFcdpx1pb9DE5Rr/MA1G5tsLGHy+K5DqtBhckpBGA=;
 b=ju3PQHFEUBSQinQrb0cIj+z/Gy6NM+JKb9Nk+t1s+Sju2b7U0Uxnk3Os8LmP4LV4VmsFq5uHW+Q89rGMPGgQk1MZAqr8aqf+5ULTyl2LQc2MLHJonzFfBw03nLFUPF3QFysw12FXhmaeDseNZBvbYnjk8NYN+Mt51cB1pBF9nbw=
x-ms-exchange-crosstenant-network-message-id: 17da254c-bc7d-45a3-a7ae-08d7ade54b43
x-ms-exchange-crosstenant-originalarrivaltime: 10 Feb 2020 04:54:21.6696 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: mgbnre8IiQOBY5Wn573zFlC+rE0FbQH332ughNXs2Pc5ApDHSRvgEaSLnfFCzpK6QbPOjyGf0gCJh0QLFFFROA==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB5894
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUYXlsb3IgU2ltcHNvbg0KPiBT
ZW50OiBTdW5kYXksIEZlYnJ1YXJ5IDksIDIwMjAgMjo1MSBQTQ0KPiBUbzogUmljaGFyZCBIZW5k
ZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+OyBSaWNoYXJkIEhlbmRlcnNvbg0K
PiA8cnRoQHR3aWRkbGUubmV0PjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBQYW9sbyBC
b256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIXSBBZGQg
c3VwcG9ydCBmb3IgYSBoZWxwZXIgd2l0aCA3IGFyZ3VtZW50cw0KPg0KPiA+IEhvd2V2ZXIsIHlv
dSBzaG91bGQgcHJlZmVyIHRvIHVzZSB0Y2dfZ2VuX2FkZGlfKiBvdmVyIHRjZ19nZW5fYWRkXyoN
Cj4gPiAoZXRjKSB3aGVuDQo+ID4geW91IGtub3cgdGhhdCBvbmUgb3BlcmFuZCBpcyBjb25zdGFu
dC4gIFRoaXMgd2lsbCBvcHRpbWl6ZSBhd2F5IHRoZSBhZGQNCj4gemVybw0KPiA+IGltbWVkaWF0
ZWx5IGFzIG9wcG9zZWQgdG8gYWxsb2NhdGluZyBtZW1vcnkgYW5kIHdhbGtpbmcgdGhlIGRhdGEN
Cj4gPiBzdHJ1Y3R1cmVzIHRvDQo+ID4gZWxpbWluYXRlIGl0IGxhdGVyLg0KPg0KPiBPSywgd2ls
bCB3b3JrIG9uIHRoaXMuDQo+DQoNCk9uZSBxdWVzdGlvbiBJIGhhdmUgZnJvbSBpbXBsZW1lbnRp
bmcgdGhpcyBpcw0KLSBJcyB0aGVyZSBhIHdheSB0byBwYXNzIGEgY29uc3RhbnQgdmFsdWUgdG8g
Z2VuX2hlbHBlcl9YWFg/DQpJdCB3b3VsZCBiZSBncmVhdCBpZiB0aGlzIHdvdWxkIGJlIHBvc3Np
YmxlIGluc3RlYWQgb2YgY2FsbGluZyB0Y2dfY29uc3RfdGwoKSBhbmQgcGFzc2luZyB0aGUgVENH
di4NCg0KQUZBSUNULCB0aGUgREVGX0hFTFBFUiBtYWNyb3MgZG9uJ3QgaGF2ZSBhbiBvcGVyYW5k
IHR5cGUgdGhhdCB0YWtlcyBhIGNvbnN0YW50LiAgSSB0aGluayBzMzIsIGkzMiwgYW5kIGludCBh
bGwgZXhwZWN0IFRDR3YgYXQgdGhlIGNhbGwgc2l0ZS4NCg0KVGhhbmtzLA0KVGF5bG9yDQoNCg==

