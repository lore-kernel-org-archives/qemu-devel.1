Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F37C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 17:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E84D214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 17:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OHnii203"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E84D214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgXuR-0004B7-BL
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 13:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58551)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <den@virtuozzo.com>) id 1hgXsy-00029T-3v
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <den@virtuozzo.com>) id 1hgXsx-0001Ce-3K
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:08:36 -0400
Received: from mail-eopbgr30097.outbound.protection.outlook.com
 ([40.107.3.97]:1155 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <den@virtuozzo.com>)
 id 1hgXsu-00019Z-ES; Thu, 27 Jun 2019 13:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVIDFQgKdYLkHbxzsZRcg4rzIFwqhg74alVPRXh6wBE=;
 b=OHnii203VBTwzIRDjSt4B/uZYzrq2w65eP9QAO74tucKeleJVYuXWVd5msPpGPhSM4zEoMbQGjieydspKhvJIRDJ5ZSFi9b+4Qm1PhhceTBeT2rdaI9PozagcjSfspnp4cUV3w7GW0Ut/E7bekE+l9YDiEKSWfmIkIML1t2I4Io=
Received: from DBBPR08MB4250.eurprd08.prod.outlook.com (20.179.40.149) by
 DBBPR08MB4459.eurprd08.prod.outlook.com (20.179.43.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 17:08:29 +0000
Received: from DBBPR08MB4250.eurprd08.prod.outlook.com
 ([fe80::1d8b:7420:f966:e881]) by DBBPR08MB4250.eurprd08.prod.outlook.com
 ([fe80::1d8b:7420:f966:e881%3]) with mapi id 15.20.2008.014; Thu, 27 Jun 2019
 17:08:29 +0000
From: Denis Lunev <den@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Thread-Topic: [RFC] Re-evaluating subcluster allocation for qcow2 images
Thread-Index: AQHVLPCb4B1OTPiTIEWxN+ewhowOEKavuBwAgAAD4YA=
Date: Thu, 27 Jun 2019 17:08:29 +0000
Message-ID: <8ac8776c-f1d7-14eb-1a22-3db12fde7aef@virtuozzo.com>
References: <20190627135914.xlzohrdwr6mz2aq3@perseus.local>
 <20190627165434.GE5618@localhost.localdomain>
In-Reply-To: <20190627165434.GE5618@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0153.eurprd05.prod.outlook.com
 (2603:10a6:7:28::40) To DBBPR08MB4250.eurprd08.prod.outlook.com
 (2603:10a6:10:c2::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=den@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c504e53e-1d82-4fa4-ddee-08d6fb221352
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4459; 
x-ms-traffictypediagnostic: DBBPR08MB4459:
x-microsoft-antispam-prvs: <DBBPR08MB44594EEAA9CDB8AACC6F10EBB6FD0@DBBPR08MB4459.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(346002)(39850400004)(136003)(376002)(51444003)(25584004)(189003)(199004)(25786009)(305945005)(66556008)(71200400001)(99286004)(26005)(486006)(476003)(6506007)(229853002)(186003)(66446008)(316002)(31686004)(11346002)(102836004)(66476007)(52116002)(76176011)(71190400001)(54906003)(2906002)(7736002)(14454004)(446003)(66066001)(386003)(256004)(6436002)(8676002)(110136005)(68736007)(6486002)(81156014)(8936002)(86362001)(81166006)(64756008)(6116002)(31696002)(107886003)(6246003)(3846002)(6512007)(36756003)(73956011)(5660300002)(478600001)(53936002)(2616005)(66946007)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4459;
 H:DBBPR08MB4250.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yQN76Lzs9O0Cc4peftVrIPwJBTh/mc+NW/lk9Aa6aIsFslxtF2P+3Iu/ppOnsQhPPnrfexTW+JXsNuKVnKbFSmpsYRVNyC/ZlRaIkutMEsdr6lXU8fHovokstLun24FqosFVkjf8/lp25u+GWhS8ogSOCGcKwi9GCHX0Ry+4EWKkfw61EzFtpJ8vTgCJoRkKJAJYmXKKip9YzNSN6FUd75wWB0ZkOJoJLlaEgcrqfpST8SwnznNm14ThJcLOaI6vn+KT6So9XbfBMpFgiUCt2yaGrt9Q7rYCwKOABwlWnc586r9M6+2B0ZGJ740WveiOr5VyoecS4tEpeNnJlPtRunVgoKXpjbkRurJ+nTtnu/uLA+ViOrrn97vipFchjbdhMakrYGromRkHyFgI+fD9BsWl8rQ6V3Zshwd9y84+KFI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <424A5C53F9EBD94E92A15402107B7E24@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c504e53e-1d82-4fa4-ddee-08d6fb221352
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 17:08:29.4099 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: den@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4459
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.97
Subject: Re: [Qemu-devel] [RFC] Re-evaluating subcluster allocation for
 qcow2 images
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
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

W3NuaXBdDQo+PiA9PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4+DQo+PiBBbmQgSSB0aGlu
ayB0aGF0J3MgYWxsLiBBcyB5b3UgY2FuIHNlZSBJIGRpZG4ndCB3YW50IHRvIGdvIG11Y2ggaW50
bw0KPj4gdGhlIG9wZW4gdGVjaG5pY2FsIHF1ZXN0aW9ucyAoSSB0aGluayB0aGUgb24tZGlzayBm
b3JtYXQgd291bGQgYmUgdGhlDQo+PiBtYWluIG9uZSksIHRoZSBmaXJzdCBnb2FsIHNob3VsZCBi
ZSB0byBkZWNpZGUgd2hldGhlciB0aGlzIGlzIHN0aWxsIGFuDQo+PiBpbnRlcmVzdGluZyBmZWF0
dXJlIG9yIG5vdC4NCj4+DQo+PiBTbywgYW55IHF1ZXN0aW9ucyBvciBjb21tZW50cyB3aWxsIGJl
IG11Y2ggYXBwcmVjaWF0ZWQuDQo+IEl0IGRvZXMgbGlrZSB2ZXJ5IGludGVyZXN0aW5nIHRvIG1l
IGF0IGxlYXN0IGZvciBzbWFsbCBzdWJjbHVzdGVyIHNpemVzLg0KPg0KPiBGb3IgdGhlIGxhcmdl
ciBvbmVzLCBJIHN1c3BlY3QgdGhhdCB0aGUgVmlydHVvenpvIGd1eXMgbWlnaHQgYmUNCj4gaW50
ZXJlc3RlZCBpbiBwZXJmb3JtaW5nIG1vcmUgYmVuY2htYXJrcyB0byBzZWUgd2hldGhlciBpdCBp
bXByb3ZlcyB0aGUNCj4gZnJhZ21lbnRhdGlvbiBwcm9ibGVtcyB0aGF0IHRoZXkgaGF2ZSB0YWxr
ZWQgYWJvdXQgYSBsb3QuIEl0IG1pZ2h0IGVuZA0KPiB1cCBiZWluZyBpbnRlcmVzdGluZyBmb3Ig
dGhlc2UgY2FzZXMsIHRvby4NCj4NCj4gS2V2aW4NClRoZXJlIGlzIG5vIGRpZmZlcmVuY2UgaW4g
dGVybXMgb2YgZGF0YSBjb250aW51aXR5IGlmIHRoZSBzcGFjZQ0KdW5kZXIgdGhlIHdob2xlIGNs
dXN0ZXIgaXMgYWxsb2NhdGVkIHdpdGggZmFsbG9jYXRlKCkgYXMgbm90ZWQNCmJ5IEJlcnRvLg0K
DQpGb3IgbGFyZ2Ugc2l6ZXMgSSBoYXZlIHBvc3RlZCBkaWZmZXJlbnQgdXNlIGNhc2UgYnV0IHdp
dGgNCnNsaWdodGx5IGRpZmZlcmVudCBjb25zdHJhaW50cy4gU3ViY2x1c3RlciBvcHRpb24gY291
bGQgYmUNCmludGVyZXN0aW5nIGluIHRlcm1zIG9mIHJhbmRvbSBJTyBvbiBiaWcgZGlza3MgZXZl
biBhZnRlcg0KdGhlIGFsbG9jYXRpb24uDQoNCkJ1dCBjYW4gd2UgZ2V0IGEgbGluayB0byB0aGUg
cmVwbyB3aXRoIGFjdHVhbCB2ZXJzaW9uIG9mDQpwYXRjaGVzLg0KDQpEZW4NCg==

