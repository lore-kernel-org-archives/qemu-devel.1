Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAF3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4687A20672
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C7uDkT8o";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="u7lxj4dK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4687A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqHAw-0001Ut-IG
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 10:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=44341d4e9=Niklas.Cassel@wdc.com>)
 id 1jqFrW-0006ZE-8g; Tue, 30 Jun 2020 08:59:46 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:14644)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=44341d4e9=Niklas.Cassel@wdc.com>)
 id 1jqFrS-0008IB-RZ; Tue, 30 Jun 2020 08:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593521984; x=1625057984;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=aeBK6SiDAg1vx1dOnPPf1enXjRTroS/bBlbyIWSw7D0=;
 b=C7uDkT8oFpb5L7NWaImH9QkUiV2UJ7ht9y5X6F1Hd3beedNWxafsu5pu
 EY23pBu1o7/72SMYo8z6lEqXjuir/PMo2qJV2dzgDW/q4FyiyncvZdNGP
 HOzD0ZeCCUDpMzx4ui75aTFQOyBNHWBnLpygpd1OEANdOuidKKSzXGa2o
 5Hx3Svrf+ITEixZ+ME7Zp2xsQj1kgkv+NNZ/GTCWpKK156QHwuT9vOYvw
 Aa50IsNNesuaIGGJwzUN/kKFBXN8nscAaNQcyAdVKhcPb9i8AM6TWO2aN
 y2ustmrYtZIYzdain5/xewHZh3SXpMMn391M7McqQ+nnB5TqvJ4qb2RRP g==;
IronPort-SDR: ALLaE3sfsr0OuFhEWYzx7Eaio905BWate0Lc1O6/nVH5oVe6TcMP6FOG3seY6Iv39MTa0a1K06
 FDKg9E6gSdXTSwBw434tODaioW7a+zNLZxYX2sj7ujCPKgKHSDUgX/2CyBE/vwEhDec3DeTQw0
 zlQ9JA9ZxMKeSXmrxQa0ZM2TFgwy2B+AoNN2KwfbR58+8IRKBfvA8t0gQnzbaZQb4VvJyqb66b
 K+DefnTLU+K5hOE8KIhjYbiEIvQ7APM/teB4/DP5CEFKph0/k8wACLTVHcwPDsKmGbKKe8TMnk
 QvI=
X-IronPort-AV: E=Sophos;i="5.75,297,1589212800"; d="scan'208";a="145597051"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
 by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2020 20:59:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ns1D2/zHa+ByUwqjiZ79VUo4opVRxV3i5/Q8HWlq5QTFymKg0nXeVUSK9O+LY7+oeZpUw32XJHU/Pv1NStwtIl4V1TORPLxCsyQJocDOpOByj+33FdArsj9IWQhI0ePdWNwXgzCKZ23TdTUddx/6oYbJuvolwtC4NTYjLGts1EqWtFBAJhXXVLVHRIjZwT4+XmNMZjxQ+jCC0g5I/9D7xvfQbKGKF12GINDahHKe85nQCpk3LWDqC5SQ62/rFViuY5zPIfY+mzKO6kz4PZ7CGXX7Kqdwf076lD6Fi7VRsSoYhD27udJYSs4/mBOy4xxP04llQ9Cv5uCIg02jBYIIyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFm7V0HGdzjXos2dLjB2DraQhtOd1e34Z9RIWH+rlQk=;
 b=cmgSx3mqNGWW55J2+rwfxcTtFBvnkxqA9lUdCbo2Th2VqmOyfKfLbRlW5uoB3MRzFDL30CqLtJdH/lSiW0HrGd2+qR22BApJLI3Ect3CfNFiqtSoRt4teoa332vfkWB6IyOs+21hlJCbCig7SIHZ65FXja5AoWEyrtIcQdLnINKqAqLBvsnC75htGmAeVqzIh97kImO41I5mvsaUj2SZrlajMj30bh3Vgy3+0IVcNBCuVvT3DPjrAkabq9XQtKcj9X+Wvse49za2Pm24nj/AzrNR5uhGzRWVfzQ7Ts7sG6vOTF5ZrfM5sqXe7BUlPRyTWfEkpIu0hwntPefFuyiO5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFm7V0HGdzjXos2dLjB2DraQhtOd1e34Z9RIWH+rlQk=;
 b=u7lxj4dK9iyqGnLxCC97kEuV/HS8fe/Ru2dL8BN4qE4LAyF2hnPcmKfzYNa0WiPYc5RnJvwDO3LBNOCAWmASLuId+gQBaQ6xBdT59v14W9l2R3RThvB1WgqiR7WrdZ/XJ1A31cScRIOjLvLjDWfULHepoquEsuzrKSnH/+uDwNI=
