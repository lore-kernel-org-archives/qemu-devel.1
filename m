Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDD0C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 00:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DAB520709
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 00:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HsvhZLeH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="J5KGfWrw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DAB520709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVPtT-0005Jz-96
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 19:55:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1iVPsS-0004rx-Bd
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 19:54:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1iVPsR-0001Lr-8h
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 19:54:20 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:51002)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1iVPsQ-0001Hx-S3
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 19:54:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1573779258; x=1605315258;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kD1BjjXever5u1aTNIroWt0xeOGuuokwcTlqSTNx2vE=;
 b=HsvhZLeHhBvt0N5YvEqtlcFWjWvu5A+LoYyR+Aoh09kMIIBUTscDkqef
 Ht/m8iipTm/qSuUFnHSUn+weYJBE8a7/P6A1hbRc2WSz4od8cH627MdXL
 m5RudxSDdSEDFs4y3iYG2x30Kc0FemdEOMq+JSPAVJEv+VDcr+ppiPJpB A=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Nov 2019 16:54:13 -0800
IronPort-SDR: sX/fRL6o1Le7wesYqmL1IrE9QmOxD0+PfPmANfD/JQmj4Ra2roASdjcLfqkS8966+Dd0wgdu0o
 JYqYGgPNt2k138GC9YBkrbfMEFlIQpYbOjVolRBF0pWvcE+6bl0Gxq5u1luM63orIWErV3/26X
 hbvJiS6IDIz1i9A42Co/3U694lluW9o9rVDUpX+Mx7Spg2JWJsNRN2LDryzj5qqmL9oD9mJK0z
 YbXr79PPe/ilbmKmjGCHnFTLBo3MQlLwYIKgmvviaeckykA4qoF2u1CICTrvg/SpwJcCnEdJe4
 noQGZR0SKASnUbN69T21dzoI
