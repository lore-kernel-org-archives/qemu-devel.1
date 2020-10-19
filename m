Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5224C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 02:05:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09225222C3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 02:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MMjt9YxR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rkDKY2ub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09225222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUKXn-0004Kk-W0
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 22:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5541069a6=Dmitry.Fomichev@wdc.com>)
 id 1kUKWd-0003MH-Lr; Sun, 18 Oct 2020 22:03:52 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5541069a6=Dmitry.Fomichev@wdc.com>)
 id 1kUKWX-0002f9-Ck; Sun, 18 Oct 2020 22:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603073187; x=1634609187;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mf16LrpFrJnvc9DyIchowsS0Mhgjodl5GTUOGCQ0CnU=;
 b=MMjt9YxRu1jSp0KeU7lYAQVTG8d3sMfxSfYrWssqktEIUV03Xt1A1fwF
 BN9RAOrL5gi4RpSYx6X7eU16ChxmXHENc5k9TRUJVUuU7JgnCQE7CPF02
 rygQfIWfMggPpeg0KP3HHY21Xa6XWJHYE8cdqwZ0f96eiyGjvSPeQpgnc
 Hj9k+r7SBypFcsN9kdQR9kyw4BXRuv7OJbiNHgGjWQ4xgOMzwz3YXp2FB
 61dlwkg9wYm64JARsDGRfG3ZIxA2qDe2xHnAytc4nkmyFI1qJOzMEah3d
 aiFadTfcjNsulkMY9tinbJdgPAJOrnJ185Qwb+d+acsVhZ8f7kfjw9DVG Q==;
IronPort-SDR: DcisiwvjiUl5ApzwG1xANJptjlyv/X+pFipETZrE8OrJvE//+VZvm508KH0cy9xWT0Rs2BfwCK
 ROdkDTTW9tXGhXftC47IDIAjhS/foeP3BiUVIw3XUCKrFigYUj4WhT2/7bo6qBIwbm9U/vgk6x
 KUnaoFjDi7uiIBtaiIdtEJCvrZWxktqh3YGFiFrTdq3+KpGKG6YtGqrKj2KVkbMjUx/zD9y3sK
 bBdLNrMUS1xr7YA6uWj0s0MIf4MZ6yKTO0wW2c/KRvYlnb19jChaULXyaO4KTPs0KHVf8/GSGK
 YxA=
X-IronPort-AV: E=Sophos;i="5.77,393,1596470400"; d="scan'208";a="253767509"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
 by ob1.hgst.iphmx.com with ESMTP; 19 Oct 2020 10:06:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYhdlag0rNJ8A6thLPJwh20PSkDYa5anFwU+vNmcPd7uIfsbZOEFsfh8UFPGxWPjKN3Q+asnlVVic27iBglBMmTh9bi5pmxewNl8ed8GTs2UwtQl72XQ2e2E/QoSyGQZvcqhqAxZt1N/BFIe6cORxFxpdTJl22OJVkyXJZA3Ne6bDEnbMMp+EnkGQsYEcmLzojWdlWL/aw4Z+UXHZM8QDwFjJiyZjJOdh75feVjlem8BoVhJcGCAafBf9Clarr+iwXtTY2mjleXkKu/ms/rj3DgBz9j3y1m3IiEuieZX4jaWCaGziiVXQlNG5/dCyE3AOoBmZQKGM4cX37rrZlAIdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEZuSr8CDi7cLVRKRYcvx3vEVem3QgKxQyk5xnQNJms=;
 b=a3NxY9/TSiIQTTdcwbDPzI5Kyr3xpCD+7Q1LA6R26U0TtsAvK453rm8Ut2BkV7cw9fXct1m7IuXGuN5Z1M10s6lHXJkxF6oVpkZvuRUCYEOnTv5JjWnyZxU7u4ovO4pZcbQRQ5N3NjbVx/Q+mD6clWPNRaCrECVufhl30DY8ucxKR3P8SQTx+rXmseWJyKU3FQ1ZgVc3rKtFnfw3Qzpckn+ym+MZIqdq8dIfhNHOrrAcvXXz3JsST0GSMO8xhujWQGdQas6bTMAR/aiYr8Zbz/euvYdhCD8dUHFYN5rSicn3vowgSzloevB5/4pFS87FXVZEh9oBDx8LoQ5f0P6dbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEZuSr8CDi7cLVRKRYcvx3vEVem3QgKxQyk5xnQNJms=;
 b=rkDKY2ub5iZnvBtf2Y+/cxJkSuFTwnKiH9304s4Ko8TIfPMt4HAzUGoZQa34FJzGXRQoyBS2eISkK0e6n2Xfs6ZZtPBS93vGSR00oG5BBglAfRmlj6YB8N7sdKo69IG9ME2MDnMjTaKWmIIHOlQJrG75OVkz7T30VYGHAMCnbhE=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5919.namprd04.prod.outlook.com (2603:10b6:208:a2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Mon, 19 Oct
 2020 02:03:41 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44c9:85df:4910:44d8]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44c9:85df:4910:44d8%4]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 02:03:41 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: RE: [PATCH v6 03/11] hw/block/nvme: Add support for Namespace Types
