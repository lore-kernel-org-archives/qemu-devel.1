Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC8DC388F7
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 00:14:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51D6A223C7
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 00:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="RrEVxWw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D6A223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVkin-00014z-1M
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 20:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luwei.kang@intel.com>)
 id 1kVkhu-0000f2-Js
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 20:13:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:64931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luwei.kang@intel.com>)
 id 1kVkhr-0002Ci-Qw
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 20:13:22 -0400
IronPort-SDR: RbhE0Vdzs47fqZJt8qB55UvE70fRuSrXVF/u5LhIVBWi74y7rukmiCkmiHA4NsBEB+cvOwQQKV
 6sSMpTDoJ38Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="167733321"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; d="scan'208";a="167733321"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2020 17:13:13 -0700
IronPort-SDR: JD77s+NutyPP5ZZcijM/8MMtL2kmGNDj806ExNdjsdCMt/h2RjNwE7MDR8LF64C+GJIo2FGEg4
 YeLBP5bM282A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; d="scan'208";a="302499952"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by fmsmga008.fm.intel.com with ESMTP; 22 Oct 2020 17:13:13 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 22 Oct 2020 17:13:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 22 Oct 2020 17:13:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 22 Oct 2020 17:13:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5YEiDw0D7BDb1XILEZysUamHHlUxdHynh8FdzjdifPx+osy9x08W2uqLt7K+GcZBbDC1Wk11dc6BKbj5SR3zW2btp9ebk2+wiacgk8NCnplDjWYkLvrNhVwiA8fYRuZ5ZETthe9jMZMi+oB+KDkH5bm3MQsLEUkySk5IfrQevQHryufxjsqi2a3yxzEHw9DrANqQN4/mtjIM5q2dPJcOQR0bMn/4AFd+AbcuM9kP2nW9j6aE8OcuQe2Q65b/lvrYKvTKoWY1ghoO+rac4SVTp14Zz0qelgvOp4fAEDOWnGBNRMmhXzArdKVYavBqOXjCyJe94jSQ04WznwFfymRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmkXzgFY9Ck53F3ny7wYLx4LOvabgs/a8WH+cwJZFpM=;
 b=VIsKbuyUbkboA3lCW3MSHNab0fX2VDApekbLdOxkt/fG5v074aDO7KRSKZt0pSjzd0zp4dLvNg/qFQn1m5Zamed+B3wk1G++1ty6vcJkGbrqhDBp57MapqGG3mX6RfahkadMugDSfhhQD59MO1nklTItxnq96dUQNqdRa/JGLdERGyVLemlBNtTb26GJqSeQ3ixgOi3Inh/SrAtVLxfU1rrqBujOm0iz3J014EbUBNoJ4F1o6FU/H3nP7ml7xoTU/fYkl5NJ6JJzzox9DdZ/bV+e//GhY/0Bv8sdJ+y2l3a7LsPqIZKGiEbI431mWsXo81N8xq/oyXtWUrrxcIDn8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmkXzgFY9Ck53F3ny7wYLx4LOvabgs/a8WH+cwJZFpM=;
 b=RrEVxWw9dfHcn87aU8Jt+g+dssS8LdVOkCwOI43PtpLBK2TfqjjBeJFenADjbmNWEdnzrW6lCpQTTGGcwTWFIV9e8lVPBMh2360xsw3pIqi4RZlssZ3t2fSojy5WjVJA3mHCD7ywpDly8in3GT40RhTJ8+hmilZYrOZS12x1T4U=
