Return-Path: <SRS0=RqUc=6D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6EEC38A30
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 16:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59AB8206A2
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 16:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="GYIGkJcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59AB8206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQCmL-0005Xi-Hy
	for qemu-devel@archiver.kernel.org; Sun, 19 Apr 2020 12:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42018 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <963b183c516011237108a0212402affd35f0b799@lizzy.crudebyte.com>)
 id 1jQClK-0004eW-Bj
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 12:25:42 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <963b183c516011237108a0212402affd35f0b799@lizzy.crudebyte.com>)
 id 1jQClI-0004iF-NI
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 12:25:42 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:42551)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <963b183c516011237108a0212402affd35f0b799@lizzy.crudebyte.com>)
 id 1jQClI-0002jQ-4Z
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 12:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=eYztrXsCwoNP0PnfT2BUob2I77YvZJ6AlFR38A8XUGo=; b=GYIGk
 JcpsKmiZmY9gbOC4e7J6N0b55uELTXVGcSwNUWATHRg1wVsuB+OUghJRWtH/TgE+hOJ+Mo8yRoFhc
 2xQf2e6sfWcfwttnNVcJxo4i0PM7h5kN/aFscGo2amk5MbMBEgX1uHtpVwXKXX7fdcLrPjK97nsnK
 tzTJMI9Zgo6nOckhfV7byt7AOgyUPD/ahpgSOO/xw5eCSHUsPHrudY2AdQvsSzi5b23DQ85eBpg5/
 AQaMi+fbTHn1PGl+thaCwCnP7wfGIgV7yTq9oSwXxYh20e722aWBAC8/YnKnyiLv4EBXREeSEC1bo
 eG6GQmdjtjujvY6T3rm1ulyZFhATg==;
Message-Id: <cover.1587309014.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 19 Apr 2020 17:10:14 +0200
Subject: [PATCH v6 0/5] 9pfs: readdir optimization
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=963b183c516011237108a0212402affd35f0b799@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs1p.gnu.org: Linux 3.11 and newer
X-Received-From: 91.194.90.13
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As previously mentioned, I was investigating performance issues with 9pfs.
Raw file read/write of 9pfs is actually quite good, provided that client
picked a reasonable high msize (maximum message size). I would recommend
to log a warning on 9p server side if a client attached with a small msize
that would cause performance issues for that reason.

However there are other aspects where 9pfs currently performs suboptimally,
especially readdir handling of 9pfs is extremely slow, a simple readdir
request of a guest typically blocks for several hundred milliseconds or
even several seconds, no matter how powerful the underlying hardware is.
The reason for this performance issue: latency.
Currently 9pfs is heavily dispatching a T_readdir request numerous times
between main I/O thread and a background I/O thread back and forth; in fact
it is actually hopping between threads even multiple times for every single
directory entry during T_readdir request handling which leads in total to
huge latencies for a single T_readdir request.

This patch series aims to address this severe performance issue of 9pfs
T_readdir request handling. The actual performance optimization is patch 4.

v5->v6:

  * Rebased to tag: v5.0.0-rc3 (SHA-1 20038cd7).

  * Dropped patch 2 ("9pfs readdir: rename max_count -> maxsize").

Message-ID of previous version (v5):
  cover.1585258105.git.qemu_oss@crudebyte.com

Message-ID of version with performance benchmark (v4):
  cover.1579567019.git.qemu_oss@crudebyte.com

Christian Schoenebeck (5):
  tests/virtio-9p: added split readdir tests
  9pfs: make v9fs_readdir_response_size() public
  9pfs: add new function v9fs_co_readdir_many()
  9pfs: T_readdir latency optimization
  9pfs: clarify latency of v9fs_co_run_in_worker()

 hw/9pfs/9p.c                 | 130 ++++++++++++-------------
 hw/9pfs/9p.h                 |  23 +++++
 hw/9pfs/codir.c              | 181 ++++++++++++++++++++++++++++++++---
 hw/9pfs/coth.h               |  15 ++-
 tests/qtest/virtio-9p-test.c | 108 +++++++++++++++++++++
 5 files changed, 377 insertions(+), 80 deletions(-)

-- 
2.20.1


