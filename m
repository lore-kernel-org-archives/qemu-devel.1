Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB5EC2D0FA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 01:18:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E40920675
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 01:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tx5YADr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E40920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYg2I-00032K-QV
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 21:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYg16-0000st-UI
 for qemu-devel@nongnu.org; Tue, 12 May 2020 21:17:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47719
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYg13-0004CN-Uj
 for qemu-devel@nongnu.org; Tue, 12 May 2020 21:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589332617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/k13veTM0tHTxUSYsWeEdYnrinvRm8/cUZnHmLDfk/g=;
 b=Tx5YADr2wTtivah03AYezM45CMwNCN8X8SjxeNLTWgK2l5fhK6nlBegoyKqaLDqOsCToAQ
 NzCs7ULXtiHm/Tcyl126Zd45rmvNScZcQf8Ru1xxBLl0JGLhq2jMyI0y577Lq1W9ymqBNQ
 P7WBc9A2a510Re8bXFt48XIf97wqBTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-_FPPtT7PPFuANNF0RGWzqQ-1; Tue, 12 May 2020 21:16:50 -0400
X-MC-Unique: _FPPtT7PPFuANNF0RGWzqQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83DD446B;
 Wed, 13 May 2020 01:16:49 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 145963A0;
 Wed, 13 May 2020 01:16:48 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/9] qemu-img: Add convert --bitmaps
Date: Tue, 12 May 2020 20:16:39 -0500
Message-Id: <20200513011648.166876-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 21:16:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, nsoffer@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v3 was here:
https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg02139.html
original cover letter here:
https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg03464.html

Since then:
- add R-b where appropriate
- patch 3: rename new driver hook [Max]
- patch 6: typo and grammar fix [Max]
- patch 7: add 'measure --bitmaps' convenience option [Nir]
- patch 7: more documentation, enhance test to cover more cases
- patch 8: rebase to earlier changes, ensure that both 'measure --bitmaps'
and 'convert --bitmaps' pass or fail on the same criteria

001/9:[----] [--] 'docs: Sort sections on qemu-img subcommand parameters'
002/9:[----] [--] 'qemu-img: Fix stale comments on doc location'
003/9:[0017] [FC] 'block: Make it easier to learn which BDS support bitmaps'
004/9:[----] [--] 'blockdev: Promote several bitmap functions to non-static'
005/9:[----] [--] 'blockdev: Split off basic bitmap operations for qemu-img'
006/9:[0009] [FC] 'qemu-img: Add bitmap sub-command'
007/9:[0084] [FC] 'qcow2: Expose bitmaps' size during measure'
008/9:[0008] [FC] 'qemu-img: Add convert --bitmaps option'
009/9:[----] [--] 'iotests: Add test 291 to for qemu-img bitmap coverage'

Series can also be downloaded at:
https://repo.or.cz/qemu/ericb.git/shortlog/refs/tags/qemu-img-bitmaps-v4

Eric Blake (9):
  docs: Sort sections on qemu-img subcommand parameters
  qemu-img: Fix stale comments on doc location
  block: Make it easier to learn which BDS support bitmaps
  blockdev: Promote several bitmap functions to non-static
  blockdev: Split off basic bitmap operations for qemu-img
  qemu-img: Add bitmap sub-command
  qcow2: Expose bitmaps' size during measure
  qemu-img: Add convert --bitmaps option
  iotests: Add test 291 to for qemu-img bitmap coverage

 docs/tools/qemu-img.rst          |  88 +++++---
 Makefile.objs                    |   3 +-
 qapi/block-core.json             |  15 +-
 block/qcow2.h                    |   1 +
 include/block/block_int.h        |  13 ++
 include/block/dirty-bitmap.h     |   1 +
 block/crypto.c                   |   2 +-
 block/dirty-bitmap.c             |   9 +
 block/monitor/bitmap-qmp-cmds.c  | 323 +++++++++++++++++++++++++++
 block/qcow2-bitmap.c             |   7 +
 block/qcow2.c                    |  39 +++-
 block/raw-format.c               |   2 +-
 blockdev.c                       | 303 +------------------------
 qemu-img.c                       | 366 ++++++++++++++++++++++++++++++-
 MAINTAINERS                      |   1 +
 block/monitor/Makefile.objs      |   1 +
 qemu-img-cmds.hx                 |  17 +-
 tests/qemu-iotests/178.out.qcow2 |  16 ++
 tests/qemu-iotests/190           |  57 ++++-
 tests/qemu-iotests/190.out       |  35 ++-
 tests/qemu-iotests/291           | 112 ++++++++++
 tests/qemu-iotests/291.out       |  78 +++++++
 tests/qemu-iotests/group         |   1 +
 23 files changed, 1142 insertions(+), 348 deletions(-)
 create mode 100644 block/monitor/bitmap-qmp-cmds.c
 create mode 100755 tests/qemu-iotests/291
 create mode 100644 tests/qemu-iotests/291.out

-- 
2.26.2


