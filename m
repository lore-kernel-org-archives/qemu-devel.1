Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05C1C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:01:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB36F21D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bIVYHQa0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB36F21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwMz-0002Qr-RV
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:01:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1ihvYk-0001OG-Da
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1ihvYi-0006Eo-B5
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:42 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55783)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1ihvYh-0005pY-Tl
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:40 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20191219130934euoutp02570bbb299876ebb6a91e7c3814c35527~hx8CpvRjn0700607006euoutp022
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 13:09:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20191219130934euoutp02570bbb299876ebb6a91e7c3814c35527~hx8CpvRjn0700607006euoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1576760974;
 bh=N+L5zQ/BE7WGEP2zj2y7xXkVts5GT6G6CCiuGTHLnOg=;
 h=From:To:CC:Subject:Date:References:From;
 b=bIVYHQa0Q9C/3gg06NhMd24XVRrsV5QcNHrDEPUvfRrLBhFHvTZqNI8lUIyolHY2X
 hd3yLHBZVCkEQJ87mhIKxX7cFqhOK+AVcHhNS2PI59LF20mkYTALnLG7dTRfFhuBf9
 siiKD7/bc3qdSXdj8mQ2l3nJ/YkiISJwJoFrMwvs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20191219130934eucas1p29352e8e9cb2bb9182a2c0612ae1713ba~hx8ChsNpA0349703497eucas1p28;
 Thu, 19 Dec 2019 13:09:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id D4.FF.61286.E867BFD5; Thu, 19
 Dec 2019 13:09:34 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20191219130934eucas1p256e1c97e6f16a85c8da4a107d9047f53~hx8COSbTz1986619866eucas1p2T;
 Thu, 19 Dec 2019 13:09:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20191219130934eusmtrp298342cf1829bf9c2d7f9f3b3569a7147~hx8CNntpn3097130971eusmtrp2w;
 Thu, 19 Dec 2019 13:09:34 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-43-5dfb768eb06a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id D2.BE.07950.E867BFD5; Thu, 19
 Dec 2019 13:09:34 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20191219130934eusmtip211b5c171af57bdbf94cd59d1a64be03b~hx8CCEPCr2492624926eusmtip2S;
 Thu, 19 Dec 2019 13:09:34 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Thu, 19 Dec 2019 13:09:33 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Thu, 19 Dec 2019 13:09:33 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v4 00/24] nvme: support NVMe v1.3d, SGLs and multiple
 namespaces
Date: Thu, 19 Dec 2019 14:08:57 +0100
Message-ID: <20191219130921.309264-1-k.jensen@samsung.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djPc7p9Zb9jDU4/0rTY3N/OaDHp0DVG
 iyUXUy3m3VK2mPWunc3ieO8OFgc2j02rOtk87lzbw+bx5NpmJo/3+66yBbBEcdmkpOZklqUW
 6dslcGVcXv2QteCcQsXxt7+ZGxinSnUxcnJICJhIrDu1nRnEFhJYwShxZQt/FyMXkP2FUWLW
 4UeMEM5nRomL/7awwXTc3ruPHSKxnFGioXUTC1zVwXNvoDJnGCVO/ZvKBOHsYpTYs3E9E0g/
 m4CmxPY//1lAbBEBaYn2q5NYQYqYBa4zShz6fZEdJCEsECRxcMVVMJtFQFVi1s2NjCA2r4CV
 RO+vBawQh8hLbP32iRUiLihxcuYTsKHMQPHmrbOZIWr62SU2b8qDsF0kHqyaDdUrLPHq+BZ2
 CFtG4v/O+WCXSgh0M0r0ffjKDOHMYJSYvuw70NscQI61RN+ZHBCTGeiD9bv0IXodJY78esoI
 UcEnceOtIMQJfBKTtk1nhgjzSnS0CUFUq0nsaNoKVS0j8XSNwgRGpVlI7p+F5P5ZCKsWMDKv
 YhRPLS3OTU8tNsxLLdcrTswtLs1L10vOz93ECEwrp/8d/7SD8eulpEOMAhyMSjy8Dmm/Y4VY
 E8uKK3MPMUpwMCuJ8N7u+BkrxJuSWFmVWpQfX1Sak1p8iFGag0VJnNd40ctYIYH0xJLU7NTU
 gtQimCwTB6dUAyODd79zGM8Erdu7fKQmn090nLPAs9M77v7vjW02x86kLg3LevXZSPHXDTf+
 jVXt55/Y7/VrPhAiv6Oer4FFJWqreciuDVz7+o2Tbt15l7nWKHjSXrHQA8d23jfOSD7NuqU0
 L+PioxcyO9e7NXfJpc8VLWjP67Nd/fzVQbkn4YrO/53t9df8clZiKc5INNRiLipOBADxIzTQ
 JwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xe7p9Zb9jDa6sEbbY3N/OaDHp0DVG
 iyUXUy3m3VK2mPWunc3ieO8OFgc2j02rOtk87lzbw+bx5NpmJo/3+66yBbBE6dkU5ZeWpCpk
 5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GVcXv2QteCcQsXxt7+Z
 GxinSnUxcnJICJhI3N67j72LkYtDSGApo8TU5vPsEAkZiU9XPkLZwhJ/rnWxQRR9ZJT43TKD
 CcI5wyixf107lLOLUWLd85VMIC1sApoS2//8ZwGxRQSkJdqvTmIFKWIWuM4ocej3RbC5wgIB
 Eiv/bgBrYBFQlZh1cyMjiM0rYCXR+2sBK8RueYmt3z6xQsQFJU7OfAI2lBloQev23+wQtrxE
 89bZzBMYBWchKZuFpGwWkrIFjMyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAqNm27GfW3Yw
 dr0LPsQowMGoxMPrkPY7Vog1say4MvcQowQHs5II7+2On7FCvCmJlVWpRfnxRaU5qcWHGE2B
 npjILCWanA+M6LySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYyH
 mbaeEnITKX0mt07h7aN19deWXFB5tTmLIddDNfJI73UD8Q8HT/m8mD5dcOmzY+f+qydJbXOc
 JcfUIaSdMPHh0qdB62sz7yXOX/vh5YzNZ+dwSZZ5hbl8PJV9RUPOuuJhTEpqi/R21avyrzRS
 xFcUx9/1Ufb74fw1L4LF/mJm6e2Sx9l3/LYosRRnJBpqMRcVJwIAhp/w8LACAAA=
