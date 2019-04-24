Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81982C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 16:14:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B0CA21903
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 16:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TGCoSnng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B0CA21903
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44040 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJKXs-0005uu-8U
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 12:14:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hJKTn-0002DZ-7P
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hJKTb-00044v-Qw
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:36 -0400
Received: from mail-eopbgr710060.outbound.protection.outlook.com
	([40.107.71.60]:21343
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1hJKTS-0003lK-V0
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=w5xfPzElqGBBA6yiBwyQdybwiqkj5NPI1oihNHtKTUM=;
	b=TGCoSnngzCf1cPwKzicMawMFfErMkbbZrJmEnCPDozElwljr2WCH8vCgS6KAS6+KABFOmY++BBma4fFSZyeACUDWWk1ZCuDnKsBsuvGD4eCPijz8XqwLT2h5YsW+mBUwNxBbNsGa0M3p3lTQrhQF85VObNkroRbuMEhG3tjaLE0=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
	DM6PR12MB3212.namprd12.prod.outlook.com (20.179.105.76) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.12; Wed, 24 Apr 2019 16:10:11 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43]) by
	DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43%5]) with mapi id 15.20.1813.017;
	Wed, 24 Apr 2019 16:10:11 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Thread-Topic: [RFC PATCH v1 10/10] mm: x86: Invoke hypercall when page
	encryption status is changed
