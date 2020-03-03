Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B11C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 08:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B614820CC7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 08:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="XM6Si580"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B614820CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j92ZY-00051t-To
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 03:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1j92Yo-0004V5-Pj
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1j92Yn-0001CP-1J
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:05:50 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:44416)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1j92Ym-0001C8-O1
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:05:48 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02384XcQ006401; Tue, 3 Mar 2020 00:05:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=K0XCbdnmiq9glBFZmQ8NPm+p8hVGMqVWidV3IbfMMDk=;
 b=XM6Si5807BhQDCS/zxhYpe6TAR+9HOw0PNSSRNONkt2lqg4ev5GIfcnXYJBsZxePO2Lh
 PKlyqNBGvy3KnMwtEZaF1tCerj7i2rTdeHUF/Q53MstBJwfpUIwNKmc34Rxbs12G7l4p
 wA06b0V7we6Yv3roAzj18lNaG10o5tOh+pCENEoZlc7G8HxbqkNDU9MoyNYCjOYK+GEs
 izw0DAx4EvIpX5v3ONA+BfZQFY1lnOV8ofD7rncUy2p+6POVygxJyO4OTmakoFh+C1b3
 CYb8iilRLri3bRzrleSQ2P3181U2SVYgsE1FWdnElWXueMkfQZH4RgkijwTID8E87PTf tQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2yfqwnp6je-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Mar 2020 00:05:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1wBVZxCXMmL1o5NxqT4g4/iZpu7nSXSp78t9wNrUQBo7PzdtYDWqrVRbBkgoqNtQUaJ2orVu+EFjt5HLWofXYysz4Tcla2e7MY/bM8aw4EOuApzVVCjqRtRiTsUpjunrx+uKSheVoxepZDPwdnYKHK2BfJ0P7W+EDXXh8j8pYNtW4X6qYtbPj7IXRpB0NNKYOacTRvqT5qkYhI79xXipE/6X6By4Dfai2+NiuON51/ivZPhHiSWpHirJ0AdEk2zcw18tm/2p3tCSzBx7AqNQ2nQmyAR2cOI7AAcFFSF6/J0yF6mU7WQMPtUVBSUIcfBIuvlJUZoE3SZHrUDjkDt0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0XCbdnmiq9glBFZmQ8NPm+p8hVGMqVWidV3IbfMMDk=;
 b=kw86GfRM8UJqvyEi8Ics0vXGXa6mu2Hbf19G46Q/zphyAvnDJasw3vqwF78K7PwCp0bqBYU/xsqexXUe45Ei1qqJjHFMf/4vvw0AhdW9bEdUBbp5dtHGfbpwXuezLDrbLtvWmMdHl0HVZOfqp7gxcUc5QR5UDpWiTmHHcd3zY2uChy3eX0QT0tNEQNFXFesjgEOnUxVmOgyRgrKJuYzj3EldK0CS9zz8U4Cb4HgGNfC4Cyaf3t4kWe4AA8Gnzo1w1jr4qwFF/+V9AkjAX2wC4TNs9R8eErWAU+kN7+IGMR5fmrHjxZovvdgTCMpNSM30YG03JRuGMTLcwKktAvm7Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (2603:10b6:300:45::14)
 by MWHPR02MB3150.namprd02.prod.outlook.com (2603:10b6:301:61::38)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Tue, 3 Mar
 2020 08:05:44 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c4c8:b406:7827:8a2b]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c4c8:b406:7827:8a2b%6]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 08:05:44 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 0/4] Improve default object property_add uint helpers
Thread-Topic: [PATCH v6 0/4] Improve default object property_add uint helpers
Thread-Index: AQHV211IMbV0oM7QCkSeM+CVGLRnMKgLCu6AgCujaYA=
Date: Tue, 3 Mar 2020 08:05:44 +0000
Message-ID: <64CA08E4-01C2-4BB8-B2B0-163406E1CD6F@nutanix.com>
References: <20200204131601.125677-1-felipe@nutanix.com>
 <CAJ+F1CJLvKtSnFFurBUy4LcP+DqNTtqHd4oevJADfW8JEVuXXA@mail.gmail.com>