X-CMS-MailID: 20191219130934eucas1p256e1c97e6f16a85c8da4a107d9047f53
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191219130934eucas1p256e1c97e6f16a85c8da4a107d9047f53
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219130934eucas1p256e1c97e6f16a85c8da4a107d9047f53
References: <CGME20191219130934eucas1p256e1c97e6f16a85c8da4a107d9047f53@eucas1p2.samsung.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 210.118.77.12
X-Mailman-Approved-At: Thu, 19 Dec 2019 08:56:47 -0500
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This is v4 of my nvme patches.

This is mostly changes related to Beatas review (thanks again). Some of
the comments led to some refactoring, so the changes trickled down
through the series. That is why the backport diff show a lot of changes.

I dropped 'nvme: allow completion queues in the cmb' from the series as
it is not well tested. And there are no real users for this right now.
p2p might use it, but the support can be added if/when needed.

I ran into some trace event names clashing with the nvme block driver,
so I have included a patch that changes all trace events to use the
`nvme_dev` prefix instead.

I split 'nvme: add support for the get log page command' up to move
adding of the temperature threshold feature to its own commit.

Happy holidays everyone!



git-backport-diff -S -n -r upstream/master.. -u for-upstream/nvme/master/=
v3

[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/24:[down]      'nvme: rename trace events to nvme_dev'
002/24:[----] [-C] 'nvme: remove superfluous breaks'
003/24:[0006] [FC] 'nvme: move device parameters to separate struct'
004/24:[down]      'nvme: add missing fields in the identify data structu=
res'
005/24:[0006] [FC] 'nvme: populate the mandatory subnqn and ver fields'
006/24:[down]      'nvme: refactor nvme_addr_read'
007/24:[0012] [FC] 'nvme: add support for the abort command'
008/24:[0006] [FC] 'nvme: refactor device realization'
009/24:[down]      'nvme: add temperature threshold feature'
010/24:[0070] [FC] 'nvme: add support for the get log page command'
011/24:[0177] [FC] 'nvme: add support for the asynchronous event request =
command'
012/24:[0017] [FC] 'nvme: add missing mandatory features'
013/24:[down]      'nvme: additional tracing'
014/24:[down]      'nvme: make sure ncqr and nsqr is valid'
015/24:[down]      'nvme: bump supported specification to 1.3'
016/24:[0233] [FC] 'nvme: refactor prp mapping'
017/24:[0464] [FC] 'nvme: allow multiple aios per command'
018/24:[----] [--] 'pci: pass along the return value of dma_memory_rw'
019/24:[0058] [FC] 'nvme: handle dma errors'
020/24:[0315] [FC] 'nvme: add support for scatter gather lists'
021/24:[0140] [FC] 'nvme: support multiple namespaces'
022/24:[----] [--] 'nvme: bump controller pci device id'
023/24:[0110] [FC] 'nvme: remove redundant NvmeCmd pointer parameter'
024/24:[0004] [FC] 'nvme: make lba data size configurable'



Klaus Jensen (24):
  nvme: rename trace events to nvme_dev
  nvme: remove superfluous breaks
  nvme: move device parameters to separate struct
  nvme: add missing fields in the identify data structures
  nvme: populate the mandatory subnqn and ver fields
  nvme: refactor nvme_addr_read
  nvme: add support for the abort command
  nvme: refactor device realization
  nvme: add temperature threshold feature
  nvme: add support for the get log page command
  nvme: add support for the asynchronous event request command
  nvme: add missing mandatory features
  nvme: additional tracing
  nvme: make sure ncqr and nsqr is valid
  nvme: bump supported specification to 1.3
  nvme: refactor prp mapping
  nvme: allow multiple aios per command
  pci: pass along the return value of dma_memory_rw
  nvme: handle dma errors
  nvme: add support for scatter gather lists
  nvme: support multiple namespaces
  nvme: bump controller pci device id
  nvme: remove redundant NvmeCmd pointer parameter
  nvme: make lba data size configurable

 block/nvme.c           |   18 +-
 hw/block/Makefile.objs |    2 +-
 hw/block/nvme-ns.c     |  158 ++++
 hw/block/nvme-ns.h     |   62 ++
 hw/block/nvme.c        | 1983 ++++++++++++++++++++++++++++++++--------
 hw/block/nvme.h        |  191 +++-
 hw/block/trace-events  |  203 ++--
 include/block/nvme.h   |  143 ++-
 include/hw/pci/pci.h   |    3 +-
 9 files changed, 2231 insertions(+), 532 deletions(-)
 create mode 100644 hw/block/nvme-ns.c
 create mode 100644 hw/block/nvme-ns.h

--=20
2.24.1


