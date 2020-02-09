Return-Path: <SRS0=SBSl=35=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56DFC2BA83
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2020 20:52:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D3F820733
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2020 20:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="xG8TcUct";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="hSMKJM2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D3F820733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0tZ6-0003ot-KW
	for qemu-devel@archiver.kernel.org; Sun, 09 Feb 2020 15:52:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1j0tXs-0003G6-Rg
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 15:51:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1j0tXr-0003dt-Oh
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 15:51:12 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:22103)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1j0tXr-0003c0-7N
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 15:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581281471; x=1612817471;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=oQ2iXTmD14eNJbYp3Kr8AkjLGBFiGSt2yNAykF9jXQI=;
 b=xG8TcUct41QFOR5l9t0e37Ug7CnKKC82OXUl8Y0hDnPbGt3jRRkNhYr+
 2DyqmJw2H47eVaeU2FZyDSmqJJRNU/WdmZj4QDsegKWtAHQH0fIgrA3nQ
 rhYP+p5o8S+C1u1X7+ONRrwhv31Q3qenVQJ8a6vp+0xo9Va8s8ByfathF k=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 09 Feb 2020 12:51:09 -0800
Received: from nasanexm03g.na.qualcomm.com ([10.85.0.49])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 09 Feb 2020 12:51:09 -0800
Received: from nasanexm03b.na.qualcomm.com (10.85.0.98) by
 nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Sun, 9 Feb 2020 12:51:08 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03b.na.qualcomm.com (10.85.0.98) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Sun, 9 Feb 2020 12:51:08 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB5621.namprd02.prod.outlook.com (20.178.0.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Sun, 9 Feb 2020 20:51:07 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62%6]) with mapi id 15.20.2707.028; Sun, 9 Feb 2020
 20:51:07 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, Richard Henderson
 <rth@twiddle.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] Add support for a helper with 7 arguments
Thread-Topic: [PATCH] Add support for a helper with 7 arguments
Thread-Index: AQHV3HWNrLXzUmuR802n/46fb+QBo6gPp2wAgAACx8CAADlQAIACaQnwgADlCQCAACYs8A==
Date: Sun, 9 Feb 2020 20:51:07 +0000
Message-ID: <BYAPR02MB488629639A76A15DAE7FBEC4DE1E0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1580942510-2820-1-git-send-email-tsimpson@quicinc.com>
 <b308434a-1ee8-4fb5-0e60-4dfdd047c959@linaro.org>
 <BYAPR02MB4886E14CC87B1169B2F6BE2BDE1C0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <a01b3358-a598-9d01-f3c8-d9a84fb7dd28@twiddle.net>
 <SN6PR02MB4895FE0821C3927B41636AB0DE1E0@SN6PR02MB4895.namprd02.prod.outlook.com>
 <fc6876dc-1a15-152c-5585-4ab06deb60fc@linaro.org>
