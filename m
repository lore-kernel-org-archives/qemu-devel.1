Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D956CC433E6
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 19:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9660E20757
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 19:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="w6IqZlBr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="SK6+hSeH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9660E20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCTKz-0003hf-Pn
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 15:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCTK8-0002lU-6g
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 15:49:08 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:36789)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCTK6-00071F-2n
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 15:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598816946; x=1630352946;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/GkiPDDQGUbRrpLBku92Y/qAj3zisFoO4cHyh0nyr8E=;
 b=w6IqZlBr7Bi2fMwDDfZSgJ3/IfZksw/vnVfX0Dz83IwPoRNASyWOLhu+
 BJOeruXbnyQ4FHMH44JXdC4AVwy9TCd6w1XGgX0vzC8g6vOZqbpC0Su21
 IVemdCPoIcVPz6l653bMKLDUM9Xams1T6qoKwiYqm1hL5fBMZ9uw84qhK Q=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Aug 2020 12:49:04 -0700
Received: from nasanexm03a.na.qualcomm.com ([10.85.0.103])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 30 Aug 2020 12:49:04 -0700
Received: from nasanexm03d.na.qualcomm.com (10.85.0.91) by
 nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 30 Aug 2020 12:49:04 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Sun, 30 Aug 2020 12:49:03 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4006.namprd02.prod.outlook.com (2603:10b6:a02:f9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Sun, 30 Aug
 2020 19:49:02 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01%7]) with mapi id 15.20.3326.025; Sun, 30 Aug 2020
 19:49:02 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 29/34] Hexagon (target/hexagon) TCG generation
Thread-Topic: [RFC PATCH v3 29/34] Hexagon (target/hexagon) TCG generation
Thread-Index: AQHWdXeYfjaaweMb40u7yKAnghGy6alOZLUAgAK9ZtA=
Date: Sun, 30 Aug 2020 19:49:02 +0000
Message-ID: <BYAPR02MB488671FDF8F7F8C8EDCCC700DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-30-git-send-email-tsimpson@quicinc.com>
 <8c139500-7e22-a99b-fe00-1c7eecb64246@linaro.org>
In-Reply-To: <8c139500-7e22-a99b-fe00-1c7eecb64246@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5da436e6-c690-4f4d-a63a-08d84d1dbf09
x-ms-traffictypediagnostic: BYAPR02MB4006:
x-microsoft-antispam-prvs: <BYAPR02MB4006FBB08473B6373EF67C0CDE500@BYAPR02MB4006.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /2oK5DjhSnHStcEg0rfH3DkabZqeGZvE0kZi8VtUXlqv5oRgeJfqB+nUHcMt9kAgM7DOdXVbWmR+WBCfxtvnyVxfUFLqsg52ualoPwUpFERP4YCO6XDkucTYkNXBKNqNu7uB/LrWBDfXRe/3NB+pbSvN6DP3RjMkeIQ2jOCH5D/4OT6J8OFyJ0d2h0ngeQvkSglWRlEeIvufWn0n6mpR8lPBNx2rScaqvNWsOvYO+mVwAJPAx8HSB6aVAJR4cRjNhDDJW4jQVpYyTz74yw+tdqHmyHKKg+yq4tbY2u1aEZIS2BxALOEGk6aib99aa7XO3KGgSoQRX0WgJtQ7a8uOcA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(346002)(376002)(136003)(39850400004)(366004)(2906002)(4326008)(52536014)(110136005)(55016002)(478600001)(7696005)(6506007)(86362001)(5660300002)(53546011)(8676002)(71200400001)(186003)(66946007)(9686003)(64756008)(66556008)(66476007)(26005)(54906003)(316002)(8936002)(66446008)(76116006)(33656002)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: qdRIILdltbcAzRGl/fK5g4YUqxfFf7JGSINadujxqVENHDodwhe30A3Im7khDCErvOs3DMDotUO/lDkNMYGzgu9NCTYNgzkOq1rLtj89RkfvP+SqNwS4h1Phi8nc6yy5gwlz+fp6Wf1b5ONWnxExJYvdQ/Spm1AW17u7TO2SppKC9JJqTXS5Nv2ObnQ/4Z/uFZfOvN5BZ+GjA8X9VN5fF7DhT6b2M5GTReDrJ21Pzi/vnFeUSYkwTUj34vrkPfpJwkPTKgn2J5BA5HV03eJehUBKyWdhXU20oYikxB/hHWkpIWIQIJgIETH9nAhESxw2glSm/X1nreuvaFdGs4x/GZHOkAsHMfdnuaTft09xbid4Dpujj+aGW8XSfqI8iLekLZWe6SirSzNpiMcTv3RV9Dk8gl1VdFkHuAhp+6g8l9+m5poEXl0cryqX3/nBywCBDeiK+6Mwf9C5dgqcA74MKcXlt+a90lcNf0DHKJtXpCyDCr6DBOF78tIjZxbjkjRKRNEXif1i1oRir20riwiF+UrAerbg1Ijw2bZ1LNttRjUItCSk4A+AZMKpjAWK4Oy1IyXcRRAITpaGYxCi6WDVpUr3r8MuqlH/LSnQ0xzwFKoX4kcoEHjlQ1FBycO/AYJhVq72IdKsXLZt/QJjEoJBLw==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhlHZ9Edhw1HyOW5H91W9Sq4w1I7ExMy7dEcUCeujvW7CHEUZRzAFTo5lWDuz3hsbrgwOMF2PmjOjkyBc+A/QsRpVv+HVcPw9F5TtA3TzWoc8dTnoyW3KhRNdhgAUflgstYfNrefIhtrYFjz/EoqB4LWU7z0d/wzjUeus6uZNVO0bFrMu38UozYuxkpmWcj/1wEqsPSJDjbjmjjnIuYA7K6FM0611e3yZ7N1uQax+ySl9+OHgnykFC+P2P9123ipaVolHodgDGGEV2yszyL5RB2nljUNoUjmXK+UYNwvXGTRCCNCCV+DSbdFxh//3My2FVYV9+mnm8omQN/l7lmYpg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUAheUIVQsQ8HejtDF35Mmnic+q/VLwtO7So5Rtg5h0=;
 b=RlP8pKU3V0c240pu9cy1NSOYQSgUHytDhDLxtSHtthu9Eqy1906+5QvHoKba+W6ugDCcfQqMNCvEe+j9I1baJnudDeV0uLWnzdhjRCLsELMuxrXljFJkWhntdKzAM5IGb+CJCKH1tkPW73TcUyDNclBYugAns7v4W1+HI7yOxaZCcZ17cBvBi57EDL2kjSwsmHiMxFpjrnmsqOAt/0YDv7xA1AwoZlhg58EJzd7ZUMShJOAMTzJMIsAfyfi+HL8JGvxzPbeyTiSqQQfxQp+maU4N/2fZ+4/sxRjY73REg1RNPa50nJNCzHNShqbIjB3vnV4eMt42GpsbHQLodSAA4g==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUAheUIVQsQ8HejtDF35Mmnic+q/VLwtO7So5Rtg5h0=;
 b=SK6+hSeHmUmB9D+9PksrkzZ5ljV4O+sk6jR+9Bmj8qo06Jf5mpitd03IWW2HUlrJ5g6zEovmF7AQoaiN9SrN+idVYDGYtgGcn40YGPajrBGjWpt6yrOKhIEbh60qg7z/UZUm5gegFHmkTHXopQE8KG4nELyvTWj64h/JosizAuI=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 5da436e6-c690-4f4d-a63a-08d84d1dbf09
