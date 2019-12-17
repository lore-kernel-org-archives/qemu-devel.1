Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F185C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:16:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEF9E206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PG3Ta0lH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="JG6+f5DK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF9E206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihHO7-0001zO-2f
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 13:16:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1ihHNE-0001Qh-NO
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:15:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1ihHND-0007aQ-Cq
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:15:08 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:26109)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1ihHNC-0007Yh-U2
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1576606506; x=1608142506;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wQfzHcWN8phfOBaTUZYnHpsNsfDQQSVL0sz0McbXdBk=;
 b=PG3Ta0lHUqfn/fhx4eZNtXHlV7c4kp0TrTpdIAa/q7Rfr6fQF1CLckt6
 XhBB+TJ5/SuNF/UrrMtNW9EmIyW7MvJ6AeVC11Vt6Gy+NClqbU6/joN90
 QkoOr0ylnct9Ngg5vRWoWJTcD6yZjQ9A63ZENe7k4itFZYpnyTrS9Vw0u 8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 17 Dec 2019 10:14:50 -0800
Received: from nasanexm01e.na.qualcomm.com ([10.85.0.31])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 17 Dec 2019 10:14:50 -0800
Received: from nasanexm01a.na.qualcomm.com (10.85.0.81) by
 NASANEXM01E.na.qualcomm.com (10.85.0.31) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Tue, 17 Dec 2019 10:14:49 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm01a.na.qualcomm.com (10.85.0.81) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Tue, 17 Dec 2019 10:14:49 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB4647.namprd02.prod.outlook.com (52.135.240.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Tue, 17 Dec 2019 18:14:48 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::d9c2:a411:1acc:21c4]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::d9c2:a411:1acc:21c4%5]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 18:14:47 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Taylor Simpson <tsimpson@quicinc.com>, Richard Henderson
 <richard.henderson@linaro.org>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>, Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: QEMU for Qualcomm Hexagon - KVM Forum talk and code available
