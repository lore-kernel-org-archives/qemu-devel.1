Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F25CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:08:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AB3620659
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eEbXqRhQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB3620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNcqv-0006Dw-2T
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNbHD-0001K3-Qr
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNbHA-0008DJ-L1
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:27:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39483
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNbHA-0008CP-Gu
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571916451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=it4CiEy/pOuZjIPx21uT511YdwOrh9/5CQ7tB43lvCo=;
 b=eEbXqRhQ1gQRPufxKm8BC9gLvqQpUUCO8kbandnebN9ZwpYVfZEjtZItIUzAP1Wnej4zuA
 6ZosYNyQG/acBmrUdswM70vjPbaPVjz7k+OJA7EqhtrVF8VOfOnck547kjH2rL/Hl5uwlp
 RlXP3UezRcWCLrtzZSc9f6GD0PgNzBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-kPbYzkaaOz6da7i6-KOyVw-1; Thu, 24 Oct 2019 07:27:29 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F973107AD31;
 Thu, 24 Oct 2019 11:27:27 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-248.ams2.redhat.com
 [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 52C2A196B2;
 Thu, 24 Oct 2019 11:27:20 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, renzhen@linux.alibaba.com, eguan@linux.alibaba.com,
 ganesh.mahalingam@intel.com, m.mizuma@jp.fujitsu.com, mszeredi@redhat.com,
 misono.tomohiro@jp.fujitsu.com, tao.peng@linux.alibaba.com,
 piaojun@huawei.com, stefanha@redhat.com, vgoyal@redhat.com, mst@redhat.com,
 berrange@redhat.com
Subject: [PATCH 00/25] virtiofs daemon (security)
Date: Thu, 24 Oct 2019 12:26:53 +0100
Message-Id: <20191024112718.34657-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: kPbYzkaaOz6da7i6-KOyVw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  This is the 2nd set for the virtiofsd - this set sits
on top of the 'base' set recently posted.  Most of the changes
in the set are security related (with a couple more tagging
along because they were hard to separate).

  Stefan's main chunks make the daemon check the input from
the guest;  the upstream fuse code is much more trusting
about what it gets from the kernel; here the security
equation is inverted and the daemon is more trusted.
  In adition the daemon now gets sandboxing/namespacing/seccomp
limited to stop anything escaping.

  With this set virtiofsd is reasonably safe to use; we've
got some bug fixes (including some threading fixes) to send
as well though.

Dave

Dr. David Alan Gilbert (2):
  virtiofsd: Plumb fuse_bufvec through to do_write_buf
  virtiofsd: Pass write iov's all the way through

Eryu Guan (1):
  virtiofsd: print log only when priority is high enough

Miklos Szeredi (1):
  virtiofsd: passthrough_ll: add fallback for racy ops

Stefan Hajnoczi (18):
  virtiofsd: passthrough_ll: add lo_map for ino/fh indirection
  virtiofsd: passthrough_ll: add ino_map to hide lo_inode pointers
  virtiofsd: passthrough_ll: add dirp_map to hide lo_dirp pointers
  virtiofsd: passthrough_ll: add fd_map to hide file descriptors
  virtiofsd: validate path components
  virtiofsd: add fuse_mbuf_iter API
  virtiofsd: validate input buffer sizes in do_write_buf()
  virtiofsd: check input buffer size in fuse_lowlevel.c ops
  virtiofsd: prevent ".." escape in lo_do_lookup()
  virtiofsd: prevent ".." escape in lo_do_readdir()
  virtiofsd: use /proc/self/fd/ O_PATH file descriptor
  virtiofsd: sandbox mount namespace
  virtiofsd: move to an empty network namespace
  virtiofsd: move to a new pid namespace
  virtiofsd: add seccomp whitelist
  virtiofsd: set maximum RLIMIT_NOFILE limit
  virtiofsd: add security guide document
  virtiofsd: add --syslog command-line option

Vivek Goyal (3):
  virtiofsd: passthrough_ll: create new files in caller's context
  virtiofsd: Parse flag FUSE_WRITE_KILL_PRIV
  virtiofsd: Drop CAP_FSETID if client asked for it

 contrib/virtiofsd/Makefile.objs    |    7 +-
 contrib/virtiofsd/buffer.c         |   28 +
 contrib/virtiofsd/fuse_common.h    |   53 +-
 contrib/virtiofsd/fuse_i.h         |    2 +-
 contrib/virtiofsd/fuse_log.c       |    4 +
 contrib/virtiofsd/fuse_lowlevel.c  |  779 +++++++++++-----
 contrib/virtiofsd/fuse_lowlevel.h  |    2 +
 contrib/virtiofsd/fuse_virtio.c    |   72 +-
 contrib/virtiofsd/helper.c         |   11 +-
 contrib/virtiofsd/passthrough_ll.c | 1317 ++++++++++++++++++++++++----
 contrib/virtiofsd/seccomp.c        |  146 +++
 contrib/virtiofsd/seccomp.h        |   16 +
 contrib/virtiofsd/security.rst     |  108 +++
 13 files changed, 2152 insertions(+), 393 deletions(-)
 create mode 100644 contrib/virtiofsd/seccomp.c
 create mode 100644 contrib/virtiofsd/seccomp.h
 create mode 100644 contrib/virtiofsd/security.rst

--=20
2.23.0


