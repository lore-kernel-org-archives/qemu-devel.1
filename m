Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6BAC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0562420737
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="HTng3fbg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0562420737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOi5F-0006la-7a
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 09:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cristian.ancuta@intel.com>) id 1jOi4U-0005rE-Li
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cristian.ancuta@intel.com>) id 1jOi4S-0006nk-RE
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:27:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:64299)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cristian.ancuta@intel.com>)
 id 1jOi4R-0006cP-9x
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:27:16 -0400
IronPort-SDR: nrL9AxqjYUKZY982AOjV1t2JgVeoPRhpyXdJk5Pb5WPP/H9D1SD4ojpIVT7XKF5EgWEbESIPpU
 BI69Go/tqZvA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2020 06:27:11 -0700
IronPort-SDR: Gakplv0cQ1V9wO/zj0ibgZ/lius/bhw9x3DZyMQlZyT1KUTeYXnfh7uHvJGkjILXlMLMTf/yxp
 QavX2PtthYWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,387,1580803200"; d="scan'208";a="271725710"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga002.jf.intel.com with ESMTP; 15 Apr 2020 06:27:11 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Apr 2020 06:27:09 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 15 Apr 2020 06:27:06 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 15 Apr 2020 06:27:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 15 Apr 2020 06:27:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWtU/YxhVg8DrcX7Ksde4/fqn79Bpxm8TUpvghulAGHalTkB8r1phj8r0L0NgF6TlWlVgHGuEyLAxYnzMLUoSWEXY6DpONYjgc4FKixAQKnlHC0XhtMZAEg3BJmr7cLH1BPnhnZL8K8JS3kB+sg6blOtK5MOVObBi6TNfn/knIE3X8ut10d8afMdMQlyCSkQGKGNklQ00lBmAzw47f6agCQgGMc42I8bYOTdyza+2OfRNKCHhmWxehUt8JLIFqAKV8P9G+SdBL3ICmavQz90HRTHEff/hYeU6GKZSIFLm/gBSfHu9Xo4TdEarETryHuZaRywaW8G/CDxXREPWU0yzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjqYgPDLmyMXXZIpfN4M6QcqLmmlCRYpth4qhHYjpxE=;
 b=iFcrMkjnAa1AVfZWi57uXe54T27cg8BsRAMDk/eqboahTyGHmNHRgMgvQhZlK3dyz9SwtTqmygdZsp1jJ+6AZ5c/lT2fRguoABDsen+9FImhVhzgUbK8Suj6nLXcON7rXxlNReBcYsd0dcuDEO1PWk25kjUJKmVsbM/+Dd1S9qs7Yu4JHo6nSEvL2c40FC2vu7mm4cet+Z2S60xg5pUl1lMBBCun3WnZ/6p7PqgoSEM/1Dig77/gjmc6XHdlN0Pcx/4khLWdnyWyVjrUFeBHa4JJ/StWYohl7+oVMUExvFZETZGi3oTbHM+mF+mELymvWqg3TK7KqKBBkFjwSqPBFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjqYgPDLmyMXXZIpfN4M6QcqLmmlCRYpth4qhHYjpxE=;
 b=HTng3fbgJa1LrsPKCsHVPvpy7kw+XU8NLJB3Y5w2ltRE2tUEfaj7XLSAr+RsMqO2smfeTHt595zbVNM2ypRkekEnnQsnImrBdxbTXELL+lhOBw5q6UcSiVbY0h5ufUq5zIA4Jyh+CMs9H8hNi/lDnbR1FV2XZH/MnWpOGQqhRJQ=
Received: from DM6PR11MB3963.namprd11.prod.outlook.com (2603:10b6:5:19b::16)
 by DM6PR11MB3338.namprd11.prod.outlook.com (2603:10b6:5:9::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.28; Wed, 15 Apr 2020 13:27:05 +0000
Received: from DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::d46c:b97b:c9cc:c005]) by DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::d46c:b97b:c9cc:c005%7]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 13:27:05 +0000
From: "Ancuta, Cristian" <cristian.ancuta@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: RE: Qemu system mode emulation for heterogeneous SOC
Thread-Topic: Qemu system mode emulation for heterogeneous SOC
Thread-Index: AdYSoRX9rk1WIYP3T5WiHSq+TxQdbQAYSaEAAAX3ceA=
Date: Wed, 15 Apr 2020 13:27:05 +0000
Message-ID: <DM6PR11MB3963EDAD9124ABE0CFD97FE1F4DB0@DM6PR11MB3963.namprd11.prod.outlook.com>
References: <DM6PR11MB3963D92BC26FB661C7640D61F4DA0@DM6PR11MB3963.namprd11.prod.outlook.com>
 <CAFEAcA9sKn_ZKoN5OmQT2PnZ51xk_6O3+ZS7g3ZU4BwcK4Aytw@mail.gmail.com>
