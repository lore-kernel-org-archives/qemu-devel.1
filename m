Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2DEC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 05:06:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C67A323A5C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 05:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="VzBADusL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67A323A5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKaV6-0002bK-Gt
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 01:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei.rao@intel.com>) id 1kKaU4-000255-5J
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 01:04:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:15181)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei.rao@intel.com>) id 1kKaU1-00087W-3i
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 01:04:55 -0400
IronPort-SDR: q/AAzS6TJToJPvythe7cx+X9ERRinYvjUiTZ4lf7znNEZso9fd1/vBt3JBmHlBMFdvjQFNELJT
 SXfyBMZVBeSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="148193554"
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; d="scan'208";a="148193554"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 22:04:44 -0700
IronPort-SDR: 3YAhFvWpfDHYhzJNy/k/i61nx3JKtMWgr66fjdtZ3+a0y+myvlTabiUcQcsy6QN11Brm6OMX/x
 1hlarGTdf+6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; d="scan'208";a="304814008"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga003.jf.intel.com with ESMTP; 21 Sep 2020 22:04:44 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 21 Sep 2020 22:04:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 21 Sep 2020 22:04:43 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 21 Sep 2020 22:04:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgVo0qjGLNQ4ol5dl3dTVD19cTUWC9+35Stg544G9N3aupoQikOlRTIcJ5A7XQxtq0VssGA5jq94CUWhgu0NJI1a/96MfXCrIMG2fF2BA1+bcRYcNmdKAhJl5FaJNsj3fe/J0PrrMyMVLEx/T05SJ/fBHcNfs+tofBQvGu4Onz5FBeqOhfRjwN22L4ShG5bZGpkSgz1TxW5HBRiWumXjPzag1ZSu05OQ7YTN9/Wic4gOcPNiIPXmC8JRSudklIQopJL5vEhzMGEm8H10ZprSQ7W096V9HhpUI4HKXOiUG8kEe94w0/gXYb1e3woCHujwjzR3nhoWBk1PqlIyubWpSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUPXMbfXnbni7UEuUT6dyHLFEjOvtPBOePwJ8UviPd0=;
 b=KM4JxDzmgx4CSkaRNtOXdkSI0NJ9cRK0uvdKAoI4PTNQJxcDyr+C3gtUv9B7ksWxl30GRFyWMMlmD2uz9LmKcWHEbniKg3+8Y/6yLkZGO6t9700o1YtkWvdHxTtQ9HINc/lm+kpLz0daOWKS2QDjxwNBTkGap4RPd9wA3kkDOzAOIBtoBbdz+HO3BUaecvCdcB96EV13w5WWJe7KmYJ994JrqeTTJJcL4CVyQLNWplnVKDhINzs6KaUYmApDn46zrUrh2oNJuIjlbUUKQ4tQdxfcvoPeGu7mSPKB1fyfHph0IvT+3zG0tja5s/xFV78v3kqRlcwppB3BQVNyy45TIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUPXMbfXnbni7UEuUT6dyHLFEjOvtPBOePwJ8UviPd0=;
 b=VzBADusL1n7ZazJZJorJmGeCx5kgOwU/A7vCN4wTLSSx0gb/2F/ok0FpgNm5CAmQaCB/DKNU/D7rKIanskc69xOhTqmK1L6LA1RR/XvareZVea+yMVoFyEJ1pAjBW7lMmErD45OEQ5nOCCY39udnH4V75mqi2n3YRZ4I7jwU8Lg=
