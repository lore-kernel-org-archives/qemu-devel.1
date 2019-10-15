Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF92C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:47:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7115E2089C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7115E2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKKMO-0006rD-ON
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 06:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1iKKEZ-0007P9-Rd
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1iKKEY-0006Fc-5Y
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:39:19 -0400
Received: from charlie.dont.surf ([128.199.63.193]:54724)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1iKKET-00067v-OZ; Tue, 15 Oct 2019 06:39:13 -0400
Received: from apples.localdomain (unknown [194.62.217.57])
 by charlie.dont.surf (Postfix) with ESMTPSA id D6ED9BF506;
 Tue, 15 Oct 2019 10:39:09 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v2 00/20] nvme: support NVMe v1.3d,
 SGLs and multiple namespaces
Date: Tue, 15 Oct 2019 12:38:40 +0200
Message-Id: <20191015103900.313928-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.199.63.193
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Javier Gonzalez <javier@javigon.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>,
 Paul Durrant <Paul.Durrant@citrix.com>, Stephen Bates <sbates@raithlin.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

(Quick note to Fam): most of this series is irrelevant to you as the
maintainer of the nvme block driver, but patch "nvme: add support for
scatter gather lists" touches block/nvme.c due to changes in the shared
NvmeCmd struct.

Anyway, v2 comes with a good bunch of changes. Compared to v1[1], I have
squashed some commits in the beginning of the series and heavily
refactored "nvme: support multiple block requests per request" into the
new commit "nvme: allow multiple aios per command".

I have also removed the original implementation of the Abort command
(commit "nvme: add support for the abort command") as it is currently
too tricky to test reliably. It has been replaced by a stub that,
besides a trivial sanity check, just fails to abort the given command.
*Some* implementation of the Abort command is mandatory, but given the
"best effort" nature of the command this is acceptable for now. When the
device gains support for arbitration it should be less tricky to test.

The support for multiple namespaces is now backwards compatible. The
nvme device still accepts a 'drive' parameter, but for multiple
namespaces the use of 'nvme-ns' devices are required. I also integrated
some feedback from Paul so the device supports non-consecutive namespace
ids.

I have also added some new commits at the end:

  - "nvme: bump controller pci device id" makes sure the Linux kernel
    doesn't apply any quirks to the controller that it no longer has.
  - "nvme: handle dma errors" won't actually do anything before this[2]
    fix to include/hw/pci/pci.h is merged. With these two patches added,
    the device reliably passes some additional nasty tests from blktests
    (block/011 "disable PCI device while doing I/O" and block/019 "break
    PCI link device while doing I/O"). Before this patch, block/011
    would pass from time to time if you were lucky, but would at least
    mess up the controller pretty badly, causing a reset in the best
    case.


  [1]: https://patchwork.kernel.org/project/qemu-devel/list/?series=3D142=
383
  [2]: https://patchwork.kernel.org/patch/11184911/


Klaus Jensen (20):
  nvme: remove superfluous breaks
  nvme: move device parameters to separate struct
  nvme: add missing fields in the identify controller data structure
  nvme: populate the mandatory subnqn and ver fields
  nvme: allow completion queues in the cmb
  nvme: add support for the abort command
  nvme: refactor device realization
  nvme: add support for the get log page command
  nvme: add support for the asynchronous event request command
  nvme: add logging to error information log page
  nvme: add missing mandatory features
  nvme: bump supported specification version to 1.3
  nvme: refactor prp mapping
  nvme: allow multiple aios per command
  nvme: add support for scatter gather lists
  nvme: support multiple namespaces
  nvme: bump controller pci device id
  nvme: remove redundant NvmeCmd pointer parameter
  nvme: make lba data size configurable
  nvme: handle dma errors

 block/nvme.c           |   18 +-
 hw/block/Makefile.objs |    2 +-
 hw/block/nvme-ns.c     |  139 +++
 hw/block/nvme-ns.h     |   60 ++
 hw/block/nvme.c        | 1863 +++++++++++++++++++++++++++++++++-------
 hw/block/nvme.h        |  219 ++++-
 hw/block/trace-events  |   37 +-
 include/block/nvme.h   |  132 ++-
 8 files changed, 2094 insertions(+), 376 deletions(-)
 create mode 100644 hw/block/nvme-ns.c
 create mode 100644 hw/block/nvme-ns.h

--=20
2.23.0