Thread-Index: AQHU+rgx8NLk1kk3YkaGAjGQSXouEg==
Date: Wed, 24 Apr 2019 16:10:11 +0000
Message-ID: <20190424160942.13567-11-brijesh.singh@amd.com>
References: <20190424160942.13567-1-brijesh.singh@amd.com>
In-Reply-To: <20190424160942.13567-1-brijesh.singh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0601CA0019.namprd06.prod.outlook.com
	(2603:10b6:803:2f::29) To DM6PR12MB2682.namprd12.prod.outlook.com
	(2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b6d373c-49af-4f11-eef3-08d6c8cf53fa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB3212; 
x-ms-traffictypediagnostic: DM6PR12MB3212:
x-microsoft-antispam-prvs: <DM6PR12MB3212F5A4EADACB910CB2931DE53C0@DM6PR12MB3212.namprd12.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(396003)(136003)(376002)(39860400002)(366004)(346002)(199004)(189003)(6436002)(476003)(5640700003)(66556008)(66066001)(102836004)(6512007)(386003)(6506007)(6116002)(3846002)(6916009)(76176011)(2616005)(486006)(5660300002)(446003)(86362001)(97736004)(26005)(2501003)(11346002)(6486002)(186003)(2351001)(53936002)(14454004)(256004)(14444005)(36756003)(4326008)(54906003)(2906002)(25786009)(50226002)(68736007)(7416002)(8936002)(66476007)(99286004)(52116002)(81166006)(81156014)(73956011)(1076003)(8676002)(305945005)(1730700003)(71200400001)(66946007)(7736002)(66574012)(478600001)(316002)(64756008)(66446008)(71190400001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3212;
	H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TeTCLPsKBR9mSZBmHBaS7EiAYwb8+0Oj3X9w5KB5fX5Yt2A2QKTkqyWi/UC97RAhaYOgLYuHK5ZfoZdOHFJHpF4atbG+GvKccwQKaeFPOuGcAuLQ/EfDadEs0kuuOSjyzdA0/op2wDKFn0KtsnHGRS7oFmbjurDieoHWfxk/XLfvunMJBIkaBV7K7LpLijhAsS6uDvo4w4cCuBEougYB4hS3d8Fu1xH4gKBEfZsJSUqDgljklL5RjS02PVW+1hBETQLnPJCkqUnv0/dw1Fs2L2p9LPAlzeyXWnMX69ImpHH/Oz4wf9yJ4RmQkUfdK68Ip1DGyokjvN5WHVXZRmeCTfctRGPgC74fZX8QLacMx1HoIMBVd331TNJBZlFQvySr8043YdFqYgF+EJZhISYsetLL8cKSwt2EreJUR2kg9MQ=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <AE0E2698DA02E84CAC72CD57816BAD81@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6d373c-49af-4f11-eef3-08d6c8cf53fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 16:10:11.5165 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.60
Subject: [Qemu-devel] [RFC PATCH v1 10/10] mm: x86: Invoke hypercall when
 page encryption status is changed
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Singh,
	Brijesh" <brijesh.singh@amd.com>,
	=?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
	Joerg Roedel <joro@8bytes.org>, "x86@kernel.org" <x86@kernel.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424161011.zH3RJ6zGl6sUzZnSgVcnxBng1d4W0fAhQZ7KowvVLrA@z>

SW52b2tlIGEgaHlwZXJjYWxsIHdoZW4gYSBtZW1vcnkgcmVnaW9uIGlzIGNoYW5nZWQgZnJvbSBl
bmNyeXB0ZWQgLT4NCmRlY3J5cHRlZCBhbmQgdmljZSB2ZXJzYS4gSHlwZXJ2aXNvciBuZWVkIHRv
IGtub3cgdGhlIHBhZ2UgZW5jcnlwdGlvbg0Kc3RhdHVzIGR1cmluZyB0aGUgZ3Vlc3QgbWlncmF0
aW9uLg0KDQpDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQpDYzogSW5n
byBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+DQpDYzogIkguIFBldGVyIEFudmluIiA8aHBhQHp5
dG9yLmNvbT4NCkNjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0KQ2M6ICJS
YWRpbSBLcsSNbcOhxZkiIDxya3JjbWFyQHJlZGhhdC5jb20+DQpDYzogSm9lcmcgUm9lZGVsIDxq
b3JvQDhieXRlcy5vcmc+DQpDYzogQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPg0KQ2M6IFRv
bSBMZW5kYWNreSA8dGhvbWFzLmxlbmRhY2t5QGFtZC5jb20+DQpDYzogeDg2QGtlcm5lbC5vcmcN
CkNjOiBrdm1Admdlci5rZXJuZWwub3JnDQpDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KU2lnbmVkLW9mZi1ieTogQnJpamVzaCBTaW5naCA8YnJpamVzaC5zaW5naEBhbWQuY29tPg0K
LS0tDQogYXJjaC94ODYvaW5jbHVkZS9hc20vbWVtX2VuY3J5cHQuaCB8ICAzICsrDQogYXJjaC94
ODYvbW0vbWVtX2VuY3J5cHQuYyAgICAgICAgICB8IDQ1ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLQ0KIGFyY2gveDg2L21tL3BhZ2VhdHRyLmMgICAgICAgICAgICAgfCAxNSArKysrKysr
KysrDQogMyBmaWxlcyBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoN
CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tZW1fZW5jcnlwdC5oIGIvYXJjaC94
ODYvaW5jbHVkZS9hc20vbWVtX2VuY3J5cHQuaA0KaW5kZXggNjE2ZjhlNjM3YmMzLi4zZjQzY2Zk
ZDAyMDkgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tZW1fZW5jcnlwdC5oDQor
KysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tZW1fZW5jcnlwdC5oDQpAQCAtOTcsNCArOTcsNyBA
QCBleHRlcm4gY2hhciBfX3N0YXJ0X2Jzc19kZWNyeXB0ZWRbXSwgX19lbmRfYnNzX2RlY3J5cHRl
ZFtdLCBfX3N0YXJ0X2Jzc19kZWNyeXB0ZQ0KIA0KICNlbmRpZgkvKiBfX0FTU0VNQkxZX18gKi8N
CiANCitleHRlcm4gdm9pZCBzZXRfbWVtb3J5X2VuY19kZWNfaHlwZXJjYWxsKHVuc2lnbmVkIGxv
bmcgdmFkZHIsDQorCQkJCQkgdW5zaWduZWQgbG9uZyBzaXplLCBib29sIGVuYyk7DQorDQogI2Vu
ZGlmCS8qIF9fWDg2X01FTV9FTkNSWVBUX0hfXyAqLw0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L21t
L21lbV9lbmNyeXB0LmMgYi9hcmNoL3g4Ni9tbS9tZW1fZW5jcnlwdC5jDQppbmRleCAzODVhZmEy
YjllMTcuLjI0MjYxYjU4YWM5OSAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L21tL21lbV9lbmNyeXB0
LmMNCisrKyBiL2FyY2gveDg2L21tL21lbV9lbmNyeXB0LmMNCkBAIC0xOCw2ICsxOCw3IEBADQog
I2luY2x1ZGUgPGxpbnV4L2RtYS1kaXJlY3QuaD4NCiAjaW5jbHVkZSA8bGludXgvc3dpb3RsYi5o
Pg0KICNpbmNsdWRlIDxsaW51eC9tZW1fZW5jcnlwdC5oPg0KKyNpbmNsdWRlIDxsaW51eC9rdm1f
cGFyYS5oPg0KIA0KICNpbmNsdWRlIDxhc20vdGxiZmx1c2guaD4NCiAjaW5jbHVkZSA8YXNtL2Zp
eG1hcC5oPg0KQEAgLTI4LDYgKzI5LDcgQEANCiAjaW5jbHVkZSA8YXNtL3Byb2Nlc3Nvci1mbGFn
cy5oPg0KICNpbmNsdWRlIDxhc20vbXNyLmg+DQogI2luY2x1ZGUgPGFzbS9jbWRsaW5lLmg+DQor
I2luY2x1ZGUgPGFzbS9rdm1fcGFyYS5oPg0KIA0KICNpbmNsdWRlICJtbV9pbnRlcm5hbC5oIg0K
IA0KQEAgLTE5NSw2ICsxOTcsNDUgQEAgdm9pZCBfX2luaXQgc21lX2Vhcmx5X2luaXQodm9pZCkN
CiAJCXN3aW90bGJfZm9yY2UgPSBTV0lPVExCX0ZPUkNFOw0KIH0NCiANCit2b2lkIHNldF9tZW1v
cnlfZW5jX2RlY19oeXBlcmNhbGwodW5zaWduZWQgbG9uZyB2YWRkciwgdW5zaWduZWQgbG9uZyBz
eiwgYm9vbCBlbmMpDQorew0KKwl1bnNpZ25lZCBsb25nIHZhZGRyX2VuZCwgdmFkZHJfbmV4dDsN
CisNCisJdmFkZHJfZW5kID0gdmFkZHIgKyBzejsNCisNCisJZm9yICg7IHZhZGRyIDwgdmFkZHJf
ZW5kOyB2YWRkciA9IHZhZGRyX25leHQpIHsNCisJCWludCBwc2l6ZSwgcG1hc2ssIGxldmVsOw0K
KwkJdW5zaWduZWQgbG9uZyBwZm47DQorCQlwdGVfdCAqa3B0ZTsNCisNCisJCWtwdGUgPSBsb29r
dXBfYWRkcmVzcyh2YWRkciwgJmxldmVsKTsNCisJCWlmICgha3B0ZSB8fCBwdGVfbm9uZSgqa3B0
ZSkpDQorCQkJcmV0dXJuOw0KKw0KKwkJc3dpdGNoIChsZXZlbCkgew0KKwkJY2FzZSBQR19MRVZF
TF80SzoNCisJCQlwZm4gPSBwdGVfcGZuKCprcHRlKTsNCisJCQlicmVhazsNCisJCWNhc2UgUEdf
TEVWRUxfMk06DQorCQkJcGZuID0gcG1kX3BmbigqKHBtZF90ICopa3B0ZSk7DQorCQkJYnJlYWs7
DQorCQljYXNlIFBHX0xFVkVMXzFHOg0KKwkJCXBmbiA9IHB1ZF9wZm4oKihwdWRfdCAqKWtwdGUp
Ow0KKwkJCWJyZWFrOw0KKwkJZGVmYXVsdDoNCisJCQlyZXR1cm47DQorCQl9DQorDQorCQlwc2l6
ZSA9IHBhZ2VfbGV2ZWxfc2l6ZShsZXZlbCk7DQorCQlwbWFzayA9IHBhZ2VfbGV2ZWxfbWFzayhs
ZXZlbCk7DQorDQorCQlrdm1fc2V2X2h5cGVyY2FsbDMoS1ZNX0hDX1BBR0VfRU5DX1NUQVRVUywN
CisJCQkJICAgcGZuIDw8IFBBR0VfU0hJRlQsIHBzaXplID4+IFBBR0VfU0hJRlQsIGVuYyk7DQor
DQorCQl2YWRkcl9uZXh0ID0gKHZhZGRyICYgcG1hc2spICsgcHNpemU7DQorCX0NCit9DQorDQog
c3RhdGljIHZvaWQgX19pbml0IF9fc2V0X2Nscl9wdGVfZW5jKHB0ZV90ICprcHRlLCBpbnQgbGV2
ZWwsIGJvb2wgZW5jKQ0KIHsNCiAJcGdwcm90X3Qgb2xkX3Byb3QsIG5ld19wcm90Ow0KQEAgLTI1
MiwxMiArMjkzLDEzIEBAIHN0YXRpYyB2b2lkIF9faW5pdCBfX3NldF9jbHJfcHRlX2VuYyhwdGVf
dCAqa3B0ZSwgaW50IGxldmVsLCBib29sIGVuYykNCiBzdGF0aWMgaW50IF9faW5pdCBlYXJseV9z
ZXRfbWVtb3J5X2VuY19kZWModW5zaWduZWQgbG9uZyB2YWRkciwNCiAJCQkJCSAgIHVuc2lnbmVk
IGxvbmcgc2l6ZSwgYm9vbCBlbmMpDQogew0KLQl1bnNpZ25lZCBsb25nIHZhZGRyX2VuZCwgdmFk
ZHJfbmV4dDsNCisJdW5zaWduZWQgbG9uZyB2YWRkcl9lbmQsIHZhZGRyX25leHQsIHN0YXJ0Ow0K
IAl1bnNpZ25lZCBsb25nIHBzaXplLCBwbWFzazsNCiAJaW50IHNwbGl0X3BhZ2Vfc2l6ZV9tYXNr
Ow0KIAlpbnQgbGV2ZWwsIHJldDsNCiAJcHRlX3QgKmtwdGU7DQogDQorCXN0YXJ0ID0gdmFkZHI7
DQogCXZhZGRyX25leHQgPSB2YWRkcjsNCiAJdmFkZHJfZW5kID0gdmFkZHIgKyBzaXplOw0KIA0K
QEAgLTMwOCw2ICszNTAsNyBAQCBzdGF0aWMgaW50IF9faW5pdCBlYXJseV9zZXRfbWVtb3J5X2Vu
Y19kZWModW5zaWduZWQgbG9uZyB2YWRkciwNCiANCiAJcmV0ID0gMDsNCiANCisJc2V0X21lbW9y
eV9lbmNfZGVjX2h5cGVyY2FsbChzdGFydCwgc2l6ZSwgZW5jKTsNCiBvdXQ6DQogCV9fZmx1c2hf
dGxiX2FsbCgpOw0KIAlyZXR1cm4gcmV0Ow0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL3BhZ2Vh
dHRyLmMgYi9hcmNoL3g4Ni9tbS9wYWdlYXR0ci5jDQppbmRleCA0YzU3MDYxMmUyNGUuLmIxYTY4
ODc5ZjY2ZCAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L21tL3BhZ2VhdHRyLmMNCisrKyBiL2FyY2gv
eDg2L21tL3BhZ2VhdHRyLmMNCkBAIC0yNSw2ICsyNSw3IEBADQogI2luY2x1ZGUgPGFzbS9wcm90
by5oPg0KICNpbmNsdWRlIDxhc20vcGF0Lmg+DQogI2luY2x1ZGUgPGFzbS9zZXRfbWVtb3J5Lmg+
DQorI2luY2x1ZGUgPGFzbS9tZW1fZW5jcnlwdC5oPg0KIA0KICNpbmNsdWRlICJtbV9pbnRlcm5h
bC5oIg0KIA0KQEAgLTIwMTksNiArMjAyMCwxMiBAQCBpbnQgc2V0X21lbW9yeV9nbG9iYWwodW5z
aWduZWQgbG9uZyBhZGRyLCBpbnQgbnVtcGFnZXMpDQogCQkJCSAgICBfX3BncHJvdChfUEFHRV9H
TE9CQUwpLCAwKTsNCiB9DQogDQordm9pZCBfX2F0dHJpYnV0ZV9fKCh3ZWFrKSkgc2V0X21lbW9y
eV9lbmNfZGVjX2h5cGVyY2FsbCh1bnNpZ25lZCBsb25nIGFkZHIsDQorCQkJCQkJCXVuc2lnbmVk
IGxvbmcgc2l6ZSwNCisJCQkJCQkJYm9vbCBlbmMpDQorew0KK30NCisNCiBzdGF0aWMgaW50IF9f
c2V0X21lbW9yeV9lbmNfZGVjKHVuc2lnbmVkIGxvbmcgYWRkciwgaW50IG51bXBhZ2VzLCBib29s
IGVuYykNCiB7DQogCXN0cnVjdCBjcGFfZGF0YSBjcGE7DQpAQCAtMjA1OSw2ICsyMDY2LDE0IEBA
IHN0YXRpYyBpbnQgX19zZXRfbWVtb3J5X2VuY19kZWModW5zaWduZWQgbG9uZyBhZGRyLCBpbnQg
bnVtcGFnZXMsIGJvb2wgZW5jKQ0KIAkgKi8NCiAJY3BhX2ZsdXNoKCZjcGEsIDApOw0KIA0KKwkv
Kg0KKwkgKiBXaGVuIFNFViBpcyBhY3RpdmUsIG5vdGlmeSBoeXBlcnZpc29yIHRoYXQgYSBnaXZl
biBtZW1vcnkgcmFuZ2UgaXMgbWFwcGVkDQorCSAqIGVuY3J5cHRlZCBvciBkZWNyeXB0ZWQuIEh5
cGVydmlzb3Igd2lsbCB1c2UgdGhpcyBpbmZvcm1hdGlvbiBkdXJpbmcNCisJICogdGhlIFZNIG1p
Z3JhdGlvbi4NCisJICovDQorCWlmIChzZXZfYWN0aXZlKCkpDQorCQlzZXRfbWVtb3J5X2VuY19k
ZWNfaHlwZXJjYWxsKGFkZHIsIG51bXBhZ2VzIDw8IFBBR0VfU0hJRlQsIGVuYyk7DQorDQogCXJl
dHVybiByZXQ7DQogfQ0KIA0KLS0gDQoyLjE3LjENCg0K

