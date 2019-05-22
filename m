Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C85C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 11:32:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA1AF204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 11:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GA4UZexq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1AF204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40569 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTPUF-0000PB-To
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 07:32:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hTPSV-000806-P7
	for qemu-devel@nongnu.org; Wed, 22 May 2019 07:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hTPSU-0002ZX-Nu
	for qemu-devel@nongnu.org; Wed, 22 May 2019 07:30:59 -0400
Received: from mail-eopbgr70099.outbound.protection.outlook.com
	([40.107.7.99]:20110
	helo=EUR04-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hTPSR-0002V7-Rz; Wed, 22 May 2019 07:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=fgQDGnO+d5x/JnmjY1sFgE4qAH13V5i3WUVFG2utfH8=;
	b=GA4UZexqcOUmsNCIlKkkfUcLuZ5Cxz4ei3YFqAYS5VLgFZkXrmmj7Rfaj3ksbFXIKBX5LBhsWcMHoQJkTKG5tXho83k45wGP3Yk1jt1CdxYIkxg1lBS34uaKY6oVoisOFnk4leDTgAFx9cS3oUKgmk1NtFkFw025wQYIwzcpm24=
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com (10.255.96.78) by
	AM6PR08MB4056.eurprd08.prod.outlook.com (20.179.1.146) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.15; Wed, 22 May 2019 11:30:52 +0000
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1]) by
	AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1%6]) with mapi id 15.20.1878.024;
	Wed, 22 May 2019 11:30:51 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v2 for 4.1 0/2] avoid lseek on block_status
Thread-Index: AQHU7ifR38W67XMkcUq/V5mfMlS/raZ3O02AgAAL/gA=
Date: Wed, 22 May 2019 11:30:51 +0000
Message-ID: <94863ed6-84a3-63a7-7b6f-d6b98d80fda6@virtuozzo.com>
References: <20190408162617.258535-1-vsementsov@virtuozzo.com>
	<20190522104753.GD6087@localhost.localdomain>
In-Reply-To: <20190522104753.GD6087@localhost.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0011.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::21)
	To AM6PR08MB4675.eurprd08.prod.outlook.com
	(2603:10a6:20b:c2::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190522143048421
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b3e1b99-ed26-41af-af54-08d6dea8f17b
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB4056; 
x-ms-traffictypediagnostic: AM6PR08MB4056:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6PR08MB40565DE302BF57559DE6FDF1C1000@AM6PR08MB4056.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(396003)(346002)(39850400004)(376002)(136003)(366004)(199004)(189003)(6116002)(7736002)(102836004)(86362001)(305945005)(3846002)(14454004)(25786009)(81156014)(66066001)(81166006)(99286004)(256004)(8936002)(31686004)(71200400001)(54906003)(71190400001)(76176011)(6506007)(386003)(31696002)(486006)(6246003)(316002)(52116002)(6486002)(8676002)(6512007)(6436002)(6306002)(2616005)(11346002)(476003)(6916009)(66946007)(478600001)(4744005)(26005)(73956011)(53936002)(4326008)(229853002)(107886003)(5660300002)(966005)(2906002)(36756003)(446003)(66446008)(186003)(64756008)(66556008)(68736007)(66476007);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4056;
	H:AM6PR08MB4675.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XSYP0K2LGMHMFCf+Haa4Wdjh7qrE19EHRfirIR9g6Oo8jmODyBFrOrFMBPv0kPa/bjkFmwZoYnI5r8ZO/uXoD//Coh/VhCDfBsbtRqNdLP4vPaYiA2OWP+i6ijMDFUkbxbHb6/ZV6y6Kp4zqytGNFI7tSz4loLbuvHwFbS6+u33i4jtKRcm8c9/apETmOPKOHYOiSui6O0su9gIFCRZgrnVc9qfXrZbfTxnNjPK5QZT5SyzIS9Y1EEafsjO6gHL3OTtTcDBQ9T2QjwN67XhlED25psw1T12+s07OWN7NJViuQft+Fq4CsiBKppuCPLSsESsRDl69XS9VzgTISKAdSiwfF4GKqMpZjPeqMVrVtwr9eiMiXd3y0K6I17kObFCJtVDRPwIjYvQNFvSvS1iyzEJhHrN2RsBC9TheLJyMAts=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57E76E69C91E224DAB0A9A77D2DF997D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3e1b99-ed26-41af-af54-08d6dea8f17b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 11:30:51.8044 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4056
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.99
Subject: Re: [Qemu-devel] [PATCH v2 for 4.1 0/2] avoid lseek on block_status
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
Cc: "fam@euphon.net" <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjIuMDUuMjAxOSAxMzo0NywgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMDguMDQuMjAxOSB1bSAx
ODoyNiBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IEhp
IQ0KPj4NCj4+IEl0J3MgYSBjb250aW51YXRpb24gZm9yDQo+PiAiW1BBVENIXSBxY293MjogYXZv
aWQgbHNlZWsgb24gYmxvY2tfc3RhdHVzIGlmIHBvc3NpYmxlIg0KPj4gaHR0cHM6Ly9saXN0cy5n
bnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTktMDEvbXNnMDY1OTguaHRtbA0KPj4N
Cj4+IHBlcmZvcm1hbmNlIHJlc3VsdHMgZm9yIGJsb2NrLXN0YXR1cyBvbiB0bXBmcyBbdGVzdHMg
b3JpZ2luYWxseSBieSBLZXZpbiwNCj4+IG5vdyB0aGV5IGFyZSBpbiAwMV06DQo+Pg0KPj4gLi90
ZXN0cy9wZXJmL2Jsb2NrL3Fjb3cyL2NvbnZlcnQtYmxvY2tzdGF0dXMgL3JhbWRpc2sveA0KPj4N
Cj4+IGFmdGVyIDAxOg0KPj4NCj4+IHBsYWluOiA4MS43Nw0KPj4gZm9yd2FyZDogODIuNjENCj4+
IHByZWFsbG9jOiAwLjAxDQo+Pg0KPj4gYWZ0ZXIgMDI6DQo+Pg0KPj4gcGxhaW46IDAuMTINCj4+
IGZvcndhcmQ6IDAuMTINCj4+IHByZWFsbG9jOiAwLjAxDQo+IA0KPiBUaGFua3MsIGFwcGxpZWQg
dG8gdGhlIGJsb2NrIGJyYW5jaC4NCj4gDQo+IEtldmluDQo+IA0KDQpUaGFuayB5b3UhDQoNCi0t
IA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

