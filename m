Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A839C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 00:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54F782073E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 00:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c/v/qnUx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vzttA/9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F782073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr9yl-0000ff-K7
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 20:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=446c5dbe3=Dmitry.Fomichev@wdc.com>)
 id 1jr9qo-000361-6z; Thu, 02 Jul 2020 20:46:46 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:42236)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=446c5dbe3=Dmitry.Fomichev@wdc.com>)
 id 1jr9qm-0006r4-9b; Thu, 02 Jul 2020 20:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593737204; x=1625273204;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=L/C7I5wYDf7U9ZOOrYdiJKEAl0ZmK14WoOJAKTBiiDY=;
 b=c/v/qnUxzmJ1XW0Ecvz94q8BdiKuG2KhDtQ5MvqRVgJCeyRtDxdThF5h
 HAVm7VXXaIugT7uXm2NfABpM6F3ED9EWMuCmlik7ndz2m/dn0kxtjf6l7
 d3aGEbEd3I9erc3iDn+bUPykKDBiUMEH63flEd6seHVVKENftklUuGJ93
 4VWIpyBGHVGU3RB34MiZa4/woOlb3n1YiBgk7BYKMFYu7afS/FQemOu5E
 0qLMQcW0nk3tMCCbZ+Tex/yqFqFIcPBDdXQ+mdf1b5Ukp59PNNgU/51wy
 70U0hqQCLslUbTSNIjq4FfQwJQDqJFacIS1cerBCQB3HDmosgmexZ3FhW Q==;
IronPort-SDR: C95+i5+nc/DAfzcZsLZBS1P1TIh7N2DQFECa3orE1CKXaVgtqZ+awmeX5bDQDieTus4vCZAOCT
 DKJqE4urD+Q0Ks+DWZsaHRbRz3M3GcoLIxER6BUKfXQwF5V990zs6H0W5WcTTT0Akd0l6BgZVh
 w+8S+Ra3xMdU7fvsXl5Jomw1GEZHjxLRj3U8EAL9jMSMEeUKB/AkOJdvOLy1kT7aQe8xKa6UCK
 CYpZwEDfaEGJQT77LZkrJY4mvH0bFaOSi+ldHlux7r1SKavVS3wSLnmmuZHr9479OeyHCg6v9q
 XTs=
X-IronPort-AV: E=Sophos;i="5.75,306,1589212800"; d="scan'208";a="250767685"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 08:46:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ty74vMacnh1+1GjUdSsOWuo0T4V8wIhOet7QULcctl1MVxtcYXCy5W6zcQ60mKEnIBw3Xwyvvmj9Fugx0j+wCVk0QtbYgTqtoCFBBqTqHxG8Y2k11ABCSat6fPgcwbOFYW3twSyHzvNIijkLGTObksq0w6z6hwGwRK/9Z9bqn9TrhlpOnPQzgosvlxBgBXBI7pW/CTkNnwguL4Ez5mt17QGUAWtsGnM9SkYoQKwwVN/to2AMbq94b7xPUzLivYcVfMXMNens9V3k2I/pVjtb+No30iFVSHTgeBI14BhGRwNq0phh98upVquglvbIt/PMSeD10s7UZ1RmnjD0W6/VZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/C7I5wYDf7U9ZOOrYdiJKEAl0ZmK14WoOJAKTBiiDY=;
 b=npBxQf6/ou0hSbpTEXKgsyseyT3hM+Cw3AZTH3En1TpIsqLLx7/++glHEA/TublXFX4Yo3PZ0T63kPWK0rcwQoLWa8+EocCLWo3+OKDVj1J4Zp+BUyVwl8iwEJgUp9YzBpG+SWJqtk3LAKD/5MQn2eD5UK8xV3S3KQWcOq9q6R59vLw8QbaCR+ZJG+1K3FLZIpYvt0zBA4a0Ok1xZRAiUUxMY6SKvL+4TlAl/3io3qGZ6jOdeBGQf9KQ0YLG3h6QpTvkTHPakgGaM1ZuuUOE2CyHYPSIxSBv/kfASkf+jQBPCBIoaUqtKcC+9PIDaf0I/PFrsvnv3gkT+5bkvz8BVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/C7I5wYDf7U9ZOOrYdiJKEAl0ZmK14WoOJAKTBiiDY=;
 b=vzttA/9mmEdmsKWkpX1l3RETFsu+bcXVWMxFojPfyKdI9BLOS+4Js1E2+yaJy3fYwrTQsKW/cI40++eeABype+4W491KoExjZLG8BCW/IZdOP4uje41nxaE0y3/TsYMqI7a+jtWab1OZ2KugMhPtjq3FkQzypec7A/d0iikAd1I=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5552.namprd04.prod.outlook.com (2603:10b6:208:de::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Fri, 3 Jul
 2020 00:46:41 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9%5]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 00:46:40 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: "its@irrelevant.dk" <its@irrelevant.dk>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 13/17] hw/block/nvme: make sure ncqr and nsqr is valid
