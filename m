Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42FDC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 22:03:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6628521655
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 22:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="MRIZrq/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6628521655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0vBS-0001fZ-KK
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 18:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <c3946c28dd1661ea88c1e2fbf3e57fd0919600d6@lizzy.crudebyte.com>)
 id 1i0v88-0007rD-Rr
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 18:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <c3946c28dd1661ea88c1e2fbf3e57fd0919600d6@lizzy.crudebyte.com>)
 id 1i0v87-0007MW-8a
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 18:00:28 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:34631)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <c3946c28dd1661ea88c1e2fbf3e57fd0919600d6@lizzy.crudebyte.com>)
 id 1i0v7w-0006xt-0o
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 18:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Subject:Date:Cc:To:From:Message-Id:Sender:
 Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZFFxrIgdIoE9R0wF62rENBICWSd8ey/03nJuHXD+WSM=; b=MRIZrq/sCD+0jrwPPjTES+NBmt
 KvHtLfBozLMfETN0n2ypH44E594kfMlcN1ayBRCuHDJvixO6As44p6Oo83dp7h8OeFwYwKRPpbAqG
 j28QhmqlEToJNHJrKKgVV9DsfTAhC5Tmuy9gJNWgdTeqRKRuPnMrwYqgAsGwIOjhuX09+IeR6qfJ8
 p1/m5TCImfVW6ac+7VWqmks2nGwYldhRa5S8kODyhsDxo+izb8K34OdBlDW0THxEEvhzcssE5HA5q
 wY3nfjb/ph/+gtfZGy0niLiv+zSEG1hEyrOVlbVkgAEQ8SAcDlxplPpfiZWjLrumthq017WOAbCDG
 w1Vp4bFw==;
Message-Id: <cover.1566503584.git.qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 21:53:04 +0200
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.194.90.13
Subject: [Qemu-devel] [PATCH v6 0/4] 9p: Fix file ID collisions
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Greg Kurz <groug@kaod.org>, Antonios Motakis <antonios.motakis@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is v6 of a proposed patch set for fixing file ID collisions with 9pfs.

v5->v6:

  * Rebased to https://github.com/gkurz/qemu/commits/9p-next
    (SHA1 177fd3b6a8).

  * Replaced previous boolean option 'remap_inodes' by tertiary option
    'multidevs=remap|forbid|warn', where 'warn' is the new/old default
    behaviour for not breaking existing installations:
    https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg07098.html

  * Dropped incomplete fix in v9fs_do_readdir() which aimed to prevent
    exposing info outside export root with '..' entry. Postponed this
    fix for now for the reasons described:
    https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01862.html

Christian Schoenebeck (4):
  9p: Treat multiple devices on one export as an error
  9p: Added virtfs option 'multidevs=remap|forbid|warn'
  9p: stat_to_qid: implement slow path
  9p: Use variable length suffixes for inode remapping

 fsdev/file-op-9p.h      |   5 +
 fsdev/qemu-fsdev-opts.c |   7 +-
 fsdev/qemu-fsdev.c      |  11 ++
 hw/9pfs/9p.c            | 488 +++++++++++++++++++++++++++++++++++++++++++++---
 hw/9pfs/9p.h            |  51 +++++
 qemu-options.hx         |  33 +++-
 vl.c                    |   6 +-
 7 files changed, 565 insertions(+), 36 deletions(-)

-- 
2.11.0


