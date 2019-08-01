Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982B7C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 17:01:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE992064A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 17:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE992064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htESM-0003k4-Pa
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 13:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32928)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1htELM-000586-4g
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:54:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1htELK-0005DG-Pr
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:54:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43448)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1htELK-00059w-Dk
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:54:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 79D5A32FA211;
 Thu,  1 Aug 2019 16:54:16 +0000 (UTC)
Received: from localhost (ovpn-116-232.ams2.redhat.com [10.36.116.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFF60600C6;
 Thu,  1 Aug 2019 16:54:10 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: virtio-fs@redhat.com,
	qemu-devel@nongnu.org
Date: Thu,  1 Aug 2019 17:54:05 +0100
Message-Id: <20190801165409.20121-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 01 Aug 2019 16:54:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/4] virtiofsd: multithreading preparation part
 3
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
Cc: Liu Bo <bo.liu@linux.alibaba.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series introduces the virtiofsd --thread-pool-size=3DNUM and s=
ets the
default value to 64.  Each virtqueue has its own thread pool for processi=
ng
requests.  Blocking requests no longer pause virtqueue processing and I/O
performance should be greatly improved when the queue depth is greater th=
an 1.

Linux boot and pjdfstest have been tested with these patches and the defa=
ult
thread pool size of 64.

I have now concluded the thread-safety code audit.  Please let me know if=
 you
have concerns about things I missed.

Performance
-----------
Please try these patches out and share your results.

Scalability
-----------
There are several synchronization primitives that are taken by the virtqu=
eue
processing thread or the thread pool worker.  Unfortunately this is neces=
sary
to protect shared state.  It means that thread pool workers contend on or=
 at
least access thread synchronization primitives.  If anyone has suggestion=
s for
improving this situation, please discuss.

1. vu_dispatch_rwlock - libvhost-user from races between the vhost-user
   protocol thread and the virtqueue processing and thread pool worker th=
reads.

2. vq_lock - protects the virtqueue from races between the virtqueue proc=
essing
   thread and thread pool workers.

3. init_rwlock - protects FUSE_INIT/FUSE_DESTROY from races with other
   requests.

4. se->lock - protects se->list and the FUSE_INTERRUPT shared state.

Ideally we could avoid hitting all of these locks on each request.  That =
would
make the code scale better.

Future work
-----------
This series does not complete the multithreading effort yet.  Two items a=
re
still missing:
1. Multiqueue support
2. CPU affinity for virtqueue processing threads and thread pools

Stefan Hajnoczi (4):
  virtiofsd: process requests in a thread pool
  virtiofsd: prevent FUSE_INIT/FUSE_DESTROY races
  virtiofsd: fix lo_destroy() resource leaks
  virtiofsd: add --thread-pool-size=3DNUM option

 contrib/virtiofsd/fuse_i.h         |   2 +
 contrib/virtiofsd/fuse_lowlevel.c  |  25 +-
 contrib/virtiofsd/fuse_virtio.c    | 491 ++++++++++++++++-------------
 contrib/virtiofsd/passthrough_ll.c |  43 ++-
 contrib/virtiofsd/seccomp.c        |   1 +
 5 files changed, 318 insertions(+), 244 deletions(-)

--=20
2.21.0


