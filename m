Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A00DC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:16:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F30CE206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F30CE206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrGt-0006p3-9f
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41071)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hsrBE-0005rz-25
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hsrBC-0001me-5j
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:10:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58728)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hsrB8-0001l6-Hv
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:10:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 90075308FBA9;
 Wed, 31 Jul 2019 16:10:13 +0000 (UTC)
Received: from localhost (ovpn-117-27.ams2.redhat.com [10.36.117.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80D8260852;
 Wed, 31 Jul 2019 16:10:07 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: virtio-fs@redhat.com,
	qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:10:01 +0100
Message-Id: <20190731161006.9447-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 31 Jul 2019 16:10:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/5] virtiofsd: multithreading preparation part
 2
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

This is the second in a multi-series effort to make virtiofsd thread-safe=
.  The
main goal in this installment is to make lo_inode thread-safe, but other =
fixes
are included too.  Like any good author I will build suspense and won't t=
ell
where this story is headed, but I still have some more code auditing to d=
o
before we can declare virtiofsd thread-safe :).

Based-on: <20190726091103.23503-1-stefanha@redhat.com> ("virtiofsd: multi=
threading preparation")

Stefan Hajnoczi (5):
  virtiofsd: take lo->mutex around lo_add_fd_mapping()
  virtiofsd: take lo->mutex around lo_add_dirp_mapping()
  virtiofsd: rename inode->refcount to inode->nlookup
  virtiofsd: fix inode nlookup leaks
  virtiofsd: introduce inode refcount to prevent use-after-free

 contrib/virtiofsd/passthrough_ll.c | 262 +++++++++++++++++++++++------
 1 file changed, 214 insertions(+), 48 deletions(-)

--=20
2.21.0


