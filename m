Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF44C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 11:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D67E20774
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 11:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HA5WRNiZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="B0yBfJ3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D67E20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPOtV-0003bj-5c
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 07:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=54048c3c4=Niklas.Cassel@wdc.com>)
 id 1kPOrl-00031R-Ty; Mon, 05 Oct 2020 07:41:17 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:39086)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=54048c3c4=Niklas.Cassel@wdc.com>)
 id 1kPOrh-0008Aw-8f; Mon, 05 Oct 2020 07:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601898074; x=1633434074;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ZI80qtwkPWPKK49oGsvCn84wepiRrmWvJpSrg4hX+X4=;
 b=HA5WRNiZbU6TL0t4ZCZXRYDoY71S64tkMJevjyx/AvcVr9kwOP84FJ7d
 jiHx9a3zbG2QEole1v7TC3vKpr5jnLN+pKYWbNgZaKF+uoR3KomGeehrw
 d287SQ9iCEpv8XdRcto5iRm7An5BCAwIHhJNOEamSVFs4/Z4VaCEEhjBq
 bjnP86OX7X+XRQosRtNc/YbJi1/b6zCwhcdD4uFhpLu0KdCd1gc1n1a/e
 CBI1DYQwD36VE49SLy09K01TTlXU4k7zZVDqzRaW3pkuIGRWwk0/bydO3
 uze6Vp4uax1+zdCKzuhb7VD2T40z+Rsrt79aiyg1XfiFfKlyrLIOml1kW A==;
IronPort-SDR: J7ZxyKg/iVOpCKjkDkoGDk5GExgHEmWcrg/IwxWB1GJl+8QrnQsiPo0UiJ5BQ5hBaUkpU1iVqs
 W0G/HljFzIvCyGNgN4EMYyjAgI5FO8D8eNxl6vCrKKYQgCxIXFu98MsOhqHTKFiW4oZXyO9Pii
 0FE0fU9AYChDF3tIQquM4IlWt8dWW0nMqRSBrrTPRI4bsErWGqdMvjBrmjUAPisOlX3cRXMAw2
 9CycESDubmJ0xDNflyH98xsNImXfd0zBEMJXQiy7M8ck4FSMyE+8FsyddATnSNAieDK67Yl9UR
 5RQ=
X-IronPort-AV: E=Sophos;i="5.77,338,1596470400"; d="scan'208";a="150282956"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
 by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2020 19:41:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYC4hLVQagDZxOtk1gqSFbZolItinKHoRW/jTRqZFjA0Mme5lZ4kvn7bSetRWy3h5ue2gSNB6E+XuQL4Wke7gl0ZOsApPa1B+TGukSJ+vxevd0K54UeJHd0MKDEL3KdcC7/KEsBFmUAjbUq8KafEXxwRHOgOaOAvqjBODB8YVbf0PzPbEJBKGJIjg5RBsdhsuKJuVM5ADMufhdxgxqkKhEbdrqma+x9dleA/XTEJ41OnDp9BQ/yAW00vqDu9PaIm5tyQfBiLL5KkqfYfrJASt9+WDf+KmWZFW+7QkXSmOBPHRuLFY50ry6IZ4SVgWX6fT0Zil6BDsuR5fciVkADVSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYwG/jXBZ+VqIELiNbbXUlj64XDayWHsem0KRRVwQmU=;
 b=F7w8REFlMAaDNDpQSQ9AR3dikLQiFhCldfvmcUPMpPH/M0Fr/Jg/RPLhkFiXkptDXh/30YoFBR3oboeVb2votAUU5xhEsg1oyw/KbXBNXHYU9Q/QOieE/LDNMw4ykg97OqWKiuLLOIQehmYNiYR96pRawpobeD8l6zX23NqHUFV8qqEKsJ0cqMkhE13IN4rQT7vmc1JSW8qqiM01vKyxrr/4JujBBzCubuIA1D1qv0LGcmWy2hBQCMMCBQbErPcpMlls6nY9AUb6cl4yGX5Wt8KmSkqXk6fDkwYnRlWd/8+sEEUUzQbSnn4+6avMQec/MIjs/jjCxuQ4wGsYdlztnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYwG/jXBZ+VqIELiNbbXUlj64XDayWHsem0KRRVwQmU=;
 b=B0yBfJ3X8q+NKLBuZrPC8jsLL1Ykf6o5IW0jABKijLXY0k3I06boTMmMsUgdplFerNRNNq47T0f3Vagx6sf2yKrJX8kWMR8wP5qHdvmt5OtRPW5eeMUBnEQPRtTQcrQRcutCiQQv+KeedRIK3AXGcLTmz1EG/Btk6NNXNYAmlL0=
