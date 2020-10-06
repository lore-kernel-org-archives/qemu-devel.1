Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AADC4363A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 01:51:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86A6D2076B
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 01:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kyliQVd4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TpfWLr5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A6D2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPc84-0001Za-Ex
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 21:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=541d58f41=Dmitry.Fomichev@wdc.com>)
 id 1kPc76-0000wa-LU; Mon, 05 Oct 2020 21:50:00 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:2130)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=541d58f41=Dmitry.Fomichev@wdc.com>)
 id 1kPc73-0005pp-7B; Mon, 05 Oct 2020 21:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601948997; x=1633484997;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CjgKZGH+EUn2f2ubH1zTQpY/mcwzXwnd67rddj3huko=;
 b=kyliQVd450ilc+ix/gE41GtIyNOtobmsLMMuK5Ehm82kDhEpcZ8Ddmfy
 2gG+XcQwBUNInCUMBmTATqjJTk/KUX1JbMO2nfNiOf+1UR099SxpxzZKo
 w5zND16ApdH1u8NR0vTCEa/GlcC4pYoh3vf4gf8GAjke/JkSS0eqqwoxo
 LRyMJQmHOphiBdU15jFQ/bxIGEqZNjrYCvXjKxu3UuxmT8uuvPCJpenTy
 93Wd0BQiLRdZRQ1KH0ybIZi5WSf151WYbMW8ZJNJ28tbm/8UxLtLyvCnD
 8pYbSZkwD+qfzzAKxvDr3+zIA2RuTRv5OwLnhHIOKzalqy+wL7llDyj+X Q==;
IronPort-SDR: 4T4mJwWV5b0RvccDWapClqW/aeC3HU7jVk/qckc+r/cOQZC68uYr58mmeCROsEzIl9mWsv8BCG
 M7CwY6WrLKcJj9Z9vvKBeGxdQrYUTveiz3z8OyTvD7KvJD5v54r6Wu2ZRb8fAzzkiu0yDUUqTW
 T8k7ZbMNzE1JwK4kP7M9B7cxTSP5xjtdkEIltO+Ytr/dvhTMoYWdhhoeYTtOHXk2kiFv1q6u6h
 D6IRzv/OCKUIPEiO8fFH4F1XmV1oBThZdyP3PkpIXsT7c8nwjQ9azcDUgBa4tHAvDdHoxyKK3A
 Nug=
X-IronPort-AV: E=Sophos;i="5.77,341,1596470400"; d="scan'208";a="153536180"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
 by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2020 09:49:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/Qcyat4HJwPAA4Zi8HXNdJaOySN9UDvPRfrzN9/m4We9a056P0BHpXTq8f2LZHv6VxEhcEPnq6Ba2G2Y8yMiDTA9qkU7YDGn0elH9TKCV87KhrGYE8Jyd3PReAeeX5x2HIVmYiYGTjU4HSrTMg4ZiQbuD5fKav+efMFjsKqCAsySGbfpFMa8iLY/9GRLpxvgpDfCkzhqIKhe47djDHI2PjAtfh5yuXm0hjXxN7ktjdDA6UasIJC8gEFPVZgzcY+2scwwbhvuhB06/78Bk7aPQZEWgMLj2qWzN0mPHxy0/GSD0fNAXeYUcmk5MBBvhp+6b6nXTPgBXTWgJwDcV9PGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flkSM2X072Fwht+IZXc0fSdMLsaBi5UFJ48sWzA3m3A=;
 b=jXrj4ZNsuUA9thNqNU7AuxMrpdjcssmbt6pfIwg8cBNaef4lD5zzn0/nEgGxdllMOE8LKr9FPgqA+b+MlUIzdFSGWw7vnXRI0xsLYwY2FdkQ3xcsrAJnmoxy0FzCeDEhfsqE9iTGl3N1j0Ha1PXT1ncjNQRm/MzNuYi7EK/giZRjuOwfmMAz+uK4Ap+QqPFSYvq+v6ONUYpQ58VnoRxqNu6Ud0BirtSpLMtITLy9fWFclMEWU5pDsxFWMKKmNgODk9crte+1RVen0nj8gsgzj1k9uGBDaNNzGC0jLVIGxNqdwrew+ds+stNSB90ZhsIMh+cUTVhQzaMVC5a2NmKkZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flkSM2X072Fwht+IZXc0fSdMLsaBi5UFJ48sWzA3m3A=;
 b=TpfWLr5bV3jz1tZj0/+yXrfIxK6G+8rbUrM83JNnR1w9DX16SP2me9r7V1HV1V5PVM+KxkG7LHtBK/WdM/EofqqtbjKXB91PP7IRmYSbjKOwPZCkQXx6gqIOHuyalEaqtcHCK622mVUAAIT1A7jTrqg5x5W5kCzT5y3MRPWpb2I=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5776.namprd04.prod.outlook.com (2603:10b6:208:a2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Tue, 6 Oct
 2020 01:49:51 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94%6]) with mapi id 15.20.3433.044; Tue, 6 Oct 2020
 01:49:50 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: RE: [PATCH 1/9] hw/block/nvme: remove pointless rw indirection
