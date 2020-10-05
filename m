Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A26C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 23:09:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BFC2207F7
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 23:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gYuY7kxR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hXtCcRiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BFC2207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPZbX-0003Tn-Bc
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 19:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=540393388=Dmitry.Fomichev@wdc.com>)
 id 1kPZaV-0002wQ-Bs; Mon, 05 Oct 2020 19:08:11 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:35115)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=540393388=Dmitry.Fomichev@wdc.com>)
 id 1kPZaS-0004FA-8U; Mon, 05 Oct 2020 19:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601939552; x=1633475552;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/dk46JaHv3ADShHGhLDbqs7r7Y17GabFOe4ROljpQT0=;
 b=gYuY7kxRMhvBQRvq2LsZiYrpsiWXFe1+/F8H1c+G/M2LnwXhoHI0eG1K
 chZnZ37w/oDNMbPO10Lo+1P4mueJRKh1KX2w31OqPS3tnevbIsXvPDkrH
 FMaA3zbPxO8JoJUaSbVmNuheszccgnxyMogq0J0BvAjFcZ2/gNo9rmfGp
 mD15xTonerPnqtz3Bv/pOKGdoNiwQDLSKr+iKRZDpU9GQTnbDSxd9yoqM
 xiwDAXQ+YIZJRGdnQyEMMuORzUkYW9pUMDh4J2jrsR51w9v/5T++ZCGIb
 hm+SYDfJN+cczS56pkc0Igwhyao1y9up0H65Zug7LSw3J4RpaXZjpD84p A==;
IronPort-SDR: 27vleCV+s/TrvSOTnl+urVRboNIlpJ69pYr8ozSEpwkjXcbhzNY10IwcjNPg4B5cA63hUC/ArO
 poEdUJaQT5FB9O2jdZU2iK4whUP6Ar6kVhX6FOnh1du8KNxwsP1HU62j9nyZ/k663Q1atTl1jc
 mrxXFKgATq2k53YjsfRW/IySyn4k2Qvw45E6JMqFMWTLLuTw9kOJcIgC8WFbV/n1lpGFSdpZuz
 stMoleOo3ZlSjE0OXpUFUxeXk9/kjq86XSB0Xnrj9vHczda/dzuXp/RSv5QfWLS05glk2wexqe
 3B0=
X-IronPort-AV: E=Sophos;i="5.77,340,1596470400"; d="scan'208";a="252541873"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
 by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2020 07:12:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCpWsc+ZkYubl4JNVvgbyy4S66V1Z90ESX4uh1+06320cZpNIJWGl7XfuPNWfLvM8pXlSDDxJn4VfLQdgMtn7eWGt7MCeYxp390Cq5Xd12G7cvaBOKDsfWVhppz0J9Nf8KVdZ3H5ME5v3FMPsLX6aM616Bbnh+2OmXLbcErTM7jMUjsxC/pIKt/qOjgoEgIxO7kMy8yt4sEqoNocC1384t9TUxOYLUp8MEPwqN5E3TSNXXO3IdASc/KEtMSzu5pR8teb6Mto3XPQZvJ/wDUZ5hkobKaAlrX6MTxnsSPPHt+jsQfl5/Ixu03QW6lJj6Dl/u3Mk8W+5Oleje7y5CcLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayOoPC5GgTtDNs+UYgC27JOqTGGtOgaU/vnoRpVNvto=;
 b=h78pIw3a9qieDGW4UyIEwQlOXWNYfAVKFOAk1by+uPaVeyrHCi0dQzElN1ZzZRuMM1D0FJ8RIerxd2QvFUvi8pe0O7cFDjIapNWMbhKeLYS5YCjHezEoubwC3z6fCvVJfEM4PvA5Z2+FPg6PkIFbSx9z6S+4OGr82/XZKzRbqZW5KAMYUDyOWaLL05J5Hyeb4y8+NIHdyB6N3PLgjiY00p4xvdmcJ6fwNFb79IPee3k63ERxZRVo8UtGHU9DodnnN03HMRuq+YFuSDtAzAhj+abOwFZ35gaSxK8z+8PljVWfvgB53H8LfEx6kKjXdqjJeAQRnIUjwxD8erua9KYO1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayOoPC5GgTtDNs+UYgC27JOqTGGtOgaU/vnoRpVNvto=;
 b=hXtCcRiDN7LRM9Ea0ruiTeilVNYBx7Od9gGowQKawSOjnTtdkY/a9QodcRHDCDKfrhalZeLyHmbLhfabCswc7ArQhgbD4K8ZFwz+EVF4gBfjxC7gLdZcshsPniGNsOR6SPkPgm5DMeMSUuFBSs4SWSgnx0THmHJaiaL8sycCWnE=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB6205.namprd04.prod.outlook.com (2603:10b6:208:d5::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Mon, 5 Oct
 2020 23:08:02 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94%6]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 23:08:02 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: RE: [PATCH v5 09/14] hw/block/nvme: Support Zoned Namespace Command
 Set
