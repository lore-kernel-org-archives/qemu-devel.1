Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62F7C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 13:25:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 909F52073E
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 13:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="TFOKqFMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909F52073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js4eO-0006eC-Qh
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 09:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1js4da-00061z-JU; Sun, 05 Jul 2020 09:24:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:52247)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1js4dY-0001EL-HU; Sun, 05 Jul 2020 09:24:54 -0400
IronPort-SDR: DQJAx/xKAstKjtZpAqiDpBkPHkdb8R0lD6XLvmHBCfGWDbKldrcBu2p/iGbODBiqeI5zVmhxEv
 D0GISKBMxxBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9672"; a="126908375"
X-IronPort-AV: E=Sophos;i="5.75,316,1589266800"; d="scan'208";a="126908375"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2020 06:24:50 -0700
IronPort-SDR: mcA6JloUsw3JLLBogPzaZLpnWB4/ENVKX3A1i6Wt6edmA2/7wuOUYLOKm+43ipW0eQatRhbDND
 0d9sXUePtFpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,316,1589266800"; d="scan'208";a="267717258"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga008.fm.intel.com with ESMTP; 05 Jul 2020 06:24:50 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 5 Jul 2020 06:24:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 5 Jul 2020 06:24:49 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 5 Jul 2020 06:24:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Sun, 5 Jul 2020 06:24:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6+kd/rEJjMMzcUx8W6gjq2TSqTuAKb92c5NqIdS637qVn8ItedRRCC/NoruRXnQdjet484MwilYtbGKP+YhaZN8Xy4tAozTjcLLvNWlz3t/Ef6fE5qTN9X8TugkN+xaltH6BstAbvXt1HyktsljCy8/R16x7pD9Q/odrThxoprPBAlqugBwh/MszSssLfaxz8DCybhFs0Z5wyGyEYjHK8R13WnUSX+5hYI4SE7vYMR/ug1cdiq9Mc/Ofap8NncxuTOzIS7e19wvSVS0RPBlBMJ/BqluRRO4hJqJA4wGNHdyYoKURtMnnclSmgdUkeDRqFx6L5YkPYWaRFFG39HSIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AyjrwO2un2IE/mXYiLklZvUkjUHqdxwkIAemL1d4NQ=;
 b=F4f1XWa5+n+41/tPWQGrZxQiOPalZrQ0+9UUHkIyjGV6Co3JaaIWWq/Cy6ect2yKxMpcfShnQ0J2DM6oXwa5yxiiF3AS/tT2ma32gc6PNjPYDNLVNg0EgH3IsVba6GkBVSwO5ZAbVhdlXKopaWhg61a5bRQxkGS5ZLXDBTxI3c8hQyaIU510VpvnEScDMlHxZk3ZrlDehndK0R4qmcGOgg8LB2b2iy+/qVzBxykgJWLwXWYkgqHbI2wYWTTSONaThBf/Y2Cmlb+anLoAwKofeKQ35KmRY1FnNf25glW74C+fxrgjVoDAFTUTPZNUcrsZHtdrWuPUcJSRRZDJAcEcWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AyjrwO2un2IE/mXYiLklZvUkjUHqdxwkIAemL1d4NQ=;
 b=TFOKqFMRqdf82IcJJW7Ac8iViFQBHP+NiUXGWlTBMvAQ3nAnQoHOffcLpzJmw+qprmGefk8Y72kbF0mXidaJJRbWSGoKmn5DVxl+vNoF1TvARWtYA9VL8CdPpUhPAY1nq/tId92OE2jL76aMf74Oi30nV+fNX29kfDYOMt+G7VI=
Received: from DM5PR11MB1833.namprd11.prod.outlook.com (2603:10b6:3:110::12)
 by DM6PR11MB4345.namprd11.prod.outlook.com (2603:10b6:5:202::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Sun, 5 Jul
 2020 13:24:42 +0000
Received: from DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::4ce3:6680:7257:7c74]) by DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::4ce3:6680:7257:7c74%6]) with mapi id 15.20.3153.029; Sun, 5 Jul 2020
 13:24:42 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 3/3] target/nios2: Use gen_io_start around wrctl
 instruction
Thread-Topic: [PATCH 3/3] target/nios2: Use gen_io_start around wrctl
 instruction
