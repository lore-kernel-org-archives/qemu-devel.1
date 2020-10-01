Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203F3C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:43:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96648206C1
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I7OYsH1Z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="bA/b42Yb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96648206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0k3-00052t-P3
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kO0gr-0001Nq-VK
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:40:18 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:32245)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kO0go-0003eV-0w
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1601566813; x=1633102813;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kea+896fw/jbqkKD4PUcovyrTg152XEYYqM0VHn+wz0=;
 b=I7OYsH1ZD4eIrKomax+fhYtQ/mdYvmvMWpYkSjZiVvnLV937ilGyTF23
 zGxQs+DJNbn6jEahEEngE9LS/BuRN1kVykZfcw5IGkc8M2ptMJNDfFJzg
 aRwZO85AqUUTB20G5SvG9Akk60n2ydw3WQFOc4J9QeKgmbA0IKB/PWajS c=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Oct 2020 08:40:12 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 01 Oct 2020 08:40:11 -0700
Received: from nasanexm03a.na.qualcomm.com (10.85.0.103) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 1 Oct 2020 08:40:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 1 Oct 2020 08:40:11 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BY5PR02MB6787.namprd02.prod.outlook.com (2603:10b6:a03:201::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36; Thu, 1 Oct
 2020 15:40:10 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c%6]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 15:40:10 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v4 27/29] Hexagon (linux-user/hexagon) Linux user
 emulation
Thread-Topic: [RFC PATCH v4 27/29] Hexagon (linux-user/hexagon) Linux user
 emulation
Thread-Index: AQHWlb0HzVWcjEM2c02U1Hzjcbp8lKl+igOAgAMem5CAALuxgIAAgN1w
Date: Thu, 1 Oct 2020 15:40:10 +0000
Message-ID: <BYAPR02MB48863E6D16D6C5ED0ACB847EDE300@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1601314138-9930-1-git-send-email-tsimpson@quicinc.com>
 <1601314138-9930-28-git-send-email-tsimpson@quicinc.com>
 <97b7864c-f4b2-ae8a-9ad0-d1d3c1fb309c@vivier.eu>
 <BYAPR02MB488639031FDA8E05DA560CD5DE330@BYAPR02MB4886.namprd02.prod.outlook.com>
 <a7035857-28d6-4960-234f-27246aabbbb3@vivier.eu>
In-Reply-To: <a7035857-28d6-4960-234f-27246aabbbb3@vivier.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vivier.eu; dkim=none (message not signed)
 header.d=none;vivier.eu; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 925733af-f9cd-4bb9-06bb-08d8662047e8
