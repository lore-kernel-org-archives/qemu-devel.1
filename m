Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A9BC54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 22:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C80B32074F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 22:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="sD9aH5l3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="QZqNHu5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80B32074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS77P-0004oF-Rn
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 18:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jS76P-00047O-KH
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 18:47:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jS76O-0000Fr-VY
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 18:47:21 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:58781)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jS76K-0008Kt-6h; Fri, 24 Apr 2020 18:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1587768436; x=1619304436;
 h=from:to:cc:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version:subject;
 bh=HKv9dgYsbFjo+BlXDMFmbXScFkZ2XprfLNLfofll10M=;
 b=sD9aH5l3xrKkZlt4uYlGndL97250TGKgZe/BDc7QHJAZSZ8IaayYt8LU
 IwSqEtgEHfpatVogLSZBKMnvqoDZX2jhD9ingk/mIZjl4i20/3ZfQi/Xf
 VK8Uw3FoEsXmnsPywTblyIkILZ3YNOsBK/JunGY8s5vyfkJlw3W9oAYHP k=;
Subject: RE: [PATCH RFC] target/arm: Implement SVE2 TBL, TBX
Thread-Topic: [PATCH RFC] target/arm: Implement SVE2 TBL, TBX
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Apr 2020 15:47:12 -0700
Received: from nasanexm01e.na.qualcomm.com ([10.85.0.31])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 24 Apr 2020 15:47:12 -0700
Received: from APSANEXR01E.ap.qualcomm.com (10.85.0.38) by
 NASANEXM01E.na.qualcomm.com (10.85.0.31) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 24 Apr 2020 15:47:12 -0700
