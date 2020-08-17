Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FE0C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 06:46:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9390820758
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 06:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="pZBLSgwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9390820758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7Yuf-0007zk-Sy
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 02:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k7Ytp-0007To-TE; Mon, 17 Aug 2020 02:45:42 -0400
Received: from charlie.dont.surf ([128.199.63.193]:39150)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k7Ytn-0007OA-9w; Mon, 17 Aug 2020 02:45:41 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id A5DD6BF425;
 Mon, 17 Aug 2020 06:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1597646735;
 bh=7u0m9Qaxa/EOPBR33+kp6ojtS9vHzbd7a/mGn7/0L5I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pZBLSgwVJRTeiAlqHYDAFwLy4s2Pz7zVgCjUKkfNY4l1fnarGljbabe6Jfe37llDz
 mpD39TbMSa0kdJ//06xt6sVeO5f9ARl4iJSJ5Uk80bEKwPLf/eJvL+YDjG8AJ0XGV+
 4SE3F7UKqbndHKzXvHHdgxS/L09D4bJBPnCr7XHnp0eCpLitf2etAfrHkD+k2KApYF
 iPQA3TkVywXiHS1oUAe0znfviwaKlfNOWRw3qxBz+E7hXx67GnZ9siOPHEIuf+AVrq
 ZCIhThr+rjRIzuC6Odrnm1/NFF2By7A59leUs6L6okB1gk7VYORC0OKoH95FCDQoQC
 jkiU72g7aUCIA==
Date: Mon, 17 Aug 2020 08:45:29 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 00/16] hw/block/nvme: dma handling and address mapping
 cleanup
Message-ID: <20200817064520.GA11110@apples.localdomain>
References: <20200729220638.344477-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200729220638.344477-1-its@irrelevant.dk>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 02:29:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul 30 00:06, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> This series consists of patches that refactors dma read/write and adds a
> number of address mapping helper functions.
>=20
> v2:
>   * hw/block/nvme: add mapping helpers
>     - Add an assert in case of out of bounds array access. (Maxim)
>=20
>   * hw/block/nvme: remove redundant has_sg member
>     - Split the fix for the missing qemu_iov_destroy into a fresh patch
>       ("hw/block/nvme: destroy request iov before reuse"). (Minwoo)
>=20
>   * hw/block/nvme: pass request along for tracing [DROPPED]
>     - Dropped the patch and replaced it with a simple patch that just adds
>       tracing to the nvme_map_prp function ("hw/block/nvme: add tracing to
>       nvme_map_prp"). (Minwoo)
>=20
>   * hw/block/nvme: add request mapping helper
>     - Changed the name from nvme_map to nvme_map_dptr. (Minwoo, Maxim)
>=20
>   * hw/block/nvme: add check for mdts
>     - Don't touch the documentaiton for the cmb_size_mb and max_ioqpairs
>       parameters in this patch. (Minwoo)
>=20
>   * hw/block/nvme: refactor NvmeRequest clearing [DROPPED]
>     - Keep NvmeRequest structure clearing as "before use". (Maxim)
>=20
>   * hw/block/nvme: add a namespace reference in NvmeRequest
>   * hw/block/nvme: remove NvmeCmd parameter
>     - Squash these two patches together into "hw/block/nvme: add ns/cmd
>       references in NvmeRequest".
>=20
>   * hw/block/nvme: consolidate qsg/iov clearing
>     - Move the qsg/iov destroys to a new nvme_req_exit function that is c=
alled
>       after the cqe has been posted.
>=20
>   * hw/block/nvme: remove explicit qsg/iov parameters
>     - New patch. THe nvme_map_prp() function doesn't require the qsg and =
iov
>       parameters since it can just get them from the passed NvmeRequest.
>=20
> Based-on: <20200706061303.246057-1-its@irrelevant.dk>
>=20
> Klaus Jensen (16):
>   hw/block/nvme: memset preallocated requests structures
>   hw/block/nvme: add mapping helpers
>   hw/block/nvme: replace dma_acct with blk_acct equivalent
>   hw/block/nvme: remove redundant has_sg member
>   hw/block/nvme: destroy request iov before reuse
>   hw/block/nvme: refactor dma read/write
>   hw/block/nvme: add tracing to nvme_map_prp
>   hw/block/nvme: add request mapping helper
>   hw/block/nvme: verify validity of prp lists in the cmb
>   hw/block/nvme: refactor request bounds checking
>   hw/block/nvme: add check for mdts
>   hw/block/nvme: be consistent about zeros vs zeroes
>   hw/block/nvme: add ns/cmd references in NvmeRequest
>   hw/block/nvme: consolidate qsg/iov clearing
>   hw/block/nvme: use preallocated qsg/iov in nvme_dma_prp
>   hw/block/nvme: remove explicit qsg/iov parameters
>=20
>  block/nvme.c          |   4 +-
>  hw/block/nvme.c       | 506 +++++++++++++++++++++++++++---------------
>  hw/block/nvme.h       |   4 +-
>  hw/block/trace-events |   4 +
>  include/block/nvme.h  |   4 +-
>  5 files changed, 340 insertions(+), 182 deletions(-)
>=20
> --=20
> 2.27.0
>=20
>=20

Thanks for the reviews everyone.

Pushed to nvme-next.

