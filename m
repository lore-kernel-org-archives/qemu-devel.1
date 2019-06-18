Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2763C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 13:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B79213F2
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 13:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UXorRp8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B79213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58202 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdEWH-00076u-Q4
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 09:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53772)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdEQF-0004Hl-RO
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 09:45:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdEQE-0002wx-Oe
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 09:45:15 -0400
Received: from mail-am5eur03on0726.outbound.protection.outlook.com
 ([2a01:111:f400:fe08::726]:3714
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hdEQE-0002tS-5F; Tue, 18 Jun 2019 09:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwdJGAo+JacqBVzw7H/SaptgoOrh+oLiUK3xsR8FrAQ=;
 b=UXorRp8sWUOk6+wauAuCoSAlzAt+2GiHjjvqXO23xnVtr0B99bBbGxBWlMv0TXBm7m6Ce41ft5AVnJtjmqwov0Y2K+qTzixY5fD3R2vGRbGW4nzQwUmktgtlka8ZszS7LfiRulI/TIyC2LAN9Zgl35CObeu+UfzbXY6EsOi63u0=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4443.eurprd08.prod.outlook.com (20.179.43.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Tue, 18 Jun 2019 13:45:09 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 13:45:09 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 26/42] backup: Deal with filters
Thread-Index: AQHVIWvC8unVWZ+ODkyafPYVcTnJtKahdTsA
Date: Tue, 18 Jun 2019 13:45:08 +0000
Message-ID: <634b5bf3-b42a-7d2b-f605-0e6b6c89061d@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-27-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-27-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0082.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::26) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190618164506588
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f9067e3-21b3-4c56-dfb8-08d6f3f32d95
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4443; 
x-ms-traffictypediagnostic: DBBPR08MB4443:
x-microsoft-antispam-prvs: <DBBPR08MB4443F8570A6206BA0B41056BC1EA0@DBBPR08MB4443.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(346002)(376002)(366004)(39850400004)(189003)(199004)(31686004)(6436002)(4326008)(8936002)(8676002)(6486002)(99286004)(256004)(81166006)(2616005)(476003)(81156014)(6506007)(5660300002)(66066001)(71200400001)(386003)(446003)(71190400001)(25786009)(229853002)(76176011)(26005)(86362001)(2501003)(305945005)(31696002)(3846002)(6246003)(11346002)(558084003)(102836004)(54906003)(68736007)(53936002)(73956011)(36756003)(66476007)(478600001)(186003)(486006)(7736002)(14454004)(6116002)(316002)(6512007)(2906002)(66446008)(64756008)(66946007)(66556008)(110136005)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4443;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NKE4Bwvq0QBRt1Ymv7SzSVD/M6see5v8CCDZR8gSDUxPZTIMBpkHFE4DerGC8BOep81jhWGBtCU3chyMUEXnnylD7HB5ca1AHs4zNGT2seDKhPXa0QZxpAtRK5YCZIpMHdbmPq57mQ3znfFPxyw56StZSKmF/coiH5Dv6uLMdrvAPSmRh2xy9E6y9pR07Fga0TnXKzcsDcGfEiBnAL7lI2dUqPy5GB8sVH+Z0sey0XQEqk6xSuLLbbDCTbrMxvl4uZwuC0K3RDjAovX8gd4NBGjysPhiNMwCRu3WO+hgXSn6BcinnXD9EOtLGE6+I46NepeZtBITsC+OdnpAVdgzY3LUlS80B6B0u+nJLTUn4M5Yj0esVK67uQyr33IsdXrRPwqrOloMm1QSi0pG2nMQtlR7rH0cNWMvaAkhLWWOxC0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3D29C935F0A8543A0B61436CFFD12FB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9067e3-21b3-4c56-dfb8-08d6f3f32d95
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 13:45:09.0741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4443
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe08::726
Subject: Re: [Qemu-devel] [PATCH v5 26/42] backup: Deal with filters
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
ZWl0ejxtcmVpdHpAcmVkaGF0LmNvbT4NCg0Kbm90IHN1cmUgaW4gY29tcGxldGVuZXNzIChobW0s
IEknbSBhZnJhaWQgbmVpdGhlciBhc3N1cmFuY2Ugbm9yDQpjb21wbGV0ZW5lc3MgaXMgcG9zc2li
bGUgZm9yIGZpbHRlcnMgeWV0KS4uDQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3Yt
T2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCi0tIA0KQmVzdCByZWdhcmRz
LA0KVmxhZGltaXINCg==

