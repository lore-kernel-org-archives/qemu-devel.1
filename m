Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AC0C47255
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:05:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4382C21974
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eal1/p/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4382C21974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX7NM-0001yR-5c
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 14:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jX7Ln-0000D4-En
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:03:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42063
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jX7Lk-0007J5-Gl
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588961029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EScge7zxkj4dBUBAwXNDX8fjUPshhKKboImtNdvR30I=;
 b=eal1/p/uaKeo2K0+Zdcx9uDLHr2KMJm0FMhiADcz1obxIaGwmXi92q/gNmvDW0+H/TImlB
 2vcHEoSfB7rWIAGQgafsJVBOLONrFqdiAHkDU6/U3Rok791/dhsLeq3zPt2o3D7bdGtCQt
 Hrc5e28CCd4vVtSPmo+itOtiocyK2RI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-Nwej7LbfObaRCknw8hMVvA-1; Fri, 08 May 2020 14:03:42 -0400
X-MC-Unique: Nwej7LbfObaRCknw8hMVvA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5120C107ACCA;
 Fri,  8 May 2020 18:03:41 +0000 (UTC)
Received: from blue.redhat.com (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C710E60FC2;
 Fri,  8 May 2020 18:03:40 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/9] qemu-img: Add convert --bitmaps
Date: Fri,  8 May 2020 13:03:31 -0500
Message-Id: <20200508180340.675712-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:25:09
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2 was here, to see the original cover letter:
https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg03464.html

Since then:
- patch 2 was previously posted in isolation but fits well in this series
- patch 3 is new
- patch 4 and 5 were split from v2:2/6 [Max]
- new filename chosen in patch 5 is saner [Kevin]
- patch 6 allows list of operations on one bitmap name [Max]
- patch 7 exposes 0 when measuring v3 image without bitmaps [Max]
- patch 7 and 9 iotests beefed up [Max]
- patch 8 had enough rebase churn that I dropped R-b
- compilation passes on mingw [patchew]

001/9:[----] [--] 'docs: Sort sections on qemu-img subcommand parameters'
002/9:[down] 'qemu-img: Fix stale comments on doc location'
003/9:[down] 'block: Make it easier to learn which BDS support bitmaps'
004/9:[down] 'blockdev: Promote several bitmap functions to non-static'
005/9:[0076] [FC] 'blockdev: Split off basic bitmap operations for qemu-img'
006/9:[0199] [FC] 'qemu-img: Add bitmap sub-command'
007/9:[0078] [FC] 'qcow2: Expose bitmaps' size during measure'
008/9:[0017] [FC] 'qemu-img: Add convert --bitmaps option'
009/9:[0033] [FC] 'iotests: Add test 291 to for qemu-img bitmap coverage'

Series can also be downloaded at:
https://repo.or.cz/qemu/ericb.git/shortlog/refs/tags/qemu-img-bitmaps-v3

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

 docs/tools/qemu-img.rst          |  77 ++++---
 Makefile.objs                    |   3 +-
 qapi/block-core.json             |  15 +-
 block/qcow2.h                    |   1 +
 include/block/block_int.h        |  13 ++
 include/block/dirty-bitmap.h     |   1 +
 block/crypto.c                   |   2 +-
 block/dirty-bitmap.c             |   9 +
 block/monitor/bitmap-qmp-cmds.c  | 323 +++++++++++++++++++++++++++++
 block/qcow2-bitmap.c             |   7 +
 block/qcow2.c                    |  38 +++-
 block/raw-format.c               |   2 +-
 blockdev.c                       | 303 +--------------------------
 qemu-img.c                       | 340 ++++++++++++++++++++++++++++++-
 MAINTAINERS                      |   1 +
 block/monitor/Makefile.objs      |   1 +
 qemu-img-cmds.hx                 |  13 +-
 tests/qemu-iotests/178.out.qcow2 |  16 ++
 tests/qemu-iotests/190           |  43 +++-
 tests/qemu-iotests/190.out       |  23 ++-
 tests/qemu-iotests/291           | 112 ++++++++++
 tests/qemu-iotests/291.out       |  78 +++++++
 tests/qemu-iotests/group         |   1 +
 23 files changed, 1077 insertions(+), 345 deletions(-)
 create mode 100644 block/monitor/bitmap-qmp-cmds.c
 create mode 100755 tests/qemu-iotests/291
 create mode 100644 tests/qemu-iotests/291.out

-- 
2.26.2


