Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C87C4BA12
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 16:14:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73FE72084E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 16:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z3NdzPKh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="j/M51cZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FE72084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6zK8-0006Wh-L2
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 11:14:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1j6zJW-0005vF-QT
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 11:13:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1j6zJV-0002ig-Jr
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 11:13:34 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:25693)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1j6zJV-0002dJ-4w
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 11:13:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1582733613; x=1614269613;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vZJyeU0K9+p7yxk2hlAS3ZSNDm8hXLlWvlng90plYXI=;
 b=Z3NdzPKhAE4oGxy+321LZj0Un3BA8eEeTrT9e4nIK7jnTkxMoSKo74eT
 VO71+cT/QbG7aYwuY8ibu4k/z8YM6tYBDaxM38pXSWnLh1Rmr87y79cAo
 Zx6zPumCpBP04Jt2q0zxws7GfI4BrkOVJPNZnTvM4QETsOeqwz3N/9dBA g=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 26 Feb 2020 08:13:31 -0800
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 26 Feb 2020 08:13:30 -0800
Received: from apsanexr02a.ap.qualcomm.com (10.85.0.26) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 26 Feb 2020 08:13:30 -0800
Received: from nasanexm03e.na.qualcomm.com (10.85.0.48) by
 apsanexr02a.ap.qualcomm.com (10.85.0.26) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 26 Feb 2020 08:13:28 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Wed, 26 Feb 2020 08:13:28 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4950.namprd02.prod.outlook.com (2603:10b6:a03:47::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Wed, 26 Feb
 2020 16:13:27 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62%6]) with mapi id 15.20.2772.012; Wed, 26 Feb 2020
 16:13:27 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH 00/66] Hexagon patch series
Thread-Topic: [RFC PATCH 00/66] Hexagon patch series
Thread-Index: AQHV4HP9ew7ciRaxPECLDYxbEpXz4agWH/eAgBedwcA=
Date: Wed, 26 Feb 2020 16:13:26 +0000
Message-ID: <BYAPR02MB4886CF6A55DB2DB00896B3A1DEEA0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
 <cc5cf589-f27e-151e-964b-6a263e2f668d@redhat.com>
