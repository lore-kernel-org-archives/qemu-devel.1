Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7280DC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:05:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F872086A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="se7gou+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F872086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLs6T-0001DS-Nq
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 14:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <beeman.strong@intel.com>)
 id 1kLqnw-0004dF-PQ
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:42:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:22348)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <beeman.strong@intel.com>)
 id 1kLqns-0001J3-NT
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:42:40 -0400
IronPort-SDR: +kyVCUSvjTL18/YOjCcEE3BipkwIGGQMZw023fT907pHKtniWhFGh7pugzBD9K+CG3L7neAzaX
 8WN1TpYiRFyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="246367710"
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; d="scan'208";a="246367710"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2020 09:42:28 -0700
IronPort-SDR: q5kXPhK4qmWcTCA0XQMfF+g8b4McJc81M8pKJP3GBSHcPNPsJQ7gy+EETSRoikNYB47nTw0JO3
 nu8EA6zlOa8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; d="scan'208";a="336805429"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by fmsmga004.fm.intel.com with ESMTP; 25 Sep 2020 09:42:28 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 25 Sep 2020 09:42:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 25 Sep 2020 09:42:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 25 Sep 2020 09:42:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iu/CGPKpsw90XJcsfa7M2l4n7maf+9VHoykdywYuEb1bAlLmSpZP1nfeTBPe+J1xRilPo9pgB6KHBaWsumIarOJkwVB4f9klN6NEXvAw1dpVRQGBLNFXckdQnmh88VpeLn9tH9EbnUz9iroEBow1Q2BeyVp3rwhiNMQk4VFoiecfDNoZR7e7t9HPpJTjcurEgAhDv+syw+uZ2J72jnTFOsaBZ8SB0PMyosxrdU+q4E/nuqMT614ALK2DM3aZ1bElmlrEzQHLdK6cu3VRJyoKCP/PQLkbap+7LaTDZC1V0q3i466TEoG5Tb14UPAUTzFB16suZ2143Jzb5D5GjIEctw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVqxnj/5X52ULdp+Sa23cdITwGFgTv+sxDMNOFM7lkc=;
 b=Xu9K0tUJj1HWmWfCfumMnI7ZPel3FNkgF/fqLKHnr8OBPnnIp1nc5N7DYqRChcVpXZqUaJYhLAcQZX6YUFe7SuetQf2uP7PvJK4G6QKu2UhatdvrixqgPmiRpZtS9EGI0M7hZLmid1tDNlp8G4ziLSkCu8BPs4IA8yaLEGUJR6we5B77SDfp8R3/SRKq/isslQcUauC3QleE2HWp44ddPs7hj17TI8O9XSyQiJCCUsMgmr2ly1PJLjXTSuVY6mqYdnQ3/mi0mDYz1++SvSROCEnFv2NhaHCPXieWS4+6f5NNlb+7m4De6I3csL3iRgvOTWqUWqUNDaO0GCMphcadQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVqxnj/5X52ULdp+Sa23cdITwGFgTv+sxDMNOFM7lkc=;
 b=se7gou+vRdLwbca2qrWDoq2vMUhCH9L8bBbHfg5Wb5CRQ/gDaDnI4srs+clvRF0CQm9LTxx8Onp4yCubqHUvJ6oDckN+Wt2tvh8AjkHaX2ycVqQGaz8m2AnTGM2l0oOS7AvM+AQxaq6PBMLZCUbTWtNS0dEN/YAqDTWJWjF7BvA=
