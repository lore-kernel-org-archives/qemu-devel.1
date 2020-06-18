Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855DFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 03:09:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A0A20FC3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 03:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="pUUvMBKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A0A20FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlkvl-0004Rn-KP
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 23:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jlkv2-0003bv-5r; Wed, 17 Jun 2020 23:08:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:19485)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jlkuz-0006m3-F4; Wed, 17 Jun 2020 23:08:47 -0400
IronPort-SDR: jEGBkO2Kvtt56gykefZLO0SvoaP63Uv4CdVPp/88SyLdnK0fO+pYqSKq0a6sDsDVUdrG6T12DT
 Xh+pYWxw1JiA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2020 20:08:41 -0700
IronPort-SDR: QN6pNq491IXeLzIOckskH4c8QYg2Pljhjnf2SqSnWrhAun2D0UnaxRVGKkbOuWsIxGfY33sYoV
 PipSUBbnxNyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,524,1583222400"; d="scan'208";a="477088403"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga005.fm.intel.com with ESMTP; 17 Jun 2020 20:08:40 -0700
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 17 Jun 2020 20:08:40 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 17 Jun 2020 20:08:40 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 17 Jun 2020 20:08:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geyLFuQH2sMyarIi5fm9z7I0BQndlnPMDtzA3r/qnqQdhn6C3AL+1fmHt6M78WkKUJWndiNdf0JgzelhqLbDg6igQqyU/xGfpj4g27RXmiV7Ew+zTLXgSVPRXOdx8tS0EC8NnvqNp9B6xK2V6WDhMERfZmLaJkCRc+Ah9cOd6FAkIlNvBdYKD422E89QRnfXxSIEzJQm2tsTHdBbKt06uW11vD+HQtTvCbuvltXRjC4nOB2LlIozl/BcSKC64gafm+nSd+lu89b5e0bNKVCejArDdmVgaqqDXhnLZCw+CwoTs0Pe0Hv9qHcT3Csg/oSWMSU2KlixuGIfC94w+m4GqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4Tn1QgC23raf0MWJQineuDGzOFQlqxFWM26fd6ucLk=;
 b=GE/JOwdPjXm6vvBzbnbct7XMqdicx7aL/HAjTGNl2YUzCvB8NR45tzpxOskpKUd3lDycfBimqx/4tOqSJ4P8DkoepL1e0avoZhg84WI5IXXNZ7RFpeIksmAln85VOlUqyzc/7WtbUgaDH2HQ2a6Ed3xg5byv1qjWGqvD4WEcim9R4YbZLMMaIZLTF7nVvothxI9SwaRbpnG7K4M+2kFT4by/urgULuW5vG2wSTZ8wH+eHKwg7mIvg5Rj6l4A4gszT1MklsKd6fFVdeXXmB+WC6W0qSXy9MYBDeKIGwV20jiALRE6nRVqTbMcp/8O12iUdb7CeqnqTTs5KZd8PRz6/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4Tn1QgC23raf0MWJQineuDGzOFQlqxFWM26fd6ucLk=;
 b=pUUvMBKTBbyyfPeMk77FHun0jnTuthgSN0w6k97q7z0oLxz2MaBF7G3TMk/cQo3b2uGC8WiVveHtCe/j8eiYk6+4I0A14zVLmoA3KxESDiefFlOWGclScmkpWfbKW3LZv6dX+dsiDdjU8HLs6RXBT+XEPI8okFCF8CZH/pqJ+Is=
