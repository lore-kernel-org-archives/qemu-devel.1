Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C47AC47420
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 14:09:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8BCE20789
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 14:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HZEWOCWv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IF/UGBBh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BCE20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNcmy-0003Lh-NN
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 10:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5353e43af=Niklas.Cassel@wdc.com>)
 id 1kNcUy-0007ke-O0; Wed, 30 Sep 2020 09:50:25 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:20249)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5353e43af=Niklas.Cassel@wdc.com>)
 id 1kNcUv-0006NW-9T; Wed, 30 Sep 2020 09:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601473821; x=1633009821;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=oZgTU8SHHkIGTWb5+deQrw7v5SWm4iU1WUVF+CJBhIE=;
 b=HZEWOCWvipgJGY+12UY8ncZwTNgjfwnVx8WIJ25Gzj9AUB+nKmyvvo5k
 QvIGAg4aRU4g1v4s4gl13VLnZU34hGqzKpkc5SSCyr5C0geZWMSopQkqg
 5Pr2svV586fzU6n7ZhMg/bTwEZlCx2GxI0OU7h7sNwVDrjFTJSNCJ7CCH
 dgXai8ozK4JjRgM/XeOBwl8pwFo5ghj8WswQ1kDjJf1WG3gv5Tau9Ey9q
 E4Q+KoL6oiYNoSgLI1VLT7CF2kGHpRmxZnDX2fIJuUQy+J5XAriI9wkX/
 H0SUfYV7AxEZocwDoGSuZ4Je8seASaPuqVMEnNLNgftxrCyFn5dG/FAWc g==;
IronPort-SDR: IbwcAw55pEw8QWPxk/xwrDT/p60R4MJ0tSOSQf27ZJUBGHIvEPN0kpZMw5BMXkwNK7QNbcoZkY
 tcCngDLDxTE7Hr2ym336GTBYu4f14/vt42rLB05geolBCaLqdtMb8cKKUb3kxVLsHIy/5dA8pi
 4Ee3x6c6/I+AHLzWUUIzvknyubLEbFFy35BvpxXjmIZFzvJhUN3WRVduT8dy7BPDTRconV7mXN
 3fZFseUXnYtkrx3XnCocWFPNF1CQFj0G0xYkAl8L2rFChzfc+DAAv2bIaUryrO76fqAPyH+xOb
 Ttc=
X-IronPort-AV: E=Sophos;i="5.77,322,1596470400"; d="scan'208";a="148575035"
Received: from mail-sn1nam04lp2057.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.57])
 by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2020 21:50:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtGLO0S5Z+4Cnjg6GFHazZFAMSwYRdYnIHEvcbl7Y7ewHb9axphkMCT21z690uVXidmLYzwpE/lzQ/lcFmJoqDiQAkPikALWTk3Vib5Y8UCzeIafsOXBGC70PiMuqj5LVRs3U9mPtivNS2KGUIFgeDR8TaLv5NC4YsbHoM643vYsmRKX3JnTGlCAaBaC309LykA5mDlO6B8Ipy6lKS/NAi6nNJsQuGG5GhUVcEpjnB2NDXYYU4Ej3p/UvsrmzlDtCvYOE7qvwRbmGu4Z5JCje6ltXE8ff4OiDftjn9wnTPBXS5wpgpIzWwpu+vuRNJsD0HXxY6J/hAD5qM5drV/4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0pQvlSjA4SCGSkSfoTUt3Eapb7JySO7aVe7aPo0zwY=;
 b=egMSoQA2ImihVwIkoCH1j2w/V6NrEwSm5nyZbnqCxGVlA00mTWv1sZp1PpHa9GNnc2h6MqMQ1taIp91slGd7Rmg/XCmE0XZ11fBIZJ3mGmBbbzZhnwcK82UDVEi1pqJOtj+BDNt8rtlF2DbQrnfzvdM7ag8635WK4ghYLqPS/EwkTsWFebZho14iHlE4ZuCgABvrkG65ym1CMzWnkglUgiC9cSJS1wINzhkjizhWmNCHxbNfE9pJtFcDD6LyEuff+6V0FKwd90x+lkEyCyj3dn4klyCkQMu7DGSEtdDJJ7mx6CAmlI1RHFlbVmG6DEODPSIgnl1iROjuZoGrqWOIcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0pQvlSjA4SCGSkSfoTUt3Eapb7JySO7aVe7aPo0zwY=;
 b=IF/UGBBhJVpCLEXvmTdFWowPSdVU/K40QkOq8ytJVOFIoGuALU7q9oTkN84MZC5U3Qg/P2eUJEfiaU776UfO8iZuI/4JSxFU0bOECS3QRRV0l5NFrduHvEzuDcEWSc7LhccPCpJlNdGa6rjfNjKa48roOj3C5jQisQgJYk6/+Ck=
