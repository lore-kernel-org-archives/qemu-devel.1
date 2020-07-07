Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B5CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 02:43:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5489A206E6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 02:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Cv+PuIgM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5489A206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsdZV-0003nM-L1
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 22:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jsdXv-0001mM-Iz; Mon, 06 Jul 2020 22:41:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:15082)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jsdXs-000249-Ey; Mon, 06 Jul 2020 22:41:23 -0400
IronPort-SDR: UHbtvJ0qbccRRj/2Tw8ll4QINYUR1d6iYIKFpforvxle0HMgegrVB8z4S9omJCbSCtgR6gqXCU
 t3AWzC/CWPsg==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="134995470"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; d="scan'208";a="134995470"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 19:41:15 -0700
IronPort-SDR: fS79KXjNzWU3qWo1r0fcgD25vVqBGdnguwvbGJJOXPg+Die5nJ6aQ0TD6DHrwOuhh6LKcdijJb
 sr75/q+xogag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; d="scan'208";a="315368702"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga002.fm.intel.com with ESMTP; 06 Jul 2020 19:41:15 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Jul 2020 19:41:15 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 6 Jul 2020 19:41:14 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 6 Jul 2020 19:41:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 6 Jul 2020 19:41:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBl8AeSrl1+Wx0/cLc/pyI53k0TW10bNaGQ99aPlJeXgmA/clwgnU263ClpH4EOj72MLlkDBidEAIUdKg08KWGVAl4O/l+3u8FToZCSB9dbMxmlKu6bljFtsXX81Gm1w2wPvbtM9aueNsbfjl3Qs9777bu0NMNXwZY0+iCMXxZVYxafrxe0UgNeUXlTz6IKagavW5G1vqlLiGj/bj3eSvJGVGmr0/AlqOxKc+7yXV56J3jpr3efJvhzAOnxJf2GEsmJaxQrMVVdjQ+humaLa/33kotCyw5ukA3imno5tkaYSCV0YzFyqs/myao6Fb0Jf1aPlqNYImW73LILuOKoArw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qx/sjgCvhaFMdmo1yPE0kQpMUtm1EodS7+o3JmbR6+Q=;
 b=LuedeW0tr9oG8ehodn3eoFcyB7KE3IjRAz+n+xjprXNEfiCJxvWsJiNZht8JXqaPNf0wd9aWLqyC1DiPvvUW/mDk/QpPyuMrIEg5NtJkxQuVoDjUyKWpvmc9GSnyj73aLXqr+f56p46FU3o1kdT9V4PArpFPO74D13dcLbBOny9vN5/CPdzKcAyUSLFp+dk+jEhG16TqTxKjIx5NvjygWlPmbUPzqHTxrWOZ0QHeGkjecIYT7pfDonkSZJVcAydKl0h0aftuNVbtYW8gm0HEPBIrmqy3QsmRSLmYorZ2Oa16Yeohf1teGGFhC/dQyp2qrqRJ/xBL20Mwetc6hJ4/mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qx/sjgCvhaFMdmo1yPE0kQpMUtm1EodS7+o3JmbR6+Q=;
 b=Cv+PuIgMmDrBnDDaFjOrT39Nih+wQz3//z69ZgnBID36SiwNorJPJMX22j2N7mQXP4dDgFQrhFOk5Kc+wqkVDhoPOMjrrLwmNi0/yi9YM8Nijo+qASH14yKwPVNpaoMmazp8fRv4Eec/a+t3agPWkRQnEa4Y3EEu1C3guf7iaYc=
Received: from DM5PR11MB1833.namprd11.prod.outlook.com (2603:10b6:3:110::12)
 by DM6PR11MB2684.namprd11.prod.outlook.com (2603:10b6:5:c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Tue, 7 Jul
 2020 02:41:12 +0000
Received: from DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::4ce3:6680:7257:7c74]) by DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::4ce3:6680:7257:7c74%6]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 02:41:12 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
Subject: RE: [PATCH 3/3] target/nios2: Use gen_io_start around wrctl
 instruction
Thread-Topic: [PATCH 3/3] target/nios2: Use gen_io_start around wrctl
 instruction
Thread-Index: AQHWTe3BOsAD/7AE8EK8jau5tLLWZaj5QmYAgAIvvuA=
Date: Tue, 7 Jul 2020 02:41:12 +0000
Message-ID: <DM5PR11MB1833059649F476F4538B15598D660@DM5PR11MB1833.namprd11.prod.outlook.com>
References: <20200629160535.3910-1-wentong.wu@intel.com>
 <20200629160535.3910-3-wentong.wu@intel.com>
 <CAFEAcA-1eFyMNkqg-c3dTZv7HjVRUPbwcbZht5HV1mwgzrMcBQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-1eFyMNkqg-c3dTZv7HjVRUPbwcbZht5HV1mwgzrMcBQ@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: a7d0272e-5b53-4b7d-0e42-08d8221f364d