Thread-Topic: QEMU for Qualcomm Hexagon - KVM Forum talk and code available
Thread-Index: AdWLUOkdof4fsTRrRvOiehGwyV6GSgIG80YAACFndWABbY2JcAAZPB0AABIax7AABDdfgAA6ELiQBmvrnpA=
Date: Tue, 17 Dec 2019 18:14:47 +0000
Message-ID: <BYAPR02MB488640DD7CC887E5FCC0F167DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <BYAPR02MB48863165DEE32E5C563E93F4DE650@BYAPR02MB4886.namprd02.prod.outlook.com>
 <CAL1e-=jvmJNiZR4iLDL-97qm=v+2s0cwn5YTzJQ=JZ_gwOe4tQ@mail.gmail.com>
 <BYAPR02MB4886C8D82898F1E406C124F8DE7E0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <BYAPR02MB48865884056A88B660B620FCDE770@BYAPR02MB4886.namprd02.prod.outlook.com>
 <87d0dw83uz.fsf@linaro.org>
 <BYAPR02MB48866E2D82D9C76ABBECA842DE760@BYAPR02MB4886.namprd02.prod.outlook.com>
 <ffe58977-f251-df34-4bd0-62e32f78cc1a@linaro.org>
 <SN6PR02MB48953397AA553FA7456E7CFCDE700@SN6PR02MB4895.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB48953397AA553FA7456E7CFCDE700@SN6PR02MB4895.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [199.106.103.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f245e43-6777-48e1-4be8-08d7831d005c
x-ms-traffictypediagnostic: BYAPR02MB4647:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB464767822D62E696B99628D2DE500@BYAPR02MB4647.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(13464003)(189003)(199004)(33656002)(76116006)(2906002)(53546011)(66574012)(66556008)(5660300002)(55016002)(8936002)(86362001)(71200400001)(4326008)(186003)(8676002)(26005)(81166006)(81156014)(66476007)(54906003)(498600001)(66446008)(6506007)(66946007)(9686003)(110136005)(7696005)(64756008)(52536014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB4647;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7rTQP79YjJrl2Fx8zeyhiv+N5Jw0Cm18eHZfLQDhiP/zaVRjPXC3ufULHT0/MawOJyCg2XHg9Dv7r14Xg3zzap5YxHz0Gh7zu+JTckU9lL7IzR2DtvRQcwPJKYTlKgsHpDi5jinG/hTCxcisqmo17U3Gh6As1sHemGN2G4Q64GOKJy7G2D3fv5bPK3AbHxXTCLobi4ctjORnzWcdvTFGf3W47ajOhJDkx9YzH9YwZ2Tu6Ogr9mBKicmhEnqle3Ve5nRSRsFmdV0Y0tjZSE7f8Us345zjhzdQ6hTKlGVeUGrHGT4B+CW2CzrcJ6RRBW7864jTOvVk44/x8MbAmFuEnhaT+BWlnsGqehk39EOvsSrhwVhvOEe8SeASFI82yiwSy3nChJc3Ok0oUK8OuQMb0S5OnC7oq0p9fj3UuZeqwuyvma3pl22s9QPQrf+7LgOfplaloJsEesKt5jab/ySMiDXdq9uGF2WgHEQ+Xym9FH8vk48n7kZ4qvi7DzXGqING
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U75Ak1mwIjOtddDoFStm3FDWh9O5E6JE7qAzW80zF8MRDxCZApagYe+jqCy4YgvRgbBjrYZB8MXRgGBsbzqT3T5QizV4z+D0AeUlufIL4rEVsB29p6oXScgFyP5fcxMMpVBsg3Qtb4HYWX+hUdJRFj7qhXwHxzQPeVcfpljHHtroEetFQ30i/EWLec79tWxn7+AFR/mY7QYfWF/R8WduEpF/Pw/ZHL5vU/Yhyi7LKP/b34BtjO6FQNanv/pg48GI43s1ZmcIbs8sA6iegWS4ikGOw0BgVtcETFDscEa6z3xPQz5XeQ6LmQLRGYrRno4vCsKO4vcP16acGtJs96ewSQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpHafSEAtizRprcnEYlBwyBopT5oyZO/ysOZvaJei9Q=;
 b=jv3g/c7TYCI0XGsbse0DYsLfYHeNGNQlTBuEM2rwtitIAbEL5MVit4mBl23ebjt5fF/LGc+eYZsGc7xRfkPuSHDeT5YColkfzHi9rW2BxZUuEj2ImL4UlIuZkCpaVK3l2efMf+vo4HmZ+QQLKxa3Vi5h/rqKEJeJGflP6a1v5PBiLUQh8Uc9yYcalyaQJO5vZL7mTbku9ApqcRitaQRKQCiReU7edy7v3aLNgjrC80+U5vF042p9wrV5QOmWo21TY2gx7/ge/iUprBo3tCEyC3034au49sJdOVsNfhPVTbGNK6Nwc6mQt+InB6RmjbVvSuZluPGr6vtgL3pgZi71xw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpHafSEAtizRprcnEYlBwyBopT5oyZO/ysOZvaJei9Q=;
 b=JG6+f5DKJiXY9xcteYtcaE/yRVrV1ZXNCybx4whaNnLoyKWTZG345VTT2580IGLoH+f0i7CIkFik3SKkhBfylcI1pGhGClLelaKa2cQoZ47DrWSkSb/tY8MD4AfjIVBL2SFkAASsycqMWKrwQbH6yAx5RhOy0RajewLSvYFG4MA=
x-ms-exchange-crosstenant-network-message-id: 2f245e43-6777-48e1-4be8-08d7831d005c
x-ms-exchange-crosstenant-originalarrivaltime: 17 Dec 2019 18:14:47.8654 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: LJtKd4g7BY9xSdwBMBWA+VOR83YS/78+efjnEc80QvalWvZyD3ejwYS5x7sUFkpwEGafur2PlVATcBj/jI3bpQ==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4647
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
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
Cc: Alessandro Di Federico <ale@rev.ng>, "nizzo@rev.ng" <nizzo@rev.ng>,
 =?utf-8?B?TmljY29sw7IgSXp6bw==?= <izzoniccolo@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgYWdhaW4sDQoNClBlciBBbGVrc2FuZGFyJ3MgZmVlZGJhY2ssIEknbSBmaW5pc2hpbmcgdXAg
dGhlIHJld3JpdGUgb2YgdGhlIGNvZGUgaW1wb3J0ZWQgZnJvbSB0aGUgZXhpc3RpbmcgSGV4YWdv
biBzaW11bGF0b3IuICBPbmNlIEknbSBmaW5pc2hlZCB3aXRoIHRoYXQgd29yaywgSSdsbCBzdGFy
dCBicmVha2luZyBkb3duIHRoZSBjb2RlIGludG8gYSBwYXRjaCBzZXJpZXMuICBJIGhhdmUgYSBj
b3VwbGUgb2YgcXVlc3Rpb25zIEkgaG9wZSBzb21lb25lIHdvdWxkIGJlIGtpbmQgZW5vdWdoIHRv
IGFuc3dlci4NCg0KUXVlc3Rpb24gMToNCkkgc2VlIHRoaXMgZXJyb3IgZnJvbSBjaGVja3BhdGNo
LnBsDQpFUlJPUjogTWFjcm9zIHdpdGggY29tcGxleCB2YWx1ZXMgc2hvdWxkIGJlIGVuY2xvc2Vk
IGluIHBhcmVudGhlc2lzDQpIb3dldmVyLCB0aGVyZSBhcmUgdGltZXMgd2hlbiB0aGUgY29kZSB3
aWxsIG5vdCBjb21waWxlIHdpdGggcGFyZW50aGVzaXMuICBGb3IgZXhhbXBsZSwgd2UgaGF2ZSBh
IGZpbGUgdGhhdCBkZWZpbmVkIGFsbCB0aGUgaW5zdHJ1Y3Rpb24gYXR0cmlidXRlcy4gIEVhY2gg
bGluZSBoYXMNCkRFRl9BVFRSSUIoTE9BRCwgIkxvYWRzIGZyb20gbWVtb3J5IiwgIiIsICIiKQ0K
U28sIHdlIGNyZWF0ZSBhbiBlbnVtIG9mIGFsbCB0aGUgcG9zc2libGUgYXR0cmlidXRlcyBhcyBm
b2xsb3dzDQplbnVtIHsNCiNkZWZpbmUgREVGX0FUVFJJQihOQU1FLCAuLi4pIEFfIyNOQU1FLA0K
I2luY2x1ZGUgImF0dHJpYnNfZGVmLmgiDQojdW5kZWYgREVGX0FUVFJJQg0KfTsNClRoaXMgaXMg
b25lIHNpbXBsZSBleGFtcGxlLiAgV2UgYWxzbyB0aGluZ3MgbGlrZSBjcmVhdGUgYW4gYXJyYXkg
b2YgdmFsdWVzIG9yIGEgc2VyaWVzIG9mIHNtYWxsIGZ1bmN0aW9ucyBvciBjYXNlcyBpbiBhIHN3
aXRjaCBzdGF0ZW1lbnQuDQoNClF1ZXN0aW9uIDI6DQpXaGF0IGlzIHRoZSBiZXN0IHNvdXJjZSBv
ZiBndWlkYW5jZSBvbiBicmVha2luZyBkb3duIHN1cHBvcnQgZm9yIGEgbmV3IHRhcmdldCBpbnRv
IGEgcGF0Y2ggc2VyaWVzPyAgSSBzZWUgYXZyIGJlaW5nIHJldmlld2VkIGN1cnJlbnRseS4gIEkg
aGF2ZSBtb3N0bHkgbmV3IGZpbGVzOiAxMiBpbiBsaW51eC11c2VyL2hleGFnb24sIGFuZCB+NTAg
aW4gdGFyZ2V0L2hleGFnb24uICBJIGFsc28gbmVlZCB0byBhZGQgdGVzdCBjYXNlcyBhbmQgYSBj
b250YWluZXIgZm9yIHRoZSB0b29sY2hhaW4uICBJcyBpdCBPSyB0byBicmVhayB0aGluZ3MgZG93
biBtb3N0bHkgYXQgZmlsZSBib3VuZGFyaWVzPyAgSW4gc29tZSBjYXNlcyBzbWFsbCBmaWxlcyBj
b3VsZCBiZSBjb21iaW5lZCwgYW5kIGxhcmdlIGZpbGVzIHdvdWxkIGJlIGJyb2tlbiBkb3duIGlu
dG8gcmV2aWV3YWJsZSBjaHVua3MuICBMYXRlIGluIHRoZSBzZXJpZXMsIEkgY2FuIGludHJvZHVj
ZSB0aGUgY2hhbmdlcyB0byBjb21tb24gY29kZS4gIFRoZSBpbXBsaWNhdGlvbiBvZiBoYXZpbmcg
dGhlIGNvbW1vbiBjb2RlIGNoYW5nZXMgbGF0ZSBpcyB0aGF0IGNvZGUgd291bGQgY29tcGlsZSBh
bmQgcnVuIG9ubHkgYXQgdGhlIGVuZCBvZiB0aGUgc2VyaWVzLg0KDQpUaGFua3MsDQpUYXlsb3IN
Cg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogUWVtdS1kZXZlbCA8cWVtdS1k
ZXZlbC1ib3VuY2VzK3RzaW1wc29uPXF1aWNpbmMuY29tQG5vbmdudS5vcmc+IE9uIEJlaGFsZiBP
ZiBUYXlsb3IgU2ltcHNvbg0KU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDE0LCAyMDE5IDY6NTQg
UE0NClRvOiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz47
IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz47IHFlbXUtZGV2ZWxAbm9uZ251
Lm9yZw0KQ2M6IEFsZXNzYW5kcm8gRGkgRmVkZXJpY28gPGFsZUByZXYubmc+OyBuaXp6b0ByZXYu
bmc7IE5pY2NvbMOyIEl6em8gPGl6em9uaWNjb2xvQGdtYWlsLmNvbT47IEFsZWtzYW5kYXIgTWFy
a292aWMgPGFsZWtzYW5kYXIubS5tYWlsQGdtYWlsLmNvbT4NClN1YmplY3Q6IFJFOiBRRU1VIGZv
ciBRdWFsY29tbSBIZXhhZ29uIC0gS1ZNIEZvcnVtIHRhbGsgYW5kIGNvZGUgYXZhaWxhYmxlDQoN
Ck9LLCBJIGNoYW5nZWQgdGhlIGNvZGUgaW4gZ2l0aHViIGFuZCB3aWxsIHVwc3RyZWFtIGl0IHRo
YXQgd2F5Lg0KDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFJpY2hhcmQg
SGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPg0KU2VudDogV2VkbmVzZGF5
LCBOb3ZlbWJlciAxMywgMjAxOSAzOjEwIFBNDQpUbzogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29u
QHF1aWNpbmMuY29tPjsgQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPjsgcWVt
dS1kZXZlbEBub25nbnUub3JnDQpDYzogQWxlc3NhbmRybyBEaSBGZWRlcmljbyA8YWxlQHJldi5u
Zz47IG5penpvQHJldi5uZzsgTmljY29sw7IgSXp6byA8aXp6b25pY2NvbG9AZ21haWwuY29tPjsg
QWxla3NhbmRhciBNYXJrb3ZpYyA8YWxla3NhbmRhci5tLm1haWxAZ21haWwuY29tPg0KU3ViamVj
dDogUmU6IFFFTVUgZm9yIFF1YWxjb21tIEhleGFnb24gLSBLVk0gRm9ydW0gdGFsayBhbmQgY29k
ZSBhdmFpbGFibGUNCg0KT24gMTEvMTMvMTkgODozMSBQTSwgVGF5bG9yIFNpbXBzb24gd3JvdGU6
DQo+IFtUYXlsb3JdIEN1cnJlbnRseSwgSSBoYXZlIHRoZSBnZW5lcmF0b3IgYW5kIHRoZSBnZW5l
cmF0ZWQgY29kZSBzaXR0aW5nIGluIHRoZSBzb3VyY2UgdHJlZS4gIEknbSBmbGV4aWJsZSBvbiB0
aGlzIGlmIHRoZSBkZWNpc2lvbiBpcyB0byByZWdlbmVyYXRlIGl0IGV2ZXJ5IHRpbWUuDQoNCkkg
d291bGQgcHJlZmVyIHRvIHJlZ2VuZXJhdGUgZXZlcnkgdGltZSwgYW5kIG5vdCBzdG9yZSB0aGUg
Z2VuZXJhdGVkIGNvZGUgaW4gdGhlIHNvdXJjZSB0cmVlIGF0IGFsbC4gIEl0IG1ha2VzIGl0IGEg
bm8tYnJhaW5lciB0byBtb2RpZnkgdGhlIHNvdXJjZSBhbmQgbm90IGhhdmUgdG8gcmVtZW1iZXIg
aG93IHRvIHJlZ2VuZXJhdGUsIGJlY2F1c2UgdGhlIHJ1bGVzIGFyZSByaWdodCB0aGVyZSBpbiB0
aGUgbWFrZWZpbGUuDQoNCg0Kcn4NCg==

