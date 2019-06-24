Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAD_ENC_HEADER,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6417BC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 14:02:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3149520820
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 14:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IKsT9Unz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3149520820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51424 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfPXm-0006f2-78
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 10:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44835)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rkagan@virtuozzo.com>) id 1hfPSJ-0001HI-Iw
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rkagan@virtuozzo.com>) id 1hfPSI-0004qX-K4
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:56:23 -0400
Received: from mail-bgr052101135048.outbound.protection.outlook.com
 ([52.101.135.48]:46977 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
 id 1hfPSG-0004j3-9n
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOZZQe8qSqcBDnTrWpMCHc9KhtWHYFks342NGKUlEgU=;
 b=IKsT9UnzrHEvDbMgaAy3akmeeYdTwJVc6p/UJJNr10ZdqG6TczFUUIKiy9jB/qRIPIMPYvKL3kNPvAgnYUs87GmfyXOXbXnMg2MBwP+3jArCkKsDiimRvQmCoj5wOtSna0pdFlT+ArDJHm1V30X2BOL9gMKRoeOIiAg1JqXzNUI=
Received: from VI1PR08MB3981.eurprd08.prod.outlook.com (20.178.126.10) by
 VI1PR08MB3216.eurprd08.prod.outlook.com (52.133.15.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 13:56:10 +0000
Received: from VI1PR08MB3981.eurprd08.prod.outlook.com
 ([fe80::70f3:9c8:b21:58]) by VI1PR08MB3981.eurprd08.prod.outlook.com
 ([fe80::70f3:9c8:b21:58%5]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 13:56:10 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Thread-Topic: [PATCH] target/i386: fix feature check in hyperv-stub.c
Thread-Index: AQHVKonHdWlzk0C+XUaoVDKJqx3fE6aq1BCA
Date: Mon, 24 Jun 2019 13:56:10 +0000
Message-ID: <20190624135607.GA2457@rkaganb.sw.ru>
References: <20190624123835.28869-1-alex.bennee@linaro.org>
In-Reply-To: <20190624123835.28869-1-alex.bennee@linaro.org>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.12.0 (2019-05-25)
mail-followup-to: =?iso-8859-1?Q?Roman_Kagan_<rkagan@virtuozzo.com>,
 =09Alex_Benn=E9e_<alex.?=
 =?iso-8859-1?Q?bennee@linaro.org>,=09peter.maydell@linaro.org,_qemu-devel?=
 =?iso-8859-1?Q?@nongnu.org,=09Vitaly_Kuznetsov_<vkuznets@redhat.com>,=09P?=
 =?iso-8859-1?Q?aolo_Bonzini_<pbonzini@redhat.com>,=09Richard_Henderson_<r?=
 =?iso-8859-1?Q?th@twiddle.net>,=09Eduardo_Habkost_<ehabkost@redhat.com>?=
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR02CA0108.eurprd02.prod.outlook.com
 (2603:10a6:7:29::37) To VI1PR08MB3981.eurprd08.prod.outlook.com
 (2603:10a6:803:e0::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71069648-3cc0-4afb-0785-08d6f8abb62d
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3216; 
x-ms-traffictypediagnostic: VI1PR08MB3216:|VI1PR08MB3216:
x-microsoft-antispam-prvs: <VI1PR08MB3216CCBE048E731B7F7372F7C9E00@VI1PR08MB3216.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39840400004)(199004)(189003)(6246003)(14454004)(5660300002)(71200400001)(52116002)(71190400001)(66946007)(53936002)(186003)(446003)(316002)(7736002)(486006)(476003)(229853002)(66476007)(8936002)(6436002)(66446008)(25786009)(66556008)(86362001)(64756008)(76176011)(73956011)(81156014)(1076003)(8676002)(6512007)(9686003)(81166006)(6506007)(99286004)(386003)(14444005)(66574012)(6486002)(305945005)(26005)(102836004)(66066001)(6916009)(3846002)(6116002)(54906003)(11346002)(33656002)(58126008)(36756003)(4326008)(2906002)(478600001)(68736007)(256004)(30126002);
 DIR:OUT; SFP:1501; SCL:5; SRVR:VI1PR08MB3216;
 H:VI1PR08MB3981.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AWv0uTkHj1OXZmMlnEPxPrz+CxY5WwRD+ysx3LnlPdYX9TEDRZJ55U3haKfLI0FNAeiX5N62EOMvEFZ0MUhZMIl5UNr7qfKS4Kj5upLHHTZ8ynkymHWwFgSv21C1fTsrArkVPRgqwYecjT6Y6cJ6IYnS4zqbm8BKrFn/tJulKf+QuR5I+NGGdo+oPSLzUaCpT7RmKFDUIqZkOlNjLT/sFvhcY3reFi+WlNCp7uqyWpMSvs3axT5pZyUNOaXSMnP1Zf2e3HC6QjPPXuMhxFKzqoEdXjXGyvevKG10U/NgutE3MU7cYLjx1xHECBLK/7Bav/C98L822EgyMwFd2OAOidagXXQ22FXouPCvoZmMFWMwgGRZCpKbxA1pHjcx+w2xS2btXXYDJRkkqRWWTKEWPjHznJLMu3IcDtRhVyVYq87Qk9t2pkDzkJg5TjH7SllMM2+fBFwgfDyCUPmwEVGF37DJpcea8SI6msdYYpi7WREWj7mgYQtYTqQHHXja3zgR
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <8CCB7F646F3C5B47BF6EE330BDC64F4E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71069648-3cc0-4afb-0785-08d6f8abb62d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 13:56:10.1982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkagan@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3216
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.135.48
Subject: Re: [Qemu-devel] [PATCH] target/i386: fix feature check in
 hyperv-stub.c
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 24, 2019 at 01:38:35PM +0100, Alex Benn=E9e wrote:
> Commit 2d384d7c8 broken the build when built with:
>=20
>   configure --without-default-devices --disable-user
>=20
> The reason was the conversion of cpu->hyperv_synic to
> cpu->hyperv_synic_kvm_only although the rest of the patch introduces a
> feature checking mechanism. So I've fixed the KVM_EXIT_HYPERV_SYNIC in
> hyperv-stub to do the same feature check as in the real hyperv.c
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Roman Kagan <rkagan@virtuozzo.com>
> ---
>  target/i386/hyperv-stub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>

>=20
> diff --git a/target/i386/hyperv-stub.c b/target/i386/hyperv-stub.c
> index fe548cbae2..0028527e79 100644
> --- a/target/i386/hyperv-stub.c
> +++ b/target/i386/hyperv-stub.c
> @@ -15,7 +15,7 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_e=
xit *exit)
>  {
>      switch (exit->type) {
>      case KVM_EXIT_HYPERV_SYNIC:
> -        if (!cpu->hyperv_synic) {
> +        if (!hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC)) {
>              return -1;
>          }
> =20
> --=20
> 2.20.1
>=20

