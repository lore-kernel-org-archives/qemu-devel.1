Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B020AC55179
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 18:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F47920BED
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 18:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fYtYgonz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F47920BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW1xZ-0002il-0j
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 14:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kW1w3-0000tD-2e
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 14:37:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43517)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kW1vy-0001V7-L8
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 14:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603478221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TtmXdJZofvyTEiGuHu+im7J0Fiu+INRV0BZQE0VaXAI=;
 b=fYtYgonzncGscG21jGAGFl3YIZ/p+5AWsUWr5wL56/QJuRxalVYYddEl721uy8/2Ogdqo7
 jPbW/94juJYImhuityJNjBqj6/S168NrnkGRoZd7bhIeYB0hBxf6FTiMdhXak4KNQCaIp4
 VC8g47SV7ZdHk5M9sUYu0lSN5Fhblnc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-fhA5dsH1MPKC40RPaglPcQ-1; Fri, 23 Oct 2020 14:36:57 -0400
X-MC-Unique: fhA5dsH1MPKC40RPaglPcQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5111610866B0;
 Fri, 23 Oct 2020 18:36:56 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-7.phx2.redhat.com [10.3.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6FC860BFA;
 Fri, 23 Oct 2020 18:36:52 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 00/12] Exposing backing-chain allocation over NBD
Date: Fri, 23 Oct 2020 13:36:40 -0500
Message-Id: <20201023183652.478921-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, stefanha@redhat.com,
 qemu-block@nongnu.org, rjones@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v4 was here:
https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg02708.html

Since then:
- rebase to master
- patches 1, 2, and 12 are new based on Vladimir's observation of QAPI_LIST_ADD
- patches 10-11 are new based on prior discussion on exposing actual
depth in addition to a tri-state encoding
- patch 3 has a nasty bug fixed that was causing iotest failures
- patch 6 updated to take advantage of patch 2
- other minor tweaks based on review comments

001/12:[down] 'qapi: Move GenericList to qapi/util.h'
002/12:[down] 'qapi: Make QAPI_LIST_ADD() public'
003/12:[0002] [FC] 'nbd: Utilize QAPI_CLONE for type conversion'
004/12:[0010] [FC] 'nbd: Add new qemu:allocation-depth metadata context'
005/12:[----] [--] 'nbd: Add 'qemu-nbd -A' to expose allocation depth'
006/12:[0014] [FC] 'nbd: Update qapi to support exporting multiple bitmaps'
007/12:[----] [--] 'nbd: Simplify qemu bitmap context name'
008/12:[----] [--] 'nbd: Refactor counting of metadata contexts'
009/12:[0017] [FC] 'nbd: Allow export of multiple bitmaps for one device'
010/12:[down] 'block: Return depth level during bdrv_is_allocated_above'
011/12:[down] 'nbd: Expose actual depth in qemu:allocation-depth'
012/12:[down] 'qapi: Use QAPI_LIST_ADD() where possible'

Eric Blake (12):
  qapi: Move GenericList to qapi/util.h
  qapi: Make QAPI_LIST_ADD() public
  nbd: Utilize QAPI_CLONE for type conversion
  nbd: Add new qemu:allocation-depth metadata context
  nbd: Add 'qemu-nbd -A' to expose allocation depth
  nbd: Update qapi to support exporting multiple bitmaps
  nbd: Simplify qemu bitmap context name
  nbd: Refactor counting of metadata contexts
  nbd: Allow export of multiple bitmaps for one device
  block: Return depth level during bdrv_is_allocated_above
  nbd: Expose actual depth in qemu:allocation-depth
  qapi: Use QAPI_LIST_ADD() where possible

 docs/devel/writing-qmp-commands.txt |  13 +-
 docs/interop/nbd.txt                |  31 +++-
 docs/system/deprecated.rst          |   4 +-
 docs/tools/qemu-nbd.rst             |   8 +-
 qapi/block-core.json                |   7 +-
 qapi/block-export.json              |  22 ++-
 include/qapi/visitor.h              |   9 +-
 hw/net/rocker/rocker_fp.h           |   2 +-
 include/block/nbd.h                 |  14 +-
 include/qapi/util.h                 |  16 ++
 block/io.c                          |  11 +-
 block.c                             |  15 +-
 block/commit.c                      |   2 +-
 block/gluster.c                     |  19 +--
 block/mirror.c                      |   2 +-
 block/stream.c                      |   2 +-
 blockdev-nbd.c                      |  28 ++--
 chardev/char.c                      |  21 ++-
 hw/core/machine.c                   |   6 +-
 hw/net/rocker/rocker.c              |   8 +-
 hw/net/rocker/rocker_fp.c           |  14 +-
 hw/net/virtio-net.c                 |  21 +--
 migration/migration.c               |   7 +-
 migration/postcopy-ram.c            |   7 +-
 monitor/hmp-cmds.c                  |  11 +-
 nbd/server.c                        | 222 ++++++++++++++++++++++------
 qemu-img.c                          |   5 +-
 qemu-nbd.c                          |  30 ++--
 qga/commands-posix.c                |  13 +-
 qga/commands-win32.c                |  17 +--
 qga/commands.c                      |   6 +-
 qom/qom-qmp-cmds.c                  |  29 +---
 target/arm/helper.c                 |   6 +-
 target/arm/monitor.c                |  13 +-
 target/i386/cpu.c                   |   6 +-
 target/mips/helper.c                |   6 +-
 target/s390x/cpu_models.c           |  12 +-
 tests/test-clone-visitor.c          |   7 +-
 tests/test-qobject-output-visitor.c |  42 +++---
 tests/test-visitor-serialization.c  |   5 +-
 trace/qmp.c                         |  22 ++-
 ui/vnc.c                            |  21 +--
 util/qemu-config.c                  |  14 +-
 target/ppc/translate_init.c.inc     |  12 +-
 tests/qemu-iotests/291              |   6 +-
 tests/qemu-iotests/309              |  73 +++++++++
 tests/qemu-iotests/309.out          |  22 +++
 tests/qemu-iotests/group            |   1 +
 48 files changed, 529 insertions(+), 361 deletions(-)
 create mode 100755 tests/qemu-iotests/309
 create mode 100644 tests/qemu-iotests/309.out

-- 
2.29.0