x-ms-traffictypediagnostic: DM6PR11MB2684:
x-microsoft-antispam-prvs: <DM6PR11MB26842FF09FE056CED88F044F8D660@DM6PR11MB2684.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u18LQ2wLJ++gOZMT5v3wBmzQh6LPmEy46ls9l3nRHSdO+GQQMyDuORDTG3EjBNIZEBdWBzRNU/ivjzGl/zkwSXo40d34mMq7OYgjkrGWvfMq4YzP8doQs+zyijfkAxoLUAsSV9UVd2H9oCzEglBYQLoRR6NZUwtEPAbcB8qzhJSDMX/tJsLwc/KlYhgFuigru0LuLIwzt7P3szQLV/SV6FXoR4WaDi3BdujmVQ1HHZW69SBFEC0SX0Zl4EXHFYxZJqefIgS3KmG0w+mEaEoawL8Dm7Lr6UsFxZT8cwkd+UUgAaj3B0n9XQzDKEabOGEt7jELRCINmytDpuBUnwZMbg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1833.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(5660300002)(76116006)(66946007)(316002)(8676002)(2906002)(33656002)(83380400001)(478600001)(66446008)(66556008)(64756008)(71200400001)(66476007)(4326008)(8936002)(7696005)(52536014)(86362001)(9686003)(186003)(53546011)(54906003)(26005)(110136005)(55016002)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: +5N9zb+wuZIWJDhr6hH5+Mfrc9xp7ODw/hTCupJL1tkCuno472SXwyk25+G1uwbQjsweto2si1kNlRC5hZuK/2dxLmp1mjy+KET8LI9cwJG/VVAA7nikLqbwT8efoZX+lyTXsjgDQ7N4PcfBwAHyOw8AuCAjrbvvkI8vMapGxHF+EHWtxT1mrnO40aW25UkaqaCcEt7FxeKib1WNVJEjs7NH3dtwbKA+O+tb2f40UN/glHQDZR3LFxFQnXIwHftZDK0D+nU6Dk5KW46Gy7LL9/N+vxUqY2GS8BBh31kk1U9vlwpGzADnc8XnvLeV2QGs38tx6xah6G+2IggqeknRgVqGpdbE+gYzIN/7XvUOqZXLERISGEO14Fz9/35QefyWrADVyfiMcdSFNwpme3mC+KpMCQ4sGaeBkvYDpc8T2UaGEpE7GBk7ZxWXrTxGNNbDFF0/XnyfCbD31GwcTbZExt1IWNeb17PqaE1LFGLD8l4q5CQ//aoss6AaIKIDyQYE
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1833.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d0272e-5b53-4b7d-0e42-08d8221f364d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 02:41:12.1885 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l/9mx6R27zlPyBa2MLaFr9F3qrD6hMQoYYpGk6dDwLqN/Uus5cp/WAGn8akWtd4Mpoz0ACUIXpmWMZGdvWquHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2684
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=wentong.wu@intel.com; helo=mga18.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 22:41:16
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

