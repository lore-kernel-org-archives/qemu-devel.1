Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF15C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 14:52:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22C5D206FC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 14:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="q3ErUhPv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Kz2ADs1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C5D206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNdTL-0000DY-RI
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 10:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5353e43af=Niklas.Cassel@wdc.com>)
 id 1kNdR8-0007Bl-Mb; Wed, 30 Sep 2020 10:50:30 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51602)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5353e43af=Niklas.Cassel@wdc.com>)
 id 1kNdR2-0003sS-Ps; Wed, 30 Sep 2020 10:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601477426; x=1633013426;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=0K9HLYdUj6MJ4K6Wo3+S0u8JeWgpnb9FBASBA6e9hPY=;
 b=q3ErUhPv5TS+aojikZgLCQIt+TItt5lyh5KppHvqrNtrUr6H82z0UtCt
 jvsZBvMR+3foAXaY0mUQvlrns1YFBWkO1v1Ziv34pm7vv5o6b4Dujjw7W
 OrzpBe5cHproYIYkK3i8156q1MtD56LLtiIbRIvLBfjb8owMoLxbWZ3Em
 KDa1L3iwbKnJTFqUb4JpmJDE16fU92ew7JkX0yiR5GI76B3X9zD1g9zAZ
 Q5d8FmD8dLokJchbZ0aSsTvaZmZgJcOEwT1iVfGTI/LEDDnulcOieO6zJ
 7m16JuABcBKTIYwqVjL39shbx6ZmGF+lrNnQfm0K4kO8BxUpFWaCNTRhJ w==;
IronPort-SDR: Y8IvlXLSwk7J1b79l6mCKuUWvO104BJwB+DbiVYpJb+rjxDZUTmn1uyJBwU/FswcaeUbewCSsf
 3NUEQouYL02tMSpL3cfGq2qCXvYSWd+dWU6V0jGRUayCv1jbOg/SWF1vXS+FakHZJmFd1BzA7i
 ouCQklZsnLhJhlnv9VUBIWqkmXVvF6eHXygEEU3Xu8+PWfJ7gMVdTwQl7j3kL38t+VSiM+Aly1
 HM28wNO5BCqQ3Ac4mgRdl5wM7wUZ4bxbJJ3MswEInP8kFSNDmvrW+ichaPlDg/9yUAh1ZUJf/R
 XVA=
X-IronPort-AV: E=Sophos;i="5.77,322,1596470400"; d="scan'208";a="148691290"
Received: from mail-dm6nam08lp2045.outbound.protection.outlook.com (HELO
 NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.45])
 by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2020 22:50:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0lzhLhK1rBQv/FNIhujtZCSG81oCGOYDd1ot+MXMEw1kXvtKhyjaVArcepgERmUq/9F6sN4i60JQtm+d8f3R+lmUS2H4mOO/KxskW54/Vok7MhnW/4FaPpQv8CvBOKl14IdbjsD9GulIBEFVe0Hx9JBkRy0gpXnBHtfFoSR2D/IY9WH+EDCrdxyqbWBWecHFZfUUSJM1AKTM0YI3pk8K+uQqbotgKvViNRaCWwAln+8aY1xG6wCizCee5GzAHUOsARxEdTNx7gDR9oqKclDpLht7b53diLaWUK+cvbpC2Piz4wdaw47EuKMPbXe0Rv1Trf9GxvLaX9nzeQUarlCig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CV/ekrlOxRpdTBE4xMdGgmVxZUvtSoEnzeXFRZagpw=;
 b=nrwOnHGql5eb+4Mkb1V9aYG3Aqs5IsyOUnCoI26Pyv495d46oBZZMSLZopeGvBQpJfIBOh/THNisQM82/V74o7RCUtF4reqQUccRwtsOlD6KkcrI9uiLY2O23yyAB/bmLTG3HS8/nvZIOCrgFaXmgr6bBl0QfPJJKXT0AAXTtNuPebMla0zCAFd4NZKukeNzfBrwXrBvuea0H1U+/BBFU3hzep1R+MVjWkFe5e6kJVlzVYHpInMxgF/iegWYfbGxUYktB02U2/agyTt5KTMeHo0is48DkQp+OvGDkBoiU3qYL18kwzkU4o8uw1XxIPXava11jzVod6tZR6/AAfnEzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CV/ekrlOxRpdTBE4xMdGgmVxZUvtSoEnzeXFRZagpw=;
 b=Kz2ADs1Poeuo/1l+IToUZIvBjcngpLja4s1Y0lOsOM6dxE+kUa3u5z/hdXCiz6MmClqMheqxJQN7HC+/ELSFHYfiQh4S6Z+b4o8Kt+sBdoJaXd3i+12owjXmWhuGXrWK/7MnamBvXfnPg7qGnznoAwogsJJ+sBZdU7Z6xtsQe2Q=
Received: from BN6PR04MB0724.namprd04.prod.outlook.com (2603:10b6:404:ce::23)
 by BN7PR04MB5347.namprd04.prod.outlook.com (2603:10b6:408:37::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Wed, 30 Sep
 2020 14:50:17 +0000
Received: from BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::acb1:47a4:73ba:69a7]) by BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::acb1:47a4:73ba:69a7%9]) with mapi id 15.20.3412.029; Wed, 30 Sep 2020
 14:50:17 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Subject: Re: [PATCH v5 09/14] hw/block/nvme: Support Zoned Namespace Command
 Set
Thread-Topic: [PATCH v5 09/14] hw/block/nvme: Support Zoned Namespace Command
 Set
Thread-Index: AQHWlUAbQOQDY76Lzkm8Z8GHZfc6vamBR4QA
Date: Wed, 30 Sep 2020 14:50:17 +0000
Message-ID: <20200930145016.GB204568@localhost.localdomain>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
 <20200928023528.15260-10-dmitry.fomichev@wdc.com>
