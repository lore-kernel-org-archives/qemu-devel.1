Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D377AC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B5FE20716
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hv+0LW9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5FE20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9q2X-0006n1-RU
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 07:55:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j9py3-0008LB-Jp
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:51:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j9py2-0006HU-IC
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:51:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52735
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j9py2-0006GD-FL
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583412668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=h5/gnE67W8C23deutfFs8P6Ll7ZENyXzsLIDO1xmXxk=;
 b=hv+0LW9Bc1niHhF3Y97jLxu4MeaS8WP/fLWC3p3+GtOdkA32nyV64MCZruwH+7TC8mnS6s
 cYsjBNklq3X4ftOWsdeNI4G2jsj87LaXxvL7K+YMtSezOPftw39ESFCscrPBjI+nCAQbce
 LcAFql9EG6a+goemcBk8FK8yS+28A4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-ZFIDBw6GO_ejqx6U6N1kAw-1; Thu, 05 Mar 2020 07:51:05 -0500
X-MC-Unique: ZFIDBw6GO_ejqx6U6N1kAw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 407748017DF;
 Thu,  5 Mar 2020 12:51:04 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-210.ams2.redhat.com
 [10.36.117.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22699272A9;
 Thu,  5 Mar 2020 12:51:02 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 0/4] block: Relax restrictions for blockdev-snapshot
Date: Thu,  5 Mar 2020 13:50:56 +0100
Message-Id: <20200305125100.386-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

Kevin Wolf (4):
  block: Make bdrv_get_cumulative_perm() public
  block: Relax restrictions for blockdev-snapshot
  iotests: Fix run_job() with use_log=3DFalse
  iotests: Test mirror with temporarily disabled target backing file

 include/block/block_int.h     |  3 ++
 block.c                       |  6 ++--
 blockdev.c                    | 14 +++++----
 tests/qemu-iotests/iotests.py |  5 +++-
 tests/qemu-iotests/155        | 54 +++++++++++++++++++++++++++++++----
 tests/qemu-iotests/155.out    |  4 +--
 6 files changed, 68 insertions(+), 18 deletions(-)

--=20
2.20.1


