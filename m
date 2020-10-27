Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01068C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 05:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 675462080A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 05:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQ14HWc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675462080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXHDl-0005PP-Cj
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 01:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kXHBT-0003Zh-Ed
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:06:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57349)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kXHBP-0003Z4-S3
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603775166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OOlYm+z2mE0Lv+0ZHCi/WpOTXetJnryWsXYeZvOiXFY=;
 b=HQ14HWc2E+UCdS9pX6+xL8GYxRA3t7I5WX4zumvVUy67nw02WYGEaXr6/VGlpxVWYS/Odj
 p9SvJvjfNWWOUv0j5A2lwTFhBs9w1XRnnGrHRCYwC6EN+0UXPlX3EHM90dsp7Jrh5uDdOl
 YO4s5DewzYPigmksEzv/Q7jmOxwWTO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-Sbmz3UNEOTi1qMyTO7CJKQ-1; Tue, 27 Oct 2020 01:06:02 -0400
X-MC-Unique: Sbmz3UNEOTi1qMyTO7CJKQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C45628049D7;
 Tue, 27 Oct 2020 05:06:00 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-145.phx2.redhat.com [10.3.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0DB5D10013C4;
 Tue, 27 Oct 2020 05:05:56 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 00/11] Exposing backing-chain allocation over NBD
Date: Tue, 27 Oct 2020 00:05:45 -0500
Message-Id: <20201027050556.269064-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 armbru@redhat.com, rjones@redhat.com, vsementsov@virtuozzo.com,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v5 was here:
https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg07124.html

Also available at:
https://repo.or.cz/qemu/ericb.git/shortlog/refs/tags/nbd-alloc-depth-v6

Since v5:
- rebase to master (mostly affects 8/11) [Vladimir]
- drop v5 1/12, and replace with new v6 1/11 [Markus]
- rearrange series to complete 'bitmaps' before 'allocation-depth'
- don't alter 'nbd-server-add' [Peter]
- simplify qemu:allocation-depth to just be an integer [Vladimir]

I want at least 1-7/11 in a pull request this week for 5.2 soft
freeze, but it would also be nice to get the feature of 8-10/11 in as
well.  11/11 is less important, but a nice followup to 2/11.

(Oh, and my KVM Forum presentation this Friday uses these patches ;)

Eric Blake (11):
  block: Simplify QAPI_LIST_ADD
  qapi: Make QAPI_LIST_ADD() public
  nbd: Utilize QAPI_CLONE for type conversion
  nbd: Update qapi to support exporting multiple bitmaps
  nbd: Simplify qemu bitmap context name
  nbd: Refactor counting of metadata contexts
  nbd: Allow export of multiple bitmaps for one device
  block: Return depth level during bdrv_is_allocated_above
  nbd: Add new qemu:allocation-depth metadata context
  nbd: Add 'qemu-nbd -A' to expose allocation depth
  qapi: Use QAPI_LIST_ADD() where possible

 docs/devel/writing-qmp-commands.txt |  13 +-
 docs/interop/nbd.txt                |  23 ++-
 docs/system/deprecated.rst          |   3 +-
 docs/tools/qemu-nbd.rst             |   8 +-
 qapi/block-core.json                |   7 +-
 qapi/block-export.json              |  46 ++++--
 block/coroutines.h                  |   6 +-
 hw/net/rocker/rocker_fp.h           |   2 +-
 include/block/nbd.h                 |   8 +-
 include/qapi/util.h                 |   8 ++
 block/io.c                          |  29 +++-
 block.c                             |  14 +-
 block/commit.c                      |   2 +-
 block/gluster.c                     |  19 +--
 block/mirror.c                      |   2 +-
 block/nbd.c                         |  26 +++-
 block/stream.c                      |   2 +-
 blockdev-nbd.c                      |  19 +--
 chardev/char.c                      |  21 ++-
 hw/core/machine.c                   |   6 +-
 hw/net/rocker/rocker.c              |   8 +-
 hw/net/rocker/rocker_fp.c           |  14 +-
 hw/net/virtio-net.c                 |  21 +--
 migration/migration.c               |   7 +-
 migration/postcopy-ram.c            |   7 +-
 monitor/hmp-cmds.c                  |  11 +-
 nbd/server.c                        | 208 +++++++++++++++++++++-------
 qemu-img.c                          |   5 +-
 qemu-nbd.c                          |  30 ++--
 qga/commands-posix.c                |  13 +-
 qga/commands-win32.c                |  17 +--
 qga/commands.c                      |   6 +-
 qom/qom-qmp-cmds.c                  |  29 ++--
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
 tests/qemu-iotests/309              |  77 ++++++++++
 tests/qemu-iotests/309.out          |  22 +++
 tests/qemu-iotests/group            |   1 +
 49 files changed, 542 insertions(+), 370 deletions(-)
 create mode 100755 tests/qemu-iotests/309
 create mode 100644 tests/qemu-iotests/309.out

-- 
2.29.0


