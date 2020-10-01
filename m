Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2311C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 11:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28612208B6
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 11:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pxNyS/nD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="anx69xSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28612208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNwh8-0007oQ-BD
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 07:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=536559953=Niklas.Cassel@wdc.com>)
 id 1kNwfr-0006rZ-SM; Thu, 01 Oct 2020 07:22:59 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:59051)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=536559953=Niklas.Cassel@wdc.com>)
 id 1kNwfn-0007i8-91; Thu, 01 Oct 2020 07:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601551375; x=1633087375;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=PX94gycoKUsQrA5wIz04bmSr79YMJWiONbOAhXCkdkA=;
 b=pxNyS/nDulrdJHNgXdFNpxx59VAVLzWyxBj6MdQrHdSZVAI28tPFevJF
 f+1s+FtoPiLgPxOLYt9A59p50178LjR+Qi2xV/muAZmXcB20N6HJUsAGO
 1S7NKoeuO0gDVVoBpjW34uac9m6BIFGLe+SEKca8FRY38Pa1UpjHDkHQ7
 lcUs1+DuYbLgpfragoncz1gA6l8HsEdGgwR76I8WckkNDvUKbUz67SZkL
 TLxxjBJolfjEq9rJmE7pFIi/LBl+VHX0ONwiRFgfTYyXDbBK/Uja3Zn7p
 xG6oxC2nlqmX5b36THVDFE0TrGX4qMLzaMBeg1w0RuqCtY14yi/kOj6CZ w==;
IronPort-SDR: qcS/0pzYLHACq3yB/elifoHCxwu9i8x00W9isJoEjEyorsZ6Tgt+u2nQvp7A3lpu4C8wlMZj9j
 UKcQmVFNLk3aPbm+fwmCuncKleo1FAQRwMK3Ei+t5c3unp20Y7z89X5Lf8WLiGdz2tYwu+3OUH
 8HgRQ64fPLmh61j6BN5cwdfMosHcBtpXOgJ8L64PIN1sFkuBkFvgTl/bmFZCO361ICydLxWF6A
 kOMUEj6W3RxA7unCyjb8OCl84BOV7wmhUNs8KqX3cSNNqJXNpn1ZiaNkc8LX86cizkOhAKSlOO
 Fno=
X-IronPort-AV: E=Sophos;i="5.77,323,1596470400"; d="scan'208";a="148809964"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
 by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2020 19:22:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0Zxnsa03+h2Bt173GqRKS3GEgYtjChenxOZgMXCqCBKOk3PN8iqkM/ZcGkHM02CU8QnOYcJaxwX9f5MDmU0X147w0HBl34wD0dDIfNGm/wvrn3NjUJ4WqeBtwX8dqzp4lyfnB1R2M/hJ+24ygqQuTNA/ZADc/9MzT+Aljj4mzuAk1kT1P46Na0++LAQ4a8DmTNbF92E+jhV7gFg8Xbsxj16VvLEHXsXsiQAC4+2is7UD9v7y/UbyAaD2C6ykKF3uZCozSAMm5QYwsuC9WYzbOZnyEDWJ+aL0uYpSZnXMBT5KheuRmowhqI18cpq/+JvghabFKGhxXCrR0UssuYEFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjMxs98o6Ecem/sWqzEjAhy8oO1XEpyLF6JN5CVKpLc=;
 b=ndLv0aPrl5ywdy7HYC336BFlzF/p9rmhLxBz/g3H7AqBqfGOFfDR0wM1Y8aHN+92SMoMs6n76kW1BUTwlqohN/cOXSSLNum+EnZ6G4THNgvcAH/ScKUEgjORVPFxTQfE+kCsEgSWhfPNIRw6jFuj/3kMpQU123VC3o0EqacDWxYU3Y74ZHcY6VUDUbEBwj+fycSDMt7MQpoaoeOG5YgDKnnMUh7Qk7aX3ASw08UjSSwKULX15qf9c2rnxh9Su5u2xB0AMufPcRnRDQvQoWlT9xtO3d3rSH2h8zJ7tyZKgJbGGkF4whK7rGmHeAva6cqxinb/Y6EXWq2bwTqKD1HvnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjMxs98o6Ecem/sWqzEjAhy8oO1XEpyLF6JN5CVKpLc=;
 b=anx69xSMhmw9WeG1kq+WwSjOR2kNCziCOqs5bAVw54q8W5mRfW3fxLolfxFJ6EpeGoXTJXqMEVDuk0L23qqStUr8OyuEz1DCArITxTYbmN6KcJgR6grsF/410M60Ts+sjJmUOwyIih5JNqKrve//iU+UYDpGEbUV1E1uAqxaOdY=