Received: from BN6PR04MB0724.namprd04.prod.outlook.com (2603:10b6:404:ce::23)
 by BN8PR04MB5667.namprd04.prod.outlook.com (2603:10b6:408:76::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Wed, 30 Sep
 2020 13:50:14 +0000
Received: from BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::acb1:47a4:73ba:69a7]) by BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::acb1:47a4:73ba:69a7%9]) with mapi id 15.20.3412.029; Wed, 30 Sep 2020
 13:50:14 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Subject: Re: [PATCH v5 06/14] hw/block/nvme: Add support for active/inactive
 namespaces
Thread-Topic: [PATCH v5 06/14] hw/block/nvme: Add support for active/inactive
 namespaces
Thread-Index: AQHWlUAXdLu5rxVebUe9Shmhcmtp4qmBNrsA
Date: Wed, 30 Sep 2020 13:50:14 +0000
Message-ID: <20200930135012.GA204568@localhost.localdomain>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
 <20200928023528.15260-7-dmitry.fomichev@wdc.com>
In-Reply-To: <20200928023528.15260-7-dmitry.fomichev@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0c1878a3-8741-4b37-95dc-08d86547c226
x-ms-traffictypediagnostic: BN8PR04MB5667:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR04MB5667701654A9327472EC9D8EF2330@BN8PR04MB5667.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:439;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Srh9Jf/alg0ZhgU8YZ5/vqrAY8T7dkiMHqgx7oGake1e/uLcGss+6yaWNyzk1ETfT1YPc72Qug90OFhxRHCGIMnoDllRVCHWHEXWzjk3wE2LK1tZ7JWLESY+EoEen/Sm0EpuhD6ZkhKo0wQsBexqG8Kf8/vgtP6mDg0qpmAUu7vlqFDIDlMb3LN/waSMaVXy4RlH8Y+iVuFkXXMokU5c6DCoiGApqZxiqaddIVPAJhQaZkn4uDZDraWZb329QcbWlFl03LzEKt4pJnk/inZndYE0utPIITcWRte8X1BtOnnHxxn8IieMFRJ/N1oND1mQzx8wFXcbcNAhwxaxw4Lk8g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR04MB0724.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(6486002)(2906002)(6512007)(9686003)(4326008)(30864003)(66946007)(66476007)(66556008)(76116006)(91956017)(71200400001)(1076003)(6862004)(6636002)(6506007)(66446008)(64756008)(5660300002)(86362001)(54906003)(186003)(8936002)(26005)(8676002)(83380400001)(478600001)(316002)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: YK4Ssxmbw0DsUqrsoCncpGYivRDHiUUwZ26QkPAW/znRXGvG3ukf2t4vbEspjCOFLLWvljj1RB62vylZpeW+E+AzIQoidYEz69KnsLVSdXJtU33flDo/O9ZHqU2asdwDijk7lti2tya4iPby3h1TRcmwvqednI3ubrhwjbXcrelt8oSD7Y1ETgds8QMf6vqUjSDfeSqvAbhQZ4dXAfoQNgnSkIAV4MJ1IsVUnJxZS0uUm2vsJcJbLlcHemzla7lT85h/FOqkslyoMr9MwKlid2nzfnsqrCELjFVArdFK+oxnmm9hYVfEty+Tgmz6MNMojaCNIt/4jn78j1c6f702tolbi0USepDQ0dhPbRBjG4JhDLwTr+PWh+es4JNR4FvobMlO9L8IItAf1+CDnsCFaL7VUP4zS0TtJcXTiwYbIqjtRCCjB92puEU9aPgFJfkMsh1Sd7h5QZfatCdE1snDlBo5TkN6decCbeYolDRXnFrAY6g0/GTHCvXSHPhTI2fT3QRwCHVxnUDRke5ZXtKl0QqqygpTq2KUdsq1xLQ903IOl7jQs41B0eN0SuUxh3Yif293DEugEk5JihMmYtTKe0fLAahC8kfV0jpWqMWOWf1o+2zZmr91t8MkL+YTNd6+CqaydQfCKKl+ttOu61ajTQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <083BEB201B22DD4C95C1E455D9D665B5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR04MB0724.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1878a3-8741-4b37-95dc-08d86547c226
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 13:50:14.3718 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gQg9dvod9aAVBjFR7RqZrf/dJbQIeANdaEbY7ck/+Efs8tS5kAV7ncY+XDfqjkdiH1Q8HTeczlUQ13CQoS1wNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5667
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=5353e43af=Niklas.Cassel@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 09:50:18
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

