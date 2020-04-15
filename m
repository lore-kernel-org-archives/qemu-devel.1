Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AE0C2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 05:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62838206F9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 05:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62838206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOazF-0002UY-Dl
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 01:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOay5-0000WL-4Q
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:52:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOay3-0002K9-Lw
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:52:13 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47120)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOay0-0002IU-A3; Wed, 15 Apr 2020 01:52:08 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 465F5BF467;
 Wed, 15 Apr 2020 05:52:05 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v7 00/48] nvme: support NVMe v1.3d,
 SGLs and multiple namespaces
Date: Wed, 15 Apr 2020 07:50:52 +0200
Message-Id: <20200415055140.466900-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.26.0
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
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Hi,

v7 is mostly just changes proposed by Maxim. Also, Gollu's patch for the
bit bucket sgl descriptor has been added (patch #43), but it is of a
pretty manageable size.



Changes since v6
~~~~~~~~~~~~~~~~

* 01/48 ("nvme: rename trace events to nvme_dev")
  - indentation nitpicks (Maxim)

* 04/48 ("nvme: bump spec data structures to v1.3")
  - added defines for temperature threshold and sensor selection (Maxim)
  - added defines for the EUI64 and NGUID NIDT types (Maxim)

* 09/48 ("nvme: add max_ioqpairs device parameter")
  - hoisted a bugfix out (Maxim)

* 11/48 ("nvme: refactor device realization")
  - pulled the removal of the duplicated cmbsz/cmbloc struct members to
    separate patch (Maxim)
  - fixed an incomplete error message (Maxim)

* 12/48 ("nvme: add temperature threshold feature")
  - use the defines added in 04/48 (Maxim)
  - remove the addition of the unused 'temperature' NvmeCtrl member

* 13/48 ("nvme: add support for the get log page command")
  - use the already defined NvmeErrorLog type (Maxim)
  - add the 'temperature' NvmeCtrl member here instead (Maxim)

* 15/48 ("nvme: add missing mandatory features")
  - fix off-by-one when validating dw11 for the interrupt vector config
    feature (Maxim)
  - some nitpicks (Maxim)

* 16/48 ("nvme: additional tracing")
  - moved some traces (that was added in later patches) to here

* 19/48 ("nvme: support identify namespace descriptor list")
  - refactored for the nth time; I think I'm finally kind of happy with
    it

* 20/48 ("nvme: enforce valid queue creation sequence")
  - added a comment (Maxim)

* 24/48 ("nvme: add mapping helpers")
  - fixed an off-by-one error that would cause valid read/writes to the
    CMB to be rejected (Maxim)
  - add a check on len so we don't add 0 sized elements to the iovec
    (Maxim)

* 26/48 ("nvme: remove redundant has_sg member")
  - pulled the s/dma_acct/block_acct change to a separate patch (Maxim)

* 36/48 ("nvme: allow multiple aios per command")
  - renamed nvme_req_register_aio to nvme_req_add_aio and added some
    comments (Maxim)
  - killed the prinfo patch
  - pulled a bunch of refactoring stuff into other patches to make this
    one easier to read (Maxim)

* 42/48 ("nvme: add support for scatter gather lists")
  - pulled the nvme_addr_read hardening into its own patch (Maxim)
  - refactored the logic around allowed sgl descriptor types (Maxim)
  - additional comments (Maxim)

* 45/48 ("nvme: support multiple namespaces")
  - fix an inconsistent return value
  - fix an edge error case where all namespaces are allocated (Maxim)



git-backport-diff against rebased v6
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/48:[0006] [FC] 'nvme: rename trace events to nvme_dev'
002/48:[----] [--] 'nvme: remove superfluous breaks'
003/48:[----] [--] 'nvme: move device parameters to separate struct'
004/48:[0017] [FC] 'nvme: bump spec data structures to v1.3'
005/48:[down]      'nvme: use constants in identify'
006/48:[----] [--] 'nvme: refactor nvme_addr_read'
007/48:[----] [--] 'nvme: add support for the abort command'
008/48:[down]      'nvme: fix pci doorbell size calculation'
009/48:[0002] [FC] 'nvme: add max_ioqpairs device parameter'
010/48:[down]      'nvme: remove redundant cmbloc/cmbsz members'
011/48:[0022] [FC] 'nvme: refactor device realization'
012/48:[0013] [FC] 'nvme: add temperature threshold feature'
013/48:[0007] [FC] 'nvme: add support for the get log page command'
014/48:[----] [-C] 'nvme: add support for the asynchronous event request =
command'
015/48:[0002] [FC] 'nvme: add missing mandatory features'
016/48:[0014] [FC] 'nvme: additional tracing'
017/48:[----] [--] 'nvme: make sure ncqr and nsqr is valid'
018/48:[----] [--] 'nvme: add log specific field to trace events'
019/48:[0029] [FC] 'nvme: support identify namespace descriptor list'
020/48:[0005] [FC] 'nvme: enforce valid queue creation sequence'
021/48:[----] [--] 'nvme: provide the mandatory subnqn field'
022/48:[----] [--] 'nvme: bump supported version to v1.3'
023/48:[----] [--] 'nvme: memset preallocated requests structures'
024/48:[0010] [FC] 'nvme: add mapping helpers'
025/48:[down]      'nvme: replace dma_acct with blk_acct equivalent'
026/48:[0007] [FC] 'nvme: remove redundant has_sg member'
027/48:[0011] [FC] 'nvme: refactor dma read/write'
028/48:[0004] [FC] 'nvme: pass request along for tracing'
029/48:[----] [--] 'nvme: add request mapping helper'
030/48:[----] [--] 'nvme: verify validity of prp lists in the cmb'
031/48:[----] [-C] 'nvme: refactor request bounds checking'
032/48:[----] [--] 'nvme: add check for mdts'
033/48:[down]      'nvme: be consistent about zeros vs zeroes'
034/48:[down]      'nvme: refactor NvmeRequest'
035/48:[down]      'nvme: remove NvmeCmd parameter'
036/48:[0218] [FC] 'nvme: allow multiple aios per command'
037/48:[down]      'nvme: add nvme_check_rw helper'
038/48:[----] [--] 'nvme: use preallocated qsg/iov in nvme_dma_prp'
039/48:[----] [--] 'pci: pass along the return value of dma_memory_rw'
040/48:[----] [-C] 'nvme: handle dma errors'
041/48:[down]      'nvme: harden cmb access'
042/48:[0102] [FC] 'nvme: add support for scatter gather lists'
043/48:[down]      'nvme: add support for sgl bit bucket descriptor'
044/48:[----] [-C] 'nvme: refactor identify active namespace id list'
045/48:[0036] [FC] 'nvme: support multiple namespaces'
046/48:[----] [--] 'pci: allocate pci id for nvme'
047/48:[----] [--] 'nvme: change controller pci id'
048/48:[----] [-C] 'nvme: make lba data size configurable'



Gollu Appalanaidu (1):
  nvme: add support for sgl bit bucket descriptor

Klaus Jensen (47):
  nvme: rename trace events to nvme_dev
  nvme: remove superfluous breaks
  nvme: move device parameters to separate struct
  nvme: bump spec data structures to v1.3
  nvme: use constants in identify
  nvme: refactor nvme_addr_read
  nvme: add support for the abort command
  nvme: fix pci doorbell size calculation
  nvme: add max_ioqpairs device parameter
  nvme: remove redundant cmbloc/cmbsz members
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
  nvme: replace dma_acct with blk_acct equivalent
  nvme: remove redundant has_sg member
  nvme: refactor dma read/write
  nvme: pass request along for tracing
  nvme: add request mapping helper
  nvme: verify validity of prp lists in the cmb
  nvme: refactor request bounds checking
  nvme: add check for mdts
  nvme: be consistent about zeros vs zeroes
  nvme: refactor NvmeRequest
  nvme: remove NvmeCmd parameter
  nvme: allow multiple aios per command
  nvme: add nvme_check_rw helper
  nvme: use preallocated qsg/iov in nvme_dma_prp
  pci: pass along the return value of dma_memory_rw
  nvme: handle dma errors
  nvme: harden cmb access
  nvme: add support for scatter gather lists
  nvme: refactor identify active namespace id list
  nvme: support multiple namespaces
  pci: allocate pci id for nvme
  nvme: change controller pci id
  nvme: make lba data size configurable

 MAINTAINERS            |    1 +
 block/nvme.c           |   22 +-
 docs/specs/nvme.txt    |   25 +
 docs/specs/pci-ids.txt |    1 +
 hw/block/Makefile.objs |    2 +-
 hw/block/nvme-ns.c     |  162 +++
 hw/block/nvme-ns.h     |   62 ++
 hw/block/nvme.c        | 2139 ++++++++++++++++++++++++++++++++--------
 hw/block/nvme.h        |  177 +++-
 hw/block/trace-events  |  206 ++--
 hw/core/machine.c      |    1 +
 include/block/nvme.h   |  190 +++-
 include/hw/pci/pci.h   |    4 +-
 13 files changed, 2413 insertions(+), 579 deletions(-)
 create mode 100644 docs/specs/nvme.txt
 create mode 100644 hw/block/nvme-ns.c
 create mode 100644 hw/block/nvme-ns.h

--=20
2.26.0


