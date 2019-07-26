Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5069AC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 08:33:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26E5021951
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 08:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E5021951
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqvfm-0000Ek-I2
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 04:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43570)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hqvfR-0007si-Hi
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hqvfP-0001Am-EN
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:33:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39000)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hqvfP-0000yj-69
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:33:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 10FA730C34CA
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 08:33:29 +0000 (UTC)
Received: from localhost (ovpn-117-212.ams2.redhat.com [10.36.117.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDF7D87B6;
 Fri, 26 Jul 2019 08:33:23 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	virtio-fs@redhat.com
Date: Fri, 26 Jul 2019 09:33:19 +0100
Message-Id: <20190726083322.13637-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 26 Jul 2019 08:33:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/3] virtiofsd: add FUSE_INIT map_alignment
 field
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The client must know the server's alignment constraints for FUSE_SETUPMAP=
PING
and FUSE_REMOVEMAPPING.  This is necessary because mmap(2)/munmap(2) have
alignment constraints and the guest may have a different page size from t=
he
host.  The new FUSE_INIT map_alignment field communicates this informatio=
n to
the client.

Stefan Hajnoczi (3):
  virtiofsd: sync up fuse.h Linux 5.1 header
  virtiofsd: add map_alignment to fuse_kernel.h
  virtiofsd: implement FUSE_INIT map_alignment field

 contrib/virtiofsd/fuse_kernel.h   | 56 +++++++++++++++++++++----------
 contrib/virtiofsd/fuse_lowlevel.c |  8 +++++
 2 files changed, 47 insertions(+), 17 deletions(-)

--=20
2.21.0


