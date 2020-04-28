Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B751C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:30:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1243D20731
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jEMzc5eU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1243D20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTWsK-0002T1-3T
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 16:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTWr1-0000ES-3L
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTWr0-0005jy-1R
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:29:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28683
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTWqz-0005cw-Km
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588105756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=niUh6pDjnt/ZhUFv5SnT005XAMcd72M7x1f4y+VuyHY=;
 b=jEMzc5eUXHwaXParlovmIIqqsovq2zkxjZzW9UL/vD/JNXaEeiyhoje2TwRl4djMTREYWg
 XGrHZ5Jh8MVIYpGGG/3t4vf9TqvW3vOVtqaqjoCr9U9IfaVi+L4wd81wYErxjPAEET0GXN
 uMsUtUaw+QZBWA4QUHP7CNO0mOavTIE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-lth9VeOEMvGfosIjjxvv-g-1; Tue, 28 Apr 2020 16:29:07 -0400
X-MC-Unique: lth9VeOEMvGfosIjjxvv-g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE7EC53;
 Tue, 28 Apr 2020 20:29:06 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1BEE65C1D4;
 Tue, 28 Apr 2020 20:29:05 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/9] More truncate improvements
Date: Tue, 28 Apr 2020 15:28:56 -0500
Message-Id: <20200428202905.770727-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:15:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: <20200424125448.63318-1-kwolf@redhat.com>
[PATCH v7 00/10] block: Fix resize (extending) of short overlays

After reviewing Kevin's work, I questioned if we had a redundancy with
bdrv_has_zero_init_truncate.  It turns out we do, and this is the result.

Patch 1 has been previously posted [1] and reviewed, the rest is new.
I did not address Neils' comment that modern gluster also always
0-initializes [2], as I am not set up to verify it (my changes to the
other drivers are semantic no-ops, so I don't feel as bad about
posting them with less rigourous testing).

[1] https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg08070.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg04266.html

Eric Blake (9):
  gluster: Drop useless has_zero_init callback
  file-win32: Support BDRV_REQ_ZERO_WRITE for truncate
  nfs: Support BDRV_REQ_ZERO_WRITE for truncate
  rbd: Support BDRV_REQ_ZERO_WRITE for truncate
  sheepdog: Support BDRV_REQ_ZERO_WRITE for truncate
  ssh: Support BDRV_REQ_ZERO_WRITE for truncate
  parallels: Rework truncation logic
  vhdx: Rework truncation logic
  block: Drop unused .bdrv_has_zero_init_truncate

 include/block/block.h     |  1 -
 include/block/block_int.h |  7 ---
 block.c                   | 21 ---------
 block/file-posix.c        |  1 -
 block/file-win32.c        |  4 +-
 block/gluster.c           | 14 ------
 block/nfs.c               |  4 +-
 block/parallels.c         | 23 ++++++----
 block/qcow2.c             |  1 -
 block/qed.c               |  1 -
 block/raw-format.c        |  6 ---
 block/rbd.c               |  4 +-
 block/sheepdog.c          |  4 +-
 block/ssh.c               |  5 ++-
 block/vhdx.c              | 89 ++++++++++++++++++++++-----------------
 15 files changed, 80 insertions(+), 105 deletions(-)

--=20
2.26.2


