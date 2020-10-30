Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBFEC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:19:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB3F20791
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="agpicMzY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Sb/AZr+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB3F20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYY3y-0007KK-1L
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 13:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=565c1a50e=Niklas.Cassel@wdc.com>)
 id 1kYY38-0006nJ-7P; Fri, 30 Oct 2020 13:18:51 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:28209)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=565c1a50e=Niklas.Cassel@wdc.com>)
 id 1kYY33-0007GT-TI; Fri, 30 Oct 2020 13:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604078325; x=1635614325;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=FlIXRaT038ipsc2mQ3IWsdxF9n4FfOenwADZ2GyO094=;
 b=agpicMzYKqthZSUxE6sKQ8HldCisQd6PZ+Tqt1YjDNAleM6XNd/Dl0K8
 Yq2C7zXATk4tyWLySW0F3TA/tlpxY1REtb6kgn77Qrv4zlT8gKbj1GY7v
 UZ3PwXOJzaH/8SctBjYWobfc/DZR/IWG0D39YZPuJgYGd4v0dgIvYMShf
 7wZty3x834TNxOwBJTRkwwMUaOa4JN+lgP4a4mmpwl/nCo8Z3Omk30Nem
 8Wo8fS9wz5WEsXtDLPtmCNgnUlUUQ+1eKTlBxLcbxuWM6RwQFcY+PBTsV
 Y/9reWuupqZIwVqRJsbuHUW28adQ0y0kNqit+apLRPgLp8AmFi3GGkWzR g==;
IronPort-SDR: jhYpdqvct43RizkpZWXX/a26EBToLLHeXOPU9wH+77AosrB0mq+W2NMu/NmAC04e1a/apTQSOU
 BookKI7iYvBmuIdHWWB9mWFB9JlyKpsYT6TAFbv4DvMKzAAPIKmh4tCuNTdtRqvDcGgLIh4RrM
 A3M0CGqXEHCS+uYmqXPYI6Upz769Y74/a2va4v62W68uPwcvDQo3IUvBhNAIM67udJKyomCExO
 Ej/Y0u/XXpWCTRXCz+dXroMB1U6EHLC6OTAgeVF6whhlsDlkoeRTlxmJUO7OPDckP2NaA/wkRy
 /V0=
X-IronPort-AV: E=Sophos;i="5.77,434,1596470400"; d="scan'208";a="155823956"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
 by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2020 01:18:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhLQmp+9CN/lAAIPyjRdKZNGE7soQ85DZAG36SNjhJK1eV6TXovi1samYzTxgk5ncgWDdQU9L38eWbubcqDgVC0nx6bnJOr6VR990/+mKSVbHTEPQkQHmouCzlk4hVj5RzicDvlXNX+eEFa1BdVCz7RUoa6XoR3n9NwRP6lLOepjsweDUjDBUommvzjpMg8L+hm9pClsD61ozt6jGUhkOar05SoZDiqTYiy0VPdWLdXA7M/sa1I8fOFhfvLm5a6a+zcoY8fM3hOVbthg/xnaqoq373WKD3qyd44bA92Z/aQVWF0xNCTW0s4lvcdXao5lX80J6N39X+ggqwEe+UE7og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7NtMAXcPV12FrotylIkKwABZv9lQiVQDfTcXq7jJ2o=;
 b=UJdvP7UsWGYMCFBjvLevyzHy5po55tMnBFlBFJJrVa6RsVEQ/Zr/oBWS0G4aXXslvJ5wLjIlDegTCmNmWE9Ch4cYoi9xxB183LZX3tsugMnqQX965F+ij7SPim8w8QZfANfDHcy3YVnFByk+0gJOXvnOXTHggEj4B8tItQZvUyy9KfLOFrSnqY5O20G9ZNx4cypmTKeBqySs2d0ZIS+jf1qvzuwsCw3JqYzzg0sNTF7LqptRJV89KcCEQ83EXnTzJL0MR+1q1BhHYi4nYbzIThhW/T6Yv0X7NHbeGmd9XpOEieOjrEavU1RgOaUWZ4qJ+YAMA9zP5q4uhccRGc2mNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7NtMAXcPV12FrotylIkKwABZv9lQiVQDfTcXq7jJ2o=;
 b=Sb/AZr+rSr+7718ZA5Ft6uu7kjJgf62FJ0SIBmlaVoBYIerOcm57H50A/4yn/f2i6cZrsFP8ThNXTJR74xU3WKOF54x7swHEcxiKapxjqHKL/Ztq26LXlZ50e820sT3hQBTj9bxtqH3tcP5luAKgh52HLQ9f5W9zBelD7/nNyxE=