Thread-Topic: [PATCH v5 09/14] hw/block/nvme: Support Zoned Namespace Command
 Set
Thread-Index: AQHWlUAbR7szI/vjI0exN9wB2mxOtqmBR4WAgAbiGwCAAMS0AIAAf3yQ
Date: Mon, 5 Oct 2020 23:08:02 +0000
Message-ID: <MN2PR04MB5951879010370AA4D2B63B26E10C0@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
 <20200928023528.15260-10-dmitry.fomichev@wdc.com>
 <20200930145016.GB204568@localhost.localdomain>
 <081017a7953a91ddabe05b472f74713453d479ea.camel@wdc.com>
 <20201005114106.GC387917@localhost.localdomain>
In-Reply-To: <20201005114106.GC387917@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2c6ee117-7d3d-43b2-84d4-08d869838274
x-ms-traffictypediagnostic: MN2PR04MB6205:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB62059FEC29F98411CC96B1C1E10C0@MN2PR04MB6205.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eydgDPiot7t+YQ9bs1GuBNrcISHgKre1bqc1VKovtwRExwRkNTBWsbeaboHuGSzdxHddvYRZyahLtTUBSi4cDaIOwHv8wZGq3OPKe0Fk3xbQWPNVnD/EwqWX8yfzaJ7vjNNlE1gmL4ostD3O0Hn+RnasKZ5nXoVDQ5g0T1aYAAaniP1efuNZugRPynFlEemfhU9TkGsmbbpwMs7woCnyQVBN1efH2Cuj1poE1nyrFp34K2CFtzzXko58Hs4HErK9L2BnVuMZ1Gs9oeCQx3JpdvHNitC1D4cmZHrtaDeczhCM/b2asdcP0pOo8ktl30eU+K/EQBkTpkP1eAOt+mN+2Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(478600001)(7696005)(316002)(6636002)(71200400001)(4326008)(86362001)(6506007)(54906003)(53546011)(66946007)(66446008)(64756008)(66556008)(186003)(66476007)(33656002)(9686003)(76116006)(8676002)(2906002)(26005)(8936002)(5660300002)(6862004)(83380400001)(52536014)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: xqPMexNEeYCzPYI8YzSgOyclUBq19Aaz75i+4Xz5iM6UBW+Qdsoi6z2RHs9ZpIlNyFK4l/dLk+5zJ6UPw9WgrB7zsUiLMDaV9Od+eZu4NrFbepsx9fL3tnQa5dUcGz+AEVabHrA544oLNP8emetypMprQLHvLotw0BBOwJ0zRszNxjHxG2pKxu9IskTgrX1kfPMXLrKGJfzH+fiCY0daDPPYWmjmWYGVO0IwBbUWbTkwi9mn90hjqaUqKG+D0c1QnUblhsaAOEAQqQkYFra13CtQyDUKyC/b7cQTi5lNr9sD9dB6OT0I7Sq1AhAfjhwJxM+ntZ2sDLV81Y/oXSxKjDNbrs1tPRz9dsG7kDyWHvPQE8sEVo3cY21IDkUR25v+Ztiv+uLvoFNdbZ8PH6Pjom0rRiLPGfP2ny6yzZv6a36kea8WG1e7tUGNCe4YYx5uyWPD+clbJ4gyFN7v3d1LYDm9HbgGwDQ/eCjjAIeJK+7XJUElDZa9F4w/Mkq+YOy8F4v00yzjyxOAaKvqB9N+A7cZZ4fqkjXOtLlnFFbFE1oy7Q3Vz3OXXln+jaEs4KW+aTHaoEHL4xj4VU4IqAkv3GeillQYsqADawkFiGWay1yyv5HpQBxJ4svAkQF2/eOpEM+sZ0uKs4PUqvpiO4nZ+g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6ee117-7d3d-43b2-84d4-08d869838274
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2020 23:08:02.1852 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XR8oviqU2qATX9pmmCtoMUp3qOCAbX9SSuqPFUys69PjpmRmZvg6Pi/Kf87wYz1kDPb6LvlfI28OwrAvcaDaUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6205
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=540393388=Dmitry.Fomichev@wdc.com; helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 19:08:05
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "k.jensen@samsung.com" <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "philmd@redhat.com" <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Niklas Cassel <Niklas.Cassel@wdc.com>
> Sent: Monday, October 5, 2020 7:41 AM
> To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>; qemu-devel@nongnu.org;
> Damien Le Moal <Damien.LeMoal@wdc.com>; fam@euphon.net; Matias
> Bjorling <Matias.Bjorling@wdc.com>; qemu-block@nongnu.org;
> kwolf@redhat.com; mlevitsk@redhat.com; k.jensen@samsung.com;
> kbusch@kernel.org; philmd@redhat.com
> Subject: Re: [PATCH v5 09/14] hw/block/nvme: Support Zoned Namespace
> Command Set
>=20
> On Sun, Oct 04, 2020 at 11:57:07PM +0000, Dmitry Fomichev wrote:
> > On Wed, 2020-09-30 at 14:50 +0000, Niklas Cassel wrote:
> > > On Mon, Sep 28, 2020 at 11:35:23AM +0900, Dmitry Fomichev wrote:
> > > > The emulation code has been changed to advertise NVM Command Set
> when
> > > > "zoned" device property is not set (default) and Zoned Namespace
> > > > Command Set otherwise.
> > > >
> > > > Handlers for three new NVMe commands introduced in Zoned
> Namespace
> > > > Command Set specification are added, namely for Zone Management
> > > > Receive, Zone Management Send and Zone Append.
> > > >
> > > > Device initialization code has been extended to create a proper
> > > > configuration for zoned operation using device properties.
> > > >
> > > > Read/Write command handler is modified to only allow writes at the
> > > > write pointer if the namespace is zoned. For Zone Append command,
> > > > writes implicitly happen at the write pointer and the starting writ=
e
> > > > pointer value is returned as the result of the command. Write Zeroe=
s
> > > > handler is modified to add zoned checks that are identical to those
> > > > done as a part of Write flow.
> > > >
> > > > The code to support for Zone Descriptor Extensions is not included =
in
> > > > this commit and ZDES 0 is always reported. A later commit in this
> > > > series will add ZDE support.
> > > >
> > > > This commit doesn't yet include checks for active and open zone
> > > > limits. It is assumed that there are no limits on either active or
> > > > open zones.
> > > >
> > > > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > > > Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> > > > Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
> > > > Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > > > Signed-off-by: Matias Bjorling <matias.bjorling@wdc.com>
> > > > Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
> > > > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > > Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
> > > > Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> > > > ---
> > > >  block/nvme.c         |   2 +-
> > > >  hw/block/nvme-ns.c   | 185 ++++++++-
> > > >  hw/block/nvme-ns.h   |   6 +-
> > > >  hw/block/nvme.c      | 872
> +++++++++++++++++++++++++++++++++++++++++--
> > > >  include/block/nvme.h |   6 +-
> > > >  5 files changed, 1033 insertions(+), 38 deletions(-)
> > > >
> > > > diff --git a/block/nvme.c b/block/nvme.c
> > > > index 05485fdd11..7a513c9a17 100644
> > > > --- a/block/nvme.c
> > > > +++ b/block/nvme.c
>=20
> (snip)
>=20
> > >
> > > Please read my comment on nvme_identify_nslist_csi() before reading
> > > this comment.
> > >
> > > At least for this function, the specification is clear:
> > >
> > > "If the host requests a data structure for an I/O Command Set that th=
e
> > > controller does not support, the controller shall abort the command w=
ith
> > > a status of Invalid Field in Command."
> > >
> > > If the controller supports the I/O command set =3D=3D if the Command =
Set bit
> > > is set in the data struct returned by the nvme_identify_cmd_set(),
> > > so here we should do something like:
> > >
> > > } else if (->csi =3D=3D NVME_CSI_ZONED && ctrl_has_zns_namespaces()) =
{
> > > 	...
> > > }
> > >
> >
> > With this commit, the controller supports ZNS command set regardless of
> > the number of attached ZNS namespaces. It could be zero, but the
> controller
> > still supports it. I think it would be better not to change the behavio=
r
> > of this command to depend on whether there are any ZNS namespaces
> added
> > or not.
>=20
> Ok, always having ZNS Command Set support, regardless if a user defines
> a zoned namespace on the QEMU command line or not, does simplify things.
>=20
> But then in nvme_identify_cmd_set(), you need to call
> NVME_SET_CSI(*list, NVME_CSI_ZONED) unconditionally.
>=20

