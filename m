Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89EDC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 23:23:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09A19206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 23:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SeRF7OJb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="T1UU9gqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A19206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNlRL-0004ll-WE
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 19:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=535555f00=Dmitry.Fomichev@wdc.com>)
 id 1kNlQD-0003uK-Jk; Wed, 30 Sep 2020 19:22:05 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:64376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=535555f00=Dmitry.Fomichev@wdc.com>)
 id 1kNlQB-00017f-Ko; Wed, 30 Sep 2020 19:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601508124; x=1633044124;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=JuHZxR1PB5YO8AznrEeW3RqokZonrdwHZSQ3c7Tfb5Q=;
 b=SeRF7OJbG+QZUn4Wjqq4kBpBHmtcx/pPbMbdxXTpUILklZdt1mAjRHMT
 vkqr9aOpzTGjmQuGNNzDxkDZ2u+rcb5p+biLreZRtfFLhpGdV9AW8cZFN
 hkjAZlvuUhbENNC2OlhPzD8Sp9bKND0CSBtfH8D7JxWb2Eg6wNJKSMCOq
 6ypz/8FAzs/r/obiIl6Oj6ztw/1vTYBCeSxOa0tnWuTpSLrKwLA+oSSbz
 kWVVaIqZuCOStJstt9O6fy/sx2CSo1z0aOLmsYIohB9DqWf4AI+D0ipP5
 RvbOWvc/JA+GK5hn7UJAVRqmGQfH3i1Ro9q1/wAL+c4o84CtqGkyvs5zM A==;
IronPort-SDR: PNOvjMW086ZEOvVyGHZ9mEaoha+A9454tavus/M0mTHQ5+dADPCG+t7TI4fnrq/1bSt+jkYzZU
 PJJpAZH+jjBShQzOcjjtHX4sTKs1ij4ix3yRCBm4BR3M1QcwPZ4mnJ+hde2YB01eRVe93y7aEK
 RiGp///V+8aysCfy80b/gbnP4hDoeeUwM8QK68lkeFboFOAas3ysT8RxfZbaCv+//w3b9d+js9
 jaqFfSo2byFn3z/taPKuxicXFIsg1/4pA9/E21IUIgSs+y9cdpDlhpt3B8dtu0zHUU1gEkJ4Cn
 hw4=
X-IronPort-AV: E=Sophos;i="5.77,322,1596470400"; d="scan'208";a="148730511"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
 by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2020 07:22:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbJPdyvrAM6BXnBbFC6hRZ2aT6ltaGHszriNW5X4rTjoMJjuZxyrdmEyt+5NUZKWH5aurOGvczhZX5lOltpTgUXFDdsJ5Oodp5KvVcdx6/XBn3rKLQ3228Js6552tXwKDtWxc+nGM6XZqCAsveoPfHhtxgb1JcVWHdw00OOYcT4nNEz81qkghGxGrxQ7JwSC7T0nV4/FUH18Rdc/XSgkJHm7L8yU1LshJAY3+nnBJaBRSRuLrElWtXsoAvo4s60zSuiLyr4WknyqnULhXbMZOk2k2prj7FcTxIcf37y2Ww1F1O6QOL5/eBacPv9YQW3IGs4aCnlQPSbv+5bFagXc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJfzNdcOj8Hm3I/RXnnjHA9g0LKKNKhLIZ2/9y1xvmI=;
 b=fh16UZluE/Cs49jz8Rb0K53H4r9w3zxdCq820BxEt/eRvxP5Tir1ncwYBZ8d7C2SmlvXjl6POsq07MMjcN1ZcuYbSCn5NTxnAqDIOW9qhZZC2R2pwgCezuIXO8OrF8q+oEOfhCIhOA0r8wKmqyH4h75G4HEx+uciRfhMlvUCARAK/sxeuNOfbgscTjzteW+Id3Vi62zX1P3rAjFEtwJFXA9qPiC48TgSTWw4UH1e0ZBmZmmZzo0iU5pg6NNy74qS0I76hDaO41ly7Fra667q6fh1DxY32b11/+tFRDDkL92zhTUu3zYQ4SSlft6OSEJZybCvWvGST/Z1nX3YQmw91g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJfzNdcOj8Hm3I/RXnnjHA9g0LKKNKhLIZ2/9y1xvmI=;
 b=T1UU9gqcR7Mw6PGN0Z5VPn+oF+H3n5t4HiF89FC9HQiV+CqqdW8Zlpgfe0hWcCem1dl/epRHlYQO2RPjPCRxFbJoybfpJwMO/6LBFHWs+ivdugBV7SRXSc5dZOU1keHKKvrzFyW/ssOkGeGpLikH93fJeraDUEZHebr7qqh1Gqg=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5551.namprd04.prod.outlook.com (2603:10b6:208:e3::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Wed, 30 Sep
 2020 23:21:57 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94%6]) with mapi id 15.20.3433.034; Wed, 30 Sep 2020
 23:21:57 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: RE: [PATCH 8/9] hw/block/nvme: add trace event for requests with
 non-zero status code
Thread-Topic: [PATCH 8/9] hw/block/nvme: add trace event for requests with
 non-zero status code
