Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F8AC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 14:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAB912133F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 14:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAB912133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hydJL-0008Qz-Pb
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 10:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1hydIK-0007XB-VJ
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 10:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hydIJ-0007hg-7a
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 10:33:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10226)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hydIJ-0007gw-2S
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 10:33:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B5799307D965
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 14:33:29 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-130.ams2.redhat.com
 [10.36.117.130])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A0888F6C8;
 Fri, 16 Aug 2019 14:33:23 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com
Date: Fri, 16 Aug 2019 15:33:19 +0100
Message-Id: <20190816143321.20903-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 16 Aug 2019 14:33:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/2] Add virtio-fs (experimental)
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
Cc: vgoyal@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  This pair of patches adds the core of the virtio-fs support to qemu;
it's marked experimental since the kernel patch and spec changes aren't
in yet; but they're bubbling along.

  While the spec change is still in progress; the ID number is already
reserved.

  A future set of patches will add the optional DAX mapping support.

  The actual qemu change is pretty minimal, since it's really only
a virtio device with some queues.

Some links:
  Mailing list: https://www.redhat.com/mailman/listinfo/virtio-fs
  Dev tree: Including filesystem daemon: https://gitlab.com/virtio-fs/qem=
u
  kernel: https://gitlab.com/virtio-fs/linux
  virtio spec changes: https://lists.oasis-open.org/archives/virtio-dev/2=
01908/msg00056.html

Dr. David Alan Gilbert (2):
  virtio: add vhost-user-fs base device
  virtio: add vhost-user-fs-pci device

 configure                                   |  13 +
 hw/virtio/Makefile.objs                     |   2 +
 hw/virtio/vhost-user-fs-pci.c               |  79 ++++++
 hw/virtio/vhost-user-fs.c                   | 297 ++++++++++++++++++++
 include/hw/virtio/vhost-user-fs.h           |  45 +++
 include/standard-headers/linux/virtio_fs.h  |  41 +++
 include/standard-headers/linux/virtio_ids.h |   1 +
 7 files changed, 478 insertions(+)
 create mode 100644 hw/virtio/vhost-user-fs-pci.c
 create mode 100644 hw/virtio/vhost-user-fs.c
 create mode 100644 include/hw/virtio/vhost-user-fs.h
 create mode 100644 include/standard-headers/linux/virtio_fs.h

--=20
2.21.0


