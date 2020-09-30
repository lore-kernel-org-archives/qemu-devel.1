Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21679C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:26:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A862071E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CqdNT5yd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CoeZXHcl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A862071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNdzY-0006zQ-Dp
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 11:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5353e43af=Niklas.Cassel@wdc.com>)
 id 1kNdmH-0003Wv-C5; Wed, 30 Sep 2020 11:12:22 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:18582)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5353e43af=Niklas.Cassel@wdc.com>)
 id 1kNdmC-0005wE-Ve; Wed, 30 Sep 2020 11:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601478737; x=1633014737;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=j/1o2OM48gVcFa0unHVyO0S+3l9hgT2EYp2z3x22uXw=;
 b=CqdNT5yd4Ycm/PniVKyad1b+34KHRSiyZjhMnKmSzeA0+lOhBSstmbXn
 j5RFBRWRL6YIJKpBoUFMhtGeDZL4OSl4TmcEsDH3u/JQZLg7mm/E7PhwO
 GYzlCdtbS/B8jw8EsUZfMbwrYWaL2PSLARXZz7UHpz1jtqGoIMGXZjVoG
 qzp41qIuC1tMf0WRt0kMv1hGcJI7xOdWasrZn4BC4ZyCaNhpfxm/4pXHs
 tJ4Mm7X8GNEE/6zM9Y4wLFwTw4xtBLR/JVzhqaTpmH9IZnPjyVYEtV9Eh
 VK80uSGt/cSiKNx6f+XWks+RBthPrI/biw9Vh58443nPXNHLLHBRAtiCh Q==;
IronPort-SDR: +LHzPNdoP6CTZSlCQM6AJdZV1DGyIO8VbQY6m2PyPuZ0/D+HZe0MWCSYUdsedcgmOHiQTKnPck
 +GpGAqwSXiZpQRpiwRwdz2D7nPiE/wO80SqUnTmfhlDSUjvC8axm2qN/rghwFKNTyH3mkdGM9J
 d7cZKlorM0fpybJj/eTrgxScFeVH6cdcvqxSSYm6ygvddm9aKKbjFuk5GwHsWU9YIjzigiQK+3
 5ReTguc6CqmNQKbN6wnazfI/j14OCaiLYNJtvLvL97HFhlQOdUa29mtL11QHr/agVOscaqqbID
 +zk=
X-IronPort-AV: E=Sophos;i="5.77,322,1596470400"; d="scan'208";a="149882545"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
 by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2020 23:12:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2dQYSkf6uBVNUu2hxz9utwiIm/0AbWu7IpNe2B2kfVSLYUgsyRDOPKiy26SDkZfx5+C4npnmvqBwr215pqkjloTcx30EvvnEyi02xV2bTURNbe97hXJOl8kXrlUYhRmdjInoJ5DVKSaMTPzpH88dPJgjfE28g9DQedIDoWsIf/drrDV1ZWGQU7vTgJ4OomX2+BqhWmkb20jHDe1peo6wNJ1/MQUxSpXTYIMF3a6zWJynNwfdJs8mDmhcVXW/fr80Rn71A8lG/EkUF7sBqY1hhWpeqfPcv+TjasMpFunjpvzKijNXh9KxCQyjbQKcLeSRpu3JnkSigk/IRJ26g3DLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDmlY7uLOxmVLHF8sEhKECYGhCJkw37+B+yDMJBNRII=;
 b=UiRLlmNghT6aLOSx+mGb1CF9LJXVDeCjxw3BCquB3QB/UtqVcAZFEo9PVll1PMw+4r0NqyBZ+2T6lCS1nHz/iUmF/ndknVKZ47xcIM8FY9EuZAjV8mqK1J4I12HZyxtdCjBzjKk4fSiMZjGc6nYAHbnY1I9ATw4J9pWdZmsXJ5CYLLvOix0kNa4Q5S9C0l64hlvO9up0LVBN6imirazNb0axvBVgOP1pyH1nbMO8nubRcSazsCLScnEnYC1eoE6xTsa3+ufDMHiMIYz/wEEN7iBwEyAYKkQTTmZgfOR3BpwfFa9SXaVyGpep6ACj0+evnqZqQVR63Qv0/LUaGgoVLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDmlY7uLOxmVLHF8sEhKECYGhCJkw37+B+yDMJBNRII=;
 b=CoeZXHcluz5P19QmmhSxVgbzbe62Lycm4m2ERH/zE4UF+wqaP+BkMgQ/P1NkxbpLCiAYjfYAhzXDs8G1b0voX5Qq1nkpdx9kmmpPveG57qGmR+3rMzoZiZWeVxtgic4gdLfRIgZmmM3MIjP+AKHnajQyWe9fmeFPGNLtkcsYiS4=
Received: from BN6PR04MB0724.namprd04.prod.outlook.com (2603:10b6:404:ce::23)
 by BN7PR04MB5428.namprd04.prod.outlook.com (2603:10b6:408:a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28; Wed, 30 Sep
 2020 15:12:10 +0000
Received: from BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::acb1:47a4:73ba:69a7]) by BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::acb1:47a4:73ba:69a7%9]) with mapi id 15.20.3412.029; Wed, 30 Sep 2020
 15:12:10 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Subject: Re: [PATCH v5 09/14] hw/block/nvme: Support Zoned Namespace Command
 Set
