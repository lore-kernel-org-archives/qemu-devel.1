Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BC3CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:01:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C7FD2084C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9zKWFIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7FD2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMVR9-0003tJ-Gv
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iMVOl-0002F6-0m
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iMVOj-0003b9-Fg
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:58:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27478
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iMVOj-0003av-C1
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571655529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7cBNVOKZJmQsyh/mjpJ98sFmElIR99SNuhmANipUhdA=;
 b=L9zKWFIUWHFAB32GlG7h4Q9rUidYK/2JT7OfG8EhCVbP6pLvaWmZXTCGsttOdFhknBQIMT
 +Ugugm0jsZDPTjx04BVfdz+8VZ4W7XsJ+Gw5n4XSBhMZ4jN2BEN/kVVaBT9gdvp76KZcZ3
 QMEOiYpWLNm8IsrVhximhm6ZpxczzSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-eLhU_7KQMGifBGmaBLZhEA-1; Mon, 21 Oct 2019 06:58:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECF81100551E;
 Mon, 21 Oct 2019 10:58:43 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-232.ams2.redhat.com
 [10.36.117.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02B8B6060D;
 Mon, 21 Oct 2019 10:58:34 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com,
 stefanha@redhat.com
Subject: [PATCH 00/30] virtiofs daemon (base)
Date: Mon, 21 Oct 2019 11:58:02 +0100
Message-Id: <20191021105832.36574-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: eLhU_7KQMGifBGmaBLZhEA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: piaojun@huawei.com, eguan@linux.alibaba.com, vgoyal@Redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  This is the 1st set for the virtiofsd - a daemon
that implements the user space side of virtiofs.

  The kernel and qemu device parts recently went in,
so the daemon is the only thing missing to have a working
set.

  This set is the absolute minimal base set of patches;
it's not yet safe to use (from security or correctness);

I'll follow up with ~3 more series in the next few days
with:

    a) Security patches that add sandboxing and checking
       compared with normal fuse - that makes it safe.
    b) Performance improvements including threading
    c) Other fixes, including correctness.

but, this is a good start and gets things rolling.