Thread-Topic: [PATCH 13/17] hw/block/nvme: make sure ncqr and nsqr is valid
Thread-Index: AQHWTkQtGvf8m6DpkUS+1H0+RpIuk6j1CksA
Date: Fri, 3 Jul 2020 00:46:40 +0000
Message-ID: <affbe090fcd5a158af7b7b9dc9e7c23342b83487.camel@wdc.com>
References: <20200629182642.1170387-1-its@irrelevant.dk>
 <20200629182642.1170387-14-its@irrelevant.dk>
In-Reply-To: <20200629182642.1170387-14-its@irrelevant.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [173.70.233.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 773ad1b0-e37b-487a-ba47-08d81eea8d03
x-ms-traffictypediagnostic: MN2PR04MB5552:
x-microsoft-antispam-prvs: <MN2PR04MB5552065220931E0E2BCEC310E16A0@MN2PR04MB5552.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w2rYShi7O/VOVkhraCXuIvq/vQHaiqOsf18JstHAH9z2+AYFQUNY22s4eb4+iKAV2z10XmGPjOzp1x+pOOeo3cVA3DkCruOFrnsAWLn58WMn8NLuhzCDpG+tgJ5J5+K3lnZOG02i+Ay1D6orRSLrP1+Qju9KFF78ItsYYTfOTUew/qnOcVlOn1ElKKMDQLOkc73nkRwSTFW7Yrhrr8qLdyG7rXQBMkICeeQgKHJZ8IgCJq6EexaDE9kw1oPRg38f2V+Zn9uqpNYQ4EGBe5/hJxAgkYse4iqekXAQKMeYpq1BKNNOMBebJkrHV0EJLGkl62PoQtiLzwDGAhPFrLVE4g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(4326008)(186003)(76116006)(2616005)(83380400001)(6486002)(6512007)(110136005)(66946007)(66476007)(66446008)(54906003)(64756008)(66556008)(36756003)(71200400001)(8936002)(26005)(86362001)(316002)(5660300002)(2906002)(8676002)(478600001)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: DQZGL6eXzU+H5kefPc34x61loc0Btd/fam+G47+Np2g1dUXdjgq5+QdBYfzx1cJZxu5dWMsgJTFihvubsEHc2M6jnsm6uVFH3V9lYMmEMm3ymrSoWmexILgQDVx6Pb1e2tHvSZxl6JixnCc3ZJe56SmvTYVsH0E6N6obt4LRARqX+wWTnJouw7qzGParxdfb6ZBvh6lbKfg4boo2EHCYutl84DnoW1LHIZOWFMKzHoI9pbfbZy1YYQfRKEwtCUkuWNQ/YdJP/J3uyhQCAL/dvWJldlliI+RDPqTJScd3HUtb+mCZNFmwvHsTmqTbyH64q6OScQ2PjWWuUyIRToa6lhFjGAGiNBJc2M7IsLKoV616W9aokUe5tfI7su6/UKklPcSXFb00REhK2O2YIsAWGZfP6Y9kcQoYW9keIwTWsmnZQuPCpYUSZepRMLG6MW5MJ+qFT063Mv6itWENbQVItSphF5ILmDR/AeJtMeFDuDn576v+g95FnpnO8tLOpCKA
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F3821BB7566E740943AB0E90C8EC474@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 773ad1b0-e37b-487a-ba47-08d81eea8d03
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 00:46:40.8818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rH7a4L6R5cpsdKqIvxPCU/HmpWFGynq5PZtUqHvHaqUMl6PWhQYUCErSubUUnRLPmD4PaZjtxMNPl0wMtruH1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5552
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=446c5dbe3=Dmitry.Fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 20:46:09
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "k.jensen@samsung.com" <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IERtaXRyeSBGb21pY2hldiA8ZG1pdHJ5LmZvbWlj
aGV2QHdkYy5jb20+DQoNCk9uIE1vbiwgMjAyMC0wNi0yOSBhdCAyMDoyNiArMDIwMCwgS2xhdXMg
SmVuc2VuIHdyb3RlOg0KPiBGcm9tOiBLbGF1cyBKZW5zZW4gPGsuamVuc2VuQHNhbXN1bmcuY29t
Pg0KPiANCj4gMHhmZmZmIGlzIG5vdCBhbiBhbGxvd2VkIHZhbHVlIGZvciBOQ1FSIGFuZCBOU1FS
IGluIFNldCBGZWF0dXJlcyBvbg0KPiBOdW1iZXIgb2YgUXVldWVzLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogS2xhdXMgSmVuc2VuIDxrLmplbnNlbkBzYW1zdW5nLmNvbT4NCj4gQWNrZWQtYnk6IEtl
aXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IE1heGltIExldml0
c2t5IDxtbGV2aXRza0ByZWRoYXQuY29tPg0KPiAtLS0NCj4gIGh3L2Jsb2NrL252bWUuYyB8IDgg
KysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9ody9ibG9jay9udm1lLmMgYi9ody9ibG9jay9udm1lLmMNCj4gaW5kZXggYTQxNjY1
NzQ2ZDMzLi4yMjc5ZDgzOTVhYWEgMTAwNjQ0DQo+IC0tLSBhL2h3L2Jsb2NrL252bWUuYw0KPiAr
KysgYi9ody9ibG9jay9udm1lLmMNCj4gQEAgLTEyNTcsNiArMTI1NywxNCBAQCBzdGF0aWMgdWlu
dDE2X3QgbnZtZV9zZXRfZmVhdHVyZShOdm1lQ3RybCAqbiwgTnZtZUNtZCAqY21kLCBOdm1lUmVx
dWVzdCAqcmVxKQ0KPiAgICAgICAgICBibGtfc2V0X2VuYWJsZV93cml0ZV9jYWNoZShuLT5jb25m
LmJsaywgZHcxMSAmIDEpOw0KPiAgICAgICAgICBicmVhazsNCj4gICAgICBjYXNlIE5WTUVfTlVN
QkVSX09GX1FVRVVFUzoNCj4gKyAgICAgICAgLyoNCj4gKyAgICAgICAgICogTlZNZSB2MS4zLCBT
ZWN0aW9uIDUuMjEuMS43OiAweGZmZmYgaXMgbm90IGFuIGFsbG93ZWQgdmFsdWUgZm9yIE5DUVIN
Cj4gKyAgICAgICAgICogYW5kIE5TUVIuDQo+ICsgICAgICAgICAqLw0KPiArICAgICAgICBpZiAo
KGR3MTEgJiAweGZmZmYpID09IDB4ZmZmZiB8fCAoKGR3MTEgPj4gMTYpICYgMHhmZmZmKSA9PSAw
eGZmZmYpIHsNCj4gKyAgICAgICAgICAgIHJldHVybiBOVk1FX0lOVkFMSURfRklFTEQgfCBOVk1F
X0ROUjsNCj4gKyAgICAgICAgfQ0KPiArDQo+ICAgICAgICAgIHRyYWNlX3BjaV9udm1lX3NldGZl
YXRfbnVtcSgoZHcxMSAmIDB4RkZGRikgKyAxLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKChkdzExID4+IDE2KSAmIDB4RkZGRikgKyAxLA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgbi0+cGFyYW1zLm1heF9pb3FwYWlycywNCg==

