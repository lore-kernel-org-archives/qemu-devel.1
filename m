Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39934C38A2A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 17:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F290620737
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 17:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="fitpGR8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F290620737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXpzB-0004zb-1c
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 13:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jXpy5-0003wD-4J
 for qemu-devel@nongnu.org; Sun, 10 May 2020 13:42:25 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:60732)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jXpy2-0005Gf-Ui
 for qemu-devel@nongnu.org; Sun, 10 May 2020 13:42:24 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04AHgJoX010320; Sun, 10 May 2020 10:42:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=BY7aZJZJu40/g2/s3O4ZKfGzbMtOVhu5xLgUncIvT2s=;
 b=fitpGR8RzYjC+y/ojrpxSPkd3X1NN0kipXmI2iI+E0dYFXIB8/pkhfKEbI0KzkrLClDc
 9n3QLmKfXBXpkDhdbFg7LInmrb7TJ9Rnpp/hmrNMh9vFLTvvRG/JHnYSLpwUV0FkjY0R
 uSo+dvY+SZBUoF8pBTPWhBlRJG/G60j7OFxNAO6uaYMVXD9EN/uClN3285Nads+f9DNG
 nt4sG2cT8FvTWxKpeM/U/4DKyr3wOMk1pVhE9kY45l3KHu8bVkfpQ6bKNxwIjS766fZA
 UvOGGgnI3Z24rxv3Rmv0Uyki/1NjGcF8cDrZAeNMcZO/F3NUKvRsyOvaflar4miAnXkZ eg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by mx0a-002c1b01.pphosted.com with ESMTP id 30wv2xsvuq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 10 May 2020 10:42:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLkandWyyC7/Kr2HJpeYofaac8AzurpRa3i1Mo8QiZbxk1+1vT6mOnQanR8tEnYj9Iry+VbfrJk+zNwjAjTQE9n0J6Eg9Wex3lD1rzakpm0ZHyQcmmDGzdWFRSve+F3aMj8HOM1b8tbCxJkx59q/3iaaRq8wafStv/pML8dGHjF7+IYeUagYf1YBlpj/QKYjktAaGRfuNhPWEhE8O/iAoemQrxGe5YXcmq/qqwUArmcWDL6btoyA/vI8BsyxSJo+s9OSFwWT2cslabHjIyPx1WBAQt0jOsQzqufxq+KfcOnHzUzfi3bDqg/5Ix51ijbb0ENDPqmw7Ey/8fTrUmp6rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BY7aZJZJu40/g2/s3O4ZKfGzbMtOVhu5xLgUncIvT2s=;
 b=HQCYLi5WbWXr3iZqFmPU7lYNQ5Ca/3mZV2SPjS720O+zj3rWOFVqfmXDrZITWpZL8r+eMm/O88unZzRhvMRTDazsqu05ySVhWJihhTrHt2Ut4XmB3nEVgylPpTPjnvwzvC5Ja9LzK+baMog2K5xk599aXvj1PPux53cLbImo3lhT4GtlEJYZRiafFSEovN5qnk4mKoxfuNARnU78As9hJtfCXM6FpYgyqRsb31449no7kx2LmaJ7mjTP/Do6t6WnpN5DzEq8gXpMbiRFiFpcZNkvfg5BM8tRIdeOVZbAlC9RQJtvZ36mAibPldaPdpR1UKjMYAmet7DigFtcMK1avQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB6686.namprd02.prod.outlook.com (2603:10b6:208:1d0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Sun, 10 May
 2020 17:42:16 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::317d:683f:b2:fa01]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::317d:683f:b2:fa01%7]) with mapi id 15.20.2979.033; Sun, 10 May 2020
 17:42:16 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Topic: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Index: AQHWFMrLeCs/JzKNrUaCDY3Nn1YJmqh9b9kAgAACaICAAAksAIAERh2AgABeQwCAAY19AIAABL+AgAFKiACAA3KSgIAAOCMAgAemCgCAEW3HgA==
Date: Sun, 10 May 2020 17:42:16 +0000
Message-ID: <B4E56027-03A4-48DA-ACE1-73B2811528E5@nutanix.com>
References: <1587136411-200885-1-git-send-email-ani.sinha@nutanix.com>
 <20200417112620-mutt-send-email-mst@kernel.org>
 <2A13ACCD-BD24-41FB-B6EA-2804F7C1FF1D@nutanix.com>
 <20200417120732-mutt-send-email-mst@kernel.org>
 <20200420092459.GF346737@redhat.com>
 <20200420105936-mutt-send-email-mst@kernel.org>
 <07BC06B8-34F6-4C46-ACCE-DD7A4CBA9BC7@nutanix.com>
 <20200421150201.GI479771@redhat.com>
 <A31A7DC2-E1FB-409B-9A99-324F8879E9AD@nutanix.com>
 <819DA747-F897-44A4-A238-B6F20C4C8B08@nutanix.com>
 <20200424184448.GS4952@habkost.net> <20200429173254.58c8582f@redhat.com>
