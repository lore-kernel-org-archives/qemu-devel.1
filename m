Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E385C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:39:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 170D6206F6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="KzgCIru5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 170D6206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQYW0-0007u3-9p
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 11:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38030 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jQYUr-000767-Dd
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:38:09 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1jQYUp-0006vm-95
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:38:07 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:39110)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@nutanix.com>)
 id 1jQYUo-0006tY-PP
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:38:06 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03KFJ1ZA002736; Mon, 20 Apr 2020 08:38:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=ylLpUXuvjY9IjDC3XnxPBpQtdVpCMb+OvxZSqSciGb8=;
 b=KzgCIru5HWBOYXOLPtucNKLgxVqL/r/gI+gBhCN7RwfG6ni0zv6DbCMSEVe88VBVtVvJ
 itTE2r2019dZ+X1dpM1m9V+nR1pbkxpUQ3RLl/bghcRiepICh3lkP00F2gAJBxqoz4c0
 eFmyJzE4agDuCILtoMXfB2NmfRVo/oR0zEQ3BXxjVx3Q6Y3vZuDgF/SFWvh4Tk/pYeMt
 iWJpcLXt4a+Ho8PQK+bXk+yDlW40kWUeYVIhk7asQufbeFAws2iCxE+P8G9mXzdbLRcy
 CaxoxD4ldmZWEHQ35b4poP0Ka64A1JZiClZ8pyc5ye/HD1FxtqGGHg0+i2AACK2U6Zls pg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
 by mx0b-002c1b01.pphosted.com with ESMTP id 30g132breg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2020 08:38:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSq/TZ7WqkGgqgSmhfZ2Pj4iZ+WIUlUYqJCufX62u5PtAOlCeej33AFpcxob7k2h7CfQkjx0hBSrnoz3ihJw96vVH0tThZrqBDjK1LsfcrZUfd8hFPQy/LjJB7iC3W87zbks+ZxZaFw7LZ+PKmQgcC94SSqJalqpejsaGRnkd6VfGTN437qQ8A6QWEykrSGPw1rM6Nh8yOS5qVFXC6Wn5RggUvRl7CcBQsenWMPm0oUn9JsAl8TyGdh9wB88D8CoAMAvHgDILfi8AQcVd91+wkmael5Tz9WZXghscUuI7BVfYPDVk/mwL1MR5KTkrfr8Q5gS7axT8ua+1Aferl+row==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylLpUXuvjY9IjDC3XnxPBpQtdVpCMb+OvxZSqSciGb8=;
 b=YuvWNhKJ9RIEi0sWJ+jL/9fims/rWs/ALv7k/mcB5shtuAaDwZ/Dofpdju5BwwlzQVvDE2gLIAbyOd+RbtxIwuJnUkrJ0RQNLec2NZxAXb7QgUhaFVSx9JXBg+3hCmb6pn9OO9frI+8p6/3mdIEhOj++WOjM/VbkY4tWvzoqsPR3ivT0Ye1vWOPf8M/Cb8pEm4jVtL0HrDAU/EX8a6d+4PYbHUqL4m8wYQ7WuLaphRIuhKaPBB6dxJBYAatEoqFsxZnNJLfpcZqKGaJCwvy+AYT42ryju6QKxTn8APvEzaFIfJM8aXTSyfhv2yc6ORTPBehcW0x0MrAumaJZNqrMRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB5742.namprd02.prod.outlook.com (2603:10b6:208:10d::27)
 by MN2PR02MB5758.namprd02.prod.outlook.com (2603:10b6:208:10e::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 15:38:02 +0000
Received: from MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a]) by MN2PR02MB5742.namprd02.prod.outlook.com
 ([fe80::200c:b06c:d8c6:42a%7]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 15:38:02 +0000
From: Ani Sinha <ani.sinha@nutanix.com>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Topic: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Thread-Index: AQHWFMrLeCs/JzKNrUaCDY3Nn1YJmqh9b9kAgAACaICAAAksAIAAB0KAgABZuwCAAFwZAIAAnSIAgANKsgCAAAlsgA==
Date: Mon, 20 Apr 2020 15:38:02 +0000
Message-ID: <315246A9-D4F1-4C92-A822-90809A171FAD@nutanix.com>
References: <1587136411-200885-1-git-send-email-ani.sinha@nutanix.com>
 <20200417112620-mutt-send-email-mst@kernel.org>
 <2A13ACCD-BD24-41FB-B6EA-2804F7C1FF1D@nutanix.com>
 <20200417120732-mutt-send-email-mst@kernel.org>
 <56B4E13C-DCAA-4E40-A821-6C043844A253@nutanix.com>
 <0e15c8e7-7b32-985e-c182-2868273a1bd7@redhat.com>
 <AFEDBC1F-8536-4354-9C5E-9829C258B6E3@nutanix.com>
 <67ca69f6-8d6b-8be0-72f2-b30a67edf200@gmail.com>
 <24B1F6CD-14DD-4F28-9406-453D19CCAFCF@nutanix.com>
In-Reply-To: <24B1F6CD-14DD-4F28-9406-453D19CCAFCF@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [115.110.205.84]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68253af0-3b72-49c2-6e10-08d7e540cfd1
x-ms-traffictypediagnostic: MN2PR02MB5758:
x-microsoft-antispam-prvs: <MN2PR02MB57589703E0912F97484D384FF1D40@MN2PR02MB5758.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB5742.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(136003)(366004)(376002)(39860400002)(346002)(396003)(33656002)(478600001)(26005)(86362001)(6506007)(64756008)(2616005)(53546011)(5660300002)(66556008)(66476007)(66446008)(66946007)(36756003)(44832011)(76116006)(91956017)(4744005)(6512007)(54906003)(6486002)(316002)(71200400001)(4326008)(7416002)(6916009)(186003)(8936002)(8676002)(2906002)(81156014);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CX/OiQrkUKs5Y/8M19xRRpXqIrwmtuB3bGdnS/cvO2K6SSV7DFRPTKRHxFte4O+6m53H04aE1vAXT+8UQ5lrRUrZAECkRPfyr4dJn7uJGfIjrIVbP7a+PPImes8vJKixMXH6tEsR/L0ucBhJO2eMHVvEBCP5gQQn3jjD69rSpLXbQyZqHckXsPa2wQCILbgcGaMdqLkV4OWZqAXAXThV8A0zAfn0Qa6ZpkepTLZC2Kzy/4dCBcMaINE93mqmW4UCbWfnybY30dkoXDtwCyB/ou58N4FZBkT15KE+MYqKzB6e6DsgUgVM7cLBBH3+XhWmrdqmCg6smIEWCVCd8fRcObmGvLErGOgZAKyF3OClgDYJMuljNLjtwqHI4w73Aoe9DXARTAXd/uDiaT38tq0C3whZCt+6PobqzGYrNgchLwA4gbwlvw0ZwvqmnhbywTLY
x-ms-exchange-antispam-messagedata: eNTOlTEV75uY5ONC3hH8wW38XVKx3SsppUKLnalJqxPfkq+mmeMWc7fS7FUrFy+waXJmN6thxbfw5Hq1Qqox0hgMs4Y4QM/vuAw0Fhh7+FuM0ZRaSj8qc1Teg/o3jeIQctOHj/ILQLyElWkg5XgcUw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E09081595F167F46B98A0E5D7325C2ED@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68253af0-3b72-49c2-6e10-08d7e540cfd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 15:38:02.1832 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a68Z5pKL/P1eRJb9Cf5+S1wRsbu0IfxtLBVg3BqVxsIUdwDsUKCMVBkCqwkTg7lJ9hulbiaeyYU4zIO7RvLPSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5758
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-20_05:2020-04-20,
 2020-04-20 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=ani.sinha@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 11:04:22
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
 "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laine Stump <laine@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gT24gQXByIDIwLCAyMDIwLCBhdCA4OjM0IFBNLCBBbmkgU2luaGEgPGFuaS5zaW5oYUBu
dXRhbml4LmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+PiBPbiBBcHIgMTgsIDIwMjAsIGF0IDY6
MTggUE0sIE1hcmNlbCBBcGZlbGJhdW0gPG1hcmNlbC5hcGZlbGJhdW1AZ21haWwuY29tPiB3cm90
ZToNCj4+IA0KPj4gQSBQQ0llIFJvb3QgUG9ydCBvciBhIFBDSSBzbG90IGNhbiBvciBjYW5ub3Qg
c3VwcG9ydCBob3QtcGx1Z2dpbmcuIEFueXRoaW5nIGluIHRoZSBtaWRkbGUgY2FuJ3QgYmUgZG9u
ZSBhdCBQQ0llL1BDSSBsZXZlbCAoYXMgZmFyIGFzIEkga25vdykuDQo+IA0KPiBJcyBpdCBwb3Nz
aWJsZSB0byBkeW5hbWljYWxseSBzZXQgUENJX0VYUF9TTFRDQVBfSFBDIGZvciBhIHNsb3QgYXQg
cnVudGltZT8NCg0KV2hhdCBJIG1lYW4gaXMsIHdoZW4gYSBzbG90IGNhcGFiaWxpdHkgaXMgc2V0
IGFuIGluaXRpYWxpemF0aW9uLCBpcyBpdCBzZXQgaW4gc3RvbmUgb3IgY2FuIHRoZSBjYXBhYmls
aXRpZXMgYmUgcmV2b2tlZCBwb3N0IGluaXRpYWxpemF0aW9uPyBJIGNhbiDigJl0IGZpbmQgYW55
dGhpbmcgcmVsYXRlZCB0byB0aGlzIGluIFBDSUUgc3BlYy4=