Received: from BN6PR04MB0724.namprd04.prod.outlook.com (2603:10b6:404:ce::23)
 by BN6PR04MB0420.namprd04.prod.outlook.com (2603:10b6:404:91::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36; Thu, 1 Oct
 2020 11:22:47 +0000
Received: from BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::acb1:47a4:73ba:69a7]) by BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::acb1:47a4:73ba:69a7%9]) with mapi id 15.20.3433.037; Thu, 1 Oct 2020
 11:22:46 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Subject: Re: [PATCH v5 05/14] hw/block/nvme: Add support for Namespace Types
Thread-Topic: [PATCH v5 05/14] hw/block/nvme: Add support for Namespace Types
Thread-Index: AQHWlUAVwLU3dDmYeECN1HNLSzDofqmCn96A
Date: Thu, 1 Oct 2020 11:22:46 +0000
Message-ID: <20201001112245.GA316454@localhost.localdomain>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
 <20200928023528.15260-6-dmitry.fomichev@wdc.com>
In-Reply-To: <20200928023528.15260-6-dmitry.fomichev@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f8199bfb-86f6-461f-9d83-08d865fc52e5
x-ms-traffictypediagnostic: BN6PR04MB0420:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR04MB042010C309E778DF9B725B2DF2300@BN6PR04MB0420.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tvc8iZKPfgoxyFBS5gBnI/KZUpTgOE+5f/tG4Rd5+l9qY/XdP5ZpRF5CTDSY+bj/Bygnf1241R+q29Xs/kHIkJGEtEERz3KirmZifkvNokVm9THkfkn7gpVh1MA9NXb1Mt+pC5AwDeERxMT1YwTSpyrtvMUXqrijRJCDzQczIFHlQ2bGRk12oH7hUvKRJnmp5ASsL873JPGPWHW5kcGPJc/A0znEgbxlPyy/5XboNnFJtN/7o2wt2TYrzcndUPdKu7aZYI06TweBPaMsP3Vfkg5OGd9La4la1EAKuCtTwFD8lt/KHGyp9rg7Ql62GpMt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR04MB0724.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(186003)(26005)(71200400001)(76116006)(64756008)(66556008)(66476007)(66946007)(86362001)(30864003)(33656002)(6506007)(66446008)(6862004)(83380400001)(9686003)(6512007)(5660300002)(54906003)(478600001)(316002)(1076003)(8676002)(6486002)(2906002)(91956017)(6636002)(4326008)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: DHqxgTUSpy4fXeQrfqnzR/44mdCp0zjmBdG30EkbiKIEW4tv8Qjf4/jlf+jsNasD4iGH3LebQ3rlMZ6TkLs8GF0UVupaUCqXu+xQnvM20IxwK6wMm9RlyT8s3dunUfE7rhCFtX/mu5ZxIgnkER+D3NJ8aX9OJZEYdH5r+t5RUevm5LmEbu//lcoGIg54LBxxj2Pf0mMoHTM1ax1i0zouX6FWyHrb9MabmCt6ZKwRg0BvJcblrdd2dw7RD4GVA6C0VHMRxDGxx6t9VqlehtTWDVPnkcDIdK1Dyu+eXqSIuSqo98Q+Rzf0tN8xOKIcgUOHWug7S8Pu6G/gcN0wp6hiHcVzV496Lv0DeJzQQPKM5fza5WssssOmre75+hgN14DBA7qcuk6iQVvoiNObRLzlrDwZTpsLQXMDJsqcU3E1HUhD9uV/lV1DEi3Pt0wbciH8RaOrGKfOtFda5jA7idDe0wtEULMVSyyvI/0wVYrpylKa0g1MAYqaKkrX3H6zMD5lofeT3K84HHsIUoGcxfcAZ0pfGkdySZtFxc9sXbvG3BGj+Sk32kcOnyuMu3EpPLVs/Nhekvml85prAEmtsieKTKrcETNH/KpQ0RJTkQynwcLCaaRaFmRTaeQ4Aiy7xxksqNMUGkdjBbf/eskYAuZ5ng==
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <0F7796989B887B439D8D87CC8DB3CDAB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR04MB0724.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8199bfb-86f6-461f-9d83-08d865fc52e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 11:22:46.8069 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +NeMGjVy75ADTfmL04w6EluWhFGcmCLfOnrkwp1ByMj0BKVuLW15XlfwEpZsR+OqaKz6EtgTO8TEwtt77q0y5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0420
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=536559953=Niklas.Cassel@wdc.com; helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 07:22:51
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

