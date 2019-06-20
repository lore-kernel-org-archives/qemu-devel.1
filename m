Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FD6C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 19:00:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D9B206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 19:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UiKQ9oAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D9B206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52231 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he2IG-0003eu-G1
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 15:00:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43402)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1he1cb-0005Nr-Np
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 14:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1he1P9-0003u3-8E
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 14:03:47 -0400
Received: from mail-eopbgr720059.outbound.protection.outlook.com
 ([40.107.72.59]:35920 helo=NAM05-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1he1P8-0003qK-VF
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 14:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mf8jDXjO64YdTGizvevSEpAQhvar0tN+bsG6ZLT84cg=;
 b=UiKQ9oArWjqAQ94d8FyUw1ggWT34wBcoPeVjIPvf5wByQj7KZXzFeOxWmaI5dZS/lyUHGr79PfzS49FIcrZAkq8M3q2PnTYezCnqymQi7QvRJp2WTlQzfbB0lNDjW2e/qN996htYrusgyLGG2D/uaHnLPmYJM+QTsHT6cQ9+liw=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB3260.namprd12.prod.outlook.com (20.179.105.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Thu, 20 Jun 2019 18:03:16 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::b9c1:b235:fff3:dba2]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::b9c1:b235:fff3:dba2%6]) with mapi id 15.20.1987.014; Thu, 20 Jun 2019
 18:03:16 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC PATCH v1 03/12] migration/ram: add support to send
 encrypted pages
Thread-Index: AQHVJ5Jq6KfFwPejbEqFodH5195MuA==
Date: Thu, 20 Jun 2019 18:03:08 +0000
Message-ID: <20190620180247.8825-4-brijesh.singh@amd.com>
References: <20190620180247.8825-1-brijesh.singh@amd.com>
In-Reply-To: <20190620180247.8825-1-brijesh.singh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:4:15::11) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1acf7256-1093-42a9-0c03-08d6f5a98c4e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DM6PR12MB3260; 
x-ms-traffictypediagnostic: DM6PR12MB3260:
x-microsoft-antispam-prvs: <DM6PR12MB3260893CC069D092C141D172E5E40@DM6PR12MB3260.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0074BBE012
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(376002)(136003)(39860400002)(346002)(199004)(189003)(43544003)(2351001)(53936002)(486006)(2616005)(11346002)(81156014)(8676002)(14444005)(6436002)(446003)(5640700003)(50226002)(6512007)(476003)(102836004)(6916009)(99286004)(2501003)(6486002)(76176011)(8936002)(52116002)(81166006)(316002)(186003)(6506007)(26005)(478600001)(256004)(3846002)(2906002)(386003)(66066001)(14454004)(54906003)(6116002)(305945005)(25786009)(1076003)(66946007)(66556008)(73956011)(64756008)(66446008)(71190400001)(71200400001)(68736007)(36756003)(6666004)(66476007)(5660300002)(7736002)(86362001)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3260;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CpOG6ZyeM9A8ipgvDLDcgI5vGNQIsNgGaNm+M4vkW4llszD+J1KQkOmnq3gr68s7KVuzoVWKWf5K3oewqGCfPKaTOpUNnDa1JcFH7DPx1/+LLtNWOg8tHylDoHPrx3LVTUejIfeajmQupXlZ89TLmaGtMbgZ5YsPtPmCGrBTbhA3u5PElWWaAjNxF0RXt7YjYhIwKw4retTYaJK7PW1tDoHejq69grZUtXd+QErdixuMc/Y8isjs6e+c5fcYQhNn/5oVLsEKfVuFjd2ixpikMDwWs/E7BHRlEWr1KziT7atuGLrda5fPOnfKwOOK8fa+VvDkOhyo9Qn9bGflw/SDVMqHWJBQOr+1kVphZ2bPtSfj6IQXCMEDSA75Ql8XxVJwOl928C++qPCmExt5eSRk9LjfsXwprHd6SCUcdKXtCFw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1acf7256-1093-42a9-0c03-08d6f5a98c4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2019 18:03:08.4579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3260
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.72.59
Subject: [Qemu-devel] [RFC PATCH v1 03/12] migration/ram: add support to
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
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Singh,
 Brijesh" <brijesh.singh@amd.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