In-Reply-To: <20200429173254.58c8582f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [192.146.154.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5593f41b-7712-40ca-0444-08d7f5097b1c
x-ms-traffictypediagnostic: MN2PR02MB6686:
x-microsoft-antispam-prvs: <MN2PR02MB66861099568987D08982C002F1A00@MN2PR02MB6686.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 039975700A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hc3Nt8PYZgifZvFDdp7vswboPjfSUlTrrv5AXGvle2u5mwYV/1iNSBiYPqnyeoyd6qzw4dxHrE804eGdMwJRiO9pL76QMNjmBkEc0KeWzHslj/vmDI5lYEGrFs8WryBfKkWOq3k5KMTTqeHqR9Hpx9zDlPQNH5U0+7bMLzg9Ow1/rG/iUqPd3THClW9zPTQDLzjkkRHqLb2jX/MwaasmCMz2llEJlaMnPdnPwz0d/7LoQJKUQtoTvI+Ao7wsZJ1F/ekjdHpnZXpNoLL5E4F580/4CyacPmQEy46qg/0YBoiN0H0ysIdU8TK0cSvejyu0lqmRLYnntpTpenPXVJfZvQcu9QAEhJ7RK949pcu1hdxjU7dR5EkZ4sEX00bfSxUWq4HquZCOG6N3nOsvSyyujRfmf3BydsCfRxQlRD0qP37zr69dfJY1AmjPJ8c64yX8Sv0F/DEzhDLmwXjapLGAQNKSQT81M/eJAbYiFLwRsxNmmUq9Mo0ZwfoExgfcAh6qhhK/Oh1S0I1iI9uLrhCfnw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(396003)(39850400004)(366004)(376002)(136003)(33430700001)(26005)(33440700001)(54906003)(33656002)(8676002)(6512007)(316002)(44832011)(4326008)(8936002)(5660300002)(6486002)(71200400001)(2616005)(186003)(53546011)(6506007)(64756008)(66556008)(478600001)(6916009)(76116006)(2906002)(66946007)(86362001)(66476007)(66446008)(36756003)(91956017);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: jP1GlLeolHkSLvEdUjPWxTK2TIlnfwLsFR1uK/tlaOjC+w8KNeOu2DG8qND72SVAMdvg1aSZbDphe8PczyJLhMNliqz3oDyrmc7VZ+y/e4ZV5gV930kmkTLbhke13/AQNGmnNVzZ92AY6Ydj4sl/NkzAOD59YkXpC/Ch5OjF7XQwT72wZtA9AtQfm57mGHU1Xmf9Zd6yqgyJZHbJ2ii57tMxwbDx1R1267ZceyCepJsobR4/6s+tqNUQqOuAzVYP8u/rlaSifi9yKXyrelUklrI/Tk7Whs3mhctTHkS1jbwE4S1q9AtOYoFDK1PLIkWiFEw//EjGqA0mB9Q3Hy7CXcxNKOsNiiBHS60G+ANHKN5/n2DgcG3MYSjVuoy4yZesoB+9nJh/hl7EpbIvSMUikxZjdhDBdySSDbcMe3eML31ic4IVCLT5/pEWnETUU/HYLAx/yllrzFgpARIRa0c7wv/XovEYMK4MR7goeqKPgvE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <394655AA9DCB9F4EA52EE616E5F4AED5@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5593f41b-7712-40ca-0444-08d7f5097b1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2020 17:42:16.2750 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NRpzIXGWh0yyih4RxbzYvtLOpWsa12paqqmk49WMAMrJC8MAKQR0abSxjUkC1fFqp2N7jArkTa9S5W71surJig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6686
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-10_08:2020-05-08,
 2020-05-10 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=ani.sinha@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/10 13:42:19
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 KHOP_DYNAMIC=0.001, RCVD_IN_DNSWL_LOW=-0.7, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gT24gQXByIDI5LCAyMDIwLCBhdCA5OjAyIFBNLCBJZ29yIE1hbW1lZG92IDxpbWFtbWVk
b0ByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgMjQgQXByIDIwMjAgMTQ6NDQ6NDgg
LTA0MDANCj4gRWR1YXJkbyBIYWJrb3N0IDxlaGFia29zdEByZWRoYXQuY29tPiB3cm90ZToNCj4g
DQo+PiBPbiBGcmksIEFwciAyNCwgMjAyMCBhdCAwMzoyMzo1NlBNICswMDAwLCBBbmkgU2luaGEg
d3JvdGU6DQo+Pj4gDQo+Pj4gDQo+Pj4+IE9uIEFwciAyMiwgMjAyMCwgYXQgNDoxNSBQTSwgQW5p
IFNpbmhhIDxhbmkuc2luaGFAbnV0YW5peC5jb20+IHdyb3RlOg0KPj4+PiANCj4+Pj4gDQo+Pj4+
IA0KPj4+Pj4gT24gQXByIDIxLCAyMDIwLCBhdCA4OjMyIFBNLCBEYW5pZWwgUC4gQmVycmFuZ8Op
IDxiZXJyYW5nZUByZWRoYXQuY29tPiB3cm90ZToNCj4+Pj4+IA0KPj4+Pj4gT24gVHVlLCBBcHIg
MjEsIDIwMjAgYXQgMDI6NDU6MDRQTSArMDAwMCwgQW5pIFNpbmhhIHdyb3RlOiAgDQo+Pj4+Pj4g
DQo+Pj4+Pj4gDQo+Pj4+Pj4+IE9uIEFwciAyMCwgMjAyMCwgYXQgODozMiBQTSwgTWljaGFlbCBT
LiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6DQo+Pj4+Pj4+IA0KPj4+Pj4+PiBCdXQg
SSBmb3Igb25lIHdvdWxkIGxpa2UgdG8gZm9jdXMgb24ga2VlcGluZyBQSUlYIHN0YWJsZQ0KPj4+
Pj4+PiBhbmQgZm9jdXMgZGV2ZWxvcG1lbnQgb24gcTM1LiAgTm90IGJsb2F0aW5nIFBJSVggd2l0
aCBsb3RzIG9mIG5ldw0KPj4+Pj4+PiBmZWF0dXJlcyBpcyBJTUhPIGEgZ29vZCB3YXkgdG8gZG8g
dGhhdC4gIA0KPj4+Pj4+IA0KPj4+Pj4+IERvZXMgdGhpcyBtZWFuIHRoaXMgcGF0Y2ggaXMgYSBu
by1nbyB0aGVuPyA6KCAgDQo+Pj4+PiANCj4+Pj4+IEknZCBzdXBwb3J0IHRoaXMgcGF0Y2gsIGFz
IEkgZG9uJ3QgdGhpbmsgaXQgY2FuIHJlYWxseSBiZSBkZXNjcmliZWQgYXMNCj4+Pj4+IGJsb2F0
IG9yIGRlc3RhYmFsaXppbmcuIEl0IGlzIGp1c3QgYWRkaW5nIGEgc2ltcGxlIHByb3BlcnR5IHRv
DQo+Pj4+PiBjb25kaXRpb25hbGl6ZSBleGlzdGluZyBmdW5jdGlvbmFsaXR5LiAgVGVsbGluZyBw
ZW9wbGUgdG8gc3dpdGNoIHRvIFEzNQ0KPj4+Pj4gaXMgdW5yZWFzb25hYmxlIGFzIGl0IGlzIG5v
dCBhIHNpbXBsZSAxLTEgY29udmVyc2lvbiBmcm9tIGV4aXN0aW5nIHVzZQ0KPj4+Pj4gb2YgUElJ
WC4gUTM1IGhhcyBtdWNoIGhpZ2hlciBjb21wbGV4aXR5IGluIGl0cyBjb25maWd1cmF0aW9uLCBo
YXMgaGlnaGVyDQo+Pj4+PiBtZW1vcnkgb3ZlcmhlYWQgcGVyIFZNIHRvbywgYW5kIGxhY2tzIGNl
cnRhaW4gZmVhdHVyZXMgb2YgUElJWCB0b28uICANCj4+Pj4gDQo+Pj4+IENvb2wuIEhvdyBkbyB3
ZSBnbyBmb3J3YXJkIGZyb20gaGVyZT8NCj4+Pj4gDQo+Pj4gDQo+Pj4gV2Ugd291bGQgcmVhbGx5
IGFwcHJlY2lhdGUgaWYgd2UgY2FuIGFkZCB0aGlzIGV4dHJhIGtub2IgaW4NCj4+PiBRZW11LiBN
YXliZSBzb21lb25lIGVsc2UgYWxzbyBpbiB0aGUgY29tbXVuaXR5IHdpbGwgZmluZCB0aGlzDQo+
Pj4gdXNlZnVsLiBXZSBkb27igJl0IHdhbnQgdG8gbWFpbnRhaW4gdGhpcyBwYXRjaCBpbnRlcm5h
bGx5IGZvcmV2ZXINCj4+PiBidXQgcmF0aGVyIHByZWZlciB3ZSBtYWludGFpbiB0aGlzIGFzIGEg
UWVtdSBjb21tdW5pdHkuICANCj4+IA0KPj4gTWljaGFlbCwgSSBhZ3JlZSB3aXRoIERhbmllbCBo
ZXJlIGFuZCBJIGRvbid0IHRoaW5rIHdlIHNob3VsZA0KPj4gc3RhcnQgcmVmdXNpbmcgUElJWCBm
ZWF0dXJlcyBpZiB0aGV5IGFyZSB1c2VmdWwgZm9yIGEgcG9ydGlvbiBvZg0KPj4gdGhlIFFFTVUg
Y29tbXVuaXR5Lg0KPj4gDQo+PiBXb3VsZCB5b3UgcmVjb25zaWRlciBhbmQgbWVyZ2UgdGhpcyBw
YXRjaD8NCj4gDQo+IEkgcHV0IHRoaXMgcGF0Y2ggb24gbXkgcmV2aWV3IHF1ZXVlIChob3BlZnVs
bHkgbmV4dCB3ZWVrIEknZCBiZSBhYmxlIHRvIGdldCB0byBpdCkNCg0KQW55IHByb2dyZXNzPw0K
DQo=

