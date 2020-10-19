Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8975C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 02:04:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE7F222C3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 02:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NbFW0hpo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OrXl6giV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE7F222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUKXD-0003JM-P2
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 22:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5541069a6=Dmitry.Fomichev@wdc.com>)
 id 1kUKVF-0002L6-2Q; Sun, 18 Oct 2020 22:02:25 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:13660)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5541069a6=Dmitry.Fomichev@wdc.com>)
 id 1kUKVC-0002bM-Hq; Sun, 18 Oct 2020 22:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603072943; x=1634608943;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=meLyf5aRFgjb8+plE3Qg00eZUGIALklzvCLA70JDVak=;
 b=NbFW0hpomhCd4cHHS16puAzKkaAchbIHEO6OZ/R4Ozz/ij2panCkMiEH
 1merEzY9yc1Ic6s6yJlS9NMiTsxpy2oySlUpxzuxPA7j+EnZf6vdBIeBi
 c4wgfFRpz7ujuQasBc5+9F1Xl/JyQcxkefOs/bHRJqZxhX6l+Bc23iHHo
 NGjnv6Pmgo5ttZedqOgfyIuOPXPFLGfI6n+YoL2G9Op6lcmRIepgjip05
 0bBBZEPxxgemy+cr6rPnUVHi0GiYqlILJjYLi0Snl8N+3rtyAMHctaAx1
 S7Ues1ElSD5HG788h+x22o2WnUuzMP9xdKCPiNI5ldqKN7q6A4nmXffkZ Q==;
IronPort-SDR: yI4wJJwXJ0LATq0hEXH5HBkufcNosTu+2cAecWy3IZFIu11UChSN7e6TJ9fNs79BaPYUdIuDpa
 qs5vobKQ1Vdsj4Iqh7X1kIoXWkELEGvfjx+8rLShDAIkPRx+/9tiVdBdayVY6EBLho9XmIArA5
 9lolLqrQyV9PpAQFw41fXIshM7FsfczKkwP6AD4/q0ly83frG/IXUQ3z5GCbTuWm4+CAVvHv6U
 coPlFwTYX5pZz21una3jKw1qX6oRMdlXtyaUz54ZgbObS/DUgsRODNTVnDMPZF0fID7ZKSIy7E
 qEY=
X-IronPort-AV: E=Sophos;i="5.77,393,1596470400"; d="scan'208";a="154713354"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
 by ob1.hgst.iphmx.com with ESMTP; 19 Oct 2020 10:02:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gaf9RtGn0IlApQ7YbEapWMQTARdSTnPLwnRNqqGMRrehlO4VnWZKwA+EgSvTUYZQHzpnC5XgF0SV+7IgRL4MwDODiXkllUjqosdh6zV2kSQScoXq3CFqgwSqbzfmnDE4gSlmFIHyi5mjyF47finRGIqTcmfN0BlpPIx2jy8a7QNrRzXlhOPety35P6LC8boRCd6XL9WqU9nI73s782b4STj3+Ld/HJmugm3b0o/KVVBHzZkKnCrKkFc9K9lglSohJkwiP11xSh2o5dagBqbj/Wm4TMnN3qpMkwnu5Fe94czDD6JAhLzckdE1//c6XYGBOSjRld2Tw1HVZ5z5Cd1eCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPuibU+e6OSzRopBFdPl8Kcqq1ncPdQlhkRcY/Ml3Og=;
 b=ND7uW2wG/H5PFsdmhpeTDdBVqm8qpnCpviT11hbWiXAjIOIAZS81KiTEZQ/D0zz7BKh96pkecNnr8zFGpSxKzrDJD9T/xTVyxKK9Qc5OyWYo56Rg6DsHH44Iy7+zfe4HredOyazYdhujGkERH75/Ki0XVcUIYylXGQE5zd2aemoSlCuT6EWEQ8LwVLPcTwh4lFlr0RgkJMpCN3lGqbAvSoJBhPfIHg/c+rjERWK2C0Xmi7Uy+MpcbiXeVkAjmp7nVBHrSZz16dGF8aNslQMPio5l7268/PGJD07JN4PTWgRM+54z1l7CwmHzNQwPDpTmxXNMgra/EoxbMiepn7n5rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPuibU+e6OSzRopBFdPl8Kcqq1ncPdQlhkRcY/Ml3Og=;
 b=OrXl6giV/CJcao1OMercAHdSvd/lOoIqpdTNU8E0wFoEC/098qJtsfQIyj/RYKn8vkfdLg5Ys5ItvTzZQwBFZ4YSwyIFyXu+aWY25W1wTwbCeovSZDYLGMzRltsce4aRmExCt9iJKKQo6ZUgibT0/qIsMHJVuLYu/LXACtMDHSw=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5919.namprd04.prod.outlook.com (2603:10b6:208:a2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Mon, 19 Oct
 2020 02:02:16 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44c9:85df:4910:44d8]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44c9:85df:4910:44d8%4]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 02:02:16 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: RE: [PATCH v6 05/11] hw/block/nvme: Support Zoned Namespace Command
 Set
