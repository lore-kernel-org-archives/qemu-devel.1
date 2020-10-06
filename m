Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F6FC4363A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 01:58:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BF792064E
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 01:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gntySSal";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xnJffj3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF792064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPcFj-0003E8-4C
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 21:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=541d58f41=Dmitry.Fomichev@wdc.com>)
 id 1kPcEJ-0002gD-3f; Mon, 05 Oct 2020 21:57:31 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:22499)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=541d58f41=Dmitry.Fomichev@wdc.com>)
 id 1kPcEF-00070F-3s; Mon, 05 Oct 2020 21:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601949443; x=1633485443;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Myeoa4yBWbTC8IvquneQ4eY4QrjgIr3/UKUItOBL6Dw=;
 b=gntySSaliws7wc7XquIcUEmuBU7LMaEZT8WeyabX08DPgiEu2LMr47nt
 uB07F76Xw3/3vE3Z3FUPIQe+OT52AjanHCOhDYsG3Vq1O6lyMp4eTueH3
 B5k7xEPcpFx02KPh7tUc/v1xxHgg7l6NlTrIOzo6vHyOQDyJHm3Kk2xvo
 pUvKw+5NSFtRcGvC/jfaD1t4Ac5woDwYdtfR0VjGHaK0FRL82wV1GPNfv
 Xgfl2v7CZAj1BsC0vf3dSRrQ2RPW5j5cOGtUKMwoQhtbXnGIIAW68D4fo
 BvPMzBFYCHc8Xl+rVOHI36QsHtrWCXpMO8e5Ue9tmXE76ymHGiCKcfR0U g==;
IronPort-SDR: keTdXSDgbCNkV8GxCndzRqSw9A6bKB7uCM09Uw9vpJGr7Zm+Ap1V5rNBzKE4nnSojI+/A791HN
 IHvcwy0T1loQEsSF4ui64aO4dNxJPfpTy8zBxIqe5sSu/17/6UpWlqGi/AsLy7kxbek0Nh1uxs
 u5G9bd7/XQ6uSFS036FJ4ejBtgKFF3Q0JUixAyQ7bxgT2XA+Uav+XEmgdHkeBSGTIvIuxTq5eH
 uvqzj//DsGiU98Al2S32ieFtBWctT7BewTKVUXQQw1Ajl7SIKYQrE/QpP8ryAnbzpXQ82vg+De
 3VY=
X-IronPort-AV: E=Sophos;i="5.77,341,1596470400"; d="scan'208";a="150333727"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
 by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2020 09:57:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoRmIVhAQVyNCUmc/3uNTF5UItFCFw30L/YvjhWSsjTKBwrKqsnE0983pzVVOrZDxgQiVi7lJGoLy0qmhapx/D1skr3LlRU69RLdoaeFUVz8XYkgq7u7xLTel8GwdTC99Po9WnvKG5+ho4S3QBN6nwwnIiD5qZZmPqN6GkGPaBswulQ5DL/vfBQOqf+T3VWWyr0MmeKCWriqb7Qt9sIEfV+SWFZWUnxWAnWdrwvSZviC92EW+3RomHeyC29BKhBt2FKXK6fRHDD1KUi6KehWKG6KeRlfPdju0Apk7PDqopc1PiH4zwAPZHG2rPeGWTP6KEupOh0A5IDi5Ggz2TRHug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0HKHhXtKTkk0Z6gP0QKJQ1mB2F3ImIzAx6y+mTgh7Q=;
 b=nD9e3uHlU7JXJh1tqHCGnKmvrkxhyPl5h2ppnrbNNSj/M5IOhdkFL6zy/O6HrGSSSAvd2Kglz6dGZdWJFY3hEvwlv5bG2+lN5Ci7DGsQ0vVqXXg4ljH1/dzNQxUmxqs9mpzX5ce4/Zu4NE9Ejj1bjTjgRi1WlpF1P4WCYVS9f0RC2/Ci0fdlwzOKZAgPyz57/jaU25KanM5uc4Ayu5riwiYe1umTzwj//K/73FBEtcvvEDPfqatB/5EBOEL3v+6lOK0WW63NpcyL736ffCBQl1XPt7d+LxuctclrvoGDNHN3Cra+dkJXX5PfggDSanl+iBTN30UMpea5TPhB1m5mbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0HKHhXtKTkk0Z6gP0QKJQ1mB2F3ImIzAx6y+mTgh7Q=;
 b=xnJffj3fK7+e4BAQppDQmwQnMHlsJemsvD+bXbuyNaOr3oB1o52h6ZJcpSUvnimfiwj0vtN1og0a86+idOqClsOGsiF/3uwnduienPalxDMZw/4BQ+t2/GH+2dJdqijraeBnHurScUV/KPwDI6ip1EAi+SxO7xnJeJLxo8RPCCk=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5952.namprd04.prod.outlook.com (2603:10b6:208:3e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 6 Oct
 2020 01:57:18 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94%6]) with mapi id 15.20.3433.044; Tue, 6 Oct 2020
 01:57:18 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: RE: [PATCH 3/9] hw/block/nvme: support per-namespace smart log
