Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C76C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 16:16:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5BC7208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 16:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lq3NT+tF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5BC7208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44080 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJKZA-0007aS-Sy
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 12:16:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hJKTw-0002P5-JH
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hJKTn-0004EB-My
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:46 -0400
Received: from mail-eopbgr780088.outbound.protection.outlook.com
	([40.107.78.88]:16416
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1hJKTn-0003kU-Ds
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=I0lXV5tySe2KfbECTa8PFrwmGekrzFQvQXc0vjomi4M=;
	b=lq3NT+tFYx/VHok/GHZsABANNvJHneNrExfJiVmj/9rMJPnZzFUOmxXAXuTJ2d/aIEBBbMmXiK/3Lsx+dSEncFPEc/Y+RviMlYQusCvKJUbB64XKj3EBe865NP96FzbhfX8tKBgXCQNDpL+csHoX2nQSGpzavzQ+JKtfEk5feuQ=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
	DM6PR12MB2907.namprd12.prod.outlook.com (20.179.71.213) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.12; Wed, 24 Apr 2019 16:10:07 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43]) by
	DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43%5]) with mapi id 15.20.1813.017;
	Wed, 24 Apr 2019 16:10:07 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Thread-Topic: [RFC PATCH v1 07/10] KVM: x86: Add AMD SEV specific Hypercall3
