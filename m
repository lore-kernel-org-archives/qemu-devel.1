Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE18C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:25:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA1D22DD6
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="W3YON76k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA1D22DD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i06wQ-00080E-Qf
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 12:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1i06vY-0007PZ-5q
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1i06vW-0000B4-0W
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:24:07 -0400
Received: from mail-eopbgr50129.outbound.protection.outlook.com
 ([40.107.5.129]:37767 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1i06vV-00008b-Pt
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:24:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRq5t+bh78HcuomepfOYi6a0oi2rXY1gyyRh38kfh5k1qKpO8/eKYV9FuoRWD+M0y5gNCp8T8RQVslu3KpeVvnTyhyUED77PCvSsUihWDaJ7lNRce98j+r2ytMHKNAR0GNFgkkGYLUuNwFlJkwpCV9AzELf+pIFH2GHzrlLzFAa7WFjwKh/zALFfknHdT/AWVrotdCHiBjwG7rJQlKrMjsP3o4sSi2AcGziCxnqe14TNUr7XXbZv87/B2l+1eRbXV+kMWI+A0n+ER+UmMGS7iKW6sW6snnRqmQZQIIRCqLiecZ+7DhxF3BlBzN3lWxP+dr8PholWQnqJNIdugNg+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxYSa1mKgtwdWR6ZgPXqDghgiQhiKYPPquUscgSe3NM=;
 b=A3CSipRDiJJLLGCl9+LKzCys5E+c1nqE5TEzfk3c1mnsNrHxYrVhEuDxjfvRrY6DuK4930pZ/IoNNeqjAxfBFB/eYxrZGBBkOMbP9oTWHowawr1cvIyOz8EUtdpAELGpVWN6ZKwS/RuANDfKP4bed5juuW53qZg4BrqDbe6wKJvpGH14l+/C+3vDWPjo0ltus/do7brn+Nim4qVYoZ9Pp7Eof80NR+cYu+bDSgbC+r13fRDNg3Ln8vxb5mI4FBt6dx5KyQ+GMIn3L1DLIqjwwEfu4CTR5KwPrZR24eJCAsVXyugWcS7i/wCwmhXQb3NKg3TD5VNnIkRaRwOscuIZ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxYSa1mKgtwdWR6ZgPXqDghgiQhiKYPPquUscgSe3NM=;
 b=W3YON76k3IYaP4C6WcpsUAoEG56Q/9S2mGFKzfLoEW4TsxLQNGW5uqrstWnybnbVGZN77RT0TQ0eocCg92NuOOKhSpeUYPamS4iIQ2zEc7bruo0k86OdA0mGycag+hfhqwY1Osssnr/A5nDE/nB5s+Nsdnr6LsifAyPxVt8ZWco=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3795.eurprd08.prod.outlook.com (20.178.23.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Tue, 20 Aug 2019 16:24:03 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::ac29:7eee:83d9:4668]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::ac29:7eee:83d9:4668%7]) with mapi id 15.20.2157.024; Tue, 20 Aug 2019
 16:24:03 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>