In-Reply-To: <CAJ+F1CJLvKtSnFFurBUy4LcP+DqNTtqHd4oevJADfW8JEVuXXA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86955b1b-c97a-404c-8240-08d7bf49acb8
x-ms-traffictypediagnostic: MWHPR02MB3150:
x-microsoft-antispam-prvs: <MWHPR02MB315045A1636E2B55EEBBC540D7E40@MWHPR02MB3150.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(376002)(39860400002)(136003)(346002)(189003)(199004)(478600001)(6486002)(4326008)(26005)(8936002)(8676002)(81166006)(53546011)(966005)(36756003)(6512007)(186003)(6506007)(86362001)(81156014)(71200400001)(33656002)(316002)(110136005)(54906003)(2616005)(66556008)(66476007)(91956017)(66946007)(64756008)(76116006)(66446008)(2906002)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB3150;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Np9PxqBRExDseDqHp71l5/YwlNf5gJc/4O2y+kOorGeHTa+xKTKuwIEGlTcoElFeW9Y+JIShF/a/SSvbZSt4+ZCCRHc68gm/XQUlnuVrT1RGV4hOsKPfefGpbXhFMq0d005aUvnFNksm61YvYRUZ8s8w6qHkbtaPbOkQLoaA9GDnLPl1kUf8x0iE3ZY8Ad6VtmEowOIqAiFf9vru4gHDzKOkP+WGFLlgOZmariGRN5lENtYDKPK8K7Y9nmkHE0CXGXqRDFjK3C1F2v4nIz6cYJHM5h/ChtLckIyHxaSn9pMpJhUZBlzt4Z8FDVn9QzqHpqvahLoyu7dATMzrvOnsg+0Qhqh4MnKxp5ryBsEw/r/RTZvJfTLErWuGGox1SaocDlriRxNko/+DFb+P5nBHXmjcq6OVyp0LIP5DJkxgUIBUOSpkF1q5UTVCiStXB3C+06WMP0bN9ItcTb9WjNPFocJ2CxiMjyMPcZkrs0D8S1xdN+Gq9yd7IFWRFOURSiqflM0KHEtIpS+t889qEv1omQ==
x-ms-exchange-antispam-messagedata: E/8ZpZ0rEVMGBsJYV7dS8fXENEkiOT0CL+rgegwoLIppYyjxYGNu1Z9a4sgQoNfXaZQbX1WG8CvbmomNbaubvjZmShYcyg5PyqQIvshGOpfrVc5y0b3WhTlMHHu5+zjhbWLYbs7hl7IKK85ZcYgI6g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <37A0FA4171DB384D8971D89C9660BA53@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86955b1b-c97a-404c-8240-08d7bf49acb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 08:05:44.6256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tkI0BSwplqNN8gN9mhFwEDc18cSmqlsjF1iq6v7TWsl2FdRV06+vR9Xz94SrDbqtldLlAHmDVyCLCskKqLt2dJE9nGl7hvLIU1dIUg6JCN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3150
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-03_02:2020-03-03,
 2020-03-03 signatures=0
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
 QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Phillipe Mathieu-Daude <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgTWFyYy9QYW9sbywNCg0KPiBPbiBGZWIgNCwgMjAyMCwgYXQgMTo0MSBQTSwgTWFyYy1BbmRy
