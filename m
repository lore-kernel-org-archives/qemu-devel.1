Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02AEC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 19:23:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D6BB20868
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 19:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6BB20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55270 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYxym-0003K3-Eq
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 15:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53714)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hYxlG-0004lg-0I
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 15:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hYxLI-0000DB-M2
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 14:42:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49238)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hYxLE-0007dT-Kb; Thu, 06 Jun 2019 14:42:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C52F6981D3;
 Thu,  6 Jun 2019 18:42:04 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-177.bos.redhat.com [10.18.17.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BECBBABF;
 Thu,  6 Jun 2019 18:42:00 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 14:41:54 -0400
Message-Id: <20190606184159.979-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 06 Jun 2019 18:42:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/5] block/dirty-bitmap: check number and size
 constraints against queued bitmaps
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 vsementsov@virtuozzo.com, aihua liang <aliang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When adding new persistent dirty bitmaps, we only check constraints
against currently stored bitmaps, and ignore the pending number and size
of any bitmaps yet to be stored.

Rework the "can_store" and "remove" interface to explicit "add" and "remo=
ve",
and begin keeping track of the queued burden when adding new bitmaps.

Reported-by: aihua liang <aliang@redhat.com>
Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1712636

John Snow (5):
  block/qcow2-bitmap: allow bitmap_list_load to return an error code
  block/dirty-bitmap: Refactor bdrv_can_store_new_bitmap
  block/dirty-bitmap: rework bdrv_remove_persistent_dirty_bitmap
  block/qcow2-bitmap: Count queued bitmaps towards nb_bitmaps
  block/qcow2-bitmap: Count queued bitmaps towards directory_size

 block/qcow2.h                |  13 ++--
 include/block/block.h        |   2 -
 include/block/block_int.h    |  11 ++-
 include/block/dirty-bitmap.h |   9 ++-
 block.c                      |  22 ------
 block/dirty-bitmap.c         |  71 +++++++++++++++---
 block/qcow2-bitmap.c         | 140 +++++++++++++++++++++--------------
 block/qcow2.c                |   2 +-
 blockdev.c                   |  34 ++++-----
 9 files changed, 179 insertions(+), 125 deletions(-)

--=20
2.20.1


