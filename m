Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81983C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 23:56:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39C4C20874
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 23:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="W9Ogjw4z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YiRkdX5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C4C20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50827 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE0bf-0000NV-E6
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 19:56:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=99569c54a=Alistair.Francis@wdc.com>)
	id 1hE0aQ-0007n4-Am
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=99569c54a=Alistair.Francis@wdc.com>)
	id 1hE0aP-0002BR-3S
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:55:30 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:10502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=99569c54a=Alistair.Francis@wdc.com>)
	id 1hE0aO-0001vk-Kx
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1554854129; x=1586390129;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:content-transfer-encoding: mime-version;
	bh=AEvpYvbv1JN9iM4m3bHshZw4jIZBngwNw1E7zTPyMhM=;
	b=W9Ogjw4z9do8lxEJLdBmEzaDW0I+NCuV2P1Frpus8gM5JVy4/SLaRvuM
	Jq9FCgTBUjz2Qu4sjdYE9Om5Nz/hfFMhafxVU9sZstHqaVLkuVJyklZRO
	4Q5uETPcKSWQC7ZCK/G0uzICnfyBIL97mRU/j9cDxk8ncHQD1G8Ao/C8q
	yozyof2UdnV1Tspbzh4aUSbdAqLTfIL411LJLwBywKJX5SSq2mrIrpIZa
	dLCy46OoHMePrCWmK/o6I8qyexUD9J39DzpSXOejQEZDWwjwAHKnWrSJq
	oWtnLpQmRg8EpjGE8y/hdZZf3z6jI0P0kYUHCC7+SGqBZNhhPaUARaGD4 A==;
X-IronPort-AV: E=Sophos;i="5.60,331,1549900800"; d="scan'208";a="110433616"
Received: from mail-co1nam05lp2050.outbound.protection.outlook.com (HELO
	NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.50])
	by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2019 07:55:19 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=AEvpYvbv1JN9iM4m3bHshZw4jIZBngwNw1E7zTPyMhM=;
	b=YiRkdX5BVW89orL6oGxnnzPdfPh4GxOHfE7SMWqDBF+oBq3ORUoAIbUcTlOiqakbxF4JtXjPdQmH8nRq55rXb/3sw6HyDSDRt8i99cczaOaU5uLtbQhC8JFMUTAF0+dazgxxq5Bw4ZETlZBPVj0/aVX5tR4qz1p82B2Tg5WRzCc=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB3943.namprd04.prod.outlook.com (52.135.215.18) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.16; Tue, 9 Apr 2019 23:55:17 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c]) by BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c%4]) with mapi id 15.20.1771.021;
	Tue, 9 Apr 2019 23:55:17 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"peter.maydell@linaro.org" <peter.maydell@linaro.org>
Thread-Topic: [PULL 1/1] device_tree: Fix integer overflowing in
	load_device_tree()
Thread-Index: AQHU7y+uo9KsEH13PU6P9HQs6FzkdQ==
Date: Tue, 9 Apr 2019 23:55:17 +0000
Message-ID: <20190409235401.12671-2-alistair.francis@wdc.com>
References: <20190409235401.12671-1-alistair.francis@wdc.com>
In-Reply-To: <20190409235401.12671-1-alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR05CA0076.namprd05.prod.outlook.com
	(2603:10b6:a03:e0::17) To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ffa53d4-f39a-4dce-b527-08d6bd46d101
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB3943; 
x-ms-traffictypediagnostic: BYAPR04MB3943:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB394388CBAF55DA078949B1CA902D0@BYAPR04MB3943.namprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(376002)(396003)(346002)(136003)(39860400002)(199004)(189003)(2616005)(52116002)(99286004)(81166006)(71190400001)(476003)(11346002)(5660300002)(3846002)(68736007)(6486002)(486006)(110136005)(105586002)(2906002)(6116002)(54906003)(6512007)(106356001)(6506007)(14454004)(478600001)(72206003)(44832011)(86362001)(66066001)(8676002)(446003)(26005)(71200400001)(97736004)(1076003)(305945005)(102836004)(8936002)(50226002)(4326008)(14444005)(76176011)(6436002)(36756003)(316002)(2501003)(186003)(53936002)(25786009)(7736002)(81156014)(386003)(256004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB3943;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: C8Fm4aXqvnYNMuOOcm5D9eODCG0mwkHdfhZqiukdayzF+Clz3u7xnJPuFLQzQD7ITQ0ppmyn7wY0KpD/pUrSEEpGT7Aptw1C81xmG6q/KCAjluHvt/i/3hyEAAMORmOxmGNFOAinz/pp76k+e/hPPtesJW2uBsZskcLJqFrSU75VFoq8Og6OjtFWZzQT4By96UK8uzgi+KggU3VISyt39RaXF3HqfcLXkdSEV6wLam3EDYxqsZn0SllWnG29TPIWS0TmxAUdXSh3oHkn9jMmLK16RTonWPerCav37CppUUG3hOu361miQZMFyDB8UmUVBv9KQsmw4wGbLqppyLYkCu9PRXyXW9vF31rzO87M2pu1DDMQKJUyB7P29RllG5XURIMuyxWdxp92TUqvL9aq54W1nDnn/hkozNNjaZu2UhM=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <F68FC75E61BE6C4599B0C20AFFBA0273@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ffa53d4-f39a-4dce-b527-08d6bd46d101
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 23:55:17.4666 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3943
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PULL 1/1] device_tree: Fix integer overflowing in
 load_device_tree()
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
Cc: "alistair23@gmail.com" <alistair23@gmail.com>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	Kurtis Miller <kurtis.miller@nccgroup.com>,
	=?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409235517.j6Q6x0r_rOueH5syRAHdVFaWr929F6_KJkGrjO1hEWs@z>

