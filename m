Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB72DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 01:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A9ED2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 01:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ljMVhn98";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UYY69iDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9ED2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jumwo-0006BO-Ra
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 21:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=456505283=Dmitry.Fomichev@wdc.com>)
 id 1jumw1-0005IG-58; Sun, 12 Jul 2020 21:07:09 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:2417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=456505283=Dmitry.Fomichev@wdc.com>)
 id 1jumvy-0000Jy-J9; Sun, 12 Jul 2020 21:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594602426; x=1626138426;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=rRPLGxJque5X5t/ozEqS4J4X0vWDaCkRvhYOsJqQWIs=;
 b=ljMVhn98xlk9QQ3usIurceNPN0aizRhu5K3/TPUA9n9G5ClQGfIbhBnY
 ecm7+Li9cqH2MFgCLeSj2LbsKymd3MWIGDSXtnTsttyathVp52vbfQVTA
 M7CFTF2GMt7uFXQPWQmPrG9tYeS3OXi/Zu6lcS6+Bk1MJLk3ig3y9CbUa
 U9/1XveZRAmT6xyJfIyM9id84U9g9Ozzr6RCmjAzaC9OmHjLEys5tq6C7
 pOvvMwayzvYmn2QbP2gZqL/feu/OhPW6IQNnIuNF/NyE2qg7r/XNgAJos
 5UwWcoGzCuJL6IxvlQVTCglqR8ppZNiKWgDUo8Ra3aTrsrZCVZ5aI1bPf g==;
IronPort-SDR: pjoZiYHF7RBAPX0/gZ37rldrZqTwa4u+oJU8PokSTsandhQLQ3ketmuSoebUq78NBevqasF0Qu
 PITOyfd62BeJCwkjtQ84uhLUdmJSLO8HYzitTdRjDf0E+D0152nTpBJiDK/3yB9STOSAJ52TSI
 mFB8eqcqEgqNOLZ5WdBBqNTT8vqsZZBbdpC89A585gHnV4zRT3vLEAg3gkM01GusHOd8WxWu0l
 mOivqpcWlZEb+UbZUX0rNN1pD0ySb/b8tCp41B3l74js7e/XCnTx0As7Q483xkj+7dKe2szyeq
 FGs=
X-IronPort-AV: E=Sophos;i="5.75,345,1589212800"; d="scan'208";a="143586911"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
 by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2020 09:07:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Am/d7m7y17pXIwZSHd/jlCHFggA2+KeQL6hcmlklZkv8nlFKwlr7c1M1/vVLIRu4P4HYlqaGwkOT8nsuRS3gkzUVY1DhF9lu45Xx/Se5OhvXicIfrTyk0SsE34zFCq9zgn9ZBvT89YnAcb3/4meYXQ+qEMEaMGQFrFt3LvQQebLnOEQGJvvtTPJZ2AJAJr08WA42rwlv9SMzPgtW7fx18lQLgZJAw8s1tG85yrsaHzQX71qgq1wlnNad0TkD6ARRrQuqAHQUq7MKpR1Gy+e+f2dj6xlLeQyb+FQRnKyTbf1jb4WHxe0ES6OfGtkndt8JDeQmZsp/RKvcU+ZEysxE8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRPLGxJque5X5t/ozEqS4J4X0vWDaCkRvhYOsJqQWIs=;
 b=hPiAtWRL7ebVq7yKNKpWCFQc/0u8lCy3nPkelKOZtktFWUUPRtbKGapMwzRDZ9KFUDb9KJm0ssvb4WYr0MUzrWwYtfaEQxbNGU4TREXVKzEtpADeSNWFJ7t9yWLQU/RQP6UBSE8OJjpq4K0F20xzoQwW2IPIRwSqnQS9V2G3dhJ3nBB3kt6IdMfh3jVeekYDWIL/ayCCHF32VtkDR2uRFsY3Dp1rZ49SlT2CfGeD/3OVa7fYyROSHigKe3HYxApSGyxvKo6oI7o7HznnUrrddAwsCWOvFNpKLZK9/9Z9IPvKZHWdq1l6beIYDdKrpH09ipO54DG5m8Nk4EBUGJ8wbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRPLGxJque5X5t/ozEqS4J4X0vWDaCkRvhYOsJqQWIs=;
 b=UYY69iDAIf5aTADNi8cIIbv/AGCzgDQ3pPm13Ld26Y1b04cd6iPwEsT9hKpZu7CXPFYjQYCUA35PkTc/TYXRG2PxXdQnGR1k2mmmUU8Nx9lbijTI3Wf/cU66Az99PCDp/dfk6TXhYcHEzkM49XGIisnhgBxdXy4pob3Ks+doPAQ=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5680.namprd04.prod.outlook.com (2603:10b6:208:3a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.24; Mon, 13 Jul
 2020 01:07:00 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9%5]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 01:07:00 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: "philmd@redhat.com" <philmd@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 3/4] hw/block/nvme: Fix pmrmsc register size