In-Reply-To: <fc6876dc-1a15-152c-5585-4ab06deb60fc@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [70.115.140.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57ab35cf-7414-416f-97c0-08d7ada1c95d
x-ms-traffictypediagnostic: BYAPR02MB5621:
x-microsoft-antispam-prvs: <BYAPR02MB562123363BAD654C7859E779DE1E0@BYAPR02MB5621.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0308EE423E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39860400002)(199004)(189003)(7696005)(478600001)(110136005)(71200400001)(316002)(8936002)(8676002)(55016002)(52536014)(81156014)(5660300002)(9686003)(81166006)(4326008)(76116006)(66446008)(64756008)(66556008)(66476007)(66946007)(33656002)(186003)(53546011)(26005)(6506007)(86362001)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB5621;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +q2q3nI5VmYqrj+zPKBfC6aWOcaNSTAc48FcGs1BkMozr3wbRDFTzsj4QIaAgzjcJA5PIDd4LbDJ3oh8/Ol7PaAaTm5TikFBaoZg/Ue+qGF2gZaIWckFhUOxRe96dUiMMhshUBLYQJ3nsR2Q2oDTBjnwyCLl4teaWmC5Y3NUmP7tQT33+QmxKbPWoSL3R44GluM/Otb4kDeCbyqBI/bW5i0NyVq4fWq5dUiZKOh3eENjx2offwSgC8ydhjQAqVKt4vJmJE3dxdS3L++Asu4pFFmZrUiJlAKfJNOZKVpMBCnWkdIlsbB0+tP9Q4Lw7REgrKPHbCzVrwSSgqiLLPLRXuMl5iZspZy0ZYrtqidTkKXXQBXkIiCNmmRfgyMEmg/Dw4wR1rCk2UGTEi421/CONyVb6iWXPtt3yU6diiOBZa/z77tVazHRtGtWRhL2s0LN
x-ms-exchange-antispam-messagedata: VioPSya/vR+cVgd/xBc4Z8OH3me1ChjYL687EcWQMxsSH9htiOkXco3/3az2EuCKQ1e96n873Vn+ytebJwOE9CLnlpiXct+gFkj+t5c3rD39KtPQkjNNKaM0riuppqH23bQDPr2DdkLvjxQP4lacKQ==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FANRdul/YgMMf6D61Ythqt9aEg+tgweK+xs4qx8cA6czZjZu0bgLyo85ZiLZkocafiF9rSFJbi3Q0+nMRZVHjcF9C7cgpabucHl0pUt0sXxoHPOYw7VNIxqu3AbYM43WGFCq+/SAelnlDJ4hIIExkvFjkOycIqH2XyBVOK/hZpEffjoLL+ANqNHEDcPgf5aOs8BvHuwQYHVRMEaIVcjWcthi8abs2NuZSWoHuAdjHqxcdNkwxsZb1J+NI8pa+FnyI14GsJA2YDvCVnFbAke+i7UB2abyMQ+QnyfX3Y61yfehx0QDoMz9roRjJzf66e2iTTNUPYDFwUJ/F2wA+dlUiA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bQFBgQ5oDM6fVX4GWZyb3aB5Hbxzs2cBfzsBsp3hUI=;
 b=frlgQoWmWLOewv1VxEGli67vVoMDVNFeDhXyGw326MNVcihICmumBrvElZh0OU2sREJB0AA76BZzknp+sU/iGClNhjQoxqPrC2WG0uFtFMSK/lRpeGuS92YwA2xdwOdfcZVrBwERAHq5mDa8kYGVa9KmMOGC4c/Ifx6PT01CNVdw8vfDSd0ABAtH/uZgjnuGIavXzqnHwxtC9CQSlbJ5YeCryTpXTSHQm+oeeQ2NPfrvf+NI9EhLEY1Nyhk3M73r+A1UPmt0ralaXYG51zWA5QfCzU9yvysKVi/4dgZOO9czgZN2ZK6jxmsThEZEmceIXdtZc7v3Dj4FSxBEuC9qxg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bQFBgQ5oDM6fVX4GWZyb3aB5Hbxzs2cBfzsBsp3hUI=;
 b=hSMKJM2YXuUO2PkUe5l15Q1NsSUDO1Lt6yTPh190CR3Fkn+VOIfjW64dNesw/JpUcT0abURqsWU6eOChsuaTa98IgOSQf0qy3zA5nr5/mfOgh1qnlW7v7wlL4zKbjMlLL9wiY/XZ4BV8BQsjja2vxCeppinrg90uY6N3FqZStck=