Received: from nasanexm03b.na.qualcomm.com ([10.85.0.98])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 14 Nov 2019 16:54:13 -0800
Received: from nasanexm03e.na.qualcomm.com (10.85.0.48) by
 nasanexm03b.na.qualcomm.com (10.85.0.98) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Thu, 14 Nov 2019 16:54:12 -0800
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Thu, 14 Nov 2019 16:54:12 -0800
Received: from SN6PR02MB4895.namprd02.prod.outlook.com (52.135.116.33) by
 SN6PR02MB4142.namprd02.prod.outlook.com (52.135.70.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 00:54:11 +0000
Received: from SN6PR02MB4895.namprd02.prod.outlook.com
 ([fe80::8123:6b52:d2eb:96c0]) by SN6PR02MB4895.namprd02.prod.outlook.com
 ([fe80::8123:6b52:d2eb:96c0%5]) with mapi id 15.20.2451.027; Fri, 15 Nov 2019
 00:54:11 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: QEMU for Qualcomm Hexagon - KVM Forum talk and code available
Thread-Topic: QEMU for Qualcomm Hexagon - KVM Forum talk and code available
Thread-Index: AdWLUOkdof4fsTRrRvOiehGwyV6GSgIG80YAACFndWABbY2JcAAZPB0AABIax7AABDdfgAA6ELiQ
Date: Fri, 15 Nov 2019 00:54:11 +0000
Message-ID: <SN6PR02MB48953397AA553FA7456E7CFCDE700@SN6PR02MB4895.namprd02.prod.outlook.com>
References: <BYAPR02MB48863165DEE32E5C563E93F4DE650@BYAPR02MB4886.namprd02.prod.outlook.com>
 <CAL1e-=jvmJNiZR4iLDL-97qm=v+2s0cwn5YTzJQ=JZ_gwOe4tQ@mail.gmail.com>
 <BYAPR02MB4886C8D82898F1E406C124F8DE7E0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <BYAPR02MB48865884056A88B660B620FCDE770@BYAPR02MB4886.namprd02.prod.outlook.com>
 <87d0dw83uz.fsf@linaro.org>
 <BYAPR02MB48866E2D82D9C76ABBECA842DE760@BYAPR02MB4886.namprd02.prod.outlook.com>
 <ffe58977-f251-df34-4bd0-62e32f78cc1a@linaro.org>
In-Reply-To: <ffe58977-f251-df34-4bd0-62e32f78cc1a@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [192.35.156.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c82bccc-0615-4fa0-8aef-08d769665401
x-ms-traffictypediagnostic: SN6PR02MB4142:
x-microsoft-antispam-prvs: <SN6PR02MB414204FBD2DA21FF14417DAEDE700@SN6PR02MB4142.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(136003)(396003)(346002)(39860400002)(189003)(199004)(13464003)(71190400001)(71200400001)(54906003)(316002)(26005)(76116006)(76176011)(3846002)(74316002)(6246003)(86362001)(33656002)(6506007)(486006)(4326008)(478600001)(102836004)(229853002)(25786009)(2501003)(256004)(6436002)(186003)(11346002)(446003)(14454004)(53546011)(476003)(7736002)(7696005)(66476007)(52536014)(305945005)(81166006)(6116002)(81156014)(8676002)(5660300002)(99286004)(66946007)(110136005)(9686003)(55016002)(66066001)(66556008)(64756008)(8936002)(66446008)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR02MB4142;
 H:SN6PR02MB4895.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vbu6UNGRssRa+Tsyxs21J01R3xIAlcxxHliR46xAn6+zqq5Yein1bPl5QWxz7twZkyf22Iv/Ww0zaQFoubW9hkCjDFyH9wFAA0l0K+8Z524Lvv06jxCskrKcLkgchn/unweecCE0NOHZ4BwFyM7MRslQTR/w8ONXiarhS2fe5SvKjrDidG33MIb/f7AdjiEYh1NRIbjht441ulnJQNXzAo3zSdqhizct84PYpDLkAcg5MFLimM07XkL4RDFCZp1hLUsLcgrxBALhp6tTy9uPrpIuaTDWACGTli58Mw/2voNyCE5eiKS1mg4zDlOC3o26Asq1a5ANP2GM3lInQDq2UY7XMyteslKkXe9zzas5G3ACFxC0ItgSomLMEUKAO/aolzeGI66RB10WLWkdwSr4SMNR5QDxOLUc98TzojwLF52b4lOes18ca2nWWxT/0k+9
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KH1/oGqmljP+uR0uYMjmIycQJc9RyxrgZP8Iub9IVS4F9nen/z0MWNAY9Niwh0Bp/81qVGb174LQgtVsO3q8M3JBtck8PTxmMCh7RVK9rI6q+p//XxQBalTBnUKtyxSE0JFa7ytUjx9B7QcWhU4tvyMHMkm0rlt4Guvm9PaRxHUpa7sbFnWa/A7YrfQLuQZ5UNeY8GwDTWSrMZr8qwmAT6jKfa5px3Ovcdu+OlSNwQGi5XvB5SYb440B/5tTnSzf4Akki3nDGHqqUSLJQ0St4ZRkOWEUEDMZYZXBGPr/2k9Nqonjlj/OWoaYqLlHT/m5Rjeba3tfQRYQ5dZJMmyjWw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLy2/mlDvCLbou+QQ1zaomGb6Y/RnB7cclK6uweLWt4=;
 b=izAJlo7z0wMoiI4bHLP47LIT5hB2I/qo/zjVKojDCFS/1vV+0gvYDiPKFNe2VfXRp63zS3UzLfXRzSBDJ68z45+PeXkyQY/Kv8ZDoBYqs7RPu4zCMgQQY8yAW2YrXImdPE2vg1KZ3WOAGu5zjpQEMIoSGAXlgJsa31QjFBU4Dmdi6EQtgiehXKRKodxIjlD+lXLaawF8rfPU+9S4jf3MednuSjvWcPZtsOauJMsdk2a+sFqbNyrv7z7aOi38EkH2/RfIA50hnSJhlwQS6DL7F1/lYW61R5uB7zBSAxaRGQmnNe9C2+eIEovoXe1fmiik2vJu6Cj2R8qVPj1SLqlm6A==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLy2/mlDvCLbou+QQ1zaomGb6Y/RnB7cclK6uweLWt4=;
 b=J5KGfWrwy7uXDGKwyJkfNUrFCBRNz7KY7L4yzB12eDOyKOV7/kgyeiAGHivMMi/FqqG9g6Wb4+abxkSCgP74Y2a9rjEvbDsBVNaUnFkyDPKC2ETtF2qkRXWSawMb6ZQvaYZ3LpWwEgNVqoB4ETDw/tBpkmgScbHjfuWHCv4jOSU=
x-ms-exchange-crosstenant-network-message-id: 6c82bccc-0615-4fa0-8aef-08d769665401
x-ms-exchange-crosstenant-originalarrivaltime: 15 Nov 2019 00:54:11.1733 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 29aKNOSTZYLQ/2S02XwrzKlJ234MMqM280vV7pE9Pkdh0N/oSnZwkun1lwSnYG1Sg1VS1kaEYeYGfz9yhdWjaw==
x-ms-exchange-transport-crosstenantheadersstamped: SN6PR02MB4142
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
Cc: Alessandro Di Federico <ale@rev.ng>, "nizzo@rev.ng" <nizzo@rev.ng>,
 =?utf-8?B?TmljY29sw7IgSXp6bw==?= <izzoniccolo@gmail.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T0ssIEkgY2hhbmdlZCB0aGUgY29kZSBpbiBnaXRodWIgYW5kIHdpbGwgdXBzdHJlYW0gaXQgdGhh
dCB3YXkuDQoNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogUmljaGFyZCBI
ZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQpTZW50OiBXZWRuZXNkYXks
IE5vdmVtYmVyIDEzLCAyMDE5IDM6MTAgUE0NClRvOiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBzb25A
cXVpY2luYy5jb20+OyBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+OyBxZW11
LWRldmVsQG5vbmdudS5vcmcNCkNjOiBBbGVzc2FuZHJvIERpIEZlZGVyaWNvIDxhbGVAcmV2Lm5n
Pjsgbml6em9AcmV2Lm5nOyBOaWNjb2zDsiBJenpvIDxpenpvbmljY29sb0BnbWFpbC5jb20+OyBB
bGVrc2FuZGFyIE1hcmtvdmljIDxhbGVrc2FuZGFyLm0ubWFpbEBnbWFpbC5jb20+DQpTdWJqZWN0
OiBSZTogUUVNVSBmb3IgUXVhbGNvbW0gSGV4YWdvbiAtIEtWTSBGb3J1bSB0YWxrIGFuZCBjb2Rl
IGF2YWlsYWJsZQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdp
bmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24uDQotLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQoNCk9uIDExLzEzLzE5IDg6MzEgUE0sIFRheWxvciBTaW1wc29uIHdyb3RlOg0KPiBbVGF5bG9y
XSBDdXJyZW50bHksIEkgaGF2ZSB0aGUgZ2VuZXJhdG9yIGFuZCB0aGUgZ2VuZXJhdGVkIGNvZGUg
c2l0dGluZyBpbiB0aGUgc291cmNlIHRyZWUuICBJJ20gZmxleGlibGUgb24gdGhpcyBpZiB0aGUg
ZGVjaXNpb24gaXMgdG8gcmVnZW5lcmF0ZSBpdCBldmVyeSB0aW1lLg0KDQpJIHdvdWxkIHByZWZl
ciB0byByZWdlbmVyYXRlIGV2ZXJ5IHRpbWUsIGFuZCBub3Qgc3RvcmUgdGhlIGdlbmVyYXRlZCBj
b2RlIGluIHRoZSBzb3VyY2UgdHJlZSBhdCBhbGwuICBJdCBtYWtlcyBpdCBhIG5vLWJyYWluZXIg
dG8gbW9kaWZ5IHRoZSBzb3VyY2UgYW5kIG5vdCBoYXZlIHRvIHJlbWVtYmVyIGhvdyB0byByZWdl
bmVyYXRlLCBiZWNhdXNlIHRoZSBydWxlcyBhcmUgcmlnaHQgdGhlcmUgaW4gdGhlIG1ha2VmaWxl
Lg0KDQoNCnJ+DQo=