In-Reply-To: <cc5cf589-f27e-151e-964b-6a263e2f668d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [199.106.103.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1a084be-2373-4372-d2bb-08d7bad6d000
x-ms-traffictypediagnostic: BYAPR02MB4950:
x-microsoft-antispam-prvs: <BYAPR02MB4950A8EA9D07C072D4197D17DEEA0@BYAPR02MB4950.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(346002)(376002)(39860400002)(366004)(199004)(189003)(26005)(316002)(54906003)(110136005)(4326008)(2906002)(53546011)(478600001)(186003)(8676002)(81156014)(81166006)(9686003)(6506007)(55016002)(33656002)(71200400001)(4744005)(5660300002)(8936002)(86362001)(66946007)(52536014)(66446008)(76116006)(66476007)(66556008)(64756008)(7696005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB4950;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +6FwsyOUe8+20H0PBTWKcMLnJxXjovf83txpM8N72Gsa0cahWhlb2+5E1ZcJftRPVmtyJ8UaEpbQV0fVBVa6y77LeKi7Gs8RRi6RF/CNbhc0wVoxQl7Qk48HCiY6Sqh8chV8M2ljhdKiY3QrGUnEVhE1nbEo9eV2Ao1aOdWlONfv0rXGdetT5P32i6Xynx7RW7zTeizcffv5iVa/zV2tl5VvEMzTJuN+tF6wyAPj+gRlnOjxqdLEcHfeciI7VRTi8S1kIl07n8/TaS+4UU8WinXPpRkCXftK9FaXoLVY2Rky8V/I+ijSB4EdaHx/jIpXU1J5/601bOS84SbQOfsjd1f0VZ4Z5BgYgX+znxNTyl0BJSK9+Fo+hHKxKukfu3v76lbuLe8+5atcb5MertZFLi3HoN28SrQhbT/1Z4DZMUUW769jDT9n4WL1fxNKUOGx
x-ms-exchange-antispam-messagedata: p59HxuSNwStf4wc8Ic9o5WvkkaJsWvGGJGbYkigzHY8EtlhbDGElkuMzGAriXVh4L2nll9/gB39Zs/guFfTsT1pC5FGBS49wx2/tSSTUV8HSIrpm8oMPWrxDTnqzzWdv0vBuCmsp1AoGAjv7UKtR1A==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZruW9LupNsJdjCY9fmA+/p36HC0rpVoec3sIizyCYauB2D99xH5iXqobUTenn/ca7mHjQeOA/vJIL21h/IswRxA8d2dEORsX4HvuqcseBT7mWd8QoeGuBXgyWX3wR2YmJ1FxIclkCvESsqhkNTJu/gKQYEzFuVzCjEv/flyGi06KWW6Wx0TMgdm/OiZ6PO2T3sO1zTLABFxbFthkBWdzYEKzIWt7ClBDs90YBg4h2DDfv0nW5jpCG6r83+MYgdjCDtPvx/mn+HUroNshNdxQ1ZdwW+TOkUalhUILsREAYS4KPt7dt8xDOCiajHzeVfJLOZidwmKnwwQzNx7H1SDYQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECe0Bm8fsxTsBQ6Z5U5QZm9R/pDIpBNQvlmmUSlfEVE=;
 b=gODCK7va6ITK6hgca4jIWrM/Nt4D2Gznn4X0TaD4JKUlrZjd6hLycF/FDj2/Vw6H3jNtES2U8K90eJxQm0IkWacwHuql1OB0X7b6332B9TkIZ4HJBm+0yvvjAQb0znjBlwapeino6Xe5ml1QEripfjmj3esmHmLX8SaDkXqMe6VFmHxGhO/9ZjAkN5Twp0D3f+7HCDouaJ9cqJTIFji3SpO+11tlix6Cq0i8qDbTsT/FN3wSTdgNAUt/AReMSBYU79Rep21Fesd1aPZNdnEhwf2swPtmisi/s0PGhKWpNSsXWAMAbu5RPDXP8ltzTYM/7GFoXC3xqkI8KED8iVkbpg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECe0Bm8fsxTsBQ6Z5U5QZm9R/pDIpBNQvlmmUSlfEVE=;
 b=j/M51cZYu8pByWZFXw+jPh/nvKh0fxs10NMjIqwxcanLLm1wN35a4wYJGHLwyQDpBFYMWHb7Srex6euLcOqcVf+0hnKNKeSvV8N/aonY5mMJYakgn+nYhWuqS7cynJBA87ScbwTpvjlnpdDt9zyfgfI+mFHVawdtH5W/ZzWKu+E=
x-ms-exchange-crosstenant-network-message-id: a1a084be-2373-4372-d2bb-08d7bad6d000
x-ms-exchange-crosstenant-originalarrivaltime: 26 Feb 2020 16:13:26.9408 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: aYQguAz8QS0WCBL8KFvi63DtCHLMmz3I/WQvkVa25pTMkjb+4OZNkDVCXmdp0c1fp5mAiNdeNqly1znTX+Gnug==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4950
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
Cc: "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgYWxsLA0KDQpJJ3ZlIG1hZGUgdGhlIGNoYW5nZXMgZnJvbSBQaGlsaXBwZSdzIHJldmlldyBv
ZiB0aGUgcGF0Y2ggc2VyaWVzLiAgSWYgdGhlcmUgaXMgbm8gbW9yZSBmZWVkYmFjaywgSSdsbCBw
cmVwYXJlIHYyIGFuZCBzZW5kIGl0IHRvIHRoZSBsaXN0Lg0KDQpUaGFua3MsDQpUYXlsb3INCg0K
DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4NCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgMTEs
IDIwMjAgOTozMiBBTQ0KPiBUbzogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29t
PjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiByaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8u
b3JnOyBsYXVyZW50QHZpdmllci5ldTsgcmlrdS52b2lwaW9AaWtpLmZpOw0KPiBhbGVrc2FuZGFy
Lm0ubWFpbEBnbWFpbC5jb20NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMDAvNjZdIEhleGFn
b24gcGF0Y2ggc2VyaWVzDQo+DQo+DQo+IFBsZWFzZSBsb29rIGF0IHRoZSBmaWxlIHNjcmlwdHMv
Z2l0Lm9yZGVyZmlsZSBhbmQgaWYgcG9zc2libGUgaW5zdGFsbCBpdA0KPiBiZWZvcmUgeW91ciBu
ZXh0IHZlcnNpb24gKHBsZWFzZSB3YWl0IGF0IGxlYXN0IDEgd2VlayBiZXR3ZWVuIHZlcnNpb24s
DQo+IGZvciBhIHNvIGJpZyBzZXJpZXMhKS4gVGhpcyBzY3JpcHQgb3JkZXIgZmlsZXMgaW4gcGF0
Y2ggaW4gYSB3YXkgZWFzaWVyDQo+IHRvIHJldmlldyBieSBtYWlsLg0KDQo=

