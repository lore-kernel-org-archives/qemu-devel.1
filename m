Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C46C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8678720672
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FmRMNeAi";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rYy707MP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8678720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqHAx-0001Vb-2D
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 10:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=44341d4e9=Niklas.Cassel@wdc.com>)
 id 1jqD5u-0008IE-NO; Tue, 30 Jun 2020 06:02:27 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46894)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=44341d4e9=Niklas.Cassel@wdc.com>)
 id 1jqD5r-0004Oc-5G; Tue, 30 Jun 2020 06:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593511344; x=1625047344;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=PC/yUkXFXylLgRhfaEj7LJNASPXFvl8YnfQUUXcBHQ8=;
 b=FmRMNeAiszez6uN0+JzwwzjWcFMKnDueY3lhV3K4mit4TLoVxwYuJyAV
 hqltfqoYOoWdnw4HdJJsR6vvVpbdPYbnbyG7yI0a47te4YW7cRGHxpdeq
 8WpwJM4dANgcUT8nHrxHR7kas6RU4CKLoU1EO6f57YTfdyDVrHcd8KEDa
 W4aw+LJ/uXd1hXOk6IONC5AwwipBxHzewiZEjLniqL+weq8I5FEmRKr1C
 WtkkaZsAM5eJ36EYwqWwQ3bPePsnAksXnGzC6qM5s/eNCPKML7VFejD6P
 gvMj5z3oLG+aRDzH4+/8cPK6m0AJaVQ/UejRBys04R4qpwEqHqz1WFEhV Q==;
IronPort-SDR: dCLezdW9GvqIJX8k+cqSlLW4qp/PbdLp7cTnE/NoLvuLCMjHK++4MgwSlwdV815Pa76sENNGAO
 uIUz3MTR4LQ0xxGQ6RUlUJHDZ6XtalQOlhGUdJFdiYJ861sR3IPDdCHB/8fYpGQMl9qwYNvF+m
 NvVekMIXg2IQ0rbxFXYH1E21yRM1SRFaz8UnW0hqZ6PX8gpCtuL+z14Kl/Zn8PjMBAAVza2zLg
 u3e+EHNIfesDgOUAcSXu7U290gjKkphaS8HSh308l9ucSdZPiZZQuu2qxZ0BEIm0fhr/QHfCb4
 Ktk=
X-IronPort-AV: E=Sophos;i="5.75,297,1589212800"; d="scan'208";a="145586924"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
 by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2020 18:02:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJNdG7zpjFi1RWw96W68ZnaIby8GXEHlCNOv28zZVUzy4nmge2kprb8fr5XWUew4r4wK/QNDWH7uegkdJjLhFJaUTPNZRGiAKxN2VWU3FyLUSISc39IKtJLyY72h90GkPrMss9uzz4rsj5Fplh6l7IsyokmDwgYfZNmzMB7Y6JFdZEEVc0JR/+ctWlAvtCF6iruekUp8TcPGWoeGStvxBF5K3zRdpyNZFYtPArg246J6vEOqWzKsKOYUAwBExpZ22H1clhM7hi3OdfCFdjDwbBOeWnoFf2qkxZ3jYYzGIxAF/xpZ8U9OI7xMPfnjwzqobIG0/fqUxltPChyiAHdoqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOi3FHgUaz1LWVJ9H4+4JEbrQhgWUzUfFg3gmdiOuRY=;
 b=AwzsL3NtPFt1+j11tjSpCMqX+wGvfDzTQ1yu941ZdEH/FyBzw1ipsJ1/hPUFa+72I+H0JyxolT7c182B0rNkv822Py4jURRYE71Uf4UI5U/c9ivs8nGNt6+YB4+btV6Y7JIc1MIj0LckFP8E+PtcT9e8oNePIPPaBYpI2aMrYfZ1DNc+KdvHCzaCRSD64u09RPHNDOofARx9Rno+1HT+UijAgvzUEkNEiuMYLfZd1tx9NPHaOdc3f6zWYPCzguhmg91Kw6wkKLpwT0kv8mm3z+byw5i63+lGGNYGnIcV29mhZzXTqGJkN+00wQ9RyTUDtCju3l/mQYo7l/4RpcXKaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOi3FHgUaz1LWVJ9H4+4JEbrQhgWUzUfFg3gmdiOuRY=;
 b=rYy707MP1wwb+jtO5uZepzSfMLjX+SeS17xdDonmHbZH1lxzKWMncSasTsqDDkko8+QjgI0+TrCMoF2X0MOdyeUmp1AUG4Ol5TH8ajhexTcizNP0OMK3n3cVM1fzXvmAyGin3MfsptqE57/Mjd5pvt/RfUAzbJV3lHEvlZCTjtU=