RnJvbTogTWFya3VzIEFybWJydXN0ZXIgPGFybWJydUByZWRoYXQuY29tPg0KDQpJZiB0aGUgdmFs
dWUgb2YgZ2V0X2ltYWdlX3NpemUoKSBleGNlZWRzIElOVF9NQVggLyAyIC0gMTAwMDAsIHRoZQ0K
Y29tcHV0YXRpb24gb2YgQGR0X3NpemUgb3ZlcmZsb3dzIHRvIGEgbmVnYXRpdmUgbnVtYmVyLCB3
aGljaCB0aGVuDQpnZXRzIGNvbnZlcnRlZCB0byBhIHZlcnkgbGFyZ2Ugc2l6ZV90IGZvciBnX21h
bGxvYzAoKSBhbmQNCmxvYWRfaW1hZ2Vfc2l6ZSgpLiAgSW4gdGhlIChmb3J0dW5hdGVseSBpbXBy
b2JhYmxlKSBjYXNlIGdfbWFsbG9jMCgpDQpzdWNjZWVkcyBhbmQgbG9hZF9pbWFnZV9zaXplKCkg
c3Vydml2ZXMsIHdlJ2QgYXNzaWduIHRoZSBuZWdhdGl2ZQ0KbnVtYmVyIHRvICpzaXplcC4gIFdo
YXQgdGhhdCB3b3VsZCBkbyB0byB0aGUgY2FsbGVycyBJIGNhbid0IHNheSwgYnV0DQppdCdzIHVu
bGlrZWx5IHRvIGJlIGdvb2QuDQoNCkZpeCBieSByZWplY3RpbmcgaW1hZ2VzIHdob3NlIHNpemUg
d291bGQgb3ZlcmZsb3cuDQoNClJlcG9ydGVkLWJ5OiBLdXJ0aXMgTWlsbGVyIDxrdXJ0aXMubWls
bGVyQG5jY2dyb3VwLmNvbT4NClNpZ25lZC1vZmYtYnk6IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1i
cnVAcmVkaGF0LmNvbT4NClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhp
bG1kQHJlZGhhdC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFp
ci5mcmFuY2lzQHdkYy5jb20+DQpNZXNzYWdlLUlkOiA8MjAxOTA0MDkxNzQwMTguMjU3OTgtMS1h
cm1icnVAcmVkaGF0LmNvbT4NCi0tLQ0KIGRldmljZV90cmVlLmMgfCA0ICsrKysNCiAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kZXZpY2VfdHJlZS5jIGIv
ZGV2aWNlX3RyZWUuYw0KaW5kZXggMjk2Mjc4ZTEyYS4uZjhiNDZiM2M3MyAxMDA2NDQNCi0tLSBh
L2RldmljZV90cmVlLmMNCisrKyBiL2RldmljZV90cmVlLmMNCkBAIC04NCw2ICs4NCwxMCBAQCB2
b2lkICpsb2FkX2RldmljZV90cmVlKGNvbnN0IGNoYXIgKmZpbGVuYW1lX3BhdGgsIGludCAqc2l6
ZXApDQogICAgICAgICAgICAgICAgICAgICAgZmlsZW5hbWVfcGF0aCk7DQogICAgICAgICBnb3Rv
IGZhaWw7DQogICAgIH0NCisgICAgaWYgKGR0X3NpemUgPiBJTlRfTUFYIC8gMiAtIDEwMDAwKSB7
DQorICAgICAgICBlcnJvcl9yZXBvcnQoIkRldmljZSB0cmVlIGZpbGUgJyVzJyBpcyB0b28gbGFy
Z2UiLCBmaWxlbmFtZV9wYXRoKTsNCisgICAgICAgIGdvdG8gZmFpbDsNCisgICAgfQ0KIA0KICAg
ICAvKiBFeHBhbmQgdG8gMnggc2l6ZSB0byBnaXZlIGVub3VnaCByb29tIGZvciBtYW5pcHVsYXRp
b24uICAqLw0KICAgICBkdF9zaXplICs9IDEwMDAwOw0KLS0gDQoyLjIxLjANCg0K