Received: from MW3PR11MB4665.namprd11.prod.outlook.com (2603:10b6:303:5d::12)
 by MWHPR11MB1389.namprd11.prod.outlook.com (2603:10b6:300:26::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Fri, 25 Sep
 2020 16:42:26 +0000
Received: from MW3PR11MB4665.namprd11.prod.outlook.com
 ([fe80::2587:4cd7:ebda:f56c]) by MW3PR11MB4665.namprd11.prod.outlook.com
 ([fe80::2587:4cd7:ebda:f56c%3]) with mapi id 15.20.3412.022; Fri, 25 Sep 2020
 16:42:26 +0000
From: "Strong, Beeman" <beeman.strong@intel.com>
To: Eduardo Habkost <ehabkost@redhat.com>, "Kang, Luwei" <luwei.kang@intel.com>
Subject: RE: [PATCH v1 1/3] i386: Remove the limitation of IP payloads for
 Intel PT
Thread-Topic: [PATCH v1 1/3] i386: Remove the limitation of IP payloads for
 Intel PT
Thread-Index: AQHV6xf7sqMNXR+QQka/GVM/9Eq3kKl62AeAgAAGPhA=
Date: Fri, 25 Sep 2020 16:42:26 +0000
Message-ID: <MW3PR11MB46655375CAECC74BA2D7CAECF2360@MW3PR11MB4665.namprd11.prod.outlook.com>
References: <1582580312-19864-1-git-send-email-luwei.kang@intel.com>
 <1582580312-19864-2-git-send-email-luwei.kang@intel.com>
 <20200925161539.GS3717385@habkost.net>
In-Reply-To: <20200925161539.GS3717385@habkost.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [67.171.191.208]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be0ac8df-7f6b-4922-e1a7-08d86171fc3e
x-ms-traffictypediagnostic: MWHPR11MB1389:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB13898995FE969ACF2E027FFBF2360@MWHPR11MB1389.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7NR2VNUkb8pq1qKZ7PblBboyjsn07VTPZysB8IdirtpELMsaV+55s4jXFnn7scgmZtg3JMRefyjucPQwxVA7zCE96oDv+tCHIfgLVfSbLUgZriZET3gr3dfiVXsktb1BeKOKzT2z85TQl756/VKk/TJ0PD456KnsV9bV4OcsQ1q0NswKFbriHhunv11cumeku4QlApGtyEt+Lrl9XscxvyWavMyiIzBmLXbx8CA65tgecq+HzY5qqdSdv9ZIv7PF8iE2qAn9l60Jq5GcMK0P3iVsT5N2eETIaZf1eGq9z3mktQbUozwLRKWHpryVOxIgzbtF2xEgW8KI2zuoLa1jtQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4665.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(54906003)(8936002)(186003)(66946007)(76116006)(53546011)(6506007)(316002)(2906002)(6636002)(7696005)(64756008)(478600001)(66476007)(55016002)(110136005)(66446008)(33656002)(26005)(71200400001)(8676002)(66556008)(5660300002)(52536014)(86362001)(83380400001)(9686003)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: EaFRIvvHQtByJ0RPzhk4+bnSw+2XT+9udPZMkBCdgrJ38ZO4l3IcXesiU3eYsuMm8ax3tiQ/XZ25O9Pv7Xng92jGenTH/GMaJPPdAGAFQOTRzGm+C6u9gVbbkb1Zlx1JN0spO4YxaSpVNxmn0wP3iYt3GlacnwqUoMpwSO/6yzQjkkA24RAqOT6PjYpIIe6Og0tx0G5U364wEhov9HfnGjiFxJvivEbw9tcZrk/ISSL+n6x8sqpAw7tGrTjoysA2grQhMwgphjc7UK3PHM2fN5zB1p2bcQ5PDK0c7fT5zQPQ6dTT03SI5MgRWBDnpMzZI5De/DUyp9iQDkjP8NSnhvRd6E1dO0ieCFR7fRgnmg9O6k/bNxHIAGcwB8QLfpsPDMNpgNdh2mMLMos9aDejdz68IpAMJgqoETH8VH1+48OiYC0Siz5pD14Mv19HjK2JeitFEIH7s0jVzDpUcMCknk99GHF+OagwQzlRpPxSBM3BuP+qBpcf6RRN1OipMTdu72qAnNniSCEVvrnRF8ivaeyZgWuHEjAMyccSG6zsPH9ju8QtWma23nOIgTOBJC0XyuAkxQ+e98mtV8mAcsKcGD0fbqbDJInu8pCEtYeMa+CCVMYhod2/mNF5ppzkR+iRlAAmCnS18OjtgtShyY0aPw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0ac8df-7f6b-4922-e1a7-08d86171fc3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2020 16:42:26.2878 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xCFodqax7tlknA2MnOKqBwxOGIB5E+bYy3+jrcscBbl72GpME60QwQbqAc1Vn8bv8WiarDR+bJsV4+gToI+yuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1389
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.43;
 envelope-from=beeman.strong@intel.com; helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 12:42:29
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Sep 2020 14:04:06 -0400
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TElQPTAgd2lsbCBkaWZmZXIgZnJvbSBMSVA9MSBiZWhhdmlvciBvbmx5IHdoZW4gQ1NiYXNlIGlz
IG5vbi16ZXJvLCB3aGljaCByZXF1aXJlcyAzMi1iaXQgY29kZS4gIEluIHRoYXQgY2FzZSBhIExJ
UD0wIGltcGxlbWVudGF0aW9uIHdpbGwgcHJvdmlkZSBvbmx5IHRoZSBFSVAgb2Zmc2V0IGZyb20g
Q1NiYXNlIGluIElQIHBhY2tldHMgKGxpa2UgVElQIG9yIEZVUCksIHdoaWxlIExJUD0xIGltcGxl
bWVudGF0aW9uIHdpbGwgcHJvdmlkZSB0aGUgZnVsbCBMSVAgKENTYmFzZSArIEVJUCBvZmZzZXQp
Lg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogRWR1YXJkbyBIYWJrb3N0IDxl
aGFia29zdEByZWRoYXQuY29tPiANClNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDI1LCAyMDIwIDk6
MTYgQU0NClRvOiBLYW5nLCBMdXdlaSA8bHV3ZWkua2FuZ0BpbnRlbC5jb20+DQpDYzogcGJvbnpp
bmlAcmVkaGF0LmNvbTsgcnRoQHR3aWRkbGUubmV0OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IFN0
cm9uZywgQmVlbWFuIDxiZWVtYW4uc3Ryb25nQGludGVsLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjEgMS8zXSBpMzg2OiBSZW1vdmUgdGhlIGxpbWl0YXRpb24gb2YgSVAgcGF5bG9hZHMgZm9y
IEludGVsIFBUDQoNCk9uIFR1ZSwgRmViIDI1LCAyMDIwIGF0IDA1OjM4OjMwQU0gKzA4MDAsIEx1
d2VpIEthbmcgd3JvdGU6DQo+IFRoZSBJbnRlbCBQVCBwYWNrZXRzIHdoaWNoIGNvbnRhaW4gSVAg
cGF5bG9hZHMgd2lsbCBoYXZlIExJUCB2YWx1ZXMsIA0KPiBhbmQgaXQgd2lsbCBpbmNsdWRlIHRo
ZSBDUyBiYXNlIGNvbXBvbmVudCBpZiB0aGUgDQo+IENQVUlELihFQVg9MTRILEVDWD0wSCkuRUNY
LltiaXQzMV0NCj4gaXMgc2V0LiBCdXQgaXQgd2lsbCBkaXNhYmxlZCB0aGUgSW50ZWwgUFQgaW4g
a3ZtIGd1ZXN0IGJlY2F1c2Ugb2YgdGhlIA0KPiBuZWVkIG9mIGxpdmUgbWlncmF0aW9uIHNhZmUo
YzA3OGNhOSBpMzg2OiBEaXNhYmxlIEludGVsIFBUIGlmIHBhY2tldHMgDQo+IElQIHBheWxvYWRz
IGhhdmUgTElQIHZhbHVlcykuDQo+IA0KPiBUaGlzIHBhdGNoIHdpbGwgcmV2ZXJ0IHRoZSBwcmV2
aW91cyBsaW1pdGF0aW9uIGJlY2F1c2UgdGhlIEludGVsIG5ldyANCj4gaGFyZHdhcmUgd2lsbCBz
ZXQgdGhpcyBiaXQgYW5kIExJUCA9PSBSSVAgZm9yIG1vc3QvYWxsIHJlYWwgY29kZS4NCg0KIndv
cmtzIG1vc3Qgb2YgdGhlIHRpbWUiIG1pZ2h0IGJlIGdvb2QgZW5vdWdoIGlmIGl0J3MgYSBjb25z
Y2lvdXMgdXNlciBjaG9pY2UsIGJ1dCBub3QgZm9yIHNvbWV0aGluZyB3ZSBtaWdodCBiZSBlbmFi
bGluZyBieSBkZWZhdWx0LiAgVW5kZXIgd2hpY2ggY29uZGl0aW9ucyB0aGlzIHdvdWxkbid0IHdv
cms/ICBDYW4gd2UgZGV0ZWN0IHRob3NlIGNvbmRpdGlvbnMgc29tZWhvdz8NCg0KVG8gYWxsb3cg
bGl2ZSBtaWdyYXRpb24gYmV0d2VlbiBMSVA9MCBhbmQgTElQPTEgaG9zdHMsIHdlIG5lZWQgS1ZN
IHRvIGJlIGFibGUgdG8gcHJvcGVybHkgZW11bGF0ZSBMSVA9MCBvbiBMSVA9MSBob3N0cy4gIERv
ZXMgdGhlIGhhcmR3YXJlIG1ha2UgdGhpcyBwb3NzaWJsZT8NCg0KSWYgS1ZNIGNhbid0IGVtdWxh
dGUgTElQPTAgb24gYSBMSVA9MSBob3N0LCB3aGF0IHlvdSBjYW4gZG8gaGVyZSBpcyB0byBtYWtl
IHRoZSBmbGFnIGNvbmZpZ3VyYWJsZSBhbmQgY2hlY2sgaWYgdGhlIGNvbmZpZ3VyZWQgdmFsdWUg
bWF0Y2hlcyB0aGUgb25lIGluIHRoZSBob3N0LiAgVGhpcyB3YXkgd2UgY2FuIHN1cHBvcnQgYm90
aCB0eXBlcyBvZiBob3N0cywganVzdCBub3QgYWxsb3cgbGl2ZSBtaWdyYXRpb24gYmV0d2VlbiB0
aGVtLg0KDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEx1d2VpIEthbmcgPGx1d2VpLmthbmdAaW50
ZWwuY29tPg0KPiAtLS0NCj4gIHRhcmdldC9pMzg2L2NwdS5jIHwgNSArLS0tLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL3RhcmdldC9pMzg2L2NwdS5jIGIvdGFyZ2V0L2kzODYvY3B1LmMgaW5kZXggDQo+IDY5ZjUx
OGEuLjhjMGQxZTQgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9pMzg2L2NwdS5jDQo+ICsrKyBiL3Rh
cmdldC9pMzg2L2NwdS5jDQo+IEBAIC02ODgsOCArNjg4LDYgQEAgc3RhdGljIENQVUNhY2hlSW5m
byBsZWdhY3lfbDNfY2FjaGUgPSB7DQo+ICAgKiBiaXRbMDJdOiBTdXBwb3J0IFNpbmdsZS1SYW5n
ZSBPdXRwdXQgc2NoZW1lOw0KPiAgICovDQo+ICAjZGVmaW5lIElOVEVMX1BUX01JTklNQUxfRUNY
ICAgICAweDcNCj4gLS8qIGdlbmVyYXRlZCBwYWNrZXRzIHdoaWNoIGNvbnRhaW4gSVAgcGF5bG9h
ZHMgaGF2ZSBMSVAgdmFsdWVzICovDQo+IC0jZGVmaW5lIElOVEVMX1BUX0lQX0xJUCAgICAgICAg
ICAoMSA8PCAzMSkNCj4gICNkZWZpbmUgSU5URUxfUFRfQUREUl9SQU5HRVNfTlVNIDB4MiAvKiBO
dW1iZXIgb2YgY29uZmlndXJhYmxlIA0KPiBhZGRyZXNzIHJhbmdlcyAqLyAgI2RlZmluZSBJTlRF
TF9QVF9BRERSX1JBTkdFU19OVU1fTUFTSyAweDMNCj4gICNkZWZpbmUgSU5URUxfUFRfTVRDX0JJ
VE1BUCAgICAgICgweDAyNDkgPDwgMTYpIC8qIFN1cHBvcnQgQVJUKDAsMyw2LDkpICovDQo+IEBA
IC02MjgxLDggKzYyNzksNyBAQCBzdGF0aWMgdm9pZCB4ODZfY3B1X2ZpbHRlcl9mZWF0dXJlcyhY
ODZDUFUgKmNwdSwgYm9vbCB2ZXJib3NlKQ0KPiAgICAgICAgICAgICAoKGVheF8xICYgSU5URUxf
UFRfQUREUl9SQU5HRVNfTlVNX01BU0spIDwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBJTlRFTF9QVF9BRERSX1JBTkdFU19OVU0pIHx8DQo+ICAgICAgICAg
ICAgICgoZWJ4XzEgJiAoSU5URUxfUFRfUFNCX0JJVE1BUCB8IElOVEVMX1BUX0NZQ0xFX0JJVE1B
UCkpICE9DQo+IC0gICAgICAgICAgICAgICAgKElOVEVMX1BUX1BTQl9CSVRNQVAgfCBJTlRFTF9Q
VF9DWUNMRV9CSVRNQVApKSB8fA0KPiAtICAgICAgICAgICAoZWN4XzAgJiBJTlRFTF9QVF9JUF9M
SVApKSB7DQo+ICsgICAgICAgICAgICAgICAgKElOVEVMX1BUX1BTQl9CSVRNQVAgfCBJTlRFTF9Q
VF9DWUNMRV9CSVRNQVApKSkgew0KPiAgICAgICAgICAgICAgLyoNCj4gICAgICAgICAgICAgICAq
IFByb2Nlc3NvciBUcmFjZSBjYXBhYmlsaXRpZXMgYXJlbid0IGNvbmZpZ3VyYWJsZSwgc28gaWYg
dGhlDQo+ICAgICAgICAgICAgICAgKiBob3N0IGNhbid0IGVtdWxhdGUgdGhlIGNhcGFiaWxpdGll
cyB3ZSByZXBvcnQgb24NCj4gLS0NCj4gMS44LjMuMQ0KPiANCg0KLS0gDQpFZHVhcmRvDQoNCg==