On Mon, Sep 28, 2020 at 11:35:19AM +0900, Dmitry Fomichev wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> Namespace Types introduce a new command set, "I/O Command Sets",
> that allows the host to retrieve the command sets associated with
> a namespace. Introduce support for the command set and enable
> detection for the NVM Command Set.
>=20
> The new workflows for identify commands rely heavily on zero-filled
> identify structs. E.g., certain CNS commands are defined to return
> a zero-filled identify struct when an inactive namespace NSID
> is supplied.
>=20
> Add a helper function in order to avoid code duplication when
> reporting zero-filled identify structures.
>=20
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  hw/block/nvme-ns.c |   3 +
>  hw/block/nvme.c    | 210 +++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 175 insertions(+), 38 deletions(-)
>=20
> diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
> index bbd7879492..31b7f986c3 100644
> --- a/hw/block/nvme-ns.c
> +++ b/hw/block/nvme-ns.c
> @@ -40,6 +40,9 @@ static void nvme_ns_init(NvmeNamespace *ns)
> =20
>      id_ns->nsze =3D cpu_to_le64(nvme_ns_nlbas(ns));
> =20
> +    ns->params.csi =3D NVME_CSI_NVM;
> +    qemu_uuid_generate(&ns->params.uuid); /* TODO make UUIDs persistent =
*/
> +
>      /* no thin provisioning */
>      id_ns->ncap =3D id_ns->nsze;
>      id_ns->nuse =3D id_ns->ncap;
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 29fa005fa2..4ec1ddc90a 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1495,6 +1495,13 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRe=
quest *req)
>      return NVME_SUCCESS;
>  }
> =20
> +static uint16_t nvme_rpt_empty_id_struct(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    uint8_t id[NVME_IDENTIFY_DATA_SIZE] =3D {};
> +
> +    return nvme_dma(n, id, sizeof(id), DMA_DIRECTION_FROM_DEVICE, req);
> +}
> +
>  static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeRequest *req)
>  {
>      trace_pci_nvme_identify_ctrl();
> @@ -1503,11 +1510,23 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, N=
vmeRequest *req)
>                      DMA_DIRECTION_FROM_DEVICE, req);
>  }
> =20
> +static uint16_t nvme_identify_ctrl_csi(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    NvmeIdentify *c =3D (NvmeIdentify *)&req->cmd;
> +
> +    trace_pci_nvme_identify_ctrl_csi(c->csi);
> +
> +    if (c->csi =3D=3D NVME_CSI_NVM) {
> +        return nvme_rpt_empty_id_struct(n, req);
> +    }
> +
> +    return NVME_INVALID_FIELD | NVME_DNR;
> +}
> +
>  static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
>  {
>      NvmeNamespace *ns;
>      NvmeIdentify *c =3D (NvmeIdentify *)&req->cmd;
> -    NvmeIdNs *id_ns, inactive =3D { 0 };
>      uint32_t nsid =3D le32_to_cpu(c->nsid);
> =20
>      trace_pci_nvme_identify_ns(nsid);
> @@ -1518,23 +1537,46 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, Nvm=
eRequest *req)
> =20
>      ns =3D nvme_ns(n, nsid);
>      if (unlikely(!ns)) {
> -        id_ns =3D &inactive;
> -    } else {
> -        id_ns =3D &ns->id_ns;
> +        return nvme_rpt_empty_id_struct(n, req);
>      }
> =20
> -    return nvme_dma(n, (uint8_t *)id_ns, sizeof(NvmeIdNs),
> +    return nvme_dma(n, (uint8_t *)&ns->id_ns, sizeof(NvmeIdNs),
>                      DMA_DIRECTION_FROM_DEVICE, req);
>  }
> =20
> +static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    NvmeNamespace *ns;
> +    NvmeIdentify *c =3D (NvmeIdentify *)&req->cmd;
> +    uint32_t nsid =3D le32_to_cpu(c->nsid);
> +
> +    trace_pci_nvme_identify_ns_csi(nsid, c->csi);
> +
> +    if (!nvme_nsid_valid(n, nsid) || nsid =3D=3D NVME_NSID_BROADCAST) {
> +        return NVME_INVALID_NSID | NVME_DNR;
> +    }
> +
> +    ns =3D nvme_ns(n, nsid);
> +    if (unlikely(!ns)) {
> +        return nvme_rpt_empty_id_struct(n, req);
> +    }
> +
> +    if (c->csi =3D=3D NVME_CSI_NVM) {
> +        return nvme_rpt_empty_id_struct(n, req);
> +    }
> +
> +    return NVME_INVALID_FIELD | NVME_DNR;
> +}
> +
>  static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
>  {
> +    NvmeNamespace *ns;
>      NvmeIdentify *c =3D (NvmeIdentify *)&req->cmd;
> -    static const int data_len =3D NVME_IDENTIFY_DATA_SIZE;
>      uint32_t min_nsid =3D le32_to_cpu(c->nsid);
> -    uint32_t *list;
> -    uint16_t ret;
> -    int j =3D 0;
> +    uint8_t list[NVME_IDENTIFY_DATA_SIZE] =3D {};
> +    static const int data_len =3D sizeof(list);
> +    uint32_t *list_ptr =3D (uint32_t *)list;
> +    int i, j =3D 0;
> =20
>      trace_pci_nvme_identify_nslist(min_nsid);
> =20
> @@ -1548,48 +1590,76 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n,=
 NvmeRequest *req)