x-ms-exchange-crosstenant-originalarrivaltime: 30 Aug 2020 19:49:02.6186 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: o33keWFbBTSd0pFQDrRbIcAQuLFQr/VnWKQBIORl/X1gBuF4bnWyZOONKMuOL16UokN4PUQIEMfLto/PIL5CAg==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4006
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.38; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/30 15:37:55
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
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0
IDI4LCAyMDIwIDc6NTggUE0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5j
LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGhpbG1kQHJlZGhhdC5jb207IGxh
dXJlbnRAdml2aWVyLmV1OyByaWt1LnZvaXBpb0Bpa2kuZmk7DQo+IGFsZWtzYW5kYXIubS5tYWls
QGdtYWlsLmNvbTsgYWxlQHJldi5uZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAyOS8z
NF0gSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIFRDRw0KPiBnZW5lcmF0aW9uDQo+DQo+IE9uIDgv
MTgvMjAgODo1MCBBTSwgVGF5bG9yIFNpbXBzb24gd3JvdGU6DQo+ID4gKy8qIEZpbGwgaW4gdGhl
IHRhYmxlIHdpdGggTlVMTHMgYmVjYXVzZSBub3QgYWxsIHRoZSBvcGNvZGVzIGhhdmUNCj4gREVG
X1FFTVUgKi8NCj4gPiArc2VtYW50aWNfaW5zbl90IG9wY29kZV9nZW5wdHJbXSA9IHsNCj4gPiAr
I2RlZmluZSBPUENPREUoWCkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOVUxMDQo+ID4g
KyNpbmNsdWRlICJvcGNvZGVzX2RlZl9nZW5lcmF0ZWQuaCINCj4gPiArICAgIE5VTEwNCj4gPiAr
I3VuZGVmIE9QQ09ERQ0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArLyogVGhpcyBmdW5jdGlvbiBvdmVy
d3JpdGVzIHRoZSBOVUxMIGVudHJpZXMgd2hlcmUgd2UgaGF2ZSBhIERFRl9RRU1VDQo+ICovDQo+
ID4gK3ZvaWQgaW5pdF9nZW5wdHIodm9pZCkNCj4gPiArew0KPiA+ICsjZGVmaW5lIERFRl9UQ0df
RlVOQyhUQUcsIEdFTkZOKSBcDQo+ID4gKyAgICBvcGNvZGVfZ2VucHRyW1RBR10gPSBnZW5lcmF0
ZV8jI1RBRzsNCj4gPiArI2luY2x1ZGUgInRjZ19mdW5jc19nZW5lcmF0ZWQuaCINCj4gPiArI3Vu
ZGVmIERFRl9UQ0dfRlVOQw0KPiA+ICt9DQo+DQo+IEp1c3Qgc2l6ZSB0aGUgYXJyYXkgcHJvcGVy
bHkgdG8gc3RhcnQuDQo+DQo+IGNvbnN0IHNlbWFudGljX2luc25fdCBvcGNvZGVfZ2VucHRyW1hY
X0xBU1RfT1BDT0RFXSA9IHsNCj4NCj4gI2RlZmluZSBERUZfVENHX0ZVTkMoVEFHLCBHRU5GTikg
XA0KPiAgICAgW1RBR10gPSBnZW5lcmF0ZV8jI1RBRywNCj4gI2luY2x1ZGUgInRjZ19mdW5jc19n
ZW5lcmF0ZWQuaCINCj4NCj4gfTsNCg0KT0sNCg==

