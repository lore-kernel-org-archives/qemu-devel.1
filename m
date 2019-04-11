Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBBDC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 14:35:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62A4F206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 14:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MMluVUEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A4F206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49941 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEanp-0003oF-82
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 10:35:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEam8-0002rv-7L
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEam6-0004N4-RW
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:34:00 -0400
Received: from mail-ve1eur03on0711.outbound.protection.outlook.com
	([2a01:111:f400:fe09::711]:7952
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hEam5-0004Ks-Ad; Thu, 11 Apr 2019 10:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Zn8nKelapxjP1M/7hRwo6pVCV+X50+ISrLJQe8TLJrg=;
	b=MMluVUECmSkhG3plMJmJsu01tlreozCTifXrhgANAafcAAr56SpE42/0NnsQgD/LXqk0Vz4kB3gCdPMnYANvy7iOlsjAwzArwZQImYoblnutJVmk6mZ2TMHLvpS9kGJEa6+VaadjDwxDNaKcNlksYejxR2/UPc61+EEiozBIvpU=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3002.eurprd08.prod.outlook.com (52.134.109.156) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.19; Thu, 11 Apr 2019 14:33:46 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1771.021;
	Thu, 11 Apr 2019 14:33:46 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [PATCH v2 2/6] qemu-img: Add salvaging mode to convert
Thread-Index: AQHU7+AAiPxuQx+lk0aT0pbmGGq3XqY3B2CA
Date: Thu, 11 Apr 2019 14:33:46 +0000
Message-ID: <acb069c8-5207-368e-e972-baa2ba44d850@virtuozzo.com>
References: <20190410205715.2209-1-mreitz@redhat.com>
	<20190410205715.2209-3-mreitz@redhat.com>
In-Reply-To: <20190410205715.2209-3-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0079.eurprd09.prod.outlook.com
	(2603:10a6:7:3d::23) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190411173343853
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2934e394-299b-4cda-56e6-08d6be8ab478
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3002; 
x-ms-traffictypediagnostic: DB7PR08MB3002:
x-microsoft-antispam-prvs: <DB7PR08MB3002C39549A6C03589F479C4C12F0@DB7PR08MB3002.eurprd08.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(376002)(136003)(396003)(39840400004)(366004)(189003)(199004)(86362001)(2501003)(26005)(186003)(54906003)(110136005)(7736002)(25786009)(71200400001)(66066001)(107886003)(229853002)(316002)(97736004)(81166006)(305945005)(71190400001)(53936002)(14454004)(6486002)(81156014)(8936002)(8676002)(6246003)(102836004)(105586002)(5660300002)(31696002)(6436002)(68736007)(31686004)(6512007)(3846002)(6116002)(52116002)(76176011)(99286004)(2616005)(476003)(386003)(446003)(6506007)(256004)(11346002)(106356001)(36756003)(4326008)(478600001)(486006)(2906002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3002;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SVHHJB2ruPeCMSvuX66JhSZC3wGvMD+EvMaUIm9XIZngPdsr4R53iR6MOyc0W9OwLlbUBuIVTgDM4VK/ApqlaG9YVSK7PGmTQf/P8VbqAijkOlllqd4ULBV1oVLfH82+9P7PiOhXcvecfIGjdaCQlnJymiHCGvB4Kvm50xnGWnki5rsDE1VFfEtx6akf1XuVloS+LCrsvXwGwRi/DZ4E5N0XoF1zW1J9JhqbVB/zlJlGq+4dsRs+2jy5UDi5AzxPu6EYCRfW4rg82aEc6oGdoJa7CKYiMbPnu9nNNYe9IFSy4Eso8rzlO7/5+ciNJcJ9uJ1wJ4UmJ/Iw9eUNdwcTYfG/tw8cASx6VsrgFwZ5Y06pCftHQ1i6OgX4coCL+Zs7oKOBaN1RoLdbbMkOXoTZnofd9o6XD4mIC9B+ZJsFbUs=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <D1551631D7758F4291502F5A2E12A034@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2934e394-299b-4cda-56e6-08d6be8ab478
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 14:33:46.3874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3002
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe09::711
Subject: Re: [Qemu-devel] [PATCH v2 2/6] qemu-img: Add salvaging mode to
 convert
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411143346.h0czAxW6Lw5XAeNMuohCRM7GByDb-eUP-ojhfmj1rpc@z>

MTAuMDQuMjAxOSAyMzo1NywgTWF4IFJlaXR6IHdyb3RlOg0KPiBUaGlzIGFkZHMgYSBzYWx2YWdp
bmcgbW9kZSAoLS1zYWx2YWdlKSB0byBxZW11LWltZyBjb252ZXJ0IHdoaWNoIGlnbm9yZXMNCj4g
cmVhZCBlcnJvcnMgYW5kIHRyZWF0cyB0aGUgcmVzcGVjdGl2ZSBhcmVhcyBhcyBjb250YWluaW5n
IG9ubHkgemVyb2VzLg0KPiBUaGlzIGNhbiBiZSB1c2VkIGZvciBpbnN0YW5jZSB0byBhdCBsZWFz
dCBwYXJ0aWFsbHkgcmVjb3ZlciB0aGUgZGF0YQ0KPiBmcm9tIHRlcm1pbmFsbHkgY29ycnVwdGVk
IHFjb3cyIGltYWdlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJl
ZGhhdC5jb20+DQo+IC0tLQ0KDQpbLi5dDQoNCj4gLS0tIGEvcWVtdS1pbWcudGV4aQ0KPiArKysg
Yi9xZW11LWltZy50ZXhpDQo+IEBAIC0xNzUsNiArMTc1LDExIEBAIGltcHJvdmUgcGVyZm9ybWFu
Y2UgaWYgdGhlIGRhdGEgaXMgcmVtb3RlLCBzdWNoIGFzIHdpdGggTkZTIG9yIGlTQ1NJIGJhY2tl
bmRzLA0KPiAgIGJ1dCB3aWxsIG5vdCBhdXRvbWF0aWNhbGx5IHNwYXJzaWZ5IHplcm8gc2VjdG9y
cywgYW5kIG1heSByZXN1bHQgaW4gYSBmdWxseQ0KPiAgIGFsbG9jYXRlZCB0YXJnZXQgaW1hZ2Ug
ZGVwZW5kaW5nIG9uIHRoZSBob3N0IHN1cHBvcnQgZm9yIGdldHRpbmcgYWxsb2NhdGlvbg0KPiAg
IGluZm9ybWF0aW9uLg0KPiArQGl0ZW0gLS1zYWx2YWdlDQo+ICtUcnkgdG8gaWdub3JlIEkvTyBl
cnJvcnMgd2hlbiByZWFkaW5nLiAgVW5sZXNzIGluIHF1aWV0IG1vZGUgKEBjb2Rley1xfSksIGVy
cm9ycw0KPiArd2lsbCBzdGlsbCBiZSBwcmludGVkLiAgQXJlYXMgdGhhdCBjYW5ub3QgYmUgcmVh
ZCBmcm9tIHRoZSBzb3VyY2Ugd2lsbCBiZQ0KPiArdHJlYXRlZCBhcyBjb250YWluaW5nIG9ubHkg
emVyb2VzLiAgVGhpcyBvcHRpb24gaGFzIG5vIGVmZmVjdCBpbiBjb3B5IG9mZmxvYWRpbmcNCj4g
K21vZGUgKEBjb2Rley1DfSkuDQoNCklzbid0IGl0IGJldHRlciB0byByZXN0cmljdCBzdWNoIGl0
LCBpbnN0ZWFkIG9mIGNyZWF0aW5nIG1lYW5pbmdsZXNzIGNvbWJpbmF0aW9uPw0KQW5kIGRyb3Ag
dGhlIHJlc3RyaWN0aW9uIGlmIHdlIHN1cHBvcnQgaXQgaW4gZnV0dXJlLCBpbnN0ZWFkIG9mIHNp
bGVudCBtb3ZlIGZyb20NCm5vb3AgdG8gdGhlIGZlYXR1cmU/DQoNCk90aGVyd2lzZSwgbG9va3Mg
T0sgZm9yIG1lLiBJIGRpc2xpa2UgbWl4aW5nIGJ5dGUtYmFzZWQgYW5kIHNlY3Rvci1iYXNlZCBs
b2dpYywgYnV0IGl0DQppcyBub3QgYWJvdXQgdGhlIHNlcmllcywgd2Ugc2hvdWxkIG1vdmUgdG8g
Ynl0ZS1iYXNlZCBsaWtlIGluIG90aGVyIHBsYWNlcywgYW5kIGl0IG1heQ0KYmUgZG9uZSBsYXRl
ci4NCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