Thread-Topic: [PATCH v5 09/14] hw/block/nvme: Support Zoned Namespace Command
 Set
Thread-Index: AQHWlUAbQOQDY76Lzkm8Z8GHZfc6vamBTaGA
Date: Wed, 30 Sep 2020 15:12:09 +0000
Message-ID: <20200930151209.GA217996@localhost.localdomain>
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
x-ms-office365-filtering-correlation-id: 73232324-2449-4bfe-a75a-08d8655333fa
x-ms-traffictypediagnostic: BN7PR04MB5428:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR04MB5428359BDEEE7C89691733FFF2330@BN7PR04MB5428.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:595;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pTORCkFhzhR6Hn1QMz0bJh87JsxBDTgBV7ZeBrEFuL7eocybv3KyWni449DsqYadLlp2wtxNPR2AfihfUbcqjwIRcnE1MgYh8XAqs+bLDfVyTr0QXGL/7z4lPcltzM0YT9fGi5k4CYr1wT8oppsr+JcR+8hfZdr0tQmIw+r8clUAul9fIlvjgPXYUZ4tr3X15YTkzNAUaJvADM0nivLaU2/pM9UFTQFWnStKYRjhvq6JrKRa30/GEFPW/kSDQ27nZo2tZcNf88w7NU8hBaqYm/GrznlA1MpkpBHAVt9S0rLYIm3yQnZsDTevDGKMq33kq8JPZWqjsH0FITgcDEvRV4bO0tEkOwWSu2LmrjcmxRtpPYx3aRBJkCvkeJ+18Q9p
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR04MB0724.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(4326008)(86362001)(83380400001)(66446008)(91956017)(6636002)(66946007)(76116006)(8676002)(6506007)(54906003)(33656002)(6862004)(1076003)(186003)(5660300002)(8936002)(71200400001)(316002)(26005)(66476007)(66556008)(64756008)(9686003)(478600001)(2906002)(6486002)(6512007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 8Sfyg1bcpuYjHgHzZ8xMhTaC13qYjspGHqFt84Gh0JVnXmESwTDTPvTgWeHaI95asBaETvjWNQ7g+w4dfedBkc0codQ9JE+uhb212OpSDm4XM7Djaby7dW7d/eJ5NVavCjD5kQV0LHgKOEoAtd+CbkQKgbYQ17sISbo3VjJA7mvyb3spcTMU+OyDCzrY288Ts8qGY4djuKe6FR4bD+XvIgMHBxmQWvNJ7lKP3I4Kr72sZz3dg4zccLZ019U2hEp+voszUgmwSbDLBpKA1B2IXqDcyUEcI/kBIElpKWvHZPRQzprj3tODVuwVI0dyBSh8CJSJPidY1DOBeJm8G6scnLwpUyQOvBhNEXTBMUyI7NHXaEZ5o/isY0Gi0EX5xpeyWyxHipXYyu97IRQxnP4W4ziCpuRL3jMY0zH2P7AVazVeQ1KMIbxO8sliVF7hJAnBKA4BsHn96UlgsWQ2RIHuOMZz0bDi7WFYZk2YAH51D8umYKmO2P8R2esqq7vm2Ibt4xuJfhumIXCLR0RPVEhN6Odu+GonMnkb5kFORctxzB0sizIgvmwRPhXF3d9WsdLTJG+Qs8WBBRtNOg1J/AUQLn3zxrxzdCCGG9VvShJ9JEaZuB6AkwMyQQ483iXjzQ7+kMMSWK9HMPaqfPoCb4I/5Q==
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <6F7954884AC2D14DAB1E30B06F4C8058@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR04MB0724.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73232324-2449-4bfe-a75a-08d8655333fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 15:12:09.9352 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L2FI00bCQh554Gx/E7hofkg92iNMPzFblPtB/FYFoe8FG887jex5PjKp4w2H/WEhNdf8UQi2UZc1c98n4JYR7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB5428
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=5353e43af=Niklas.Cassel@wdc.com; helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 11:12:13
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

(snip)

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

Actually, intead of naming the helper function, ctrl_has_zns_namespaces(),
a better name might be ctrl_has_zns_support()

Since this is what is used to set the bit in nvme_identify_cmd_set(),

Then, I think that this should be:

if (ctrl_has_zns_support() && csi =3D=3D NVME_CSI_ZONED && NVME_CC_CSS(n->b=
ar.cc) =3D=3D CSS_CSI) {


> +        iocs[NVME_CMD_ZONE_APPEND] =3D NVME_CMD_EFFECTS_CSUPP |
> +                                     NVME_CMD_EFFECTS_LBCC;
> +        iocs[NVME_CMD_ZONE_MGMT_SEND] =3D NVME_CMD_EFFECTS_CSUPP;
> +        iocs[NVME_CMD_ZONE_MGMT_RECV] =3D NVME_CMD_EFFECTS_CSUPP;
> +    }
> =20
>      trans_len =3D MIN(sizeof(cmd_eff_log) - off, buf_len);
> =20



