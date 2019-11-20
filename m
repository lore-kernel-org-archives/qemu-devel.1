Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD172C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 18:48:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A882B2071C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 18:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IsfSBdlT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A882B2071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXV1J-0005xh-TX
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 13:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iXUyd-00042s-Jn
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:45:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iXUyc-0005th-42
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:45:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26121
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iXUyc-0005tN-09
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574275517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=E+lkT3yJrEzXi4VA80LuhNSHp73plvDfs/AsP9W+QgI=;
 b=IsfSBdlTcJipViE7WOSz/hrMMxpC/lFClKjs6OhUrVm2aHHFUkNKLjv/6jWXzDgP/evO0Z
 3lOnXKsSr/s58199uDm2WMr7j1FPI++MrH3+UMEM3c2wX5oBswMHBbK2vH3gxuMwHe/ijc
 RLdBxWb2LsItP08OEx0cwJgr/ZpISZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-wskCd3sxPfaX4emXUE22fA-1; Wed, 20 Nov 2019 13:45:15 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC71C801E7E;
 Wed, 20 Nov 2019 18:45:14 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2A43104C52A;
 Wed, 20 Nov 2019 18:45:05 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-4.2? v2 0/6] block: Fix resize (extending) of short
 overlays
Date: Wed, 20 Nov 2019 19:44:55 +0100
Message-Id: <20191120184501.28159-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: wskCd3sxPfaX4emXUE22fA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

See patch 2 for the description of the bug fixed.

v2:
- Switched order of bs->total_sectors update and zero write [Vladimir]
- Fixed coding style [Vladimir]
- Changed the commit message to contain what was in the cover letter
- Test all preallocation modes
- Test allocation status with qemu-io 'map' [Vladimir]

Kevin Wolf (6):
  block: bdrv_co_do_pwrite_zeroes: 64 bit 'bytes' parameter
  block: truncate: Don't make backing file data visible
  iotests: Add qemu_io_log()
  iotests: Fix timeout in run_job()
  iotests: Support job-complete in run_job()
  iotests: Test committing to short backing file

 block/io.c                    |  38 +++++-
 tests/qemu-iotests/274        | 141 +++++++++++++++++++++
 tests/qemu-iotests/274.out    | 227 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |  11 +-
 5 files changed, 413 insertions(+), 5 deletions(-)
 create mode 100755 tests/qemu-iotests/274
 create mode 100644 tests/qemu-iotests/274.out

--=20
2.20.1


