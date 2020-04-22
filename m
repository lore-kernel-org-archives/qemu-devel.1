Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC24C5518A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 10:46:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7832E20780
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 10:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="OmPY9IXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7832E20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRCtL-0008MN-N9
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 06:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jRCsS-0007pr-Oj
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jRCsQ-0001ml-UQ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:45:11 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:7768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jRCsQ-0001Tw-5d
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:45:10 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03MAielY030775; Wed, 22 Apr 2020 03:45:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=8GDtA56o9MRAtiqNXfB6af//dabYkfgeud8VX/pogok=;
 b=OmPY9IXHKv4odNGt01R5l9lCFpRSq+fKg5Cu2UoXPLTIvMCxBNes8VvxP7hs8u55VU6E
 8O2wUwaNkeWi3IKajJrUy/kYP1r/lroEm7gpkL6UANpiWCmT3Poi4dfjpk+8w7MedQtx
 27qg5mEi0qFz79rqkaG4n77ZfPx6uLaZ05NtKbpvxRVcHTRaYK/8vLlDB3wdAWjDnKDA
 WgGQZe0RFxYRA0ADht9L8BueXW3JwdaEOmz7d1Ty5KARBLXQzZz2+9bUP/pcDrZlGlNG
 dtaqpOtel6wZndDnHWcxKYvXQfWYeKZwaL3cIJLJl+t39kWkMYjisFCUkkkL4pzLo7T9 VA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by mx0b-002c1b01.pphosted.com with ESMTP id 30fy3a0quj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Apr 2020 03:45:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+UdL2YenW+eVHXCjgFcr7l4cgrgBWaDPiOamODXzCE+MZ7B2+7XUVbEdlzc1rj3SXbf7JHrFKqUdiKLj2IvqubaUNHfTGZfrbZ+jlRCGQ51NJ2JZOI3jpGPicreGiKmnIQi8DxEAIpAt85YU8nrc6uHTkBWEe+3n3r3sHjO3GYtmQjg4yR/ayt5YVCy5xQlAE7kQ8DveETGo6k8KNeY1SdIgCbTzrvzrmriY32GePOcH/xrjkQ+RfDMKj8K2SvMYLvvcgYmX/5laqdXr4e8b95XM0D5HzHlvHXRWB9sJH5RlmvXbL4V1m6El+vUwZEzfCmuQQksLFYD5h2iaroa1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GDtA56o9MRAtiqNXfB6af//dabYkfgeud8VX/pogok=;
 b=kxPWHvlxILz0RUvUyXIeXc7ItqtF3RfOruQ1a6+GoNh3w9jf/nQAO43fBcG+l/3JVzaKpIvnXftd8b6+G0ThhLFYbhTHsnriPpx8zyt/U4bVrEru3i9HHHtKwq1sB4RzAYzEKwSjga9dVPmLFHKiHm6e+/9URRAr7jy12gwkGJVJU6u6/uVNWG7PeSilnWmlltrH3tgHMfCiL3hd5VrGY+IKRIMNooFt6EVvB/OsxXwi/7DPAz8yNNF9ZgJcjiYFJ9wY9Mzy7HT4V/sQFBgEP+j8hRMeej8UfNathTISRh0Y9vhlynfgf2t4N/EkRP3LglgCcbCnVKS57FiNPejMLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB6734.namprd02.prod.outlook.com (2603:10b6:208:1d1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 22 Apr
 2020 10:45:04 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a%7]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 10:45:04 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Subject: Re: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Topic: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Index: AQHWFMrLeCs/JzKNrUaCDY3Nn1YJmqh9b9kAgAACaICAAAksAIAERh2AgABeQwCAAY19AIAABL+AgAFKiAA=
Date: Wed, 22 Apr 2020 10:45:04 +0000
Message-ID: <A31A7DC2-E1FB-409B-9A99-324F8879E9AD@nutanix.com>
References: <1587136411-200885-1-git-send-email-ani.sinha@nutanix.com>
 <20200417112620-mutt-send-email-mst@kernel.org>
 <2A13ACCD-BD24-41FB-B6EA-2804F7C1FF1D@nutanix.com>
 <20200417120732-mutt-send-email-mst@kernel.org>
 <20200420092459.GF346737@redhat.com>
 <20200420105936-mutt-send-email-mst@kernel.org>
 <07BC06B8-34F6-4C46-ACCE-DD7A4CBA9BC7@nutanix.com>
 <20200421150201.GI479771@redhat.com>
