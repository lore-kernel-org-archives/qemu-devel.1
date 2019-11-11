Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824DBC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 13:02:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13E3821872
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 13:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E3821872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU9KS-0003br-DD
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 08:02:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.kiszka@siemens.com>) id 1iU9G1-0001qU-UR
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 07:57:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@siemens.com>) id 1iU9Fx-0006gn-S4
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 07:57:23 -0500
Received: from david.siemens.de ([192.35.17.14]:37365)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
 id 1iU9Fx-0006dd-IL
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 07:57:21 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by david.siemens.de (8.15.2/8.15.2) with ESMTPS id xABCvCZT020373
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Nov 2019 13:57:12 +0100
Received: from md1f2u6c.ad001.siemens.net ([139.25.68.37])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id xABCvCBD010919;
 Mon, 11 Nov 2019 13:57:12 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [RFC][PATCH 0/3] IVSHMEM version 2 device for QEMU
Date: Mon, 11 Nov 2019 13:57:09 +0100
Message-Id: <cover.1573477032.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.16.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 192.35.17.14
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
Cc: liang yan <lyan@suse.com>, Jailhouse <jailhouse-dev@googlegroups.com>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Hannes Reinecke <hare@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To get the ball rolling after my presentation of the topic at KVM Forum
[1] and many fruitful discussions around it, this is a first concrete
code series. As discussed, I'm starting with the IVSHMEM implementation
of a QEMU device and server. It's RFC because, besides specification and
implementation details, there will still be some decisions needed about
how to integrate the new version best into the existing code bases.

If you want to play with this, the basic setup of the shared memory
device is described in patch 1 and 3. UIO driver and also the
virtio-ivshmem prototype can be found at

    http://git.kiszka.org/?p=linux.git;a=shortlog;h=refs/heads/queues/ivshmem2

Accessing the device via UIO is trivial enough. If you want to use it
for virtio, this is additionally to the description in patch 3 needed on
the virtio console backend side:

    modprobe uio_ivshmem
    echo "1af4 1110 1af4 1100 ffc003 ffffff" > /sys/bus/pci/drivers/uio_ivshmem/new_id
    linux/tools/virtio/virtio-ivshmem-console /dev/uio0

And for virtio block:

    echo "1af4 1110 1af4 1100 ffc002 ffffff" > /sys/bus/pci/drivers/uio_ivshmem/new_id
    linux/tools/virtio/virtio-ivshmem-console /dev/uio0 /path/to/disk.img

After that, you can start the QEMU frontend instance with the
virtio-ivshmem driver installed which can use the new /dev/hvc* or
/dev/vda* as usual.

Any feedback welcome!

Jan

PS: Let me know if I missed someone potentially interested in this topic
on CC - or if you would like to be dropped from the list.

PPS: The Jailhouse queues are currently out of sync /wrt minor details
of this one, primarily the device ID. Will update them when the general
direction is clear.

[1] https://kvmforum2019.sched.com/event/TmxI

Jan Kiszka (3):
  hw/misc: Add implementation of ivshmem revision 2 device
  docs/specs: Add specification of ivshmem device revision 2
  contrib: Add server for ivshmem revision 2

 Makefile                                  |    3 +
 Makefile.objs                             |    1 +
 configure                                 |    1 +
 contrib/ivshmem2-server/Makefile.objs     |    1 +
 contrib/ivshmem2-server/ivshmem2-server.c |  462 ++++++++++++
 contrib/ivshmem2-server/ivshmem2-server.h |  158 +++++
 contrib/ivshmem2-server/main.c            |  313 +++++++++
 docs/specs/ivshmem-2-device-spec.md       |  333 +++++++++
 hw/misc/Makefile.objs                     |    2 +-
 hw/misc/ivshmem2.c                        | 1091 +++++++++++++++++++++++++++++
 include/hw/misc/ivshmem2.h                |   48 ++
 11 files changed, 2412 insertions(+), 1 deletion(-)
 create mode 100644 contrib/ivshmem2-server/Makefile.objs
 create mode 100644 contrib/ivshmem2-server/ivshmem2-server.c
 create mode 100644 contrib/ivshmem2-server/ivshmem2-server.h
 create mode 100644 contrib/ivshmem2-server/main.c
 create mode 100644 docs/specs/ivshmem-2-device-spec.md
 create mode 100644 hw/misc/ivshmem2.c
 create mode 100644 include/hw/misc/ivshmem2.h

-- 
2.16.4