Received: from DM6PR04MB5483.namprd04.prod.outlook.com (2603:10b6:5:126::20)
 by DM6PR04MB5977.namprd04.prod.outlook.com (2603:10b6:5:12a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Mon, 5 Oct
 2020 11:41:08 +0000
Received: from DM6PR04MB5483.namprd04.prod.outlook.com
 ([fe80::c8ee:62d1:5ed1:2ee]) by DM6PR04MB5483.namprd04.prod.outlook.com
 ([fe80::c8ee:62d1:5ed1:2ee%6]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 11:41:08 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Subject: Re: [PATCH v5 09/14] hw/block/nvme: Support Zoned Namespace Command
 Set
Thread-Topic: [PATCH v5 09/14] hw/block/nvme: Support Zoned Namespace Command
 Set
Thread-Index: AQHWlUAbQOQDY76Lzkm8Z8GHZfc6vamBR4QAgAbiHYCAAMSxAA==
Date: Mon, 5 Oct 2020 11:41:08 +0000
Message-ID: <20201005114106.GC387917@localhost.localdomain>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
 <20200928023528.15260-10-dmitry.fomichev@wdc.com>
 <20200930145016.GB204568@localhost.localdomain>
 <081017a7953a91ddabe05b472f74713453d479ea.camel@wdc.com>
In-Reply-To: <081017a7953a91ddabe05b472f74713453d479ea.camel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9b4ad8b5-e4ac-4e24-abe1-08d869238d46
x-ms-traffictypediagnostic: DM6PR04MB5977:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB597723F493CC4BAC0F9A6AB6F20C0@DM6PR04MB5977.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /ZnIxTGjuECahwMcwtPSd+hxBuVv+OrNaC+ffqzOFh7++A9jY6m2j3Y6fYE6P+JrzgN96IUtCsGNW0ZMBGOYM8R27RDlmJmf2qLVztAQ4jEzq1mCUWq4sCmo7tfuDh8A5LNppVLq+PRYqRUu+7PbXgOnwu0V+Yjs0++1vuqv4qIlyABdTywBJgK7Fi497NlH1oS7JSMacJC/Yw1qSBYIRElvo46sjJOQ0I6DW6pufw6a5iJ1daTZIEmUM4hGkunf2jJ/0ui+mCwYUAGgAtW5HsRoOL1z48DL8GKhjU7tvQIIzOI6Nkmmmk6pGNTFhwrqqUFs3/I2BLvqsHD9cvCiYw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB5483.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(66476007)(64756008)(66446008)(66946007)(66556008)(1076003)(54906003)(91956017)(76116006)(2906002)(5660300002)(316002)(4326008)(71200400001)(8676002)(6486002)(6506007)(6862004)(86362001)(83380400001)(6636002)(186003)(33656002)(6512007)(9686003)(8936002)(478600001)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Ug+/nTew+mLNYOAWRNMm5RPtbgpwyWyUryTp3BDEJiw8Qw/wLByhzVB8N2j059HiTr9dP9sT1QvMM1CNVRC7UGm5XZffvj0zwlbdPyRRo4WKI/28PXxuJQLudk/mVKg+BZ6K/w/Gcm4NWoUn9DHbIRzfHTkaHQmjczTCqdk8JlBjET00vHPGx3uI359decCfya379rgcSmwERNdSOkThtAf55dFcnBuqVhYirDNZ2VqIZXTXN0mq0GTj1MuayiqjnMtRfMWA5/tuwOspHRHL/S7rDEfZ9fE6RRv1MKmVnuop7MU5oSV9dqWHC1j4YF8GMya0r0AXJeKKZAUM2VD1+EIrxh65DRs7neXOVE8r/+QDZOHnAgpDpv4QcyxgdD4LHARjnYPQQ5SOZUbdjVycy55P+XHiSrsntNEtZb7T+jPZWClPBEKxbL8PUY0R0bFiEDi/hp+o7xamAMXk75oRt9cUoHUtPM2Wr4PGfYYUud8ZuBJYCemo+RW48ncg+utk7FQCLugwF6LIRLNa6m+jgcT3QcQCdDrSuppsirrmztoBg4WRYr9Nkw8Z3WBWENUcYwwMDkHb7od8Pe+pi7A+3iG5KSvQ7xF4NCcM/S0AgjDcprWxbfi9vfovr33OsTA2ZDpn5cZPjwW84xPVlsjpnA==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BFA6D73FD7DB7749AEAA1E9341B22AB2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB5483.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4ad8b5-e4ac-4e24-abe1-08d869238d46
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2020 11:41:08.5727 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8eTgspepPyYy2NVi+N0rWYn3Dl6GXLjF6MJs4yNusRWTd3AAq6nIh/FEB+dAgjKh0W/OmqxEpvT3GrucGSl5Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5977
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=54048c3c4=Niklas.Cassel@wdc.com; helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 07:41:11
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

On Sun, Oct 04, 2020 at 11:57:07PM +0000, Dmitry Fomichev wrote:
> On Wed, 2020-09-30 at 14:50 +0000, Niklas Cassel wrote:
> > On Mon, Sep 28, 2020 at 11:35:23AM +0900, Dmitry Fomichev wrote:
> > > The emulation code has been changed to advertise NVM Command Set when
> > > "zoned" device property is not set (default) and Zoned Namespace
> > > Command Set otherwise.
> > >=20
> > > Handlers for three new NVMe commands introduced in Zoned Namespace
> > > Command Set specification are added, namely for Zone Management
> > > Receive, Zone Management Send and Zone Append.
> > >=20
> > > Device initialization code has been extended to create a proper
> > > configuration for zoned operation using device properties.
> > >=20
> > > Read/Write command handler is modified to only allow writes at the
> > > write pointer if the namespace is zoned. For Zone Append command,
> > > writes implicitly happen at the write pointer and the starting write
> > > pointer value is returned as the result of the command. Write Zeroes
> > > handler is modified to add zoned checks that are identical to those
> > > done as a part of Write flow.
> > >=20
> > > The code to support for Zone Descriptor Extensions is not included in
> > > this commit and ZDES 0 is always reported. A later commit in this
> > > series will add ZDE support.
> > >=20
> > > This commit doesn't yet include checks for active and open zone
> > > limits. It is assumed that there are no limits on either active or
> > > open zones.
> > >=20
> > > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > > Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> > > Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
> > > Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > > Signed-off-by: Matias Bjorling <matias.bjorling@wdc.com>
> > > Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
> > > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
> > > Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> > > ---
> > >  block/nvme.c         |   2 +-
> > >  hw/block/nvme-ns.c   | 185 ++++++++-
> > >  hw/block/nvme-ns.h   |   6 +-
> > >  hw/block/nvme.c      | 872 +++++++++++++++++++++++++++++++++++++++++=
--
> > >  include/block/nvme.h |   6 +-
> > >  5 files changed, 1033 insertions(+), 38 deletions(-)
> > >=20
> > > diff --git a/block/nvme.c b/block/nvme.c
> > > index 05485fdd11..7a513c9a17 100644
> > > --- a/block/nvme.c
> > > +++ b/block/nvme.c

(snip)

> >=20
> > Please read my comment on nvme_identify_nslist_csi() before reading
> > this comment.
> >=20
> > At least for this function, the specification is clear:
> >=20
> > "If the host requests a data structure for an I/O Command Set that the
> > controller does not support, the controller shall abort the command wit=
h
> > a status of Invalid Field in Command."
> >=20
> > If the controller supports the I/O command set =3D=3D if the Command Se=
t bit
> > is set in the data struct returned by the nvme_identify_cmd_set(),
> > so here we should do something like:
> >=20
> > } else if (->csi =3D=3D NVME_CSI_ZONED && ctrl_has_zns_namespaces()) {
> > 	...
> > }
> >=20
>=20
> With this commit, the controller supports ZNS command set regardless of
> the number of attached ZNS namespaces. It could be zero, but the controll=
er
> still supports it. I think it would be better not to change the behavior
> of this command to depend on whether there are any ZNS namespaces added
> or not.

Ok, always having ZNS Command Set support, regardless if a user defines
a zoned namespace on the QEMU command line or not, does simplify things.

But then in nvme_identify_cmd_set(), you need to call
NVME_SET_CSI(*list, NVME_CSI_ZONED) unconditionally.

(Right now you loop though all namespaces, and only set the support bit
if you find a zoned namespace.)

> > Like I wrote in my review comment in the patch that added support for t=
he new
> > allocated CNS values, I prefer if we remove this for-loop completely, a=
nd
> > simply set attached =3D true in nvme_ns_setup()/nvme_ns_init() instead.
> >=20
> > (I was considering if we should set attach =3D true in nvme_zoned_init_=
ns(),
> > but because nvme_ns_setup()/nvme_ns_init() is called for all namespaces=
,
> > including ZNS namespaces, I don't think that any additional code in
> > nvme_zoned_init_ns() is warranted.)
>=20
> I think CC.CSS value is not available during namespace setup and if we
> assign active flag in nvme_zoned_ns_setup(), zoned namespaces may end up
> being active even if NVM Only command set is selected. So keeping this lo=
op
> seems like a good idea.

It is true that CC.CSS is not yet available during namespace setup,
but since the controller itself will never detach namespaces based on
CC.CSS, why are we dependant on CC.CSS being available?

Sure, once someone implements namespace management, they will need
to read if a certain namespace is attached or detached from some
persistent state, perhaps in the zone meta-data file, and set
attached boolean in nvme_ns_init() accordingly, but I still don't see
any dependance on CC.CSS even when namespace management is implemented.



Kind regards,
Niklas=