Thread-Topic: [PATCH v9] qemu-io: add pattern file for write command
Thread-Index: AQHVV1wcGJUcVc3jCEioObuNgpDsdKcEOJqA
Date: Tue, 20 Aug 2019 16:24:03 +0000
Message-ID: <30AD7752-A792-459B-AD48-45B4E841EC7A@getmailspring.com>
References: <f3eb6ae0-98d9-b7d1-3c04-60b37444fa68@redhat.com>
In-Reply-To: <f3eb6ae0-98d9-b7d1-3c04-60b37444fa68@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0072.eurprd07.prod.outlook.com
 (2603:10a6:3:64::16) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Mailspring
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65bd411e-2269-41d5-800b-08d7258ad0a9
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:AM0PR08MB3795; 
x-ms-traffictypediagnostic: AM0PR08MB3795:
x-microsoft-antispam-prvs: <AM0PR08MB3795AB500408EE69DC257672CFAB0@AM0PR08MB3795.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(136003)(366004)(376002)(346002)(199004)(189003)(2906002)(386003)(6506007)(18926415008)(3736002)(8936002)(50226002)(6486002)(14454004)(25786009)(53546011)(8676002)(99286004)(52116002)(6436002)(733005)(76176011)(54906003)(478600001)(5660300002)(33656002)(81156014)(81166006)(36756003)(26005)(86362001)(107886003)(3846002)(6116002)(7736002)(71200400001)(305945005)(71190400001)(66946007)(486006)(186003)(102836004)(6246003)(66066001)(53936002)(476003)(229853002)(14444005)(4326008)(316002)(9686003)(6306002)(54896002)(446003)(256004)(11346002)(66556008)(66476007)(6862004)(6512007)(66446008)(64756008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3795;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JFMLjfXI/MKYtDab1dGO2FxsMiuQcJBdJLtbp2q8qAFh0rh1usMP2QKE2+r0ZwsLLh9RtDT3iFqth2UrxLKBcOnZlytuhI9MEyg+hG+a78Da0j2i06eHK0DD5W+0PjYU/WHUhul48U639l3cpng1PeYtUwPKXstY7H6XWTYEDRg5C+qcZFodjP7fy7/u3XJVHyfzQAgvwzzrBYUvGOycnMqVyG1kHJkGbFfo9HhQqPwKyhARW0Q3hnccjYL3J+f7Gmo7EItSdMqFOwthFGygjP6q9meWCo4Lnn76rOWscAwUS6OEyS9ZvrZJe/p4syRRz++llJAC8Vugicr9a77lCilgei+wPpV0Ip33bLlu/dVW6jPvMr8ImdGmL3iVhwCKC7FLm2giZmHkzYT04SsDInYHZaYLtKf/cIPK+YfL1ss=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65bd411e-2269-41d5-800b-08d7258ad0a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 16:24:03.3957 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yk+2iDnj8DyvwEktG8D7smNZ1r0rhWGyoQffPzfjEaz4C65ui8NsDTvUNjUOaChZDEEtresJBppZ9blIsfNQd1z+IHox1igTARb8SK8eguM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3795
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.129
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v9] qemu-io: add pattern file for write
 command
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIEF1ZyAyMCAyMDE5LCBhdCA0OjM1IHBtLCBNYXggUmVpdHogPG1yZWl0ekByZWRoYXQu
Y29tPiB3cm90ZToNCk9uIDE5LjA4LjE5IDE4OjE4LCBEZW5pcyBQbG90bmlrb3Ygd3JvdGU6DQpU
aGUgcGF0Y2ggYWxsb3dzIHRvIHByb3ZpZGUgYSBwYXR0ZXJuIGZpbGUgZm9yIHdyaXRlDQpjb21t
YW5kLiBUaGVyZSB3YXMgbm8gc2ltaWxhciBhYmlsaXR5IGJlZm9yZS4NCg0KU2lnbmVkLW9mZi1i
eTogRGVuaXMgUGxvdG5pa292IDxkcGxvdG5pa292QHZpcnR1b3p6by5jb20+DQotLS0NCnY5Og0K
KiByZXBsYWNlIGZsYWcgY2FzdCB0byBpbnQgd2l0aCBib29sIFtFcmljXQ0KKiBmaXggdGhlIGVy
cm9yIG1lc3NhZ2UgW0VyaWNdDQoqIHVzZSBxZW11X2lvX2ZyZWUgaW5zdGVhZCBvZiBxZW11X3Zm
cmVlIFtFcmljXQ0KKiBhZGQgZnVuY3Rpb24gZGVzY3JpcHRpb24gW0VyaWNdDQoNCnY4OiBmaXgg
YWNjb3JkaW5nIHRvIE1heCdzIGNvbW1lbnRzDQoqIGdldCByaWQgb2YgdW5uZWNlc3NhcnkgYnVm
ZmVyIGZvciB0aGUgcGF0dGVybg0KKiBidWZmZXIgYWxsb2NhdGlvbiBqdXN0IGluIGJ5dGVzDQoq
IHRha2UgaW50byBhY2NvdW50IHRoZSBtaXNzYWxpZ24gb2Zmc2V0DQoqIGRvbid0IGNvcHkgZmls
ZSBuYW1lDQoqIGNoYW5nZWQgY2hhciogdG8gY29uc3QgY2hhciogaW4gaW5wdXQgcGFyYW1zDQoN
CnY3Og0KKiBmaXggdmFyaWFibGUgbmFtaW5nDQoqIG1ha2UgY29kZSBtb3JlIHJlYWRhYmxlDQoq
IGV4dGVuZCBoZWxwIGZvciB3cml0ZSBjb21tYW5kDQoNCnY2Og0KKiB0aGUgcGF0dGVybiBmaWxl
IGlzIHJlYWQgb25jZSB0byByZWR1Y2UgaW8NCg0KdjU6DQoqIGZpbGUgbmFtZSBpbml0aWF0ZWQg
d2l0aCBudWxsIHRvIG1ha2UgY29tcGlsZXJzIGhhcHB5DQoNCnY0Og0KKiBtaXNzaW5nIHNpZ25l
ZC1vZmYgY2xhdXNlIGFkZGVkDQoNCnYzOg0KKiBtaXNzaW5nIGZpbGUgY2xvc2luZyBhZGRlZA0K
KiBleGNsdXNpdmUgZmxhZ3MgcHJvY2Vzc2luZyBjaGFuZ2VkDQoqIGJ1ZmZlciB2b2lkKiBjb252
ZXJ0ZWQgdG8gY2hhciogdG8gZml4IHBvaW50ZXIgYXJpdGhtZXRpY3MNCiogZmlsZSByZWFkaW5n
IGVycm9yIHByb2Nlc3NpbmcgYWRkZWQNCi0tLQ0KcWVtdS1pby1jbWRzLmMgfCA5NyArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KMSBmaWxlIGNoYW5n
ZWQsIDkxIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9xZW11
LWlvLWNtZHMuYyBiL3FlbXUtaW8tY21kcy5jDQppbmRleCAwOTc1MGEyM2NlLi5mN2JkZmU2NzNi
IDEwMDY0NA0KLS0tIGEvcWVtdS1pby1jbWRzLmMNCisrKyBiL3FlbXUtaW8tY21kcy5jDQpAQCAt
MzUxLDYgKzM1MSw3NyBAQCBzdGF0aWMgdm9pZCBxZW11X2lvX2ZyZWUodm9pZCAqcCkNCnFlbXVf
dmZyZWUocCk7DQp9DQoNCisvKg0KKyAqIHFlbXVfaW9fYWxsb2NfZnJvbV9maWxlKCkNCisgKg0K
KyAqIEFsbG9jYXRlcyB0aGUgYnVmZmVyIGFuZCBwb3B1bGF0ZXMgaXQgd2l0aCB0aGUgY29udGVu
dCBvZiB0aGUgZ2l2ZW4gZmlsZQ0KKyAqIHVwIHRvIEBsZW4gYnl0ZXMuIElmIHRoZSBmaWxlIGxl
bmd0aCBpcyBsZXNzIHRoZW4gQGxlbiwgdGhlbiB0aGUgYnVmZmVyDQoNCnMvdGhlbi90aGFuLyAo
dGhlIGZpcnN0IG9uZSkNCg0KKyAqIGlzIHBvcHVsYXRlZCB3aXRoIHRoZW4gZmlsZSBjb250ZW50
IGN5Y2xpY2FsbHkuDQoNCnMvdGhlbi90aGUvDQoNCisgKg0KKyAqIEBibGsgLSB0aGUgYmxvY2sg
YmFja2VuZCB3aGVyZSB0aGUgYnVmZmVyIGNvbnRlbnQgaXMgZ29pbmcgdG8gYmUgd3JpdHRlbiB0
bw0KKyAqIEBsZW4gLSB0aGUgYnVmZmVyIGxlbmd0aA0KKyAqIEBmaWxlX25hbWUgLSB0aGUgZmls
ZSB0byBjb3B5IHRoZSBjb250ZW50IGZyb20NCg0KUHJvYmFibHkgYmV0dGVyIHMvY29weS9yZWFk
Lw0KDQorICoNCisgKiBSZXR1cm5zOiB0aGUgYnVmZmVyIHBvaW50ZXIgb24gc3VjY2Vzcw0KKyAq
IE5VTEwgb24gZXJyb3INCisgKi8NCitzdGF0aWMgdm9pZCAqcWVtdV9pb19hbGxvY19mcm9tX2Zp
bGUoQmxvY2tCYWNrZW5kICpibGssIHNpemVfdCBsZW4sDQorIGNvbnN0IGNoYXIgKmZpbGVfbmFt
ZSkNCit7DQorIGNoYXIgKmJ1ZiwgKmJ1Zl9vcmlnaW47DQorIEZJTEUgKmYgPSBmb3BlbihmaWxl
X25hbWUsICJyIik7DQorIGludCBwYXR0ZXJuX2xlbjsNCisNCisgaWYgKCFmKSB7DQorIHBlcnJv
cihmaWxlX25hbWUpOw0KKyByZXR1cm4gTlVMTDsNCisgfQ0KKw0KKyBpZiAocWVtdWlvX21pc2Fs
aWduKSB7DQorIGxlbiArPSBNSVNBTElHTl9PRkZTRVQ7DQorIH0NCisNCisgYnVmX29yaWdpbiA9
IGJ1ZiA9IGJsa19ibG9ja2FsaWduKGJsaywgbGVuKTsNCisNCisgaWYgKHFlbXVpb19taXNhbGln
bikgew0KKyBidWZfb3JpZ2luICs9IE1JU0FMSUdOX09GRlNFVDsNCisgfQ0KKw0KKyBwYXR0ZXJu
X2xlbiA9IGZyZWFkKGJ1Zl9vcmlnaW4sIDEsIGxlbiwgZik7DQoNClB1bGxpbmcgdGhlIG1pc2Fs
aWdubWVudCB1cCBoZXJlIGhhcyBtb3JlIGVmZmVjdHMgdGhhbiBqdXN0IHJlcXVpcmluZw0KcWVt
dV9pb19mcmVlKCkgcmF0aGVyIHRoYW4gcWVtdV92ZnJlZSgpLg0KDQpGaXJzdCwgaXQgYnJlYWtz
IHRoaXMgZnJlYWQoKSwgYmVjYXVzZSBAbGVuIGlzIHRoZSBsZW5ndGggb2YgdGhlIGJ1ZmZlcg0K
aW4gdG90YWwsIHNvIHRoaXMgaGVyZSBpcyBhIGJ1ZmZlciBvdmVyZmxvdy4NCg0KKw0KKyBpZiAo
ZmVycm9yKGYpKSB7DQorIHBlcnJvcihmaWxlX25hbWUpOw0KKyBnb3RvIGVycm9yOw0KKyB9DQor
DQorIGlmIChwYXR0ZXJuX2xlbiA9PSAwKSB7DQorIGZwcmludGYoc3RkZXJyLCAiJXM6IGZpbGUg
aXMgZW1wdHlcbiIsIGZpbGVfbmFtZSk7DQorIGdvdG8gZXJyb3I7DQorIH0NCisNCisgZmNsb3Nl
KGYpOw0KKw0KKyBpZiAobGVuID4gcGF0dGVybl9sZW4pIHsNCisgbGVuIC09IHBhdHRlcm5fbGVu
Ow0KKyBidWYgKz0gcGF0dGVybl9sZW47DQorDQorIHdoaWxlIChsZW4gPiAwKSB7DQorIHNpemVf
dCBsZW5fdG9fY29weSA9IE1JTihwYXR0ZXJuX2xlbiwgbGVuKTsNCisNCisgbWVtY3B5KGJ1Ziwg
YnVmX29yaWdpbiwgbGVuX3RvX2NvcHkpOw0KDQpTZWNvbmQsIGl0IGJyZWFrcyB0aGlzIG1lbWNw
eSgpLCBiZWNhdXNlIG5vdyBbYnVmLCBidWYgKyBsZW5fdG9fY29weSkNCmFuZCBbYnVmX29yaWdp
biwgYnVmX29yaWdpbiArIGxlbl90b19jb3B5KSBtYXkgb3ZlcmxhcC4NCg0KSSB0aGluayB0aGUg
c29sdXRpb24gd291bGQgYmUgKDEpIHRvIGFkZCBNSVNBTElHTl9PRkZTRVQgbm90IG9ubHkgdG8N
CkBidWZfb3JpZ2luLCBidXQgdG8gQGJ1ZiBhbHNvLCBhbmQgKDIpIHRvIHJlZHVjZSBsZW4gYnkg
TUlTQUxJR05fT0ZGU0VULg0KDQoNClNvIGFsbCBpbiBhbGwsIEkgdGhpbmsgYm90aCBpc3N1ZXMg
c2hvdWxkIGJlIGZpeGVkIGlmIHlvdSBhZGQNCuKAnGJ1ZiArPSBNSVNBTElHTl9PRkZTRVTigJ0g
YW5kIOKAnGxlbiAtPSBNSVNBTElHTl9PRkZTRVTigJ0gdG8gdGhlIHNlY29uZA0K4oCcaWYgKHFl
bXVpb19taXNhbGlnbinigJ0gYmxvY2suIEkgdGhpbmsuDQoNClllcywgdGhhbmtzIGZvciBwb2lu
dGluZyBvdXQNCg0KRGVuaXMNCg0KKw0KKyBsZW4gLT0gbGVuX3RvX2NvcHk7DQorIGJ1ZiArPSBs
ZW5fdG9fY29weTsNCisgfQ0KKyB9DQorDQorIHJldHVybiBidWZfb3JpZ2luOw0KKw0KK2Vycm9y
Og0KKyBxZW11X2lvX2ZyZWUoYnVmX29yaWdpbik7DQorIHJldHVybiBOVUxMOw0KK30NCisNCnN0
YXRpYyB2b2lkIGR1bXBfYnVmZmVyKGNvbnN0IHZvaWQgKmJ1ZmZlciwgaW50NjRfdCBvZmZzZXQs
IGludDY0X3QgbGVuKQ0Kew0KdWludDY0X3QgaTsNCg0KWy4uLl0NCg0KQEAgLTEwNTEsOCArMTEy
OCw5IEBAIHN0YXRpYyBpbnQgd3JpdGVfZihCbG9ja0JhY2tlbmQgKmJsaywgaW50IGFyZ2MsIGNo
YXIgKiphcmd2KQ0KcmV0dXJuIC1FSU5WQUw7DQp9DQoNCi0gaWYgKHpmbGFnICYmIFBmbGFnKSB7
DQotIHByaW50ZigiLXogYW5kIC1QIGNhbm5vdCBiZSBzcGVjaWZpZWQgYXQgdGhlIHNhbWUgdGlt
ZVxuIik7DQorIGlmICgoYm9vbCl6ZmxhZyArIChib29sKVBmbGFnICsgKGJvb2wpc2ZsYWcgPiAx
KSB7DQoNCkVyaWPigJlzIHBvaW50IHdhcyB0aGF0IHlvdSBkb27igJl0IG5lZWQgdG8gY2FzdCBh
dCBhbGwuDQoNCk1heA0KDQorIHByaW50ZigiT25seSBvbmUgb2YgLXosIC1QLCBhbmQgLXMgIg0K
KyAiY2FuIGJlIHNwZWNpZmllZCBhdCB0aGUgc2FtZSB0aW1lXG4iKTsNCnJldHVybiAtRUlOVkFM
Ow0KfQ0KDQo=
