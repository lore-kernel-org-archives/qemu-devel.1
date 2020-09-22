Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA3CC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:33:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E62E20BED
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="QFnbpiTE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E62E20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKefj-0006iQ-Jg
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 05:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei.rao@intel.com>) id 1kKeKm-0006wG-IV
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:11:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:38628)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei.rao@intel.com>) id 1kKeKj-0003xL-Ad
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:11:36 -0400
IronPort-SDR: 5O/sVbFTfZOlVOKZfFSVAr4irPZreSbLB9fgmbrqHWs8sfVmEt5caBerfQhqOaWJnK/aTxj2mB
 RSBuADgAU2jQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="148229598"
X-IronPort-AV: E=Sophos;i="5.77,290,1596524400"; d="scan'208";a="148229598"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2020 02:11:30 -0700
IronPort-SDR: dH60fJDWBTJXC0Ty3jXYGPxGlK6qberaRBKuZuK6o8WcbsJ2D0oBRRlpJjf64SYqBp0szF11Xd
 qSD6tkN+6VTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,290,1596524400"; d="scan'208";a="511129677"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga005.fm.intel.com with ESMTP; 22 Sep 2020 02:11:29 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Sep 2020 02:11:29 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Sep 2020 02:11:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 22 Sep 2020 02:11:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 22 Sep 2020 02:11:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbTlzPu1DYhE93pD6vFygaGOpC8pFQk/vqVbGWaTqdrjCy84Li1N5iufYhfWFHZ3VtjARpKYv+CsYGONZVVNaa2SSM3bkshxyd6MAb8lwyemuBPmV3f2RMUoVn/CpmHcfWu+n+JHPAhiv989pB9zOwLBtONJUsb2eSfMrIt5TfLwCSr9vwwXe7Ia2nUxyMo/iqTh5C/KSp/s7EygORVWUMoF4tUGbr6J8+M6/gpgWgx6fEUsn7gqD4GcvsZ9dDn+CbxL0BWLQudebrULMF30vbJbf8zwJgG7n8XNlCTpHUtZ1HBD+UElM51tmtlQMwYuN76UP6gOnCX+IzduZGxRsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUAZsE4cKNntqjjP66Cq6AFRvWIBtV1TKSSPtNQWBKE=;
 b=RqR/GF/sSjwWExl0A6C3x6d23A58lQDmSSUeLWco4BO3pvp8//66Sl3EZMyX4loUhriYrbwPwQ/RwU3wmyexLsL1NskM1DumBIi3hbprjuEw8qGgxUwo+g+x8SpiGS2c9NO2lAzQir/R+WDUAlzxkSvii3oSs77IvKjBOA/SWzkMVWHgpGaI5Q4gzIjGSCYjwJeI51yzOCFS3bo28+NcGHg2escUL+UMW4cb804saQJqzXTLPj8wytsPGbe1Z+oQiJPpUBe2+n9Vw3oDw4H+Ukrx29zf1zHQYP/eJy0X7Z6fpY8IJLjFMGH722/CJrKXs+Cb1PuB1O08q/LRzA3R+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUAZsE4cKNntqjjP66Cq6AFRvWIBtV1TKSSPtNQWBKE=;
 b=QFnbpiTE0+tXB/rMotEabu4yMdnVPXz+PHTVIMa+RDVMUjsdjlibXFsR9e9BOxJSwPVQIukKNSk1K5Hzf+tbRHRuwj7wq9xgU/Eqx3QhnR9dSklgVht1ZxtqincdXM94Cx4lmq5iIMZpaOi9Sp5Ddwf4G9yMifY+9ew0Gk75EtI=