In-Reply-To: <20200928023528.15260-10-dmitry.fomichev@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d690761-7fb0-4f53-5e64-08d8655025c0
x-ms-traffictypediagnostic: BN7PR04MB5347:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR04MB5347D3C1CF9839BBFAA161E7F2330@BN7PR04MB5347.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:324;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3w2bU5yXJXj7vlfbMuvcGAr5+IkVE1UdmmsGddYzm9B26rAPxMQsQRKswKxs7+fsTc0DoJyxTwAcX3xyk7fnUujYijJfZi2oD2z1asu5s8Up/0AHbs4JjwUPwIK8t+yDM6VbMiUc/qwPR/FwAP8xb/xZPRp7Xll/42ec6VmVsCjOyf8MXjdxOds+4832RhY56oaq2zCtCPd8taUS1yXxzffj/Rymz9TdgRPFceqyVownOZCAAOI3LTtJaiMhVkOeQtOlXL186kH/1Vnxv9C+DtHZpXT14tg7yOSnzbookmBVHbX68jwtB0YnAdPiT+PdofaxDQlfeNwh3OXc9qZ8O7nMOdo2bYoqGqQxbohQ5y7a15xG16yTg4URjLDNn41a
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR04MB0724.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(66946007)(66476007)(66556008)(64756008)(66446008)(76116006)(91956017)(71200400001)(54906003)(6636002)(6486002)(6512007)(316002)(9686003)(186003)(83380400001)(1076003)(86362001)(5660300002)(30864003)(33656002)(45080400002)(8936002)(2906002)(478600001)(8676002)(6862004)(6506007)(4326008)(26005)(579004)(559001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: WmRe9ImIkWsWM60K1La8l3jNFfqo/qh6QBDzMaXpOU7YrJjDRIjAXIvd4xETYoJxxn8jUEWx8S5JsN5Eo8GCRu9jCiBUNjzarcWKXNzm0Y7aS/aObwqG5aEojtGM8d5MxXMDRkvQ3yUbakYMUTjL32TJ6CwLa94fBYENc1fpyrUto/rRp8zR8VqxMwnR8yTNXxo2XqToY3zl65WNGBZ4Qig0Ah6ttlPXfsxC7tLPx0+8aLwtTfLBV9XZsND3rwyRAXF/Nvc9bBKWcNyUVr7ICxiypDzBgRsel9fp4pdpk9jD0f+8Pj3XmIZHxF+s/sUPkHX0Mg0ZI/SQJ/bxsX9PXhId59ri9MmPS1xWlqzeRcSgNnRzPhvaOdimKUWpWTxsfSmGdnQNqpdHhiOpSit919zFyrFQVhfDt/8L8IFolCA8GMl/nfaqv11QvAzbWzOSOgbvIw9IEA+hQpE4zk8v4HnmaS5/apgvq/CPSrlgt8U8tofEJ5bcSwyYDMaOR6fNzn44PsPL2BTNaTVyGNeQqPd0xxGOgNb5C6t6CCR/F/GU86SQTqPdulaindLSTxXBkOJOb/TJd1HCEqxzHEm5FHfxCHv+IsLyaQlHodYOhj1tut5dt8I9DPox0mOf3PAjfWhQW9gMvOw2WTLd3Awtug==
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <148E2EBCF72782419E3C2E52A7FC3676@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR04MB0724.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d690761-7fb0-4f53-5e64-08d8655025c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 14:50:17.4789 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VK8sLPVdbRPT0FlzkZ43wpzrjhQGzhjtZfgRye+FSbJydI8VwmF1VIzlizMhMh0uFlsPb9kQ1eHEZ+qR/7d3rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB5347
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=5353e43af=Niklas.Cassel@wdc.com; helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 10:50:22
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

On Mon, Sep 28, 2020 at 11:35:23AM +0900, Dmitry Fomichev wrote:
> The emulation code has been changed to advertise NVM Command Set when
> "zoned" device property is not set (default) and Zoned Namespace
> Command Set otherwise.
>=20
> Handlers for three new NVMe commands introduced in Zoned Namespace
> Command Set specification are added, namely for Zone Management
> Receive, Zone Management Send and Zone Append.
>=20
> Device initialization code has been extended to create a proper
> configuration for zoned operation using device properties.
>=20
> Read/Write command handler is modified to only allow writes at the
> write pointer if the namespace is zoned. For Zone Append command,
> writes implicitly happen at the write pointer and the starting write
> pointer value is returned as the result of the command. Write Zeroes
> handler is modified to add zoned checks that are identical to those
> done as a part of Write flow.
>=20
> The code to support for Zone Descriptor Extensions is not included in
> this commit and ZDES 0 is always reported. A later commit in this
> series will add ZDE support.
>=20
> This commit doesn't yet include checks for active and open zone
> limits. It is assumed that there are no limits on either active or
> open zones.
>=20
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Signed-off-by: Matias Bjorling <matias.bjorling@wdc.com>
> Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  block/nvme.c         |   2 +-
>  hw/block/nvme-ns.c   | 185 ++++++++-
>  hw/block/nvme-ns.h   |   6 +-
>  hw/block/nvme.c      | 872 +++++++++++++++++++++++++++++++++++++++++--
>  include/block/nvme.h |   6 +-
>  5 files changed, 1033 insertions(+), 38 deletions(-)
>=20
> diff --git a/block/nvme.c b/block/nvme.c
> index 05485fdd11..7a513c9a17 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -333,7 +333,7 @@ static inline int nvme_translate_error(const NvmeCqe =
*c)
>  {
>      uint16_t status =3D (le16_to_cpu(c->status) >> 1) & 0xFF;
>      if (status) {
> -        trace_nvme_error(le32_to_cpu(c->result),
> +        trace_nvme_error(le32_to_cpu(c->result32),
>                           le16_to_cpu(c->sq_head),
>                           le16_to_cpu(c->sq_id),
>                           le16_to_cpu(c->cid),
> diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
> index 31b7f986c3..6d9dc9205b 100644
> --- a/hw/block/nvme-ns.c
> +++ b/hw/block/nvme-ns.c
> @@ -33,14 +33,14 @@ static void nvme_ns_init(NvmeNamespace *ns)
>      NvmeIdNs *id_ns =3D &ns->id_ns;
> =20
>      if (blk_get_flags(ns->blkconf.blk) & BDRV_O_UNMAP) {
> -        ns->id_ns.dlfeat =3D 0x9;
> +        ns->id_ns.dlfeat =3D 0x8;

You seem to change something that is NVM namespace specific here, why?
If it is indeed needed, I assume that this change should be in a separate
patch.

>      }
> =20
>      id_ns->lbaf[0].ds =3D BDRV_SECTOR_BITS;
> =20
>      id_ns->nsze =3D cpu_to_le64(nvme_ns_nlbas(ns));
> =20
> -    ns->params.csi =3D NVME_CSI_NVM;
> +    ns->csi =3D NVME_CSI_NVM;
>      qemu_uuid_generate(&ns->params.uuid); /* TODO make UUIDs persistent =
*/
> =20
>      /* no thin provisioning */
> @@ -73,7 +73,162 @@ static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespac=
e *ns, Error **errp)
>      }
> =20
>      lba_index =3D NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
> -    ns->id_ns.lbaf[lba_index].ds =3D 31 - clz32(n->conf.logical_block_si=
ze);
> +    ns->id_ns.lbaf[lba_index].ds =3D 31 - clz32(ns->blkconf.logical_bloc=
k_size);
> +
> +    return 0;
> +}
> +
> +/*
> + * Add a zone to the tail of a zone list.
> + */
> +void nvme_add_zone_tail(NvmeNamespace *ns, NvmeZoneList *zl, NvmeZone *z=
one)
> +{
> +    uint32_t idx =3D (uint32_t)(zone - ns->zone_array);
> +
> +    assert(nvme_zone_not_in_list(zone));
> +
> +    if (!zl->size) {
> +        zl->head =3D zl->tail =3D idx;
> +        zone->next =3D zone->prev =3D NVME_ZONE_LIST_NIL;
> +    } else {
> +        ns->zone_array[zl->tail].next =3D idx;
> +        zone->prev =3D zl->tail;
> +        zone->next =3D NVME_ZONE_LIST_NIL;
> +        zl->tail =3D idx;
> +    }
> +    zl->size++;
> +}
> +
> +/*
> + * Remove a zone from a zone list. The zone must be linked in the list.
> + */
> +void nvme_remove_zone(NvmeNamespace *ns, NvmeZoneList *zl, NvmeZone *zon=
e)
> +{
> +    uint32_t idx =3D (uint32_t)(zone - ns->zone_array);
> +
> +    assert(!nvme_zone_not_in_list(zone));
> +
> +    --zl->size;
> +    if (zl->size =3D=3D 0) {
> +        zl->head =3D NVME_ZONE_LIST_NIL;
> +        zl->tail =3D NVME_ZONE_LIST_NIL;
> +    } else if (idx =3D=3D zl->head) {
> +        zl->head =3D zone->next;
> +        ns->zone_array[zl->head].prev =3D NVME_ZONE_LIST_NIL;
> +    } else if (idx =3D=3D zl->tail) {
> +        zl->tail =3D zone->prev;
> +        ns->zone_array[zl->tail].next =3D NVME_ZONE_LIST_NIL;
> +    } else {
> +        ns->zone_array[zone->next].prev =3D zone->prev;
> +        ns->zone_array[zone->prev].next =3D zone->next;
> +    }
> +
> +    zone->prev =3D zone->next =3D 0;
> +}
> +
> +static int nvme_calc_zone_geometry(NvmeNamespace *ns, Error **errp)
> +{
> +    uint64_t zone_size, zone_cap;
> +    uint32_t nz, lbasz =3D ns->blkconf.logical_block_size;
> +
> +    if (ns->params.zone_size_mb) {
> +        zone_size =3D ns->params.zone_size_mb;
> +    } else {
> +        zone_size =3D NVME_DEFAULT_ZONE_SIZE;
> +    }
> +    if (ns->params.zone_capacity_mb) {
> +        zone_cap =3D ns->params.zone_capacity_mb;
> +    } else {
> +        zone_cap =3D zone_size;
> +    }
> +    ns->zone_size =3D zone_size * MiB / lbasz;
> +    ns->zone_capacity =3D zone_cap * MiB / lbasz;
> +    if (ns->zone_capacity > ns->zone_size) {
> +        error_setg(errp, "zone capacity exceeds zone size");
> +        return -1;
> +    }
> +
> +    nz =3D DIV_ROUND_UP(ns->size / lbasz, ns->zone_size);
> +    ns->num_zones =3D nz;
> +    ns->zone_array_size =3D sizeof(NvmeZone) * nz;
> +    ns->zone_size_log2 =3D 0;
> +    if (is_power_of_2(ns->zone_size)) {
> +        ns->zone_size_log2 =3D 63 - clz64(ns->zone_size);
> +    }
> +
> +    return 0;
> +}
> +
> +static void nvme_init_zone_meta(NvmeNamespace *ns)
> +{
> +    uint64_t start =3D 0, zone_size =3D ns->zone_size;
> +    uint64_t capacity =3D ns->num_zones * zone_size;
> +    NvmeZone *zone;
> +    int i;
> +
> +    ns->zone_array =3D g_malloc0(ns->zone_array_size);
> +    ns->exp_open_zones =3D g_malloc0(sizeof(NvmeZoneList));
> +    ns->imp_open_zones =3D g_malloc0(sizeof(NvmeZoneList));
> +    ns->closed_zones =3D g_malloc0(sizeof(NvmeZoneList));
> +    ns->full_zones =3D g_malloc0(sizeof(NvmeZoneList));
> +
> +    nvme_init_zone_list(ns->exp_open_zones);
> +    nvme_init_zone_list(ns->imp_open_zones);
> +    nvme_init_zone_list(ns->closed_zones);
> +    nvme_init_zone_list(ns->full_zones);
> +
> +    zone =3D ns->zone_array;
> +    for (i =3D 0; i < ns->num_zones; i++, zone++) {
> +        if (start + zone_size > capacity) {
> +            zone_size =3D capacity - start;
> +        }
> +        zone->d.zt =3D NVME_ZONE_TYPE_SEQ_WRITE;
> +        nvme_set_zone_state(zone, NVME_ZONE_STATE_EMPTY);
> +        zone->d.za =3D 0;
> +        zone->d.zcap =3D ns->zone_capacity;
> +        zone->d.zslba =3D start;
> +        zone->d.wp =3D start;
> +        zone->w_ptr =3D start;
> +        zone->prev =3D 0;
> +        zone->next =3D 0;
> +        start +=3D zone_size;
> +    }
> +}
> +
> +static int nvme_zoned_init_ns(NvmeCtrl *n, NvmeNamespace *ns, int lba_in=
dex,
> +                              Error **errp)
> +{
> +    NvmeIdNsZoned *id_ns_z;
> +
> +    if (n->params.fill_pattern =3D=3D 0) {
> +        ns->id_ns.dlfeat |=3D 0x01;
> +    } else if (n->params.fill_pattern =3D=3D 0xff) {
> +        ns->id_ns.dlfeat |=3D 0x02;
> +    }
> +
> +    if (nvme_calc_zone_geometry(ns, errp) !=3D 0) {
> +        return -1;
> +    }
> +
> +    nvme_init_zone_meta(ns);
> +
> +    id_ns_z =3D g_malloc0(sizeof(NvmeIdNsZoned));
> +
> +    /* MAR/MOR are zeroes-based, 0xffffffff means no limit */
> +    id_ns_z->mar =3D 0xffffffff;
> +    id_ns_z->mor =3D 0xffffffff;
> +    id_ns_z->zoc =3D 0;
> +    id_ns_z->ozcs =3D ns->params.cross_zone_read ? 0x01 : 0x00;
> +
> +    id_ns_z->lbafe[lba_index].zsze =3D cpu_to_le64(ns->zone_size);
> +    id_ns_z->lbafe[lba_index].zdes =3D 0; /* FIXME make helper */
> +
> +    ns->csi =3D NVME_CSI_ZONED;
> +    ns->id_ns.ncap =3D cpu_to_le64(ns->zone_capacity * ns->num_zones);
> +    ns->id_ns.nuse =3D ns->id_ns.ncap;
> +    ns->id_ns.nsze =3D ns->id_ns.ncap;
> +
> +    ns->id_ns_zoned =3D id_ns_z;
> =20
>      return 0;
>  }
> @@ -103,6 +258,12 @@ int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Er=
ror **errp)
>          return -1;
>      }
> =20
> +    if (ns->params.zoned) {
> +        if (nvme_zoned_init_ns(n, ns, 0, errp) !=3D 0) {
> +            return -1;
> +        }
> +    }
> +
>      return 0;
>  }
> =20
> @@ -116,6 +277,16 @@ void nvme_ns_flush(NvmeNamespace *ns)
>      blk_flush(ns->blkconf.blk);
>  }
> =20
> +void nvme_ns_cleanup(NvmeNamespace *ns)
> +{
> +    g_free(ns->id_ns_zoned);
> +    g_free(ns->zone_array);
> +    g_free(ns->exp_open_zones);
> +    g_free(ns->imp_open_zones);
> +    g_free(ns->closed_zones);
> +    g_free(ns->full_zones);
> +}
> +
>  static void nvme_ns_realize(DeviceState *dev, Error **errp)
>  {
>      NvmeNamespace *ns =3D NVME_NS(dev);
> @@ -133,6 +304,14 @@ static void nvme_ns_realize(DeviceState *dev, Error =
**errp)
>  static Property nvme_ns_props[] =3D {
>      DEFINE_BLOCK_PROPERTIES(NvmeNamespace, blkconf),
>      DEFINE_PROP_UINT32("nsid", NvmeNamespace, params.nsid, 0),
> +
> +    DEFINE_PROP_BOOL("zoned", NvmeNamespace, params.zoned, false),
> +    DEFINE_PROP_UINT64("zone_size", NvmeNamespace, params.zone_size_mb,
> +                       NVME_DEFAULT_ZONE_SIZE),
> +    DEFINE_PROP_UINT64("zone_capacity", NvmeNamespace,
> +                       params.zone_capacity_mb, 0),
> +    DEFINE_PROP_BOOL("cross_zone_read", NvmeNamespace,
> +                      params.cross_zone_read, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
> index 04172f083e..daa13546c4 100644
> --- a/hw/block/nvme-ns.h
> +++ b/hw/block/nvme-ns.h
> @@ -38,7 +38,6 @@ typedef struct NvmeZoneList {
> =20
>  typedef struct NvmeNamespaceParams {
>      uint32_t nsid;
> -    uint8_t  csi;
>      bool     attached;
>      QemuUUID uuid;
> =20
> @@ -52,6 +51,7 @@ typedef struct NvmeNamespace {
>      DeviceState  parent_obj;
>      BlockConf    blkconf;
>      int32_t      bootindex;
> +    uint8_t      csi;
>      int64_t      size;
>      NvmeIdNs     id_ns;
> =20
> @@ -107,6 +107,7 @@ typedef struct NvmeCtrl NvmeCtrl;
>  int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp);
>  void nvme_ns_drain(NvmeNamespace *ns);
>  void nvme_ns_flush(NvmeNamespace *ns);
> +void nvme_ns_cleanup(NvmeNamespace *ns);
> =20
>  static inline uint8_t nvme_get_zone_state(NvmeZone *zone)
>  {
> @@ -188,4 +189,7 @@ static inline NvmeZone *nvme_next_zone_in_list(NvmeNa=
mespace *ns, NvmeZone *z,
>      return &ns->zone_array[z->next];
>  }
> =20
> +void nvme_add_zone_tail(NvmeNamespace *ns, NvmeZoneList *zl, NvmeZone *z=
one);
> +void nvme_remove_zone(NvmeNamespace *ns, NvmeZoneList *zl, NvmeZone *zon=
e);
> +
>  #endif /* NVME_NS_H */
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 63ad03d6d6..38e25a4d1f 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -54,6 +54,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
>  #include "qemu/error-report.h"
> +#include "crypto/random.h"
>  #include "hw/block/block.h"
>  #include "hw/pci/msix.h"
>  #include "hw/pci/pci.h"
> @@ -127,6 +128,46 @@ static uint16_t nvme_sqid(NvmeRequest *req)
>      return le16_to_cpu(req->sq->sqid);
>  }
> =20
> +static void nvme_assign_zone_state(NvmeNamespace *ns, NvmeZone *zone,
> +                                   uint8_t state)
> +{
> +    if (!nvme_zone_not_in_list(zone)) {
> +        switch (nvme_get_zone_state(zone)) {
> +        case NVME_ZONE_STATE_EXPLICITLY_OPEN:
> +            nvme_remove_zone(ns, ns->exp_open_zones, zone);
> +            break;
> +        case NVME_ZONE_STATE_IMPLICITLY_OPEN:
> +            nvme_remove_zone(ns, ns->imp_open_zones, zone);
> +            break;
> +        case NVME_ZONE_STATE_CLOSED:
> +            nvme_remove_zone(ns, ns->closed_zones, zone);
> +            break;
> +        case NVME_ZONE_STATE_FULL:
> +            nvme_remove_zone(ns, ns->full_zones, zone);
> +        }
> +   }
> +
> +    nvme_set_zone_state(zone, state);
> +
> +    switch (state) {
> +    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
> +        nvme_add_zone_tail(ns, ns->exp_open_zones, zone);
> +        break;
> +    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
> +        nvme_add_zone_tail(ns, ns->imp_open_zones, zone);
> +        break;
> +    case NVME_ZONE_STATE_CLOSED:
> +        nvme_add_zone_tail(ns, ns->closed_zones, zone);
> +        break;
> +    case NVME_ZONE_STATE_FULL:
> +        nvme_add_zone_tail(ns, ns->full_zones, zone);
> +    case NVME_ZONE_STATE_READ_ONLY:
> +        break;
> +    default:
> +        zone->d.za =3D 0;
> +    }
> +}
> +
>  static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
>  {
>      hwaddr low =3D n->ctrl_mem.addr;
> @@ -813,7 +854,7 @@ static void nvme_process_aers(void *opaque)
> =20
>          req =3D n->aer_reqs[n->outstanding_aers];
> =20
> -        result =3D (NvmeAerResult *) &req->cqe.result;
> +        result =3D (NvmeAerResult *) &req->cqe.result32;
>          result->event_type =3D event->result.event_type;
>          result->event_info =3D event->result.event_info;
>          result->log_page =3D event->result.log_page;
> @@ -882,6 +923,200 @@ static inline uint16_t nvme_check_bounds(NvmeCtrl *=
n, NvmeNamespace *ns,
>      return NVME_SUCCESS;
>  }
> =20
> +static void nvme_fill_data(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t =
offset,
> +                           uint32_t max_len, uint8_t pattern)
> +{
> +    ScatterGatherEntry *entry;
> +    uint32_t len, ent_len;
> +
> +    if (qsg->nsg > 0) {
> +        entry =3D qsg->sg;
> +        len =3D qsg->size;
> +        if (max_len) {
> +            len =3D MIN(len, max_len);
> +        }
> +        for (; len > 0; len -=3D ent_len) {
> +            ent_len =3D MIN(len, entry->len);
> +            if (offset > ent_len) {
> +                offset -=3D ent_len;
> +            } else if (offset !=3D 0) {
> +                dma_memory_set(qsg->as, entry->base + offset,
> +                               pattern, ent_len - offset);
> +                offset =3D 0;
> +            } else {
> +                dma_memory_set(qsg->as, entry->base, pattern, ent_len);
> +            }
> +            entry++;
> +        }
> +    } else if (iov->iov) {
> +        len =3D iov_size(iov->iov, iov->niov);
> +        if (max_len) {
> +            len =3D MIN(len, max_len);
> +        }
> +        qemu_iovec_memset(iov, offset, pattern, len - offset);
> +    }
> +}
> +
> +static uint16_t nvme_check_zone_write(NvmeZone *zone, uint64_t slba,
> +                                      uint32_t nlb)
> +{
> +    uint16_t status;
> +
> +    if (unlikely((slba + nlb) > nvme_zone_wr_boundary(zone))) {
> +        return NVME_ZONE_BOUNDARY_ERROR;
> +    }
> +
> +    switch (nvme_get_zone_state(zone)) {
> +    case NVME_ZONE_STATE_EMPTY:
> +    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
> +    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
> +    case NVME_ZONE_STATE_CLOSED:
> +        status =3D NVME_SUCCESS;
> +        break;
> +    case NVME_ZONE_STATE_FULL:
> +        status =3D NVME_ZONE_FULL;
> +        break;
> +    case NVME_ZONE_STATE_OFFLINE:
> +        status =3D NVME_ZONE_OFFLINE;
> +        break;
> +    case NVME_ZONE_STATE_READ_ONLY:
> +        status =3D NVME_ZONE_READ_ONLY;
> +        break;
> +    default:
> +        assert(false);
> +    }
> +    return status;
> +}
> +
> +static uint16_t nvme_check_zone_read(NvmeNamespace *ns, NvmeZone *zone,
> +                                     uint64_t slba, uint32_t nlb)
> +{
> +    uint64_t lba =3D slba, count;
> +    uint16_t status;
> +    uint8_t zs;
> +
> +    do {
> +        if (!ns->params.cross_zone_read &&
> +            (lba + nlb > nvme_zone_rd_boundary(ns, zone))) {
> +            return NVME_ZONE_BOUNDARY_ERROR | NVME_DNR;
> +        }
> +
> +        zs =3D nvme_get_zone_state(zone);
> +        switch (zs) {
> +        case NVME_ZONE_STATE_EMPTY:
> +        case NVME_ZONE_STATE_IMPLICITLY_OPEN:
> +        case NVME_ZONE_STATE_EXPLICITLY_OPEN:
> +        case NVME_ZONE_STATE_FULL:
> +        case NVME_ZONE_STATE_CLOSED:
> +        case NVME_ZONE_STATE_READ_ONLY:
> +            status =3D NVME_SUCCESS;
> +            break;
> +        case NVME_ZONE_STATE_OFFLINE:
> +            status =3D NVME_ZONE_OFFLINE | NVME_DNR;
> +            break;
> +        default:
> +            assert(false);
> +        }
> +        if (status !=3D NVME_SUCCESS) {
> +            break;
> +        }
> +
> +        if (lba + nlb > nvme_zone_rd_boundary(ns, zone)) {
> +            count =3D nvme_zone_rd_boundary(ns, zone) - lba;
> +        } else {
> +            count =3D nlb;
> +        }
> +
> +        lba +=3D count;
> +        nlb -=3D count;
> +        zone++;
> +    } while (nlb);
> +
> +    return status;
> +}
> +
> +static inline uint32_t nvme_zone_idx(NvmeNamespace *ns, uint64_t slba)
> +{
> +    return ns->zone_size_log2 > 0 ? slba >> ns->zone_size_log2 :
> +                                    slba / ns->zone_size;
> +}
> +
> +static bool nvme_finalize_zoned_write(NvmeNamespace *ns, NvmeRequest *re=
q,
> +                                      bool failed)
> +{
> +    NvmeRwCmd *rw =3D (NvmeRwCmd *)&req->cmd;
> +    NvmeZone *zone;
> +    uint64_t slba, start_wp =3D req->cqe.result64;
> +    uint32_t nlb, zone_idx;
> +    uint8_t zs;
> +
> +    if (rw->opcode !=3D NVME_CMD_WRITE &&
> +        rw->opcode !=3D NVME_CMD_ZONE_APPEND &&
> +        rw->opcode !=3D NVME_CMD_WRITE_ZEROES) {
> +        return false;
> +    }
> +
> +    slba =3D le64_to_cpu(rw->slba);
> +    nlb =3D le16_to_cpu(rw->nlb) + 1;
> +    zone_idx =3D nvme_zone_idx(ns, slba);
> +    assert(zone_idx < ns->num_zones);
> +    zone =3D &ns->zone_array[zone_idx];
> +
> +    if (!failed && zone->w_ptr < start_wp + nlb) {
> +        /*
> +         * A preceding queued write to the zone has failed,
> +         * now this write is not at the WP, fail it too.
> +         */
> +        failed =3D true;
> +    }
> +
> +    if (failed) {
> +        if (zone->w_ptr > start_wp) {
> +            zone->w_ptr =3D start_wp;
> +        }
> +        req->cqe.result64 =3D 0;
> +    } else if (zone->w_ptr =3D=3D nvme_zone_wr_boundary(zone)) {
> +        zs =3D nvme_get_zone_state(zone);
> +        switch (zs) {
> +        case NVME_ZONE_STATE_IMPLICITLY_OPEN:
> +        case NVME_ZONE_STATE_EXPLICITLY_OPEN:
> +        case NVME_ZONE_STATE_CLOSED:
> +        case NVME_ZONE_STATE_EMPTY:
> +            nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_FULL);
> +            /* fall through */
> +        case NVME_ZONE_STATE_FULL:
> +            break;
> +        default:
> +            assert(false);
> +        }
> +        zone->d.wp =3D zone->w_ptr;
> +    } else {
> +        zone->d.wp +=3D nlb;
> +    }
> +
> +    return failed;
> +}
> +
> +static uint64_t nvme_advance_zone_wp(NvmeNamespace *ns, NvmeZone *zone,
> +                                     uint32_t nlb)
> +{
> +    uint64_t result =3D zone->w_ptr;
> +    uint8_t zs;
> +
> +    zone->w_ptr +=3D nlb;
> +
> +    if (zone->w_ptr < nvme_zone_wr_boundary(zone)) {
> +        zs =3D nvme_get_zone_state(zone);
> +        switch (zs) {
> +        case NVME_ZONE_STATE_EMPTY:
> +        case NVME_ZONE_STATE_CLOSED:
> +            nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_IMPLICITLY_=
OPEN);
> +        }
> +    }
> +
> +    return result;
> +}
> +
>  static void nvme_rw_cb(void *opaque, int ret)
>  {
>      NvmeRequest *req =3D opaque;
> @@ -896,10 +1131,27 @@ static void nvme_rw_cb(void *opaque, int ret)
>      trace_pci_nvme_rw_cb(nvme_cid(req), blk_name(blk));
> =20
>      if (!ret) {
> -        block_acct_done(stats, acct);
> +        if (ns->params.zoned) {
> +            if (nvme_finalize_zoned_write(ns, req, false)) {
> +                ret =3D EIO;
> +                block_acct_failed(stats, acct);
> +                req->status =3D NVME_ZONE_INVALID_WRITE;
> +            } else if (req->fill_ofs >=3D 0) {
> +                nvme_fill_data(&req->qsg, &req->iov, req->fill_ofs,
> +                               req->fill_len,
> +                               nvme_ctrl(req)->params.fill_pattern);
> +            }
> +        }
> +        if (!ret) {
> +            block_acct_done(stats, acct);
> +        }
>      } else {
>          uint16_t status;
> =20
> +        if (ns->params.zoned) {
> +            nvme_finalize_zoned_write(ns, req, true);
> +        }
> +
>          block_acct_failed(stats, acct);
> =20
>          switch (req->cmd.opcode) {
> @@ -953,6 +1205,7 @@ static uint16_t nvme_do_aio(BlockBackend *blk, int64=
_t offset, size_t len,
>          break;
> =20
>      case NVME_CMD_WRITE:
> +    case NVME_CMD_ZONE_APPEND:
>          is_write =3D true;
> =20
>          /* fallthrough */
> @@ -997,8 +1250,10 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, Nvme=
Request *req)
>      NvmeNamespace *ns =3D req->ns;
>      uint64_t slba =3D le64_to_cpu(rw->slba);
>      uint32_t nlb =3D (uint32_t)le16_to_cpu(rw->nlb) + 1;
> +    NvmeZone *zone =3D NULL;
>      uint64_t offset =3D nvme_l2b(ns, slba);
>      uint32_t count =3D nvme_l2b(ns, nlb);
> +    uint32_t zone_idx;
>      uint16_t status;
> =20
>      trace_pci_nvme_write_zeroes(nvme_cid(req), nvme_nsid(ns), slba, nlb)=
;
> @@ -1009,20 +1264,43 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, Nv=
meRequest *req)
>          return status;
>      }
> =20
> +    if (ns->params.zoned) {
> +        zone_idx =3D nvme_zone_idx(ns, slba);
> +        assert(zone_idx < ns->num_zones);
> +        zone =3D &ns->zone_array[zone_idx];
> +
> +        status =3D nvme_check_zone_write(zone, slba, nlb);
> +        if (status !=3D NVME_SUCCESS) {
> +            trace_pci_nvme_err_zone_write_not_ok(slba, nlb, status);
> +            return status | NVME_DNR;
> +        }
> +
> +        assert(nvme_wp_is_valid(zone));
> +        if (unlikely(slba !=3D zone->w_ptr)) {
> +            trace_pci_nvme_err_write_not_at_wp(slba, zone->d.zslba,
> +                                               zone->w_ptr);
> +            return NVME_ZONE_INVALID_WRITE | NVME_DNR;
> +        }
> +
> +        req->cqe.result64 =3D nvme_advance_zone_wp(ns, zone, nlb);
> +    }
> +
>      return nvme_do_aio(ns->blkconf.blk, offset, count, req);
>  }
> =20
> -static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
> +static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req, bool append)
>  {
>      NvmeRwCmd *rw =3D (NvmeRwCmd *)&req->cmd;
>      NvmeNamespace *ns =3D req->ns;
> -    uint32_t nlb =3D (uint32_t)le16_to_cpu(rw->nlb) + 1;
> +    uint32_t nlb  =3D le32_to_cpu(rw->nlb) + 1;
>      uint64_t slba =3D le64_to_cpu(rw->slba);
> -
>      uint64_t data_size =3D nvme_l2b(ns, nlb);
> -    uint64_t data_offset =3D nvme_l2b(ns, slba);
> -    enum BlockAcctType acct =3D req->cmd.opcode =3D=3D NVME_CMD_WRITE ?
> -        BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
> +    uint64_t data_offset;
> +
> +    NvmeZone *zone =3D NULL;
> +    uint32_t zone_idx =3D 0;
> +    bool is_write =3D rw->opcode =3D=3D NVME_CMD_WRITE || append;
> +    enum BlockAcctType acct =3D is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT=
_READ;
>      uint16_t status;
> =20
>      trace_pci_nvme_rw(nvme_cid(req), nvme_io_opc_str(rw->opcode),
> @@ -1040,18 +1318,468 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest=
 *req)
>          goto invalid;
>      }
> =20
> +    if (ns->params.zoned) {
> +        zone_idx =3D nvme_zone_idx(ns, slba);
> +        assert(zone_idx < ns->num_zones);
> +        zone =3D &ns->zone_array[zone_idx];
> +
> +        if (is_write) {
> +            status =3D nvme_check_zone_write(zone, slba, nlb);
> +            if (status !=3D NVME_SUCCESS) {
> +                trace_pci_nvme_err_zone_write_not_ok(slba, nlb, status);
> +                goto invalid;
> +            }
> +
> +            assert(nvme_wp_is_valid(zone));
> +            if (append) {
> +                if (unlikely(slba !=3D zone->d.zslba)) {
> +                    trace_pci_nvme_err_append_not_at_start(slba, zone->d=
.zslba);
> +                    status =3D NVME_ZONE_INVALID_WRITE | NVME_DNR;
> +                    goto invalid;
> +                }
> +                if (data_size > (n->page_size << n->zasl)) {
> +                    trace_pci_nvme_err_append_too_large(slba, nlb, n->za=
sl);
> +                    status =3D NVME_INVALID_FIELD | NVME_DNR;
> +                    goto invalid;
> +                }
> +                slba =3D zone->w_ptr;
> +            } else if (unlikely(slba !=3D zone->w_ptr)) {
> +                trace_pci_nvme_err_write_not_at_wp(slba, zone->d.zslba,
> +                                                   zone->w_ptr);
> +                status =3D NVME_ZONE_INVALID_WRITE | NVME_DNR;
> +                goto invalid;
> +            }
> +            req->fill_ofs =3D -1LL;
> +        } else {
> +            status =3D nvme_check_zone_read(ns, zone, slba, nlb);
> +            if (status !=3D NVME_SUCCESS) {
> +                trace_pci_nvme_err_zone_read_not_ok(slba, nlb, status);
> +                goto invalid;
> +            }
> +
> +            if (slba + nlb > zone->w_ptr) {
> +                /*
> +                 * All or some data is read above the WP. Need to
> +                 * fill out the buffer area that has no backing data
> +                 * with a predefined data pattern (zeros by default)
> +                 */
> +                if (slba >=3D zone->w_ptr) {
> +                    req->fill_ofs =3D 0;
> +                } else {
> +                    req->fill_ofs =3D nvme_l2b(ns, zone->w_ptr - slba);
> +                }
> +                req->fill_len =3D nvme_l2b(ns,
> +                    nvme_zone_rd_boundary(ns, zone) - slba);
> +            } else {
> +                req->fill_ofs =3D -1LL;
> +            }
> +        }
> +    } else if (append) {
> +        trace_pci_nvme_err_invalid_opc(rw->opcode);
> +        status =3D NVME_INVALID_OPCODE | NVME_DNR;
> +        goto invalid;
> +    }
> +
>      status =3D nvme_map_dptr(n, data_size, req);
>      if (status) {
>          goto invalid;
>      }
> =20
> +    if (ns->params.zoned) {
> +        if (unlikely(req->fill_ofs =3D=3D 0 &&
> +            slba + nlb <=3D nvme_zone_rd_boundary(ns, zone))) {
> +            /* No backend I/O necessary, only need to fill the buffer */
> +            nvme_fill_data(&req->qsg, &req->iov, 0, 0, n->params.fill_pa=
ttern);
> +            req->status =3D NVME_SUCCESS;
> +            return NVME_SUCCESS;
> +        }
> +        if (is_write) {
> +            req->cqe.result64 =3D nvme_advance_zone_wp(ns, zone, nlb);
> +        }
> +    }
> +
> +    data_offset =3D nvme_l2b(ns, slba);
> +
>      return nvme_do_aio(ns->blkconf.blk, data_offset, data_size, req);
> =20
>  invalid:
>      block_acct_invalid(blk_get_stats(ns->blkconf.blk), acct);
> +    return status | NVME_DNR;
> +}
> +
> +static uint16_t nvme_get_mgmt_zone_slba_idx(NvmeNamespace *ns, NvmeCmd *=
c,
> +                                            uint64_t *slba, uint32_t *zo=
ne_idx)
> +{
> +    uint32_t dw10 =3D le32_to_cpu(c->cdw10);
> +    uint32_t dw11 =3D le32_to_cpu(c->cdw11);
> +
> +    if (!ns->params.zoned) {
> +        trace_pci_nvme_err_invalid_opc(c->opcode);
> +        return NVME_INVALID_OPCODE | NVME_DNR;
> +    }
> +
> +    *slba =3D ((uint64_t)dw11) << 32 | dw10;
> +    if (unlikely(*slba >=3D ns->id_ns.nsze)) {
> +        trace_pci_nvme_err_invalid_lba_range(*slba, 0, ns->id_ns.nsze);
> +        *slba =3D 0;
> +        return NVME_LBA_RANGE | NVME_DNR;
> +    }
> +
> +    *zone_idx =3D nvme_zone_idx(ns, *slba);
> +    assert(*zone_idx < ns->num_zones);
> +
> +    return NVME_SUCCESS;
> +}
> +
> +static uint16_t nvme_open_zone(NvmeNamespace *ns, NvmeZone *zone,
> +                               uint8_t state)
> +{
> +    switch (state) {
> +    case NVME_ZONE_STATE_EMPTY:
> +    case NVME_ZONE_STATE_CLOSED:
> +    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
> +        nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_EXPLICITLY_OPEN=
);
> +        /* fall through */
> +    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
> +        return NVME_SUCCESS;
> +    }
> +
> +    return NVME_ZONE_INVAL_TRANSITION;
> +}
> +
> +static bool nvme_cond_open_all(uint8_t state)
> +{
> +    return state =3D=3D NVME_ZONE_STATE_CLOSED;
> +}
> +
> +static uint16_t nvme_close_zone(NvmeNamespace *ns, NvmeZone *zone,
> +                                uint8_t state)
> +{
> +    switch (state) {
> +    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
> +    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
> +        nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_CLOSED);
> +        /* fall through */
> +    case NVME_ZONE_STATE_CLOSED:
> +        return NVME_SUCCESS;
> +    }
> +
> +    return NVME_ZONE_INVAL_TRANSITION;
> +}
> +
> +static bool nvme_cond_close_all(uint8_t state)
> +{
> +    return state =3D=3D NVME_ZONE_STATE_IMPLICITLY_OPEN ||
> +           state =3D=3D NVME_ZONE_STATE_EXPLICITLY_OPEN;
> +}
> +
> +static uint16_t nvme_finish_zone(NvmeNamespace *ns, NvmeZone *zone,
> +                                 uint8_t state)
> +{
> +    switch (state) {
> +    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
> +    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
> +    case NVME_ZONE_STATE_CLOSED:
> +    case NVME_ZONE_STATE_EMPTY:
> +        zone->w_ptr =3D nvme_zone_wr_boundary(zone);
> +        zone->d.wp =3D zone->w_ptr;
> +        nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_FULL);
> +        /* fall through */
> +    case NVME_ZONE_STATE_FULL:
> +        return NVME_SUCCESS;
> +    }
> +
> +    return NVME_ZONE_INVAL_TRANSITION;
> +}
> +
> +static bool nvme_cond_finish_all(uint8_t state)
> +{
> +    return state =3D=3D NVME_ZONE_STATE_IMPLICITLY_OPEN ||
> +           state =3D=3D NVME_ZONE_STATE_EXPLICITLY_OPEN ||
> +           state =3D=3D NVME_ZONE_STATE_CLOSED;
> +}
> +
> +static uint16_t nvme_reset_zone(NvmeNamespace *ns, NvmeZone *zone,
> +                                uint8_t state)
> +{
> +    switch (state) {
> +    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
> +    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
> +    case NVME_ZONE_STATE_CLOSED:
> +    case NVME_ZONE_STATE_FULL:
> +        zone->w_ptr =3D zone->d.zslba;
> +        zone->d.wp =3D zone->w_ptr;
> +        nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_EMPTY);
> +        /* fall through */
> +    case NVME_ZONE_STATE_EMPTY:
> +        return NVME_SUCCESS;
> +    }
> +
> +    return NVME_ZONE_INVAL_TRANSITION;
> +}
> +
> +static bool nvme_cond_reset_all(uint8_t state)
> +{
> +    return state =3D=3D NVME_ZONE_STATE_IMPLICITLY_OPEN ||
> +           state =3D=3D NVME_ZONE_STATE_EXPLICITLY_OPEN ||
> +           state =3D=3D NVME_ZONE_STATE_CLOSED ||
> +           state =3D=3D NVME_ZONE_STATE_FULL;
> +}
> +
> +static uint16_t nvme_offline_zone(NvmeNamespace *ns, NvmeZone *zone,
> +                                  uint8_t state)
> +{
> +    switch (state) {
> +    case NVME_ZONE_STATE_READ_ONLY:
> +        nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_OFFLINE);
> +        /* fall through */
> +    case NVME_ZONE_STATE_OFFLINE:
> +        return NVME_SUCCESS;
> +    }
> +
> +    return NVME_ZONE_INVAL_TRANSITION;
> +}
> +
> +static bool nvme_cond_offline_all(uint8_t state)
> +{
> +    return state =3D=3D NVME_ZONE_STATE_READ_ONLY;
> +}
> +
> +typedef uint16_t (*op_handler_t)(NvmeNamespace *, NvmeZone *,
> +                                 uint8_t);
> +typedef bool (*need_to_proc_zone_t)(uint8_t);
> +
> +static uint16_t name_do_zone_op(NvmeNamespace *ns, NvmeZone *zone,
> +                                uint8_t state, bool all,
> +                                op_handler_t op_hndlr,
> +                                need_to_proc_zone_t proc_zone)
> +{
> +    int i;
> +    uint16_t status =3D 0;
> +
> +    if (!all) {
> +        status =3D op_hndlr(ns, zone, state);
> +    } else {
> +        for (i =3D 0; i < ns->num_zones; i++, zone++) {
> +            state =3D nvme_get_zone_state(zone);
> +            if (proc_zone(state)) {
> +                status =3D op_hndlr(ns, zone, state);
> +                if (status !=3D NVME_SUCCESS) {
> +                    break;
> +                }
> +            }
> +        }
> +    }
> +
>      return status;
>  }
> =20
> +static uint16_t nvme_zone_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    NvmeCmd *cmd =3D (NvmeCmd *)&req->cmd;
> +    NvmeNamespace *ns =3D req->ns;
> +    uint32_t dw13 =3D le32_to_cpu(cmd->cdw13);
> +    uint64_t slba =3D 0;
> +    uint32_t zone_idx =3D 0;
> +    uint16_t status;
> +    uint8_t action, state;
> +    bool all;
> +    NvmeZone *zone;
> +
> +    action =3D dw13 & 0xff;
> +    all =3D dw13 & 0x100;
> +
> +    req->status =3D NVME_SUCCESS;
> +
> +    if (!all) {
> +        status =3D nvme_get_mgmt_zone_slba_idx(ns, cmd, &slba, &zone_idx=
);
> +        if (status) {
> +            return status;
> +        }
> +    }
> +
> +    zone =3D &ns->zone_array[zone_idx];
> +    if (slba !=3D zone->d.zslba) {
> +        trace_pci_nvme_err_unaligned_zone_cmd(action, slba, zone->d.zslb=
a);
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +    state =3D nvme_get_zone_state(zone);
> +
> +    switch (action) {
> +
> +    case NVME_ZONE_ACTION_OPEN:
> +        trace_pci_nvme_open_zone(slba, zone_idx, all);
> +        status =3D name_do_zone_op(ns, zone, state, all,
> +                                 nvme_open_zone, nvme_cond_open_all);
> +        break;
> +
> +    case NVME_ZONE_ACTION_CLOSE:
> +        trace_pci_nvme_close_zone(slba, zone_idx, all);
> +        status =3D name_do_zone_op(ns, zone, state, all,
> +                                 nvme_close_zone, nvme_cond_close_all);
> +        break;
> +
> +    case NVME_ZONE_ACTION_FINISH:
> +        trace_pci_nvme_finish_zone(slba, zone_idx, all);
> +        status =3D name_do_zone_op(ns, zone, state, all,
> +                                 nvme_finish_zone, nvme_cond_finish_all)=
;
> +        break;
> +
> +    case NVME_ZONE_ACTION_RESET:
> +        trace_pci_nvme_reset_zone(slba, zone_idx, all);
> +        status =3D name_do_zone_op(ns, zone, state, all,
> +                                 nvme_reset_zone, nvme_cond_reset_all);
> +        break;
> +
> +    case NVME_ZONE_ACTION_OFFLINE:
> +        trace_pci_nvme_offline_zone(slba, zone_idx, all);
> +        status =3D name_do_zone_op(ns, zone, state, all,
> +                                 nvme_offline_zone, nvme_cond_offline_al=
l);
> +        break;
> +
> +    case NVME_ZONE_ACTION_SET_ZD_EXT:
> +        trace_pci_nvme_set_descriptor_extension(slba, zone_idx);
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +        break;
> +
> +    default:
> +        trace_pci_nvme_err_invalid_mgmt_action(action);
> +        status =3D NVME_INVALID_FIELD;
> +    }
> +
> +    if (status =3D=3D NVME_ZONE_INVAL_TRANSITION) {
> +        trace_pci_nvme_err_invalid_zone_state_transition(state, action, =
slba,
> +                                                         zone->d.za);
> +    }
> +    if (status) {
> +        status |=3D NVME_DNR;
> +    }
> +
> +    return status;
> +}
> +
> +static bool nvme_zone_matches_filter(uint32_t zafs, NvmeZone *zl)
> +{
> +    int zs =3D nvme_get_zone_state(zl);
> +
> +    switch (zafs) {
> +    case NVME_ZONE_REPORT_ALL:
> +        return true;
> +    case NVME_ZONE_REPORT_EMPTY:
> +        return zs =3D=3D NVME_ZONE_STATE_EMPTY;
> +    case NVME_ZONE_REPORT_IMPLICITLY_OPEN:
> +        return zs =3D=3D NVME_ZONE_STATE_IMPLICITLY_OPEN;
> +    case NVME_ZONE_REPORT_EXPLICITLY_OPEN:
> +        return zs =3D=3D NVME_ZONE_STATE_EXPLICITLY_OPEN;
> +    case NVME_ZONE_REPORT_CLOSED:
> +        return zs =3D=3D NVME_ZONE_STATE_CLOSED;
> +    case NVME_ZONE_REPORT_FULL:
> +        return zs =3D=3D NVME_ZONE_STATE_FULL;
> +    case NVME_ZONE_REPORT_READ_ONLY:
> +        return zs =3D=3D NVME_ZONE_STATE_READ_ONLY;
> +    case NVME_ZONE_REPORT_OFFLINE:
> +        return zs =3D=3D NVME_ZONE_STATE_OFFLINE;
> +    default:
> +        return false;
> +    }
> +}
> +
> +static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    NvmeCmd *cmd =3D (NvmeCmd *)&req->cmd;
> +    NvmeNamespace *ns =3D req->ns;
> +    /* cdw12 is zero-based number of dwords to return. Convert to bytes =
*/
> +    uint32_t len =3D (le32_to_cpu(cmd->cdw12) + 1) << 2;
> +    uint32_t dw13 =3D le32_to_cpu(cmd->cdw13);
> +    uint32_t zone_idx, zra, zrasf, partial;
> +    uint64_t max_zones, nr_zones =3D 0;
> +    uint16_t ret;
> +    uint64_t slba;
> +    NvmeZoneDescr *z;
> +    NvmeZone *zs;
> +    NvmeZoneReportHeader *header;
> +    void *buf, *buf_p;
> +    size_t zone_entry_sz;
> +
> +    req->status =3D NVME_SUCCESS;
> +
> +    ret =3D nvme_get_mgmt_zone_slba_idx(ns, cmd, &slba, &zone_idx);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    if (len < sizeof(NvmeZoneReportHeader)) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    zra =3D dw13 & 0xff;
> +    if (!(zra =3D=3D NVME_ZONE_REPORT || zra =3D=3D NVME_ZONE_REPORT_EXT=
ENDED)) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    if (zra =3D=3D NVME_ZONE_REPORT_EXTENDED) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    zrasf =3D (dw13 >> 8) & 0xff;
> +    if (zrasf > NVME_ZONE_REPORT_OFFLINE) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    partial =3D (dw13 >> 16) & 0x01;
> +
> +    zone_entry_sz =3D sizeof(NvmeZoneDescr);
> +
> +    max_zones =3D (len - sizeof(NvmeZoneReportHeader)) / zone_entry_sz;
> +    buf =3D g_malloc0(len);
> +
> +    header =3D (NvmeZoneReportHeader *)buf;
> +    buf_p =3D buf + sizeof(NvmeZoneReportHeader);
> +
> +    while (zone_idx < ns->num_zones && nr_zones < max_zones) {
> +        zs =3D &ns->zone_array[zone_idx];
> +
> +        if (!nvme_zone_matches_filter(zrasf, zs)) {
> +            zone_idx++;
> +            continue;
> +        }
> +
> +        z =3D (NvmeZoneDescr *)buf_p;
> +        buf_p +=3D sizeof(NvmeZoneDescr);
> +        nr_zones++;
> +
> +        z->zt =3D zs->d.zt;
> +        z->zs =3D zs->d.zs;
> +        z->zcap =3D cpu_to_le64(zs->d.zcap);
> +        z->zslba =3D cpu_to_le64(zs->d.zslba);
> +        z->za =3D zs->d.za;
> +
> +        if (nvme_wp_is_valid(zs)) {
> +            z->wp =3D cpu_to_le64(zs->d.wp);
> +        } else {
> +            z->wp =3D cpu_to_le64(~0ULL);
> +        }
> +
> +        zone_idx++;
> +    }
> +
> +    if (!partial) {
> +        for (; zone_idx < ns->num_zones; zone_idx++) {
> +            zs =3D &ns->zone_array[zone_idx];
> +            if (nvme_zone_matches_filter(zrasf, zs)) {
> +                nr_zones++;
> +            }
> +        }
> +    }
> +    header->nr_zones =3D cpu_to_le64(nr_zones);
> +
> +    ret =3D nvme_dma(n, (uint8_t *)buf, len, DMA_DIRECTION_FROM_DEVICE, =
req);
> +
> +    g_free(buf);
> +
> +    return ret;
> +}
> +
>  static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
>  {
>      uint32_t nsid =3D le32_to_cpu(req->cmd.nsid);
> @@ -1073,9 +1801,15 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeReque=
st *req)