w6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBIaQ0K
PiANCj4gT24gVHVlLCBGZWIgNCwgMjAyMCBhdCAyOjE2IFBNIEZlbGlwZSBGcmFuY2lvc2kgPGZl
bGlwZUBudXRhbml4LmNvbT4gd3JvdGU6DQo+PiANCj4+IFRoaXMgaW1wcm92ZXMgdGhlIGZhbWls
eSBvZiBvYmplY3RfcHJvcGVydHlfYWRkX3VpbnRYWF9wdHIgaGVscGVycyBieSBlbmFibGluZw0K
Pj4gYSBkZWZhdWx0IGdldHRlci9zZXR0ZXIgb25seSB3aGVuIGRlc2lyZWQuIFRvIHByZXZlbnQg
YW4gQVBJIGJlaGF2aW91cmFsIGNoYW5nZQ0KPj4gKGZyb20gY2xpZW50cyB0aGF0IGFscmVhZHkg
dXNlZCB0aGVzZSBoZWxwZXJzIGFuZCBkaWQgbm90IHdhbnQgYSBzZXR0ZXIpLCB3ZQ0KPj4gYWRk
IGEgT0JKX1BST1BfRkxBR19SRUFEIGZsYWcgdGhhdCBhbGxvdyBjbGllbnRzIHRvIG9ubHkgaGF2
ZSBhIGdldHRlci4gUGF0Y2ggMQ0KPj4gZW5oYW5jZXMgdGhlIEFQSSBhbmQgbW9kaWZ5IGN1cnJl
bnQgdXNlcnMuDQo+PiANCj4+IFdoaWxlIG1vZGlmeWluZyB0aGUgY2xpZW50cyBvZiB0aGUgQVBJ
LCBhIGNvdXBsZSBvZiBpbXByb3ZlbWVudCBvcHBvcnR1bml0aWVzDQo+PiB3ZXJlIG9ic2VydmVk
IGluIGljaDkuIFRoZXNlIHdlcmUgYWRkZWQgaW4gc2VwYXJhdGUgcGF0Y2hlcyAoMiBhbmQgMyku
DQo+PiANCj4+IFBhdGNoIDQgY2xlYW5zIHVwIGEgbG90IG9mIGV4aXN0aW5nIGNvZGUgYnkgbW92
aW5nIHZhcmlvdXMgb2JqZWN0cyB0byB0aGUNCj4+IGVuaGFuY2VkIEFQSS4gUHJldmlvdXNseSwg
dGhvc2Ugb2JqZWN0cyBoYWQgdGhlaXIgb3duIGdldHRlcnMvc2V0dGVycyB0aGF0IG9ubHkNCj4+
IHVwZGF0ZWQgdGhlIHZhbHVlcyB3aXRob3V0IGZ1cnRoZXIgY2hlY2tzLiBTb21lIG9mIHRoZW0g
YWN0dWFsbHkgbGFja2VkIGEgY2hlY2sNCj4+IGZvciBzZXR0aW5nIG92ZXJmbG93cywgd2hpY2gg
Y291bGQgaGF2ZSByZXN1bHRlZCBpbiB1bmRlc2lyZWQgdmFsdWVzIGJlaW5nIHNldC4NCj4+IFRo
ZSBuZXcgZGVmYXVsdCBzZXR0ZXJzIGluY2x1ZGUgYSBjaGVjayBmb3IgdGhhdCwgbm90IHVwZGF0
aW5nIHRoZSB2YWx1ZXMgaW4NCj4+IGNhc2Ugb2YgZXJyb3JzIChhbmQgcHJvcGFnYXRpbmcgdGhl
bSkuIElmIHRoZXkgZGlkIG5vdCBwcm92aWRlIGFuIGVycm9yDQo+PiBwb2ludGVyLCB0aGVuIHRo
YXQgYmVoYXZpb3VyIHdhcyBtYWludGFpbmVkLg0KPj4gDQo+PiBGZWxpcGUgRnJhbmNpb3NpICg0
KToNCj4+ICBxb20vb2JqZWN0OiBlbmFibGUgc2V0dGVyIGZvciB1aW50IHR5cGVzDQo+PiAgaWNo
OTogZml4IGdldHRlciB0eXBlIGZvciBzY2lfaW50IHByb3BlcnR5DQo+PiAgaWNoOTogU2ltcGxp
ZnkgaWNoOV9scGNfaW5pdGZuDQo+PiAgcW9tL29iamVjdDogVXNlIGNvbW1vbiBnZXQvc2V0IHVp
bnQgaGVscGVycw0KPj4gDQo+PiBody9hY3BpL2ljaDkuYyAgICAgICB8ICA5OSArKy0tLS0tLS0t
LS0tLS0tLS0tLQ0KPj4gaHcvYWNwaS9wY2locC5jICAgICAgfCAgIDcgKy0NCj4+IGh3L2FjcGkv
cGlpeDQuYyAgICAgIHwgIDEyICstLQ0KPj4gaHcvaXNhL2xwY19pY2g5LmMgICAgfCAgMjcgKyst
LS0tDQo+PiBody9taXNjL2VkdS5jICAgICAgICB8ICAxMyArLS0NCj4+IGh3L3BjaS1ob3N0L3Ez
NS5jICAgIHwgIDE0ICstLQ0KPj4gaHcvcHBjL3NwYXByLmMgICAgICAgfCAgMTggKy0tLQ0KPj4g
aHcvcHBjL3NwYXByX2RyYy5jICAgfCAgIDMgKy0NCj4+IGluY2x1ZGUvcW9tL29iamVjdC5oIHwg
IDQ4ICsrKysrKysrLS0NCj4+IG1lbW9yeS5jICAgICAgICAgICAgIHwgIDE1ICstLQ0KPj4gcW9t
L29iamVjdC5jICAgICAgICAgfCAyMTIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0tLQ0KPj4gdGFyZ2V0L2FybS9jcHUuYyAgICAgfCAgMjIgKy0tLS0NCj4+IHRhcmdl
dC9pMzg2L3Nldi5jICAgIHwgMTA2ICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+IHVpL2NvbnNv
bGUuYyAgICAgICAgIHwgICA0ICstDQo+PiAxNCBmaWxlcyBjaGFuZ2VkLCAyODIgaW5zZXJ0aW9u
cygrKSwgMzE4IGRlbGV0aW9ucygtKQ0KPiANCj4gU2VyaWVzOg0KPiBSZXZpZXdlZC1ieTogTWFy
Yy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+DQo+IA0KPiBQYW9s
bywgd291bGQgeW91IHF1ZXVlIGl0Pw0KDQpQaW5nOiBkaWQgdGhpcyBnZXQgbG9zdD8NCg0KRi4N
Cg0KPiANCj4+IA0KPj4gLS0NCj4+IDIuMjAuMQ0KPj4gDQo+PiBDaGFuZ2Vsb2c6DQo+PiB2MS0+
djI6DQo+PiAtIFVwZGF0ZSBzY2lfaW50IGRpcmVjdGx5IGluc3RlYWQgb2YgdXNpbmcgc3RhY2sg
dmFyaWFibGUNCj4+IC0gRGVmaW5pbmcgYW4gZW5oYW5jZWQgT2JqZWN0UHJvcGVydHlGbGFncyBp
bnN0ZWFkIG9mIGp1c3QgJ3JlYWRvbmx5Jw0KPj4gLSBFcnJvcmluZyBvdXQgZGlyZWN0bHkgKGlu
c3RlYWQgb2YgdXNpbmcgZ290b3MpIG9uIGRlZmF1bHQgc2V0dGVycw0KPj4gLSBSZXRhaW5pbmcg
bGFjayBvZiBlcnJwIHBhc3Npbmcgd2hlbiBpdCB3YXNuJ3QgdGhlcmUNCj4+IHYyLT52MzoNCj4+
IC0gUmVuYW1lIGZsYWdzIF9SRCB0byBfUkVBRCBhbmQgX1dSIHRvIF9XUklURQ0KPj4gLSBBZGQg
YSBjb252ZW5pZW5jZSBfUkVBRFdSSVRFIGZsYWcNCj4+IC0gRHJvcCB0aGUgdXNhZ2Ugb2YgVUwg
aW4gdGhlIGJpdCBmbGFnIGRlZmluaXRpb25zDQo+PiB2My0+djQ6DQo+PiAtIERyb3AgY2hhbmdl
cyB0byBody92ZmlvL3BjaS1xdWlya3MuYw0KPj4gdjQtPnY1Og0KPj4gLSBSZWJhc2Ugb24gbGF0
ZXN0IG1hc3Rlcg0KPj4gLSBBdmFpbGFibGUgaGVyZTogaHR0cHM6Ly9naXRodWIuY29tL2ZyYW5j
aW96enkvcWVtdS90cmVlL2F1dG9zZXR0ZXJzDQo+PiB2NS0+djY6DQo+PiAtIEZpeCBidWlsZCBl
cnJvciBpbnRyb2R1Y2VkIGluIHJlYmFzZQ0KPiANCj4gDQo+IA0KPiAtLSANCj4gTWFyYy1BbmRy
w6kgTHVyZWF1DQoNCg==