Received: from BN8PR04MB5475.namprd04.prod.outlook.com (2603:10b6:408:50::28)
 by BN7PR04MB5299.namprd04.prod.outlook.com (2603:10b6:408:3f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Fri, 30 Oct
 2020 17:18:38 +0000
Received: from BN8PR04MB5475.namprd04.prod.outlook.com
 ([fe80::44a3:946f:57b0:9903]) by BN8PR04MB5475.namprd04.prod.outlook.com
 ([fe80::44a3:946f:57b0:9903%7]) with mapi id 15.20.3477.034; Fri, 30 Oct 2020
 17:18:38 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Subject: Re: [PATCH v8 07/11] hw/block/nvme: Support Zoned Namespace Command
 Set
Thread-Topic: [PATCH v8 07/11] hw/block/nvme: Support Zoned Namespace Command
 Set
Thread-Index: AQHWrmUEKdtIsa2mmEGiRi0HGYwoXqmwZJ2A
Date: Fri, 30 Oct 2020 17:18:38 +0000
Message-ID: <20201030171837.GA127076@localhost.localdomain>
References: <20201030023242.5204-1-dmitry.fomichev@wdc.com>
 <20201030023242.5204-8-dmitry.fomichev@wdc.com>
In-Reply-To: <20201030023242.5204-8-dmitry.fomichev@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9baff954-38a3-4e4e-fd0f-08d87cf7d798
x-ms-traffictypediagnostic: BN7PR04MB5299:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR04MB52991B17308DDD8E9BAE6B77F2150@BN7PR04MB5299.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qa7jHcmyPmWkX4xHhaCWAzJ5x8To7bIhuijwwA85dniosuDOOJMyuC957EL97MAQZVdzNiQVgwLoxLElF0zWeTpfR0d0toWXjHankuH/ljCwidXbfDM44eIrulAjXqHC2f+3TWwo11Gs/yPDs2Uq1SAnjAKiJszgSO7x9SMXsTVuoy7G3hEx9o76M5ENCTa/pxLk3mMD2ogFSlUrxIENYgb+wrk508duer6yErmp8+YKN88FmRX8eyQUQV9tzxTVxOV7j6EsrXivGafRQQtVPzHm6XgfWPz0e0sawzlJPuvWLaw4AHeAg2pGMoPL3JurpxBw7Qp+R6pieVbh8rdmcw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR04MB5475.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(186003)(9686003)(6506007)(6862004)(83380400001)(316002)(71200400001)(2906002)(64756008)(66946007)(6512007)(6486002)(66476007)(86362001)(33656002)(66446008)(26005)(4326008)(66556008)(6636002)(91956017)(8936002)(478600001)(76116006)(5660300002)(8676002)(54906003)(1076003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: UjIvEK4blzGDVpkkzqYhCKkuYn59zXPr15Oz+Xn1DZ5N92Owi4PG6tUX2NJiBm+QmHoGKNNdWrvtT9WBeHD1SpmCbZ1+mlpb58lIuOj7fuH47PyN+y3i7qAxC5OR57dXFTdt6uJ716Bt+Da5wp7S8QWbBtJrrJMElD3LEcjvwl83uqELk4+ISP/YLAYKGCzp0y1oSibQkjI2g6ZVI62OxAGE9cf0PoLvL3CuFbHRI7z4pdWZmLNHwCSv3xZYFx2Xq4UXBORnSrY1XsKAPd57NzDExrDpgknnH3hgia/3ib+++JYAMLkQKdu3OxnfOwdGYJawsvsXfOWRPFuf/9+uErnxM5m/fuaLGY/FKgwl84QrNvvWNVSyzgGLcbwq9BtCtpF47+WibrKflYIOt1unP/B3abfUqCSba232hCXvV9MsLzEezjHQoKhZWFj4XwL1ZKglH94Y3L5bWmEjL23OGwR1zQ+q6bNhico6xyOHEVNoacpog2Omqq8pMm04KQBMdgCF5lUCbd2/tVIWBAfIlzPrBajz+8VRdRXflzXnSJ7lJqJn1Z5X8ABT7RDVpxrJnSSdo3D6G2gPUg2enwuUaf53zSc8CSIGaUmAWWZxvE379jCtlyPS0IwQhjKMdRfN3h6nMLvlh/HH8cevowplPA==
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <B05F41686CB1554282795B7911093BE6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR04MB5475.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9baff954-38a3-4e4e-fd0f-08d87cf7d798
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 17:18:38.7400 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RAl8OrsozHEjbINKfnwf578TM1+rfI1cEaxui3/VxfDL0TCkIiiIangBVfaiCEEaEeHnri4R+kgDAB9IX+EWzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB5299
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=565c1a50e=Niklas.Cassel@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 13:18:42
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

On Fri, Oct 30, 2020 at 11:32:38AM +0900, Dmitry Fomichev wrote:
> The emulation code has been changed to advertise NVM Command Set when
> "zoned" device property is not set (default) and Zoned Namespace
> Command Set otherwise.
>=20
> Define values and structures that are needed to support Zoned
> Namespace Command Set (NVMe TP 4053) in PCI NVMe controller emulator.
> Define trace events where needed in newly introduced code.
>=20
> In order to improve scalability, all open, closed and full zones
> are organized in separate linked lists. Consequently, almost all
> zone operations don't require scanning of the entire zone array
> (which potentially can be quite large) - it is only necessary to
> enumerate one or more zone lists.
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
> Subsequent commits in this series add ZDE support and checks for
> active and open zone limits.
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
> Reviewed-by: Niklas Cassel <Niklas.Cassel@wdc.com>

(snip)

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

Just like nvme_read() and nvme_write(), nvme_zone_mgmt_recv()
has to do something like:

+    ret =3D nvme_check_mdts(n, len);
+    if (ret) {
+        trace_pci_nvme_err_mdts(nvme_cid(req), len);
+        return ret;
+    }
+

To see that we are not exceeding MDTS.


Kind regards,
Niklas


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
> +}=

