Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77238C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:50:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DF742076B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="ZQ0m9kfa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF742076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThTk-0000U4-Dg
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jThQR-0005tG-Ob
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jThNI-0007si-DX
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:46:35 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:58510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jThNH-0007sY-MA
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:43:20 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03T7WPD6010013; Wed, 29 Apr 2020 00:43:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=qO+QwzLEXcL2lT5+9dMym8WCcWPtCarPfZ2aOPyK+uU=;
 b=ZQ0m9kfaqnPgZSCHaGIN1HWXU5uLw16pB+R8PYxcFHbMqvciJDFDNhMQd6b9hAime9iO
 gT4OxDS98Yc7E3iEy3Ub3FnCYAPM4vt45fk6fn3BorZIaJIJ/2MSPTIcRDizPZaqAzVw
 hhV/iIEZrcjvrnA8lDxKgQQILNEMdaTN4K6UIG0KuV6HgI2t19sebJSKKJX/YOjEc2vz
 i/vVszUwfsh6tkMhr5/3V0sv9Wyinl+9Rbg2/0DpTFIx1qjwjeqrZdbl7nzF6KEbkGKo
 EB9vpV7bcVbZ+h7UTUtGkOtkM4Gst3GpjzA+pDVCa9gTYOIH7CM5zvb7XdWdXvZ/YQBU WA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
 by mx0b-002c1b01.pphosted.com with ESMTP id 30mmhj84xd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2020 00:43:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URuGYrJhnxUxwLJ8jY06dnthx730/QS5iHH4KUC51+lpoiY2b+QvuFgdmA3wVX8b1pHhyGRNLPfYfAxh2wIwoqF3xJL+84C05saalwpzMDz6bekXTEr3IFrDZF+RGUqb3CkBjZzcnUqqSKcbv0/QZfrqbtXQF103XWa3vLGepw5Jar78n59vVeHyDqzLfuPNja07FvUabN/lnsc6jguL5Oz7sX3+JWI6J3FiN1W8k5R/utyjLWpm4LCSjHQCiPIcZKk/aWRENvmW4P+grJwi/5cXvAqmqAvKWIPD1q62BUY2f0RD/0e1cTfTekTKy3UoSiphSqTEs4lrhelEmLqb/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qO+QwzLEXcL2lT5+9dMym8WCcWPtCarPfZ2aOPyK+uU=;
 b=Cf5kkwoweTbUOg4kB3weUQy+oiwxsBMjXYq1+8L9s68qB4HodffPw3dl8yuwTSPngqgql4ghaMmkK0TsuWeiJLLJNbypzIe0t6FvRMVAHaXLeuYKpK5lBNqwhMglsikMCup3ro2f6CRcZrVLC5VgpVHxsCuMqTfLpAmFjIjVPqT2R362c5gca17UaJLRhVEptBAr6ajrVoxLGatR1LW2BMKCGmp7Pc2mjosp0/7OBK9T4HmqLrXILXKVia/ItFOySNP5+M9fKdshQ30Njjizp3VmHfSoohQ1KVbp6eiYf7lnHwCQ64gQ5tSehVmX4/Bz4Mm1QPZPM8RutLhbN1OUrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB7104.namprd02.prod.outlook.com (2603:10b6:208:1f5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 07:43:05 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a%7]) with mapi id 15.20.2937.028; Wed, 29 Apr 2020
 07:43:05 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Topic: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Thread-Index: AQHWHUYvMyDNYIpa20C9378Nh0w8t6iOszWAgAAA+QCAAANNgIAABV8AgABEbYCAAEbYAIAASz+AgAAMEQCAAAuhAIAAAIgAgAAAq4CAAAGWAIAACeGAgAABVgA=
