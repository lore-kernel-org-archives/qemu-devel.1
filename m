Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F4AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 02:25:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1DA206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 02:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="d+BU108y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1DA206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsdIp-0003ll-S7
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 22:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1jsdIC-0003KE-2i
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 22:25:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:27802)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1jsdI9-0008A2-3g
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 22:25:07 -0400
IronPort-SDR: sqgzz7hLMTwJxaLDHYQTiQVC/2F1MK07xdocBu9AkwkTCb/Kk1pgGWle2xoOYBT8FqJ6J4yc5w
 wU2JZvKEgtkg==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="165601537"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; d="scan'208";a="165601537"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 19:25:00 -0700
IronPort-SDR: kZO6iIwwXCimbsqWZxaBYdGx1pPArG/oNqT/YVk7G+MYtKLSyX3CtM2UXAbfb1ww9JYoNF4MAG
 tYXl1X5wmCxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; d="scan'208";a="483340817"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
 by fmsmga005.fm.intel.com with ESMTP; 06 Jul 2020 19:24:56 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Jul 2020 19:24:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 6 Jul 2020 19:24:55 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 6 Jul 2020 19:24:55 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Jul 2020 19:24:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kk2KRgdRq9QEQANqC8ULu7nzIwM08DqmbQJnAnQqNhI93j6HTGMjh3kqOz7fMXDHqXEHeOuCJ1kQpGgzOeiG4rzf/wvBFZjWZhSZ+9YQMAKQA3y+G5P4+kkK31gQOcFySCIlN+t9JqsDFBlo79vUbbKr2WgJFBS2/hB/moxKomgApUWWRa/B3WmVVsWs9SaZbpZuiOS7ulvuPlI+Op1fra3433ewjkvR8bdwIZsZHK2BcSaIYvdIWSpvA3yWPwHJdT2eManqBmetYolKtLJyKVXPANDi46bqGozCzidnhr15w41BxK5tADeKUhUf2S47+Ild3HuvI4rPPMxpwJ10+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udlu5QCeFNZZvT6JjCQQ7eHqggwvBbH9WjNVYrvQ09I=;
 b=Quz+jPm2tSY8oquJo2yyUwcS/qH98mA4hv+X4bbZGUzS9BmbxhSE4VzLKiUv5WWFzSLRq9Nz1AtAoGUT0XpQLuNDfXjszezFHC6oGZHRYUjeaLTJDGpB+FtJ5RIpQFv7gvxvXArmNF2ImyVt7BVvR6pSNoxUOeq1folEvPu+hyWqrRg/8SNw0UYUGsTd0w1cFOwHUUyQS+l0dusaPK/bA6sQAcDegEuOrXTv/RDnzonIy/cV2heACUOZZHf0sdeGl3mRwXdY53XAPag1F3wFCKE5uBXlGB9hfZi3mNbUi5ca0h984UhWluYkNzcGTfyCze5IpP+pjSIq0HYFOe5EZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udlu5QCeFNZZvT6JjCQQ7eHqggwvBbH9WjNVYrvQ09I=;
 b=d+BU108yisI2hm0eJ0hJhu8kgtTUptl9nJJu8mZxFnmRVDPsZJJEOpIvMX2BkCNMOKGXFDJxgjVHsKm88fUld3VP/4hrZEJmUuAhpXqRIdYE/yxAd4xSTvGxqhZbpAqt1bL61chgD3mDBpm6O9IXdmDhgssfuHnIjk5yZVXDtNI=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB4154.namprd11.prod.outlook.com (2603:10b6:5:191::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20; Tue, 7 Jul 2020 02:24:53 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 02:24:53 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [PATCH] intel_iommu: Use correct shift for 256 bits qi descriptor
Thread-Topic: [PATCH] intel_iommu: Use correct shift for 256 bits qi descriptor
Thread-Index: AQHWUdlAH/GJGHl7rESWYe6bQd2IY6j7DKeAgABbErA=
Date: Tue, 7 Jul 2020 02:24:53 +0000
Message-ID: <DM5PR11MB14359DAAD9C8B29F04EE1541C3660@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1593850035-35483-1-git-send-email-yi.l.liu@intel.com>
 <20200706205819.GC88106@xz-x1>
In-Reply-To: <20200706205819.GC88106@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2abc3d0d-e140-49f0-ded5-08d8221cef1f
x-ms-traffictypediagnostic: DM6PR11MB4154:
x-microsoft-antispam-prvs: <DM6PR11MB41547B8A0510AFA6BC2774BEC3660@DM6PR11MB4154.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DIRqceeCqBALM9NkLMgmKohsryaDUlxZrYkKwGpkLdoxPvDMZSfIMQbFAatuz2cc8nfRN0SaF5AziMXAaiyvHpL823lu79TWbge1S59llrayg7SF3mv31p035fPCJ1XxulnOcjg535IacLcxhVnekFs0qQE7y/PdM5NW+OAVDkM2HDRb0sImYEsLtkLpTpbUiuPZTIkUrOVaB2cR2IqURmW1jHIgumFFVGPMci1tCL/yWbMVtS+9/oFt2zDm8BM3vDOVQ96y+q4qTAtVKHng13q/a70ztM4H2ax1/xvUHCYG77C0fMlPsGlZ96B0I6aL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(4744005)(54906003)(2906002)(8936002)(33656002)(66946007)(316002)(64756008)(66476007)(66446008)(6916009)(66556008)(86362001)(76116006)(5660300002)(71200400001)(7696005)(4326008)(9686003)(478600001)(26005)(55016002)(186003)(52536014)(83380400001)(6506007)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: +xe7NgDMWJTaNFkFcYLXKkADvVe1i8ugAuBKTPgkDcLhpPedFZEVcNSUca8uYZVJEudt5LC8fJMAMvEqcIBUY0rI1Y1/G4LENYHsNsIzLL482we3x0Rv3ZlwDAaz+Q4w7XjsTG+Wo9+ojP8kEBwh1d1Zg0kYkVdXOjGcxy8WAjnNrprhMJpV1kC/gDGo+Lwo9fcTE5CVCGcrIMHhimgm7Mj2d+ueuZBroESIVeBZwEiwO40WE7eRaSY8ux7mkIJ7iW9q4I1mYOEXTUicbM76SNB1YjTANS0msz16SL+l5CsyEaJNn4nHzFV2bcHpcXVlsVi3EeMrUsAaiJF+2s2DrNwhWjSFimCpqnnmBusry7hNuRxKFxiLjUn0i7hZ2qouxqtAYVs5JA7Kv+qK57W+NJrivLGPPUBcRyVv+Ldco/xVWQuexCyIlh/GxzQ2BVfDbNAdIvQV9neBLEimPFvdNAt50q7ciPDu13s/yfGKbJ4J7gD0yRiN5ozaLcfu0cRN
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abc3d0d-e140-49f0-ded5-08d8221cef1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 02:24:53.8097 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vCFWycLYjfT/Qj5JYUsiid1MBcigRY1ONru23fpO/i0Z1LYNoU/gCTctxFQXaV8UTRIbsdF0h3MZkCeXfpKWlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4154
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.88; envelope-from=yi.l.liu@intel.com;
 helo=mga01.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 22:24:58
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1
bHkgNywgMjAyMCA0OjU4IEFNDQo+IA0KPiBPbiBTYXQsIEp1bCAwNCwgMjAyMCBhdCAwMTowNzox
NUFNIC0wNzAwLCBMaXUgWWkgTCB3cm90ZToNCj4gPiBJbiBjaGFwdGVyIDEwLjQuMjMgb2YgVlQt
ZCBzcGVjIDMuMCwgRGVzY3JpcHRvciBXaWR0aCBiaXQgd2FzDQo+ID4gaW50cm9kdWNlZCBpbiBW
VERfSVFBX1JFRy4gU2ZvdHdhcmUgY291bGQgc2V0IHRoaXMgYml0IHRvIHRlbGwgVlQtZA0KPiA+
IHRoZSBRSSBkZXNjcmlwdG9yIGZyb20gc29mdHdhcmUgd291bGQgYmUgMjU2IGJpdHMuIEFjY29y
ZGluZ2x5LCB0aGUNCj4gPiBWVERfSVFIX1FIX1NISUZUIHNob3VsZCBiZSA1IHdoZW4gZGVzY3Jp
cHRvciBzaXplIGlzIDI1NiBiaXRzLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBhZGRzIHRoZSBEVyBi
aXQgY2hlY2sgd2hlbiBkZWNpZGluZyB0aGUgc2hpZnQgdXNlZCB0bw0KPiA+IHVwZGF0ZSBWVERf
SVFIX1JFRy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IExpdSBZaSBMIDx5aS5sLmxpdUBpbnRl
bC5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTogUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPg0K
DQp0aGFua3MuDQoNClJlZ2FyZHMsDQpZaSBMaXUNCg==