On Mon, Sep 28, 2020 at 11:35:20AM +0900, Dmitry Fomichev wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> In NVMe, a namespace is active if it exists and is attached to the
> controller.
>=20
> CAP.CSS (together with the I/O Command Set data structure) defines what
> command sets are supported by the controller.
>=20
> CC.CSS (together with Set Profile) can be set to enable a subset of the
> available command sets. The namespaces belonging to a disabled command se=
t
> will not be able to attach to the controller, and will thus be inactive.
>=20
> E.g., if the user sets CC.CSS to Admin Only, NVM namespaces should be
> marked as inactive.
>=20
> The identify namespace, the identify namespace CSI specific, and the name=
space
> list commands have two different versions, one that only shows active
> namespaces, and the other version that shows existing namespaces, regardl=
ess
> of whether the namespace is attached or not.
>=20
> Add an attached member to struct NvmeNamespace, and implement the missing=
 CNS
> commands.
>=20
> The added functionality will also simplify the implementation of namespac=
e
> management in the future, since namespace management can also attach and
> detach namespaces.

Following my previous discussion with Klaus,
I think we need to rewrite this commit message completely:

Subject: hw/block/nvme: Add support for allocated CNS command variants

Many CNS commands have "allocated" command variants.
These includes a namespace as long as it is allocated
(i.e. a namespace is included regardless if it is active (attached)
or not.)

While these commands are optional (they are mandatory for controllers
supporting the namespace attachment command), our QEMU implementation
is more complete by actually providing support for these CNS values.

However, since our QEMU model currently does not support the namespace
attachment command, these new allocated CNS commands will return the same
result as the active CNS command variants.

In NVMe, a namespace is active if it exists and is attached to the
controller.

CAP.CSS (together with the I/O Command Set data structure) defines what
command sets are supported by the controller.

CC.CSS (together with Set Profile) can be set to enable a subset of the
available command sets.

Even if a user configures CC.CSS to e.g. Admin only, NVM namespaces
will still be attached (and thus marked as active).
Similarly, if a user configures CC.CSS to e.g. NVM, ZNS namespaces
will still be attached (and thus marked as active).

However, any operation from a disabled command set will result in a
Invalid Command Opcode.

Add an attached struct member for struct NvmeNamespace,
so that we lay the foundation for namespace attachment
support. Also implement logic in the new CNS values to
include/exclude namespaces based on this new struct member.
The only thing missing hooking up the actual Namespace Attachment
command opcode, which allows a user to toggle the attached
variable per namespace. The reason for not hooking up this
command completely is because the NVMe specification
requires that the namespace managment command is supported
if the namespacement attachment command is supported.


>=20
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  hw/block/nvme-ns.h   |  1 +
>  hw/block/nvme.c      | 60 ++++++++++++++++++++++++++++++++++++++------
>  include/block/nvme.h | 20 +++++++++------
>  3 files changed, 65 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
> index cca23bc0b3..acdb76f058 100644
> --- a/hw/block/nvme-ns.h
> +++ b/hw/block/nvme-ns.h
> @@ -22,6 +22,7 @@
>  typedef struct NvmeNamespaceParams {
>      uint32_t nsid;
>      uint8_t  csi;
> +    bool     attached;
>      QemuUUID uuid;
>  } NvmeNamespaceParams;
> =20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 4ec1ddc90a..63ad03d6d6 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c

We need to add an additional check in nvme_io_cmd()
that returns Invalid Command Opcode when CC.CSS =3D=3D Admin only.

> @@ -1523,7 +1523,8 @@ static uint16_t nvme_identify_ctrl_csi(NvmeCtrl *n,=
 NvmeRequest *req)