In-Reply-To: <CAFEAcA9sKn_ZKoN5OmQT2PnZ51xk_6O3+ZS7g3ZU4BwcK4Aytw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=cristian.ancuta@intel.com; 
x-originating-ip: [134.191.233.127]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a33588a7-5a20-4605-5f7a-08d7e140b0d2
x-ms-traffictypediagnostic: DM6PR11MB3338:
x-microsoft-antispam-prvs: <DM6PR11MB33387D501BC080E6D7707218F4DB0@DM6PR11MB3338.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR11MB3963.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(136003)(366004)(396003)(39860400002)(376002)(346002)(52536014)(64756008)(2906002)(186003)(8676002)(5660300002)(7696005)(316002)(6506007)(478600001)(66446008)(55016002)(26005)(53546011)(71200400001)(4326008)(76116006)(9686003)(66556008)(8936002)(81156014)(86362001)(66476007)(66946007)(33656002)(6916009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pyMkC8k524S80vNgYuI255AeBW3RZIFC4cA/4ooOZFqOwBXe4BsWLZdnnrj5jCoXtkijr94w7AjbWnaNL/o8gUBpW8EFSbsAFVS4R2TT9nKFix25vz3z/ZMW+QwYZ71LDrfBTYIrDA/YHmlsrzk2gFRCo0I4b1WQ4CWV90wHmBNmycWDs79zd2QiFPpWuzbhgG3tNSHIfa+TSd4Bu9VauqZisHYp92QKyB1VJsFEoB9OvmkMpPpN9amcVhjknGVCkGrFzIxuTtS+AZ29IoBweOGrsFCH47ygB5kpluoQoxEl3SrOtZ2SgUp5W0MsHs0Dn0L2x9b/lO5NujkfI77WzcyLwJ8/o+BADa2QXfhX5NzPk7pmfkKlgfFtJreHDXvBGFP7iQh6ir+0A3nzVVyHRC5lnfv1CEDVrBmSwXOfY9eyw2xfOM1WGCwov4W4oLfS
x-ms-exchange-antispam-messagedata: 913syueN9sdEHmLQgOYw0Ai2d/ftTdhje/B54pYL7pKDL4p253ht5ZQ8nrDyrMk7H4sykk3BRUBkHYdhWih6BxwZDjYR5ES6HOEv69jNIZLVKOBmCYfNn0iSRljri3qC7EDh3PgANVAGV1Mw+yTEyA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a33588a7-5a20-4605-5f7a-08d7e140b0d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 13:27:05.5578 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fvgly2H9SdhxvHKaHfAb1h3fH7bePJ6iLgZpae//qhsSzWNsSLoWKDOG2CIino7HclMCuAZPTJMpwaOIoSFNfA7RIH+IxNCtXyHi6XxcbtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3338
X-OriginatorOrg: intel.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.24
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

SGksIHRoYW5rcyBmb3IgdGFraW5nIHRoZSB0aW1lLg0KDQpTbyBqdXN0IHRvIG1ha2Ugc3VyZSBJ
IHVuZGVyc3RhbmQgdGhlIE1NSU8gc3R1ZmYgY29ycmVjdGx5LCB0aGVyZSdzIG5vIHVzZXIgbW9k
ZSBzdXBwb3J0IGJlY2F1c2UgdXNlciBtb2RlIGFwcGxpY2F0aW9ucyBhcmUgdGFsa2luZyB0byBo
YXJkd2FyZSB0aHJvdWdoIHRoZSBPUyBkcml2ZXJzIGFuZCBzeXNjYWxscyAod2hpY2ggd291bGQg
cnVuIGluIHN5c3RlbSBtb2RlKSBhbnl3YXk/DQoNCkFsc28sIGlzIHRoZXJlIGEgbXVsdGkgY29y
ZSBib2FyZCBpbiB0aGUgc291cmNlIHRyZWUgdGhhdCBJIGNvdWxkIGxvb2sgYXQgdG8gZ2V0IG1l
IHN0YXJ0ZWQgPyBBbmQgaWYgdGhlcmUgaXMsIHdoZW4gZW11bGF0aW5nIG11bHRpcGxlIGd1ZXN0
IGNvcmVzLCBkbyB0aGV5IGVhY2ggZ2V0IHRoZWlyIG93biB0aHJlYWRzLCBvciBhcmUgdGhleSBy
dW4gaW4gYSByb3VuZC1yb2JpbiBmYXNoaW9uIG9uIHRoZSBzYW1lIHFlbXUgdGhyZWFkPw0KDQpU
aGFua3MsDQpDcmlzdGlhbg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogUGV0
ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPiANClNlbnQ6IFdlZG5lc2RheSwg
QXByaWwgMTUsIDIwMjAgMTE6NDYgQU0NClRvOiBBbmN1dGEsIENyaXN0aWFuIDxjcmlzdGlhbi5h
bmN1dGFAaW50ZWwuY29tPg0KQ2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KU3ViamVjdDogUmU6
IFFlbXUgc3lzdGVtIG1vZGUgZW11bGF0aW9uIGZvciBoZXRlcm9nZW5lb3VzIFNPQw0KDQpPbiBU
dWUsIDE0IEFwciAyMDIwIGF0IDIzOjA4LCBBbmN1dGEsIENyaXN0aWFuIDxjcmlzdGlhbi5hbmN1
dGFAaW50ZWwuY29tPiB3cm90ZToNCj4gQXMgdGhlIHN1YmplY3Qgc2F5cywgSSB3YXMgd29uZGVy
aW5nIGlmIFFFTVUgZXhlY3V0aW9uIG1vZGVsIGFsbG93cyB0aGUgZnVsbCBzeXN0ZW0gZW11bGF0
aW9uIG9mIGEgY3VzdG9tIGhldGVyb2dlbmVvdXMgU29DIGFyY2hpdGVjdHVyZS4NCg0KT25seSBp
biB0aGUgdmVyeSBsaW1pdGVkIHNlbnNlICJ5b3UgY2FuIGhhdmUgdHdvIGRpZmZlcmVudCBDUFVz
IHdoaWNoIGFyZSBvZiB0aGUgc2FtZSBhcmNoaXRlY3R1cmUiLCBlZyBhbiBBcm0gTS1jbGFzcyBj
b3JlIGFuZCBhbiBBLWNsYXNzIGNvcmUuIFlvdSBjYW4ndCBoYXZlIHR3byBDUFVzIHdoaWNoIGFy
ZSBlbnRpcmVseSBkaWZmZXJlbnQgYXJjaGl0ZWN0dXJlcyAoZWcgUFBDIGFuZCBBcm0pLiBJbiBw
cmluY2lwbGUgdGhpcyB3b3VsZCBiZSBuaWNlIHRvIGJlIGFibGUgdG8gZG8sIGJ1dCBpbiBwcmFj
dGljZSBRRU1VJ3MgY3VycmVudCBzb3VyY2UgdHJlZSBhc3N1bWVzIHRoYXQgdmFyaW91cyBwcm9w
ZXJ0aWVzIG9mIHRoZSBndWVzdCBDUFUgYXJlIGNvbXBpbGUtdGltZSBmaXhlZCwgYW5kIG1ha2lu
ZyB0aG9zZSBhbGwgYmUgInRoaXMgaXMgYWN0dWFsbHkgYSB2YXJpYWJsZSBwcm9wZXJ0eSB0aGF0
IGFwcGxpZXMgb25seSB0byBzb21lIG9mIHRoZSBDUFVzIGJlaW5nIGVtdWxhdGVkIiByYXRoZXIg
dGhhbiBqdXN0ICJ0aGlzIGlzIHNldCBieSBhICNkZWZpbmUiIHdvdWxkIGJlIGEgbWFzc2l2ZSBl
ZmZvcnQuDQoNCj4gQXMgYSByZWxhdGVkIHF1ZXN0aW9uLCBpcyBNTUlPIHN1cHBvcnRlZCBpbiB1
c2VyIG1vZGUgZW11bGF0aW9uPw0KDQpOby4gTXVjaCBvZiB0aGUgaW5mcmFzdHJ1Y3R1cmUgYW5k
IGZyYW1ld29yayBmb3IgZGV2aWNlIGVtdWxhdGlvbiBpcyBvbmx5IGluIHRoZSAtc29mdG1tdSBi
aW5hcmllcy4gVGhlIHVzZXItbW9kZSBlbXVsYXRpb24gc3R1ZmYgaXMgaW50ZW5kZWQgZm9yIGVt
dWxhdGluZyBzaW5nbGUgTGludXggdXNlcnNwYWNlIHByb2Nlc3Nlcywgd2hpY2ggZG9uJ3QgaGF2
ZSBkaXJlY3QgYWNjZXNzIHRvIGRldmljZSBoYXJkd2FyZS4NCg0KdGhhbmtzDQotLSBQTU0NCg==