SGksDQpJIHRoaW5rIHdlIGNhbiBnZXQgdGhpcyBwYXRjaCBzZXJpZXMgbWVyZ2VkIGZpcnN0IGlu
IG9yZGVyIHRvIGdldCBxZW11X25pb3MyIHdvcmtpbmcgd2l0aCBpY291bnQsIGFjdHVhbGx5IHdl
IGFyZSBibG9ja2VkIGJ5IGl0IGZvciBzb21lIHRpbWUuIA0KQlRXIGlmIG1haW50YWluZXJzKENo
cmlzIFd1bGZmIGFuZCBNYXJlayBWYXN1dCkgZG9uJ3QgaGF2ZSB0aW1lIGZvciB0aGUgcmUtd29y
aywgSSdkIGxpa2UgdG8gdGFrZSBpdC4NCg0KVGhhbmtzDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4g
DQo+IFNlbnQ6IE1vbmRheSwgSnVseSA2LCAyMDIwIDE6MTAgQU0NCj4gVG86IFd1LCBXZW50b25n
IDx3ZW50b25nLnd1QGludGVsLmNvbT4NCj4gQ2M6IFFFTVUgRGV2ZWxvcGVycyA8cWVtdS1kZXZl
bEBub25nbnUub3JnPjsgUUVNVSBUcml2aWFsIDxxZW11LXRyaXZpYWxAbm9uZ251Lm9yZz47IENo
cmlzIFd1bGZmIDxjcnd1bGZmQGdtYWlsLmNvbT47IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRl
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDMvM10gdGFyZ2V0L25pb3MyOiBVc2UgZ2VuX2lvX3N0
YXJ0IGFyb3VuZCB3cmN0bCBpbnN0cnVjdGlvbg0KPg0KPiBPbiBNb24sIDI5IEp1biAyMDIwIGF0
IDA5OjE3LCBXZW50b25nIFd1IDx3ZW50b25nLnd1QGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiB3cmN0bCBpbnN0cnVjdGlvbiBvbiBuaW9zMiB0YXJnZXQgd2lsbCBjYXVzZSBjaGVja2luZyBj
cHUgaW50ZXJydXB0IA0KPiA+IGJ1dCB0Y2dfaGFuZGxlX2ludGVycnVwdCgpIHdpbGwgY2FsbCBj
cHVfYWJvcnQoKSBpZiB0aGUgQ1BVIGdldHMgYW4gDQo+ID4gaW50ZXJydXB0IHdoaWxlIGl0J3Mg
bm90IGluICdjYW4gZG8gSU8nDQo+ID4gc3RhdGUsIHNvIGFkZCBnZW5faW9fc3RhcnQgYXJvdW5k
IHdyY3RsIGluc3RydWN0aW9uLiBBbHNvIGF0IHRoZSBzYW1lIA0KPiA+IHRpbWUsIGVuZCB0aGUg
b25naW5nIFRCIHdpdGggRElTQVNfVVBEQVRFLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2Vu
dG9uZyBXdSA8d2VudG9uZy53dUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIHRhcmdldC9uaW9z
Mi90cmFuc2xhdGUuYyB8IDUgKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9u
cygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3RhcmdldC9uaW9zMi90cmFuc2xhdGUuYyBiL3Rh
cmdldC9uaW9zMi90cmFuc2xhdGUuYyBpbmRleCANCj4gPiA4M2MxMGViMi4uNTEzNDdhZGEgMTAw
NjQ0DQo+ID4gLS0tIGEvdGFyZ2V0L25pb3MyL3RyYW5zbGF0ZS5jDQo+ID4gKysrIGIvdGFyZ2V0
L25pb3MyL3RyYW5zbGF0ZS5jDQo+ID4gQEAgLTMyLDYgKzMyLDcgQEANCj4gPiAgI2luY2x1ZGUg
ImV4ZWMvY3B1X2xkc3QuaCINCj4gPiAgI2luY2x1ZGUgImV4ZWMvdHJhbnNsYXRvci5oIg0KPiA+
ICAjaW5jbHVkZSAicWVtdS9xZW11LXByaW50LmgiDQo+ID4gKyNpbmNsdWRlICJleGVjL2dlbi1p
Y291bnQuaCINCj4gPg0KPiA+ICAvKiBpc19qbXAgZmllbGQgdmFsdWVzICovDQo+ID4gICNkZWZp
bmUgRElTQVNfSlVNUCAgICBESVNBU19UQVJHRVRfMCAvKiBvbmx5IHBjIHdhcyBtb2RpZmllZCBk
eW5hbWljYWxseSAqLw0KPiA+IEBAIC01MTgsNyArNTE5LDExIEBAIHN0YXRpYyB2b2lkIHdyY3Rs
KERpc2FzQ29udGV4dCAqZGMsIHVpbnQzMl90IGNvZGUsIHVpbnQzMl90IGZsYWdzKQ0KPiA+ICAg
ICAgLyogSWYgaW50ZXJydXB0cyB3ZXJlIGVuYWJsZWQgdXNpbmcgV1JDVEwsIHRyaWdnZXIgdGhl
bS4gKi8gICNpZiANCj4gPiAhZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZKQ0KPiA+ICAgICAgaWYg
KChpbnN0ci5pbW01ICsgQ1JfQkFTRSkgPT0gQ1JfU1RBVFVTKSB7DQo+ID4gKyAgICAgICAgaWYg
KHRiX2NmbGFncyhkYy0+dGIpICYgQ0ZfVVNFX0lDT1VOVCkgew0KPiA+ICsgICAgICAgICAgICBn
ZW5faW9fc3RhcnQoKTsNCj4gPiArICAgICAgICB9DQo+ID4gICAgICAgICAgZ2VuX2hlbHBlcl9j
aGVja19pbnRlcnJ1cHRzKGRjLT5jcHVfZW52KTsNCj4gPiArICAgICAgICBkYy0+aXNfam1wID0g
RElTQVNfVVBEQVRFOw0KPiA+ICAgICAgfQ0KPiA+ICAjZW5kaWYNCj4gPiAgfQ0KPiANCj4gUmV2
aWV3ZWQtYnk6IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4NCj4NCj4g
dGhvdWdoIGFzIFJpY2hhcmQgbm90ZXMgaWRlYWxseSB0aGUgaW50ZXJydXB0IGhhbmRsaW5nIGNv
ZGUgaGVyZSBzaG91bGQgYmUgcmV3cml0dGVuIGJlY2F1c2UgdGhlIGNoZWNrX2ludGVycnVwdHMg
aGVscGVyIGlzIGEgdmVyeSB3ZWlyZCB3YXkgdG8gaW1wbGVtZW50IHRoaW5ncy4NCj4NCj4gdGhh
bmtzDQo+IC0tIFBNTQ0K

