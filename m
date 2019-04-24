Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4171C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 16:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AAB4208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 16:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N3BZeE+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AAB4208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44013 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJKVL-0003GQ-KK
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 12:12:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hJKTP-0001wP-NL
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hJKTG-0003YR-1L
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:15 -0400
Received: from mail-eopbgr780073.outbound.protection.outlook.com
	([40.107.78.73]:27328
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1hJKTD-0003PD-9e
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=dui2qMpD3nJ6b1BVahn6iBrgETSYyXno8AljJD17ha4=;
	b=N3BZeE+bQZ8c4X3VgIIr2VhQ0mC1fsrRlaE64GezV4d8iKKi9ck83DdMQf9taExCIFvtnwek5Me0AVYlsb/O5zqaPCGziKWPoM+mfOs5aPDp1BX84tZdWPh4FQ6IFd35T0tCnWcayrcCq4Deb+rkusz9E55qq4Cu5OWoZ1rGQq8=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
	DM6PR12MB2907.namprd12.prod.outlook.com (20.179.71.213) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.12; Wed, 24 Apr 2019 16:09:58 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43]) by
	DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43%5]) with mapi id 15.20.1813.017;
	Wed, 24 Apr 2019 16:09:58 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Thread-Topic: [RFC PATCH v1 00/10] Add AMD SEV guest live migration support
