Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FF5C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:52:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A011E20709
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Z3ovZyMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A011E20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuwZL-0005sN-SC
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iuwY1-0005BB-C7
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:51:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iuwXJ-0006tD-Tb
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:50:45 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:9092)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iuwXI-0006kj-No
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:50:01 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00OAg9rY007812; Fri, 24 Jan 2020 02:49:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=qIhjfkpMYw9lsLztRQcQu0czPp8tc5gcbYsrfWbbJko=;
 b=Z3ovZyMmk0bubth/lJ4l2Vjewi58dD0HUhRjTzSAoOrDhzfSibp79pkmKe/6TU86DOvW
 8GmT4wRUGkUxJrdV/XljgdMGfpkOUpwb1zTCF9CSi33IN9WTDuWFVFBnh8cMcI1iiOVj
 6VivkT8dHgWOwvBLQ6lwBk42HzEupOwnm5BHjw8s23l6Sn0zly9rLXRQ6eaUq4ZlAa49
 8gSRj4v1x1t2ySR3GDkvC2BEYncwYVbebNAENfBhGebT5RGIFubQc6gTgoqqBWcL0UN8
 Vu2waisv5lv90m1JtaYAhZ1yfmI/umXRZaA/jIvFA8VOKP9Ftkds4e/h5P4xYkTSWLzB GQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2xky80nakb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jan 2020 02:49:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIAJKYmZJXYYpjZe1xY3duMB6b8iyDK5RFEJ41Si2fzAWGk5t69I1Ileps7gwOght0WPwoD4da8iJzBcY5p/Hmjt5Npov0zqFEZ3l3LJX/v5h961T2irdycgMGOaJT35YTFTLbX83KFuk7cJhXoY5tnDEk+QM4cwRLBeTE7iiRE6PiI6nFk1hU7464GWEXouC21apx/tKurPbBQbgu2Cktfv9+kIMfW7/beYTR0vWEWdWH5JDbNbic9MUGincec+WTrlyP65fCkakrvfMsAiE0xYfnPg6Quqi4IZ/nVrCRL0N8CdRVxvLLJodJ4zXmmty7Pe9XTIMozG9RYXpVvbTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIhjfkpMYw9lsLztRQcQu0czPp8tc5gcbYsrfWbbJko=;
 b=KASK2ipSMX7qcTzs2SZAE1KbKrBMbpx1PczhRnGLdX7XmPk3OyVMydlV/mKnZuTv6j3P4oAKpE2o5+ISnpL+aJx2W/tIYrHzp30b4NInwpCwdsdZBiFxmJTJCF+27u98TDDV8+KGd3RqdCCfRPjPX3M1ICT9XJ7lqOz6qPp6evARZ7tbCWhhO9AXRoC1G2JjkHeCNCJstrUJc8KWZ83CRBQHIasg/TTCdFByvpPZ1x7lTTU86lbWE5JIFWc3KLxDxupViJCqMsj+cn+8unSRnKMJaGZ+v3yWhWlEvu9sN5++1V4nNV92vMf7AwtRxQqXkwA7W07HwF/Hj2e00bGGBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB3278.namprd02.prod.outlook.com (10.164.187.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Fri, 24 Jan 2020 10:49:51 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029%10]) with mapi id 15.20.2644.028; Fri, 24 Jan
 2020 10:49:51 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 0/4] Improve default object property_add uint helpers
Thread-Topic: [PATCH v4 0/4] Improve default object property_add uint helpers
Thread-Index: AQHVtpZ6lIuRGF0HJ0OIoqz7XKz+uqfDI2WAgDa3bgA=
Date: Fri, 24 Jan 2020 10:49:51 +0000
Message-ID: <A7FBEA28-7FDD-46BA-87DD-3EDB5B101571@nutanix.com>
References: <20191219180205.25191-1-felipe@nutanix.com>
 <CAJ+F1C+YmQFnMmWrJOZpKrqp9pEzUqLF7yP-yB2hwsz6h3L3cA@mail.gmail.com>