Received: from SN6PR11MB3103.namprd11.prod.outlook.com (2603:10b6:805:d7::13)
 by SN6PR11MB3293.namprd11.prod.outlook.com (2603:10b6:805:be::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Tue, 22 Sep
 2020 09:11:22 +0000
Received: from SN6PR11MB3103.namprd11.prod.outlook.com
 ([fe80::dd10:fbd6:99e9:52f4]) by SN6PR11MB3103.namprd11.prod.outlook.com
 ([fe80::dd10:fbd6:99e9:52f4%4]) with mapi id 15.20.3391.024; Tue, 22 Sep 2020
 09:11:22 +0000
From: "Rao, Lei" <lei.rao@intel.com>
To: Li Zhijian <lizhijian@cn.fujitsu.com>, "Zhang, Chen"
 <chen.zhang@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "quintela@redhat.com" <quintela@redhat.com>, "dgilbert@redhat.com"
 <dgilbert@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: RE: [PATCH 2/3] Reduce the time of checkpoint for COLO
Thread-Topic: [PATCH 2/3] Reduce the time of checkpoint for COLO
Thread-Index: AQHWjjTrIz179/z8gUaNCw2fvTz9Iql0PvqAgAAkeOA=
Date: Tue, 22 Sep 2020 09:11:22 +0000
Message-ID: <SN6PR11MB31037B5FD4C80FEFCAFCA335FD3B0@SN6PR11MB3103.namprd11.prod.outlook.com>
References: <1600485023-263643-1-git-send-email-lei.rao@intel.com>
 <1600485023-263643-3-git-send-email-lei.rao@intel.com>
 <81e419c4-e844-aa01-c762-175ea547e93e@cn.fujitsu.com>
In-Reply-To: <81e419c4-e844-aa01-c762-175ea547e93e@cn.fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: cn.fujitsu.com; dkim=none (message not signed)
 header.d=none;cn.fujitsu.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5551716d-67c4-4a68-5f16-08d85ed77985
x-ms-traffictypediagnostic: SN6PR11MB3293:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3293CD9D7C34B840959A8D21FD3B0@SN6PR11MB3293.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t3Fh5N6gDFtAgzbO2JPkaPAMElzBaFdvimhOyMLtBMMeG0UvOdgYJAws/h50tf/49q43xX6XjKnbO+/Xf4PhlXpXjmV/1yBA5HuRmbzompPCKfbpcUI2oyMOXF1YUMeG0j5mnvSiU/Nu4r0eNpOJ2nb7nnJanJxZ35oZSA2y8fl+ctSvLyRNh6bTeDrIx+S1xPl8xaY+G+kQPf3DevtrqgzIvldmhksnEcdaew3QfKsvODnxN2TSO6RDWvoWMSj7hwM/bx65/3BP/gdnRW4hktT3uqF9bxo6Zigs6WypknNzg7No5x5lRhiLkn7GqaXqMYcH91/EkFQjRU9YjHo4Cg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR11MB3103.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(33656002)(110136005)(66946007)(86362001)(4326008)(478600001)(5660300002)(8676002)(9686003)(83380400001)(316002)(7696005)(55016002)(76116006)(66446008)(26005)(52536014)(53546011)(186003)(2906002)(8936002)(66556008)(66476007)(6506007)(71200400001)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: iYIoenxSfOGzXWCDrUOoCWNsPGrjaDXH/+OQtt8Xs3KJllJhakIdDIMn8mRc2TyOtOTl2R+c6VKBUWRcuPxMBUX0f8mr0/iP38VFXp7xZV3ANyKkXAzHZ9PVI+2HYq2wc6ShYKJHc0WLzKRZgyRInHU3v13K1Po87rkISHHJilU6I3H7QaQrc3m3P630Xh6AGmb0PLAf6nOG3ASqj7YVInblH10kvLwm8yu+AHCs2CjA0dUVLhIR2vRTT6A7EH4rjTj3IeYR7ieUaSEqxudn4xmOfosVkXmDAeE6Tb9zCj/clvrTZqBcf19ZYFhieCeEkd7ocbW8MFtomeoLndWtA1u2lVt4Q53Hqu5gxg8jy0oY6BkKlqbRhEfNBswGaAvZTX6isGMaO3ZKgLrBfEkDdRjwRvFGGxliEJZikLAfrL+8oHaLGGNLYHfthZzjbNGwdRj0Mzt8Releyykp+JuBZAgKXH7PBN3tpzTeFcOZdGVRw2RXVXNVcHp3+NG764rlX55dk5rNSY38WAjpT+eVNmyCQ5MBrrTF8+1A6wSyNX6DJH/RDr3PcI0LPxh7Oh2j3nINvBLQ0wj61nef3Z7JF15hlUIMz1v3brNNGrUcq0QyoSpb1TM7os6Reb2LGT53b70SpL78oFmTqedgqgxijQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3103.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5551716d-67c4-4a68-5f16-08d85ed77985
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2020 09:11:22.1898 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DHw8HSjF1Y97krJYesvMYKC9b7A/+6Pn1BBnj4mLwmiwd71x8WgLYjxH84uagRo2fWhoxWD6XkH/OcGXJUR5pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3293
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20; envelope-from=lei.rao@intel.com;
 helo=mga02.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 05:11:30
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

R290IGl0Lg0KSXQgbG9va3MgbW9yZSByZWFzb25hYmxlLiBXaWxsIGJlIGNoYW5nZWQgaW4gVjIu
DQoNClRoYW5rcywNCkxlaS4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExp
IFpoaWppYW4gPGxpemhpamlhbkBjbi5mdWppdHN1LmNvbT4gDQpTZW50OiBUdWVzZGF5LCBTZXB0
ZW1iZXIgMjIsIDIwMjAgMjo1OCBQTQ0KVG86IFJhbywgTGVpIDxsZWkucmFvQGludGVsLmNvbT47
IFpoYW5nLCBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT47IGphc293YW5nQHJlZGhhdC5jb207
IHF1aW50ZWxhQHJlZGhhdC5jb207IGRnaWxiZXJ0QHJlZGhhdC5jb207IHBib256aW5pQHJlZGhh
dC5jb20NCkNjOiBxZW11LWRldmVsQG5vbmdudS5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8z
XSBSZWR1Y2UgdGhlIHRpbWUgb2YgY2hlY2twb2ludCBmb3IgQ09MTw0KDQoNCg0KT24gOS8xOS8y
MCAxMToxMCBBTSwgbGVpcmFvIHdyb3RlOg0KPiB3ZSBzaG91bGQgc2V0IHJhbV9idWxrX3N0YWdl
IHRvIGZhbHNlIGFmdGVyIHJhbV9zdGF0ZV9pbml0LCBvdGhlcndpc2UgDQo+IHRoZSBiaXRtYXAg
d2lsbCBiZSB1bnVzZWQgaW4gbWlncmF0aW9uX2JpdG1hcF9maW5kX2RpcnR5Lg0KPiBhbGwgcGFn
ZXMgaW4gcmFtIGNhY2hlIHdpbGwgYmUgZmx1c2hlZCB0byB0aGUgcmFtIG9mIHNlY29uZGFyeSBn
dWVzdCANCj4gZm9yIGVhY2ggY2hlY2twb2ludC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogbGVpcmFv
IDxsZWkucmFvQGludGVsLmNvbT4NCj4gLS0tDQo+ICAgbWlncmF0aW9uL3JhbS5jIHwgMTIgKysr
KysrKysrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4NCj4gZGlm
ZiAtLWdpdCBhL21pZ3JhdGlvbi9yYW0uYyBiL21pZ3JhdGlvbi9yYW0uYyBpbmRleCA3NmQ0ZmVl
Li42YTJiNmMxIA0KPiAxMDA2NDQNCj4gLS0tIGEvbWlncmF0aW9uL3JhbS5jDQo+ICsrKyBiL21p
Z3JhdGlvbi9yYW0uYw0KPiBAQCAtMzAxOSw2ICszMDE5LDE3IEBAIHN0YXRpYyB2b2lkIGRlY29t
cHJlc3NfZGF0YV93aXRoX211bHRpX3RocmVhZHMoUUVNVUZpbGUgKmYsDQo+ICAgfQ0KPiAgIA0K
PiAgIC8qDQo+ICsgKiB3ZSBtdXN0IHNldCByYW1fYnVsa19zdGFnZSB0byBmYXNsZSwgb3RoZXJ3
aXNlIGluDQo+ICsgKiBtaWdhdGlvbl9iaXRtYXBfZmluZF9kaXJ0eSB0aGUgYml0bWFwIHdpbGwg
YmUgdW51c2VkIGFuZA0KPiArICogYWxsIHRoZSBwYWdlcyBpbiByYW0gY2FjaGUgd2lsIGJlIGZs
dXNoZWQgdG8gdGhlIHJhbSBvZg0KPiArICogc2Vjb25kYXJ5IFZNLg0KPiArICovDQo+ICtzdGF0
aWMgdm9pZCBjb2xvX3NldF9yYW1fc3RhdGUoUkFNU3RhdGUgKnJzcCkNCnRoaXMgZnVuY3Rpb24g
bmFtZSBpcyB0b28gZ2VuZXJhbCwgaG93IGFib3V0DQoNCmNvbG9faW5pdF9yYW1fc3RhdGUocmFt
X3N0YXRlKQ0Kew0KICAgICByYW1fc3RhdGVfaW5pdCgmcmFtX3N0YXRlKTsNCiAgICAgcmFtX3N0
YXRlLT5yYW1fYnVsa19zdGFnZSA9IGZhbHNlOw0KfQ0KDQpUaGFua3MNClpoaWppYW4NCg0KPiAr
ew0KPiArICAgIHJzcC0+cmFtX2J1bGtfc3RhZ2UgPSBmYWxzZTsNCj4gK30NCj4gKw0KPiArLyoN
Cj4gICAgKiBjb2xvIGNhY2hlOiB0aGlzIGlzIGZvciBzZWNvbmRhcnkgVk0sIHdlIGNhY2hlIHRo
ZSB3aG9sZQ0KPiAgICAqIG1lbW9yeSBvZiB0aGUgc2Vjb25kYXJ5IFZNLCBpdCBpcyBuZWVkIHRv
IGhvbGQgdGhlIGdsb2JhbCBsb2NrDQo+ICAgICogdG8gY2FsbCB0aGlzIGhlbHBlci4NCj4gQEAg
LTMwNjIsNiArMzA3Myw3IEBAIGludCBjb2xvX2luaXRfcmFtX2NhY2hlKHZvaWQpDQo+ICAgICAg
IH0NCj4gICANCj4gICAgICAgcmFtX3N0YXRlX2luaXQoJnJhbV9zdGF0ZSk7DQo+ICsgICAgY29s
b19zZXRfcmFtX3N0YXRlKHJhbV9zdGF0ZSk7DQo+ICAgICAgIHJldHVybiAwOw0KPiAgIH0NCj4g
ICANCg0KDQoNCg==

