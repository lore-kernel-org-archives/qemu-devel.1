Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A10C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:09:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD631222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="brIqwJMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD631222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2hHB-0000PY-Ls
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 15:09:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j2hGI-0007II-Dy
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:08:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j2hGH-0005E8-HB
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:08:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41299
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j2hGH-0005CG-DK
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581710908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=icOhGOCwIEYC1VHqlZosDy+3TD4z2uEU+7dMvk1epO4=;
 b=brIqwJMcB810paj20VEND5I+apptd9leGJfRjaWBwRwZtNcplZCUdawhIolQbhy30LmASs
 UWd6lM9rQ+sqBDjpx2Znlir+KvVwEmiTLcl82UhBa1enJ9NOVsy8nCWeucFYxnudL5CyDr
 ZoKClo8JDr5Q+SFZE/vzb1+ikBGcyRQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-ds6L54M5M02NajGWaF6ZfA-1; Fri, 14 Feb 2020 15:08:27 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A607800D4E;
 Fri, 14 Feb 2020 20:08:26 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 557E45C1C3;
 Fri, 14 Feb 2020 20:08:23 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 0/7] commit: Expose on-error option in QMP
Date: Fri, 14 Feb 2020 21:08:05 +0100
Message-Id: <20200214200812.28180-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: ds6L54M5M02NajGWaF6ZfA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, nsoffer@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All other block jobs already provide a QMP option to control the error
handling policy. It's time to add it to commit, too.

Peter, I guess libvirt wants to expose this?

Nir, as you would probably assume, this is motivated by the recent
finding that VDSM has to preallocate the theoretical maximum for commit
operations because QEMU doesn't provide a way to reliably resize the
base image dynamically. If you ever want to improve that code, this will
enable you to do so from the QEMU side.

Kevin Wolf (7):
  qapi: Document meaning of 'ignore' BlockdevOnError for jobs
  commit: Remove unused bytes_written
  commit: Fix argument order for block_job_error_action()
  commit: Inline commit_populate()
  commit: Fix is_read for block_job_error_action()
  commit: Expose on-error option in QMP
  iotests: Test error handling policies with block-commit

 qapi/block-core.json       |   9 +-
 block/commit.c             |  37 ++---
 blockdev.c                 |   8 +-
 tests/qemu-iotests/040     | 283 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/040.out |   4 +-
 5 files changed, 309 insertions(+), 32 deletions(-)

--=20
2.20.1


