Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCCCC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:18:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD97F20665
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD97F20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAGBb-0006D9-6p
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 12:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iAFuc-00007g-Gv
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iAFua-0004uq-Nx
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:01:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33058)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iAFua-0004uW-Ic
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:01:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BA629A3D382
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 16:01:03 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-53.ams2.redhat.com
 [10.36.116.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7CEF6012E;
 Tue, 17 Sep 2019 16:00:59 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	cohuck@redhat.com,
	mst@redhat.com
Date: Tue, 17 Sep 2019 17:00:54 +0100
Message-Id: <20190917160057.11847-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Tue, 17 Sep 2019 16:01:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 0/3] Add virtio-fs (experimental)
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
Cc: mszeredi@redhat.com, vgoyal@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  This set of patches adds the core of the virtio-fs support to qemu;
it's marked experimental since the kernel patch isn't in yet; but
it's nearly there;  the spec has passed the voting stage, and
the kernel changes are queued in fuse-next.

  A future set of patches will add the optional DAX mapping support.

  The actual qemu change is pretty minimal, since it's really only
a virtio device with some queues.

Some links:
  Mailing list: https://www.redhat.com/mailman/listinfo/virtio-fs
  Dev tree: Including filesystem daemon: https://gitlab.com/virtio-fs/qem=
u
  kernel:
         dev world:
            https://gitlab.com/virtio-fs/linux
         fuse next:
           https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.=
git/log/?h=3Dfor-next
  virtio spec changes:
         https://lists.oasis-open.org/archives/virtio-dev/201908/msg00112=
.html

v3
  Split the kernel header update out
    The contents correspond to the fuse-next world+a patch Stefan just
    sent to make that use the newer 'num_request_queues' name

  Update copyright year,
  Remove the assert in vuf_handle_output
    the virtio core code sometimes calls it during cleanup if the
    daemon dies first
  (I've not changed the comment about guest_notifier_mask/virtio-pci
   since that's copied in a bunch of virtio code going back ~5 years)

Dr. David Alan Gilbert (3):
  virtio: Add virito_fs linux headers
  virtio: add vhost-user-fs base device
  virtio: add vhost-user-fs-pci device

 configure                                   |  13 +
 hw/virtio/Makefile.objs                     |   2 +
 hw/virtio/vhost-user-fs-pci.c               |  85 ++++++
 hw/virtio/vhost-user-fs.c                   | 299 ++++++++++++++++++++
 include/hw/virtio/vhost-user-fs.h           |  45 +++
 include/standard-headers/linux/virtio_fs.h  |  41 +++
 include/standard-headers/linux/virtio_ids.h |   1 +
 7 files changed, 486 insertions(+)
 create mode 100644 hw/virtio/vhost-user-fs-pci.c
 create mode 100644 hw/virtio/vhost-user-fs.c
 create mode 100644 include/hw/virtio/vhost-user-fs.h
 create mode 100644 include/standard-headers/linux/virtio_fs.h

--=20
2.21.0