Thread-Index: AQHU+rgpwai7tJB3uUaULXjJMShjVQ==
Date: Wed, 24 Apr 2019 16:09:58 +0000
Message-ID: <20190424160942.13567-1-brijesh.singh@amd.com>
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
x-ms-office365-filtering-correlation-id: a232132e-0b1d-4919-222b-08d6c8cf4c35
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB2907; 
x-ms-traffictypediagnostic: DM6PR12MB2907:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DM6PR12MB2907870F4046F203CB030C0BE53C0@DM6PR12MB2907.namprd12.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(39860400002)(136003)(366004)(396003)(376002)(346002)(189003)(199004)(1730700003)(99286004)(2501003)(73956011)(478600001)(6506007)(14454004)(966005)(6116002)(52116002)(386003)(476003)(25786009)(66946007)(486006)(4326008)(71200400001)(66446008)(66556008)(3846002)(66476007)(64756008)(1076003)(66574012)(71190400001)(186003)(2616005)(5660300002)(2351001)(102836004)(97736004)(26005)(14444005)(86362001)(6512007)(8676002)(66066001)(6306002)(8936002)(68736007)(2906002)(50226002)(256004)(81156014)(305945005)(36756003)(316002)(6436002)(54906003)(7736002)(5640700003)(81166006)(53936002)(6916009)(6486002)(7416002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2907;
	H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tpAzzmY9nbv5hx+9QFqMOOeF98xVZM/etoQR5Nlj+G5/jKvCiH/+TDZ3N8YtTZAS8CilOgNzWX8zjlbKpzPsSFCR1IROlb6z/zyk2ZIbcU6XpYBDBgZI3sqAKG1dpWvK7m7UGLfDVjC/uQ81cRcH4ryY/iOovc4J5Z8aBbF14jpRUHSMEwb1Sy7TRHXq5WYIq4MtkY+P3SsfG4P5xQmqzCH7yeJKiAAjQgZkxhn4m1pwijPqICQuW0A3FfQfD27zsZXggJ6yPvwd95ibZqjg7Tf+YreIWOiJA0+L8z2lXCDCS05RQ+RGvqBurw4eppHdTKygCPeAVOVv6bqOMUbGyPWkTrA2I7oC71lUYaOGjvFAJB+OOcZzAXqqEz+TRk1hdqAalX/HEq5TdiGSDJQJh5mFfaMiEBeW5t77SpiynBI=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <E0D8780B4ABB474EAE9EACD7D2C035AF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a232132e-0b1d-4919-222b-08d6c8cf4c35
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 16:09:58.5242 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2907
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.78.73
Subject: [Qemu-devel] [RFC PATCH v1 00/10] Add AMD SEV guest live migration
 support
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
Message-ID: <20190424160958.xBrhi5EFrlqOAgn8mCYO1rvRRt2HLU6wURrcjqPnX38@z>

VGhlIHNlcmllcyBhZGQgc3VwcG9ydCBmb3IgQU1EIFNFViBndWVzdCBsaXZlIG1pZ3JhdGlvbiBj
b21tYW5kcy4gVG8gcHJvdGVjdCB0aGUNCmNvbmZpZGVudGlhbGl0eSBvZiBhbiBTRVYgcHJvdGVj
dGVkIGd1ZXN0IG1lbW9yeSB3aGlsZSBpbiB0cmFuc2l0IHdlIG5lZWQgdG8NCnVzZSB0aGUgU0VW
IGNvbW1hbmRzIGRlZmluZWQgaW4gU0VWIEFQSSBzcGVjIFsxXS4NCg0KU0VWIGd1ZXN0IFZNcyBo
YXZlIHRoZSBjb25jZXB0IG9mIHByaXZhdGUgYW5kIHNoYXJlZCBtZW1vcnkuIFByaXZhdGUgbWVt
b3J5DQppcyBlbmNyeXB0ZWQgd2l0aCB0aGUgZ3Vlc3Qtc3BlY2lmaWMga2V5LCB3aGlsZSBzaGFy
ZWQgbWVtb3J5IG1heSBiZSBlbmNyeXB0ZWQNCndpdGggaHlwZXJ2aXNvciBrZXkuIFRoZSBjb21t
YW5kcyBwcm92aWRlZCBieSB0aGUgU0VWIEZXIGFyZSBtZWFudCB0byBiZSB1c2VkDQpmb3IgdGhl
IHByaXZhdGUgbWVtb3J5IG9ubHkuIFRoZSBwYXRjaCBzZXJpZXMgaW50cm9kdWNlcyBhIG5ldyBo
eXBlcmNhbGwuDQpUaGUgZ3Vlc3QgT1MgY2FuIHVzZSB0aGlzIGh5cGVyY2FsbCB0byBub3RpZnkg
dGhlIHBhZ2UgZW5jcnlwdGlvbiBzdGF0dXMuDQpJZiB0aGUgcGFnZSBpcyBlbmNyeXB0ZWQgd2l0
aCBndWVzdCBzcGVjaWZpYy1rZXkgdGhlbiB3ZSB1c2UgU0VWIGNvbW1hbmQgZHVyaW5nDQp0aGUg
bWlncmF0aW9uLiBJZiBwYWdlIGlzIG5vdCBlbmNyeXB0ZWQgdGhlbiBmYWxsYmFjayB0byBkZWZh
dWx0Lg0KDQpUaGUgcGF0Y2ggYWRkcyBhIG5ldyBpb2N0bCBLVk1fR0VUX1BBR0VfRU5DX0JJVE1B
UC4gVGhlIGlvY3RsIGNhbiBiZSB1c2VkDQpieSB0aGUgcWVtdSB0byBnZXQgdGhlIHBhZ2UgZW5j
cnlwdGVkIGJpdG1hcC4gUWVtdSBjYW4gY29uc3VsdCB0aGlzIGJpdG1hcA0KZHVyaW5nIHRoZSBt
aWdyYXRpb24gdG8ga25vdyB3aGV0aGVyIHRoZSBwYWdlIGlzIGVuY3J5cHRlZC4NCg0KWzFdIGh0
dHBzOi8vZGV2ZWxvcGVyLmFtZC5jb20vd3AtY29udGVudC9yZXNvdXJjZXMvNTU3NjYuUERGDQoN
ClRoZSBzZXJpZXMgaXMgdGVzdGVkIHdpdGggdGhlIFFlbXUsIEkgYW0gaW4gcHJvY2VzcyBvZiBj
bGVhbmluZw0KdXAgdGhlIFFlbXUgY29kZSBhbmQgd2lsbCBzdWJtaXQgc29vbi4NCg0KV2hpbGUg
aW1wbGVtZW50aW5nIHRoZSBtaWdyYXRpb24gSSBzdHVtYmxlZCBvbiB0aGUgZm9sbG93IHF1ZXN0
aW9uOg0KDQotIFNpbmNlIHRoZXJlIGlzIGEgZ3Vlc3QgT1MgY2hhbmdlcyByZXF1aXJlZCB0byBz
dXBwb3J0IHRoZSBtaWdyYXRpb24sDQogIHNvIGhvdyBkbyB3ZSBrbm93IHdoZXRoZXIgZ3Vlc3Qg
T1MgaXMgdXBkYXRlZD8gU2hvdWxkIHdlIGV4dGVuZCBLVk0NCiAgY2FwYWJpbGl0aWVzL2ZlYXR1
cmUgYml0cyB0byBjaGVjayB0aGlzPw0KDQpUT0RPOg0KIC0gYWRkIGFuIGlvY3RsIHRvIGJ1aWxk
IGVuY3J5cHRpb24gYml0bWFwLiBUaGUgZW5jcnlwdGlvbiBiaXRtYXAgaXMgYnVpbHQgZHVyaW5n
DQogICB0aGUgZ3Vlc3QgYm9vdHVwL2V4ZWN1dGlvbi4gV2Ugc2hvdWxkIHByb3ZpZGUgYW4gaW9j
dGwgc28gdGhhdCBkZXN0aW5hdGlvbg0KICAgY2FuIGJ1aWxkIHRoZSBiaXRtYXAgYXMgaXQgcmVj
ZWl2ZXMgdGhlIHBhZ2VzLiANCiAtIHJlc2V0IHRoZSBiaXRtYXAgb24gZ3Vlc3QgcmVib290Lg0K
DQpUaGUgY29tcGxldGUgdHJlZSB3aXRoIHBhdGNoIGlzIGF2YWlsYWJsZSBhdDoNCmh0dHBzOi8v
Z2l0aHViLmNvbS9jb2RvbWFuaWEva3ZtL3RyZWUvc2V2LW1pZ3JhdGlvbi1yZmMtdjENCg0KQ2M6
IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KQ2M6IEluZ28gTW9sbmFyIDxt
aW5nb0ByZWRoYXQuY29tPg0KQ2M6ICJILiBQZXRlciBBbnZpbiIgPGhwYUB6eXRvci5jb20+DQpD
YzogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCkNjOiAiUmFkaW0gS3LEjW3D
ocWZIiA8cmtyY21hckByZWRoYXQuY29tPg0KQ2M6IEpvZXJnIFJvZWRlbCA8am9yb0A4Ynl0ZXMu
b3JnPg0KQ2M6IEJvcmlzbGF2IFBldGtvdiA8YnBAc3VzZS5kZT4NCkNjOiBUb20gTGVuZGFja3kg
PHRob21hcy5sZW5kYWNreUBhbWQuY29tPg0KQ2M6IHg4NkBrZXJuZWwub3JnDQpDYzoga3ZtQHZn
ZXIua2VybmVsLm9yZw0KQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCg0KQnJpamVz
aCBTaW5naCAoMTApOg0KICBLVk06IFNWTTogQWRkIEtWTV9TRVYgU0VORF9TVEFSVCBjb21tYW5k
DQogIEtWTTogU1ZNOiBBZGQgS1ZNX1NFTkRfVVBEQVRFX0RBVEEgY29tbWFuZA0KICBLVk06IFNW
TTogQWRkIEtWTV9TRVZfU0VORF9GSU5JU0ggY29tbWFuZA0KICBLVk06IFNWTTogQWRkIHN1cHBv
cnQgZm9yIEtWTV9TRVZfUkVDRUlWRV9TVEFSVCBjb21tYW5kDQogIEtWTTogU1ZNOiBBZGQgS1ZN
X1NFVl9SRUNFSVZFX1VQREFURV9EQVRBIGNvbW1hbmQNCiAgS1ZNOiBTVk06IEFkZCBLVk1fU0VW
X1JFQ0VJVkVfRklOSVNIIGNvbW1hbmQNCiAgS1ZNOiB4ODY6IEFkZCBBTUQgU0VWIHNwZWNpZmlj
IEh5cGVyY2FsbDMNCiAgS1ZNOiBYODY6IEludHJvZHVjZSBLVk1fSENfUEFHRV9FTkNfU1RBVFVT
IGh5cGVyY2FsbA0KICBLVk06IHg4NjogSW50cm9kdWNlIEtWTV9HRVRfUEFHRV9FTkNfQklUTUFQ
IGlvY3RsDQogIG1tOiB4ODY6IEludm9rZSBoeXBlcmNhbGwgd2hlbiBwYWdlIGVuY3J5cHRpb24g
c3RhdHVzIGlzIGNoYW5nZWQNCg0KIC4uLi92aXJ0dWFsL2t2bS9hbWQtbWVtb3J5LWVuY3J5cHRp
b24ucnN0ICAgICB8IDExNiArKysrDQogRG9jdW1lbnRhdGlvbi92aXJ0dWFsL2t2bS9oeXBlcmNh
bGxzLnR4dCAgICAgIHwgIDE0ICsNCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oICAg
ICAgICAgICAgICAgfCAgIDMgKw0KIGFyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9wYXJhLmggICAg
ICAgICAgICAgICB8ICAxMiArDQogYXJjaC94ODYvaW5jbHVkZS9hc20vbWVtX2VuY3J5cHQuaCAg
ICAgICAgICAgIHwgICAzICsNCiBhcmNoL3g4Ni9rdm0vc3ZtLmMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCA1NjAgKysrKysrKysrKysrKysrKystDQogYXJjaC94ODYva3ZtL3ZteC92bXgu
YyAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCiBhcmNoL3g4Ni9rdm0veDg2LmMgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTcgKw0KIGFyY2gveDg2L21tL21lbV9lbmNyeXB0
LmMgICAgICAgICAgICAgICAgICAgICB8ICA0NSArLQ0KIGFyY2gveDg2L21tL3BhZ2VhdHRyLmMg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAxNSArDQogaW5jbHVkZS91YXBpL2xpbnV4L2t2bS5o
ICAgICAgICAgICAgICAgICAgICAgIHwgIDUxICsrDQogaW5jbHVkZS91YXBpL2xpbnV4L2t2bV9w
YXJhLmggICAgICAgICAgICAgICAgIHwgICAxICsNCiAxMiBmaWxlcyBjaGFuZ2VkLCA4MzQgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjE3LjENCg0K