x-ms-exchange-crosstenant-network-message-id: 57ab35cf-7414-416f-97c0-08d7ada1c95d
x-ms-exchange-crosstenant-originalarrivaltime: 09 Feb 2020 20:51:07.3619 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: JyOY0o/87D9b+RxCaW779S2svbGZVkEtNdOG+InFeX43U4N5a9sC80C9C0CC0zDYzHGP/elYU5xrxJlf0GSTSg==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB5621
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
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
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFN1bmRheSwgRmVicnVh
cnkgOSwgMjAyMCAxMjoxOCBQTQ0KPiBUbzogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNp
bmMuY29tPjsgUmljaGFyZCBIZW5kZXJzb24NCj4gPHJ0aEB0d2lkZGxlLm5ldD47IHFlbXUtZGV2
ZWxAbm9uZ251Lm9yZw0KPiBDYzogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0gQWRkIHN1cHBvcnQgZm9yIGEgaGVscGVyIHdpdGggNyBh
cmd1bWVudHMNCj4gV2UgY2FuIG9wdGltaXplIHRoZW0uDQo+DQo+IEhvd2V2ZXIsIHlvdSBzaG91
bGQgcHJlZmVyIHRvIHVzZSB0Y2dfZ2VuX2FkZGlfKiBvdmVyIHRjZ19nZW5fYWRkXyoNCj4gKGV0
Yykgd2hlbg0KPiB5b3Uga25vdyB0aGF0IG9uZSBvcGVyYW5kIGlzIGNvbnN0YW50LiAgVGhpcyB3
aWxsIG9wdGltaXplIGF3YXkgdGhlIGFkZCB6ZXJvDQo+IGltbWVkaWF0ZWx5IGFzIG9wcG9zZWQg
dG8gYWxsb2NhdGluZyBtZW1vcnkgYW5kIHdhbGtpbmcgdGhlIGRhdGENCj4gc3RydWN0dXJlcyB0
bw0KPiBlbGltaW5hdGUgaXQgbGF0ZXIuDQoNCk9LLCB3aWxsIHdvcmsgb24gdGhpcy4NCg0KPg0K
PiBXaHkgYXJlIHlvdSB1c2luZyBhIGxvY2FsIHRlbXBvcmFyeSBmb3IgRUE/ICBUaGF0IHNob3Vs
ZCBiZSBkZWFkDQo+IGltbWVkaWF0ZWx5DQo+IGFmdGVyIHRoaXMgc2xvdCBpcyBjb21wbGV0ZS4N
Cg0KVGhlIGRlY2xhcmF0aW9uIG9mIEVBIGlzIGFkZGVkIGJ5IHRoZSBnZW5lcmF0b3IuICBJdCdz
IGRlY2xhcmVkIGFzIGEgbG9jYWwgdGVtcCB0byBiZSBjb25zZXJ2YXRpdmUgaW4gY2FzZSB0aGVy
ZSBpcyBjb250cm9sIGZsb3cuICBJJ2xsIHdvcmsgb24gbWFraW5nIHRoZSBnZW5lcmF0b3Igc21h
cnRlci4gIEkgdGhpbmsgaXQgd2lsbCB3b3JrIHRvIGNoZWNrIGlmIHRoZSBpbnN0cnVjdGlvbiBp
cyBwcmVkaWNhdGVkIGFuZCB1c2UgYSB0ZW1wIGlmIGl0IGlzbid0Lg0KDQoNCj4NCj4gV2hhdCdz
IHdpdGggdHdvIHRlbXBvcmFyaWVzIGJvdGggbmFtZWQgIm5ld192YWx1ZSI/DQo+DQoNCkl0J3Mg
YWN0dWFsbHkgYW4gYXJyYXkgdGhhdCBwYXJhbGxlbHMgdGhlIEdQUnMuICBJJ20ganVzdCBwYXNz
aW5nIHRoZSBzYW1lIHN0cmluZyB0byBlYWNoIGNhbGwgdG8gdGNnX2dsb2JhbF9tZW1fbmV3LiAg
SSdsbCBjaGFuZ2UgaXQgdG8gYmUgYSB1bmlxdWUgc3RyaW5nIGZvciBlYWNoLg0KDQo+ID4+IEZv
ciBhIGNvbmRpdGlvbmFsIGxvYWQgaW4gc2xvdCAwLCB3ZSBjYW4gbG9hZCBkaXJlY3RseSBpbnRv
IHRoZSBmaW5hbA0KPiA+PiBkZXN0aW5hdGlvbiByZWdpc3RlciBhbmQgc2tpcCB0aGUgdGVtcG9y
YXJ5Lg0KPiA+DQo+ID4gSW4gZ2VuZXJhbCwgdGhlcmUgd2lsbCBiZSBsb3RzIG9mIGNoZWNrcyB3
ZSB3b3VsZCBuZWVkIHRvIHBlcmZvcm0gYmVmb3JlDQo+ID4gY29uY2x1ZGluZyB0aGF0IGFuIGlu
c3RydWN0aW9uIGNhbiB3cml0ZSBkaXJlY3RseSBpbnRvIHRoZSBkZXN0aW5hdGlvbi4gIEZvcg0K
PiA+IGV4YW1wbGUsIHdlIGhhdmUgdG8gbWFrZSBzdXJlIG5vIG90aGVyIGluc3RydWN0aW9uIGxh
dGVyIGluIHRoZSBwYWNrZXQNCj4gcmVhZHMNCj4gPiByNy4NCj4NCj4gV2hpY2ggaXMgb2YgY291
cnNlIGFsbCB0cml2aWFsIGZvciBzbG90IDAsIGJlaW5nIGxhc3QuDQoNClNsb3QgMCBtaWdodCBi
ZSBsYXN0IGluIHRoZSBlbmNvZGluZywgYnV0IHRoYXQgZG9lc24ndCBtZWFuIGl0IGlzIHRoZSBs
YXN0IG9uZSB0byBleGVjdXRlLiAgUmVtZW1iZXIgdGhhdCB0aGUgcGFja2V0IGdldHMgcmVvcmRl
cmVkIGJlZm9yZSBUQ0cgZ2VuZXJhdGlvbiBzbyB0aGF0IC5uZXcgZGVmaW5pdGlvbnMgYXJlIGJl
Zm9yZSB0aGVpciB1c2VzLiAgU28sIGlmIHRoZSByZXN1bHQgb2YgdGhlIHNsb3QgMCBpbnN0cnVj
dGlvbiBpcyB1c2VkIGJ5IGEgLm5ldyByZWZlcmVuY2UsIGl0IHdvbid0IGJlIGxhc3QuDQoNCg==