The set pulls in a big chunk of the upstream libfuse library
(unmodified so that it's easy to check it really is upstream),
chops all the stuff out we don't need and then adds the
new transport we need.

For new files I've formatted the code according to qemu
standards; for files that are from upstream libfuse
I've kept with their standards for ease of future updating.

We can't just link with libfuse, since we have to make ABI incompatible
changes for the new transport.

Running this daemon is typically done with:

   ./virtiofsd -o vhost_user_socket=3D/path/socket -o source=3D/path/to/fs

connected to a qemu that's then started with:
   -chardev socket,id=3Dchar0,path=3D/path/socket -device vhost-user-fs-pci=
,queue-size=3D1024,chardev=3Dchar0,tag=3Dmyfs

and then in the guest mount with:
   mount -t virtiofs myfs /mnt

Our development branch is: https://gitlab.com/virtio-fs/qemu/tree/virtio-fs=
-dev

Dave


Dr. David Alan Gilbert (22):
  virtiofsd: Pull in upstream headers
  virtiofsd: Pull in kernel's fuse.h
  virtiofsd: Add auxiliary .c's
  virtiofsd: Add fuse_lowlevel.c
  virtiofsd: Add passthrough_ll
  virtiofsd: Trim down imported files
  virtiofsd: Fix fuse_daemonize ignored return values
  virtiofsd: Fix common header and define for QEMU builds
  virtiofsd: fuse: Make iov_length usable outside fuse_lowlevel.c
  virtiofsd: Add options for virtio
  virtiofsd: Open vhost connection instead of mounting
  virtiofsd: Start wiring up vhost-user
  virtiofsd: Add main virtio loop
  virtiofsd: get/set features callbacks
  virtiofsd: Start queue threads
  virtiofsd: Poll kick_fd for queue
  virtiofsd: Start reading commands from queue
  virtiofsd: Send replies to messages
  virtiofsd: Keep track of replies
  virtiofsd: Add Makefile wiring for virtiofsd contrib
  virtiofsd: Fast path for virtio read
  virtiofs: Add maintainers entry

Stefan Hajnoczi (7):
  virtiofsd: remove mountpoint dummy argument
  virtiofsd: remove unused notify reply support
  virtiofsd: add -o source=3DPATH to help output
  virtiofsd: add --fd=3DFDNUM fd passing option
  virtiofsd: make -f (foreground) the default
  virtiofsd: add vhost-user.json file
  virtiofsd: add --print-capabilities option

Vivek Goyal (1):
  virtiofsd: Make fsync work even if only inode is passed in

 .gitignore                                  |    1 +
 MAINTAINERS                                 |    8 +
 Makefile                                    |    9 +
 Makefile.objs                               |    1 +
 contrib/virtiofsd/50-qemu-virtiofsd.json.in |    5 +
 contrib/virtiofsd/Makefile.objs             |   10 +
 contrib/virtiofsd/buffer.c                  |  318 +++
 contrib/virtiofsd/fuse.h                    | 1268 ++++++++++
 contrib/virtiofsd/fuse_common.h             |  823 +++++++
 contrib/virtiofsd/fuse_i.h                  |  131 ++
 contrib/virtiofsd/fuse_kernel.h             |  858 +++++++
 contrib/virtiofsd/fuse_log.c                |   40 +
 contrib/virtiofsd/fuse_log.h                |   82 +
 contrib/virtiofsd/fuse_loop_mt.c            |   54 +
 contrib/virtiofsd/fuse_lowlevel.c           | 2302 +++++++++++++++++++
 contrib/virtiofsd/fuse_lowlevel.h           | 2024 ++++++++++++++++
 contrib/virtiofsd/fuse_misc.h               |   59 +
 contrib/virtiofsd/fuse_opt.c                |  422 ++++
 contrib/virtiofsd/fuse_opt.h                |  271 +++
 contrib/virtiofsd/fuse_signals.c            |   90 +
 contrib/virtiofsd/fuse_virtio.c             |  717 ++++++
 contrib/virtiofsd/fuse_virtio.h             |   33 +
 contrib/virtiofsd/helper.c                  |  300 +++
 contrib/virtiofsd/passthrough_helpers.h     |   76 +
 contrib/virtiofsd/passthrough_ll.c          | 1341 +++++++++++
 docs/interop/vhost-user.json                |    4 +-
 26 files changed, 11246 insertions(+), 1 deletion(-)
 create mode 100644 contrib/virtiofsd/50-qemu-virtiofsd.json.in
 create mode 100644 contrib/virtiofsd/Makefile.objs
 create mode 100644 contrib/virtiofsd/buffer.c
 create mode 100644 contrib/virtiofsd/fuse.h
 create mode 100644 contrib/virtiofsd/fuse_common.h
 create mode 100644 contrib/virtiofsd/fuse_i.h
 create mode 100644 contrib/virtiofsd/fuse_kernel.h
 create mode 100644 contrib/virtiofsd/fuse_log.c
 create mode 100644 contrib/virtiofsd/fuse_log.h
 create mode 100644 contrib/virtiofsd/fuse_loop_mt.c
 create mode 100644 contrib/virtiofsd/fuse_lowlevel.c
 create mode 100644 contrib/virtiofsd/fuse_lowlevel.h
 create mode 100644 contrib/virtiofsd/fuse_misc.h
 create mode 100644 contrib/virtiofsd/fuse_opt.c
 create mode 100644 contrib/virtiofsd/fuse_opt.h
 create mode 100644 contrib/virtiofsd/fuse_signals.c
 create mode 100644 contrib/virtiofsd/fuse_virtio.c
 create mode 100644 contrib/virtiofsd/fuse_virtio.h
 create mode 100644 contrib/virtiofsd/helper.c
 create mode 100644 contrib/virtiofsd/passthrough_helpers.h
 create mode 100644 contrib/virtiofsd/passthrough_ll.c

--=20
2.23.0