Received: from BN6PR11MB1827.namprd11.prod.outlook.com (2603:10b6:404:fb::19)
 by BN6PR11MB1281.namprd11.prod.outlook.com (2603:10b6:404:47::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.23; Thu, 18 Jun
 2020 03:08:38 +0000
Received: from BN6PR11MB1827.namprd11.prod.outlook.com
 ([fe80::d56f:a59c:536a:7693]) by BN6PR11MB1827.namprd11.prod.outlook.com
 ([fe80::d56f:a59c:536a:7693%4]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 03:08:38 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: RE: [PATCH] hw/nios2: Update interrupt request when CR_STATUS_PIE
 disabled
Thread-Topic: [PATCH] hw/nios2: Update interrupt request when CR_STATUS_PIE
 disabled
Thread-Index: AQHWP4ZsWxBTOO2K8UOOQsF38ZGk3KjbaaGAgAJQw+A=
Date: Thu, 18 Jun 2020 03:08:38 +0000
Message-ID: <BN6PR11MB1827A8D46827893AEF611BED8D9B0@BN6PR11MB1827.namprd11.prod.outlook.com>
References: <20200611081319.1864-1-wentong.wu@intel.com>
 <CAFEAcA_oQ7X9COCPnoarrKfGtXD4CVKs7MAjWq-i_8yc5jTtDA@mail.gmail.com>
In-Reply-To: <CAFEAcA_oQ7X9COCPnoarrKfGtXD4CVKs7MAjWq-i_8yc5jTtDA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60f81ebc-4f18-4d73-ddaa-08d81334e5e3
x-ms-traffictypediagnostic: BN6PR11MB1281:
x-microsoft-antispam-prvs: <BN6PR11MB1281A8D8C7F12492E67F34338D9B0@BN6PR11MB1281.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YJsKYh8nv/rAnsoqex7EMB9N7N8Gja4cwoO6WJBAoMHUXAvX5SOqinfKyU2HRXq8tCfKFKDSV04k4xlS0iH/Y/1f66I8CVNt5fvkgmbf3MwBaVOvnJsIuXnLwMfwpz4mxoPlh0PBCvOVCiE2HKO7jjLUjDZFL6uTHxjhxQa5gKS8SQya8RY8dYL5TxrZMs7NjeE2fBTKECjR65756vuKdeFIBHDYSifKUBHeeGpQLPF/+OAw6Vl146OWkQ1IwO9Zb4KDiNIqoQn24Wp40rwagDo4ngB3hbxkhq8KW9Wdp7guQLEuQY+g0h06feVmXDsiD9hA7+fGP1DPE/sGN2UTWA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR11MB1827.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(71200400001)(54906003)(86362001)(6916009)(8676002)(8936002)(316002)(64756008)(9686003)(66476007)(66556008)(52536014)(186003)(15650500001)(66946007)(5660300002)(478600001)(83380400001)(66446008)(6506007)(26005)(7696005)(55016002)(4326008)(76116006)(2906002)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: ZLgtYktqUHQN7D2Fc/sWUAVgJK48uca7EzKuKCFcnL22wArKGDdVlhffUIjaqt2eSsbYpGmaSGZG+RqPupDjN4PStdLw8zOQsIZjyxvJ2UnZOPAvg/ouN0LPtOGOJW5BCE16D6J19j1APsJSahnR/U4zWbhYobqxUr3PripVvV6k5/UvRJ7KD8LoaXzeNQ3FRVKzAC9jJ8XilJaaMpTemGo8vzzb4BJUwo8dlbS9SGZQVcy+g/hWMz4RKIYV5rL4dagA9yY52OiFfDs0xrIDzETb+EltzaBuq3hhnVdm/gezSvtcyodtgtpipPuJEtfs4K9cuBaYulHDZIwc0ni2XPl9Y+ScSr8Cs4Ixh44FS56aMRYHkI7Wcc3f7PPL0h7dYlhn0A+UHXx3YEqswaUvvdhjBKOQsdZgSsGRdrlds2pbhMsjdrXIBGHfYKqoTM4PErDUhHy77mr6SS3CB0n4xnk8oyKuLpN5OJhY+ihg8wYbZtz1rHBRQaTJ/4klaw6p
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f81ebc-4f18-4d73-ddaa-08d81334e5e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 03:08:38.8188 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h7yfJw0n8mVyq80Tubb7tr8MUbctPxovZxQel/EsASTa6YwkPFa40te+uCR34I6BLg2rOTIRxi5x/IJTsYuHlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1281
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=wentong.wu@intel.com; helo=mga07.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 23:08:41
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Marek Vasut <marex@denx.de>,
 Chris Wulff <crwulff@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQo+ID4NCj4gPiBVcGRhdGUgaW50ZXJydXB0IHJlcXVlc3Qgd2hlbiBleHRlcm5hbCBpbnRlcnVw
dCBwZW5kcyBmb3IgU1RBVFVTX1BJRSANCj4gPiBkaXNhYmxlZC4gT3RoZXJ3aXNlIG9uIGljb3Vu
dCBlbmFibGVkIG5pb3MyIHRhcmdldCB0aGVyZSB3aWxsIGJlIGNwdSANCj4gPiBhYm9ydCB3aGVu
IGd1ZXN0IGNvZGUgY2hhbmdlcyBzdGF0ZSByZWdpc3RlciB3aXRoIHdyY3RsIGluc3RydWN0aW9u
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2VudG9uZyBXdSA8d2VudG9uZy53dUBpbnRlbC5j
b20+DQo+ID4gLS0tDQo+ID4gaHcvbmlvczIvY3B1X3BpYy5jIHwgMiArKw0KPiA+IDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9uaW9zMi9j
cHVfcGljLmMgYi9ody9uaW9zMi9jcHVfcGljLmMgaW5kZXggDQo+ID4gMWMxOTg5ZDUuLjJhYmM4
ZmE4IDEwMDY0NA0KPiA+IC0tLSBhL2h3L25pb3MyL2NwdV9waWMuYw0KPiA+ICsrKyBiL2h3L25p
b3MyL2NwdV9waWMuYw0KPiA+IEBAIC00Miw2ICs0Miw4IEBAIHN0YXRpYyB2b2lkIG5pb3MyX3Bp
Y19jcHVfaGFuZGxlcih2b2lkICpvcGFxdWUsIGludCBpcnEsIGludCBsZXZlbCkNCj4gPiAgICAg
ICAgfSBlbHNlIGlmICghbGV2ZWwpIHsNCj4gPiAgICAgICAgICAgICBlbnYtPmlycV9wZW5kaW5n
ID0gMDsNCj4gPiAgICAgICAgICAgICBjcHVfcmVzZXRfaW50ZXJydXB0KGNzLCB0eXBlKTsNCj4g
PiArICAgICAgICB9IGVsc2Ugew0KPiA+ICsgICAgICAgICAgICBjcy0+aW50ZXJydXB0X3JlcXVl
c3QgfD0gdHlwZTsNCj4gPiAgICAgICAgfQ0KDQo+IFRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRp
b24gaW4geW91ciBvdGhlciBlbWFpbCBhYm91dCB0aGUgaXNzdWUgeW91J3JlIHRyeWluZyB0byBh
ZGRyZXNzOg0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXchDQoNCj4gPiBJ4oCZbSBydW5uaW5nIGlj
b3VudCBtb2RlIG9uIHFlbXVfbmlvczIgd2l0aCBjdXN0b21pemVkIHBsYXRmb3JtIGJ1dCBjcHUg
DQo+ID4gYWJvcnQgaGFwcGVuZWQocWVtdTogZmF0YWw6IFJhaXNlZCBpbnRlcnJ1cHQgd2hpbGUg
bm90IGluIEkvTyANCj4gPiBmdW5jdGlvbikgd2hlbiBndWVzdCBjb2RlIGNoYW5nZXMgc3RhdGUg
cmVnaXN0ZXIgd2l0aCB3cmN0bCANCj4gPiBpbnN0cnVjdGlvbiBhZGQgc29tZSBkZWJ1ZyBjb2Rl
IGZpbmRpbmcgdGhhdCBpdOKAmXMgY2F1c2VkIGJ5IHRoZSANCj4gPiBpbnRlcnJ1cHRfcmVxdWVz
dCBtaXNtYXRjaC4NCg0KPiBJIGRvbid0IHRoaW5rIHRoZSBjaGFuZ2UgeW91J3ZlIG1hZGUgaXMg
dGhlIGNvcnJlY3QgZml4Lg0KPiBTZXR0aW5nIGNzLT5pbnRlcnJ1cHRfcmVxdWVzdCBsaWtlIHRo
aXMgaXMgcHJldHR5IG11Y2ggdGhlIHNhbWUgdGhpbmcgdGhhdCBjYWxsaW5nIGNwdV9pbnRlcnJ1
cHQoKSBkb2VzLCBzbyB3aGF0IHlvdXIgcGF0Y2ggaXMgZG9pbmcgaXMgZXNzZW50aWFsbHkgImln
bm9yZSB0aGUgc3RhdHVzLlBJRSBiaXQgYW5kIGFsd2F5cyBkZWxpdmVyIGludGVycnVwdHMiLCB3
aGljaCBpc24ndCBob3cgdGhlIGhhcmR3YXJlIGJlaGF2ZXMuDQoNCj4gVGhlIGFzc2VydGlvbiB5
b3UndmUgcnVuIGludG8gaXMgc2F5aW5nICJzb21lIGluc3RydWN0aW9uIGNhdXNlZCB1cyB0byB0
YWtlIGFuIGludGVycnVwdCwgYnV0IGl0IHdhc24ndCBtYXJrZWQgdXAgdG8gaW5kaWNhdGUgdGhh
dCBpdCBtaWdodCBjYXVzZSBhIHNpZGUgZWZmZWN0Ii4gKFRoaXMgb25seSBtYXR0ZXJzIGluIGlj
b3VudCBtb2RlLCB3aGVyZSB3ZSBpbnNpc3QgdGhhdCB3ZSBuZXZlciBnZXQgdW5leHBlY3RlZCBz
aWRlZWZmZWN0cyBsaWtlIHRoaXMuKSBJZiB0aGUgZ3Vlc3Qgd3JpdGVzIHRvIHN0YXR1cy5QSUUg
dG8gdW5tYXNrIGludGVycnVwdHMgdGhhdCdzIHRoZSBraW5kIG9mIHRoaW5nIHRoYXQgd2lsbCBj
YXVzZSBhbiBpbnRlcnJ1cHQgdG8gYmUgdGFrZW4sIHNvIHRoZSBwcm9ibGVtIHJlYWxseSBoZXJl
IGlzIHRoYXQgdGhlIG5pb3MyIHRyYW5zbGF0ZS5jIGNvZGUgaGFzbid0IGluZGljYXRlZCB0aGF0
IHRoaXMgaW5zbiBjYW4gZG8gdGhpcy4NCg0KPiBUaGUgcmlnaHQgZml4IGhlcmUgd2lsbCBiZSB0
aGF0IHRhcmdldC9uaW9zMi90cmFuc2xhdGUuYyBuZWVkcyB0byBkbyB0aGlzOg0KPiAgIGlmICh0
Yl9jZmxhZ3Mocy0+YmFzZS50YikgJiBDRl9VU0VfSUNPVU5UKSB7DQo+ICAgICAgICBnZW5faW9f
c3RhcnQoKTsNCj4gICB9DQo+IGJlZm9yZSBnZW5lcmF0aW5nIGNvZGUgZm9yIGFuIGluc24gbGlr
ZSB0aGlzIG9uZSwgYW5kIHRoZW4NCj4gICBpZiAodGJfY2ZsYWdzKGRjLT5iYXNlLnRiKSAmIENG
X1VTRV9JQ09VTlQpIHsNCj4gICAgICAgIGdlbl9pb19lbmQoKTsNCj4gICB9DQo+IGFmdGVyIGl0
LiAoQ29tcGFyZSB0aGUgeHRlbnNhIHRhcmdldCB3aGljaCBkb2VzIGEgc2ltaWxhciBraW5kIG9m
IHRoaW5nIGZvciBpdHMgaW50ZXJydXB0IGhhbmRsaW5nLikgRm9yIHdyY3RsIHRvIFNUQVRVUyBp
dCBzaG91bGQgSSB0aGluayBhbHNvIGVuZCB0aGUgVEIsIGJlY2F1c2Ugd2Ugd2FudCB0byBhY3R1
YWxseSB0YWtlIGFueSBwZW5kaW5nIGludGVycnVwdCBub3csIG5vdCBpbiBhIGZldyBpbnN0cnVj
dGlvbnMgdGltZSB3aGVuIHRoZSBuZXh0IGJyYW5jaCBjb21lcyBhbG9uZy4NCg0KPiBUaGUgZmFj
dCB0aGF0IHRoZSBjdXJyZW50IG5pb3MyIGNvZGUgaGFzIG5vIGNhbGxzIHRvDQo+IGdlbl9pb19z
dGFydCgpIGluIGl0IGF0IGFsbCAoYXBhcnQgZnJvbSBvbmUgaW4gYm9pbGVycGxhdGUNCj4gY29k
ZSkgc3VnZ2VzdHMgdG8gbWUgdGhhdCB0aGlzIHRhcmdldCBpcyBzaW1wbHkgYnJva2VuIGZvciB1
c2Ugd2l0aCAtaWNvdW50IGF0IHRoZSBtb21lbnQuIFRoZXJlIG1heSB3ZWxsIGJlIG90aGVyIGJ1
Z3Mgb2YgYSBzaW1pbGFyIGtpbmQgd2hlcmUgcGFydGljdWxhciBpbnNucyB0aGF0IGNhdXNlIGlu
dGVycnVwdHMgb3IgdG91Y2ggZGV2aWNlcyAoYW55IGVxdWl2YWxlbnQgdG8gdGhlDQo+IHg4NiBp
bi9vdXQgaW5zbnMsIGZvciBpbnN0YW5jZSkgYWxzbyBuZWVkIHRvIGJlIG1hcmtlZCB1cCBhcyBJ
Ty4NCg0KDQpUaGFua3MgZm9yIHRoZSBkZXRhaWwsIHlvdSBhcmUgcmlnaHQsIHVuZGVyc3RhbmQg
dGhpcyBtb3JlLiBUaGFua3MNCg0KPiAoQmV5b25kIHRoYXQsIHRoZSB3YXkgdGhhdCBuaW9zMl9j
aGVja19pbnRlcnJ1cHRzKCkgd29ya3MgbG9va3Mgd2VpcmQ7IGluIGFuIGlkZWFsIHdvcmxkIGl0
IHdvdWxkIGJlIHJld3JpdHRlbiB0byB3b3JrIGluIGEgd2F5IHRoYXQncyBtb3JlIGluIGxpbmUg
d2l0aCBob3cgd2UnZCB3cml0ZSB0aGF0IGtpbmQgb2YgY29kZSB0b2RheS4gSXQgc2hvdWxkIGJl
IHBvc3NpYmxlIHRvIGdldCBpdCB0byB3b3JrIHdpdGggaWNvdW50IHdpdGhvdXQgZ2V0dGluZyBp
bnRvIHRoYXQga2luZCBvZiByZWZhY3RvcmluZy9yZXdvcmssDQo+IHRob3VnaC4pDQoNCj4gdGhh
bmtzDQo+IC0tIFBNTQ0K