Received: from BYAPR04MB5112.namprd04.prod.outlook.com (2603:10b6:a03:45::10)
 by BYAPR04MB5494.namprd04.prod.outlook.com (2603:10b6:a03:e6::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Tue, 30 Jun
 2020 10:02:16 +0000
Received: from BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b]) by BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b%6]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 10:02:16 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Alistair Francis <alistair23@gmail.com>
Subject: Re: [PATCH v2 05/18] hw/block/nvme: Introduce the Namespace Types
 definitions
Thread-Topic: [PATCH v2 05/18] hw/block/nvme: Introduce the Namespace Types
 definitions
Thread-Index: AQHWRO8bQ1sdANlR30yceHLn7+/JoqjwfgaAgACDKgA=
Date: Tue, 30 Jun 2020 10:02:15 +0000
Message-ID: <20200630100214.GA548602@localhost.localdomain>
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
 <20200617213415.22417-6-dmitry.fomichev@wdc.com>
 <CAKmqyKO-O5kVkb-mKmBeCCtmaS8uR+0oau=5FfS_gYrXXX0nHA@mail.gmail.com>
In-Reply-To: <CAKmqyKO-O5kVkb-mKmBeCCtmaS8uR+0oau=5FfS_gYrXXX0nHA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.224.200.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9a2daaff-db17-4bf1-59a3-08d81cdcab10
x-ms-traffictypediagnostic: BYAPR04MB5494:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB54943F09E716D81D9F50E2F3F26F0@BYAPR04MB5494.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c36xtkk6E75HROHdFwlx7jrs+jn1V6002/L4IdtrsskyprqSTDyGnCbOndoxg0128rxy+bTrUckjRt9Zt1e4wmE6D1nj/J6HZNLQCLdkXri1Vt294yynA8Mw3G9UNY58EvXxLLLHTTx2KV/vqsedNae6cmS+2csKQX9yNNRtjtSnRXoqZL0+9DfmWxuIJArmiN1Nxp3tm/p/7UVHWTjoMzxqJaR4zqbTqYyD8mPVCMX8/ZUkZvTi5mGj+I7+56NhYrjFcyjATnQNU0y1RgPeUr0z2IJODWuSVYb5jxQ+E899YMbfBXlzIH8oEdCHbAELKJDMXqp+irVpoXKLBW1hn9R5ofAaOiRHolwhh1+ZXGcm+Hy+1s3xhhaAn/rwCSKjXtyd3XBY4fSf/fSE8n7Fjo8K4PoO/o7jUpk4QB4gtLHWOn5EFCdZ/TSWUPtw55khh/lQ1VnhdOl1rfgaIMyuM7+k6ZnjAuTxymkvPOHlCqc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB5112.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(186003)(66446008)(478600001)(966005)(4326008)(66556008)(66476007)(86362001)(8676002)(6486002)(5660300002)(66946007)(76116006)(1076003)(91956017)(2906002)(26005)(8936002)(9686003)(83380400001)(64756008)(53546011)(33656002)(6512007)(316002)(54906003)(71200400001)(6506007)(6916009)(43620500001)(15398625002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: HLn0OeA17ZOLay5UVvG7vFEU8yEw67xRg2u3oQbAWlaDE2MbKkjdSPuGIq8DOiQpJERpdZ762vu3i5mbVZl+uhzSG1C1N8+Wbbfo8l4dkL2rJ4xPcmnX0ZYaLk/2KQDXrT156VCHGPk2nEPg0/MXDQ6VMxcFpwSpCqrsorwQZXS/vqRFmuh+7fv8Z5iU6Z4doLAYoTmVuAim8H1uUvTuG+7aagiabSSbv8SNvzmLDN5gadCQVAOl3qeE/OYs55x4JgKLslcd1R+8B92nvURpfBsSC6YjZhLUg7/Jk+VP+eKQ4SYcMAsVLpC9HqTxNh6DJjWO0lyGK01g+r8bewKypc6bRp7yiczeDhINu8ye9gmMf0KmZh4wwMBgO9CIw2xC4iKqvgxPy4BwXrQeREWLU6c+oz8lh+4/x3RrUzEdjpKWEpvcF1jus3Ml/uztcEczfEe4QJjfoXKh5DFSLeXQrhT1RrOLp+GO8v+UfIxuNPiqaGQKJ7g24wTI/XDjBLoy
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <2FCD5A0D25932347B8E1E8FB20B75E08@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB5112.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2daaff-db17-4bf1-59a3-08d81cdcab10
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 10:02:16.0364 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: icKWj8mHidaURlEx26A8tFRBjbWnpn4e/yX6hufatkL1r/3jduOWw8EaZLO0dap1RnEzlRhgjQJ/Vey71zmj5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5494
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=44341d4e9=Niklas.Cassel@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 06:02:18
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
 Qemu-block <qemu-block@nongnu.org>, Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Keith Busch <kbusch@kernel.org>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 29, 2020 at 07:12:47PM -0700, Alistair Francis wrote:
> On Wed, Jun 17, 2020 at 2:47 PM Dmitry Fomichev <dmitry.fomichev@wdc.com>=
 wrote:
> >
> > From: Niklas Cassel <niklas.cassel@wdc.com>
> >
> > Define the structures and constants required to implement
> > Namespace Types support.
> >
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> > ---
> >  hw/block/nvme.h      |  3 ++
> >  include/block/nvme.h | 75 +++++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 73 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> > index 4f0dac39ae..4fd155c409 100644
> > --- a/hw/block/nvme.h
> > +++ b/hw/block/nvme.h
> > @@ -63,6 +63,9 @@ typedef struct NvmeCQueue {
> >
> >  typedef struct NvmeNamespace {
> >      NvmeIdNs        id_ns;
> > +    uint32_t        nsid;
> > +    uint8_t         csi;
> > +    QemuUUID        uuid;
> >  } NvmeNamespace;
> >
> >  static inline NvmeLBAF *nvme_ns_lbaf(NvmeNamespace *ns)
> > diff --git a/include/block/nvme.h b/include/block/nvme.h
> > index 6a58bac0c2..5a1e5e137c 100644
> > --- a/include/block/nvme.h
> > +++ b/include/block/nvme.h
> > @@ -50,6 +50,11 @@ enum NvmeCapMask {
> >      CAP_PMR_MASK       =3D 0x1,
> >  };
> >
> > +enum NvmeCapCssBits {
> > +    CAP_CSS_NVM        =3D 0x01,
> > +    CAP_CSS_CSI_SUPP   =3D 0x40,
> > +};
> > +
> >  #define NVME_CAP_MQES(cap)  (((cap) >> CAP_MQES_SHIFT)   & CAP_MQES_MA=
SK)
> >  #define NVME_CAP_CQR(cap)   (((cap) >> CAP_CQR_SHIFT)    & CAP_CQR_MAS=
K)
> >  #define NVME_CAP_AMS(cap)   (((cap) >> CAP_AMS_SHIFT)    & CAP_AMS_MAS=
K)
> > @@ -101,6 +106,12 @@ enum NvmeCcMask {
> >      CC_IOCQES_MASK  =3D 0xf,
> >  };
> >
> > +enum NvmeCcCss {
> > +    CSS_NVM_ONLY        =3D 0,
> > +    CSS_ALL_NSTYPES     =3D 6,
> > +    CSS_ADMIN_ONLY      =3D 7,
> > +};
> > +
> >  #define NVME_CC_EN(cc)     ((cc >> CC_EN_SHIFT)     & CC_EN_MASK)
> >  #define NVME_CC_CSS(cc)    ((cc >> CC_CSS_SHIFT)    & CC_CSS_MASK)
> >  #define NVME_CC_MPS(cc)    ((cc >> CC_MPS_SHIFT)    & CC_MPS_MASK)
> > @@ -109,6 +120,21 @@ enum NvmeCcMask {
> >  #define NVME_CC_IOSQES(cc) ((cc >> CC_IOSQES_SHIFT) & CC_IOSQES_MASK)
> >  #define NVME_CC_IOCQES(cc) ((cc >> CC_IOCQES_SHIFT) & CC_IOCQES_MASK)
> >
> > +#define NVME_SET_CC_EN(cc, val)     \
> > +    (cc |=3D (uint32_t)((val) & CC_EN_MASK) << CC_EN_SHIFT)
> > +#define NVME_SET_CC_CSS(cc, val)    \
> > +    (cc |=3D (uint32_t)((val) & CC_CSS_MASK) << CC_CSS_SHIFT)
> > +#define NVME_SET_CC_MPS(cc, val)    \
> > +    (cc |=3D (uint32_t)((val) & CC_MPS_MASK) << CC_MPS_SHIFT)
> > +#define NVME_SET_CC_AMS(cc, val)    \
> > +    (cc |=3D (uint32_t)((val) & CC_AMS_MASK) << CC_AMS_SHIFT)
> > +#define NVME_SET_CC_SHN(cc, val)    \
> > +    (cc |=3D (uint32_t)((val) & CC_SHN_MASK) << CC_SHN_SHIFT)
> > +#define NVME_SET_CC_IOSQES(cc, val) \
> > +    (cc |=3D (uint32_t)((val) & CC_IOSQES_MASK) << CC_IOSQES_SHIFT)
> > +#define NVME_SET_CC_IOCQES(cc, val) \
> > +    (cc |=3D (uint32_t)((val) & CC_IOCQES_MASK) << CC_IOCQES_SHIFT)
> > +
> >  enum NvmeCstsShift {
> >      CSTS_RDY_SHIFT      =3D 0,
> >      CSTS_CFS_SHIFT      =3D 1,
> > @@ -482,10 +508,41 @@ typedef struct NvmeIdentify {
> >      uint64_t    rsvd2[2];
> >      uint64_t    prp1;
> >      uint64_t    prp2;
> > -    uint32_t    cns;
> > -    uint32_t    rsvd11[5];
> > +    uint8_t     cns;
> > +    uint8_t     rsvd4;
> > +    uint16_t    ctrlid;
>=20
> Shouldn't this be CNTID?

From the NVMe spec:
https://nvmexpress.org/wp-content/uploads/NVM-Express-1_4-2019.06.10-Ratifi=
ed.pdf

Figure 241:
Controller  Identifier  (CNTID)

So you are correct, this is the official abbreviation.

I guess that I tried wanted to keep it in sync with Linux:
https://github.com/torvalds/linux/blob/master/include/linux/nvme.h#L974

Which uses ctrlid.


Looking further at the NVMe spec:
In Figure 247 (Identify Controller Data Structure) they use other names
for fields:

Controller  ID  (CNTLID)
Controller Attributes (CTRATT)

I can understand if they want to have unique names for fields, but it
seems like they have trouble deciding how to abbreviate controller :)

Personally I think that ctrlid is more obvious that we are talking about
a controller and not a count. But I'm fine regardless.


Kind regards,
Niklas

>=20
> Alistair
>=20
> > +    uint16_t    nvmsetid;
> > +    uint8_t     rsvd3;
> > +    uint8_t     csi;
> > +    uint32_t    rsvd12[4];
> >  } NvmeIdentify;
> >
> > +typedef struct NvmeNsIdDesc {
> > +    uint8_t     nidt;
> > +    uint8_t     nidl;
> > +    uint16_t    rsvd2;
> > +} NvmeNsIdDesc;
> > +
> > +enum NvmeNidType {
> > +    NVME_NIDT_EUI64             =3D 0x01,
> > +    NVME_NIDT_NGUID             =3D 0x02,
> > +    NVME_NIDT_UUID              =3D 0x03,
> > +    NVME_NIDT_CSI               =3D 0x04,
> > +};
> > +
> > +enum NvmeNidLength {
> > +    NVME_NIDL_EUI64             =3D 8,
> > +    NVME_NIDL_NGUID             =3D 16,
> > +    NVME_NIDL_UUID              =3D 16,
> > +    NVME_NIDL_CSI               =3D 1,
> > +};
> > +
> > +enum NvmeCsi {
> > +    NVME_CSI_NVM                =3D 0x00,
> > +};
> > +
> > +#define NVME_SET_CSI(vec, csi) (vec |=3D (uint8_t)(1 << (csi)))
> > +
> >  typedef struct NvmeRwCmd {
> >      uint8_t     opcode;
> >      uint8_t     flags;
> > @@ -603,6 +660,7 @@ enum NvmeStatusCodes {
> >      NVME_CMD_ABORT_MISSING_FUSE =3D 0x000a,
> >      NVME_INVALID_NSID           =3D 0x000b,
> >      NVME_CMD_SEQ_ERROR          =3D 0x000c,
> > +    NVME_CMD_SET_CMB_REJECTED   =3D 0x002b,
> >      NVME_LBA_RANGE              =3D 0x0080,
> >      NVME_CAP_EXCEEDED           =3D 0x0081,
> >      NVME_NS_NOT_READY           =3D 0x0082,
> > @@ -729,9 +787,14 @@ typedef struct NvmePSD {
> >  #define NVME_IDENTIFY_DATA_SIZE 4096
> >
> >  enum {
> > -    NVME_ID_CNS_NS             =3D 0x0,
> > -    NVME_ID_CNS_CTRL           =3D 0x1,
> > -    NVME_ID_CNS_NS_ACTIVE_LIST =3D 0x2,
> > +    NVME_ID_CNS_NS                =3D 0x0,
> > +    NVME_ID_CNS_CTRL              =3D 0x1,
> > +    NVME_ID_CNS_NS_ACTIVE_LIST    =3D 0x2,
> > +    NVME_ID_CNS_NS_DESC_LIST      =3D 0x03,
> > +    NVME_ID_CNS_CS_NS             =3D 0x05,
> > +    NVME_ID_CNS_CS_CTRL           =3D 0x06,
> > +    NVME_ID_CNS_CS_NS_ACTIVE_LIST =3D 0x07,
> > +    NVME_ID_CNS_IO_COMMAND_SET    =3D 0x1c,
> >  };
> >
> >  typedef struct NvmeIdCtrl {
> > @@ -825,6 +888,7 @@ enum NvmeFeatureIds {
> >      NVME_WRITE_ATOMICITY            =3D 0xa,
> >      NVME_ASYNCHRONOUS_EVENT_CONF    =3D 0xb,
> >      NVME_TIMESTAMP                  =3D 0xe,
> > +    NVME_COMMAND_SET_PROFILE        =3D 0x19,
> >      NVME_SOFTWARE_PROGRESS_MARKER   =3D 0x80
> >  };
> >
> > @@ -914,6 +978,7 @@ static inline void _nvme_check_size(void)
> >      QEMU_BUILD_BUG_ON(sizeof(NvmeFwSlotInfoLog) !=3D 512);
> >      QEMU_BUILD_BUG_ON(sizeof(NvmeSmartLog) !=3D 512);
> >      QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrl) !=3D 4096);
> > +    QEMU_BUILD_BUG_ON(sizeof(NvmeNsIdDesc) !=3D 4);
> >      QEMU_BUILD_BUG_ON(sizeof(NvmeIdNs) !=3D 4096);
> >      QEMU_BUILD_BUG_ON(sizeof(NvmeEffectsLog) !=3D 4096);
> >  }
> > --
> > 2.21.0
> >
> >=

