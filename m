Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39BBC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:39:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A139524655
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hkwxOfI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A139524655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdEh-0004oq-Sr
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jBdDl-0003Ek-9K
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jBdDj-0008Mi-5s
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:38:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26548
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jBdDh-0008IU-Dl
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583840323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0d8J1/ecefCprcwCY1oMPNv2arNy6a4FaX9eVciN3ek=;
 b=hkwxOfI1ASgHRnyFxw2P9LokPkAJf0I3c9/m9Z45lb0OX8Ho00I1L9mthUJyXQQP8f3HsW
 9UvBo4R/LJdTXI3PVixki6mZEsfBMo65sMLZ1wI176Z2mcRdtkIIuGAIzdIgg9qnnjxZ0a
 T0Z3WoXxdp2SAAy3DfmI69390urUkwg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-HHprnQGhOYapvuXljMQ_JA-1; Tue, 10 Mar 2020 07:38:39 -0400
X-MC-Unique: HHprnQGhOYapvuXljMQ_JA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDE12184C806;
 Tue, 10 Mar 2020 11:38:38 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B844887B2F;
 Tue, 10 Mar 2020 11:38:37 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 0/7] block: Relax restrictions for blockdev-snapshot
Date: Tue, 10 Mar 2020 12:38:24 +0100
Message-Id: <20200310113831.27293-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series allows libvirt to fix a regression that its switch from
drive-mirror to blockdev-mirror caused: It currently requires that the
backing chain of the target image is already available when the mirror
operation is started.

In reality, the backing chain may only be copied while the operation is
in progress, so the backing file of the target image needs to stay
disabled until the operation completes and should be attached only at
that point. Without this series, we don't have a supported API to attach
the backing file at that later point.

v2:
- Added a fix and test case for iothreads [Peter]
- Added a blockdev-snapshot feature flag to indicate that it's usable
  for attaching a backing chain to an overlay that is already in
  write-only use (e.g. as a mirror target) [Peter]

Kevin Wolf (6):
  block: Make bdrv_get_cumulative_perm() public
  block: Relax restrictions for blockdev-snapshot
  iotests: Fix run_job() with use_log=3DFalse
  iotests: Test mirror with temporarily disabled target backing file
  block: Fix cross-AioContext blockdev-snapshot
  iotests: Add iothread cases to 155

Peter Krempa (1):
  qapi: Add '@allow-write-only-overlay' feature for 'blockdev-snapshot'

 qapi/block-core.json          |  9 +++-
 include/block/block_int.h     |  3 ++
 block.c                       |  7 ++-
 blockdev.c                    | 30 ++++--------
 tests/qemu-iotests/iotests.py |  5 +-
 tests/qemu-iotests/085.out    |  4 +-
 tests/qemu-iotests/155        | 88 +++++++++++++++++++++++++++++------
 tests/qemu-iotests/155.out    |  4 +-
 8 files changed, 104 insertions(+), 46 deletions(-)

--=20
2.20.1


