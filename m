Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5165C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 04:53:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 643242087B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 04:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TZSMaS6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643242087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52025 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKyIM-0006WJ-Aj
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 00:53:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hKyH9-0005wH-JG
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 00:52:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hKyFG-00069Q-3G
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 00:50:27 -0400
Received: from mail-eopbgr120101.outbound.protection.outlook.com
	([40.107.12.101]:54080
	helo=FRA01-PR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hKyF3-00065E-K4; Mon, 29 Apr 2019 00:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=rY4ZzcrfiFY2fip25orfafnxFzsVYtVrKEF53GuT2BQ=;
	b=TZSMaS6O9C5oMTXxTa1ZQ1fNhIh7Q9/+RQ3o26jyQXDRwAzMJWsJ3jLqBEzBg+vu2gaTxMVZHjkpfwckU8JPF2unU+7HSeyl88T5c/sqmE0oBZuGvdBAnpBmnQ2P5/Cyyknlmge1v6AyqVCYHc8jXgGl4PYX5/5m3niMrqsNNuI=
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com (52.133.109.209) by
	PR2PR08MB4793.eurprd08.prod.outlook.com (52.133.109.21) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.13; Mon, 29 Apr 2019 04:49:56 +0000
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::88d7:ecf0:1120:f1a1]) by
	PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::88d7:ecf0:1120:f1a1%3]) with mapi id 15.20.1835.018;
	Mon, 29 Apr 2019 04:49:56 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v6 5/5] block/backup: refactor: split out
	backup_calculate_cluster_size
Thread-Index: AQHU85p/OB840rNuMU6WmnqRzWRYUKZO1PEAgAPR0oA=
Date: Mon, 29 Apr 2019 04:49:56 +0000
Message-ID: <2e608d6a-8dce-aee8-15e4-a9830a2afd6b@virtuozzo.com>
References: <20190415144948.78568-1-vsementsov@virtuozzo.com>
	<20190415144948.78568-6-vsementsov@virtuozzo.com>
	<4f5ed0c3-83d0-bcbe-5866-e0aab67f188f@redhat.com>
In-Reply-To: <4f5ed0c3-83d0-bcbe-5866-e0aab67f188f@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0401CA0052.eurprd04.prod.outlook.com
	(2603:10a6:3:19::20) To PR2PR08MB4684.eurprd08.prod.outlook.com
	(2603:10a6:101:22::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190429074953726
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06710b15-07a1-4f5b-36bb-08d6cc5e202b
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:PR2PR08MB4793; 
x-ms-traffictypediagnostic: PR2PR08MB4793:
x-microsoft-antispam-prvs: <PR2PR08MB4793BF7CA6AE1D442A1B46ACC1390@PR2PR08MB4793.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(396003)(346002)(376002)(39840400004)(366004)(199004)(189003)(7736002)(386003)(305945005)(66066001)(71200400001)(6436002)(6512007)(54906003)(110136005)(26005)(4744005)(71190400001)(6486002)(66476007)(66946007)(66556008)(64756008)(316002)(256004)(73956011)(14454004)(478600001)(8676002)(2616005)(6116002)(486006)(446003)(76176011)(107886003)(53936002)(25786009)(81166006)(4326008)(36756003)(66446008)(99286004)(8936002)(81156014)(5660300002)(229853002)(2501003)(52116002)(2906002)(86362001)(11346002)(186003)(68736007)(2201001)(53546011)(102836004)(476003)(97736004)(6246003)(6506007)(31696002)(31686004)(3846002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:PR2PR08MB4793;
	H:PR2PR08MB4684.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VYPBCDjW/JIua+G1DenS6MXIwib/FG3woLlJD4bMDMunZAEtht79F0NNII3ODSRz7Vw67fNfj15c3K8xDOpVhg/tQfmlhlbtqwvMSJPhhBqMokJeueUN2f83fIrCNVXAEWSZsrrz+GbkuS490yurfIddf7rBqiPn0aQ62rMMh/4cf2oHrbCuJ78jNgpjKUzMLusOiuw05GuVA5I8/p02hiiQT+MBaJJ7yz2rIqk1i7uOuH5dkfHln9px+iuq1iP/le4t600/pbak8TrktSpWOBNomJTIM87TGVObaQCVX3Gg258ET2P/NZW/u7U5xd8TpKpaR0pIddQkjgYHDPZTN+DYcA1NWAnkNDUKwEkaVFw7sRg+WjwquavXAF7FdZAlkcluOzL0exxd83AsVFZOqWxHIBPfcWwEUrWn1stmkwg=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <12A8C8B25D813F4D8A98F0648E02E6F6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06710b15-07a1-4f5b-36bb-08d6cc5e202b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 04:49:56.0250 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4793
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.12.101
Subject: Re: [Qemu-devel] [PATCH v6 5/5] block/backup: refactor: split out
 backup_calculate_cluster_size
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
	"jsnow@redhat.com" <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429044956.LO28bnQc5CMvHMGowRGONHpiZHIWJaQe9SQaBHACNbc@z>

MjYuMDQuMjAxOSAyMTozMCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxNS4wNC4xOSAxNjo0OSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IFNwbGl0IG91dCBjbHVzdGVy
X3NpemUgY2FsY3VsYXRpb24uIE1vdmUgY29weS1iaXRtYXAgY3JlYXRpb24gYWJvdmUNCj4+IGJs
b2NrLWpvYiBjcmVhdGlvbiwgYXMgd2UgYXJlIGdvaW5nIHRvIHNoYXJlIGl0IHdpdGggdXBjb21p
bmcNCj4+IGJhY2t1cC10b3AgZmlsdGVyLCB3aGljaCBhbHNvIHNob3VsZCBiZSBjcmVhdGVkIGJl
Zm9yZSBhY3R1YWwgYmxvY2sgam9iDQo+PiBjcmVhdGlvbi4NCj4+DQo+PiBBbHNvLCB3aGlsZSBi
ZWluZyBoZXJlLCBkcm9wIHVubmVjZXNzYXJ5ICJnb3RvIGVycm9yIiBmcm9tDQo+PiBiZHJ2X2dl
dGxlbmd0aCBlcnJvciBwYXRoLg0KPiANCj4gSXQgaXNu4oCZdCB1bm5lY2Vzc2FyeSwgdGhvdWdo
LiAgQmVmb3JlIHRoaXMsIHdlIGludm9rZQ0KPiBiZHJ2X2RpcnR5X2JpdG1hcF9jcmVhdGVfc3Vj
Y2Vzc29yKCksIHNvIHRoZSBlcnJvciBwYXRoIGhhcyB0byBjbGVhbg0KPiB0aGF0IHVwIHdpdGgg
YmRydl9yZWNsYWltX2RpcnR5X2JpdG1hcCgpLg0KPiANCj4gTWF4DQo+IA0KDQpPb3BzLCB3aWxs
IHJlc2VuZC4gSSB3YXMgbG9va2luZyBhdCBwcmV2aW91cyBwbGFpbiAicmV0dXJuIE5VTEwiLCBi
dXQgbWlzc2VkDQp0aGF0IGluICJpZiIgYnJhbmNoIHdlIGRvIHRoaW5nIHRvIGJlIHJvbGxlZC1i
YWNrIG9uIGZhaWwuDQoNClRoYW5rIHlvdSBmb3IgcmV2aWV3IQ0KDQotLSANCkJlc3QgcmVnYXJk
cywNClZsYWRpbWlyDQo=

