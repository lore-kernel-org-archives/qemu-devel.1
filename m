Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E75DC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:46:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 435E1206A3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435E1206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44596 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRYVf-0000Z0-87
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 04:46:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klaus@birkelund.eu>) id 1hRYTF-0007S3-AA
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:44:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klaus@birkelund.eu>) id 1hRYTC-00061t-PX
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:44:04 -0400
Received: from charlie.dont.surf ([128.199.63.193]:40154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <klaus@birkelund.eu>)
	id 1hRYT8-0005tR-Iv; Fri, 17 May 2019 04:43:58 -0400
Received: from apples.localdomain (ip-5-186-120-196.cgn.fibianet.dk
	[5.186.120.196])
	by charlie.dont.surf (Postfix) with ESMTPSA id 6A699C00AA;
	Fri, 17 May 2019 08:43:55 +0000 (UTC)
From: Klaus Birkelund Jensen <klaus@birkelund.eu>
To: qemu-block@nongnu.org
Date: Fri, 17 May 2019 10:42:26 +0200
Message-Id: <20190517084234.26923-1-klaus@birkelund.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: [Qemu-devel] [PATCH 0/8] nvme: v1.3, sgls,
 metadata and new 'ocssd' device
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series of patches contains a number of refactorings to the emulated
nvme device, adds additional features, such as support for metadata and
scatter gather lists, and bumps the supported NVMe version to 1.3.
Lastly, it contains a new 'ocssd' device.

The motivation for the first seven patches is to set everything up for
the final patch that adds a new 'ocssd' device and associated block
driver that implements the OpenChannel 2.0 specification[1]. Many of us
in the OpenChannel comunity have used a qemu fork[2] for emulation of
OpenChannel devices. The fork is itself based on Keith's qemu-nvme
tree[3] and we recently merged mainline qemu into it, but the result is
still a "hybrid" nvme device that supports both conventional nvme and
the OCSSD 2.0 spec through a 'dialect' mechanism. Merging instead of
rebasing also created a pretty messy commit history and my efforts to
try and rebase our work onto mainline was getting hairy to say the
least. And I was never really happy with the dialect approach anyway.

I have instead prepared this series of fresh patches that incrementally
adds additional features to the nvme device to bring it into shape for
finally introducing a new (and separate) 'ocssd' device that emulates an
OpenChannel 2.0 device by reusing core functionality from the nvme
device. Providing a separate ocssd device ensures that no ocssd specific
stuff creeps into the nvme device.

The ocssd device is backed by a new 'ocssd' block driver that holds
internal meta data and keeps state permanent across power cycles. In the
future I think we could use the same approach for the nvme device to
keep internal metadata such as utilization and deallocated blocks. For
now, the nvme device does not support the Deallocated and Unwritten
Logical Block Error (DULBE) feature or the Data Set Management command
as this would require such support.

I have tried to make the patches to the nvme device in this series as
digestible as possible, but I undestand that commit 310fcd5965e5 ("nvme:
bump supported spec to 1.3") is pretty huge. I can try to chop it up if
required, but the changes pretty much needs to be done in bulk to
actually implement v1.3.

This version was recently used to find a bug in use of SGLs in the Linux
kernel, so I believe there is some value in introducing these new
features. As for the ocssd device I believe that it is time it is
included upstream and not kept seperately. I have knowledge of at least
one other qemu fork implementing OCSSD 2.0 used by the SPDK team and I
think we could all benefit from using a common implementation. The ocssd
device is feature complete with respect to the OCSSD 2.0 spec (mandatory
as well as optional features).

  [1]: http://lightnvm.io/docs/OCSSD-2_0-20180129.pdf
  [2]: https://github.com/OpenChannelSSD/qemu-nvme
  [3]: http://git.infradead.org/users/kbusch/qemu-nvme.git


Klaus Birkelund Jensen (8):
  nvme: move device parameters to separate struct
  nvme: bump supported spec to 1.3
  nvme: simplify PRP mappings
  nvme: allow multiple i/o's per request
  nvme: add support for metadata
  nvme: add support for scatter gather lists
  nvme: keep a copy of the NVMe command in request
  nvme: add an OpenChannel 2.0 NVMe device (ocssd)

 MAINTAINERS                |   14 +-
 Makefile.objs              |    1 +
 block.c                    |    2 +-
 block/Makefile.objs        |    2 +-
 block/nvme.c               |   20 +-
 block/ocssd.c              |  690 ++++++++++
 hw/block/Makefile.objs     |    2 +-
 hw/block/nvme.c            | 1405 -------------------
 hw/block/nvme.h            |   92 --
 hw/block/nvme/nvme.c       | 2485 +++++++++++++++++++++++++++++++++
 hw/block/nvme/ocssd.c      | 2647 ++++++++++++++++++++++++++++++++++++
 hw/block/nvme/ocssd.h      |  140 ++
 hw/block/nvme/trace-events |  136 ++
 hw/block/trace-events      |   91 --
 include/block/block_int.h  |    3 +
 include/block/nvme.h       |  152 ++-
 include/block/ocssd.h      |  231 ++++
 include/hw/block/nvme.h    |  233 ++++
 include/hw/pci/pci_ids.h   |    2 +
 qapi/block-core.json       |   47 +-
 20 files changed, 6774 insertions(+), 1621 deletions(-)
 create mode 100644 block/ocssd.c
 delete mode 100644 hw/block/nvme.c
 delete mode 100644 hw/block/nvme.h
 create mode 100644 hw/block/nvme/nvme.c
 create mode 100644 hw/block/nvme/ocssd.c
 create mode 100644 hw/block/nvme/ocssd.h
 create mode 100644 hw/block/nvme/trace-events
 create mode 100644 include/block/ocssd.h
 create mode 100644 include/hw/block/nvme.h

--=20
2.21.0

