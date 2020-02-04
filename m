Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2007AC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:04:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E12512192A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sOxel5kd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E12512192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyv4g-0002Jv-2i
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 05:04:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1iyv0n-0004Ti-DG
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:00:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1iyv0l-0001o0-UW
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:00:53 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38907)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1iyv0l-0001a9-Mw
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:00:51 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204095216euoutp0199b1d6c36b307a08366d8dffada2d61e~wKkLoT2Kv3027830278euoutp01_
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 09:52:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200204095216euoutp0199b1d6c36b307a08366d8dffada2d61e~wKkLoT2Kv3027830278euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580809936;
 bh=hmIfq3RJfC7qJq6LioldwQTF1K+aTC7oVH3UHtVx2ho=;
 h=From:To:CC:Subject:Date:References:From;
 b=sOxel5kdemqmvciNNF3/xRrjQYjqghW74y8rVbHxIX7z6tcasQt3qhyD9NjsgVlEH
 AseZXaN+NoV3RJMT6vJR0ogftYCSbzZyUiQkuLmbonsM6pSXBVqh2IBzMvJw/r46lr
 V+frQ066yaTi5W/RrhfaAueyTo/LZ+VsMK1j5FDY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200204095215eucas1p18d99c1c71a171d3c225688580a8014ee~wKkLgIFj10928009280eucas1p10;
 Tue,  4 Feb 2020 09:52:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id BB.8E.61286.FCE393E5; Tue,  4
 Feb 2020 09:52:15 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200204095215eucas1p1bb0d5a3c183f7531d8b0e5e081f1ae6b~wKkLMbzU10043700437eucas1p1D;
 Tue,  4 Feb 2020 09:52:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200204095215eusmtrp249378f977eb44415eb815cf0ea9413d9~wKkLLzC5K0487104871eusmtrp2F;
 Tue,  4 Feb 2020 09:52:15 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-db-5e393ecf4fbc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id ED.5A.07950.FCE393E5; Tue,  4
 Feb 2020 09:52:15 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200204095215eusmtip25c486c35aed52906b7e5f505296c5eae~wKkLBsTAU2738327383eusmtip2I;
 Tue,  4 Feb 2020 09:52:15 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Tue, 4 Feb 2020 09:52:15 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Tue, 4 Feb 2020 09:52:14 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v5 00/26] nvme: support NVMe v1.3d, SGLs and multiple
 namespaces
Date: Tue, 4 Feb 2020 10:51:42 +0100
Message-ID: <20200204095208.269131-1-k.jensen@samsung.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsWy7djP87rn7SzjDKbMNrLY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFFcNimpOZllqUX6dglcGR8fzGQrOCFe8XX1BrYGxm+CXYwcHBICJhJtXd5djJwcQgIrGCXu
 PGbrYuQCsr8wSmy5/pwVwvnMKHHjzlZWmIb10wQg4ssZJU7N6GGBKzr04Cc7hHOaUeJ6xyEo
 ZyejxMUNILM4OdgENCW2//nPAmKLCEhLtF+dBLaDWeA3o8TcxolsIDuEBYIklj0IA6lhEVCR
 uHbjCxuIzStgJbHyehcziC0hIC8xu/E0VFxQ4uTMJ2AzmYHizVtnM4PMlBBYxC6xp+8JK0SD
 i8Sd+wsZIWxhiVfHt7BD2DIS/3fOZ4Jo6GaU6PvwFap7BqPE9GXf2SC+tpboO5MDYjIDfbB+
 lz5Er6PEqm+PoCr4JG68FYS4gU9i0rbpzBBhXomONiGIajWJHU1bGSHCMhJP1yhMYFSaheSB
 WUgemIWwagEj8ypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzANHP63/FPOxi/Xko6xCjA
 wajEw3vBziJOiDWxrLgy9xCjBAezkgjveX3LOCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8xote
 xgoJpCeWpGanphakFsFkmTg4pRoYp/94/CT9ue5qFg+trSfWri0+sVjgUbe5wMTv2/UnNL3a
 27Q4YoLA97rNkZKqN9K7l+Zvi790a5Vbx6rCdUYmCpvW7ZRWWvp815G13YzrlFT1nq0pOeVg
 umk594E5h4oFXDz6iuTvn9N0XXbEWOTX/IdGG09PvqQtb+ZRzPlDmPnLEYaNcVNZNyqxFGck
 GmoxFxUnAgD29aa1LwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xe7rn7SzjDLZvkbPY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GR8f
 zGQrOCFe8XX1BrYGxm+CXYwcHBICJhLrpwl0MXJyCAksZZRYcjMHxJYQkJH4dOUjO4QtLPHn
 WhdbFyMXUM1HRokt5y6zQDinGSX+bp7JDOHsZJT4eukZE0gLm4CmxPY//1lAbBEBaYn2q5NY
 QWxmgd+MEn/6AkE2CwsESDy8LgoSZhFQkbh24wsbiM0rYCWx8noXM8RmeYnZjaeh4oISJ2c+
 YYEYoynRuv03O4QtL9G8dTbzBEbBWUjKZiEpm4WkbAEj8ypGkdTS4tz03GIjveLE3OLSvHS9
 5PzcTYzACNp27OeWHYxd74IPMQpwMCrx8Go4WsQJsSaWFVfmHmKU4GBWEuE9r28ZJ8SbklhZ
 lVqUH19UmpNafIjRFOiJicxSosn5wOjOK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5Ykpqd
 mlqQWgTTx8TBKdXAKF2sKzTrDMdLnWrF+1zH9Sq8CmME8u7N+nq0VVPu6kGb3IzzslZ89Za6
 tXa3Jf3FSiN+JU0JTVRpku3OPcjTOOl7uMziJbmu9v8+97+7Wrbvnb7WzfdfLUVKpnyuzeSw
 2mu8KTZ6kap50NMD31NDTsYm1+pHT31x5WOdjX5xIkMjq+HcLFslluKMREMt5qLiRAAu+k9U
 tgIAAA==
