Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD3DC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:54:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14F3C2075D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KmFAwSGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F3C2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDl4j-0002xn-1r
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 03:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDl3Z-0002OY-An
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 03:52:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDl3X-0004um-Nz
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 03:52:48 -0400
Received: from mail-eopbgr70123.outbound.protection.outlook.com
 ([40.107.7.123]:51510 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDl3W-0004t9-Ak; Fri, 27 Sep 2019 03:52:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCS1smO2saBhUf0UAnbjK6uXoJWi2rcz1C5U1jV7yKGoImWVWizQyoQyTYFRLFwannZQb+6PHZj4rFdTJmeC01LGibHFK6qHaIQLLVFXOuzbSGzSNuBqekAEeimtLJ/7RDMD/NBi3ZvC7AyLIZxGtoLUd87ga9IxGXf/YkhRtgm846ABoL1tKn5LlbRUFzO25k3tfNHjwmgJw6tDlU7INCWXdWOnIS0CJ+5Wq5aH+Kk7eG87o8SUmDMfcRg1lmXWRTRdCRgbqYvbV07yTqF9MXb1FvnnjFtdfTX5jo7NxBJ8txLzg2BY2KCKFFwr7fPzmYtlDcZ/bzXd6Udeg1usyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5LF+rvRMEYwpt4Ak+29YikRDM1+yvIWUftmq/zBsXw=;
 b=JB5pmgspp5UmfoYJzkBKORtbyFVn8kDClSDmGh/ZrjfE6UI9yMI+7kDpyPo6re9sNzY3ocuUDTFDE9c+O6m9OnXGctxZg8BQ5RIe+qdYhsuX3vdvFr9oh9IBTUZs0whdK4qCdt/U7jeoJ5urklvuhvvV7c0aTGFAnZKyLWWP7ylzBsCXSnxmfHsl0U3f/wT7D/ZAjamiiD5nivD3s7XfYSwNj3WnDNn9GwCRYjJy1QuFMkNh4Gjv2ZowMAjJ0P613M7z4aJKULiE1NA+SXvvqWdWNwKxShP5jLjrHFiTh4N4slRDNObJV2SVGNRLcNrmxK2bIcxszG0aOPcED+2Onw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5LF+rvRMEYwpt4Ak+29YikRDM1+yvIWUftmq/zBsXw=;
 b=KmFAwSGC9Eg2cFoAKyLEj2DRoZYtsZvStmX4kmTPwr295xONKBHAQiWG0qvp8wKrW9HStJdvCA6lr3vFuXvLGPzMX4hC7CfGSOLwjLvTJaOrNz+I/aFYVMu0zMnEtJX7uR2Fsh4f1+ZnSOGu+NKmmKyH+RZb7YCcMgHrowDa/YA=
Received: from AM0PR08MB5491.eurprd08.prod.outlook.com (52.132.215.9) by
 AM0PR08MB3955.eurprd08.prod.outlook.com (20.178.119.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Fri, 27 Sep 2019 07:52:42 +0000
Received: from AM0PR08MB5491.eurprd08.prod.outlook.com
 ([fe80::d552:8bd7:4773:3d75]) by AM0PR08MB5491.eurprd08.prod.outlook.com
 ([fe80::d552:8bd7:4773:3d75%2]) with mapi id 15.20.2305.017; Fri, 27 Sep 2019
 07:52:42 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [Qemu-devel] [PATCH v4 09/10] block/qcow2-bitmap: fix and improve
 qcow2_reopen_bitmaps_rw
Thread-Topic: [Qemu-devel] [PATCH v4 09/10] block/qcow2-bitmap: fix and
 improve qcow2_reopen_bitmaps_rw
Thread-Index: AQHVTSoqipOZ3STGlEyLOw5sQRnhRKc+5+GAgACO24A=
Date: Fri, 27 Sep 2019 07:52:41 +0000
Message-ID: <4fb89dc3-6eb6-bb86-2aaf-611881b82c39@virtuozzo.com>
References: <20190807141226.193501-1-vsementsov@virtuozzo.com>
 <20190807141226.193501-10-vsementsov@virtuozzo.com>
 <c3e11dc4-14ab-e6a4-26c3-ab0d66bda330@redhat.com>
In-Reply-To: <c3e11dc4-14ab-e6a4-26c3-ab0d66bda330@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0179.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::27) To AM0PR08MB5491.eurprd08.prod.outlook.com
 (2603:10a6:208:189::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190927105239222
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ad4173b-bda5-4ab2-16db-08d7431facd2
x-ms-traffictypediagnostic: AM0PR08MB3955:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB395577EEA4C5221E82AAA853C1810@AM0PR08MB3955.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:302;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(366004)(39850400004)(136003)(346002)(189003)(199004)(6116002)(8936002)(446003)(2501003)(11346002)(2906002)(4326008)(110136005)(81156014)(107886003)(66946007)(64756008)(6246003)(71200400001)(3846002)(8676002)(229853002)(71190400001)(66476007)(53546011)(66556008)(6436002)(26005)(66446008)(6506007)(52116002)(31696002)(76176011)(386003)(6486002)(6512007)(186003)(5660300002)(316002)(36756003)(86362001)(54906003)(81166006)(102836004)(25786009)(66066001)(99286004)(7736002)(14454004)(478600001)(31686004)(2616005)(256004)(305945005)(14444005)(486006)(476003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3955;
 H:AM0PR08MB5491.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zYlkt7tAPLvw1Rhu+CjzRfAXM613XqnlT2ghwCYJzvQIYFnuaktbMBtPw1E84q1SapSSX3tIYxisQKmL0i5Y2jaXLtFUCGn7leDJ+X0PrQ+gvKWh6OPqfa+cKsjj1aNk4kXOcN02GfzSK6u5lWARXKMGki4wjEfUbgX/EicC2ba2zXQQDqkl2f50miEuJz40u+S1Z9gxARxVgGtTGHnl6xXAwFs49IvMgX9veXOiIthwceGEtbgxDS3J0NlimUMJR3QxyoaMDSE0g6gLx35Qu7LGYQ7qg/dkLYWneCaIurUloRVxzmn2RulW2UMX7LyVifUWokI/k7xndl/nciWCZe4DeVfrnDFLGZsM48Iwldgux9jFQ3rIN4xvBnx2Uql5JPiTWoEOnePgdv7JtSK0cXgTsyfCIWwzE/1W6agJ6PE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAE443B7525D814AACF42B7D9CD87C6F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad4173b-bda5-4ab2-16db-08d7431facd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 07:52:41.9812 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nc55CDvorYD7Hp/SWZqRXuy2wR5TwUueqgKSbEfs/YgOf/WxjI7aFZylsXdxSj94oqKiFI1cCt1z80TrFzekqYkETjtVQ5OlKSQA2UOzxCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3955
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.123
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjcuMDkuMjAxOSAyOjIxLCBKb2huIFNub3cgd3JvdGU6DQo+IA0KPiANCj4gT24gOC83LzE5IDEw
OjEyIEFNLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gLSBDb3JyZWN0
IGNoZWNrIGZvciB3cml0ZSBhY2Nlc3MgdG8gZmlsZSBjaGlsZCwgYW5kIGluIGNvcnJlY3QgcGxh
Y2UNCj4+ICAgIChvbmx5IGlmIHdlIHdhbnQgdG8gd3JpdGUpLg0KPj4gLSBTdXBwb3J0IHJlb3Bl
biBydyAtPiBydyAod2hpY2ggd2lsbCBiZSB1c2VkIGluIGZvbGxvd2luZyBjb21taXQpLA0KPj4g
ICAgZm9yIGV4YW1wbGUsICFiZHJ2X2RpcnR5X2JpdG1hcF9yZWFkb25seSgpIGlzIG5vdCBhIGNv
cnJ1cHRpb24gaWYNCj4+ICAgIGJpdG1hcCBpcyBtYXJrZWQgSU5fVVNFIGluIHRoZSBpbWFnZS4N
Cj4+IC0gQ29uc2lkZXIgdW5leHBlY3RlZCBiaXRtYXAgYXMgYSBjb3JydXB0aW9uIGFuZCBjaGVj
ayBvdGhlcg0KPj4gICAgY29tYmluYXRpb25zIG9mIGluLWltYWdlIGFuZCBpbi1SQU0gYml0bWFw
cy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2
c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+PiAtLS0NCj4+ICAgYmxvY2svcWNvdzItYml0bWFw
LmMgfCA1NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPj4g
ICAxIGZpbGUgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2Jsb2NrL3Fjb3cyLWJpdG1hcC5jIGIvYmxvY2svcWNvdzItYml0bWFw
LmMNCj4+IGluZGV4IGE2MzZkYzUwY2EuLmUyNzZhOTUxNTQgMTAwNjQ0DQo+PiAtLS0gYS9ibG9j
ay9xY293Mi1iaXRtYXAuYw0KPj4gKysrIGIvYmxvY2svcWNvdzItYml0bWFwLmMNCj4+IEBAIC0x
MTA4LDE4ICsxMTA4LDE0IEBAIGludCBxY293Ml9yZW9wZW5fYml0bWFwc19ydyhCbG9ja0RyaXZl
clN0YXRlICpicywgRXJyb3IgKiplcnJwKQ0KPj4gICAgICAgUWNvdzJCaXRtYXBMaXN0ICpibV9s
aXN0Ow0KPj4gICAgICAgUWNvdzJCaXRtYXAgKmJtOw0KPj4gICAgICAgR1NMaXN0ICpyb19kaXJ0
eV9iaXRtYXBzID0gTlVMTDsNCj4+IC0gICAgaW50IHJldCA9IDA7DQo+PiArICAgIGludCByZXQg
PSAtRUlOVkFMOw0KPj4gKyAgICBib29sIG5lZWRfaGVhZGVyX3VwZGF0ZSA9IGZhbHNlOw0KPj4g
ICANCj4+ICAgICAgIGlmIChzLT5uYl9iaXRtYXBzID09IDApIHsNCj4+ICAgICAgICAgICAvKiBO
byBiaXRtYXBzIC0gbm90aGluZyB0byBkbyAqLw0KPj4gICAgICAgICAgIHJldHVybiAwOw0KPj4g
ICAgICAgfQ0KPj4gICANCj4+IC0gICAgaWYgKCFjYW5fd3JpdGUoYnMpKSB7DQo+PiAtICAgICAg
ICBlcnJvcl9zZXRnKGVycnAsICJDYW4ndCB3cml0ZSB0byB0aGUgaW1hZ2Ugb24gcmVvcGVuaW5n
IGJpdG1hcHMgcnciKTsNCj4+IC0gICAgICAgIHJldHVybiAtRUlOVkFMOw0KPj4gLSAgICB9DQo+
PiAtDQo+PiAgICAgICBibV9saXN0ID0gYml0bWFwX2xpc3RfbG9hZChicywgcy0+Yml0bWFwX2Rp
cmVjdG9yeV9vZmZzZXQsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzLT5i
aXRtYXBfZGlyZWN0b3J5X3NpemUsIGVycnApOw0KPj4gICAgICAgaWYgKGJtX2xpc3QgPT0gTlVM
TCkgew0KPj4gQEAgLTExMjgsMzIgKzExMjQsNTQgQEAgaW50IHFjb3cyX3Jlb3Blbl9iaXRtYXBz
X3J3KEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBFcnJvciAqKmVycnApDQo+PiAgIA0KPj4gICAgICAg
UVNJTVBMRVFfRk9SRUFDSChibSwgYm1fbGlzdCwgZW50cnkpIHsNCj4+ICAgICAgICAgICBCZHJ2
RGlydHlCaXRtYXAgKmJpdG1hcCA9IGJkcnZfZmluZF9kaXJ0eV9iaXRtYXAoYnMsIGJtLT5uYW1l
KTsNCj4+IC0gICAgICAgIGlmIChiaXRtYXAgPT0gTlVMTCkgew0KPj4gLSAgICAgICAgICAgIGNv
bnRpbnVlOw0KPj4gLSAgICAgICAgfQ0KPj4gICANCj4+IC0gICAgICAgIGlmICghYmRydl9kaXJ0
eV9iaXRtYXBfcmVhZG9ubHkoYml0bWFwKSkgew0KPj4gLSAgICAgICAgICAgIGVycm9yX3NldGco
ZXJycCwgIkJpdG1hcCAlcyB3YXMgbG9hZGVkIHByaW9yIHRvIHJ3LXJlb3BlbiwgYnV0IHdhcyAi
DQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAibm90IG1hcmtlZCBhcyByZWFkb25seS4gVGhp
cyBpcyBhIGJ1Zywgc29tZXRoaW5nIHdlbnQgIg0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAg
Indyb25nLiBBbGwgb2YgdGhlIGJpdG1hcHMgbWF5IGJlIGNvcnJ1cHRlZCIsIGJtLT5uYW1lKTsN
Cj4+IC0gICAgICAgICAgICByZXQgPSAtRUlOVkFMOw0KPj4gKyAgICAgICAgaWYgKCFiaXRtYXAp
IHsNCj4+ICsgICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJVbmV4cGVjdGVkIGJpdG1hcCAn
JXMnIGluIHRoZSBpbWFnZSAnJXMnIiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGJtLT5u
YW1lLCBicy0+ZmlsZW5hbWUpOw0KPj4gICAgICAgICAgICAgICBnb3RvIG91dDsNCj4+ICAgICAg
ICAgICB9DQo+PiAgIA0KPiANCj4gSSB0aGluayB5b3UgY2FuIGFjdHVhbGx5IGRyb3AgdGhlIGRl
ZmluaXRlIGFydGljbGUsIGJlY2F1c2UgdGhlIGltYWdlDQo+IG5hbWUgaXMgdGhlIHNwZWNpZmll
ci4NCj4gDQo+ICJVbmV4cGVjdGVkIGJpdG1hcCAnJXMnIGluIGltYWdlICclcyciIGlzIHN1ZmZp
Y2llbnQuDQo+IA0KPj4gLSAgICAgICAgYm0tPmZsYWdzIHw9IEJNRV9GTEFHX0lOX1VTRTsNCj4+
IC0gICAgICAgIHJvX2RpcnR5X2JpdG1hcHMgPSBnX3NsaXN0X2FwcGVuZChyb19kaXJ0eV9iaXRt
YXBzLCBiaXRtYXApOw0KPj4gKyAgICAgICAgaWYgKCEoYm0tPmZsYWdzICYgQk1FX0ZMQUdfSU5f
VVNFKSkgew0KPj4gKyAgICAgICAgICAgIGlmICghYmRydl9kaXJ0eV9iaXRtYXBfcmVhZG9ubHko
Yml0bWFwKSkgew0KPj4gKyAgICAgICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJDb3JydXB0
aW9uOiBiaXRtYXAgJyVzJyBpcyBub3QgbWFya2VkIElOX1VTRSAiDQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgImluIHRoZSBpbWFnZSAnJXMnIGFuZCBub3QgbWFya2VkIHJlYWRvbmx5
IGluIFJBTSIsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgYm0tPm5hbWUsIGJzLT5m
aWxlbmFtZSk7DQo+PiArICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPj4gKyAgICAgICAgICAg
IH0NCj4+ICsgICAgICAgICAgICBpZiAoYmRydl9kaXJ0eV9iaXRtYXBfaW5jb25zaXN0ZW50KGJp
dG1hcCkpIHsNCj4+ICsgICAgICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiQ29ycnVwdGlv
bjogYml0bWFwICclcycgaXMgaW5jb25zaXN0ZW50IGJ1dCAiDQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgImlzIG5vdCBtYXJrZWQgSU5fVVNFIGluIHRoZSBpbWFnZSAnJXMnIiwgYm0t
Pm5hbWUsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgYnMtPmZpbGVuYW1lKTsNCj4+
ICsgICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+PiArICAgICAgICAgICAgfQ0KPiANCj4gV2Ug
c3VwcG9ydCBSVyAtLT4gUlcgbm93LCBidXQgd2hhdCBoYXBwZW5zIGlmIHNvbWV0aGluZyBpcyBt
YXJrZWQgSU5fVVNFDQo+IG9uIFJPIC0tPiBSVz8gSXQncyBub3Qgb2J2aW91cyBmcm9tIHRoaXMg
ZnVuY3Rpb24gYWxvbmUgd2h5IHRoYXQncyBzYWZlDQo+IHRvIGlnbm9yZS4NCg0KSWYgYml0bWFw
IGlzIElOX1VTRSBpbiB0aGUgaW1hZ2UsIGl0J3MgYWx3YXlzIHNhZmUgdG8gaWdub3JlIGl0LCBh
cyBpdCdzIG1hcmtlZCBhcw0KaW52YWxpZCBhbnl3YXkuDQoNCkNvbnNpZGVyIFJPLT5SVyB3aXRo
IElOX1VTRS4NCg0KaWYgY29ycmVzcG9uZGluZyBCZHJ2RGlydHlCaXRtYXAgaXMgaW5jb25zaXN0
ZW50LCBpdCdzIE9LLg0KDQpJZiBub3QsIGhvdyBjYW4gdGhhdCBiZT8gSSBjYW4ndCBpbWFnaW5l
LiBCdXQgd2UgaGF2ZSBjb3JyZWN0IGJpdG1hcCBpbiBSQU0sIHNob3VsZA0Kd2UgbWFyayBpdCBp
bmNvbnNpc3RlbnQsIGJlY2F1c2Ugb2YgYml0bWFwIGluIGltYWdlPyBJIGRvbid0IGtub3cuDQoN
Cg0KPiANCj4+ICsNCj4+ICsgICAgICAgICAgICBibS0+ZmxhZ3MgfD0gQk1FX0ZMQUdfSU5fVVNF
Ow0KPj4gKyAgICAgICAgICAgIG5lZWRfaGVhZGVyX3VwZGF0ZSA9IHRydWU7DQo+PiArICAgICAg
ICB9DQo+PiArDQo+PiArICAgICAgICBpZiAoYmRydl9kaXJ0eV9iaXRtYXBfcmVhZG9ubHkoYml0
bWFwKSkgew0KPj4gKyAgICAgICAgICAgIHJvX2RpcnR5X2JpdG1hcHMgPSBnX3NsaXN0X2FwcGVu
ZChyb19kaXJ0eV9iaXRtYXBzLCBiaXRtYXApOw0KPj4gKyAgICAgICAgfQ0KPj4gICAgICAgfQ0K
Pj4gICANCj4+IC0gICAgaWYgKHJvX2RpcnR5X2JpdG1hcHMgIT0gTlVMTCkgew0KPj4gKyAgICBp
ZiAobmVlZF9oZWFkZXJfdXBkYXRlKSB7DQo+PiArICAgICAgICBpZiAoIWNhbl93cml0ZShicy0+
ZmlsZS0+YnMpIHx8ICEoYnMtPmZpbGUtPnBlcm0gJiBCTEtfUEVSTV9XUklURSkpIHsNCj4+ICsg
ICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJGYWlsZWQgdG8gcmVvcGVuIGJpdG1hcHMgcnc6
IG5vIHdyaXRlIGFjY2VzcyAiDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAidGhlIHByb3Rv
Y29sIGZpbGUiKTsNCj4+ICsgICAgICAgICAgICBnb3RvIG91dDsNCj4+ICsgICAgICAgIH0NCj4+
ICsNCj4+ICAgICAgICAgICAvKiBpbl91c2UgZmxhZ3MgbXVzdCBiZSB1cGRhdGVkICovDQo+PiAg
ICAgICAgICAgcmV0ID0gdXBkYXRlX2V4dF9oZWFkZXJfYW5kX2Rpcl9pbl9wbGFjZShicywgYm1f
bGlzdCk7DQo+PiAgICAgICAgICAgaWYgKHJldCA8IDApIHsNCj4+IC0gICAgICAgICAgICBlcnJv
cl9zZXRnX2Vycm5vKGVycnAsIC1yZXQsICJDYW4ndCB1cGRhdGUgYml0bWFwIGRpcmVjdG9yeSIp
Ow0KPj4gKyAgICAgICAgICAgIGVycm9yX3NldGdfZXJybm8oZXJycCwgLXJldCwgIkNhbm5vdCB1
cGRhdGUgYml0bWFwIGRpcmVjdG9yeSIpOw0KPj4gICAgICAgICAgICAgICBnb3RvIG91dDsNCj4+
ICAgICAgICAgICB9DQo+PiAtICAgICAgICBnX3NsaXN0X2ZvcmVhY2gocm9fZGlydHlfYml0bWFw
cywgc2V0X3JlYWRvbmx5X2hlbHBlciwgZmFsc2UpOw0KPj4gICAgICAgfQ0KPj4gICANCj4+ICsg
ICAgZ19zbGlzdF9mb3JlYWNoKHJvX2RpcnR5X2JpdG1hcHMsIHNldF9yZWFkb25seV9oZWxwZXIs
IGZhbHNlKTsNCj4+ICsgICAgcmV0ID0gMDsNCj4+ICsNCj4+ICAgb3V0Og0KPj4gICAgICAgZ19z
bGlzdF9mcmVlKHJvX2RpcnR5X2JpdG1hcHMpOw0KPj4gICAgICAgYml0bWFwX2xpc3RfZnJlZShi
bV9saXN0KTsNCj4+DQo+IA0KPiBTZWVtcyBPSyBvdGhlcndpc2UsIGJ1dCBJIGp1c3QgaGF2ZSB0
aGF0IG9uZSBkb3VidC4NCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