Thread-Index: AQHWTe3BOsAD/7AE8EK8jau5tLLWZaj0qFAAgARZioA=
Date: Sun, 5 Jul 2020 13:24:42 +0000
Message-ID: <DM5PR11MB1833EE863D9DCE9AE701478B8D680@DM5PR11MB1833.namprd11.prod.outlook.com>
References: <20200629160535.3910-1-wentong.wu@intel.com>
 <20200629160535.3910-3-wentong.wu@intel.com>
 <3260735e-05ab-2d42-f7e4-914ad804f543@linaro.org>
In-Reply-To: <3260735e-05ab-2d42-f7e4-914ad804f543@linaro.org>
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
x-ms-office365-filtering-correlation-id: 386bbb73-7b9a-4699-fa88-08d820e6c6ec
x-ms-traffictypediagnostic: DM6PR11MB4345:
x-microsoft-antispam-prvs: <DM6PR11MB4345D5A15613D88F0F5F2D4D8D680@DM6PR11MB4345.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 045584D28C
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0c9QD5CfcUJ8ydGUdJnYT+Bl6pQdcWTORUIL4+Y6Ghb7D3dy0qLOYgaOzC6RtBE2gYgL1v+0zD7ofsuIJiw3BLnT/m2vNDumGSoifzxWVywvGEbmaLA5xVrn/jCxllA3QbljsP0wAWLr25+4v3IJQ8GMIj7JWzfN1H5SH8e55LvEOPDRWwzS1oYxxxLNFAAoakABpW2CmIy27AdAgSq7OmmgAL95cB0bqNhOmLk6d421Tx0GldyTnXNKVy530uFE67naHia+XAgj/GGAj6AlfSSdTraW9irdQp8NyHTQcbpc1Fq2fLw6EWkqbRhDPXdhKq9dOmbx1M1cK0MOi9fy0Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1833.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(54906003)(316002)(110136005)(8936002)(8676002)(9686003)(4326008)(186003)(66946007)(66556008)(53546011)(6506007)(55016002)(7696005)(66446008)(66476007)(64756008)(76116006)(2906002)(26005)(71200400001)(86362001)(52536014)(33656002)(5660300002)(83380400001)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: PNeri9JjhzJSAlkg9Y/+aLHcMOSoPi0UL5c67lJa9pkTCHpqLmukVAIpoyPXR/6960Q/gxGn0VwERWAg0DSY5b+CfE5u0RPRbUsIVkWniy7XGrktri7BykzjyzBZh5aYw8TH1NBkrYawy0iLOi2jTgQYunDMRnKbZq57Nk7enOJN0n54WihucnOdnOsLxVTsK463/3CnnsSSH5e/qeOyZTZP29S4Skdf3ofDplCaZ7MXevsnNZ/JaWAqWJ6pkuFpCcvp/88chJAobqZSAnUId42S3kdEH989lnxql8bgOrK2DVMV5L1Y4f257pbFHagR4kXqp3SdtFjnJwYw8U59sCQQUup61QqIVFgCqicFvPGcMOLc6sVfmw5ww2KxY/UaY9//uIB2M/9MgUib4IEvf0e2qoE9CgS4o/JNWhlGPxygtjCUXp8R+s0voI9RGnlrQX9AJySDGvMiI3B4nw7u+k7HN5N6k5kcRhwESt45yC8Nuy05oABu51K+q8ns6Qkf
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1833.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 386bbb73-7b9a-4699-fa88-08d820e6c6ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2020 13:24:42.3372 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AnArs4/xzp6V0CoY5aryUejxedpFRUjqSmICQYqsS8S84Ddg7ZTbgra4K3R10JGgDZgn9eUdN60GJizbQ3jQVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4345
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136; envelope-from=wentong.wu@intel.com;
 helo=mga12.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 09:24:50
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "marex@denx.de" <marex@denx.de>, "crwulff@gmail.com" <crwulff@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Q29ycmVjdCB0aGUgZm9ybWF0DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+IA0KPiBT
ZW50OiBGcmlkYXksIEp1bHkgMywgMjAyMCAyOjU0IEFNDQo+IFRvOiBXdSwgV2VudG9uZyA8d2Vu
dG9uZy53dUBpbnRlbC5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHFlbXUtdHJp
dmlhbEBub25nbnUub3JnOyBtYXJleEBkZW54LmRlOyBjcnd1bGZmQGdtYWlsLmNvbTsgcGV0ZXIu
bWF5ZGVsbEBsaW5hcm8ub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy8zXSB0YXJnZXQvbmlv
czI6IFVzZSBnZW5faW9fc3RhcnQgYXJvdW5kIHdyY3RsIGluc3RydWN0aW9uDQo+IA0KPiBPbiA2
LzI5LzIwIDk6MDUgQU0sIFdlbnRvbmcgV3Ugd3JvdGU6DQo+ID4gd3JjdGwgaW5zdHJ1Y3Rpb24g
b24gbmlvczIgdGFyZ2V0IHdpbGwgY2F1c2UgY2hlY2tpbmcgY3B1IGludGVycnVwdCANCj4gPiBi
dXQgdGNnX2hhbmRsZV9pbnRlcnJ1cHQoKSB3aWxsIGNhbGwgY3B1X2Fib3J0KCkgaWYgdGhlIENQ
VSBnZXRzIGFuIA0KPiA+IGludGVycnVwdCB3aGlsZSBpdCdzIG5vdCBpbiAnY2FuIGRvIElPJw0K
PiA+IHN0YXRlLCBzbyBhZGQgZ2VuX2lvX3N0YXJ0IGFyb3VuZCB3cmN0bCBpbnN0cnVjdGlvbi4g
QWxzbyBhdCB0aGUgc2FtZSANCj4gPiB0aW1lLCBlbmQgdGhlIG9uZ2luZyBUQiB3aXRoIERJU0FT
X1VQREFURS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZW50b25nIFd1IDx3ZW50b25nLnd1
QGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgdGFyZ2V0L25pb3MyL3RyYW5zbGF0ZS5jIHwgNSAr
KysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlm
ZiAtLWdpdCBhL3RhcmdldC9uaW9zMi90cmFuc2xhdGUuYyBiL3RhcmdldC9uaW9zMi90cmFuc2xh
dGUuYyBpbmRleCANCj4gPiA4M2MxMGViMi4uNTEzNDdhZGEgMTAwNjQ0DQo+ID4gLS0tIGEvdGFy
Z2V0L25pb3MyL3RyYW5zbGF0ZS5jDQo+ID4gKysrIGIvdGFyZ2V0L25pb3MyL3RyYW5zbGF0ZS5j
DQo+ID4gQEAgLTMyLDYgKzMyLDcgQEANCj4gPiAgI2luY2x1ZGUgImV4ZWMvY3B1X2xkc3QuaCIN
Cj4gPiAgI2luY2x1ZGUgImV4ZWMvdHJhbnNsYXRvci5oIg0KPiA+ICAjaW5jbHVkZSAicWVtdS9x
ZW11LXByaW50LmgiDQo+ID4gKyNpbmNsdWRlICJleGVjL2dlbi1pY291bnQuaCINCj4gPiAgDQo+
ID4gIC8qIGlzX2ptcCBmaWVsZCB2YWx1ZXMgKi8NCj4gPiAgI2RlZmluZSBESVNBU19KVU1QICAg
IERJU0FTX1RBUkdFVF8wIC8qIG9ubHkgcGMgd2FzIG1vZGlmaWVkIGR5bmFtaWNhbGx5ICovDQo+
ID4gQEAgLTUxOCw3ICs1MTksMTEgQEAgc3RhdGljIHZvaWQgd3JjdGwoRGlzYXNDb250ZXh0ICpk
YywgdWludDMyX3QgY29kZSwgdWludDMyX3QgZmxhZ3MpDQo+ID4gICAgICAvKiBJZiBpbnRlcnJ1
cHRzIHdlcmUgZW5hYmxlZCB1c2luZyBXUkNUTCwgdHJpZ2dlciB0aGVtLiAqLyAgI2lmIA0KPiA+
ICFkZWZpbmVkKENPTkZJR19VU0VSX09OTFkpDQo+ID4gICAgICBpZiAoKGluc3RyLmltbTUgKyBD
Ul9CQVNFKSA9PSBDUl9TVEFUVVMpIHsNCj4gPiArICAgICAgICBpZiAodGJfY2ZsYWdzKGRjLT50
YikgJiBDRl9VU0VfSUNPVU5UKSB7DQo+ID4gKyAgICAgICAgICAgIGdlbl9pb19zdGFydCgpOw0K
PiA+ICsgICAgICAgIH0NCj4gPiAgICAgICAgICBnZW5faGVscGVyX2NoZWNrX2ludGVycnVwdHMo
ZGMtPmNwdV9lbnYpOw0KPiA+ICsgICAgICAgIGRjLT5pc19qbXAgPSBESVNBU19VUERBVEU7DQo+
ID4gICAgICB9DQo+ID4gICNlbmRpZg0KPiANCj4gVGhpcyBpc24ndCByaWdodC4gIE5vdCBzbyBt
dWNoIHRoZSBnZW5faW9fc3RhcnQgcG9ydGlvbiwgYnV0IHRoZSBlbnRpcmUgZXhpc3RlbmNlIG9m
IGhlbHBlcl9jaGVja19pbnRlcnJ1cHQuDQo+IA0KPiBUaGUgY29ycmVjdCB3YXkgdG8gYWNrbm93
bGVkZ2UgaW50ZXJydXB0cyBhZnRlciBjaGFuZ2luZyBhbiBpbnRlcnJ1cHQgbWFzayBiaXQgaXMg
dG8gZXhpdCB0aGUgVEIgYmFjayB0byB0aGUgY3B1IG1haW4gbG9vcC4NCj4gV2hpY2ggeW91IGFy
ZSBkb2luZyBoZXJlIHdpdGggRElTQVNfVVBEQVRFLCBzbyB0aGF0IHBhcnQgaXMgZmluZS4gIChB
bHRob3VnaCB5b3UgY291bGQgbWVyZ2UgdGhhdCBpbnRvIHRoZSBzd2l0Y2ggc3RhdGVtZW50IGFi
b3ZlLikNCj4gDQo+IExvb2tpbmcgYXQgbmlvc19waWNfY3B1X2hhbmRsZXIsIHRoZXJlIGFyZSB0
d28gb3RoZXIgYnVnczoNCj4gDQo+IDEpIEdldCByaWQgb2YgZW52LT5pcnFfcGVuZGluZyBhbmQg
dXNlIGNwdV9pbnRlcnJ1cHQvY3B1X3Jlc2V0X2ludGVycnVwdCBpbnN0ZWFkLg0KDQpJTUhPLCB3
ZSBuZWVkIGVudi0+aXJxX3BlbmRpbmcsIGJlY2F1c2UgaWYgKChlbnYtPnJlZ3NbQ1JfU1RBVFVT
XSAmIENSX1NUQVRVU19QSUUpID09IEZhbHNlKSwgaXQgY2FuIGluZGljYXRlIHRoZXJlIGlzIGlu
dGVycnVwdCBwZW5kaW5nLCB3ZSBjYW4gZXhpdCB0byBtYWluIGxvb3AgdG8gaGFuZGxlIHRoZSBp
bnRlcnJ1cHQgYXQgb25jZSBpZiBndWVzdCBjb2RlIGVuYWJsZSBpcnEgbGF0ZXIuDQoNCj4gMikg
RG8gbm90IGNoZWNrIGVudi0+cmVnc1tDUl9TVEFUVVNdICYgQ1JfU1RBVFVTX1BJRS4gIFRoYXQg
dmFyaWFibGUgZG9lcyBub3QgYmVsb25nIHRvIHRoZSBwaWMgYW5kIHNob3VsZCBub3QgYmUgY2hl
Y2tlZCB0aGVyZS4gIFRoZSBjaGVjayBiZWxvbmdzIGluIG5pb3MyX2NwdV9leGVjX2ludGVycnVw
dCwgYW5kIGlzIGluIGZhY3QgYWxyZWFkeSB0aGVyZS4NCg0KQnV0IHRoYXQgd2lsbCBjYXVzZSBz
b21lIGFzc2VydCBoYXBwZW4gaWYgZGV2aWNlIHRyaWdnZXIgaXJxIHdpdGggZW52LT5yZWdzW0NS
X1NUQVRVU10gJiBDUl9TVEFUVVNfUElFID0gRmFsc2UNCg0KQlINCg==