Thread-Topic: [PATCH 3/9] hw/block/nvme: support per-namespace smart log
Thread-Index: AQHWl3WqF0QBafvaSEKw0t+jrD0Mi6mJ2E0w
Date: Tue, 6 Oct 2020 01:57:18 +0000
Message-ID: <MN2PR04MB59511A76ECDD83C8A41DA61CE10D0@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20200930220414.562527-1-kbusch@kernel.org>
 <20200930220414.562527-4-kbusch@kernel.org>
In-Reply-To: <20200930220414.562527-4-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1bd7d771-31d7-46d1-c21d-08d8699b2804
x-ms-traffictypediagnostic: MN2PR04MB5952:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB595255A9B3FBC0FBF9A77E5DE10D0@MN2PR04MB5952.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:128;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jUyf9LjMaKpGFLTg56rUHHGik7sM/om6pyF2s7ZsROzvM9v44OdbB3xWlOf2oFZWYcXW5r3gYGK4Yg+QYprzcI5k6qdSeRZMqH97HI/Au70DlAA3o+guRq4v7Pn3KwCPjn0k6d1jHXsCtxBVGldUBEQJEQAaQ/LHDddovtlE/t1yFSkoYOoYKrb87xP3pdOi1GgQPnzRdYBAhDADc36GM5peZF1v1n4YqpnKxr1EA66XWcRYVR4cVII6eXNV6XlCS5hdKR1wcdposiXV3U6BkaW4xPlyRDpREMGrzTW9G/7IMl7+GXoKRlTBB5DsOodY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(76116006)(52536014)(5660300002)(86362001)(2906002)(54906003)(7696005)(316002)(110136005)(8676002)(8936002)(4326008)(83380400001)(53546011)(6506007)(26005)(33656002)(55016002)(478600001)(9686003)(186003)(66476007)(71200400001)(66946007)(66556008)(66446008)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 92Ng8nAYsoAIod0wvcJt0uKnb8S2d5XLvm/rbaTOnfEABovfaCp7pMFIq+OwbR58/RuOnvyjN08ofL2VCtYmhSMnAP/MQbltbWCET9+/FbLbwLeizKc4km2H+RRmwwOcX/zf5K/BwS1kOeTz6kvr88Qvdopuy/TffAc4tBev0mioonxBzwgRdI0oPahNqokJq9K2ClK5lva+pqSMgJ0y/y/mEnOhnuUmUND32dZ3h0O0soy0oBuV8sTKhs8BD9ca/k9rgH76BRPlcWl8purNkKogqdnh1ocGnmL5bUFWpe41DUJSNa1gYhSXQH3TT3B826hkDytdnkTtWPqKLXo01nEDVFYoFXpCbI0YxTyIthn6WwJYYkih1mJIK0sxlxWCE7y1/47wOeYADgRklufoGiIIQ1/5IvxSZUoqZm1sRAuxnmNzfaOG9U26CIM8ve97R+bnrAkOtKevNEah3YKq+RjfQe1qtl12Yu7+1vhPOD12urJ98R1NmuOBOmQ/v1pdWUdykqHM0loYySaBEpZwyr+T0mivppyXtXXmvfwHRxo5E2pRZ14QdaJQH4r1mXIImq3HPGfU6TkvHVa98unalMfITR0RLQKLKtzRUfssrKmpqLtVbMHqVE5numq77g+/hwWd7qaKe3VTY/9n5f8kFA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd7d771-31d7-46d1-c21d-08d8699b2804
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 01:57:18.3174 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eKnJP7oRPuUThFcXNkc8Dqoajm4BmBKPTWuv/2lXrA17YrVLRHN+UTVZPHFzujUwFFIEe3o0iI4G3J7QAmxFHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5952
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=541d58f41=Dmitry.Fomichev@wdc.com; helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 21:57:20
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
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Keith Busch <kbusch@kernel.org>
> Sent: Wednesday, September 30, 2020 6:04 PM
> To: qemu-block@nongnu.org; qemu-devel@nongnu.org; Klaus Jensen
> <k.jensen@samsung.com>
> Cc: Niklas Cassel <Niklas.Cassel@wdc.com>; Dmitry Fomichev
> <Dmitry.Fomichev@wdc.com>; Kevin Wolf <kwolf@redhat.com>; Philippe
> Mathieu-Daud=E9 <philmd@redhat.com>; Keith Busch <kbusch@kernel.org>
> Subject: [PATCH 3/9] hw/block/nvme: support per-namespace smart log
>=20
> Let the user specify a specific namespace if they want to get access
> stats for a specific namespace.
>=20
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  hw/block/nvme.c      | 66 +++++++++++++++++++++++++++-----------------
>  include/block/nvme.h |  1 +
>  2 files changed, 41 insertions(+), 26 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 8d2b5be567..41389b2b09 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1164,48 +1164,62 @@ static uint16_t nvme_create_sq(NvmeCtrl *n,
> NvmeRequest *req)
>      return NVME_SUCCESS;
>  }
>=20
> +struct nvme_stats {
> +    uint64_t units_read;
> +    uint64_t units_written;
> +    uint64_t read_commands;
> +    uint64_t write_commands;
> +};
> +
> +static void nvme_set_blk_stats(NvmeNamespace *ns, struct nvme_stats
> *stats)
> +{
> +    BlockAcctStats *s =3D blk_get_stats(ns->blkconf.blk);
> +
> +    stats->units_read +=3D s->nr_bytes[BLOCK_ACCT_READ] >>
> BDRV_SECTOR_BITS;
> +    stats->units_written +=3D s->nr_bytes[BLOCK_ACCT_WRITE] >>
> BDRV_SECTOR_BITS;
> +    stats->read_commands +=3D s->nr_ops[BLOCK_ACCT_READ];
> +    stats->write_commands +=3D s->nr_ops[BLOCK_ACCT_WRITE];
> +}
> +
>  static uint16_t nvme_smart_info(NvmeCtrl *n, uint8_t rae, uint32_t
> buf_len,
>                                  uint64_t off, NvmeRequest *req)
>  {
>      uint32_t nsid =3D le32_to_cpu(req->cmd.nsid);
> -
> +    struct nvme_stats stats =3D { 0 };
> +    NvmeSmartLog smart =3D { 0 };
>      uint32_t trans_len;
> +    NvmeNamespace *ns;
>      time_t current_ms;
> -    uint64_t units_read =3D 0, units_written =3D 0;
> -    uint64_t read_commands =3D 0, write_commands =3D 0;
> -    NvmeSmartLog smart;
> -
> -    if (nsid && nsid !=3D 0xffffffff) {
> -        return NVME_INVALID_FIELD | NVME_DNR;
> -    }
>=20
>      if (off >=3D sizeof(smart)) {
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
>=20
> -    for (int i =3D 1; i <=3D n->num_namespaces; i++) {
> -        NvmeNamespace *ns =3D nvme_ns(n, i);
> -        if (!ns) {
> -            continue;
> -        }
> -
> -        BlockAcctStats *s =3D blk_get_stats(ns->blkconf.blk);
> +    if (nsid !=3D 0xffffffff) {
> +        ns =3D nvme_ns(n, nsid);
> +        if (!ns)
> +            return NVME_INVALID_NSID | NVME_DNR;

checkpatch will complain about missing curly braces here

> +        nvme_set_blk_stats(ns, &stats);
> +    } else {
> +        int i;
>=20
> -        units_read +=3D s->nr_bytes[BLOCK_ACCT_READ] >>
> BDRV_SECTOR_BITS;
> -        units_written +=3D s->nr_bytes[BLOCK_ACCT_WRITE] >>
> BDRV_SECTOR_BITS;
> -        read_commands +=3D s->nr_ops[BLOCK_ACCT_READ];
> -        write_commands +=3D s->nr_ops[BLOCK_ACCT_WRITE];
> +        for (i =3D 1; i <=3D n->num_namespaces; i++) {
> +            ns =3D nvme_ns(n, i);
> +            if (!ns) {
> +                continue;
> +            }
> +            nvme_set_blk_stats(ns, &stats);
> +        }
>      }
>=20
>      trans_len =3D MIN(sizeof(smart) - off, buf_len);
>=20
> -    memset(&smart, 0x0, sizeof(smart));
> -
> -    smart.data_units_read[0] =3D cpu_to_le64(DIV_ROUND_UP(units_read,
> 1000));
> -    smart.data_units_written[0] =3D
> cpu_to_le64(DIV_ROUND_UP(units_written,
> +    smart.data_units_read[0] =3D
> cpu_to_le64(DIV_ROUND_UP(stats.units_read,
> +                                                        1000));
> +    smart.data_units_written[0] =3D
> cpu_to_le64(DIV_ROUND_UP(stats.units_written,
>                                                             1000));
> -    smart.host_read_commands[0] =3D cpu_to_le64(read_commands);
> -    smart.host_write_commands[0] =3D cpu_to_le64(write_commands);
> +    smart.host_read_commands[0] =3D cpu_to_le64(stats.read_commands);
> +    smart.host_write_commands[0] =3D cpu_to_le64(stats.write_commands);
>=20
>      smart.temperature =3D cpu_to_le16(n->temperature);
>=20
> @@ -2708,7 +2722,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice
> *pci_dev)
>      id->acl =3D 3;
>      id->aerl =3D n->params.aerl;
>      id->frmw =3D (NVME_NUM_FW_SLOTS << 1) | NVME_FRMW_SLOT1_RO;
> -    id->lpa =3D NVME_LPA_EXTENDED;
> +    id->lpa =3D NVME_LPA_NS_SMART | NVME_LPA_EXTENDED;
>=20
>      /* recommended default value (~70 C) */
>      id->wctemp =3D cpu_to_le16(NVME_TEMPERATURE_WARNING);
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 58647bcdad..868cf53f0b 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -849,6 +849,7 @@ enum NvmeIdCtrlFrmw {
>  };
>=20
>  enum NvmeIdCtrlLpa {
> +    NVME_LPA_NS_SMART =3D 1 << 0,
>      NVME_LPA_EXTENDED =3D 1 << 2,
>  };
>=20
> --
> 2.24.1