In-Reply-To: <20200421150201.GI479771@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.146.154.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9afa0e59-dc0e-43a6-bfe6-08d7e6aa37a2
x-ms-traffictypediagnostic: MN2PR02MB6734:
x-microsoft-antispam-prvs: <MN2PR02MB67349C2BD1391F4680A46BADF1D20@MN2PR02MB6734.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03818C953D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(136003)(396003)(39860400002)(346002)(376002)(186003)(33656002)(54906003)(8936002)(5660300002)(81156014)(36756003)(6506007)(316002)(6512007)(26005)(478600001)(53546011)(6486002)(2906002)(44832011)(2616005)(86362001)(6916009)(4744005)(76116006)(91956017)(66476007)(64756008)(66946007)(4326008)(66446008)(66556008)(71200400001)(8676002);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AKqX9q2dUef/84vzUzGPxbKLZ+dA2EW51fxGEVMVVlHPUNeh4dG7dNz4ev+BjrEpfNn24E43I5C6PM7YF6weOlMn/Q/QphzWDAUxZb72YBbTLtW3WbKpJOXHQsKcHGUyHmxsiqflaHCiqiWnWcQYH1HnLiyfMvm/4pEidceHuTJErmt9JxF3Z/86cv5YV3Yp4UTX1tvDIBcJFT+8b6LbDxY0VjPC4pn39g9Q+mi3ruFbnBrKpHwIAhLYFtdzzq7fgQaUsQja7+b8xjSOoaL9JM/NolERYEKfU5o5JbSp3X+zitcEu7IyXhRYxUKKRAFAMhStvoPrJ5pB+1scMyrsBHf2DWKxa3B1bK4J70Oh46ycFk6BlTWU13aBh42bL2CjHQs853rXooIVfJjZiCTnU2WENHmuu4snY/e7DNgZVKCNYg6RPbUfbD6M4NKEgQUo
x-ms-exchange-antispam-messagedata: 0+wfLtUHH4K0ThMKrhfUIDLL00XmLzIx5n4L5b5c08v4yZ+TsPGQOL3fVx6hHwqyCI03cZqaeDP16ncYygr+PFZ/zv2QVnlmnPGUqgaAZR9C/htQbqj7s28V1Rq1XYYE8mAZXgQi+i9jvGvA92ojMg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9061C4C2233DFE4E915186538CCDD849@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9afa0e59-dc0e-43a6-bfe6-08d7e6aa37a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2020 10:45:04.6507 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vM+DLmxfqEooh9oAuVvB3Tr/VqZDITvGpkYSFNdvImDDqtJOUUxtcVQsy/v8T94uFodAUoCadCi0aoFbHuXLog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6734
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-22_03:2020-04-22,
 2020-04-22 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=ani.sinha@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 06:45:07
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gT24gQXByIDIxLCAyMDIwLCBhdCA4OjMyIFBNLCBEYW5pZWwgUC4gQmVycmFuZ8OpIDxi
ZXJyYW5nZUByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgQXByIDIxLCAyMDIwIGF0
IDAyOjQ1OjA0UE0gKzAwMDAsIEFuaSBTaW5oYSB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gQXBy
IDIwLCAyMDIwLCBhdCA4OjMyIFBNLCBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29t
PiB3cm90ZToNCj4+PiANCj4+PiBCdXQgSSBmb3Igb25lIHdvdWxkIGxpa2UgdG8gZm9jdXMgb24g
a2VlcGluZyBQSUlYIHN0YWJsZQ0KPj4+IGFuZCBmb2N1cyBkZXZlbG9wbWVudCBvbiBxMzUuICBO
b3QgYmxvYXRpbmcgUElJWCB3aXRoIGxvdHMgb2YgbmV3DQo+Pj4gZmVhdHVyZXMgaXMgSU1ITyBh
IGdvb2Qgd2F5IHRvIGRvIHRoYXQuDQo+PiANCj4+IERvZXMgdGhpcyBtZWFuIHRoaXMgcGF0Y2gg
aXMgYSBuby1nbyB0aGVuPyA6KA0KPiANCj4gSSdkIHN1cHBvcnQgdGhpcyBwYXRjaCwgYXMgSSBk
b24ndCB0aGluayBpdCBjYW4gcmVhbGx5IGJlIGRlc2NyaWJlZCBhcw0KPiBibG9hdCBvciBkZXN0
YWJhbGl6aW5nLiBJdCBpcyBqdXN0IGFkZGluZyBhIHNpbXBsZSBwcm9wZXJ0eSB0bw0KPiBjb25k
aXRpb25hbGl6ZSBleGlzdGluZyBmdW5jdGlvbmFsaXR5LiAgVGVsbGluZyBwZW9wbGUgdG8gc3dp
dGNoIHRvIFEzNQ0KPiBpcyB1bnJlYXNvbmFibGUgYXMgaXQgaXMgbm90IGEgc2ltcGxlIDEtMSBj
b252ZXJzaW9uIGZyb20gZXhpc3RpbmcgdXNlDQo+IG9mIFBJSVguIFEzNSBoYXMgbXVjaCBoaWdo
ZXIgY29tcGxleGl0eSBpbiBpdHMgY29uZmlndXJhdGlvbiwgaGFzIGhpZ2hlcg0KPiBtZW1vcnkg
b3ZlcmhlYWQgcGVyIFZNIHRvbywgYW5kIGxhY2tzIGNlcnRhaW4gZmVhdHVyZXMgb2YgUElJWCB0
b28uDQoNCkNvb2wuIEhvdyBkbyB3ZSBnbyBmb3J3YXJkIGZyb20gaGVyZT8NCg0K