Received: from BYAPR04MB5112.namprd04.prod.outlook.com (2603:10b6:a03:45::10)
 by BYAPR04MB4776.namprd04.prod.outlook.com (2603:10b6:a03:11::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Tue, 30 Jun
 2020 12:59:33 +0000
Received: from BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b]) by BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b%6]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 12:59:33 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 00/10] hw/block/nvme: namespace types and zoned namespaces
Thread-Topic: [PATCH 00/10] hw/block/nvme: namespace types and zoned namespaces
Thread-Index: AQHWTsV/pjwwjyRMkUSo9H5IUgtdGqjxHw0A
Date: Tue, 30 Jun 2020 12:59:33 +0000
Message-ID: <20200630125932.GA553472@localhost.localdomain>
References: <20200630100139.1483002-1-its@irrelevant.dk>
In-Reply-To: <20200630100139.1483002-1-its@irrelevant.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.224.200.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 891daf93-3af4-4a7b-449d-08d81cf56fac
x-ms-traffictypediagnostic: BYAPR04MB4776:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4776EA0C7958D713252E178EF26F0@BYAPR04MB4776.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PmLcf4GgPQpJW1zlWCZgHRxQhxhSoluTOEwMbg+hj2CjbQ0hcUVgxlA1FjCU/Cv4aPeRltXfYzkylMcKBv0wrx+8qIpTfXU7e4t/sZmtAeF8UKm4bs44azFeqj5PQ1pH9Q1tysYE3boEZDgzldzpeH9z5nZPx783Wacn9+ylbA9FbQ9B/Gr7Q0imVtsv85AtRxSw5Y3dkN6ihJu0UdTJfITE2bLV2xyyjGIuiUavCBxXs9xJv2lSq4xAMm0ccvFRcw65uiGN+kRDQir2rXXLUwKxRldVs/A7/1hc7PlpqAdo6rnt2dS0wqtZfs/bwVrw94/5NYwNTofNQv8atRHUWXrY4uFrEkoZYHnydFs8PwCuuKXnrpLd+vOEaD+lGGV5hkcVmsH2us+aHdrjH1iH2A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB5112.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(1076003)(6916009)(6506007)(9686003)(6512007)(54906003)(316002)(4326008)(186003)(26005)(966005)(83380400001)(66556008)(64756008)(478600001)(86362001)(8936002)(2906002)(7416002)(71200400001)(66946007)(8676002)(33656002)(5660300002)(76116006)(91956017)(66446008)(66476007)(6486002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: GgtWlzTcPqPniLiSFkQk58nVbp+nB8zzbxzt1m2tf/aq/BR25ivnwNFULPEAprF86YyQUzoDNE505yiHXeV4FWQy6IQYDunsWdw32EHjXsHfDXIjyqoAibQj508p7ggTlL50HCL99IIU/KX+09PmVk3ftUofsRgklvqFRtGIZcv34jh0gG42II1eaAiU63Mdbq2I9fgd4GWMQCfcyCsZ1Jpc9+ps4YOlHbzNTeDwCGFt87l8Jk1aC4ePj0GpPlid9lFDRO9CoXrVU0W5PDE7xzU3eX8G18OpflQVQzUL2OAi26NsPEM/OQ42NaL7knTRyDTr7OPFfIQDmCL4NE/KveIBIT2PNa4La6cM4IcZtMXzIXolA2/Y9ZqoRUd07zigaFCtTS7MRrf8BE+rm3N7qvKTaM/uPCQBedwPW4dr1SVu4WuFNn0AyK8LD8lpugls7ouKqTKK7q1KCoscrcnsS380J0igDHPqnrAfUtkncvbM68MnscfDnidrzxP1dejC
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <C0DCD4E4CDAA4543B4616C07E7E6B1AB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB5112.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891daf93-3af4-4a7b-449d-08d81cf56fac
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 12:59:33.7162 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dnko55gkzwkTtFZO85+SLvMtcck/2V6tWrQ2qcryJdBkJKMC8c9uuxELiDCg3OsSyC9vPZJy8HsySaFzJc6qdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4776
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=44341d4e9=Niklas.Cassel@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 08:59:39
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 30 Jun 2020 10:22:57 -0400
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
Cc: Kevin Wolf <kwolf@redhat.com>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 30, 2020 at 12:01:29PM +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> Hi all,

Hello Klaus,

>=20
> This series adds support for TP 4056 ("Namespace Types") and TP 4053
> ("Zoned Namespaces") and is an alternative implementation to the one
> submitted by Dmitry[1].
>=20
> While I don't want this to end up as a discussion about the merits of
> each version, I want to point out a couple of differences from Dmitry's
> version. At a glance, my version
>=20
>   * builds on my patch series that adds fairly complete NVMe v1.4
>     mandatory support, as well as nice-to-have feature such as SGLs,
>     multiple namespaces and mostly just overall clean up. This finally
>     brings the nvme device into a fairly compliant state on which we can
>     add new features. I've tried hard to get these compliance and
>     clean-up patches merged for a long time (in parallel with developing
>     the emulation of NST and ZNS) and I would be really sad to see them
>     by-passed since they have already been through many iterations and
>     already carries Acked- and Reviewed-by's for the bulk of the
>     patches. I think the nvme device is already in a "frankenstate" wrt.
>     the implemented nvme version and the features it currently supports,
>     so I think this kind of cleanup is long overdue.
>=20
>   * uses an attached blockdev and standard blk_aio for persistent zone
>     info. This is the same method used in our patches for Write
>     Uncorrectable and (separate and extended lba) metadata support, but
>     I've left those optional features out for now to ease the review
>     process.
>=20
>   * relies on the universal dulbe support added in ("hw/block/nvme: add
>     support for dulbe") and sparse images for handling reads in gaps
>     (above write pointer and below ZSZE); that is - the size of the
>     underlying blockdev is in terms of ZSZE, not ZCAP
>=20
>   * the controller uses timers to autonomously finish zones (wrt. FRL)

AFAICT, Dmitry's patches does this as well.

>=20
> I've been on paternity leave for a month, so I havn't been around to
> review Dmitry's patches, but I have started that process now. I would
> also be happy to work with Dmitry & Friends on merging our versions to
> get the best of both worlds if it makes sense.
>=20
> This series and all preparatory patch sets (the ones I've been posting
> yesterday and today) are available on my GitHub[2]. Unfortunately
> Patchew got screwed up in the middle of me sending patches and it never
> picked up v2 of "hw/block/nvme: support multiple namespaces" because it
> was getting late and I made a mistake with the CC's. So my posted series
> don't apply according to Patchew, but they actually do if you follow the
> Based-on's (... or just grab [2]).
>=20
>=20
>   [1]: Message-Id: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
>   [2]: https://github.com/birkelund/qemu/tree/for-master/nvme
>=20
>=20
> Based-on: <20200630043122.1307043-1-its@irrelevant.dk>
> ("[PATCH 0/3] hw/block/nvme: bump to v1.4")

Is this the only patch series that this series depends on?

In the beginning of the cover letter, you mentioned
"NVMe v1.4 mandatory support", "SGLs", "multiple namespaces",
and "and mostly just overall clean up".

>=20
> Klaus Jensen (10):
>   hw/block/nvme: support I/O Command Sets
>   hw/block/nvme: add zns specific fields and types
>   hw/block/nvme: add basic read/write for zoned namespaces
>   hw/block/nvme: add the zone management receive command
>   hw/block/nvme: add the zone management send command
>   hw/block/nvme: add the zone append command
>   hw/block/nvme: track and enforce zone resources
>   hw/block/nvme: allow open to close transitions by controller
>   hw/block/nvme: allow zone excursions
>   hw/block/nvme: support reset/finish recommended limits
>=20
>  block/nvme.c          |    6 +-
>  hw/block/nvme-ns.c    |  397 +++++++++-
>  hw/block/nvme-ns.h    |  148 +++-
>  hw/block/nvme.c       | 1676 +++++++++++++++++++++++++++++++++++++++--
>  hw/block/nvme.h       |   76 +-
>  hw/block/trace-events |   43 +-
>  include/block/nvme.h  |  252 ++++++-
>  7 files changed, 2469 insertions(+), 129 deletions(-)
>=20
> --=20
> 2.27.0
>=20

I think that you have done a great job getting the NVMe
driver out of a frankenstate, and made it compliant with
a proper spec (NVMe 1.4).

I'm also a big fan of the refactoring so that the driver
handles more than one namespace, and the new bus model.

I know that you first sent your
"nvme: support NVMe v1.3d, SGLs and multiple namespaces"
patch series July, last year.

Looking at your outstanding patch series on patchwork:
https://patchwork.kernel.org/project/qemu-devel/list/?submitter=3D188679

(Feel free to correct me if I have misunderstood anything.)

I see that these are related to your patch series from July last year:
hw/block/nvme: bump to v1.3
hw/block/nvme: support scatter gather lists
hw/block/nvme: support multiple namespaces
hw/block/nvme: bump to v1.4


This patch series seems minor and could probably be merged immediately:
hw/block/nvme: handle transient dma errors


This patch series looks a bit weird:
hw/block/nvme: AIO and address mapping refactoring

Since it looks like a V1 post, and was first posted yesterday.
However, 2 out of the 17 patches in are Acked-by: Keith.
(Perhaps some of your previously posted patches was put inside
this new patch series?)


This patch series:
hw/block/nvme: namespace types and zoned namespaces

Which was first posted today. Up until earlier today, we haven't seen
any patches from you related to ZNS (only overall NVMe cleanups).
Dmitry's ZNS patches have been on the list since 2020-06-16.


Just a friendly suggestion, how about:

1) We get your

hw/block/nvme: bump to v1.3
hw/block/nvme: support scatter gather lists
hw/block/nvme: support multiple namespaces
hw/block/nvme: bump to v1.4

patch series merged.

2) We get Dmitry's patch series merged.

Shared 4:th) If there is any feature that you miss in Dmitry's patch series=
,
perhaps you could send patches to add what you are missing.

Shared 4:th) Your other patch series:
hw/block/nvme: AIO and address mapping refactoring could get merged.


Please don't take this suggestion the wrong way, I'm simply trying
to come up with a way to move forward from here.


Kind regards,
Niklas=