Thread-Topic: [PATCH v3 3/4] hw/block/nvme: Fix pmrmsc register size
Thread-Index: AQHWTs6o0rIHdzw8XkG8oO0hY+ciYqkExjSA
Date: Mon, 13 Jul 2020 01:07:00 +0000
Message-ID: <20a270874cc6e2be3293b94a7a6f0f1c3a6024b1.camel@wdc.com>
References: <20200630110429.19972-1-philmd@redhat.com>
 <20200630110429.19972-4-philmd@redhat.com>
In-Reply-To: <20200630110429.19972-4-philmd@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [100.35.204.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6b79d153-036f-4f77-071e-08d826c90c46
x-ms-traffictypediagnostic: MN2PR04MB5680:
x-microsoft-antispam-prvs: <MN2PR04MB5680FDFD57E644AA2644325DE1600@MN2PR04MB5680.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Io/HhyTktQ13vswn+kVyrlyT9A7SvZdUG4u3jgwVxgfp8+Hk0sgiNYYYRmS/1PPCKKyWPgsX7KXDQ7aO+X1g04nN0yGA1Nbfts6TdEFXs96t0NbQ9zH0nQM/tOcqXIyQJFe++o4WnEaV+nY1EazjDwbXrUXh2Jn4NHeIa/topRxe17kI4p1W5uTffL4gID5oqnN49xnxUBoXqSpTFIIQ/aCopvavkePQFzS0GoTGaChpkEKilOs7SsieZUQ22OuZdnrV7MXv/+eXa6RtL8g17InPPTbJ5bfGUclpZ1WcP/1+p+AnX7E8NKlHPZjBWlSOwmG2efRaEBPEVvvSyKO7mWjspcp2RL1No66/HP1rtG6v/rI6AF1Ts+f1qDLjKpIp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(4326008)(8936002)(83380400001)(5660300002)(478600001)(110136005)(2616005)(26005)(6486002)(186003)(54906003)(6512007)(4744005)(36756003)(71200400001)(8676002)(2906002)(86362001)(66946007)(64756008)(66556008)(66476007)(316002)(76116006)(6506007)(66446008)(40753002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 2YjT4P4QMqxYDd9EBreGCGlDMn+YImLwUGSYkazRV+hVogGNdqYu5L5ABeHoPUgrY9WCEEf3ByqVAOuxrSeJDOwR60HgS8N61VQ40sJS8wMDyD4kyf4mPtEy/8FcL+4nF8YCN3YnslS7aPCG6Z21v/3Vp+bGBr7D30mHOj4gNPqhVbgA/iAjpVBQHMuZCE0bQ+oU0mH02CB633+PzuKFDEoc74q/fSIENqGXPFRXiyLsdUpp+HNjtnMy5BN3sdY9VVqAwkpu4A9HMg7w8qSr02uBXGkF53r2nydzdO37EnFrD2Ue1Ay7/aXYqb33w04WorE/sT55hQhSuFSdeuqmOH0+lhuU4KgiUqY8wd/WUi4qeQXhrExmRUwarqZh4aFcBJ+A9swzYsm8yAI3cohxR6YRZ/jxyqRZtnhrj3A4O9hf0azRHn5XItm5CsX71LIUxBJbYKUXou962WXlnetI6P/0EeTUW+EayDWyjxP3jSLria+beRLbkavzkAq0xMhT
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D8861FD56F85B41A5CEC84276227A1F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b79d153-036f-4f77-071e-08d826c90c46
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 01:07:00.7124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 02Gl/XMgkSJN7JzsRjOqK4fa/THWsADeTbBr5/yMP5oyNg1qdv5cAckiKVKIV496Xigv9y4JKIddPG6Wvbv4kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5680
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=456505283=Dmitry.Fomichev@wdc.com; helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/12 21:07:03
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "k.jensen@samsung.com" <k.jensen@samsung.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "andrzej.jakowski@linux.intel.com" <andrzej.jakowski@linux.intel.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gVHVlLCAyMDIwLTA2LTMwIGF0IDEzOjA0ICswMjAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToNCj4gVGhlIFBlcnNpc3RlbnQgTWVtb3J5IFJlZ2lvbiBDb250cm9sbGVyIE1lbW9y
eSBTcGFjZSBDb250cm9sDQo+IHJlZ2lzdGVyIGlzIDY0LWJpdCB3aWRlLiBTZWUgJ0ZpZ3VyZSA2
ODogUmVnaXN0ZXIgRGVmaW5pdGlvbicNCj4gb2YgdGhlICdOVk0gRXhwcmVzcyBCYXNlIFNwZWNp
ZmljYXRpb24gUmV2aXNpb24gMS40Jy4NCj4gDQo+IEZpeGVzOiA2Y2Y5NDEzMjI5ICgiaW50cm9k
dWNlIFBNUiBzdXBwb3J0IGZyb20gTlZNZSAxLjQgc3BlYyIpDQo+IFJlcG9ydGVkLWJ5OiBLbGF1
cyBKZW5zZW4gPGsuamVuc2VuQHNhbXN1bmcuY29tPg0KPiBSZXZpZXdlZC1ieTogS2xhdXMgSmVu
c2VuIDxrLmplbnNlbkBzYW1zdW5nLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0
aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPg0KPiAtLS0NCj4gQ2M6IEFuZHJ6ZWogSmFr
b3dza2kgPGFuZHJ6ZWouamFrb3dza2lAbGludXguaW50ZWwuY29tPg0KPiAtLS0NCj4gIGluY2x1
ZGUvYmxvY2svbnZtZS5oIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ibG9jay9udm1lLmgg
Yi9pbmNsdWRlL2Jsb2NrL252bWUuaA0KPiBpbmRleCA3MWM1NjgxOTEyLi44MmMzODQ2MTRhIDEw
MDY0NA0KPiAtLS0gYS9pbmNsdWRlL2Jsb2NrL252bWUuaA0KPiArKysgYi9pbmNsdWRlL2Jsb2Nr
L252bWUuaA0KPiBAQCAtMjEsNyArMjEsNyBAQCB0eXBlZGVmIHN0cnVjdCBRRU1VX1BBQ0tFRCBO
dm1lQmFyIHsNCj4gICAgICB1aW50MzJfdCAgICBwbXJzdHM7DQo+ICAgICAgdWludDMyX3QgICAg
cG1yZWJzOw0KPiAgICAgIHVpbnQzMl90ICAgIHBtcnN3dHA7DQo+IC0gICAgdWludDMyX3QgICAg
cG1ybXNjOw0KPiArICAgIHVpbnQ2NF90ICAgIHBtcm1zYzsNCj4gIH0gTnZtZUJhcjsNCj4gIA0K
PiAgZW51bSBOdm1lQ2FwU2hpZnQgew0KPiAtLSANCj4gMi4yMS4zDQo+IA0KPiANCg0KUmV2aWV3
ZWQtYnk6IERtaXRyeSBGb21pY2hldiA8ZG1pdHJ5LmZvbWljaGV2QHdkYy5jb20+DQoNCg==