x-ms-traffictypediagnostic: BY5PR02MB6787:
x-microsoft-antispam-prvs: <BY5PR02MB67875955609D53FE3DA70A18DE300@BY5PR02MB6787.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IXMZV2oqctUaz4szUO9cevydkyQejYhetuWo1CsIrDx/Ni7jUAKkWS2Gbad5tMKHn12xmWdx76bkiDeESojEo8d5t4zHvb5dhwthDbnIi8ispuMw3QVq7XqmljnObSEeqdlrOahsIoGwfeswgwXSzGyLQ2p2gGKkora1woJk7ACTmNe0MP2oi1g0Xndd3sLa76T7TAXdFXZHvaJwhZzg2QsZdV166lguZ1wjneC0IruUGgvVXySd+6+HAJ/ylMfg7piClIUcpAoyyQIhQh90hl+eCmkYw2psdALpDJt9adCccrIhtWuF0QKWo0aayG8/8K2zvzCkU9JF9EiKYhpBSw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(136003)(396003)(376002)(39860400002)(346002)(8936002)(4326008)(55016002)(2906002)(8676002)(86362001)(478600001)(33656002)(66446008)(76116006)(110136005)(54906003)(316002)(66946007)(26005)(5660300002)(53546011)(52536014)(9686003)(66556008)(6506007)(186003)(83380400001)(64756008)(66574015)(71200400001)(66476007)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Ir/1oHmkGx6ACeDX6q3oezMwAKDgm2hpd//0b/EW/eLmJa3XoLtwiAtuVZtMz0Y7xif4AbP9MLexj3dyIWiHuqVucHqQ4mKxaoNETk/pOLOomAgQ3Gh7dDFfGRFlpBVzDUTb9dNkHeUx9EXiBdBIIpdr81YiJ0p1rRGPj5zGsc/WGO3/ghrw/JAwQZZhctjdcSuzCvq+BDUCk6+YPO7GpOStAAz97MMGiYfO52/vDAN9aJER0X6O7iBZsU59lDjSEJBBJZTXTFQCN/xKsLPjC0hujA2cU3WLraFU+uB62fO9Nj3vSWkav6F7w7QCla6CtN2YTXJ0HdzM6D+4WgA6FpKd7752Wky295HuBQ5MOUd5/vM3kVPvIi1DWvU5Vr9ORmbflDBTW26U2G2WsSGwPgj5UwXavi3PuhvLGwIXQidObAlHieR9Pg1/jgm0VcKeZBpT3OE/1iHaq74OQO38d/mEDeveANWHprafBNkpvG/+I/ckiC6ar+7gCHNudFb6VZN0krSpSeDNgH0I7zCkC2D4Fs7oRMnsx2xCiGpwxiQ8cg/CRFS01jSFv+etBZPZ0I8nBlzzJl9okhiSwyHjew8vo/5JkqA6etM8wV2dUdAvOkMmOUomcBZFHwXuAOXggbPSNomB2DGZdxQR9IBiOg==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0cuuYncn8I2mn57P7ZU5mnSDcZFX/KA33BxCBnD78Zxlh5F1/msnBN1uDoVF7mW+pVP5hH6HM8HpNX+G+efYsoZ595T4ZmhV+E2v45AkyBYAAmPVHt5U7jK0qwWbmuC7BASxQCXlDpMzfr7URS+gfoybbAdV9e039dqvmIAYSmfrksw7tRa5xUK+UaWZ7JJRz9Vnumv1F0x1qzBk3WROzf4fXTW+XpOVX2D8ILx6z2Zs3J12uKPi5OyRzkd5uSJ1QtGZCp81P9QXw6P/M2VXZnnIM99oETDdhti0oyZzwENVejg5C9FHEQIzW2uyOgZminaTAjuMK7Jy7axsNXoQw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X282IF4ROdkAMajPyZpRji/xyWDBQt3TusSCbhN9NVw=;
 b=BGPuqSlPXhwXkCMDjaylPE7M+mw0mrSzY+pH6fF68ckhb1wBD+1YaZpz83pmaDbdphPIRBiP2XOJHMlkR9QB37PLh18HXeTcsNWHl2kKkFircyOokvKcisfF474zRhYaKBkc4HZ5tWtLjfd174Oid6DH+d+LQ1B7taYTKZ7Jv0ML6rkqO6iEMkr8VMFcBrxUs5ldC+QjD9A6oVLUWI2NoWbGL4TE4dsfUeJQ6tYEjkQCBqJDjsbOVd0me5kyXXrfh7HglK27Sl3P4jaEYmmqv1da8SruSDVBeumkWxVsMxNv7Yx4OJx0gP5XELWK5mSMEQgcu9XByChMEYnCT/3KSQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X282IF4ROdkAMajPyZpRji/xyWDBQt3TusSCbhN9NVw=;
 b=bA/b42Ybjbl81tPkMHGLtNAd5ueRAe4rLX/6KUVOx076zTExVT17BOn4odPT4pykb6ShPyXyLahGoN+d2Q89RPWZX8Rdy7oYwVuDq3RXaFAn4tv57vAU8dr0KlH/d7dKdftIVyJ0U8FUX22tiHklnSeXy0JJMPDNaMbSwCea4/4=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 925733af-f9cd-4bb9-06bb-08d8662047e8