Received: from CY4PR11MB1447.namprd11.prod.outlook.com (2603:10b6:910:10::16)
 by CY4PR11MB1399.namprd11.prod.outlook.com (2603:10b6:903:2f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 23 Oct
 2020 00:13:07 +0000
Received: from CY4PR11MB1447.namprd11.prod.outlook.com
 ([fe80::e973:a623:3d68:7669]) by CY4PR11MB1447.namprd11.prod.outlook.com
 ([fe80::e973:a623:3d68:7669%4]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 00:13:06 +0000
From: "Kang, Luwei" <luwei.kang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, 
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Subject: RE: [PATCH] i386/cpu: Expose the PTWRITE to the guest
Thread-Topic: [PATCH] i386/cpu: Expose the PTWRITE to the guest
Thread-Index: AQHWqEorI2N0Z6q9SUO0e8/VKWwsj6mjljSAgAC6UJA=
Date: Fri, 23 Oct 2020 00:13:06 +0000
Message-ID: <CY4PR11MB14478D54B50D7456E1288D19801A0@CY4PR11MB1447.namprd11.prod.outlook.com>
References: <20201022040122.30086-1-luwei.kang@intel.com>
 <4d21bf6c-a6b3-c0fe-d291-9661fa6436fb@redhat.com>
In-Reply-To: <4d21bf6c-a6b3-c0fe-d291-9661fa6436fb@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95dbb542-4152-44e8-7ddb-08d876e86ad6
x-ms-traffictypediagnostic: CY4PR11MB1399:
x-microsoft-antispam-prvs: <CY4PR11MB13998B585E9F9C71737BE9C6801A0@CY4PR11MB1399.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZXISWjdzjRvGG6DlmWUSu+AnnSJ1KSLoGsh/M5t3wgNvkKWBoYTLCD+27eWKtOXBgpnBvLhc30pk//H1lxZZFl5cFhNUxgupuCHC1qpDcF3cPHUuZFj2A5b9nAKp9ZS3s6bnxOAMW+8OcjZPgV7cxtstSUtqVkTzbFyeJLE71QnQGdtFeUa+zk156BJzlgnwfdcZ7U0vKP+Z+cSb1T84fhIq2xQBrCWNbjQjGH5zAevUOwaBFH3Js08Sqjjm1DThzVal5zAPxi0rvNvZv0gRlIiOtG0XTlH20jo1XHDKgiOPE3lcI5VkOgutaFXfYEsFZrWwqgmM9Zja992HhXuPCA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR11MB1447.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(8936002)(2906002)(66476007)(9686003)(66556008)(76116006)(52536014)(66446008)(71200400001)(64756008)(5660300002)(66946007)(86362001)(110136005)(186003)(55016002)(26005)(6506007)(8676002)(33656002)(7696005)(316002)(478600001)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: EzIKgGtXsHVmsNhsNBjMCCTdt61RcZjXOieEPfpVbeezDKVnxi/oU71PrYn6OV/+YKOdJvBhrt+9pdb4eHcIvsa1j+luXewOmfOuz7O8zm2NdDzCPwv/aYe8YUoPSFo/gxLjFdYzclmBZUUxTAUsnU0+NbweZ8Vvu3dYgH7qFUdcIowDzW/YW+6vg3BmDArU5mgItj+mZDbVkmUcJPGnYpd3NItauz8Qd6ZyU5/CO6WneIIaputUnP4NNtdwnayYUHSs9Ndss60DaUFKHjnb9MZnY8etEedte7hYgU1QDo3VOFWO4PjMcF3gKna8EyvNXnHPju+GaHVq0cLTFxdxAtY/7f/MVs4PrgKQEaJjxaMmEQtsZoTQiv7z+p2Ie+We6l6BjBwa/etBhP83PEQsx2WjRmOXtqz0U9m5JLcVCV4Jd73R9dd6Hgl+wI1/loFWgvoSk1Q+4FLNKo6YuAMlHHmR7PGc2a9Yv8kbNKAZGUGK1k+SQ9BEe6gGNw4oX6C2lblOELM+BK/cQM09OKghdLdGGY8tzMMsl9+5LgXeMMhiVq0Vh3bs8NsYpMuY+lK7TSQvjvNI7/rNvgmJ63w3p8TFWCmgrJl8Qtr9ufx7BUZcO7Ck/y8IJjHSUm2kgwNL4JIKFE+k7jrxaAgRp3eZtg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1447.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95dbb542-4152-44e8-7ddb-08d876e86ad6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2020 00:13:06.8547 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uW4ECdMzCB6YV4ZcWBtuSo961aIAeiRka+8A+5YOmUg8Px+7W60jeDOrMlYs8ochv7XILm+aOA3aQoIY4kc0SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1399
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.24; envelope-from=luwei.kang@intel.com;
 helo=mga09.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 20:13:13
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

PiA+IFBUV1JJVEUgcHJvdmlkZXMgYSBtZWNoYW5pc20gYnkgd2hpY2ggc29mdHdhcmUgY2FuIGlu
c3RydW1lbnQgdGhlDQo+ID4gSW50ZWwgUFQgdHJhY2UuIFRoZSBjdXJyZW50IGltcGxlbWVudGF0
aW9uIHdpbGwgbWFzayBvZmYgdGhpcyBmZWF0dXJlDQo+ID4gd2hlbiB0aGUgUFRXUklURSBpcyBz
dXBwb3J0ZWQgb24gdGhlIGhvc3QgYmVjYXVzZSBvZiB0aGUgSW50ZWwgUFQNCj4gPiBDUFVJRCBp
cyBhIGNvbnN0YW50IHZhbHVlKElDWCBDUFVJRCkgaW4gcWVtdS4gVGhpcyBwYXRjaCB3aWxsIGV4
cG9zZQ0KPiA+IHRoZSBQVFdSSVRFIGZlYXR1cmUgdG8gdGhlIGd1ZXN0Lg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogTHV3ZWkgS2FuZyA8bHV3ZWkua2FuZ0BpbnRlbC5jb20+DQo+ID4gLS0tDQo+
ID4gIHRhcmdldC9pMzg2L2NwdS5jIHwgMjQgKysrKysrKysrKysrKysrKysrKysrKysrICB0YXJn
ZXQvaTM4Ni9jcHUuaCB8DQo+ID4gNCArKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjggaW5z
ZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3RhcmdldC9pMzg2L2NwdS5jIGIvdGFy
Z2V0L2kzODYvY3B1LmMgaW5kZXgNCj4gPiBhZWFiZGQ1YmQ0Li4yNDJiYThhODcwIDEwMDY0NA0K
PiA+IC0tLSBhL3RhcmdldC9pMzg2L2NwdS5jDQo+ID4gKysrIGIvdGFyZ2V0L2kzODYvY3B1LmMN
Cj4gPiBAQCAtNjcyLDYgKzY3Miw3IEBAIHN0YXRpYyB2b2lkIHg4Nl9jcHVfdmVuZG9yX3dvcmRz
MnN0cihjaGFyICpkc3QsDQo+ID4gdWludDMyX3QgdmVuZG9yMSwgICNkZWZpbmUgVENHX1hTQVZF
X0ZFQVRVUkVTDQo+IChDUFVJRF9YU0FWRV9YU0FWRU9QVCB8IENQVUlEX1hTQVZFX1hHRVRCVjEp
DQo+ID4gICAgICAgICAgICAvKiBtaXNzaW5nOg0KPiA+ICAgICAgICAgICAgQ1BVSURfWFNBVkVf
WFNBVkVDLCBDUFVJRF9YU0FWRV9YU0FWRVMgKi8NCj4gPiArI2RlZmluZSBUQ0dfMTRfMF9FQlhf
RkVBVFVSRVMgMA0KPiA+ICAjZGVmaW5lIFRDR18xNF8wX0VDWF9GRUFUVVJFUyAwDQo+ID4NCj4g
PiAgdHlwZWRlZiBlbnVtIEZlYXR1cmVXb3JkVHlwZSB7DQo+ID4gQEAgLTEzMDIsNiArMTMwMywy
NiBAQCBzdGF0aWMgRmVhdHVyZVdvcmRJbmZvDQo+IGZlYXR1cmVfd29yZF9pbmZvW0ZFQVRVUkVf
V09SRFNdID0gew0KPiA+ICAgICAgICAgIH0NCj4gPiAgICAgIH0sDQo+ID4NCj4gPiArICAgIFtG
RUFUXzE0XzBfRUJYXSA9IHsNCj4gPiArICAgICAgICAudHlwZSA9IENQVUlEX0ZFQVRVUkVfV09S
RCwNCj4gPiArICAgICAgICAuZmVhdF9uYW1lcyA9IHsNCj4gPiArICAgICAgICAgICAgTlVMTCwg
TlVMTCwgTlVMTCwgTlVMTCwNCj4gPiArICAgICAgICAgICAgInB0d3JpdGUiLCBOVUxMLCBOVUxM
LCBOVUxMLA0KPiA+ICsgICAgICAgICAgICBOVUxMLCBOVUxMLCBOVUxMLCBOVUxMLA0KPiA+ICsg
ICAgICAgICAgICBOVUxMLCBOVUxMLCBOVUxMLCBOVUxMLA0KPiA+ICsgICAgICAgICAgICBOVUxM
LCBOVUxMLCBOVUxMLCBOVUxMLA0KPiA+ICsgICAgICAgICAgICBOVUxMLCBOVUxMLCBOVUxMLCBO
VUxMLA0KPiA+ICsgICAgICAgICAgICBOVUxMLCBOVUxMLCBOVUxMLCBOVUxMLA0KPiA+ICsgICAg
ICAgICAgICBOVUxMLCBOVUxMLCBOVUxMLCBOVUxMLA0KPiA+ICsgICAgICAgIH0sDQo+ID4gKyAg
ICAgICAgLmNwdWlkID0gew0KPiA+ICsgICAgICAgICAgICAuZWF4ID0gMHgxNCwNCj4gPiArICAg
ICAgICAgICAgLm5lZWRzX2VjeCA9IHRydWUsIC5lY3ggPSAwLA0KPiA+ICsgICAgICAgICAgICAu
cmVnID0gUl9FQlgsDQo+ID4gKyAgICAgICAgfSwNCj4gPiArICAgICAgICAudGNnX2ZlYXR1cmVz
ID0gVENHXzE0XzBfRUJYX0ZFQVRVUkVTLA0KPiA+ICsgICAgfSwNCj4gPiArDQo+IA0KPiBQbGVh
c2UgYWRkIGEgZGVwZW5kZW5jeSBvbiB0aGUgcHJvY2Vzc29yIHRyYWNpbmcgZmxhZyB0b28uDQoN
CldpbGwgZml4IGl0IGluIHRoZSBuZXh0IHZlcnNpb24uIFRoYW5rcy4NCg0KTHV3ZWkgS2FuZw0K
DQo+IA0KPiBQYW9sbw0KPiANCg0K