Thread-Topic: [PATCH v6 05/11] hw/block/nvme: Support Zoned Namespace Command
 Set
Thread-Index: AQHWoanCcoGGSGgkV0uIzMkJ+CA7V6mW/38AgAcG74A=
Date: Mon, 19 Oct 2020 02:02:16 +0000
Message-ID: <MN2PR04MB59517B981B58CB9E5AFB07D7E11E0@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20201013214212.2152-1-dmitry.fomichev@wdc.com>
 <20201013214212.2152-6-dmitry.fomichev@wdc.com>
 <20201014115903.GA122299@localhost.localdomain>
In-Reply-To: <20201014115903.GA122299@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fbe128bb-5e40-430e-62fe-08d873d300e8
x-ms-traffictypediagnostic: MN2PR04MB5919:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB5919FD05F703CDCDEF8F297BE11E0@MN2PR04MB5919.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BJzyR/KdRnn9Jityt12ZFoWT7IMlU7TRpan1J8S8kRfqXcTcmEviBVUnsoMMnNaQami2lILHe2DjzYiDt+RPeZCfob8VeSgvY/Ic61CuinwEA1JYg/fvXdNyrDwDNSMLE2tG6it1tR54eMtIk5HfGJGxxzfRiZ4Mdn63w2QxYxF+ypj7JOHheClsCUO+E+3myI6jx0F0AqpcHtNAWwUa2T8tVXvn/AISXHvEo9VOXaEbRHMi/sGEq4jAytsaOe3LXqOn7IfNjMlo06RfQEWKZwxvnlq/6dkDXAPU/2nHTHOTAI4AamgEQyZV+OMf29oJoT9a2sDzDc+f/W7u7yotGQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(76116006)(66476007)(66446008)(66946007)(64756008)(66556008)(6862004)(26005)(4326008)(186003)(7696005)(6506007)(53546011)(8676002)(8936002)(52536014)(9686003)(5660300002)(55016002)(54906003)(6636002)(71200400001)(33656002)(478600001)(86362001)(2906002)(83380400001)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: aQG3DKljb5jGAhcIFMOIz/9d02IzOZLYglDA9xjbik6yhDQIhhI6DiMmiF7wrRUD0xs01/wO9kPlsd66/asx8yU1AjSlHf+ULmtksx+ax4fVbVsekPeR3Tk8Q9NmjHjIVBkT/6PXKCweEP1zS6RYU5B8qL7PMwyYZfmPDky/mzN7Mf3CtCRjAmi1+J1i5mgY15FiNR9cLYX9qi7M0XtAf1M8xMajXeryHGKayCogMem1kDTw57Wnkq4CthuZtlov6/R+hiCYOSn5gm1OJ9r+ZBJfYQ7pe2Lprrkr2n0cS8Hb7fO9IHKLHDUNM03IA0y38jePrjmDStu5n0MQkzewzsb1SHj7vDCBdodWGR9h3rRWTpZVC89EOXrW6LkMaHtSmE+GuC3MuEYbtQAJ5He6kk5P4NoXAMsaLxtiwbrwbjAZVC1nUkY+BKI4F+oacRnn/RaJJ6ayc5at3Oh5EeDSAir27k49uH6hHQumC+EnxiGD+QqAzqGyXFTngxu1svSMCGVPFAko65xTgHZukhZaBHq+3wjZxIPBu/+eQbCz/S6QltuRZ3uRojJSKj6FpcI5UP4m/HHi2EjCDxugIN1i5Q7EmfhnIcEhaE6rUF5TwnvC+szWViaZxeVjtz+iQVsaDHo0o5ks6kpLjFwDs4cj4w==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe128bb-5e40-430e-62fe-08d873d300e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2020 02:02:16.1509 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XdzKoSjYac98oxT1bctg6UhqFQgdakGrVH7fKy87rY0a6Q2v7w6ix3T3jlM0X11R1158h9LwsyLvUCicnqcc/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5919
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=5541069a6=Dmitry.Fomichev@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 22:02:18
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
> Sent: Wednesday, October 14, 2020 7:59 AM
> To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
> Cc: Keith Busch <kbusch@kernel.org>; Klaus Jensen
> <k.jensen@samsung.com>; Kevin Wolf <kwolf@redhat.com>; Philippe
> Mathieu-Daud=E9 <philmd@redhat.com>; Maxim Levitsky
> <mlevitsk@redhat.com>; Fam Zheng <fam@euphon.net>; Alistair Francis
> <Alistair.Francis@wdc.com>; Matias Bjorling <Matias.Bjorling@wdc.com>;
> Damien Le Moal <Damien.LeMoal@wdc.com>; qemu-block@nongnu.org;
> qemu-devel@nongnu.org
> Subject: Re: [PATCH v6 05/11] hw/block/nvme: Support Zoned Namespace
> Command Set
>=20
> On Wed, Oct 14, 2020 at 06:42:06AM +0900, Dmitry Fomichev wrote:
> > The emulation code has been changed to advertise NVM Command Set
> when
> > "zoned" device property is not set (default) and Zoned Namespace
> > Command Set otherwise.
> >
> > Define values and structures that are needed to support Zoned
> > Namespace Command Set (NVMe TP 4053) in PCI NVMe controller
> emulator.
> > Define trace events where needed in newly introduced code.
> >
> > In order to improve scalability, all open, closed and full zones
> > are organized in separate linked lists. Consequently, almost all
> > zone operations don't require scanning of the entire zone array
> > (which potentially can be quite large) - it is only necessary to
> > enumerate one or more zone lists.
> >
> > Handlers for three new NVMe commands introduced in Zoned Namespace
> > Command Set specification are added, namely for Zone Management
> > Receive, Zone Management Send and Zone Append.
> >
> > Device initialization code has been extended to create a proper
> > configuration for zoned operation using device properties.
> >
> > Read/Write command handler is modified to only allow writes at the
> > write pointer if the namespace is zoned. For Zone Append command,
> > writes implicitly happen at the write pointer and the starting write
> > pointer value is returned as the result of the command. Write Zeroes
> > handler is modified to add zoned checks that are identical to those
> > done as a part of Write flow.
> >
> > Subsequent commits in this series add ZDE support and checks for
> > active and open zone limits.
> >
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> > Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
> > Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > Signed-off-by: Matias Bjorling <matias.bjorling@wdc.com>
> > Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
> > Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
>=20
> (snip)
>=20
> > @@ -2260,6 +3155,11 @@ static void nvme_select_ns_iocs(NvmeCtrl *n)
> >                  ns->iocs =3D nvme_cse_iocs_nvm;
> >              }
> >              break;
> > +        case NVME_CSI_ZONED:
> > +            if (NVME_CC_CSS(n->bar.cc) =3D=3D NVME_CC_CSS_CSI) {
> > +                ns->iocs =3D nvme_cse_iocs_zoned;
> > +            }
> > +            break;
> >          }
> >      }
> >  }
>=20
> Who knows how this whole command set mess is supposed to work,
> since e.g. the Key Value Command Set assigns opcodes for new commands
> (Delete, Exist) with a opcode values (0x10,0x14) smaller than the
> current highest opcode value (0x15) in the NVM Command Set,
> while those opcodes (0x10,0x14) are reserved in the NVM Command Set.
>=20
> At least for Zoned Command Set, they defined the new commands
> (Zone Mgmt Send, Zone Mgmt Recv) to opcode values (0x79,0x7a)
> that are higher than the current highest opcode value in the
> NVM Command Set.
>=20
> So since we know that the Zoned Command Set is a strict superset of
> the NVM Command Set, I guess it might be nice to do something like:
>=20
> case NVME_CSI_ZONED:
>     if (NVME_CC_CSS(n->bar.cc) =3D=3D NVME_CC_CSS_CSI) {
>         ns->iocs =3D nvme_cse_iocs_zoned;
>     } else if (NVME_CC_CSS(n->bar.cc) =3D=3D NVME_CC_CSS_NVM) {
>         ns->iocs =3D nvme_cse_iocs_nvm;
>     }
>     break;
>=20
>=20
> Since I assume that the spec people intended reads/writes
> to a ZNS namespace to still be possible when CC_CSS =3D=3D NVM,
> but who knows?

Yes, I think it should be this way, thanks. Now it is matched with what
CSE log reports in this case.

>=20
>=20
> Kind regards,
> Niklas

