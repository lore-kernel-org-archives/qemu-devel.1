Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78397C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:58:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F08E720674
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hn2rVmO2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08E720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb6VE-0000oP-TS
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 13:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jb6UR-00088a-6y
 for qemu-devel@nongnu.org; Tue, 19 May 2020 13:57:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52540
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jb6UQ-0003YI-6B
 for qemu-devel@nongnu.org; Tue, 19 May 2020 13:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589911037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sLazx+ez6Tem4n61+s/H+BTJfYFqKriO0sYUsQ4WyrM=;
 b=Hn2rVmO2FfbDR/uJNdxohu2CM40AeKOX+77Pg/iMIbjBtmaYejJeQSzxR2zI8LiW8LxTsf
 nGFlSYJJ5/ZoIg08gR+Jv4w7AxP3EfIVduQYuVkCj9ic7dfkmv0KhZcPEJMMSw8GS/1AiS
 VBn/f/sxUc7vQ3Pqbfi5LkAoISvfDys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-Ulu0qxelMVqpMOpnK5LC4g-1; Tue, 19 May 2020 13:57:13 -0400
X-MC-Unique: Ulu0qxelMVqpMOpnK5LC4g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A66F18FE868
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 17:57:12 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A5125C1BB
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 17:57:11 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 0/7] bitmaps patches for 2020-05-18
Date: Tue, 19 May 2020 12:57:00 -0500
Message-Id: <20200519175707.815782-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 09:19:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

The following changes since commit f2465433b43fb87766d79f42191607dac4aed5b4:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2020-05-19 13:42:58 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-bitmaps-2020-05-18-v3

for you to fetch changes up to 3b51ab4bf0f49a01cc2db7b954e0669e081719b5:

  qemu-img: Add bitmap sub-command (2020-05-19 12:53:22 -0500)

v3: actually commit the cvtnum changes that I thought were in v2
v2: resolve semantic conflict with commit 43d589b0, only sending changed patch

----------------------------------------------------------------
bitmaps patches for 2020-05-18

- update bitmaps maintainers
- add 'qemu-img bitmap' subcommand

----------------------------------------------------------------
Eric Blake (7):
      bitmaps: Update maintainer
      docs: Sort sections on qemu-img subcommand parameters
      qemu-img: Fix stale comments on doc location
      block: Make it easier to learn which BDS support bitmaps
      blockdev: Promote several bitmap functions to non-static
      blockdev: Split off basic bitmap operations for qemu-img
      qemu-img: Add bitmap sub-command

 docs/tools/qemu-img.rst         |  72 ++++++---
 Makefile.objs                   |   3 +-
 block/qcow2.h                   |   1 +
 include/block/block_int.h       |  13 ++
 include/block/dirty-bitmap.h    |   1 +
 block/dirty-bitmap.c            |   9 ++
 block/monitor/bitmap-qmp-cmds.c | 321 ++++++++++++++++++++++++++++++++++++++++
 block/qcow2-bitmap.c            |   7 +
 block/qcow2.c                   |   2 +
 blockdev.c                      | 303 +------------------------------------
 qemu-img.c                      | 250 ++++++++++++++++++++++++++++++-
 MAINTAINERS                     |   8 +-
 block/monitor/Makefile.objs     |   1 +
 qemu-img-cmds.hx                |   9 +-
 14 files changed, 671 insertions(+), 329 deletions(-)
 create mode 100644 block/monitor/bitmap-qmp-cmds.c

-- 
2.26.2


