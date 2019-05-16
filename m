Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331CBC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 15:24:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB6B20657
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 15:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CafAsqGK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB6B20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59891 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRIFM-0008BV-3h
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 11:24:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hRIET-0007q2-BU
	for qemu-devel@nongnu.org; Thu, 16 May 2019 11:23:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hRIES-0004cS-Gk
	for qemu-devel@nongnu.org; Thu, 16 May 2019 11:23:45 -0400
Received: from mail-eopbgr10117.outbound.protection.outlook.com
	([40.107.1.117]:39015
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hRIER-0004Zu-FH; Thu, 16 May 2019 11:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=2bZtmFNrmDom4skcbZirePXaB/QR4Fia9t3+sLF7mec=;
	b=CafAsqGKfJn0y373i/QQeiKQ2/eM97iOxl2bVfS013jKFgqYufhdiB9Du8dE8yrjffftcOeBVmpsv2icO6Fgww29H2sMFbk6uWhS2onbH2nhdnpJmHDxS0tqzrotrL61KCbxt+KBLCce0iP7Mi29/ybKsstE73iXpIUz4ze9ekY=
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com (10.255.96.78) by
	AM6PR08MB3592.eurprd08.prod.outlook.com (20.177.114.225) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1900.17; Thu, 16 May 2019 15:23:31 +0000
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1]) by
	AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1%6]) with mapi id 15.20.1878.024;
	Thu, 16 May 2019 15:23:31 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [PATCH v8 8/9] file-posix: account discard operations
Thread-Index: AQHVC/RU3KfNtN6gp0+qRPHbh4wQbqZt3rYA
Date: Thu, 16 May 2019 15:23:31 +0000
Message-ID: <26a8d27f-bf4b-cede-2119-320aa80aadd7@virtuozzo.com>
References: <20190516143314.81302-1-anton.nefedov@virtuozzo.com>
	<20190516143314.81302-9-anton.nefedov@virtuozzo.com>
In-Reply-To: <20190516143314.81302-9-anton.nefedov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0042.eurprd07.prod.outlook.com
	(2603:10a6:7:66::28) To AM6PR08MB4675.eurprd08.prod.outlook.com
	(2603:10a6:20b:c2::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190516182328406
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e0e0611-0aee-4c66-6a44-08d6da127444
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB3592; 
x-ms-traffictypediagnostic: AM6PR08MB3592:
x-microsoft-antispam-prvs: <AM6PR08MB3592D84AAF1270CFD8630D24C10A0@AM6PR08MB3592.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(979002)(39850400004)(346002)(396003)(366004)(136003)(376002)(189003)(199004)(6246003)(6512007)(2616005)(36756003)(478600001)(81166006)(31686004)(476003)(66066001)(316002)(6116002)(3846002)(8936002)(446003)(229853002)(2906002)(6486002)(6436002)(25786009)(11346002)(81156014)(5660300002)(8676002)(66446008)(26005)(186003)(15650500001)(54906003)(110136005)(4744005)(256004)(6506007)(66476007)(99286004)(73956011)(66946007)(71190400001)(52116002)(31696002)(76176011)(71200400001)(102836004)(53936002)(386003)(86362001)(14454004)(2501003)(7736002)(68736007)(64756008)(4326008)(305945005)(66556008)(486006)(969003)(989001)(999001)(1009001)(1019001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3592;
	H:AM6PR08MB4675.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9JbmQpoT1y6os5ZZHgJdrWvhDPOg+gg3F3JBILNAabqSabGMFJe/gocoxTnJhFJxg4RRhk2i88CJkqY1BIOjz3Fs17vHngURDvUnn0nrdKmhrWY+KASeg2o2ghnprmQx72B4MG2bVFlU1XNzD2Zyk5rfOEBd1V54o0O8CMuEyykmoLEo8qMblq5Ld7vhDGfYVZZs7//JTKfEjenNkLcFCNwMfhXpqTU0MD80Uf7d0hc3zpIJ4WNxQM5R1cyiQfnfpz+upllxR5Oq82QpDtvyeklYYplORGqA+bDNUXU+RJi8/ao4R9K0BbCsMfzvovJTadeRBWD8m17l6Q45d/nqz5+aDbhK0xuir8Li83+Adqhuq2j/UyA6xCCg4rX6qaXFRq6Gu9TTlETuTRYD77/S/zAMolFUZJzGG7GS030DQcE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C50005E994108D42B7DB686FAB41BFCA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0e0611-0aee-4c66-6a44-08d6da127444
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 15:23:31.7919 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3592
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.117
Subject: Re: [Qemu-devel] [PATCH v8 8/9] file-posix: account discard
 operations
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
	"berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTYuMDUuMjAxOSAxNzozMywgQW50b24gTmVmZWRvdiB3cm90ZToNCj4gVGhpcyB3aWxsIGhlbHAg
dG8gaWRlbnRpZnkgaG93IG1hbnkgb2YgdGhlIHVzZXItaXNzdWVkIGRpc2NhcmQgb3BlcmF0aW9u
cw0KPiAoYWNjb3VudGVkIG9uIGEgZGV2aWNlIGxldmVsKSBoYXZlIGFjdHVhbGx5IHN1Y2VlZGVk
IGRvd24gb24gdGhlIGhvc3QgZmlsZQ0KPiAoZXZlbiB0aG91Z2ggdGhlIG51bWJlcnMgd2lsbCBu
b3QgYmUgZXhhY3RseSB0aGUgc2FtZSBpZiBub24tcmF3IGZvcm1hdA0KPiBkcml2ZXIgaXMgdXNl
ZCAoZS5nLiBxY293MiBzZW5kaW5nIG1ldGFkYXRhIGRpc2NhcmRzKSkuDQo+IA0KPiBOb3RlIHRo
YXQgdGhlc2UgbnVtYmVycyB3aWxsIG5vdCBpbmNsdWRlIGRpc2NhcmRzIHRyaWdnZXJlZCBieQ0K
PiB3cml0ZS16ZXJvZXMgKyBNQVlfVU5NQVAgY2FsbHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBB
bnRvbiBOZWZlZG92IDxhbnRvbi5uZWZlZG92QHZpcnR1b3p6by5jb20+DQoNClJldmlld2VkLWJ5
OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+
DQoNCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