>          return NVME_INVALID_NSID | NVME_DNR;
>      }
> =20
> -    list =3D g_malloc0(data_len);
> -    for (int i =3D 1; i <=3D n->num_namespaces; i++) {
> -        if (i <=3D min_nsid || !nvme_ns(n, i)) {
> +    for (i =3D 1; i <=3D n->num_namespaces; i++) {
> +        ns =3D nvme_ns(n, i);
> +        if (!ns) {
>              continue;
>          }
> -        list[j++] =3D cpu_to_le32(i);
> +        if (ns->params.nsid < min_nsid) {
> +            continue;
> +        }
> +        list_ptr[j++] =3D cpu_to_le32(ns->params.nsid);
>          if (j =3D=3D data_len / sizeof(uint32_t)) {
>              break;
>          }
>      }
> -    ret =3D nvme_dma(n, (uint8_t *)list, data_len, DMA_DIRECTION_FROM_DE=
VICE,
> -                   req);
> -    g_free(list);
> -    return ret;
> +
> +    return nvme_dma(n, list, data_len, DMA_DIRECTION_FROM_DEVICE, req);
> +}
> +
> +static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    NvmeNamespace *ns;
> +    NvmeIdentify *c =3D (NvmeIdentify *)&req->cmd;
> +    uint32_t min_nsid =3D le32_to_cpu(c->nsid);
> +    uint8_t list[NVME_IDENTIFY_DATA_SIZE] =3D {};
> +    static const int data_len =3D sizeof(list);
> +    uint32_t *list_ptr =3D (uint32_t *)list;
> +    int i, j =3D 0;
> +
> +    trace_pci_nvme_identify_nslist_csi(min_nsid, c->csi);
> +
> +    if (c->csi !=3D NVME_CSI_NVM) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    for (i =3D 1; i <=3D n->num_namespaces; i++) {
> +        ns =3D nvme_ns(n, i);
> +        if (!ns) {
> +            continue;
> +        }
> +        if (ns->params.nsid < min_nsid) {
> +            continue;
> +        }
> +        list_ptr[j++] =3D cpu_to_le32(ns->params.nsid);
> +        if (j =3D=3D data_len / sizeof(uint32_t)) {
> +            break;
> +        }
> +    }
> +
> +    return nvme_dma(n, list, data_len, DMA_DIRECTION_FROM_DEVICE, req);
>  }
> =20
>  static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *re=
q)
>  {
>      NvmeIdentify *c =3D (NvmeIdentify *)&req->cmd;
> +    NvmeNamespace *ns;
>      uint32_t nsid =3D le32_to_cpu(c->nsid);
> -    uint8_t list[NVME_IDENTIFY_DATA_SIZE];
> -
> -    struct data {
> -        struct {
> -            NvmeIdNsDescr hdr;
> -            uint8_t v[16];
> -        } uuid;
> -    };
> -
> -    struct data *ns_descrs =3D (struct data *)list;
> +    NvmeIdNsDescr *desc;
> +    uint8_t list[NVME_IDENTIFY_DATA_SIZE] =3D {};
> +    static const int data_len =3D sizeof(list);
> +    void *list_ptr =3D list;
> =20
>      trace_pci_nvme_identify_ns_descr_list(nsid);
> =20
> -    if (!nvme_nsid_valid(n, nsid) || nsid =3D=3D NVME_NSID_BROADCAST) {
> -        return NVME_INVALID_NSID | NVME_DNR;
> -    }
> -
>      if (unlikely(!nvme_ns(n, nsid))) {
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
> =20
> -    memset(list, 0x0, sizeof(list));
> +    ns =3D nvme_ns(n, nsid);
> +    if (unlikely(!ns)) {
> +        return nvme_rpt_empty_id_struct(n, req);
> +    }
> =20
>      /*
>       * Because the NGUID and EUI64 fields are 0 in the Identify Namespac=
e data
> @@ -1597,12 +1667,31 @@ static uint16_t nvme_identify_ns_descr_list(NvmeC=
trl *n, NvmeRequest *req)
>       * Namespace Identification Descriptor. Add a very basic Namespace U=
UID
>       * here.
>       */
> -    ns_descrs->uuid.hdr.nidt =3D NVME_NIDT_UUID;
> -    ns_descrs->uuid.hdr.nidl =3D NVME_NIDL_UUID;
> -    stl_be_p(&ns_descrs->uuid.v, nsid);
> +    desc =3D list_ptr;
> +    desc->nidt =3D NVME_NIDT_UUID;
> +    desc->nidl =3D NVME_NIDL_UUID;
> +    list_ptr +=3D sizeof(*desc);
> +    memcpy(list_ptr, ns->params.uuid.data, NVME_NIDL_UUID);
> +    list_ptr +=3D NVME_NIDL_UUID;
> =20
> -    return nvme_dma(n, list, NVME_IDENTIFY_DATA_SIZE,
> -                    DMA_DIRECTION_FROM_DEVICE, req);
> +    desc =3D list_ptr;
> +    desc->nidt =3D NVME_NIDT_CSI;
> +    desc->nidl =3D NVME_NIDL_CSI;
> +    list_ptr +=3D sizeof(*desc);
> +    *(uint8_t *)list_ptr =3D NVME_CSI_NVM;
> +
> +    return nvme_dma(n, list, data_len, DMA_DIRECTION_FROM_DEVICE, req);
> +}
> +
> +static uint16_t nvme_identify_cmd_set(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    uint8_t list[NVME_IDENTIFY_DATA_SIZE] =3D {};
> +    static const int data_len =3D sizeof(list);
> +
> +    trace_pci_nvme_identify_cmd_set();
> +
> +    NVME_SET_CSI(*list, NVME_CSI_NVM);
> +    return nvme_dma(n, list, data_len, DMA_DIRECTION_FROM_DEVICE, req);
>  }
> =20
>  static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
> @@ -1612,12 +1701,20 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeRe=
quest *req)
>      switch (le32_to_cpu(c->cns)) {
>      case NVME_ID_CNS_NS:
>          return nvme_identify_ns(n, req);
> +    case NVME_ID_CNS_CS_NS:
> +        return nvme_identify_ns_csi(n, req);
>      case NVME_ID_CNS_CTRL:
>          return nvme_identify_ctrl(n, req);
> +    case NVME_ID_CNS_CS_CTRL:
> +        return nvme_identify_ctrl_csi(n, req);
>      case NVME_ID_CNS_NS_ACTIVE_LIST:
>          return nvme_identify_nslist(n, req);
> +    case NVME_ID_CNS_CS_NS_ACTIVE_LIST:
> +        return nvme_identify_nslist_csi(n, req);
>      case NVME_ID_CNS_NS_DESCR_LIST:
>          return nvme_identify_ns_descr_list(n, req);
> +    case NVME_ID_CNS_IO_COMMAND_SET:
> +        return nvme_identify_cmd_set(n, req);
>      default:
>          trace_pci_nvme_err_invalid_identify_cns(le32_to_cpu(c->cns));
>          return NVME_INVALID_FIELD | NVME_DNR;
> @@ -1799,6 +1896,9 @@ defaults:
>              result |=3D NVME_INTVC_NOCOALESCING;
>          }
> =20
> +        break;
> +    case NVME_COMMAND_SET_PROFILE:
> +        result =3D 0;
>          break;
>      default:
>          result =3D nvme_feature_default[fid];
> @@ -1939,6 +2039,12 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, Nvme=
Request *req)
>          break;
>      case NVME_TIMESTAMP:
>          return nvme_set_feature_timestamp(n, req);
> +    case NVME_COMMAND_SET_PROFILE:
> +        if (dw11 & 0x1ff) {
> +            trace_pci_nvme_err_invalid_iocsci(dw11 & 0x1ff);
> +            return NVME_CMD_SET_CMB_REJECTED | NVME_DNR;
> +        }
> +        break;
>      default:
>          return NVME_FEAT_NOT_CHANGEABLE | NVME_DNR;
>      }
> @@ -2222,6 +2328,30 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr off=
set, uint64_t data,
>          break;
>      case 0x14:  /* CC */
>          trace_pci_nvme_mmio_cfg(data & 0xffffffff);
> +
> +        if (NVME_CC_CSS(data) !=3D NVME_CC_CSS(n->bar.cc)) {
> +            if (NVME_CC_EN(n->bar.cc)) {

I just saw this print when doing controller reset on a live system.

Added a debug print:
nvme_write_bar WRITING: 0x0 previous: 0x464061

so the second if-statement has to be:

    if (NVME_CC_EN(n->bar.cc) && NVME_CC_EN(data)) {

Sorry for introducing the bug in the first place.


Kind regards,
Niklas

> +                NVME_GUEST_ERR(pci_nvme_err_change_css_when_enabled,
> +                               "changing selected command set when enabl=
ed");
> +            } else {
> +                switch (NVME_CC_CSS(data)) {
> +                case CSS_NVM_ONLY:
> +                    trace_pci_nvme_css_nvm_cset_selected_by_host(data &
> +                                                                 0xfffff=
fff);
> +                    break;
> +                case CSS_CSI:
> +                    NVME_SET_CC_CSS(n->bar.cc, CSS_CSI);
> +                    trace_pci_nvme_css_all_csets_sel_by_host(data & 0xff=
ffffff);
> +                    break;
> +                case CSS_ADMIN_ONLY:
> +                    break;
> +                default:
> +                    NVME_GUEST_ERR(pci_nvme_ub_unknown_css_value,
> +                                   "unknown value in CC.CSS field");
> +                }
> +            }
> +        }
> +
>          /* Windows first sends data, then sends enable bit */
>          if (!NVME_CC_EN(data) && !NVME_CC_EN(n->bar.cc) &&
>              !NVME_CC_SHN(data) && !NVME_CC_SHN(n->bar.cc))
> @@ -2810,7 +2940,11 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice =
*pci_dev)
>      NVME_CAP_SET_MQES(n->bar.cap, 0x7ff);
>      NVME_CAP_SET_CQR(n->bar.cap, 1);
>      NVME_CAP_SET_TO(n->bar.cap, 0xf);
> -    NVME_CAP_SET_CSS(n->bar.cap, 1);
> +    /*
> +     * The device now always supports NS Types, but all commands
> +     * that support CSI field will only handle NVM Command Set.
> +     */
> +    NVME_CAP_SET_CSS(n->bar.cap, (CAP_CSS_NVM | CAP_CSS_CSI_SUPP));
>      NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
> =20
>      n->bar.vs =3D NVME_SPEC_VER;
> --=20
> 2.21.0
> =