>      return NVME_INVALID_FIELD | NVME_DNR;
>  }
> =20
> -static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
> +static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req,
> +                                 bool only_active)
>  {
>      NvmeNamespace *ns;
>      NvmeIdentify *c =3D (NvmeIdentify *)&req->cmd;
> @@ -1540,11 +1541,16 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, Nvm=
eRequest *req)
>          return nvme_rpt_empty_id_struct(n, req);
>      }
> =20
> +    if (only_active && !ns->params.attached) {
> +        return nvme_rpt_empty_id_struct(n, req);
> +    }
> +
>      return nvme_dma(n, (uint8_t *)&ns->id_ns, sizeof(NvmeIdNs),
>                      DMA_DIRECTION_FROM_DEVICE, req);
>  }
> =20
> -static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req)
> +static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req,
> +                                     bool only_active)
>  {
>      NvmeNamespace *ns;
>      NvmeIdentify *c =3D (NvmeIdentify *)&req->cmd;
> @@ -1561,6 +1567,10 @@ static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, =
NvmeRequest *req)
>          return nvme_rpt_empty_id_struct(n, req);
>      }
> =20
> +    if (only_active && !ns->params.attached) {
> +        return nvme_rpt_empty_id_struct(n, req);
> +    }
> +
>      if (c->csi =3D=3D NVME_CSI_NVM) {
>          return nvme_rpt_empty_id_struct(n, req);
>      }
> @@ -1568,7 +1578,8 @@ static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, N=
vmeRequest *req)
>      return NVME_INVALID_FIELD | NVME_DNR;
>  }
> =20
> -static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
> +static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req,
> +                                     bool only_active)
>  {
>      NvmeNamespace *ns;
>      NvmeIdentify *c =3D (NvmeIdentify *)&req->cmd;
> @@ -1598,6 +1609,9 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, N=
vmeRequest *req)
>          if (ns->params.nsid < min_nsid) {
>              continue;
>          }
> +        if (only_active && !ns->params.attached) {
> +            continue;
> +        }
>          list_ptr[j++] =3D cpu_to_le32(ns->params.nsid);
>          if (j =3D=3D data_len / sizeof(uint32_t)) {
>              break;
> @@ -1607,7 +1621,8 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, N=
vmeRequest *req)
>      return nvme_dma(n, list, data_len, DMA_DIRECTION_FROM_DEVICE, req);
>  }
> =20
> -static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req)
> +static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req,
> +                                         bool only_active)
>  {
>      NvmeNamespace *ns;
>      NvmeIdentify *c =3D (NvmeIdentify *)&req->cmd;
> @@ -1631,6 +1646,9 @@ static uint16_t nvme_identify_nslist_csi(NvmeCtrl *=
n, NvmeRequest *req)
>          if (ns->params.nsid < min_nsid) {
>              continue;
>          }
> +        if (only_active && !ns->params.attached) {
> +            continue;
> +        }
>          list_ptr[j++] =3D cpu_to_le32(ns->params.nsid);
>          if (j =3D=3D data_len / sizeof(uint32_t)) {
>              break;
> @@ -1700,17 +1718,25 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeRe=
quest *req)
> =20
>      switch (le32_to_cpu(c->cns)) {
>      case NVME_ID_CNS_NS:
> -        return nvme_identify_ns(n, req);
> +        return nvme_identify_ns(n, req, true);
>      case NVME_ID_CNS_CS_NS:
> -        return nvme_identify_ns_csi(n, req);
> +        return nvme_identify_ns_csi(n, req, true);
> +    case NVME_ID_CNS_NS_PRESENT:
> +        return nvme_identify_ns(n, req, false);
> +    case NVME_ID_CNS_CS_NS_PRESENT:
> +        return nvme_identify_ns_csi(n, req, false);
>      case NVME_ID_CNS_CTRL:
>          return nvme_identify_ctrl(n, req);
>      case NVME_ID_CNS_CS_CTRL:
>          return nvme_identify_ctrl_csi(n, req);
>      case NVME_ID_CNS_NS_ACTIVE_LIST:
> -        return nvme_identify_nslist(n, req);
> +        return nvme_identify_nslist(n, req, true);
>      case NVME_ID_CNS_CS_NS_ACTIVE_LIST:
> -        return nvme_identify_nslist_csi(n, req);
> +        return nvme_identify_nslist_csi(n, req, true);
> +    case NVME_ID_CNS_NS_PRESENT_LIST:
> +        return nvme_identify_nslist(n, req, false);
> +    case NVME_ID_CNS_CS_NS_PRESENT_LIST:
> +        return nvme_identify_nslist_csi(n, req, false);
>      case NVME_ID_CNS_NS_DESCR_LIST:
>          return nvme_identify_ns_descr_list(n, req);
>      case NVME_ID_CNS_IO_COMMAND_SET:
> @@ -2188,8 +2214,10 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
> =20
>  static int nvme_start_ctrl(NvmeCtrl *n)
>  {
> +    NvmeNamespace *ns;
>      uint32_t page_bits =3D NVME_CC_MPS(n->bar.cc) + 12;
>      uint32_t page_size =3D 1 << page_bits;
> +    int i;
> =20
>      if (unlikely(n->cq[0])) {
>          trace_pci_nvme_err_startfail_cq();
> @@ -2276,6 +2304,22 @@ static int nvme_start_ctrl(NvmeCtrl *n)
>      nvme_init_sq(&n->admin_sq, n, n->bar.asq, 0, 0,
>                   NVME_AQA_ASQS(n->bar.aqa) + 1);
> =20
> +    for (i =3D 1; i <=3D n->num_namespaces; i++) {
> +        ns =3D nvme_ns(n, i);
> +        if (!ns) {
> +            continue;
> +        }
> +        ns->params.attached =3D false;
> +        switch (ns->params.csi) {
> +        case NVME_CSI_NVM:
> +            if (NVME_CC_CSS(n->bar.cc) =3D=3D CSS_NVM_ONLY ||
> +                NVME_CC_CSS(n->bar.cc) =3D=3D CSS_CSI) {
> +                ns->params.attached =3D true;
> +            }
> +            break;
> +        }
> +    }
> +

Considering that the controller doesn't attach/detach
namespaces belonging to command sets that it doesn't
support, I think a nicer way is to remove this for-loop,
and instead, in nvme_ns_setup() or nvme_ns_init(),
always set attached =3D true. (Since we currently don't
support namespace attachment command).

The person that implements the last piece of namespace
management and namespace attachment will have to deal
with reading "attached" from some kind of persistent state
and setting it accordingly.

>      nvme_set_timestamp(n, 0ULL);
> =20
>      QTAILQ_INIT(&n->aer_queue);
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 4587311783..b182fe40b2 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -804,14 +804,18 @@ typedef struct QEMU_PACKED NvmePSD {
>  #define NVME_IDENTIFY_DATA_SIZE 4096
> =20
>  enum NvmeIdCns {
> -    NVME_ID_CNS_NS                =3D 0x00,
> -    NVME_ID_CNS_CTRL              =3D 0x01,
> -    NVME_ID_CNS_NS_ACTIVE_LIST    =3D 0x02,
> -    NVME_ID_CNS_NS_DESCR_LIST     =3D 0x03,
> -    NVME_ID_CNS_CS_NS             =3D 0x05,
> -    NVME_ID_CNS_CS_CTRL           =3D 0x06,
> -    NVME_ID_CNS_CS_NS_ACTIVE_LIST =3D 0x07,
> -    NVME_ID_CNS_IO_COMMAND_SET    =3D 0x1c,
> +    NVME_ID_CNS_NS                    =3D 0x00,
> +    NVME_ID_CNS_CTRL                  =3D 0x01,
> +    NVME_ID_CNS_NS_ACTIVE_LIST        =3D 0x02,
> +    NVME_ID_CNS_NS_DESCR_LIST         =3D 0x03,
> +    NVME_ID_CNS_CS_NS                 =3D 0x05,
> +    NVME_ID_CNS_CS_CTRL               =3D 0x06,
> +    NVME_ID_CNS_CS_NS_ACTIVE_LIST     =3D 0x07,
> +    NVME_ID_CNS_NS_PRESENT_LIST       =3D 0x10,
> +    NVME_ID_CNS_NS_PRESENT            =3D 0x11,
> +    NVME_ID_CNS_CS_NS_PRESENT_LIST    =3D 0x1a,
> +    NVME_ID_CNS_CS_NS_PRESENT         =3D 0x1b,
> +    NVME_ID_CNS_IO_COMMAND_SET        =3D 0x1c,
>  };
> =20
>  typedef struct QEMU_PACKED NvmeIdCtrl {
> --=20
> 2.21.0
> =

