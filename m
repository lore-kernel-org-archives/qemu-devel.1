Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2210DC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:15:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0247206CD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FSYFh1P9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="BQqy6XkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0247206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCoL8-0001TJ-QO
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 14:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCoK9-00012r-2v
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:14:33 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:10494)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCoK6-0004QC-DW
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598897670; x=1630433670;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Vkv7JwcS4V8xb4yYCH/DRYx13zd9K82MYcX2qyrM6nY=;
 b=FSYFh1P9e96O9I0WGi6na6jo6pcoG4WIPT/HAw3W+JSMI1Q87fGtR0tr
 9nX/3OGQOYz5gqMS898JRjfpt3au/DDVOAtIfrksM9Wc27JFxUSDwrskN
 ZlmS02EiCF03phMuwAEAvc7PUC4NCG4tmLIEOfXfFLuHvEZZM1OItcnTa c=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 31 Aug 2020 11:14:28 -0700
Received: from nasanexm03g.na.qualcomm.com ([10.85.0.49])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 31 Aug 2020 11:14:28 -0700
Received: from APSANEXR01A.ap.qualcomm.com (10.85.0.36) by
 nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 31 Aug 2020 11:14:28 -0700
Received: from nasanexm03b.na.qualcomm.com (10.85.0.98) by
 APSANEXR01A.ap.qualcomm.com (10.85.0.36) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 31 Aug 2020 11:14:06 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03b.na.qualcomm.com (10.85.0.98) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 31 Aug 2020 11:14:06 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4552.namprd02.prod.outlook.com (2603:10b6:a03:58::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.22; Mon, 31 Aug
 2020 18:14:05 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01%7]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 18:14:05 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 30/34] Hexagon (target/hexagon) TCG for
 instructions with multiple definitions
Thread-Topic: [RFC PATCH v3 30/34] Hexagon (target/hexagon) TCG for
 instructions with multiple definitions
Thread-Index: AQHWdXdjR65U8vNpmEiviytk7eiWcalOZgsAgAK5LuCAABqagIAAAiTQgAAjBACAASHoAIAADK2AgAAIhJA=
Date: Mon, 31 Aug 2020 18:14:05 +0000
Message-ID: <BYAPR02MB4886F055CBD52DBEE5F269AEDE510@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-31-git-send-email-tsimpson@quicinc.com>
 <10127f7e-a2df-2f19-e897-9a874f9a5d82@linaro.org>
 <BYAPR02MB488691F539AD3A2BFA1C819DDE500@BYAPR02MB4886.namprd02.prod.outlook.com>
 <a0987bce-409b-cd14-7559-c63413ff2b6f@linaro.org>
 <BYAPR02MB4886985CC5CBF78F7D5DBFE5DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
 <fca34122-160d-8c13-d237-a87a917f341b@linaro.org>
 <BYAPR02MB4886D48EDC604CEEF65FDAA7DE510@BYAPR02MB4886.namprd02.prod.outlook.com>
 <1cf57f2b-a2c8-6fbc-2c1c-9945a5d77dd8@linaro.org>