Thread-Topic: [PATCH 1/9] hw/block/nvme: remove pointless rw indirection
Thread-Index: AQHWl3WpclExvcNTFkS36JPl6O0KrqmJ0S6A
Date: Tue, 6 Oct 2020 01:49:50 +0000
Message-ID: <MN2PR04MB595107E6A7E4D7EB9BFC09E2E10D0@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20200930220414.562527-1-kbusch@kernel.org>
 <20200930220414.562527-2-kbusch@kernel.org>
In-Reply-To: <20200930220414.562527-2-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad33d5f5-ed92-4db4-5c78-08d8699a1d45
x-ms-traffictypediagnostic: MN2PR04MB5776:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB5776C8230E48E5E9CD2B537FE10D0@MN2PR04MB5776.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZzV3bT5ioSqIlgd3Sccr7lzbyurSv1Y9MsVjVp0D/8cZCHIPd7vMmy+mcg1x0oS/UvXDOeSIxEo965c5uTcPXs2iJ/2P0TldehkJdiqUWuD812Dus0prlf4xEXrUP83sYK1rCa8L+ymmusFupd1D9Xi1WW0mz2w1IX0dsKApBe1N5GhqUmHJDaAqXljnOK0/LpXMuyOvJjaGpUCy8jDjt5mo9mx1sJ8ttO5SetqfIXvAtHXigpUoO5jAE3kSD0nU9aSiMb1nCNq8wxN4qht97acZtFZ64XpUby6UmPuveb72r/OFg23O6AfyxgAXFCcCJcQ3Nls8L1zgIg7qo7PCww==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(4326008)(2906002)(478600001)(9686003)(76116006)(71200400001)(86362001)(186003)(55016002)(8936002)(53546011)(83380400001)(7696005)(6506007)(110136005)(66556008)(8676002)(66476007)(64756008)(66946007)(66446008)(5660300002)(54906003)(33656002)(26005)(316002)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: mAWa6n6m57EQHjVAInLaVwJ6xh1ZT+nxz/U9Q981/W09P1Y+uvPUyuPnEg4wr8ur1+yirnTh7uxSZDCi8rEg8+sUGCODBDBhtENPOAWPCIfdTefvsiUv95vnmPiKQCikLAEZrpGyFrAAEgbWvZ5rSdGcEv1u/NLsjgPl8FKO1cmPhYZC3kJzM2bbrEI1bOLYsxEXwT4MJRCuho6mZIjV6/8TCpdLsaWI2rF2yV63fFV3G806QX9zXe3SMUqc06YtSIJsZuV2n2ZvqLx0x+gh2NvfAaKo7YMNxaKYPjl9qErhNPiFDX9RNUB7yeBJ5Ymq+mY7tgmxVKXIYOpqUWvEHr3TYytcw8Ms0vhDZwS6BJ1Km0L7uq6EOIOyzYBOgaovGMYjiAy6rZCsSlm6YFQ+HfTAFa8Be/nSd/k5Vj7JaZ7tS/Qns49NxaD8WizdWOhtwNLozz1C/PJvuJyfGPVeU1j6+tGpnrNCSEIlLehu0gP4QBRiQUaL3ovFgCQAaQ0jZX1tnUc96LFeMZUNkm/RldpHfnVb5wiGNxQscqAq6CThvQ68QX6O/scz79kSaRNiexGKZiVT6aieDrNiE+pwUTHKd4BTiVxAY/mOboOby76POBmulgQIx41quj6RHrT5BqAV/pmuGuerP7B1cBDLnA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad33d5f5-ed92-4db4-5c78-08d8699a1d45
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 01:49:50.8051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qnxq7m/Dh1Ljti+T5IXbs3r0kDiAdiIm1dqxW2S8NAW/+S6AVjdqlMx0AT+WVkCpILQYCS9H4rgwYvYcSF1GoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5776
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=541d58f41=Dmitry.Fomichev@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 21:49:53
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
> Subject: [PATCH 1/9] hw/block/nvme: remove pointless rw indirection
>=20
> The code switches on the opcode to invoke a function specific to that
> opcode. There's no point in consolidating back to a common function that
> just switches on that same opcode without any actual common code.
> Restore the opcode specific behavior without going back through another
> level of switches.
>=20
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  hw/block/nvme.c | 91 ++++++++++++++++---------------------------------
>  1 file changed, 29 insertions(+), 62 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index da8344f196..db52ea0db9 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -927,68 +927,12 @@ static void nvme_rw_cb(void *opaque, int ret)
>      nvme_enqueue_req_completion(nvme_cq(req), req);
>  }
>=20
> -static uint16_t nvme_do_aio(BlockBackend *blk, int64_t offset, size_t le=
n,
> -                            NvmeRequest *req)
> -{
> -    BlockAcctCookie *acct =3D &req->acct;
> -    BlockAcctStats *stats =3D blk_get_stats(blk);
> -
> -    bool is_write =3D false;
> -
> -    trace_pci_nvme_do_aio(nvme_cid(req), req->cmd.opcode,
> -                          nvme_io_opc_str(req->cmd.opcode), blk_name(blk=
),
> -                          offset, len);
> -
> -    switch (req->cmd.opcode) {
> -    case NVME_CMD_FLUSH:
> -        block_acct_start(stats, acct, 0, BLOCK_ACCT_FLUSH);
> -        req->aiocb =3D blk_aio_flush(blk, nvme_rw_cb, req);
> -        break;
> -
> -    case NVME_CMD_WRITE_ZEROES:
> -        block_acct_start(stats, acct, len, BLOCK_ACCT_WRITE);
> -        req->aiocb =3D blk_aio_pwrite_zeroes(blk, offset, len,
> -                                           BDRV_REQ_MAY_UNMAP, nvme_rw_c=
b,
> -                                           req);
> -        break;
> -
> -    case NVME_CMD_WRITE:
> -        is_write =3D true;
> -
> -        /* fallthrough */
> -
> -    case NVME_CMD_READ:
> -        block_acct_start(stats, acct, len,
> -                         is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ);
> -
> -        if (req->qsg.sg) {
> -            if (is_write) {
> -                req->aiocb =3D dma_blk_write(blk, &req->qsg, offset,
> -                                           BDRV_SECTOR_SIZE, nvme_rw_cb,=
 req);
> -            } else {
> -                req->aiocb =3D dma_blk_read(blk, &req->qsg, offset,
> -                                          BDRV_SECTOR_SIZE, nvme_rw_cb, =
req);
> -            }
> -        } else {
> -            if (is_write) {
> -                req->aiocb =3D blk_aio_pwritev(blk, offset, &req->iov, 0=
,
> -                                             nvme_rw_cb, req);
> -            } else {
> -                req->aiocb =3D blk_aio_preadv(blk, offset, &req->iov, 0,
> -                                            nvme_rw_cb, req);
> -            }
> -        }
> -
> -        break;
> -    }
> -
> -    return NVME_NO_COMPLETE;
> -}
> -
>  static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
>  {
> -    NvmeNamespace *ns =3D req->ns;
> -    return nvme_do_aio(ns->blkconf.blk, 0, 0, req);
> +    block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,

This should be
block_acct_start(blk_get_stats(req->ns->blkconf.blk), &req->acct, 0,

> +                     BLOCK_ACCT_FLUSH);
> +    req->aiocb =3D blk_aio_flush(n->conf.blk, nvme_rw_cb, req);

and here
req->aiocb =3D blk_aio_flush(req->ns->blkconf.blk, nvme_rw_cb, req);

> +    return NVME_NO_COMPLETE;
>  }
>=20
>  static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
> @@ -1009,7 +953,11 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n,
> NvmeRequest *req)
>          return status;
>      }
>=20
> -    return nvme_do_aio(ns->blkconf.blk, offset, count, req);
> +    block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,

 block_acct_start(blk_get_stats(ns->blkconf.blk), &req->acct, 0,

> +                     BLOCK_ACCT_WRITE);
> +    req->aiocb =3D blk_aio_pwrite_zeroes(n->conf.blk, offset, count,

Here as well,
 req->aiocb =3D blk_aio_pwrite_zeroes(ns->blkconf.blk, offset, count,

> +                                       BDRV_REQ_MAY_UNMAP, nvme_rw_cb, r=
eq);
> +    return NVME_NO_COMPLETE;
>  }
>=20
>  static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
> @@ -1023,6 +971,7 @@ static uint16_t nvme_rw(NvmeCtrl *n,
> NvmeRequest *req)
>      uint64_t data_offset =3D nvme_l2b(ns, slba);
>      enum BlockAcctType acct =3D req->cmd.opcode =3D=3D NVME_CMD_WRITE ?
>          BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
> +    BlockBackend *blk =3D ns->blkconf.blk;
>      uint16_t status;
>=20
>      trace_pci_nvme_rw(nvme_cid(req), nvme_io_opc_str(rw->opcode),
> @@ -1045,7 +994,25 @@ static uint16_t nvme_rw(NvmeCtrl *n,
> NvmeRequest *req)
>          goto invalid;
>      }
>=20
> -    return nvme_do_aio(ns->blkconf.blk, data_offset, data_size, req);
> +    block_acct_start(blk_get_stats(blk), &req->acct, data_size, acct);
> +    if (req->qsg.sg) {
> +        if (acct =3D=3D BLOCK_ACCT_WRITE) {
> +            req->aiocb =3D dma_blk_write(blk, &req->qsg, data_offset,
> +                                       BDRV_SECTOR_SIZE, nvme_rw_cb, req=
);
> +        } else {
> +            req->aiocb =3D dma_blk_read(blk, &req->qsg, data_offset,
> +                                      BDRV_SECTOR_SIZE, nvme_rw_cb, req)=
;
> +        }
> +    } else {
> +        if (acct =3D=3D BLOCK_ACCT_WRITE) {
> +            req->aiocb =3D blk_aio_pwritev(blk, data_offset, &req->iov, =
0,
> +                                         nvme_rw_cb, req);
> +        } else {
> +            req->aiocb =3D blk_aio_preadv(blk, data_offset, &req->iov, 0=
,
> +                                        nvme_rw_cb, req);
> +        }
> +    }
> +    return NVME_NO_COMPLETE;
>=20
>  invalid:
>      block_acct_invalid(blk_get_stats(ns->blkconf.blk), acct);
> --
> 2.24.1


