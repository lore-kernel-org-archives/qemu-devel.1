Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4C8C742CA
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 15:46:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF5E520863
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 15:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lwVQ5CM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5E520863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlxl5-0007w0-VU
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 11:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38008)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hlxku-0007VF-BI
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hlxkd-0008Mc-6J
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:46:28 -0400
Received: from mail-eopbgr820078.outbound.protection.outlook.com
 ([40.107.82.78]:3203 helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hlxkc-0008CX-6h
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:46:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOWye7hSxxXpuiiH9dGIfW74P96pCaxI09G1ok84xyc=;
 b=lwVQ5CM2Z4nnnLP2oNh6OWpdhpmOU50vEioCB0g/uYRJPmn8ovfJbTAyZbCQcKieoaSqoFJm3rfvCF7QM0HJD0kksU2GTgbMDwDQp8+U3vs0TizEhOOWXeTDTH5XqCsriwsilqhjzKwnQMiWA7Afmz/u+aKWqFInme8HZ4BBJXg=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB3065.namprd12.prod.outlook.com (20.178.30.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Fri, 12 Jul 2019 15:46:18 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd%6]) with mapi id 15.20.2073.008; Fri, 12 Jul 2019
 15:46:18 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Thread-Topic: [PATCH v2 03/13] migration/ram: add support to send encrypted
 pages
Thread-Index: AQHVN11E5yX2Qel2IUGBE0XocGCcP6bFrwuA///QKYCAATokAIAAac4A
Date: Fri, 12 Jul 2019 15:46:18 +0000
Message-ID: <c2818b98-5bac-6b3e-93e3-c97e4581cb43@amd.com>
References: <20190710202219.25939-1-brijesh.singh@amd.com>
 <20190710202219.25939-4-brijesh.singh@amd.com>
 <20190711173427.GR3971@work-vm>
 <f57e4255-74d1-b0c9-bbda-1763d30f95fe@amd.com>
 <20190712092734.GA2730@work-vm>
In-Reply-To: <20190712092734.GA2730@work-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0062.namprd02.prod.outlook.com
 (2603:10b6:803:20::24) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a95b6ec5-40d8-4c56-df40-08d706e014a0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB3065; 
x-ms-traffictypediagnostic: DM6PR12MB3065:
x-microsoft-antispam-prvs: <DM6PR12MB3065D9460654CAAF77F8643FE5F20@DM6PR12MB3065.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(199004)(189003)(2906002)(52116002)(76176011)(66066001)(66476007)(66446008)(7736002)(66556008)(66946007)(64756008)(14444005)(256004)(11346002)(2616005)(3846002)(486006)(478600001)(6116002)(26005)(68736007)(6486002)(54906003)(25786009)(229853002)(53936002)(14454004)(446003)(81166006)(6506007)(476003)(36756003)(31696002)(6436002)(81156014)(6916009)(316002)(86362001)(71200400001)(186003)(71190400001)(4326008)(102836004)(99286004)(5660300002)(8936002)(305945005)(8676002)(31686004)(6512007)(6246003)(386003)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3065;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tsufA02Z3zR0L82rQg2q7U7IY+m0AqQrcv3GPTARMpgouCs350iX25wAnEuHKLV8BqwKABGcCRbpmjw+bHbhSR+nl/8dde0x3dM4ZKRxG2RdYYOWfKGViwfki//dkg/SoBN9H5uxZah0v3/VUwSxLUMaKggnsapjzNntR3z/OAsjYcbmVZnzqZC+WfYEaC+9jbS34UNi+lhHVKCO9/vB9MFlLTgN2aoFawb8edWJgko9hrqxk/TZ5T0t89NklJUR9BDIDfOwhkILhNQGiaV0rXeRuOUSNmBIqeFlj3NiklNy//lb2xoXLIDEc+2OUd2Zk2ZvuJdf/MwA6Z5KdGKFs8qaeGxSJvuldUodadX1+mqZLkOym8F3CGJZuIyrj52ft8MpOEY8G6pqkIjSCmDuxxr578L2OX4D4xw7E3gILNE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47341EAA8565CA45B3F58259B52853A6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a95b6ec5-40d8-4c56-df40-08d706e014a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 15:46:18.7521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3065
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.82.78
Subject: Re: [Qemu-devel] [PATCH v2 03/13] migration/ram: add support to
 send encrypted pages
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Lendacky,
 Thomas" <Thomas.Lendacky@amd.com>, "Singh, Brijesh" <brijesh.singh@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDcvMTIvMTkgNDoyNyBBTSwgRHIuIERhdmlkIEFsYW4gR2lsYmVydCB3cm90ZToNCg0K