While you did make sure that we don't expose zone mgmt send/recv/zone appen=
d
in the cmd_effects log when CC.CSS !=3D CSS_CSI, we also need to make sure =
we
return Invalid Command Opcode for any of those three commands, if a user tr=
ies
to use them anyway (while CC.CSS !=3D CSI).

>          return nvme_flush(n, req);
>      case NVME_CMD_WRITE_ZEROES:
>          return nvme_write_zeroes(n, req);
> +    case NVME_CMD_ZONE_APPEND:
> +        return nvme_rw(n, req, true);
>      case NVME_CMD_WRITE:
>      case NVME_CMD_READ:
> -        return nvme_rw(n, req);
> +        return nvme_rw(n, req, false);
> +    case NVME_CMD_ZONE_MGMT_SEND:
> +        return nvme_zone_mgmt_send(n, req);
> +    case NVME_CMD_ZONE_MGMT_RECV:
> +        return nvme_zone_mgmt_recv(n, req);
>      default:
>          trace_pci_nvme_err_invalid_opc(req->cmd.opcode);
>          return NVME_INVALID_OPCODE | NVME_DNR;
> @@ -1301,7 +2035,7 @@ static uint16_t nvme_error_info(NvmeCtrl *n, uint8_=
t rae, uint32_t buf_len,
>                      DMA_DIRECTION_FROM_DEVICE, req);
>  }
> =20
> -static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint32_t buf_len,
> +static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint8_t csi, uint32_t buf_=
len,
>                                   uint64_t off, NvmeRequest *req)
>  {
>      NvmeEffectsLog cmd_eff_log =3D {};
> @@ -1326,11 +2060,20 @@ static uint16_t nvme_cmd_effects(NvmeCtrl *n, uin=
t32_t buf_len,
>      acs[NVME_ADM_CMD_GET_LOG_PAGE] =3D NVME_CMD_EFFECTS_CSUPP;
>      acs[NVME_ADM_CMD_ASYNC_EV_REQ] =3D NVME_CMD_EFFECTS_CSUPP;
> =20
> -    iocs[NVME_CMD_FLUSH] =3D NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_L=
BCC;
> -    iocs[NVME_CMD_WRITE_ZEROES] =3D NVME_CMD_EFFECTS_CSUPP |
> -                                  NVME_CMD_EFFECTS_LBCC;
> -    iocs[NVME_CMD_WRITE] =3D NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_L=
BCC;
> -    iocs[NVME_CMD_READ] =3D NVME_CMD_EFFECTS_CSUPP;
> +    if (NVME_CC_CSS(n->bar.cc) !=3D CSS_ADMIN_ONLY) {
> +        iocs[NVME_CMD_FLUSH] =3D NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFEC=
TS_LBCC;
> +        iocs[NVME_CMD_WRITE_ZEROES] =3D NVME_CMD_EFFECTS_CSUPP |
> +                                      NVME_CMD_EFFECTS_LBCC;
> +        iocs[NVME_CMD_WRITE] =3D NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFEC=
TS_LBCC;
> +        iocs[NVME_CMD_READ] =3D NVME_CMD_EFFECTS_CSUPP;
> +    }
> +
> +    if (csi =3D=3D NVME_CSI_ZONED && NVME_CC_CSS(n->bar.cc) =3D=3D CSS_C=
SI) {
> +        iocs[NVME_CMD_ZONE_APPEND] =3D NVME_CMD_EFFECTS_CSUPP |
> +                                     NVME_CMD_EFFECTS_LBCC;
> +        iocs[NVME_CMD_ZONE_MGMT_SEND] =3D NVME_CMD_EFFECTS_CSUPP;
> +        iocs[NVME_CMD_ZONE_MGMT_RECV] =3D NVME_CMD_EFFECTS_CSUPP;
> +    }
> =20
>      trans_len =3D MIN(sizeof(cmd_eff_log) - off, buf_len);
> =20
> @@ -1349,6 +2092,7 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeReque=
st *req)
>      uint8_t  lid =3D dw10 & 0xff;
>      uint8_t  lsp =3D (dw10 >> 8) & 0xf;
>      uint8_t  rae =3D (dw10 >> 15) & 0x1;
> +    uint8_t csi =3D le32_to_cpu(cmd->cdw14) >> 24;
>      uint32_t numdl, numdu;
>      uint64_t off, lpol, lpou;
>      size_t   len;
> @@ -1382,7 +2126,7 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeReque=
st *req)
>      case NVME_LOG_FW_SLOT_INFO:
>          return nvme_fw_log_info(n, len, off, req);
>      case NVME_LOG_CMD_EFFECTS:
> -        return nvme_cmd_effects(n, len, off, req);
> +        return nvme_cmd_effects(n, csi, len, off, req);
>      default:
>          trace_pci_nvme_err_invalid_log_page(nvme_cid(req), lid);
>          return NVME_INVALID_FIELD | NVME_DNR;
> @@ -1502,6 +2246,16 @@ static uint16_t nvme_rpt_empty_id_struct(NvmeCtrl =
*n, NvmeRequest *req)
>      return nvme_dma(n, id, sizeof(id), DMA_DIRECTION_FROM_DEVICE, req);
>  }
> =20
> +static inline bool nvme_csi_has_nvm_support(NvmeNamespace *ns)
> +{
> +    switch (ns->csi) {
> +    case NVME_CSI_NVM:
> +    case NVME_CSI_ZONED:
> +        return true;
> +    }
> +    return false;
> +}
> +
>  static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeRequest *req)
>  {
>      trace_pci_nvme_identify_ctrl();
> @@ -1513,11 +2267,16 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, N=
vmeRequest *req)
>  static uint16_t nvme_identify_ctrl_csi(NvmeCtrl *n, NvmeRequest *req)
>  {
>      NvmeIdentify *c =3D (NvmeIdentify *)&req->cmd;
> +    NvmeIdCtrlZoned id =3D {};
> =20
>      trace_pci_nvme_identify_ctrl_csi(c->csi);
> =20
>      if (c->csi =3D=3D NVME_CSI_NVM) {
>          return nvme_rpt_empty_id_struct(n, req);
> +    } else if (c->csi =3D=3D NVME_CSI_ZONED) {
> +        id.zasl =3D n->zasl;
> +        return nvme_dma(n, (uint8_t *)&id, sizeof(id),
> +                        DMA_DIRECTION_FROM_DEVICE, req);

Please read my comment on nvme_identify_nslist_csi() before reading
this comment.

At least for this function, the specification is clear:

"If the host requests a data structure for an I/O Command Set that the
controller does not support, the controller shall abort the command with
a status of Invalid Field in Command."

If the controller supports the I/O command set =3D=3D if the Command Set bi=
t
is set in the data struct returned by the nvme_identify_cmd_set(),
so here we should do something like:

} else if (->csi =3D=3D NVME_CSI_ZONED && ctrl_has_zns_namespaces()) {
	...
}

>      }
> =20
>      return NVME_INVALID_FIELD | NVME_DNR;
> @@ -1545,8 +2304,12 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, Nvme=
Request *req,
>          return nvme_rpt_empty_id_struct(n, req);
>      }
> =20
> -    return nvme_dma(n, (uint8_t *)&ns->id_ns, sizeof(NvmeIdNs),
> -                    DMA_DIRECTION_FROM_DEVICE, req);
> +    if (c->csi =3D=3D NVME_CSI_NVM && nvme_csi_has_nvm_support(ns)) {
> +        return nvme_dma(n, (uint8_t *)&ns->id_ns, sizeof(NvmeIdNs),
> +                        DMA_DIRECTION_FROM_DEVICE, req);
> +    }
> +
> +    return NVME_INVALID_CMD_SET | NVME_DNR;
>  }
> =20
>  static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req,
> @@ -1571,8 +2334,11 @@ static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, =
NvmeRequest *req,
>          return nvme_rpt_empty_id_struct(n, req);
>      }
> =20
> -    if (c->csi =3D=3D NVME_CSI_NVM) {
> +    if (c->csi =3D=3D NVME_CSI_NVM && nvme_csi_has_nvm_support(ns)) {
>          return nvme_rpt_empty_id_struct(n, req);
> +    } else if (c->csi =3D=3D NVME_CSI_ZONED && ns->csi =3D=3D NVME_CSI_Z=
ONED) {
> +        return nvme_dma(n, (uint8_t *)ns->id_ns_zoned, sizeof(NvmeIdNsZo=
ned),
> +                        DMA_DIRECTION_FROM_DEVICE, req);
>      }
> =20
>      return NVME_INVALID_FIELD | NVME_DNR;
> @@ -1634,7 +2400,7 @@ static uint16_t nvme_identify_nslist_csi(NvmeCtrl *=
n, NvmeRequest *req,
> =20
>      trace_pci_nvme_identify_nslist_csi(min_nsid, c->csi);
> =20
> -    if (c->csi !=3D NVME_CSI_NVM) {
> +    if (c->csi !=3D NVME_CSI_NVM && c->csi !=3D NVME_CSI_ZONED) {

When reading the specification for CNS 07h, I think that it is not clear
how this should behave...

I'm thinking in the case when c->csi =3D=3D NVME_CSI_ZONED
when our QEMU model does only have NVMe namespaces.

Either we should return an empty list (1),
or we should return Invalid Field in Command (2).

If we decide to go with (2),
then we should probably take the code you have written in nvme_identify_cmd=
_set():

+    for (i =3D 1; i <=3D n->num_namespaces; i++) {
+        ns =3D nvme_ns(n, i);
+        if (ns && ns->params.zoned) {
+            NVME_SET_CSI(*list, NVME_CSI_ZONED);
+            break;
+        }
+    }

And move it into a ctrl_has_zns_namespaces() helper function,
and then do something like:
if (!(c->csi =3D=3D NVME_CSI_NVM || (ctrl_has_zns_namespaces() && c->csi =
=3D=3D NVME_CSI_ZONED))=20
	return NVME_INVALID_FIELD | NVME_DNR;


>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
> =20
> @@ -1643,7 +2409,7 @@ static uint16_t nvme_identify_nslist_csi(NvmeCtrl *=
n, NvmeRequest *req,
>          if (!ns) {
>              continue;
>          }
> -        if (ns->params.nsid < min_nsid) {
> +        if (ns->params.nsid < min_nsid || c->csi !=3D ns->csi) {
>              continue;
>          }
>          if (only_active && !ns->params.attached) {
> @@ -1696,19 +2462,29 @@ static uint16_t nvme_identify_ns_descr_list(NvmeC=
trl *n, NvmeRequest *req)
>      desc->nidt =3D NVME_NIDT_CSI;
>      desc->nidl =3D NVME_NIDL_CSI;
>      list_ptr +=3D sizeof(*desc);
> -    *(uint8_t *)list_ptr =3D NVME_CSI_NVM;
> +    *(uint8_t *)list_ptr =3D ns->csi;
> =20
>      return nvme_dma(n, list, data_len, DMA_DIRECTION_FROM_DEVICE, req);
>  }
> =20
>  static uint16_t nvme_identify_cmd_set(NvmeCtrl *n, NvmeRequest *req)
>  {
> +    NvmeNamespace *ns;
>      uint8_t list[NVME_IDENTIFY_DATA_SIZE] =3D {};
>      static const int data_len =3D sizeof(list);
> +    int i;
> =20
>      trace_pci_nvme_identify_cmd_set();
> =20
>      NVME_SET_CSI(*list, NVME_CSI_NVM);
> +    for (i =3D 1; i <=3D n->num_namespaces; i++) {
> +        ns =3D nvme_ns(n, i);
> +        if (ns && ns->params.zoned) {
> +            NVME_SET_CSI(*list, NVME_CSI_ZONED);
> +            break;
> +        }
> +    }
> +
>      return nvme_dma(n, list, data_len, DMA_DIRECTION_FROM_DEVICE, req);
>  }
> =20
> @@ -1751,7 +2527,7 @@ static uint16_t nvme_abort(NvmeCtrl *n, NvmeRequest=
 *req)
>  {
>      uint16_t sqid =3D le32_to_cpu(req->cmd.cdw10) & 0xffff;
> =20
> -    req->cqe.result =3D 1;
> +    req->cqe.result32 =3D 1;
>      if (nvme_check_sqid(n, sqid)) {
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
> @@ -1932,7 +2708,7 @@ defaults:
>      }
> =20
>  out:
> -    req->cqe.result =3D cpu_to_le32(result);
> +    req->cqe.result32 =3D cpu_to_le32(result);
>      return NVME_SUCCESS;
>  }
> =20
> @@ -2057,8 +2833,8 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeR=
equest *req)
>                                      ((dw11 >> 16) & 0xFFFF) + 1,
>                                      n->params.max_ioqpairs,
>                                      n->params.max_ioqpairs);
> -        req->cqe.result =3D cpu_to_le32((n->params.max_ioqpairs - 1) |
> -                                      ((n->params.max_ioqpairs - 1) << 1=
6));
> +        req->cqe.result32 =3D cpu_to_le32((n->params.max_ioqpairs - 1) |
> +                                        ((n->params.max_ioqpairs - 1) <<=
 16));
>          break;
>      case NVME_ASYNCHRONOUS_EVENT_CONF:
>          n->features.async_config =3D dw11;
> @@ -2310,16 +3086,28 @@ static int nvme_start_ctrl(NvmeCtrl *n)
>              continue;
>          }
>          ns->params.attached =3D false;
> -        switch (ns->params.csi) {
> +        switch (ns->csi) {
>          case NVME_CSI_NVM:
>              if (NVME_CC_CSS(n->bar.cc) =3D=3D CSS_NVM_ONLY ||
>                  NVME_CC_CSS(n->bar.cc) =3D=3D CSS_CSI) {
>                  ns->params.attached =3D true;
>              }
>              break;
> +        case NVME_CSI_ZONED:
> +            if (NVME_CC_CSS(n->bar.cc) =3D=3D CSS_CSI) {
> +                ns->params.attached =3D true;
> +            }
> +            break;
>          }
>      }

Like I wrote in my review comment in the patch that added support for the n=
ew
allocated CNS values, I prefer if we remove this for-loop completely, and
simply set attached =3D true in nvme_ns_setup()/nvme_ns_init() instead.

(I was considering if we should set attach =3D true in nvme_zoned_init_ns()=
,
but because nvme_ns_setup()/nvme_ns_init() is called for all namespaces,
including ZNS namespaces, I don't think that any additional code in
nvme_zoned_init_ns() is warranted.)

> =20
> +    if (!n->zasl_bs) {
> +        assert(n->params.mdts);
> +        n->zasl =3D n->params.mdts;
> +    } else {
> +        n->zasl =3D 31 - clz32(n->zasl_bs / n->page_size);
> +    }
> +
>      nvme_set_timestamp(n, 0ULL);
> =20
>      QTAILQ_INIT(&n->aer_queue);
> @@ -2382,10 +3170,11 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr of=
fset, uint64_t data,
>                  case CSS_NVM_ONLY:
>                      trace_pci_nvme_css_nvm_cset_selected_by_host(data &
>                                                                   0xfffff=
fff);
> -                    break;
> +                break;
>                  case CSS_CSI:
>                      NVME_SET_CC_CSS(n->bar.cc, CSS_CSI);
> -                    trace_pci_nvme_css_all_csets_sel_by_host(data & 0xff=
ffffff);
> +                    trace_pci_nvme_css_all_csets_sel_by_host(data &
> +                                                             0xffffffff)=
;
>                      break;
>                  case CSS_ADMIN_ONLY:
>                      break;
> @@ -2780,6 +3569,12 @@ static void nvme_init_state(NvmeCtrl *n)
>      n->features.temp_thresh_hi =3D NVME_TEMPERATURE_WARNING;
>      n->starttime_ms =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
>      n->aer_reqs =3D g_new0(NvmeRequest *, n->params.aerl + 1);
> +
> +    if (!n->params.zasl_kb) {
> +        n->zasl_bs =3D n->params.mdts ? 0 : NVME_DEFAULT_MAX_ZA_SIZE * K=
iB;
> +    } else {
> +        n->zasl_bs =3D n->params.zasl_kb * KiB;
> +    }
>  }
> =20
>  int nvme_register_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp=
)
> @@ -2985,8 +3780,9 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *=
pci_dev)
>      NVME_CAP_SET_CQR(n->bar.cap, 1);
>      NVME_CAP_SET_TO(n->bar.cap, 0xf);
>      /*
> -     * The device now always supports NS Types, but all commands
> -     * that support CSI field will only handle NVM Command Set.
> +     * The device now always supports NS Types, even when "zoned" proper=
ty
> +     * is set to zero. If this is the case, all commands that support CS=
I
> +     * field only handle NVM Command Set.
>       */
>      NVME_CAP_SET_CSS(n->bar.cap, (CAP_CSS_NVM | CAP_CSS_CSI_SUPP));
>      NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
> @@ -3033,9 +3829,21 @@ static void nvme_realize(PCIDevice *pci_dev, Error=
 **errp)
>  static void nvme_exit(PCIDevice *pci_dev)
>  {
>      NvmeCtrl *n =3D NVME(pci_dev);
> +    NvmeNamespace *ns;
> +    int i;
> =20
>      nvme_clear_ctrl(n);
> +
> +    for (i =3D 1; i <=3D n->num_namespaces; i++) {
> +        ns =3D nvme_ns(n, i);
> +        if (!ns) {
> +            continue;
> +        }
> +
> +        nvme_ns_cleanup(ns);
> +    }
>      g_free(n->namespaces);
> +
>      g_free(n->cq);
>      g_free(n->sq);
>      g_free(n->aer_reqs);
> @@ -3063,6 +3871,8 @@ static Property nvme_props[] =3D {
>      DEFINE_PROP_UINT32("aer_max_queued", NvmeCtrl, params.aer_max_queued=
, 64),
>      DEFINE_PROP_UINT8("mdts", NvmeCtrl, params.mdts, 7),
>      DEFINE_PROP_BOOL("use-intel-id", NvmeCtrl, params.use_intel_id, fals=
e),
> +    DEFINE_PROP_UINT8("fill_pattern", NvmeCtrl, params.fill_pattern, 0),
> +    DEFINE_PROP_UINT32("zone_append_size_limit", NvmeCtrl, params.zasl_k=
b, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index a7126e123f..628c665728 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -651,8 +651,10 @@ typedef struct QEMU_PACKED NvmeAerResult {
>  } NvmeAerResult;
> =20
>  typedef struct QEMU_PACKED NvmeCqe {
> -    uint32_t    result;
> -    uint32_t    rsvd;
> +    union {
> +        uint64_t     result64;
> +        uint32_t     result32;
> +    };
>      uint16_t    sq_head;
>      uint16_t    sq_id;
>      uint16_t    cid;
> --=20
> 2.21.0
> =