In-Reply-To: <CAJ+F1C+YmQFnMmWrJOZpKrqp9pEzUqLF7yP-yB2hwsz6h3L3cA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.9.225.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2eb89cc0-0c51-4e79-989f-08d7a0bb23df
x-ms-traffictypediagnostic: MWHPR02MB3278:
x-microsoft-antispam-prvs: <MWHPR02MB3278884707C5DB37F1B5E14ED70E0@MWHPR02MB3278.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02929ECF07
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(376002)(39860400002)(136003)(366004)(189003)(199004)(81166006)(81156014)(8936002)(110136005)(54906003)(76116006)(4326008)(66946007)(33656002)(91956017)(64756008)(66556008)(66476007)(66446008)(86362001)(8676002)(71200400001)(316002)(5660300002)(26005)(6486002)(186003)(53546011)(6512007)(2616005)(6506007)(2906002)(478600001)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB3278;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NbYoVpShL7/ukY4rRBakacfWoyQ2rqhtvcwnaoPoLkkoZIa2kg6ZpIkh6RvdquNaltOtCVyD0vJnDG22Ksehjk3mc7IoKRB3XU80RfCkeuY4tpJehiYB1jGLmBrjak4HTOZvccGacAETWmTG7u2D8WQXRrzItGz8MDGsFoV8YNvIVnOPWXlTmY62plcPinXWp+xzbIcrCiiLVLLOdvkaGKX48YZHe+WlqYO/Fe2qSeY6FBPuxcc5kKIb/nOV2KnIoJ5Se2jOhXgdCHCk/fXG4R4iceXgH5v0VjQcZ17DR6mrEJg3VuZVb9vNtQTCnwCik791jQum9fC/09kNhPEg8vieoKWaxJAkV2I0cdSeIyyx2mcmZlwm9nzHaTL3hePOVONlK/qxypVJfEdtcDeDlPIWmFjGJAATcwOehBoAgiOhI78Ql8/9MB0Ax5bp11JZ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7F218CC4CBA4B42BD23271C46569E62@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb89cc0-0c51-4e79-989f-08d7a0bb23df
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2020 10:49:51.5340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YLSmaOd5s3PizuVt659bqHPJuQUJpmZUB+F2lN/agjlhAVWxPxiC4WGSUIL999NozE0GgpwxbmEuNgJDWLpL2W8E6F8OJAFAjyDcOLAKlWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3278
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-24_03:2020-01-24,
 2020-01-24 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.151.68
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Phillipe Mathieu-Daude <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgTWFyYy1BbmRyZSBhbmQgUGFvbG8sDQoNCj4gT24gRGVjIDIwLCAyMDE5LCBhdCAzOjE1IFBN
LCBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAZ21haWwuY29tPiB3cm90ZToN
Cj4gDQo+IEhpDQo+IA0KPiBPbiBUaHUsIERlYyAxOSwgMjAxOSBhdCAxMDowMiBQTSBGZWxpcGUg
RnJhbmNpb3NpIDxmZWxpcGVAbnV0YW5peC5jb20+IHdyb3RlOg0KPj4gDQo+PiBUaGlzIGltcHJv
dmVzIHRoZSBmYW1pbHkgb2Ygb2JqZWN0X3Byb3BlcnR5X2FkZF91aW50WFhfcHRyIGhlbHBlcnMg
YnkgZW5hYmxpbmcNCj4+IGEgZGVmYXVsdCBnZXR0ZXIvc2V0dGVyIG9ubHkgd2hlbiBkZXNpcmVk
LiBUbyBwcmV2ZW50IGFuIEFQSSBiZWhhdmlvdXJhbCBjaGFuZ2UNCj4+IChmcm9tIGNsaWVudHMg
dGhhdCBhbHJlYWR5IHVzZWQgdGhlc2UgaGVscGVycyBhbmQgZGlkIG5vdCB3YW50IGEgc2V0dGVy
KSwgd2UNCj4+IGFkZCBhIE9CSl9QUk9QX0ZMQUdfUkVBRCBmbGFnIHRoYXQgYWxsb3cgY2xpZW50
cyB0byBvbmx5IGhhdmUgYSBnZXR0ZXIuIFBhdGNoIDENCj4+IGVuaGFuY2VzIHRoZSBBUEkgYW5k
IG1vZGlmeSBjdXJyZW50IHVzZXJzLg0KPj4gDQo+PiBXaGlsZSBtb2RpZnlpbmcgdGhlIGNsaWVu
dHMgb2YgdGhlIEFQSSwgYSBjb3VwbGUgb2YgaW1wcm92ZW1lbnQgb3Bwb3J0dW5pdGllcw0KPj4g
d2VyZSBvYnNlcnZlZCBpbiBpY2g5LiBUaGVzZSB3ZXJlIGFkZGVkIGluIHNlcGFyYXRlIHBhdGNo
ZXMgKDIgYW5kIDMpLg0KPj4gDQo+PiBQYXRjaCAzIGNsZWFucyB1cCBhIGxvdCBvZiBleGlzdGlu
ZyBjb2RlIGJ5IG1vdmluZyB2YXJpb3VzIG9iamVjdHMgdG8gdGhlDQo+PiBlbmhhbmNlZCBBUEku
IFByZXZpb3VzbHksIHRob3NlIG9iamVjdHMgaGFkIHRoZWlyIG93biBnZXR0ZXJzL3NldHRlcnMg
dGhhdCBvbmx5DQo+PiB1cGRhdGVkIHRoZSB2YWx1ZXMgd2l0aG91dCBmdXJ0aGVyIGNoZWNrcy4g
U29tZSBvZiB0aGVtIGFjdHVhbGx5IGxhY2tlZCBhIGNoZWNrDQo+PiBmb3Igc2V0dGluZyBvdmVy
Zmxvd3MsIHdoaWNoIGNvdWxkIGhhdmUgcmVzdWx0ZWQgaW4gdW5kZXNpcmVkIHZhbHVlcyBiZWlu
ZyBzZXQuDQo+PiBUaGUgbmV3IGRlZmF1bHQgc2V0dGVycyBpbmNsdWRlIGEgY2hlY2sgZm9yIHRo
YXQsIG5vdCB1cGRhdGluZyB0aGUgdmFsdWVzIGluDQo+PiBjYXNlIG9mIGVycm9ycyAoYW5kIHBy
b3BhZ2F0aW5nIHRoZW0pLiBJZiB0aGV5IGRpZCBub3QgcHJvdmlkZSBhbiBlcnJvcg0KPj4gcG9p
bnRlciwgdGhlbiB0aGF0IGJlaGF2aW91ciB3YXMgbWFpbnRhaW5lZC4NCj4+IA0KPj4gRmVsaXBl
IEZyYW5jaW9zaSAoNCk6DQo+PiAgcW9tL29iamVjdDogZW5hYmxlIHNldHRlciBmb3IgdWludCB0
eXBlcw0KPj4gIGljaDk6IGZpeCBnZXR0ZXIgdHlwZSBmb3Igc2NpX2ludCBwcm9wZXJ0eQ0KPj4g
IGljaDk6IFNpbXBsaWZ5IGljaDlfbHBjX2luaXRmbg0KPj4gIHFvbS9vYmplY3Q6IFVzZSBjb21t
b24gZ2V0L3NldCB1aW50IGhlbHBlcnMNCj4+IA0KPj4gaHcvYWNwaS9pY2g5LmMgICAgICAgfCAg
OTkgKystLS0tLS0tLS0tLS0tLS0tLS0NCj4+IGh3L2FjcGkvcGNpaHAuYyAgICAgIHwgICA3ICst
DQo+PiBody9hY3BpL3BpaXg0LmMgICAgICB8ICAxMiArLS0NCj4+IGh3L2lzYS9scGNfaWNoOS5j
ICAgIHwgIDI3ICsrLS0tLQ0KPj4gaHcvbWlzYy9lZHUuYyAgICAgICAgfCAgMTMgKy0tDQo+PiBo
dy9wY2ktaG9zdC9xMzUuYyAgICB8ICAxNCArLS0NCj4+IGh3L3BwYy9zcGFwci5jICAgICAgIHwg
IDE4ICstLS0NCj4+IGh3L3BwYy9zcGFwcl9kcmMuYyAgIHwgICAzICstDQo+PiBpbmNsdWRlL3Fv
bS9vYmplY3QuaCB8ICA0NCArKysrKysrLS0NCj4+IG1lbW9yeS5jICAgICAgICAgICAgIHwgIDE1
ICstLQ0KPj4gcW9tL29iamVjdC5jICAgICAgICAgfCAyMTYgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLQ0KPj4gdGFyZ2V0L2FybS9jcHUuYyAgICAgfCAgMjIgKy0t
LS0NCj4+IHRhcmdldC9pMzg2L3Nldi5jICAgIHwgMTA2ICsrLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
Pj4gdWkvY29uc29sZS5jICAgICAgICAgfCAgIDQgKy0NCj4+IDE0IGZpbGVzIGNoYW5nZWQsIDI4
MiBpbnNlcnRpb25zKCspLCAzMTggZGVsZXRpb25zKC0pDQo+IA0KPiBJdCBjb25mbGljdHMgd2l0
aCBzb21lIHJlY2VudCBjaGFuZ2VzLCBzbyB5b3UnbGwgbmVlZCB0byBzZW5kIGEgbmV3DQo+IHZl
cnNpb24sIGJ1dCB0aGF0IG9uZSBsb29rcyBnb29kIHRvIG1lOg0KPiBSZXZpZXdlZC1ieTogTWFy
Yy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+DQo+IA0KPiBQYW9s
bywgaXMgaXQgZ29pbmcgdGhyb3VnaCB5b3VyIHF1ZXVlPw0KDQpJIGRpZG4ndCBzZWUgYW55IHJl
c3BvbnNlIGFmdGVyIHRoaXMuIERpZCB0aGUgc2VyaWVzIGdldCBsb3N0Pw0KDQpDaGVlcnMsDQpG
ZWxpcGUNCg0KPiANCj4+IA0KPj4gLS0NCj4+IDIuMjAuMQ0KPj4gDQo+PiBDaGFuZ2Vsb2c6DQo+
PiB2MS0+djI6DQo+PiAtIFVwZGF0ZSBzY2lfaW50IGRpcmVjdGx5IGluc3RlYWQgb2YgdXNpbmcg
c3RhY2sgdmFyaWFibGUNCj4+IC0gRGVmaW5pbmcgYW4gZW5oYW5jZWQgT2JqZWN0UHJvcGVydHlG
bGFncyBpbnN0ZWFkIG9mIGp1c3QgJ3JlYWRvbmx5Jw0KPj4gLSBFcnJvcmluZyBvdXQgZGlyZWN0
bHkgKGluc3RlYWQgb2YgdXNpbmcgZ290b3MpIG9uIGRlZmF1bHQgc2V0dGVycw0KPj4gLSBSZXRh
aW5pbmcgbGFjayBvZiBlcnJwIHBhc3Npbmcgd2hlbiBpdCB3YXNuJ3QgdGhlcmUNCj4+IHYyLT52
MzoNCj4+IC0gUmVuYW1lIGZsYWdzIF9SRCB0byBfUkVBRCBhbmQgX1dSIHRvIF9XUklURQ0KPj4g
LSBBZGQgYSBjb252ZW5pZW5jZSBfUkVBRFdSSVRFIGZsYWcNCj4+IC0gRHJvcCB0aGUgdXNhZ2Ug
b2YgVUwgaW4gdGhlIGJpdCBmbGFnIGRlZmluaXRpb25zDQo+PiB2My0+djQ6DQo+PiAtIERyb3Ag
Y2hhbmdlcyB0byBody92ZmlvL3BjaS1xdWlya3MuYw0KPiANCj4gDQo+IA0KPiAtLSANCj4gTWFy
Yy1BbmRyw6kgTHVyZWF1DQoNCg==