Thread-Index: AQHU+rgvbIcbaP1/MEei2P+PkK1plQ==
Date: Wed, 24 Apr 2019 16:10:07 +0000
Message-ID: <20190424160942.13567-8-brijesh.singh@amd.com>
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
x-ms-office365-filtering-correlation-id: ded7b687-5cb4-47b4-3c89-08d6c8cf51a0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB2907; 
x-ms-traffictypediagnostic: DM6PR12MB2907:
x-microsoft-antispam-prvs: <DM6PR12MB2907CDA86FF44B8B502D36FBE53C0@DM6PR12MB2907.namprd12.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(39860400002)(136003)(366004)(396003)(376002)(346002)(189003)(199004)(1730700003)(99286004)(2501003)(73956011)(478600001)(11346002)(6506007)(76176011)(14454004)(6116002)(52116002)(386003)(476003)(25786009)(66946007)(486006)(4326008)(71200400001)(66446008)(66556008)(3846002)(66476007)(64756008)(1076003)(71190400001)(446003)(186003)(2616005)(5660300002)(2351001)(102836004)(97736004)(26005)(86362001)(6512007)(8676002)(66066001)(8936002)(68736007)(2906002)(50226002)(256004)(81156014)(305945005)(36756003)(316002)(6436002)(54906003)(7736002)(5640700003)(81166006)(53936002)(6916009)(6486002)(7416002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2907;
	H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: brQEv9LUFoYSOlzWpl3hYIQjBh78chXdupB4Fh2XSspzuBSAK6odfTF8LQsKef9vLR6a1aW3+s/ryjR7kPT4d+IsmR1AboV/qqzVVEFpp51rPPQmUvJpR9KHmX5U5UsrYjjh7jDPj4oluPEzzEAes6TWbdet0RjstVDcPPY8a1twK97pZaHgfSdybdxoM42kjUG+T+BW+uaBvYshqTQj8cddZr7cxWTjuMBhltDIj88h5M7h9XSHoF4RbRPa2WxV1RK7dWRZ+kop83mvyzKflXqzgbrLR/emQKuOJPvglJdxJ8aE3WIZ/ntPEA378+N5GAc4k5vRDAtPMcIVxWyJ2Q8qMCX3DvZfLMYtHhHcR8u4DpKeo7Hju0/TVcFV7CsLCBpL9iwDORc6UZ9nQyP/NbsXTEfEh7PZApOLT+sM97A=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <6C26546F6C64B3438A26C98CB0F1C566@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded7b687-5cb4-47b4-3c89-08d6c8cf51a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 16:10:07.6157 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2907
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.78.88
Subject: [Qemu-devel] [RFC PATCH v1 07/10] KVM: x86: Add AMD SEV specific
 Hypercall3
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
Message-ID: <20190424161007.HFoucd8_9QdfKjdNaHW3W53q6dQlQ0DDU5soVbxclUo@z>

S1ZNIGh5cGVyY2FsbCBmcmFtZXdvcmsgcmVsaWVzIG9uIGFsdGVybmF0aXZlIGZyYW1ld29yayB0
byBwYXRjaCB0aGUNClZNQ0FMTCAtPiBWTU1DQUxMIG9uIEFNRCBwbGF0Zm9ybS4gSWYgYSBoeXBl
cmNhbGwgaXMgbWFkZSBiZWZvcmUNCmFwcGx5X2FsdGVybmF0aXZlKCkgaXMgY2FsbGVkIHRoZW4g
aXQgZGVmYXVsdHMgdG8gVk1DQUxMLiBUaGUgYXBwcm9hY2gNCndvcmtzIGZpbmUgb24gbm9uIFNF
ViBndWVzdC4gQSBWTUNBTEwgd291bGQgY2F1c2VzICNVRCwgYW5kIGh5cGVydmlzb3INCndpbGwg
YmUgYWJsZSB0byBkZWNvZGUgdGhlIGluc3RydWN0aW9uIGFuZCBkbyB0aGUgcmlnaHQgdGhpbmdz
LiBCdXQNCndoZW4gU0VWIGlzIGFjdGl2ZSwgZ3Vlc3QgbWVtb3J5IGlzIGVuY3J5cHRlZCB3aXRo
IGd1ZXN0IGtleSBhbmQNCmh5cGVydmlzb3Igd2lsbCBub3QgYmUgYWJsZSB0byBkZWNvZGUgdGhl
IGluc3RydWN0aW9uIGJ5dGVzLg0KDQpBZGQgU0VWIHNwZWNpZmljIGh5cGVyY2FsbDMsIGl0IHVu
Y29uZGl0aW9uYWxseSB1c2VzIFZNTUNBTEwuIFRoZSBoeXBlcmNhbGwNCndpbGwgYmUgdXNlZCBi
eSB0aGUgU0VWIGd1ZXN0IHRvIG5vdGlmeSBlbmNyeXB0ZWQgcGFnZXMgdG8gdGhlIGh5cGVydmlz
b3IuDQoNCkNjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCkNjOiBJbmdv
IE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT4NCkNjOiAiSC4gUGV0ZXIgQW52aW4iIDxocGFAenl0
b3IuY29tPg0KQ2M6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+DQpDYzogIlJh
ZGltIEtyxI1tw6HFmSIgPHJrcmNtYXJAcmVkaGF0LmNvbT4NCkNjOiBKb2VyZyBSb2VkZWwgPGpv
cm9AOGJ5dGVzLm9yZz4NCkNjOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQHN1c2UuZGU+DQpDYzogVG9t
IExlbmRhY2t5IDx0aG9tYXMubGVuZGFja3lAYW1kLmNvbT4NCkNjOiB4ODZAa2VybmVsLm9yZw0K
Q2M6IGt2bUB2Z2VyLmtlcm5lbC5vcmcNCkNjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
DQpTaWduZWQtb2ZmLWJ5OiBCcmlqZXNoIFNpbmdoIDxicmlqZXNoLnNpbmdoQGFtZC5jb20+DQot
LS0NCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1fcGFyYS5oIHwgMTIgKysrKysrKysrKysrDQog
MSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2luY2x1ZGUvYXNtL2t2bV9wYXJhLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1fcGFyYS5o
DQppbmRleCA1ZWQzY2YxYzM5MzQuLjk0ZTkxYzBiYzJlMCAxMDA2NDQNCi0tLSBhL2FyY2gveDg2
L2luY2x1ZGUvYXNtL2t2bV9wYXJhLmgNCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9w
YXJhLmgNCkBAIC04NCw2ICs4NCwxOCBAQCBzdGF0aWMgaW5saW5lIGxvbmcga3ZtX2h5cGVyY2Fs
bDQodW5zaWduZWQgaW50IG5yLCB1bnNpZ25lZCBsb25nIHAxLA0KIAlyZXR1cm4gcmV0Ow0KIH0N
CiANCitzdGF0aWMgaW5saW5lIGxvbmcga3ZtX3Nldl9oeXBlcmNhbGwzKHVuc2lnbmVkIGludCBu
ciwgdW5zaWduZWQgbG9uZyBwMSwNCisJCQkJICAgICAgdW5zaWduZWQgbG9uZyBwMiwgdW5zaWdu
ZWQgbG9uZyBwMykNCit7DQorCWxvbmcgcmV0Ow0KKw0KKwlhc20gdm9sYXRpbGUoInZtbWNhbGwi
DQorCQkgICAgIDogIj1hIihyZXQpDQorCQkgICAgIDogImEiKG5yKSwgImIiKHAxKSwgImMiKHAy
KSwgImQiKHAzKQ0KKwkJICAgICA6ICJtZW1vcnkiKTsNCisJcmV0dXJuIHJldDsNCit9DQorDQog
I2lmZGVmIENPTkZJR19LVk1fR1VFU1QNCiBib29sIGt2bV9wYXJhX2F2YWlsYWJsZSh2b2lkKTsN
CiB1bnNpZ25lZCBpbnQga3ZtX2FyY2hfcGFyYV9mZWF0dXJlcyh2b2lkKTsNCi0tIA0KMi4xNy4x
DQoNCg==