x-ms-exchange-crosstenant-originalarrivaltime: 01 Oct 2020 15:40:10.3320 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: IG/hOXzcviECZizRu0DL0+vBNQm5cZMX2NxnIM90VHDb4VYlGF5vgbp2RIJUeb4DAOKtnLnAdbPDshuqB8HizQ==
x-ms-exchange-transport-crosstenantheadersstamped: BY5PR02MB6787
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.39; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 11:40:12
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
Cc: "ale@rev.ng" <ale@rev.ng>, "philmd@redhat.com" <philmd@redhat.com>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGF1cmVudCBWaXZpZXIg
PGxhdXJlbnRAdml2aWVyLmV1Pg0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAxLCAyMDIwIDE6
NTMgQU0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT47IHFlbXUt
ZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZzsgcGhp
bG1kQHJlZGhhdC5jb207IHJpa3Uudm9pcGlvQGlraS5maTsNCj4gYWxla3NhbmRhci5tLm1haWxA
Z21haWwuY29tOyBhbGVAcmV2Lm5nDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHY0IDI3LzI5
XSBIZXhhZ29uIChsaW51eC11c2VyL2hleGFnb24pIExpbnV4IHVzZXINCj4gZW11bGF0aW9uDQo+
DQo+IExlIDMwLzA5LzIwMjAgw6AgMjI6NDcsIFRheWxvciBTaW1wc29uIGEgw6ljcml0IDoNCj4g
Pg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IExhdXJl
bnQgVml2aWVyIDxsYXVyZW50QHZpdmllci5ldT4NCj4gPj4gU2VudDogTW9uZGF5LCBTZXB0ZW1i
ZXIgMjgsIDIwMjAgMzowMyBQTQ0KPiA+PiBUbzogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1
aWNpbmMuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+ID4+IENjOiByaWNoYXJkLmhlbmRl
cnNvbkBsaW5hcm8ub3JnOyBwaGlsbWRAcmVkaGF0LmNvbTsgcmlrdS52b2lwaW9AaWtpLmZpOw0K
PiA+PiBhbGVrc2FuZGFyLm0ubWFpbEBnbWFpbC5jb207IGFsZUByZXYubmcNCj4gPj4gU3ViamVj
dDogUmU6IFtSRkMgUEFUQ0ggdjQgMjcvMjldIEhleGFnb24gKGxpbnV4LXVzZXIvaGV4YWdvbikg
TGludXgNCj4gdXNlcg0KPiA+PiBlbXVsYXRpb24NCj4gPj4NCj4gPj4+ICsNCj4gPj4+ICtzeXNj
YWxsX25yX2dlbmVyYXRvcnMgKz0gew0KPiA+Pj4gKyAgJ2hleGFnb24nOiBnZW5lcmF0b3Ioc2gs
DQo+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICBhcmd1bWVudHM6IFsgJ2NhdCcsICdzeXNj
YWxsX25yLmgnLCAnPicsICdAT1VUUFVUQCcgXSwNCj4gPj4+ICsgICAgICAgICAgICAgICAgICAg
ICBvdXRwdXQ6ICdAQkFTRU5BTUVAX25yLmgnKQ0KPiA+Pg0KPiA+PiBXaHkgZG8gd2UgbmVlZCB0
aGF0Pw0KPiA+PiBUaGUgc3lzY2FsbF9ucl9nZW5lcmF0b3JzIGlzIHVzZWQgdG8gZ2VuZXJhdGUg
c3lzY2FsbF9uci5oIGZyb20gc3lzY2FsbC50YmwNCj4gPg0KPiA+IFRoZSBvdGhlciBsaW51eC11
c2VyIHRhcmdldHMgaGF2ZSB0aGlzIGluIHRoZWlyIG1lc29uLmJ1aWxkIGZpbGVzLiAgSSdsbCBy
ZW1vdmUNCj4gaWYgaXQncyBub3QgbmVlZGVkLg0KPg0KPiBOb3QgYWxsIHRoZSB0YXJnZXRzIChv
bmx5IHRoZSBvbmVzIHdpdGggc3lzY2FsbC50YmwpIGFuZCB0aGV5IGNhbGwNCj4gc3lzY2FsbGhk
ci5zaCBhbmQgbm90IGNhdC4gU28geW91IGNhbiByZW1vdmUgaXQuDQo+DQo+ID4+DQo+ID4+PiAr
fQ0KPiA+Pj4gZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIvbWVzb24uYnVpbGQgYi9saW51eC11c2Vy
L21lc29uLmJ1aWxkDQo+ID4+PiBpbmRleCAyYjk0ZTRiLi44YjFkZmM4IDEwMDY0NA0KPiA+Pj4g
LS0tIGEvbGludXgtdXNlci9tZXNvbi5idWlsZA0KPiA+Pj4gKysrIGIvbGludXgtdXNlci9tZXNv
bi5idWlsZA0KPiA+Pj4gQEAgLTIyLDYgKzIyLDcgQEAgc3lzY2FsbF9ucl9nZW5lcmF0b3JzID0g
e30NCj4gPj4+DQo+ID4+PiAgc3ViZGlyKCdhbHBoYScpDQo+ID4+PiAgc3ViZGlyKCdhcm0nKQ0K
PiA+Pj4gK3N1YmRpcignaGV4YWdvbicpDQo+ID4+DQo+ID4+IHNvIHlvdSBkb24ndCBuZWVkIHRo
YXQgZWl0aGVyDQo+ID4NCj4gPiBPSw0KPiA+DQo+ID4+PiAtICAgIGdyZXAgLWUgIiNkZWZpbmUg
X19OUl8iIC1lICIjZGVmaW5lIF9fTlIzMjY0Ig0KPiA+Pj4gKyAgICBncmVwIC1lICIjZGVmaW5l
IF9fTlJfIiAtZSAiI2RlZmluZSBfX05SMzI2NCIgfCBncmVwIC12DQo+ID4+IF9fTlJfc3lzY2Fs
bHMNCj4gPj4NCj4gPj4gV2h5IGRvIHlvdSByZW1vdmUgX19OUl9zeXNjYWxscz8NCj4gPg0KPiA+
IE9sZGVyIGtlcm5lbHMgaGF2ZSBhIGJ1bmNoIG9mDQo+ID4gI3VuZGVmIF9fTlJfc3lzY2FsbHMN
Cj4gPiAjZGVmaW5lIF9fTlJfc3lzY2FsbHMgIFgNCj4gPg0KPiA+IFRoZSBzY3JpcHQgcmVtb3Zl
cyBhbGwgI3VuZGVmJ3MgYnV0IGxlYXZlcyB0aGUgI2RlZmluZSdzLCBzbyB3ZSBnZXQgY29tcGls
ZQ0KPiBlcnJvcnMuICBUaGF0IHN5bWJvbCBpc24ndCB1c2VkIGJ5IHFlbXUgc28gaXQncyBzYWZl
IHRvIHJlbW92ZS4NCj4gPg0KPg0KPiBBcyB0aGUgc3lzY2FsbF9uci5oIGdlbmVyYXRlZCBmcm9t
IHN5c2NhbGwudGJsIGRvbid0IGhhdmUgdGhpcyBzeW1ib2wsIEkNCj4gdGhpbmsgd2UgY2FuIHJl
bW92ZSBpdC4gQnV0IEknbSB2ZXJ5IHN1cnByaXNlZCBpdCBkb2Vzbid0IHdvcmsgd2l0aCBpdA0K
PiBmb3IgeW91Lg0KPg0KPiBDb3VsZCB5b3UgcHV0IHRoaXMgb25lLWxpbmUgY2hhbmdlIGluIGEg
c2VwYXJhdGUgcGF0Y2g/DQo+DQo+IFRoZSBiZXN0IHdvdWxkIGJlIHRvIHJlLXJ1biBpdCBvbmNl
IHRoZSBjaGFuZ2UgaXMgbWFkZSB0byB1cGRhdGUgYWxsIHRoZQ0KPiBnZW5lcmF0ZWQgc3lzY2Fs
bF9uci5oIHdpdGhvdXQgdGhlIF9fTlJfc3lzY2FsbHMgbGluZS4NCj4NCj4gTW9yZW92ZXIgdGhl
IHN5c2NhbGxfbnIuaCBJIGdlbmVyYXRlIGZyb20gbGludXgtNS45IGZvciBoZXhhZ29uIGlzDQo+
IGRpZmZlcmVudCBmcm9tIHRoZSBvbmUgeW91IHB1dCBpbiB0aGlzIHNlcmllcyAodGhlIDEwMjQg
LT4gMTA3OSBwYXJ0IGlzDQo+IG1pc3NpbmcpLg0KDQpUaGUgc3lzY2FsbF9uci5oIEkgc3VibWl0
dGVkIGlzIGZyb20gNC45LCBhbmQgd2UgYXJlIGluIHRoZSBwcm9jZXNzIG9mIHVwZ3JhZGluZyB0
aGUgdG9vbGNoYWluL2tlcm5lbC9ldGMuDQoNCldoaWNoIHZlcnNpb25zIG9mIHRoZSBrZXJuZWwg
ZG9lcyBxZW11IGV4cGVjdCB0byBzdXBwb3J0PyAgSSdsbCBpbnZlc3RpZ2F0ZSB3aGV0aGVyIHRo
b3NlIHZlcnNpb25zIGhhdmUgbXVsdGlwbGUgX19OUl9zeXNjYWxscy4gIElmIG5vdCwgdGhlcmUn
cyBubyBuZWVkIGZvciB0aGF0IGNoYW5nZS4NCg0KVGF5bG9yDQoNCg==