W3NuaXBdDQoNCj4+Pg0KPj4+IE9LLCB0aGF0J3Mgb3VyIHZlcnkgbGFzdCB1c2FibGUgZmxhZyEg
IFVzZSBpdCB3aXNlbHkhDQo+Pj4NCj4+DQo+PiBIbW0sIG1heWJlIHRoZW4gSSBtaXNzZWQgc29t
ZXRoaW5nLiBJIHRob3VnaHQgdGhlIGZsYWcgaXMgNjQtYml0IGFuZA0KPj4gd2UgaGF2ZSBtb3Jl
IHJvb20uIERpZCBJIG1pc3Mgc29tZXRoaW5nID8NCj4gDQo+IFRoZSA2NGJpdCB2YWx1ZSB3cml0
dGVuIGluIHRoZSBzdHJlYW0gaXMNCj4gICAgKHRoZSBhZGRyZXNzIG9mIHRoZSBwYWdlKSB8ICh0
aGUgc2V0IG9mIGZsYWdzKQ0KPiANCj4gc28gdGhlIHNldCBvZiB1c2FibGUgZmxhZ3MgZGVwZW5k
cyBvbiB0aGUgbWluaW11bSBwYWdlIGFsaWdubWVudA0KPiBvZiB3aGljaCB0aGUgd29yc3QgY2Fz
ZSBpcyBBUk0gd2l0aCBhIFRBUkdFVF9QQUdFX0JJVFNfTUlOIG9mIDEwDQo+IChtb3N0IG90aGVy
cyBhcmUgNGsgYXQgbGVhc3QgYnV0IHRoYXQncyBzdGlsbCBvbmx5IDIgbGVmdCkuDQo+IA0KPj4N
Cg0KR290IGl0LCB0aGFua3MNCg0KDQo+Pg0KPj4gQ3VycmVudGx5LCB0aGVyZSBhcmUgdHdvIGlu
dGVyZmFjZXMgYnkgd2hpY2ggd2UgY2FuIGtub3cgaWYgd2UNCj4+IGFyZSBkZWFsaW5nIHdpdGgg
ZW5jcnlwdGVkIGd1ZXN0LiBrdm1fbWVtY3J5cHRfZW5hYmxlZCgpIG9yDQo+PiBNYWNoaW5lU3Rh
dGUtPm1lbW9yeV9lbmNyeXB0aW9uIHBvaW50ZXIuIEkgZGlkIHJlYWxpemVkIHRoYXQNCj4+IG1p
Z3JhdGlvbiBjb2RlIGhhdmUgbm90IGRlYWx0IHdpdGgga3ZtIHNvIGZhci4NCj4+DQo+PiBIb3cg
YWJvdXQgdGFyZ2V0L2kzODYvc2V2LmMgZXhwb3J0aW5nIHRoZSBtaWdyYXRpb24gZnVuY3Rpb25z
IGFuZA0KPj4gYmFzZWQgb24gc3RhdGUgb2YgTWFjaGluZVN0YXRlLT5tZW1vcnlfZW5jcnlwdGlv
biB3ZSBjYWxsIHRoZQ0KPj4gU0VWIG1pZ3JhdGlvbiByb3V0aW5lcyBmb3IgdGhlIGVuY3J5cHRl
ZCBwYWdlcz8NCj4gDQo+IEknbSBtaWdyYXRpb24gbm90IG1hY2hpbmU7IHNvIGZyb20gbXkgcG9p
bnQgb2YgdmlldyB0aGUgdGhpbmcgdGhhdCdzDQo+IGltcG9ydGFudCBpcyBtYWtpbmcgc3VyZSB3
ZSd2ZSBub3QgZ290IEtWTSBkaXJlY3QgZGVwZW5kZW5jaWVzIGluIGhlcmU7DQo+IGlmIHlvdSd2
ZSBhbHJlYWR5IGdvdCBhIE1hY2hpbmVTdGF0ZS0+bWVtb3J5X2VuY3J5cHRpb24gcG9pbnRlciB0
aGVuIEknZA0KPiBob3BlIHlvdSBjb3VsZCBkbyBzb21ldGhpbmcgbGlrZToNCj4gDQo+ICAgICAg
cmV0ID0gTWFjaGluZVN0YXRlLT5tZW1vcnlfZW5jcnlwdGlvbi0+b3BzLT5zYXZlKC4uLi4pDQo+
IA0KDQpJIHdpbGwgbG9vayBpbnRvIGRvaW5nIHNvbWV0aGluZyBsaWtlIHRoaXMuDQoNCnRoYW5r
cw0K