V2hlbiBtZW1vcnkgZW5jcnlwdGlvbiBpcyBlbmFibGVkLCB0aGUgZ3Vlc3QgbWVtb3J5IHdpbGwg
YmUgZW5jcnlwdGVkIHdpdGgNCnRoZSBndWVzdCBzcGVjaWZpYyBrZXkuIFRoZSBwYXRjaCBpbnRy
b2R1Y2VzIFJBTV9TQVZFX0ZMQUdfRU5DUllQVEVEX1BBR0UNCmZsYWcgdG8gZGlzdGluZ3Vpc2gg
dGhlIGVuY3J5cHRlZCBkYXRhIGZyb20gcGxhaW50ZXh0LiBFbmNyeXB0ZWQgcGFnZXMNCm1heSBu
ZWVkIHNwZWNpYWwgaGFuZGxpbmcuIFRoZSBrdm1fbWVtY3J5cHRfc2F2ZV9vdXRnb2luZ19wYWdl
KCkgaXMgdXNlZA0KYnkgdGhlIHNlbmRlciB0byB3cml0ZSB0aGUgZW5jcnlwdGVkIHBhZ2VzIG9u
dG8gdGhlIHNvY2tldCwgc2ltaWxhcmx5IHRoZQ0Ka3ZtX21lbWNyeXB0X2xvYWRfaW5jb21pbmdf
cGFnZSgpIGlzIHVzZWQgYnkgdGhlIHRhcmdldCB0byByZWFkIHRoZQ0KZW5jcnlwdGVkIHBhZ2Vz
IGZyb20gdGhlIHNvY2tldCBhbmQgbG9hZCBpbnRvIHRoZSBndWVzdCBtZW1vcnkuDQoNClNpZ25l
ZC1vZmYtYnk6IEJyaWplc2ggU2luZ2ggPGJyaWplc2guc2luZ2hAYW1kLmNvbT4NCi0tLQ0KIG1p
Z3JhdGlvbi9yYW0uYyB8IDU0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0NCiAxIGZpbGUgY2hhbmdlZCwgNTMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KDQpkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL3JhbS5jIGIvbWlncmF0aW9uL3JhbS5jDQpp
bmRleCA5MDg1MTdmYzJiLi4zYzg5NzdkNTA4IDEwMDY0NA0KLS0tIGEvbWlncmF0aW9uL3JhbS5j
DQorKysgYi9taWdyYXRpb24vcmFtLmMNCkBAIC01Nyw2ICs1Nyw3IEBADQogI2luY2x1ZGUgInFl
bXUvdXVpZC5oIg0KICNpbmNsdWRlICJzYXZldm0uaCINCiAjaW5jbHVkZSAicWVtdS9pb3YuaCIN
CisjaW5jbHVkZSAic3lzZW11L2t2bS5oIg0KIA0KIC8qKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8NCiAvKiByYW0gc2F2ZS9yZXN0b3Jl
ICovDQpAQCAtNzYsNiArNzcsNyBAQA0KICNkZWZpbmUgUkFNX1NBVkVfRkxBR19YQlpSTEUgICAw
eDQwDQogLyogMHg4MCBpcyByZXNlcnZlZCBpbiBtaWdyYXRpb24uaCBzdGFydCB3aXRoIDB4MTAw
IG5leHQgKi8NCiAjZGVmaW5lIFJBTV9TQVZFX0ZMQUdfQ09NUFJFU1NfUEFHRSAgICAweDEwMA0K
KyNkZWZpbmUgUkFNX1NBVkVfRkxBR19FTkNSWVBURURfUEFHRSAgIDB4MjAwDQogDQogc3RhdGlj
IGlubGluZSBib29sIGlzX3plcm9fcmFuZ2UodWludDhfdCAqcCwgdWludDY0X3Qgc2l6ZSkNCiB7
DQpAQCAtNDYwLDYgKzQ2Miw5IEBAIHN0YXRpYyBRZW11Q29uZCBkZWNvbXBfZG9uZV9jb25kOw0K
IHN0YXRpYyBib29sIGRvX2NvbXByZXNzX3JhbV9wYWdlKFFFTVVGaWxlICpmLCB6X3N0cmVhbSAq
c3RyZWFtLCBSQU1CbG9jayAqYmxvY2ssDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcmFtX2FkZHJfdCBvZmZzZXQsIHVpbnQ4X3QgKnNvdXJjZV9idWYpOw0KIA0KK3N0YXRpYyBp
bnQgcmFtX3NhdmVfZW5jcnlwdGVkX3BhZ2UoUkFNU3RhdGUgKnJzLCBQYWdlU2VhcmNoU3RhdHVz
ICpwc3MsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIGxhc3Rfc3Rh
Z2UpOw0KKw0KIHN0YXRpYyB2b2lkICpkb19kYXRhX2NvbXByZXNzKHZvaWQgKm9wYXF1ZSkNCiB7
DQogICAgIENvbXByZXNzUGFyYW0gKnBhcmFtID0gb3BhcXVlOw0KQEAgLTIwMDYsNiArMjAxMSwz
NiBAQCBzdGF0aWMgaW50IHJhbV9zYXZlX211bHRpZmRfcGFnZShSQU1TdGF0ZSAqcnMsIFJBTUJs
b2NrICpibG9jaywNCiAgICAgcmV0dXJuIDE7DQogfQ0KIA0KKy8qKg0KKyAqIHJhbV9zYXZlX2Vu
Y3J5cHRlZF9wYWdlIC0gc2VuZCB0aGUgZ2l2ZW4gZW5jcnlwdGVkIHBhZ2UgdG8gdGhlIHN0cmVh
bQ0KKyAqLw0KK3N0YXRpYyBpbnQgcmFtX3NhdmVfZW5jcnlwdGVkX3BhZ2UoUkFNU3RhdGUgKnJz
LCBQYWdlU2VhcmNoU3RhdHVzICpwc3MsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBib29sIGxhc3Rfc3RhZ2UpDQorew0KKyAgICBpbnQgcmV0Ow0KKyAgICB1aW50OF90ICpw
Ow0KKyAgICBSQU1CbG9jayAqYmxvY2sgPSBwc3MtPmJsb2NrOw0KKyAgICByYW1fYWRkcl90IG9m
ZnNldCA9IHBzcy0+cGFnZSA8PCBUQVJHRVRfUEFHRV9CSVRTOw0KKyAgICB1aW50NjRfdCBieXRl
c194bWl0Ow0KKw0KKyAgICBwID0gYmxvY2stPmhvc3QgKyBvZmZzZXQ7DQorDQorICAgIHJhbV9j
b3VudGVycy50cmFuc2ZlcnJlZCArPQ0KKyAgICAgICAgc2F2ZV9wYWdlX2hlYWRlcihycywgcnMt
PmYsIGJsb2NrLA0KKyAgICAgICAgICAgICAgICAgICAgb2Zmc2V0IHwgUkFNX1NBVkVfRkxBR19F
TkNSWVBURURfUEFHRSk7DQorDQorICAgIHJldCA9IGt2bV9tZW1jcnlwdF9zYXZlX291dGdvaW5n
X3BhZ2UocnMtPmYsIHAsDQorICAgICAgICAgICAgICAgICAgICAgICAgVEFSR0VUX1BBR0VfU0la
RSwgJmJ5dGVzX3htaXQpOw0KKyAgICBpZiAocmV0KSB7DQorICAgICAgICByZXR1cm4gLTE7DQor
ICAgIH0NCisNCisgICAgcmFtX2NvdW50ZXJzLnRyYW5zZmVycmVkICs9IGJ5dGVzX3htaXQ7DQor
ICAgIHJhbV9jb3VudGVycy5ub3JtYWwrKzsNCisNCisgICAgcmV0dXJuIDE7DQorfQ0KKw0KIHN0
YXRpYyBib29sIGRvX2NvbXByZXNzX3JhbV9wYWdlKFFFTVVGaWxlICpmLCB6X3N0cmVhbSAqc3Ry
ZWFtLCBSQU1CbG9jayAqYmxvY2ssDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
cmFtX2FkZHJfdCBvZmZzZXQsIHVpbnQ4X3QgKnNvdXJjZV9idWYpDQogew0KQEAgLTI0NTAsNiAr
MjQ4NSwxNiBAQCBzdGF0aWMgaW50IHJhbV9zYXZlX3RhcmdldF9wYWdlKFJBTVN0YXRlICpycywg
UGFnZVNlYXJjaFN0YXR1cyAqcHNzLA0KICAgICAgICAgcmV0dXJuIHJlczsNCiAgICAgfQ0KIA0K
KyAgICAvKg0KKyAgICAgKiBJZiBtZW1vcnkgZW5jcnlwdGlvbiBpcyBlbmFibGVkIHRoZW4gdXNl
IG1lbW9yeSBlbmNyeXB0aW9uIEFQSXMNCisgICAgICogdG8gd3JpdGUgdGhlIG91dGdvaW5nIGJ1
ZmZlciB0byB0aGUgd2lyZS4gVGhlIGVuY3J5cHRpb24gQVBJcw0KKyAgICAgKiB3aWxsIHRha2Ug
Y2FyZSBvZiBhY2Nlc3NpbmcgdGhlIGd1ZXN0IG1lbW9yeSBhbmQgcmUtZW5jcnlwdCBpdA0KKyAg
ICAgKiBmb3IgdGhlIHRyYW5zcG9ydCBwdXJwb3Nlcy4NCisgICAgICovDQorICAgICBpZiAoa3Zt
X21lbWNyeXB0X2VuYWJsZWQoKSkgew0KKyAgICAgICAgcmV0dXJuIHJhbV9zYXZlX2VuY3J5cHRl
ZF9wYWdlKHJzLCBwc3MsIGxhc3Rfc3RhZ2UpOw0KKyAgICAgfQ0KKw0KICAgICBpZiAoc2F2ZV9j
b21wcmVzc19wYWdlKHJzLCBibG9jaywgb2Zmc2V0KSkgew0KICAgICAgICAgcmV0dXJuIDE7DQog
ICAgIH0NCkBAIC00MjcxLDcgKzQzMTYsOCBAQCBzdGF0aWMgaW50IHJhbV9sb2FkKFFFTVVGaWxl
ICpmLCB2b2lkICpvcGFxdWUsIGludCB2ZXJzaW9uX2lkKQ0KICAgICAgICAgfQ0KIA0KICAgICAg
ICAgaWYgKGZsYWdzICYgKFJBTV9TQVZFX0ZMQUdfWkVSTyB8IFJBTV9TQVZFX0ZMQUdfUEFHRSB8
DQotICAgICAgICAgICAgICAgICAgICAgUkFNX1NBVkVfRkxBR19DT01QUkVTU19QQUdFIHwgUkFN
X1NBVkVfRkxBR19YQlpSTEUpKSB7DQorICAgICAgICAgICAgICAgICAgICAgUkFNX1NBVkVfRkxB
R19DT01QUkVTU19QQUdFIHwgUkFNX1NBVkVfRkxBR19YQlpSTEUgfA0KKyAgICAgICAgICAgICAg
ICAgICAgIFJBTV9TQVZFX0ZMQUdfRU5DUllQVEVEX1BBR0UpKSB7DQogICAgICAgICAgICAgUkFN
QmxvY2sgKmJsb2NrID0gcmFtX2Jsb2NrX2Zyb21fc3RyZWFtKGYsIGZsYWdzKTsNCiANCiAgICAg
ICAgICAgICAvKg0KQEAgLTQzOTEsNiArNDQzNywxMiBAQCBzdGF0aWMgaW50IHJhbV9sb2FkKFFF
TVVGaWxlICpmLCB2b2lkICpvcGFxdWUsIGludCB2ZXJzaW9uX2lkKQ0KICAgICAgICAgICAgICAg
ICBicmVhazsNCiAgICAgICAgICAgICB9DQogICAgICAgICAgICAgYnJlYWs7DQorICAgICAgICBj
YXNlIFJBTV9TQVZFX0ZMQUdfRU5DUllQVEVEX1BBR0U6DQorICAgICAgICAgICAgaWYgKGt2bV9t
ZW1jcnlwdF9sb2FkX2luY29taW5nX3BhZ2UoZiwgaG9zdCkpIHsNCisgICAgICAgICAgICAgICAg
ICAgIGVycm9yX3JlcG9ydCgiRmFpbGVkIHRvIGVuY3J5cHRlZCBpbmNvbWluZyBkYXRhIik7DQor
ICAgICAgICAgICAgICAgICAgICByZXQgPSAtRUlOVkFMOw0KKyAgICAgICAgICAgIH0NCisgICAg
ICAgICAgICBicmVhazsNCiAgICAgICAgIGNhc2UgUkFNX1NBVkVfRkxBR19FT1M6DQogICAgICAg
ICAgICAgLyogbm9ybWFsIGV4aXQgKi8NCiAgICAgICAgICAgICBtdWx0aWZkX3JlY3Zfc3luY19t
YWluKCk7DQotLSANCjIuMTcuMQ0KDQo=

