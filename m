Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F11C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 20:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44F022086D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 20:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Lu9VNHgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F022086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgExP-0006du-DR
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 16:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44645)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <fea3c051eb7ac3e2c5cbccb89d279a84d9b2c91d@lizzy.crudebyte.com>)
 id 1hgErE-0002ji-Ff
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 16:49:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fea3c051eb7ac3e2c5cbccb89d279a84d9b2c91d@lizzy.crudebyte.com>)
 id 1hgEr6-0004j1-OG
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 16:49:28 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:47113)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <fea3c051eb7ac3e2c5cbccb89d279a84d9b2c91d@lizzy.crudebyte.com>)
 id 1hgEqx-0003yc-SE
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 16:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Subject:Date:Cc:To:From:Message-Id:Sender:
 Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Btj2NNaVSNMjsXpEYNmXQm1oG+b8mCN5x+DYgs/ykg8=; b=Lu9VNHgW8pnZM1Pp4lh6bbUxpI
 Lz3xtabwT3LD6BefeFiPGgtNSSvXtjuFEYK0TXw2j/UAyficiMfPwyf5gwvObbh835tuK/AyB9qkg
 G2aX00F7cpsvbHm+vA53MKTLCw+5yKFHy8K1aIFoa1fBadq1QWJ3slYfkXs+FQHQNMHZdwKiV0mib
 Nh5fZymZguY/9AMSuAkBDfORjmK6Df3Iel9kyPbGb58uhqvWayFqllrU95ud0IRtrhvFNSIvSqcnc
 Oku3r8ExX53c1WW6wlKTvNlEpL0BNBqkOONx19n2UF+kD5E7OcXIw7ATe668s/P6xgEyOzWTk7bAd
 5wEKxjqg==;
Message-Id: <cover.1561575449.git.qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 20:57:29 +0200
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.194.90.13
Subject: [Qemu-devel] [PATCH v4 0/5] 9p: Fix file ID collisions
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
From: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>, Greg Kurz <groug@kaod.org>, Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is v4 of a proposed patch set for fixing file ID collisions with 9pfs.

v3->v4:

  * Rebased to latest git master head.

  * Splitted Antonios' patch set to its original 4 individual patches.
    (was merged previously as only 1 patch).

  * Addressed discussed issues directly on Antonios' patches
    (was a separate patch before).

  * Added virtfs command line option "remap_inodes": Unless this option
    is not enabled, no inode remapping is performed at all, the user
    just gets an error message when trying to use more than 1 device
    per export.

  * Dropped persistency feature of QIDs beyond reboots.

  * Dropped disputed "vii" feature.

Greg, please check if I am doing anything superfluous in patch 3 regarding
the new command line parameter "remap_inodes".

Daniel, I also have a libvirt patch for this new "remap_inodes" command
line parameter, but I guess I wait for this qemu patch set to get through.

Christian Schoenebeck (5):
  9p: unsigned type for type, version, path
  9p: Treat multiple devices on one export as an error
  9p: Added virtfs option "remap_inodes"
  9p: stat_to_qid: implement slow path
  9p: Use variable length suffixes for inode remapping

 fsdev/9p-marshal.h      |   6 +-
 fsdev/file-op-9p.h      |   1 +
 fsdev/qemu-fsdev-opts.c |   7 +-
 fsdev/qemu-fsdev.c      |   6 +
 hw/9pfs/9p.c            | 448 +++++++++++++++++++++++++++++++++++++++++++++---
 hw/9pfs/9p.h            |  83 +++++++++
 hw/9pfs/trace-events    |  14 +-
 qemu-options.hx         |  17 +-
 vl.c                    |   3 +
 9 files changed, 550 insertions(+), 35 deletions(-)

-- 
2.11.0