In-Reply-To: <1cf57f2b-a2c8-6fbc-2c1c-9945a5d77dd8@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e2ca564-a324-4a80-3b55-08d84dd9a5a5
x-ms-traffictypediagnostic: BYAPR02MB4552:
x-microsoft-antispam-prvs: <BYAPR02MB4552CCC31C724F21F095B37ADE510@BYAPR02MB4552.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bjYsDciVQ6he+V+rHLjHeh2bbVpRk/tz38NpfqfaPd8oMeml4RTR/p/UCjmxbcW41LGbuRfK5JPaLKW+lLWz1vHKVJ5INEOAVkodxPp0Gpp214NSw1oWMHhAEDKUQvyr1slQQtJrjpW6NNGnwtyTujZ0F9Oj5HsVXzO3hbQmaThZynnta/+O8zT52Ch0wL7a39pvtFW3SQNc1U6th2GFPwSKsQVf4NyxflvvokvLhyOmFfGX1KXVaq8/Ycp2hfb0S7LnwzNip7hHG9FNMy0MXPMEw/KqdOuIodYn3UMCcNjTj1KF9kIssN3h7Yx/AtfDBTT+Nirue9fTq/c88s27Qw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(39860400002)(346002)(136003)(376002)(366004)(110136005)(86362001)(316002)(8676002)(55016002)(64756008)(76116006)(54906003)(8936002)(2906002)(9686003)(83380400001)(478600001)(33656002)(52536014)(4326008)(71200400001)(6506007)(53546011)(186003)(5660300002)(66946007)(66446008)(66556008)(26005)(7696005)(66476007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 5ESa4s+/WjvRuQvNKBpO9WQRmeb5AC3cR3MTF2gsPlM7Cb9tBV8pkhe0RhCcRonT6tcJiJTflimm3zAVLQWXkIrkDwZ55NIUbLeZAYy5RKGqNRgSxKmdPlkUzPNc4d0+yx81NQCfN9IsWGaFG1b574QzZ5E1xRja8GA6Fw3GJpSWgiOvFfRW0xN1OLMqecA/RHzrs+LOEXR7TmZG74vaR86yOkDiCXbT5nzB/wnp0pRBciOziKU5zGd68qUBekcbfXGudqMuDgK8aOHmVZrKdy0Eu++anng/bmtsxtVNqkM/lE2EM6SN2I2Lqy/a9udAgPSQdsu4zlBmvfUq94uHyW9F6DN+1keQaMFd1G4z7Gv2Pv1MXcJoJul4kfm1xJmcFHaeXkTmU05jRPDOIE/0gwsXWXRsGl74Pa4ZMtbveVPxYfxOahyAxyDDYol7w5hlZDGPN3ZV7XijEtB4pPgnyIpdJZJAcWLXZ1g75tRjKXRiK40LAEvYK+H9eKQtSlM7bTQ+1OcWuog+gg67SDYzAHZa+3k1TBqRuL+r6Kr/FQWL4XYD7fA05CFZeSFuVuPTMgeVVCsDeEROTf1wvnAPsekKIZXdDcCAbZDBee8t4GMTRCQi5bCVeLdTQ9/EWYX3fyrrLLBOmPWVl0knDcCnhQ==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EU2NuGVu6YqnS5ny9Xwk2tjjgf059YkgdCgOr9baHV7ZdFT9NrTYfUwFQMFvW1RnWv48ZkQQjBW1GGGD9FAVudJjKUE8xkW1bfZzj4R0s7RGkKEzB9WqlkMiaUYELMy3jyzA+9Vudoe+qhRgmt9TzazgmQa81X8dhM6VkPf4be+eiS30aL3m7bb0Mdji3asI4Y06P923+cpFEH14yzhNrzf3YYeoTzoOAyeRuZ+QZCjTe/rKrBn1Et+um+4mplj8lXcuIWuaEawKuohBEQ8IDrFae6Q+UbmjJUtONWwpmrktBtJNja5ikQRzmcIRz8hYDmkY7jMDQijdrOsMEJ7rnA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbJ+/ybTPso1dVGAAZmUoiK2QPdOjP9wr2uvfzwx0Qs=;
 b=k66u9u8McIKjbivqzj+UmSagv+56+HIXFVlzdta/BxeMk2rYaQM6+QnP9kk1puj35JxvYh+LsEHY/SDu0a3TL5HdgiHOTplTT5w7SLdcVbzBOrOQRmmz3h/d3Z9WMsoIqzw8//ZC9q4H8MDJ8IbqEhQxkgOADje6Hh98cLIeN3q9sWdXOv1pDQvQSykVmMN/3j8+yd14JjBXn3sDgcumsT53bdelnFFocYp9Jxa5xwBVcia62Tvyu291T7MX8jCJu6r5MKiSl5DHEwxVHNTgrF6WuJ37VnkZhefmBpRxBv1hGW9EDcaBZZdwOqsVR5LbJGOqzeWnTFQzBZj7gvxNCA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbJ+/ybTPso1dVGAAZmUoiK2QPdOjP9wr2uvfzwx0Qs=;
 b=BQqy6XkLVNaofrOQtoH61ciWnGfuA6AsinKIyUEtcpOkKe6mJt9KVnBIqPOTNLUcJpjkBnFoDMlNQ8BY8WXo04UkiWjg4IwNcN/8SN1wXBDMGgROUz7ICqECTPfy+O85SkmzAt+NXSrPyWkr1B76hLvUMz5mlRin5/8tQRlj0Ko=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 4e2ca564-a324-4a80-3b55-08d84dd9a5a5
x-ms-exchange-crosstenant-originalarrivaltime: 31 Aug 2020 18:14:05.2847 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: RJtJvydTaVDKqJ6ZVjGGBS7nrc0EKuzmyrcj/k0wa972i5+96omS7iLJpSKGSx5UtPvQL//mOqYApzWCBAl9vQ==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4552
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.38; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 13:08:37
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
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgQXVndXN0
IDMxLCAyMDIwIDExOjI5IEFNDQo+IFRvOiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2lu
Yy5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBoaWxtZEByZWRoYXQuY29tOyBs
YXVyZW50QHZpdmllci5ldTsgcmlrdS52b2lwaW9AaWtpLmZpOw0KPiBhbGVrc2FuZGFyLm0ubWFp
bEBnbWFpbC5jb207IGFsZUByZXYubmcNCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjMgMzAv
MzRdIEhleGFnb24gKHRhcmdldC9oZXhhZ29uKSBUQ0cgZm9yDQo+IGluc3RydWN0aW9ucyB3aXRo
IG11bHRpcGxlIGRlZmluaXRpb25zDQo+DQo+IE9uIDgvMzEvMjAgMTA6MDggQU0sIFRheWxvciBT
aW1wc29uIHdyb3RlOg0KPiA+IFRoZXJlIGFyZSBzb21lIGFzc3VtcHRpb25zIGhlcmUgSSdkIGxp
a2UgdG8gY2xhcmlmeS4gIFdoZW4gSSBzdGFydGVkIHRoaXMNCj4gPiBkaXNjdXNzaW9uLCB0aGVy
ZSBzZWVtZWQgdG8gYmUgZ2VuZXJhbCByZXNpc3RhbmNlIHRvIHRoZSBjb25jZXB0IG9mIGENCj4g
PiBnZW5lcmF0b3IuICBCZWNhdXNlIG9mIHRoaXMsIEkgbWFkZSB0aGUgZ2VuZXJhdG9yIGFzIHNp
bXBsZSBhcyBwb3NzaWJsZSBhbmQNCj4gPiBwdXNoZWQgdGhlIGNvbXBsZXhpdHkgYW5kIG9wdGlt
aXphdGlvbiBpbnRvIGNvZGUgdGhhdCBjb25zdW1lcyB0aGUNCj4gb3V0cHV0IG9mDQo+ID4gdGhl
IGdlbmVyYXRvci4gIEFsc28sIEkgYXNzdW1lZCBwZW9wbGUgd291bGRuJ3QgcmVhZCB0aGUgb3V0
cHV0IG9mIHRoZQ0KPiA+IGdlbmVyYXRvciwgc28gSSBkaWRuJ3QgZm9jdXMgb24gbWFraW5nIGl0
IHJlYWRhYmxlLg0KPg0KPiBFeGNlcHQsIGF0IHNvbWUgcG9pbnQsIG9uZSBoYXMgdG8gZGVidWcg
dGhpcyBjb2RlLg0KPiBJZiB0aGUgY29kZSBpcyB1bnJlYWRhYmxlLCBob3cgZG8geW91IGZpZ3Vy
ZSBvdXQgd2hhdCdzIGJyb2tlbj8NCj4NCj4gPiBOb3csIGl0IHNvdW5kcyBsaWtlIG15IGFzc3Vt
cHRpb25zIHdlcmUgbm90IGNvcnJlY3QuICBZb3UgcG9pbnRlZCBvdXQgdHdvDQo+ID4gdGhpbmdz
IHRvIGRvIGluIHRoZSBnZW5lcmF0b3I+IC0gRXhwYW5kIHRoZSBtYWNyb3MgaW5saW5lDQo+ID4g
LSBTa2lwIHRoZSBpbnN0cnVjdGlvbnMgdGhhdCBoYXZlIG92ZXJyaWRlcw0KPg0KPiBZZXMgcGxl
YXNlLg0KPg0KPiA+IEkgYWRkaXRpb24sIHRoZXJlIG90aGVyIHRoaW5ncyBJIHNob3VsZCBkbyBp
ZiB3ZSB3YW50IHRoZSBnZW5lcmF0ZWQgZmlsZXMgdG8NCj4gYmUgbW9yZSByZWFkYWJsZQ0KPiA+
IC0gSW5kZW50IHRoZSBjb2RlDQo+DQo+IEhlbHBmdWwsIHllcy4NCj4NCj4gSSB3b3VsZG4ndCB3
b3JyeSBhYm91dCBuZXN0ZWQgc3RhdGVtZW50cyB3aXRoaW4gdGhlICouZGVmIGZpbGVzIHRvbyBt
dWNoLA0KPiBleGNlcHQgdG8gcHV0IGVhY2ggIjsiIHRlcm1pbmF0ZWQgc3RhdGVtZW50IG9uIGEg
bmV3IGxpbmUsIHNvIHRoYXQgZ2RiJ3Mgc3RlcA0KPiBjb21tYW5kIGdvZXMgdG8gdGhlIG5leHQg
c3RhdGVtZW50IGluc3RlYWQgb2Ygc2tpcHBpbmcgZXZlcnl0aGluZyBhbGwgYXQNCj4gb25jZS4N
Cj4NCj4gPiAtIE9ubHkgZ2VuZXJhdGUgb25lIG9mIHRoZSBmR0VOX1RDR188dGFnPiBvciBnZW5f
aGVscGVyXzx0YWc+DQo+DQo+IFRoYXQgd291bGQgYmUgcGFydCBvZiAic2tpcCB0aGUgaW5zdHJ1
Y3Rpb25zIHRoYXQgaGF2ZSBvdmVycmlkZXMiLCB3b3VsZCBpdA0KPiBub3Q/DQoNCkp1c3QgdG8g
YmUgZXhwbGljaXQsIHRoZSBjb2RlIHRoYXQgZ2VuZXJhdGVzIGNvZGUgaXMgZ2VuZXJhdGVkIGFz
DQogICAgI2lmZGVmIGZHRU5fVENHX0EyX2FkZA0KICAgIGZHRU5fVENHX0EyX2FkZCh7IFJkVj1S
c1YrUnRWO30pOw0KICAgICNlbHNlDQogICAgZG8gew0KICAgIGdlbl9oZWxwZXJfQTJfYWRkKFJk
ViwgY3B1X2VudiwgUnNWLCBSdFYpOw0KICAgIH0gd2hpbGUgKDApOw0KICAgICNlbmRpZg0KSWYg
d2UncmUgZ29pbmcgdG8gaGF2ZSB0aGUgZ2VuZXJhdG9yIGtub3cgaWYgdGhlcmUgaXMgYW4gb3Zl
cnJpZGUsIHRoaXMgd291bGQgYmUgbW9yZSByZWFkYWJsZSBhcyBlaXRoZXINCiAgICBmR0VOX1RD
R19BMl9hZGQoeyBSZFY9UnNWK1J0Vjt9KTsNCm9yDQogICAgZ2VuX2hlbHBlcl9BMl9hZGQoUmRW
LCBjcHVfZW52LCBSc1YsIFJ0Vik7DQoNCg0KPiA+IC0gR2VuZXJhdGUgdGhlIGRlY2xhcmF0aW9u
IG9mIHRoZSBnZW5lcmF0ZV88dGFnPiBmdW5jdGlvbiBpbnN0ZWFkIG9mIGp1c3QNCj4gdGhlIGJv
ZHkNCj4NCj4gSSdtIG5vdCBxdWl0ZSBzdXJlIHdoYXQgdGhpcyBtZWFucy4NCj4NCj4gQXJlbid0
IHRoZSAiZ2VuZXJhdGVfPHRhZz4iIGZ1bmN0aW9ucyBwcml2YXRlIHRvIGdlbnB0ci5jPyAgV2h5
IHdvdWxkIHdlDQo+IG5lZWQgYQ0KPiBzZXBhcmF0ZSBkZWNsYXJhdGlvbiBvZiB0aGVtLCBhcyBv
cHBvc2VkIHRvIGp1c3QgYSBkZWZpbml0aW9uPw0KDQpJbiBnZW5wdHIuYywgdGhlcmUgaXMNCiAg
ICAjZGVmaW5lIERFRl9UQ0dfRlVOQyhUQUcsIEdFTkZOKSBcDQogICAgc3RhdGljIHZvaWQgZ2Vu
ZXJhdGVfIyNUQUcoQ1BVSGV4YWdvblN0YXRlICplbnYsIERpc2FzQ29udGV4dCAqY3R4LCBcDQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW5zbl90ICppbnNuLCBwYWNrZXRfdCAqcGt0
KSBcDQogICAgeyBcDQogICAgICAgIEdFTkZOIFwNCiAgICB9DQogICAgI2luY2x1ZGUgInRjZ19m
dW5jc19nZW5lcmF0ZWQuaCINCiAgICAjdW5kZWYgREVGX1RDR19GVU5DDQpUaGUgZ2VuZXJhdGVk
IGNvZGUgb25seSBoYXMgdGhlIGJvZHkgb2YgdGhlIGZ1bmN0aW9uLiAgSXQgd291bGQgYmUgbW9y
ZSByZWFkYWJsZSB0byBtb3ZlIHRoZSBzdGF0aWMgdm9pZCBnZW5lcmF0ZV8jI1RBRyAuLi4gaW50
byB0aGUgZ2VuZXJhdGVkIGNvZGUuDQoNCg0KDQoNCg==