X-CMS-MailID: 20200204095215eucas1p1bb0d5a3c183f7531d8b0e5e081f1ae6b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204095215eucas1p1bb0d5a3c183f7531d8b0e5e081f1ae6b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095215eucas1p1bb0d5a3c183f7531d8b0e5e081f1ae6b
References: <CGME20200204095215eucas1p1bb0d5a3c183f7531d8b0e5e081f1ae6b@eucas1p1.samsung.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.11
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
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,


Changes since v4
 - Changed vendor and device id to use a Red Hat allocated one. For
   backwards compatibility add the 'x-use-intel-id' nvme device
   parameter. This is off by default but is added as a machine compat
   property to be true for machine types <=3D 4.2.

 - SGL mapping code has been refactored.


Comments specific to Beata's review:
 - [PATCH v4 19/24] nvme: handle dma errors
   I ended up not including any specific code for resetting the device
   when dma transfers fail for too long. If running I/O and then
   disabling bus master, the OS will (should) eventually reset the
   device and reenable bus mastering (this is the behavior in Linux at
   least). The device can maybe set CFS ("Controller Fail Status") in
   the BAR, but I have not explored that for now.

 - [PATCH v4 17/24] nvme: allow multiple aios per command
   I forgot to give an answer for your comment on the correctness of:

     if (unlikely((slba + nlb) > nsze)) {

   `slba` *is* the "address" of the first logical block, but it is in
   terms of logical blocks, so the condition should be correct. (and at
   this point `nlb` is no longer a 0's based value)


Klaus Jensen (26):
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
  nvme: use preallocated qsg/iov in nvme_dma_prp
  pci: pass along the return value of dma_memory_rw
  nvme: handle dma errors
  nvme: add support for scatter gather lists
  nvme: support multiple namespaces
  pci: allocate pci id for nvme
  nvme: change controller pci id
  nvme: remove redundant NvmeCmd pointer parameter
  nvme: make lba data size configurable

 MAINTAINERS            |    1 +
 block/nvme.c           |   18 +-
 docs/specs/nvme.txt    |   10 +
 docs/specs/pci-ids.txt |    1 +
 hw/block/Makefile.objs |    2 +-
 hw/block/nvme-ns.c     |  158 ++++
 hw/block/nvme-ns.h     |   62 ++
 hw/block/nvme.c        | 2012 +++++++++++++++++++++++++++++++---------
 hw/block/nvme.h        |  201 +++-
 hw/block/trace-events  |  204 ++--
 hw/core/machine.c      |    1 +
 include/block/nvme.h   |  143 ++-
 include/hw/pci/pci.h   |    4 +-
 13 files changed, 2266 insertions(+), 551 deletions(-)
 create mode 100644 docs/specs/nvme.txt
 create mode 100644 hw/block/nvme-ns.c
 create mode 100644 hw/block/nvme-ns.h

--=20
2.25.0