Thread-Index: AQHWl3WrflscPeYrDUuGO0KT+zNLd6mB0Uxw
Date: Wed, 30 Sep 2020 23:21:57 +0000
Message-ID: <MN2PR04MB5951128DF467E8BA4649A373E1330@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20200930220414.562527-1-kbusch@kernel.org>
 <20200930220414.562527-9-kbusch@kernel.org>
In-Reply-To: <20200930220414.562527-9-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a202e97f-0506-481c-4d41-08d86597a042
x-ms-traffictypediagnostic: MN2PR04MB5551:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB555136CAD8B6AA4AEFB761B3E1330@MN2PR04MB5551.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FJlN/HxC3Ug6G9UBhSwhZwhJFaOubu602Xtrlc5mJT3PzjKvrjloBSrfVJ8HGtfBrlr6JmyYqmMLLfOQqIyJO58H1p4lQQwr5fk9RY8YtHdGT0iAvTnA4n6mSxO8QDBK0BqNy2GtwwQ4Mjb49N93qUkflTPup4B4/fVTw9c//B2wDUzaitG8YCvC6DzFXom9x48Y2DyyvPO+rxEiVUvvVyQBuu4a+PrJ7lQMoyITSTtsmTfbYz8fMfVDr1nN5t7hHDMYPuIIs+kMRRO9Wmvo4d3MoTfelM47UYhtbneH54SBtQT45NgFFsfFfBQzBddgZqTzfEqAGOPKao/rK+rjHA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(66476007)(66556008)(9686003)(76116006)(66946007)(66446008)(8676002)(64756008)(316002)(478600001)(7696005)(186003)(110136005)(2906002)(54906003)(4326008)(8936002)(55016002)(83380400001)(86362001)(6506007)(53546011)(33656002)(52536014)(71200400001)(26005)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: xQuLmDc/FOveG0GkzQP3XvP81cDgkn3Ir8CD5J49h5MrMvHoy+iFazO5GsT9fLhsm6DWU9bxKC6O0ogXfeMBUfGEr8cEAQJmi0fDw2M1udQiHiiEPnMud/2KmhKaSZh1l2AI4Mts21NAt198NsJjFQvuRcniLDUrQHqYVrilgvCQtmUGrE13SB+FdaTV29aHIAoPes5GskkyWL+y4oiyUX1c5GhPCPmaerWkQlSiQulpZq1rJxiCb3BXdxauKDiJAPvD2Y/tnT1uy0pcY9bvBAWtMjXUfmYUYVHmFdLVItDILm9JCQ7PwX2lh6wF5Glqx58Sp7NnVzgEiS3iFX5QB1FZVj7TouDhF4sYEFuYF4uOMbLct31l/MoeQSw9KeJ0xSImxsDkZrSCuvKJ/H+McOeo30OShmV0DmB+HG++fquyC4XvGDoAwH17fOaS6fFOM5FTkcmZL+6liTQDlzb+kValLrOsltYbaUExRDCw2EoLAwItkno24Jxgaek8eVIDoAnXoiX/6OC0t+5QUwPjbYk8DC+JqQGyTKV/z69BuvMYtA7Ch9eJytXgCibXQWH4kLDx7vB8LaQBDeOlF5ka78xFqSvTkGTvjCylsdwPYnMIT3pRvEffrUVn5vJUu/VfCSPF9bCbVej88DmkaHmZ6w==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a202e97f-0506-481c-4d41-08d86597a042
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 23:21:57.5562 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OIgmFvDERbjzznAoxz7w+v6AVVEzgCHhpo2dUZXdTepHzDoch1q+rRzHmouv/CGsF5HmjWhmA9fMDh/Ym+i1Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5551
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=535555f00=Dmitry.Fomichev@wdc.com; helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 19:22:01
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
> Subject: [PATCH 8/9] hw/block/nvme: add trace event for requests with
> non-zero status code
>=20
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> If a command results in a non-zero status code, trace it.
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  hw/block/nvme.c       | 6 ++++++
>  hw/block/trace-events | 1 +
>  2 files changed, 7 insertions(+)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index dc971c9653..16804d0278 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -777,6 +777,12 @@ static void
> nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
>      assert(cq->cqid =3D=3D req->sq->cqid);
>      trace_pci_nvme_enqueue_req_completion(nvme_cid(req), cq->cqid,
>                                            req->status);
> +
> +    if (req->status) {
> +        trace_pci_nvme_err_req_status(nvme_cid(req), nvme_nsid(req->ns),
> +                                      req->status, req->cmd.opcode);
> +    }
> +

Very useful.
Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>

>      QTAILQ_REMOVE(&req->sq->out_req_list, req, entry);
>      QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
>      timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> 500);
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 180c43d258..ff3ca4bbf6 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -89,6 +89,7 @@ pci_nvme_mmio_shutdown_cleared(void) "shutdown
> bit cleared"
>=20
>  # nvme traces for error conditions
>  pci_nvme_err_mdts(uint16_t cid, size_t len) "cid %"PRIu16" len %zu"
> +pci_nvme_err_req_status(uint16_t cid, uint32_t nsid, uint16_t status,
> uint8_t opc) "cid %"PRIu16" nsid %"PRIu32" status 0x%"PRIx16" opc
> 0x%"PRIx8""
>  pci_nvme_err_addr_read(uint64_t addr) "addr 0x%"PRIx64""
>  pci_nvme_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
>  pci_nvme_err_cfs(void) "controller fatal status"
> --
> 2.24.1


