Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF13C2BB1D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F25220663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F25220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDskA-00050W-72
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jDqkP-0008LN-S2
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:29:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jDqkO-0007LD-8L
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:29:41 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jDqkK-0006T5-JT; Mon, 16 Mar 2020 10:29:36 -0400
Received: from apples.local (80-62-117-52-mobile.dk.customer.tdc.net
 [80.62.117.52])
 by charlie.dont.surf (Postfix) with ESMTPSA id 5C201BF538;
 Mon, 16 Mar 2020 14:29:34 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v6 00/42] nvme: support NVMe v1.3d,
 SGLs and multiple namespaces
Date: Mon, 16 Mar 2020 07:28:46 -0700
Message-Id: <20200316142928.153431-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Hi,

So this patchset kinda blew up in size (wrt. number of patches) after
Maxim's comments (26 -> 42), but Maxim's comments about splitting up a
bunch of the patches made a lot of sense.

v6 primarily splits up the big nasty patches into more digestible parts.
Specifically the 'nvme: refactor prp mapping' and 'nvme: allow multiple
aios per command' patches has been split up according to Maxim's
comments. Most additions to the shared include/block/nvme.h has also
been consolidated into a single patch (also according to Maxim's
comments). A lot of the patches still carries a 'Reviewed-By', but
git-backport-diff reports some changes due to changes/additions in some
of the early patches.

The only real "addition" is a new "max_ioqpairs" parameter for the
device. This is to fix some confusion about the current "num_queues"
parameter. See "nvme: add max_ioqpairs device parameter".

Maxim, I responded to your comments in the original thread and I believe
that all your comments has been adressed.

Also, I *did* change the line indentation style - I hope I caught 'em
all :)


Klaus Jensen (42):
  nvme: rename trace events to nvme_dev
  nvme: remove superfluous breaks
  nvme: move device parameters to separate struct
  nvme: bump spec data structures to v1.3
  nvme: use constant for identify data size
  nvme: add identify cns values in header
  nvme: refactor nvme_addr_read
  nvme: add support for the abort command
  nvme: add max_ioqpairs device parameter
  nvme: refactor device realization
  nvme: add temperature threshold feature
  nvme: add support for the get log page command
  nvme: add support for the asynchronous event request command
  nvme: add missing mandatory features
  nvme: additional tracing
  nvme: make sure ncqr and nsqr is valid
  nvme: add log specific field to trace events
  nvme: support identify namespace descriptor list
  nvme: enforce valid queue creation sequence
  nvme: provide the mandatory subnqn field
  nvme: bump supported version to v1.3
  nvme: memset preallocated requests structures
  nvme: add mapping helpers
  nvme: remove redundant has_sg member
  nvme: refactor dma read/write
  nvme: pass request along for tracing
  nvme: add request mapping helper
  nvme: verify validity of prp lists in the cmb
  nvme: refactor request bounds checking
  nvme: add check for mdts
  nvme: add check for prinfo
  nvme: allow multiple aios per command
  nvme: use preallocated qsg/iov in nvme_dma_prp
  pci: pass along the return value of dma_memory_rw
  nvme: handle dma errors
  nvme: add support for scatter gather lists
  nvme: refactor identify active namespace id list
  nvme: support multiple namespaces
  pci: allocate pci id for nvme
  nvme: change controller pci id
  nvme: remove redundant NvmeCmd pointer parameter
  nvme: make lba data size configurable

 MAINTAINERS            |    1 +
 block/nvme.c           |   18 +-
 docs/specs/nvme.txt    |   25 +
 docs/specs/pci-ids.txt |    1 +
 hw/block/Makefile.objs |    2 +-
 hw/block/nvme-ns.c     |  162 ++++
 hw/block/nvme-ns.h     |   62 ++
 hw/block/nvme.c        | 2041 ++++++++++++++++++++++++++++++++--------
 hw/block/nvme.h        |  205 +++-
 hw/block/trace-events  |  206 ++--
 hw/core/machine.c      |    1 +
 include/block/nvme.h   |  178 +++-
 include/hw/pci/pci.h   |    4 +-
 13 files changed, 2347 insertions(+), 559 deletions(-)
 create mode 100644 docs/specs/nvme.txt
 create mode 100644 hw/block/nvme-ns.c
 create mode 100644 hw/block/nvme-ns.h

--=20
2.25.1