Received: from NASANEXM01B.na.qualcomm.com (10.85.0.82) by
 APSANEXR01E.ap.qualcomm.com (10.85.0.38) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 24 Apr 2020 15:47:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01B.na.qualcomm.com (10.85.0.82) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Fri, 24 Apr 2020 15:47:08 -0700
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3578.namprd02.prod.outlook.com
 (2603:10b6:301:77::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Fri, 24 Apr
 2020 22:47:06 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2937.020; Fri, 24 Apr 2020
 22:47:06 +0000
From: Stephen Long <steplong@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Index: AQHWGY47iRLlr/FapUKqLdO4QWI+WaiIze8AgAAQsxA=
Date: Fri, 24 Apr 2020 22:47:06 +0000
Message-ID: <MWHPR0201MB354724516113DC31C0CFCD50C7D00@MWHPR0201MB3547.namprd02.prod.outlook.com>
References: <20200423164236.5181-1-steplong@quicinc.com>
 <c1dc0aa8-783b-c91e-058f-52e3183f9202@linaro.org>
In-Reply-To: <c1dc0aa8-783b-c91e-058f-52e3183f9202@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
x-originating-ip: [108.176.222.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ae9433d-9a46-424b-6dfb-08d7e8a16a26
x-ms-traffictypediagnostic: MWHPR0201MB3578:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR0201MB3578078A27FBEEBD47FE8F14C7D00@MWHPR0201MB3578.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(396003)(376002)(346002)(366004)(39860400002)(8676002)(107886003)(5660300002)(66556008)(86362001)(6506007)(76116006)(66476007)(26005)(478600001)(7696005)(9686003)(53546011)(66946007)(33656002)(66446008)(64756008)(2906002)(52536014)(316002)(4326008)(8936002)(54906003)(81156014)(186003)(55016002)(71200400001)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aEX9/CGqD+AJaaIgpSiQ4uzNImPgOPv3rrc+x2LNzz8AYP6YTiQhIbb4QwBP57Dq0lhbMc6gL613Pr395KmPugAoCp/CNCCuKnkl2WP0T3dKND13doXHZ6eMZ1k9lN5Fq3esDelttpMY6e5venQ/mrmZ9rABSh+nTbtgYRp2Z3nfUw30nYwsWQ1vQe20A1LhFrGDRfiiqmguNq4HrEhiDsIhyX6jBj53ugdN7YUXgKtuiDw9B14lP4rPDoEgEyfSymb/bH9dhDR4zOBwBwR7Ep9BJn5rchePQBij7vLO7pD877cbb7hsqJEHNMjDZMMU3CH6AxkjIdcBEeV8QHBqQ/VtS5Aq38bFADnmQc0ysWvbkfRMG9VJgAm8XvydFM9EJpho2lZfE7MthSUM1w6tRI6U8p4sXUrXOg1780zAVmlnZWEsE7hssqCTur5jcmv+
x-ms-exchange-antispam-messagedata: lrrCwRYuvYlH+jSaPLJ1TLvK2ueP7YwlZbCetVGpFJHxUsEnn6IehATXs3XLwWtAv3p2Ce06aul/PmuCY107buvOlQYN0AkwA4OznWlHw6ydCidIme1XXQOlnM945BjEig5S+g0AAm15/sXNkAeR1ODf6c3z7CAgM5JvaoP1Ak182jc/X6+y3i4vQj8ngCJJKIRgQt7/Pgfs9g00BglC/A293zzW4kibowB1m3q6yz6sTx8E1M33Jm6R38F70H3+zRr0BG0AgPLhHUnQAk4W9Hh1CgaqCgxbkVKV0XeOKqrsaWS403MAimUxRwTbyQrzEylB62ulHPfwyUHxWdVNH1AH9A+raX+dFFBXNvKftGXtBkX1JddCMElHZE2tC2ToaUNH8h7AvgXdvwF0WEM+tNhLrGPysF5WDn6O65vQRrc7JNiAitUHO4eHIYPqQL1OFT2GB+Zf0MmmiEiS8TrvV16dq0tBIvK7bRqx7AtzwJqMKIzSJ+hoX5QyUU8llXZn8FqjYF7KyvRzlxJN2JM/JgXCRWFm8XEVLXhc2S/IOcgYrHkLfYGKND5Fp+KyCr89Ues2iDvVVfMl44VmTFo+ACD5we+jpACiau2TXteM0vEV7WVpFsXUHfYRPrrtRp5kBcf8rqqWpHw04M3IojFnkTee8gCyFCp3tk/1TDafU+FM4q0W60LvDtH4Fif+NdcbHiLUagCkBXthWCJtxMxjVVurbDAkG5hwpbMogIL+CxO1wM7EFspQfTewqNggoARuzWCAXX4Xj+GnUoVgQCbmxSNo/8+Ws3O0aJ6R5WZkrzk=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcTO/lVS1JbyBVYFDsF7kb8AAPcxCI6TB2BOyM43sH2O6twoTDSqkBzgx+l0fHgTL+UQsJZ8kE97Ufcx4ODiLFd9AvWBUD1wSYZDBtUykCkUVnHhNdZuK/WCl+v9WjYluxRFhtDaSWSuty/q53WCRByskVbd4vpW0KGKXc1wKgJlv+mxhbd1oSDlZCuhuVOTdSHqETalNt16D2bQ911GDsPmE3nk455ZnhTki2XHdq9m0M3mkGaRhMkh3yr8bGhi5dKRG3hNaYt1vQcJrqnOJtp916UvilKLGZql+pswLe3bVyYqHcjQOi50DEF89MF1m+V5rH3XQp6wrYMMn1/l5g==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpZrcKkx2Oinjq2CEp7wFR6DuYWjE3Y+AALtgBvLOJo=;
 b=MHMQc0TfjYU8jggPCr33ZblV56nZzu0gJ33pJlDyPMheZXfkqp2hGkrXqsL7Bq0+lAsiiMchMz6QckhX+ucdwPtuagX4VQBU6DW93RH6UbNWFj77ZSlSvDW7znpQzZW7HhqhCCYM0oaVQ6naIhh17o+lGkElrB3SIq91RsB0lNkMMOV5GawfpMgXigYAHlsh53O5a8h30Bhbpbtf2NA0pxaeAGp3LI3teiixcmiVYxys8vzzmtklAE1rNK5MnPlj4Zha0qknn6xbkaz54Gi3psP4PVBgl39t13gPCKkbKlrTGZrRSXcVMrpP6bgczNMs5IWJMNM1hOZYtJMZqJIQwg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpZrcKkx2Oinjq2CEp7wFR6DuYWjE3Y+AALtgBvLOJo=;
 b=QZqNHu5nLRRhF+ynEWzK5/w1032OHGbPsMh9Curf3FP3vJsfccSE/9JVCzlnNBsvtfB49Z1yZfqM3Cle5+0y+CyD2GVP0avRonSUaJc1pebWfBwtangSdeUtOgXCVb83GqY5ABxZ/Yz9rljapkPUm2fMaaa3cUnVrb7ga7H3OxE=
x-ms-exchange-crosstenant-network-message-id: 8ae9433d-9a46-424b-6dfb-08d7e8a16a26
x-ms-exchange-crosstenant-originalarrivaltime: 24 Apr 2020 22:47:06.4116 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: MeojbJLsW7gUnYSRkRfir1jrSSLQ9DBGvq/2sEiQH72RQ2zNapHIw8F9/lrMdqt0Xa7xhiF5jlBHJTv0waUOnA==
x-ms-exchange-transport-crosstenantheadersstamped: MWHPR0201MB3578
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.39; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 18:47:12
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
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
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Ana Pazos <apazos@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T2gsIG1heWJlIEkgbWlzcmVhZCB0aGUgbWFudWFsIGRlc2NyaXB0aW9uIGZvciBTVkUyIFRCTCwg
YnV0IEkgdGhvdWdodCBabSB3YXMgdGhlIGluZGV4ZXMgcmVnaXN0ZXIgYW5kIHRoZSBsb29wIGNv
bXBhcmVzIHRoZSBpbmRleCBmcm9tIFptIHdpdGggdGhlIHRvdGFsIG51bWJlciBvZiBlbGVtcywg
dGFibGVfZWxlbXMuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBSaWNoYXJk
IEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4NClNlbnQ6IEZyaWRheSwg
QXByaWwgMjQsIDIwMjAgMjozNyBQTQ0KVG86IFN0ZXBoZW4gTG9uZyA8c3RlcGxvbmdAcXVpY2lu
Yy5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCkNjOiBxZW11LWFybUBub25nbnUub3JnOyBB
bmEgUGF6b3MgPGFwYXpvc0BxdWljaW5jLmNvbT4NClN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0gg
UkZDXSB0YXJnZXQvYXJtOiBJbXBsZW1lbnQgU1ZFMiBUQkwsIFRCWA0KDQpPbiA0LzIzLzIwIDk6
NDIgQU0sIFN0ZXBoZW4gTG9uZyB3cm90ZToNCj4gU2lnbmVkLW9mZi1ieTogU3RlcGhlbiBMb25n
IDxzdGVwbG9uZ0BxdWljaW5jLmNvbT4NCj4NCj4gVGhlc2UgaW5zbnMgZG9uJ3Qgc2hvdyB1cCB1
bmRlciBhbnkgU1ZFMiBjYXRlZ29yaWVzIGluIHRoZSBtYW51YWwuIEJ1dA0KPiBpZiB5b3UgbG9v
a3VwIGVhY2ggaW5zbiwgeW91J2xsIGZpbmQgdGhleSBoYXZlIFNWRTIgdmFyaWFudHMuDQo+IC0t
LQ0KPiAgdGFyZ2V0L2FybS9oZWxwZXItc3ZlLmggICAgfCAxMCArKysrKysrDQo+ICB0YXJnZXQv
YXJtL3N2ZS5kZWNvZGUgICAgICB8ICA1ICsrKysNCj4gIHRhcmdldC9hcm0vc3ZlX2hlbHBlci5j
ICAgIHwgNTMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIHRhcmdl
dC9hcm0vdHJhbnNsYXRlLXN2ZS5jIHwgMjAgKysrKysrKysrKysrKysNCj4gIDQgZmlsZXMgY2hh
bmdlZCwgODggaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2FybS9oZWxw
ZXItc3ZlLmggYi90YXJnZXQvYXJtL2hlbHBlci1zdmUuaCBpbmRleA0KPiBmNmFlODE0MDIxLi41
NGQyMDU3NWU4IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvYXJtL2hlbHBlci1zdmUuaA0KPiArKysg
Yi90YXJnZXQvYXJtL2hlbHBlci1zdmUuaA0KPiBAQCAtMjY4NywzICsyNjg3LDEzIEBAIERFRl9I
RUxQRVJfRkxBR1NfNShzdmUyX3NxcmRjbWxhaF96enp6X3MsIFRDR19DQUxMX05PX1JXRywNCj4g
ICAgICAgICAgICAgICAgICAgICB2b2lkLCBwdHIsIHB0ciwgcHRyLCBwdHIsIGkzMikNCj4gREVG
X0hFTFBFUl9GTEFHU181KHN2ZTJfc3FyZGNtbGFoX3p6enpfZCwgVENHX0NBTExfTk9fUldHLA0K
PiAgICAgICAgICAgICAgICAgICAgIHZvaWQsIHB0ciwgcHRyLCBwdHIsIHB0ciwgaTMyKQ0KPiAr
DQo+ICtERUZfSEVMUEVSX0ZMQUdTXzUoc3ZlMl90YmxfYiwgVENHX0NBTExfTk9fUldHLCB2b2lk
LCBwdHIsIHB0ciwgcHRyLA0KPiArcHRyLCBpMzIpIERFRl9IRUxQRVJfRkxBR1NfNShzdmUyX3Ri
bF9oLCBUQ0dfQ0FMTF9OT19SV0csIHZvaWQsIHB0ciwNCj4gK3B0ciwgcHRyLCBwdHIsIGkzMikg
REVGX0hFTFBFUl9GTEFHU181KHN2ZTJfdGJsX3MsIFRDR19DQUxMX05PX1JXRywNCj4gK3ZvaWQs
IHB0ciwgcHRyLCBwdHIsIHB0ciwgaTMyKSBERUZfSEVMUEVSX0ZMQUdTXzUoc3ZlMl90YmxfZCwN
Cj4gK1RDR19DQUxMX05PX1JXRywgdm9pZCwgcHRyLCBwdHIsIHB0ciwgcHRyLCBpMzIpDQo+ICsN
Cj4gK0RFRl9IRUxQRVJfRkxBR1NfNChzdmUyX3RieF9iLCBUQ0dfQ0FMTF9OT19SV0csIHZvaWQs
IHB0ciwgcHRyLCBwdHIsDQo+ICtpMzIpIERFRl9IRUxQRVJfRkxBR1NfNChzdmUyX3RieF9oLCBU
Q0dfQ0FMTF9OT19SV0csIHZvaWQsIHB0ciwgcHRyLA0KPiArcHRyLCBpMzIpIERFRl9IRUxQRVJf
RkxBR1NfNChzdmUyX3RieF9zLCBUQ0dfQ0FMTF9OT19SV0csIHZvaWQsIHB0ciwNCj4gK3B0ciwg
cHRyLCBpMzIpIERFRl9IRUxQRVJfRkxBR1NfNChzdmUyX3RieF9kLCBUQ0dfQ0FMTF9OT19SV0cs
IHZvaWQsDQo+ICtwdHIsIHB0ciwgcHRyLCBpMzIpDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvYXJt
L3N2ZS5kZWNvZGUgYi90YXJnZXQvYXJtL3N2ZS5kZWNvZGUgaW5kZXgNCj4gM2EyYTRhN2YxYy4u
NDgzZmJmMGRjYyAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L2FybS9zdmUuZGVjb2RlDQo+ICsrKyBi
L3RhcmdldC9hcm0vc3ZlLmRlY29kZQ0KPiBAQCAtMTM4NywzICsxMzg3LDggQEAgVU1MU0xUX3p6
encgICAgIDAxMDAwMTAwIC4uIDAgLi4uLi4gMDEwIDExMSAuLi4uLiAuLi4uLiAgQHJkYV9ybl9y
bQ0KPg0KPiAgQ01MQV96enp6ICAgICAgIDAxMDAwMTAwIGVzejoyIDAgcm06NSAwMDEwIHJvdDoy
IHJuOjUgcmQ6NSAgcmE9JXJlZ19tb3ZwcmZ4DQo+ICBTUVJEQ01MQUhfenp6eiAgMDEwMDAxMDAg
ZXN6OjIgMCBybTo1IDAwMTEgcm90OjIgcm46NSByZDo1DQo+IHJhPSVyZWdfbW92cHJmeA0KPiAr
DQo+ICsjIyMgU1ZFMiBUYWJsZSBMb29rdXAgKHRocmVlIHNvdXJjZXMpDQo+ICsNCj4gK1RCTF96
enogICAgICAgICAwMDAwMDEwMSAuLiAxIC4uLi4uIDAwMTAxIDAgLi4uLi4gLi4uLi4gIEByZF9y
bl9ybQ0KPiArVEJYX3p6eiAgICAgICAgIDAwMDAwMTAxIC4uIDEgLi4uLi4gMDAxMDEgMSAuLi4u
LiAuLi4uLiAgQHJkX3JuX3JtDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvYXJtL3N2ZV9oZWxwZXIu
YyBiL3RhcmdldC9hcm0vc3ZlX2hlbHBlci5jIGluZGV4DQo+IDU1ZTJjMzJmMDMuLmQxZTkxZGEw
MmEgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9hcm0vc3ZlX2hlbHBlci5jDQo+ICsrKyBiL3Rhcmdl
dC9hcm0vc3ZlX2hlbHBlci5jDQo+IEBAIC0yOTY4LDYgKzI5NjgsNTkgQEAgRE9fVEJMKHN2ZV90
YmxfZCwgdWludDY0X3QsICkNCj4NCj4gICN1bmRlZiBUQkwNCj4NCj4gKyNkZWZpbmUgRE9fU1ZF
Ml9UQkwoTkFNRSwgVFlQRSwgSCkgXA0KPiArdm9pZCBIRUxQRVIoTkFNRSkodm9pZCAqdmQsIHZv
aWQgKnZuMSwgdm9pZCAqdm0sIHZvaWQgKnZuMiwgdWludDMyX3QgZGVzYykgIFwNCj4gK3sgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBcDQo+ICsgICAgaW50cHRyX3QgaSwgb3ByX3N6ID0gc2ltZF9vcHJzeihk
ZXNjKTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiArICAgIHVpbnRwdHJf
dCBlbGVtID0gb3ByX3N6IC8gc2l6ZW9mKFRZUEUpOyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFwNCj4gKyAgICBUWVBFICpkID0gdmQsICpuMSA9IHZuMSwgKm4yID0gdm4yLCAqbSA9
IHZtOyAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ICsgICAgQVJNVmVjdG9yUmVnIHRt
cDEsIHRtcDI7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
XA0KDQpPbmx5IG9uZSB0ZW1wIG5lZWRlZC4NCg0KPiArICAgIGlmICh1bmxpa2VseSh2ZCA9PSB2
bjEpKSB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4g
KyAgICAgICAgbjEgPSBtZW1jcHkoJnRtcDEsIHZuMSwgb3ByX3N6KTsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBcDQo+ICsgICAgfSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiArICAgIGlm
ICh1bmxpa2VseSh2ZCA9PSB2bjIpKSB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFwNCj4gKyAgICAgICAgbjIgPSBtZW1jcHkoJnRtcDIsIHZuMiwgb3ByX3N6
KTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ICsgICAgfQ0KDQpCZXR0
ZXIgd2l0aCBlbHNlIGlmIGhlcmUuDQpCZWNhdXNlIHZkIGNhbm5vdCBvdmVybGFwIGJvdGggdm4x
IG9yIHZuMiwgb25seSBvbmUgb2YgdGhlbS4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFwNCj4gKyAgICBmb3IgKGkgPSAwOyBpIDwgZWxlbTsgaSsrKSB7ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ICsgICAgICAgIFRZ
UEUgaiA9IG1bSChpKV07ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXA0KPiArICAgICAgICBkW0goaSldID0gaiA8IChlbGVtICogMikgPyBuMVtIKGop
XSA6IDA7ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBcDQo+ICsgICAgICAgIFRZUEUgayA9IG1bSChlbGVtICsgaSldOyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiArICAgICAgICBkW0goZWxlbSArIGkpXSA9
IGsgPCAoZWxlbSAqIDIpID8gbjJbSChrKV0gOiAwOyAgICAgICAgICAgICAgICAgICAgIFwNCj4g
KyAgICB9DQoNCkZpcnN0LCB0aGUgaW5kZXhpbmcgaXMgd3JvbmcuDQoNCk5vdGUgdGhhdCB5b3Un
cmUgcmFuZ2UgY2hlY2tpbmcgdnMgZWxlbSAqIDIsIGJ1dCBvbmx5IGluZGV4aW5nIGEgc2luZ2xl
IHZlY3Rvci4NCiBUaHVzIHlvdSBtdXN0IGJlIGluZGV4aW5nIGludG8gdGhlIG5leHQgdmVjdG9y
Lg0KDQpUaGlzIHNob3VsZCBsb29rIG1vcmUgbGlrZQ0KDQogICAgVFlQRSBqID0gbVtIKGkpXTsN
CiAgICBUWVBFIHIgPSAwOw0KDQogICAgaWYgKGogPCBlbGVtKSB7DQogICAgICAgIHIgPSBuMVtI
KGopXTsNCiAgICB9IGVsc2UgaWYgKGogPCAyICogZWxlbSkgew0KICAgICAgICByID0gbjJbSChq
IC0gZWxlbSldOw0KICAgIH0NCiAgICBkW0goaSldID0gcjsNCg0KU2Vjb25kLCB0aGlzIGlzIG9u
ZSBjYXNlIHdoZXJlIEknZCBwcmVmZXIgdG8gc2hhcmUgY29kZSB3aXRoIEFBcmNoNjQuICBJdCB3
b3VsZCBiZSB3b3J0aHdoaWxlIHRvIHJlYXJyYW5nZSBib3RoIHN2ZTEgYW5kIGFkdnNpbWQgdG8g
dXNlIGEgY29tbW9uIHNldCBvZiBoZWxwZXJzLg0KDQo+ICtzdGF0aWMgYm9vbCB0cmFuc19UQkxf
enp6KERpc2FzQ29udGV4dCAqcywgYXJnX3Jycl9lc3ogKmEpDQoNCl96enogaXMgbm90IGhlbHBm
dWwgaGVyZS4gIFRoZSBTVkUxIGluc24gYWxzbyBvcGVyYXRlcyBvbiAzIHJlZ2lzdGVycywgYW5k
IHRodXMgY291bGQgbG9naWNhbGx5IGJlIF96enogdG9vLg0KDQpCZXR0ZXIgbWlnaHQgYmUgX2Rv
dWJsZSwgYWZ0ZXIgZG91YmxlX3RhYmxlID0gVFJVRSwgb3IgbWF5YmUganVzdCBfMiBqdXN0IGlu
IGNhc2UgU1ZFMyBhZGRzIGEgdmFyaWFudCB3aXRoIG1vcmUgdGFibGUgcmVnaXN0ZXJzLg0KDQoN
CnJ+DQo=