Perhaps,
NVME_SET_CSI(*list, NVME_CSI_NVM)
NVME_SET_CSI(*list, NVME_CSI_ZONED)

since this is a vector...

> (Right now you loop though all namespaces, and only set the support bit
> if you find a zoned namespace.)
>=20
> > > Like I wrote in my review comment in the patch that added support for
> the new
> > > allocated CNS values, I prefer if we remove this for-loop completely,=
 and
> > > simply set attached =3D true in nvme_ns_setup()/nvme_ns_init() instea=
d.
> > >
> > > (I was considering if we should set attach =3D true in
> nvme_zoned_init_ns(),
> > > but because nvme_ns_setup()/nvme_ns_init() is called for all
> namespaces,
> > > including ZNS namespaces, I don't think that any additional code in
> > > nvme_zoned_init_ns() is warranted.)
> >
> > I think CC.CSS value is not available during namespace setup and if we
> > assign active flag in nvme_zoned_ns_setup(), zoned namespaces may end
> up
> > being active even if NVM Only command set is selected. So keeping this
> loop
> > seems like a good idea.
>=20
> It is true that CC.CSS is not yet available during namespace setup,
> but since the controller itself will never detach namespaces based on
> CC.CSS, why are we dependant on CC.CSS being available?
>=20
> Sure, once someone implements namespace management, they will need
> to read if a certain namespace is attached or detached from some
> persistent state, perhaps in the zone meta-data file, and set
> attached boolean in nvme_ns_init() accordingly, but I still don't see
> any dependance on CC.CSS even when namespace management is
> implemented.
>=20

Ok, thanks for the clarification. I think it would be the best to add "atta=
ched"
property to namespace code instead of hardcoding it to true. The default,
of course, will be true, but will be possible to set it to false to test ho=
w everything
works with inactive namespaces. And yes, no dependence on CC.CSS.

>=20
>=20
> Kind regards,
> Niklas