Received: from SN6PR11MB3103.namprd11.prod.outlook.com (2603:10b6:805:d7::13)
 by SA0PR11MB4751.namprd11.prod.outlook.com (2603:10b6:806:73::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Tue, 22 Sep
 2020 05:04:40 +0000
Received: from SN6PR11MB3103.namprd11.prod.outlook.com
 ([fe80::dd10:fbd6:99e9:52f4]) by SN6PR11MB3103.namprd11.prod.outlook.com
 ([fe80::dd10:fbd6:99e9:52f4%4]) with mapi id 15.20.3391.024; Tue, 22 Sep 2020
 05:04:40 +0000
From: "Rao, Lei" <lei.rao@intel.com>
To: Derek Su <dereksu@qnap.com>, "Zhang, Chen" <chen.zhang@intel.com>
Subject: RE: [PATCH v1 1/1] COLO: only flush dirty ram pages from colo cache
Thread-Topic: [PATCH v1 1/1] COLO: only flush dirty ram pages from colo cache
Thread-Index: AQHWh1/dgjfXRbYmWk6DdoD9BvpKCalzjL0AgACIBWCAAALcAIAAEPtQ
Date: Tue, 22 Sep 2020 05:04:39 +0000
Message-ID: <SN6PR11MB310385A0573115166280241DFD3B0@SN6PR11MB3103.namprd11.prod.outlook.com>
References: <20200910104650.1182807-1-dereksu@qnap.com>
 <20200910104650.1182807-2-dereksu@qnap.com>
 <CAKEOLWXPfULXx5-vzg3w-DRS3azhkizo-Ne05FJE+t5mtPd4Mg@mail.gmail.com>
 <b92f4c7b02fd448a949fed3b304cafa8@intel.com>
 <CAKEOLWW+zWuA6BYMcM35pqJFdSS+jz+1OfScsksb5izemfrGig@mail.gmail.com>
In-Reply-To: <CAKEOLWW+zWuA6BYMcM35pqJFdSS+jz+1OfScsksb5izemfrGig@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: qnap.com; dkim=none (message not signed)
 header.d=none;qnap.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acad8411-091a-4a08-1415-08d85eb502b8
x-ms-traffictypediagnostic: SA0PR11MB4751:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR11MB47518AA9692C93C45ED26755FD3B0@SA0PR11MB4751.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nuail6NTeVtMO74J7B8rMy87qMOYY83jY3bejf35fojfTGde206deYSMxMSsvf7aO+Ae7vsrONskgmsfEKkRacut8F4qTG1kB4cv5eP2Sd6DyCYi0svbGng8OXPOhKygp/FKfWFpd6RkFncypoczP57shmJYLjsGDBlD8cYnkxTTTsWgxhm/RVNZ60q3bczFWLCc53nhLtbBkWOzX903cl06sVobRtbqQDIYLEtpeKYa7NdyuDqqVD7fRCgqKamRMbmPPGVA6CMQSXCJ+MHy6NO+e9L1zg7aRPkQ0e3ktauPNd8j49CqifJmUkjipqFgc/MiIehi162iGZhqe/82iUwCtvRqt5o32P+5rSnThav8aW+a2NTb6paADrfvtYyc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR11MB3103.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(478600001)(53546011)(7696005)(76116006)(6636002)(26005)(55016002)(66946007)(86362001)(9686003)(6506007)(316002)(110136005)(64756008)(66556008)(66446008)(33656002)(2906002)(54906003)(66476007)(52536014)(8676002)(8936002)(83380400001)(71200400001)(186003)(5660300002)(4326008)(14143004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Or64zsfUg050b5SN73uTpKHpgr/rqDiyWiRNflIvnjkZaGxwst5CtGLr8Ha0EGA1MZtAt8cc3oIU3mWCMO90LMYBRQMn9pqEMlFcjI+ySnjkZDAUDtVl1xv9RpaHDvaaj3HRuvK2rHwDDr+witpIzOGq/llv7JHuKylZLyUHSsYGv7ORKqXM1TSKH0uLyhp3cr/4Lz5z3bDqQPK0nAzcaMcy6w87fveLEf/iqZOLIiJGsNPYAfakLghBMUSqMtNFbvt4ytNRQwe+ZieRg8rpQp6GZuA/Ow4Ua5SrQwfm9zXTgoArM5gGWr4i4l0ng1uHRg8o1qLFSr/Gt0GB46zd1CKt8o82EjEQ9XSIhO6QqfjCoGbHXkhFsJpZa6fd3XFbadMDkdTI/HWXxDenvHue2wYO5iXutHIQq4jT8Rgg0PadfSl2DBWjwospHUkQD1LePjs8G3N9rokmucawEUAEhJk4hcNUGUYUxJeWHCcxQSGWprlNli9jXzFUhbNPmY53gXNOb7PoRBu6kLL6Fc6GTmQLOi3mEXxvkYorwZHT/8stQdsxaCq6hqwTSA7igIQEhoFHOJkgZ5wzBDi+dHdK8a4ZKx2ufpP0zAM77a8z3DF8hCrkxhN4awSn/vhd5dKbTXcs4UNl1HDuodeMDdAhIw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3103.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acad8411-091a-4a08-1415-08d85eb502b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2020 05:04:39.9655 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9OrYpadlQMTThQdNlx9ir8EVKGhJJ3Ru7KlV+sYo6TWLDRqUS8CszX3Ski5S4Rwet9+iRbYrtLi8+g8rhucsdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4751
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20; envelope-from=lei.rao@intel.com;
 helo=mga02.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 01:04:45
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
Cc: "quintela@redhat.com" <quintela@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "zhang.zhanghailiang@huawei.com" <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGksIERlcmVrIGFuZCBDaGVuDQoNCnJhbV9idWxrX3N0YWdlIGlzIGZhbHNlIGJ5IGRlZmF1bHQg
YmVmb3JlIEhhaWxpYW5nJ3MgcGF0Y2guDQpGb3IgQ09MTywgaXQgZG9lcyBub3Qgc2VlbSB0byBi
ZSB1c2VkLCBzbyBJIHRoaW5rIHRoZXJlIGlzIG5vIG5lZWQgdG8gcmVzZXQgaXQgdG8gdHJ1ZS4N
Cg0KVGhhbmtzLA0KTGVpLg0KDQpGcm9tOiBEZXJlayBTdSA8ZGVyZWtzdUBxbmFwLmNvbT4gDQpT
ZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjIsIDIwMjAgMTE6NDggQU0NClRvOiBaaGFuZywgQ2hl
biA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+DQpDYzogcWVtdS1kZXZlbCA8cWVtdS1kZXZlbEBub25n
bnUub3JnPjsgUmFvLCBMZWkgPGxlaS5yYW9AaW50ZWwuY29tPjsgemhhbmcuemhhbmdoYWlsaWFu
Z0BodWF3ZWkuY29tOyBxdWludGVsYUByZWRoYXQuY29tOyBkZ2lsYmVydEByZWRoYXQuY29tDQpT
dWJqZWN0OiBSZTogW1BBVENIIHYxIDEvMV0gQ09MTzogb25seSBmbHVzaCBkaXJ0eSByYW0gcGFn
ZXMgZnJvbSBjb2xvIGNhY2hlDQoNCkhpLCBDaGVuDQoNClN1cmUuDQoNCkJUVywgSSBqdXN0IHdl
bnQgdGhyb3VnaCBMZWkncyBwYXRjaC4NCnJhbV9idWxrX3N0YWdlKCkgbWlnaHQgbmVlZCB0byBy
ZXNldCB0byB0cnVlIGFmdGVyIHN0b3BwaW5nIENPTE8gc2VydmljZSBhcyBteSBwYXRjaC4NCkhv
dyBhYm91dCB5b3VyIG9waW5pb24/DQoNClRoYW5rcy4NCg0KDQpCZXN0IHJlZ2FyZHMsDQpEZXJl
aw0KDQoNClpoYW5nLCBDaGVuIDxtYWlsdG86Y2hlbi56aGFuZ0BpbnRlbC5jb20+IOaWvCAyMDIw
5bm0OeaciDIy5pelIOmAseS6jCDkuIrljYgxMTo0MeWvq+mBk++8mg0KSGkgRGVyZWsgYW5kIExl
aSwNCsKgDQpJdCBsb29rcyBzYW1lIHdpdGggTGVp4oCZIHBhdGNoOg0KW1BBVENIIDIvM10gUmVk
dWNlIHRoZSB0aW1lIG9mIGNoZWNrcG9pbnQgZm9yIENPTE8NCkNhbiB5b3UgZGlzY3VzcyB0byBt
ZXJnZSBpdCBpbnRvIG9uZSBwYXRjaD8NCsKgDQpUaGFua3MNClpoYW5nIENoZW4NCsKgDQpGcm9t
OiBEZXJlayBTdSA8bWFpbHRvOmRlcmVrc3VAcW5hcC5jb20+IA0KU2VudDogVHVlc2RheSwgU2Vw
dGVtYmVyIDIyLCAyMDIwIDExOjMxIEFNDQpUbzogcWVtdS1kZXZlbCA8bWFpbHRvOnFlbXUtZGV2
ZWxAbm9uZ251Lm9yZz4NCkNjOiBtYWlsdG86emhhbmcuemhhbmdoYWlsaWFuZ0BodWF3ZWkuY29t
OyBtYWlsdG86cXVpbnRlbGFAcmVkaGF0LmNvbTsgbWFpbHRvOmRnaWxiZXJ0QHJlZGhhdC5jb207
IFpoYW5nLCBDaGVuIDxtYWlsdG86Y2hlbi56aGFuZ0BpbnRlbC5jb20+DQpTdWJqZWN0OiBSZTog
W1BBVENIIHYxIDEvMV0gQ09MTzogb25seSBmbHVzaCBkaXJ0eSByYW0gcGFnZXMgZnJvbSBjb2xv
IGNhY2hlDQrCoA0KSGVsbG8sIGFsbA0KwqANClBpbmcuLi4NCsKgDQpSZWdhcmRzLA0KRGVyZWsg
U3UNCsKgDQpEZXJlayBTdSA8bWFpbHRvOmRlcmVrc3VAcW5hcC5jb20+IOaWvCAyMDIw5bm0Oeac
iDEw5pelIOmAseWbmyDkuIvljYg2OjQ35a+r6YGT77yaDQpJbiBzZWNvbmRhcnkgc2lkZSwgdGhl
IGNvbG9fZmx1c2hfcmFtX2NhY2hlKCkgY2FsbHMNCm1pZ3JhdGlvbl9iaXRtYXBfZmluZF9kaXJ0
eSgpIHRvIGZpbmRpbmcgdGhlIGRpcnR5IHBhZ2VzIGFuZA0KZmx1c2ggdGhlbSB0byBob3N0LiBC
dXQgcmFtX3N0YXRlJ3MgcmFtX2J1bGtfc3RhZ2UgZmxhZyBpcyBhbHdheXMNCmVuYWJsZWQgaW4g
c2Vjb25kYXJ5IHNpZGUsIGl0IGxlYWRzIHRvIHRoZSB3aG9sZSByYW0gcGFnZXMgY29weQ0KaW5z
dGVhZCBvZiBvbmx5IGRpcnR5IHBhZ2VzLg0KDQpIZXJlLCB0aGUgcmFtX2J1bGtfc3RhZ2UgaW4g
c2Vjb25kYXJ5IHNpZGUgaXMgZGlzYWJsZWQgaW4gdGhlDQpwcmVwYXJhdGlvbiBvZiBDT0xPIGlu
Y29taW5nIHByb2Nlc3MgdG8gYXZvaWQgdGhlIHdob2xlIGRpcnR5DQpyYW0gcGFnZXMgZmx1c2gu
DQoNClNpZ25lZC1vZmYtYnk6IERlcmVrIFN1IDxtYWlsdG86ZGVyZWtzdUBxbmFwLmNvbT4NCi0t
LQ0KwqBtaWdyYXRpb24vY29sby5jIHzCoCA2ICsrKysrLQ0KwqBtaWdyYXRpb24vcmFtLmPCoCB8
IDEwICsrKysrKysrKysNCsKgbWlncmF0aW9uL3JhbS5owqAgfMKgIDMgKysrDQrCoDMgZmlsZXMg
Y2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEv
bWlncmF0aW9uL2NvbG8uYyBiL21pZ3JhdGlvbi9jb2xvLmMNCmluZGV4IGVhN2QxZTlkNGUuLjZl
NjQ0ZGIzMDYgMTAwNjQ0DQotLS0gYS9taWdyYXRpb24vY29sby5jDQorKysgYi9taWdyYXRpb24v
Y29sby5jDQpAQCAtODQ0LDYgKzg0NCw4IEBAIHZvaWQgKmNvbG9fcHJvY2Vzc19pbmNvbWluZ190
aHJlYWQodm9pZCAqb3BhcXVlKQ0KwqAgwqAgwqAgwqAgwqByZXR1cm4gTlVMTDsNCsKgIMKgIMKg
fQ0KDQorwqAgwqAgY29sb19kaXNhYmxlX3JhbV9idWxrX3N0YWdlKCk7DQorDQrCoCDCoCDCoGZh
aWxvdmVyX2luaXRfc3RhdGUoKTsNCg0KwqAgwqAgwqBtaXMtPnRvX3NyY19maWxlID0gcWVtdV9m
aWxlX2dldF9yZXR1cm5fcGF0aChtaXMtPmZyb21fc3JjX2ZpbGUpOw0KQEAgLTg3Myw3ICs4NzUs
NyBAQCB2b2lkICpjb2xvX3Byb2Nlc3NfaW5jb21pbmdfdGhyZWFkKHZvaWQgKm9wYXF1ZSkNCsKg
IMKgIMKgIMKgIMKgZ290byBvdXQ7DQrCoCDCoCDCoH0NCsKgI2Vsc2UNCi3CoCDCoCDCoCDCoCBh
Ym9ydCgpOw0KK8KgIMKgIGFib3J0KCk7DQrCoCNlbmRpZg0KwqAgwqAgwqB2bV9zdGFydCgpOw0K
wqAgwqAgwqB0cmFjZV9jb2xvX3ZtX3N0YXRlX2NoYW5nZSgic3RvcCIsICJydW4iKTsNCkBAIC05
MjQsNiArOTI2LDggQEAgb3V0Og0KwqAgwqAgwqAgwqAgwqBxZW11X2ZjbG9zZShmYik7DQrCoCDC
oCDCoH0NCg0KK8KgIMKgIGNvbG9fZW5hYmxlX3JhbV9idWxrX3N0YWdlKCk7DQorDQrCoCDCoCDC
oC8qIEhvcGUgdGhpcyBub3QgdG8gYmUgdG9vIGxvbmcgdG8gbG9vcCBoZXJlICovDQrCoCDCoCDC
oHFlbXVfc2VtX3dhaXQoJm1pcy0+Y29sb19pbmNvbWluZ19zZW0pOw0KwqAgwqAgwqBxZW11X3Nl
bV9kZXN0cm95KCZtaXMtPmNvbG9faW5jb21pbmdfc2VtKTsNCmRpZmYgLS1naXQgYS9taWdyYXRp
b24vcmFtLmMgYi9taWdyYXRpb24vcmFtLmMNCmluZGV4IDc2ZDRmZWU1ZDUuLjY1ZTliMTIwNTgg
MTAwNjQ0DQotLS0gYS9taWdyYXRpb24vcmFtLmMNCisrKyBiL21pZ3JhdGlvbi9yYW0uYw0KQEAg
LTMzNTcsNiArMzM1NywxNiBAQCBzdGF0aWMgYm9vbCBwb3N0Y29weV9pc19ydW5uaW5nKHZvaWQp
DQrCoCDCoCDCoHJldHVybiBwcyA+PSBQT1NUQ09QWV9JTkNPTUlOR19MSVNURU5JTkcgJiYgcHMg
PCBQT1NUQ09QWV9JTkNPTUlOR19FTkQ7DQrCoH0NCg0KK3ZvaWQgY29sb19lbmFibGVfcmFtX2J1
bGtfc3RhZ2Uodm9pZCkNCit7DQorwqAgwqAgcmFtX3N0YXRlLT5yYW1fYnVsa19zdGFnZSA9IHRy
dWU7DQorfQ0KKw0KK3ZvaWQgY29sb19kaXNhYmxlX3JhbV9idWxrX3N0YWdlKHZvaWQpDQorew0K
K8KgIMKgIHJhbV9zdGF0ZS0+cmFtX2J1bGtfc3RhZ2UgPSBmYWxzZTsNCit9DQorDQrCoC8qDQrC
oCAqIEZsdXNoIGNvbnRlbnQgb2YgUkFNIGNhY2hlIGludG8gU1ZNJ3MgbWVtb3J5Lg0KwqAgKiBP
bmx5IGZsdXNoIHRoZSBwYWdlcyB0aGF0IGJlIGRpcnRpZWQgYnkgUFZNIG9yIFNWTSBvciBib3Ro
Lg0KZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9yYW0uaCBiL21pZ3JhdGlvbi9yYW0uaA0KaW5kZXgg
MmVlYWFjZmExMy4uYzFjMGViYmUwZiAxMDA2NDQNCi0tLSBhL21pZ3JhdGlvbi9yYW0uaA0KKysr
IGIvbWlncmF0aW9uL3JhbS5oDQpAQCAtNjksNCArNjksNyBAQCB2b2lkIGNvbG9fZmx1c2hfcmFt
X2NhY2hlKHZvaWQpOw0KwqB2b2lkIGNvbG9fcmVsZWFzZV9yYW1fY2FjaGUodm9pZCk7DQrCoHZv
aWQgY29sb19pbmNvbWluZ19zdGFydF9kaXJ0eV9sb2codm9pZCk7DQoNCit2b2lkIGNvbG9fZW5h
YmxlX3JhbV9idWxrX3N0YWdlKHZvaWQpOw0KK3ZvaWQgY29sb19kaXNhYmxlX3JhbV9idWxrX3N0
YWdlKHZvaWQpOw0KKw0KwqAjZW5kaWYNCi0tIA0KMi4yNS4xDQo=