Date: Wed, 29 Apr 2020 07:43:04 +0000
Message-ID: <D4141715-B662-407A-8B4D-0EB64B41F6A1@nutanix.com>
References: <20200428121837-mutt-send-email-mst@kernel.org>
 <CAARzgwwTo+r9xFge_XL_eu8-nsRFBFXEaQmTOhT1YHJifzfCJA@mail.gmail.com>
 <20200428164428-mutt-send-email-mst@kernel.org>
 <CAARzgwznhCPhGmwOxUBf_6bnFX7-Za7TxFMd999CARM+hDm8bA@mail.gmail.com>
 <20200429011228-mutt-send-email-mst@kernel.org>
 <544B4749-9A1C-44BB-BD89-C37A7E8D86F4@nutanix.com>
 <20200429025200-mutt-send-email-mst@kernel.org>
 <A69272ED-DDFF-4CC7-B12C-2994B004C013@nutanix.com>
 <20200429025535-mutt-send-email-mst@kernel.org>
 <B5DF1405-B261-4CE4-8484-F3738BE83E14@nutanix.com>
 <20200429033657-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200429033657-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [192.146.154.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9abf244-daad-4217-e284-08d7ec10f3cf
x-ms-traffictypediagnostic: MN2PR02MB7104:
x-microsoft-antispam-prvs: <MN2PR02MB710412FFC58C175EC477E981F1AD0@MN2PR02MB7104.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39860400002)(346002)(396003)(366004)(376002)(136003)(6506007)(53546011)(8676002)(33656002)(316002)(6512007)(4326008)(186003)(26005)(478600001)(966005)(6486002)(8936002)(86362001)(54906003)(2906002)(64756008)(36756003)(66946007)(66446008)(66476007)(66556008)(71200400001)(2616005)(7416002)(5660300002)(44832011)(6916009)(76116006)(91956017);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YBZ+l4LIWUNDnijYsvVJ3ApjxZLqY8jGM/vTJtfk+yioiN8IjU7GcuvZQLb9zZdTlGKQyTt0S3EIVC2dmj5s/t4Dd0nnS2g38iAEci5YyC6J/hfxcNpF693XOjQLbMXyfuslzfauVnNbDFsUUjubgTFbGnJAQrsgpbi4FR07XTLiY4SZgDWG1MtkASZNcC2GasM4dcectTQrhdpzLaVAPKuPHKv8V2/EBOdPirPdki2Na/JfliEgHmW0vCUxAwbFPYXLTZjroIkTpaO1bEknayEXVL41mTDMCUyTFbRETh8nMrd2lLkhiwXJkJdVVy+fdxuH3sjJ8hwOuEBcYnaOB/R/k0/7XTLcyeUjIMOniffrchtlaJCxtMHEP8iouqJQfsbuE70gLNon4o9ZUvMFb2TuAIZ3kDSxGJkhlA/vBaJSDYKwXTaNoLAhPhfL79NzkOMPoYgm3HTIsAWT4/DkVoRIjZ7DYsFPV8haAyunu1W42taGtvTYzKttUr0EF+LyfzE2ZbDyhwrVanku1N3W9A==
x-ms-exchange-antispam-messagedata: xd/fGW6vqumIvMatekT0dUEhPp7qyuEIrVqb9Lnv0OnkUeEI0LJzNOzuJmtcsAr1KpJ92BBWdXgvwPDnZrc3GuEBpfS63xAAFBb7vm0DAHrhP9u3R8tf7O/AuklVoxq10LNFB7H0YLvc1BXhhQSC8x8sTnHh/rsPWiWBfTslg+zT6XgwIFPDRKVCQH5PN50C+B+WefqZqgrZPy4k2GWlJYx1jNsNfBXk4jWFHH7AGz261zW6Q68LRmkqPjkFuiMqEshWQdXnHviB0vE3/79afuMkn+9gyfbS5Ba9tEQkkZlJ2tksw73pLe9+JWJeNk7OBEjg3pRk+gJYAgIrFWfu+VAnyVvufeCurGHv8N6J9KSKBc1YxkkVsxxHCncYkCRV8hE6B2R/VD+TfHtPruxycAlPxqtmaZ7Sm3o4QuU4XDxoKLQcXV6yOk7dF7+oYl8UMSr+/WDJLBrrLUcNM+BKP3rBu7Q2tu49SKa//mZapTbSPUXDZ4uvmqCQtiwrBjVZHMd2FDwemFCC/e79SbueAp4dVA4zHSe4y5u2mOulsDnRYUAPlESkYOOUIlNBFnmfrzr35zb8v4Dmj+dlzc7/l3hubGhfOsMOEmMtPPBzO6eeJMAJojX3eyQMkT6gh25WcnBGGf71kO6vv1rvEoqsWzEv5UU5CfJ5b4sF1DzjX26W1BvHb9tQnoRACFeolGEKoOYuH50oivn8+4JqFiHGsPWHr+mN7R7jxeRzdPyiPI3SsvxWTdUEvhr9nS6RV/8tVdQVAgAw11WYxWWLjEDBFDxgV2UgVQMXL9Et1e3aNbI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F8432A53F898E42A46F371C07500816@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9abf244-daad-4217-e284-08d7ec10f3cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 07:43:04.8484 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yV9VlZIEwOypmU7LHU9vWHiZB9cStZlOsT/S3jgtPhOXXdI7o+PJ40CMVjCTdlLzxTFrpJwY1GO4kdlkb7xscA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7104
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-29_02:2020-04-28,
 2020-04-29 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=ani.sinha@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 02:11:36
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Received-From: 148.163.155.12
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gT24gQXByIDI5LCAyMDIwLCBhdCAxOjA4IFBNLCBNaWNoYWVsIFMuIFRzaXJraW4gPG1z
dEByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgQXByIDI5LCAyMDIwIGF0IDA3OjAy
OjU2QU0gKzAwMDAsIEFuaSBTaW5oYSB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gQXByIDI5LCAy
MDIwLCBhdCAxMjoyNyBQTSwgTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3Jv
dGU6DQo+Pj4gDQo+Pj4gT24gV2VkLCBBcHIgMjksIDIwMjAgYXQgMDY6NTQ6NTJBTSArMDAwMCwg
QW5pIFNpbmhhIHdyb3RlOg0KPj4+PiANCj4+Pj4gDQo+Pj4+PiBPbiBBcHIgMjksIDIwMjAsIGF0
IDEyOjIyIFBNLCBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToNCj4+
Pj4+IA0KPj4+Pj4gT24gV2VkLCBBcHIgMjksIDIwMjAgYXQgMDY6MTE6MjBBTSArMDAwMCwgQW5p
IFNpbmhhIHdyb3RlOg0KPj4+Pj4+IA0KPj4+Pj4+IA0KPj4+Pj4+PiBPbiBBcHIgMjksIDIwMjAs
IGF0IDEwOjU4IEFNLCBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToN
Cj4+Pj4+Pj4gDQo+Pj4+Pj4+IG8gaWYgdGhlcmUncyBhIG5lZWQgdG8gZGlzYWJsZQ0KPj4+Pj4+
PiBqdXN0IG9uZSBvZiB0aGVzZSwgY29tbWl0IGxvZyBuZWVkcyB0byBkbyBhIGJldHRlciBqb2Ig
ZG9jdW1lbnRpbmcgdGhlDQo+Pj4+Pj4+IHVzZWNhc2UuDQo+Pj4+Pj4gDQo+Pj4+Pj4gVGhlIHVz
ZSBjYXNlIGlzIHNpbXBsZS4gV2l0aCB0aGlzIGZlYXR1cmUgYWRtaW5zIHdpbGwgYmUgYWJsZSB0
byBkbyB3aGF0IHRoZXkgd2VyZSBmb3JjZWQgdG8gZG8gZnJvbSBXaW5kb3dzIGRyaXZlciBsZXZl
bCBidXQgbm93IGF0IHRoZSBidXMgbGV2ZWwuIEhlbmNlLCANCj4+Pj4+PiAoYSkgVGhleSBuZWVk
IG5vdCBoYXZlIGFjY2VzcyB0byB0aGUgZ3Vlc3QgVk0gdG8gY2hhbmdlIG9yIHVwZGF0ZSB3aW5k
b3dzIGRyaXZlciByZWdpc3RyeSBzZXR0aW5ncy4gVGhleSBjYW4gZW5hYmxlIHRoZSBzYW1lIHNl
dHRpbmcgZnJvbSBhZG1pbiBtYW5hZ2VtZW50IGNvbnNvbGUgd2l0aG91dCBhbnkgYWNjZXNzIHRv
IFZNLg0KPj4+Pj4+IChiKSBJdCBpcyBtb3JlIHJvYnVzdC4gTm8gbmVlZCB0byBtZXNzIHdpdGgg
ZHJpdmVyIHNldHRpbmdzLiBJbmNvcnJlY3Qgc2V0dGluZ3MgY2FuIGJyaWNrIGd1ZXN0IE9TLiBB
bHNvIG5vIGd1ZXN0IHNwZWNpZmljIGtub3dob3cgcmVxdWlyZWQuDQo+Pj4+Pj4gKGMpIEl0IGlz
IG1vcmUgc2NhbGFibGUgc2luY2UgYSBzaW5nbGUgY2x1c3RlciB3aWRlIHNldHRpbmcgY2FuIGJl
IHVzZWQgZm9yIGFsbCBWTSBwb3dlciBvbnMgYW5kIHRoZSBtYW5hZ2VtZW50IHBsYW5lIGNhbiB0
YWtlIGNhcmUgb2YgdGhlIHJlc3QgYXV0b21hdGljYWxseS4gTm8gbmVlZCB0byBhY2Nlc3MgaW5k
aXZpZHVhbCBWTXMgdG8gZW5mb3JjZSB0aGlzLg0KPj4+Pj4+IChkKSBJIGFtIHRvbGQgdGhhdCB0
aGUgZHJpdmVyIGxldmVsIHNvbHV0aW9uIGRvZXMgbm90IHBlcnNpc3QgYWNyb3NzIGEgcmVib290
LiANCj4+Pj4+PiANCj4+Pj4+PiBBbmkNCj4+Pj4+IA0KPj4+Pj4gTG9va3MgbGlrZSBkaXNhYmxp
bmcgYm90aCBwbHVnIGFuZCB1bnBsdWcgd291bGQgYWxzbyBhZGRyZXNzIHRoZXNlIG5lZWRzLg0K
Pj4+PiANCj4+Pj4gTm8gdGhlIGRyaXZlciBsZXZlbCBzb2x1dGlvbiBkb2VzIG5vdCBwcmV2ZW50
IGhvdCBwbHVnZ2luZyBvZiBkZXZpY2VzIGJ1dCBibG9ja3MganVzdCBob3QgdW5wbHVnZ2luZy4g
VGhlIHNvbHV0aW9uIEkgYW0gcHJvcG9zaW5nIHRyaWVzIHRvIGRvIHRoZSBzYW1lIGJ1dCBmcm9t
IHRoZSBidXMvaHlwZXJ2aXNvciBsZXZlbC4NCj4+PiANCj4+PiBXaHkgZG9lcyB0aGUgZHJpdmVy
IGxldmVsIHNvbHV0aW9uIG5lZWQgdG8gcHJldmVudCBqdXN0IGhvdCB1bnBsdWdnaW5nPw0KPj4g
DQo+PiBCZWNhdXNlIGl0IG5vdCBmYWlyIHRvIHByZXZlbnQgZW5kIHVzZXJzIGZyb20gaG90IHBs
dWdnaW5nIG5ldyBkZXZpY2VzIHdoZW4gaXQgaXMgdGhlIChhY2NpZGVudGFsPykgaG90IHVucGx1
Z2dpbmcgb2YgZXhpc3RpbmcgZGV2aWNlcyB3aGljaCBjYXVzZXMgaXNzdWVzLg0KPiANCj4gQWNj
aWRlbnRhbD8gU28gbWF5YmUgd2hhdCB5b3UgbmVlZCBpcyBhY3R1YWxseSBzb21ldGhpbmcgZWxz
ZSB0aGVuIC0NCj4gYXZvaWQgKnJlbW92aW5nKiB0aGUgZGV2aWNlIHdoZW4gaXQncyBwb3dlcmVk
IGRvd24uDQoNCllvdSBkb27igJl0IGdldCBpdC4gSXQgaXMgbm90IGh5cGVydmlzb3IgYWRtaW5z
IHdobyBhcmUgdW5wbHVnZ2luZyBpdC4gSXQgaXMgdGhlIGVuZCB1c2Vycy4gRXZlbiBSZWRIYXQg
Y3VzdG9tZXJzIHdhbnQgdGhpcyBmZWF0dXJlLiBTZWUgZm9sbG93aW5nIHJlc291cmNlczogDQpo
dHRwczovL3d3dy5yZWRoYXQuY29tL2FyY2hpdmVzL2xpYnZpci1saXN0LzIwMjAtRmVicnVhcnkv
bXNnMDAxMTAuaHRtbA0KaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNnaT9p
ZD0xODAyNTkyDQpodHRwczovL2J1Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTE3
OTA4OTkNCg0KTXkgYXBwcm9hY2ggaXMgbXVjaCBtb3JlIGZpbmUgZ3JhaW5lZCB0aGFuIGp1c3Qg
ZGlzYWJsZSBldmVyeXRoaW5nIGFwcHJvYWNoIHRoYXQgd2UgaGF2ZSBmb3IgcTM1LiBGb3IgaTQ0
MGZ4IHdlIGNhbiBkbyBiZXR0ZXIgdGhhbiB0aGF0Lg0KDQoNCg0KPiANCj4+PiANCj4+PiANCj4+
Pj4gDQo+Pj4+PiAtLSANCj4+Pj4+IE1TVA0KDQo=