Thread-Topic: [PATCH v6 03/11] hw/block/nvme: Add support for Namespace Types
Thread-Index: AQHWoam/0gRDDmJrJUOFtnVAaAlNg6mXEOqAgAbxZRA=
Date: Mon, 19 Oct 2020 02:03:40 +0000
Message-ID: <MN2PR04MB5951924C8B5AC2805744E7F4E11E0@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20201013214212.2152-1-dmitry.fomichev@wdc.com>
 <20201013214212.2152-4-dmitry.fomichev@wdc.com>
 <20201014130124.GA133631@localhost.localdomain>
In-Reply-To: <20201014130124.GA133631@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a8792aae-2ff0-4de1-50b6-08d873d3336d
x-ms-traffictypediagnostic: MN2PR04MB5919:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB5919E81337762E6F1172AC96E11E0@MN2PR04MB5919.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xoYGkr5PI3c1gA1Y5EMTQbPYW1d6QGv74c2qyjFzwyG0blgqxmMGZ82kxQJDe6TxDkV7I6GjM7DRu5/irpoTHQ9WLVO0HA7pRkEOl/r1XFO9c8VngN0VRq1p/0UWI3wafP01Sm39lVESauc9j6KBMKAcARvyPWPuRAwAoGo0MGD91/6hcQc7+PlMAnneT++k+6tH2tXBA3daO6hSEsXa8+rong4bhalUkiDA2rGr1SzSyECG1BO90E5sPnnZaRVfdYZPODe8lxaASdv2Us5rZzn/ZqwNXNHyndUrqf5Ygl4LvQw1HN/Ty7RQM1THO2F3Mr4TRH+EcGzcjAdGhh9Iaw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(76116006)(66476007)(66446008)(66946007)(64756008)(66556008)(6862004)(26005)(4326008)(186003)(7696005)(6506007)(53546011)(8676002)(8936002)(52536014)(9686003)(5660300002)(55016002)(54906003)(6636002)(71200400001)(33656002)(478600001)(86362001)(2906002)(83380400001)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: rE81B9xVAqgNfePFL21QPsgvFrP9ok9cTvrW00jJmSQ6B4r1HkQXFyio290hFMAcvP70jyk/EYGBHdEV7xpc7MlqQdexti3PVsp4Z+sqhJJjGTRL3rsLcN1I1Vz1uZvfutkX/3dDHgTZV7uyaL83p/bvH/GbQSersVIEowafVdu42Cuu7oufpWYua3xyY3osbzcUxnnHuhnPjUrdQdT0pbpc6Fms+/XJC1YIQ6t05in/2QsaTlSHn4XQ/Ao7B/NuaoqwaqFO6yza3u5V/WZV/6oNpe/q6pOquUSBuyNLQR7FFnq+PtAtmNRViALCRMnpFLWWtvMU9v/o/lgCzDSxQ6E/2snVA62aT8Vw2jtsbeTofyxcjPW2R+80OTo2fniu+9OsxVx9eUpXIO98CJ/co/tOaqWEt79OsICDWEz0b9AFVg8lY2axz9hEiMDkhDHC99f41VUTbZ0Aiu0pm9wz+SAilCn/qZuQLx03zIhLMBFiE6tlfvlNur11TevOkNnbsZTXqiUTnkuSaCoW/hHnG0PbgPJwUxPkb1darQfCvvCdjdGMp3tNYQi/L64V1akFbAx/PEtgItEGGcPJVIuZ/M4p6fvxiHtfEEHl7Z0M6MUse4HKtj2jDsaIhZlDKWQWnnn+quYHfPOg7+8V2GUlfw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8792aae-2ff0-4de1-50b6-08d873d3336d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2020 02:03:40.9082 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: paRHBJ5pylO/hQ/eWa1zkfnYt+LwHtEbiMBoPn46ZFdNbdmkBDyOin7Hg+bKeT2DBfad32dR4gjRfhgayAFYIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5919
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=5541069a6=Dmitry.Fomichev@wdc.com; helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 22:03:43
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Niklas Cassel <Niklas.Cassel@wdc.com>
> Sent: Wednesday, October 14, 2020 9:01 AM
> To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
> Cc: Keith Busch <kbusch@kernel.org>; Klaus Jensen
> <k.jensen@samsung.com>; Kevin Wolf <kwolf@redhat.com>; Philippe
> Mathieu-Daud=E9 <philmd@redhat.com>; Maxim Levitsky
> <mlevitsk@redhat.com>; Fam Zheng <fam@euphon.net>; Alistair Francis
> <Alistair.Francis@wdc.com>; Matias Bjorling <Matias.Bjorling@wdc.com>;
> Damien Le Moal <Damien.LeMoal@wdc.com>; qemu-block@nongnu.org;
> qemu-devel@nongnu.org
> Subject: Re: [PATCH v6 03/11] hw/block/nvme: Add support for Namespace
> Types
>=20
> On Wed, Oct 14, 2020 at 06:42:04AM +0900, Dmitry Fomichev wrote:
> > From: Niklas Cassel <niklas.cassel@wdc.com>
> >
> > Define the structures and constants required to implement
> > Namespace Types support.
> >
> > Namespace Types introduce a new command set, "I/O Command Sets",
> > that allows the host to retrieve the command sets associated with
> > a namespace. Introduce support for the command set and enable
> > detection for the NVM Command Set.
> >
> > The new workflows for identify commands rely heavily on zero-filled
> > identify structs. E.g., certain CNS commands are defined to return
> > a zero-filled identify struct when an inactive namespace NSID
> > is supplied.
> >
> > Add a helper function in order to avoid code duplication when
> > reporting zero-filled identify structures.
> >
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> > ---
>=20
> (snip)
>=20
> > @@ -2090,6 +2199,27 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
> >      n->bar.cc =3D 0;
> >  }
> >
> > +static void nvme_select_ns_iocs(NvmeCtrl *n)
> > +{
> > +    NvmeNamespace *ns;
> > +    int i;
> > +
> > +    for (i =3D 1; i <=3D n->num_namespaces; i++) {
> > +        ns =3D nvme_ns(n, i);
> > +        if (!ns) {
> > +            continue;
> > +        }
> > +        ns->iocs =3D nvme_cse_iocs_none;
> > +        switch (ns->csi) {
> > +        case NVME_CSI_NVM:
> > +            if (NVME_CC_CSS(n->bar.cc) !=3D NVME_CC_CSS_ADMIN_ONLY) {
> > +                ns->iocs =3D nvme_cse_iocs_nvm;
> > +            }
> > +            break;
> > +        }
> > +    }
> > +}
> > +
> >  static int nvme_start_ctrl(NvmeCtrl *n)
> >  {
> >      uint32_t page_bits =3D NVME_CC_MPS(n->bar.cc) + 12;
> > @@ -2188,6 +2318,8 @@ static int nvme_start_ctrl(NvmeCtrl *n)
> >
> >      QTAILQ_INIT(&n->aer_queue);
> >
> > +    nvme_select_ns_iocs(n);
> > +
> >      return 0;
> >  }
> >
> > @@ -2655,7 +2787,6 @@ int nvme_register_namespace(NvmeCtrl *n,
> NvmeNamespace *ns, Error **errp)
> >      trace_pci_nvme_register_namespace(nsid);
> >
> >      n->namespaces[nsid - 1] =3D ns;
> > -    ns->iocs =3D nvme_cse_iocs_nvm;
> >
> >      return 0;
> >  }
>=20
> Considering how tightly coupled the three above diffs are with the
> Commands Supported and Effects log, and since patch 1 already adds
> the ns->iocs checking in nvme_admin_cmd() and nvme_io_cmd(),
> and since these three diffs are not really related to NS types,
> I think they should be moved to patch 1.
>=20
> It really helps the reviewer if both the ns->iocs assignment
> and checking is done in the same patch, and introduced as early
> as possible. And since this code is needed/valid simply to check
> if ADMIN_ONLY is selected (even before NS Types were introduced),
> I don't see any reason not to introduce them in to patch 1
> together with the other ns->iocs stuff.
>=20
> (We were always able to select a I/O Command Set using CC.CSS
> (Admin only/None, or NVM), NS types simply introduced the ability
> to select/enable more than one command set at the same time.)
>=20

OK, perhaps it is better to introduce nvme_select_ns_iocs() earlier,
in the CSE Log patch. This way there will be no need to modify
nvme_start_ctrl() again in this patch. Since ns->csi is not defined
until this commit, the initial code for nvme_select_ns_iocs() will
be simpler.

>=20
> Kind regards,
> Niklas

