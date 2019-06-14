Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0157CC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:13:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C69D121744
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="T5rHqYmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69D121744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52520 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbntt-0002d6-3x
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 11:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45980)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbnmD-0005ef-Df
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:06:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbnm9-0000Us-0y
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:05:59 -0400
Received: from mail-am5eur03on0728.outbound.protection.outlook.com
 ([2a01:111:f400:fe08::728]:12869
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbnm6-0008Gp-4K; Fri, 14 Jun 2019 11:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p70/X4X2vj683LuIE+nbTnheC0Irx+cr9NnJQjqXfMg=;
 b=T5rHqYmvwHY27uj9HsTsXp4vkO9htzlU9nuwXDu89J5bVY/dD6tHFZwJS+jWKPvBZR2Wsg6ZpAZhaj8o771aq6XTEo2s66bxRsi3sn/1DawDZs+I/VdvFqA3xxX5B//t+YpQOwL4IoFmO9oBU8hMexJu9iM1XpKbBnD8dbwfSck=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB3473.eurprd08.prod.outlook.com (20.177.109.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Fri, 14 Jun 2019 15:04:39 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Fri, 14 Jun 2019
 15:04:39 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 17/42] block: Use CAFs in bdrv_refresh_limits()
Thread-Index: AQHVIWuz07ZO+milBE+st/2hcppaT6abQh+A
Date: Fri, 14 Jun 2019 15:04:39 +0000
Message-ID: <e49cb4b8-4faf-040c-c663-7c4853f09b20@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-18-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-18-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0264.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::16) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190614180437339
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 905308b3-048f-4398-7698-08d6f0d99f7b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:AM0PR08MB3473; 
x-ms-traffictypediagnostic: AM0PR08MB3473:
x-microsoft-antispam-prvs: <AM0PR08MB3473F9D43FA2156549241675C1EE0@AM0PR08MB3473.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:400;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(376002)(396003)(39850400004)(346002)(189003)(199004)(66556008)(2906002)(14454004)(6436002)(6486002)(31686004)(53936002)(2501003)(86362001)(31696002)(478600001)(25786009)(71200400001)(68736007)(71190400001)(99286004)(52116002)(66066001)(558084003)(6512007)(6246003)(7736002)(36756003)(66446008)(6116002)(5660300002)(66946007)(66476007)(8936002)(102836004)(26005)(54906003)(73956011)(8676002)(81166006)(386003)(6506007)(76176011)(316002)(110136005)(81156014)(476003)(2616005)(486006)(446003)(4326008)(305945005)(186003)(256004)(229853002)(11346002)(3846002)(64756008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3473;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mIr4To2bnBF6dTMim/r7wlfU5eEnxd3p0+krwW8IHuW/U4QWFWk2qqdImCq4h5OVAgK4NJzJAP1bKNiLkREVnZUDZGAU6pfmDBuFFhZH7FNQzF/YdS8oJmFYak6rcV2udaQEVNsanNXG3nQo4FFdOvQgKEvZ4s7p93tyMPtUucChgww5uhjPUxyCjdSSeZOzHp+ebROw3YvSlnxUqPf8Y2jRhAxviLwbx3W0HeQJ7b4wH3pZ8UiIR+dttZxiH+Mhb/OVOnZ8Enjm6/5gjQfksvkHIxXCm5wU3G2k2kRMcC1lFincv2gKcvN1KstjkVCGKhAQu89G5tuCNeIrGBb27Gik5Ex9BG2oxiKy7PPQqYX5nL3bkjXsbsfdyy+lO5pcJqEdctzTje9aAVydmdu+koJdWe5gHVo0AU5/nAhSSgo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F841F96F6BF6B3429B9F80BCBA2E2461@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 905308b3-048f-4398-7698-08d6f0d99f7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 15:04:39.7079 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3473
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe08::728
Subject: Re: [Qemu-devel] [PATCH v5 17/42] block: Use CAFs in
 bdrv_refresh_limits()
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+IFNpZ25lZC1vZmYtYnk6IE1heCBS
ZWl0ejxtcmVpdHpAcmVkaGF0LmNvbT4NCg0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQotLSANCkJlc3QgcmVn
YXJkcywNClZsYWRpbWlyDQo=

