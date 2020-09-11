Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D7DC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:41:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2764B2078B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="I84DR4y8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2764B2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGecE-0007Ey-0T
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 04:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kGebQ-0005mB-Sm; Fri, 11 Sep 2020 04:40:16 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:45868)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kGebM-00029m-6d; Fri, 11 Sep 2020 04:40:14 -0400
Received: from sas1-ec30c78b6c5b.qloud-c.yandex.net
 (sas1-ec30c78b6c5b.qloud-c.yandex.net
 [IPv6:2a02:6b8:c14:2704:0:640:ec30:c78b])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 62B1D2E14DD;
 Fri, 11 Sep 2020 11:40:07 +0300 (MSK)
Received: from sas2-32987e004045.qloud-c.yandex.net
 (sas2-32987e004045.qloud-c.yandex.net [2a02:6b8:c08:b889:0:640:3298:7e00])
 by sas1-ec30c78b6c5b.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 tbd42YlPJN-e2vi9dMb; Fri, 11 Sep 2020 11:40:07 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1599813607; bh=/1IkPW8SgKZi0C7XPMMhMNC+CPgYH6AncZedQ2SzGzg=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=I84DR4y8b8dBsz7kDEIUAi/rDuUN4KDm3VMS8tdvcMymEeZRRwR5vJ2cJO1T/8Y7Y
 m6pwbglNWJ2IgK9dseZGq9hEot9FZUyYmU2gAAXpHSoK8feh8JXKVydmjPxt3mCrVe
 Iha7dX589FYINrcEkXXk9Pnv4LEEQNyCtB6hc7lI=
Authentication-Results: sas1-ec30c78b6c5b.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:7216::1:a])
 by sas2-32987e004045.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 v35icu4tRa-e2lWlHXo; Fri, 11 Sep 2020 11:40:02 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Dima Stepanov <dimastep@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/7] vhost-user-blk: fix the migration issue and enhance
 qtests
Date: Fri, 11 Sep 2020 11:39:42 +0300
Message-Id: <cover.1599813294.git.dimastep@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
Received-SPF: pass client-ip=5.45.199.163;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 04:40:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, lvivier@redhat.com, thuth@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, stefanha@gmail.com, jasowang@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, fengli@smartx.com,
 yc-core@yandex-team.ru, pbonzini@redhat.com, raphael.norwitz@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v4 -> v5:
  - vhost: check queue state in the vhost_dev_set_log routine
    tests/qtest/vhost-user-test: prepare the tests for adding new
    dev class
    tests/qtest/vhost-user-test: add support for the
    vhost-user-blk device
    tests/qtest/vhost-user-test: add migrate_reconnect test
    Reviewed-by: Raphael Norwitz
  - Update qtest, by merging vhost-user-blk "if" case with the
    virtio-blk case.

v3 -> v4:
  - vhost: recheck dev state in the vhost_migration_log routine
    Reviewed-by: Raphael Norwitz
  - vhost: check queue state in the vhost_dev_set_log routine
    Use "continue" instead of "break" to handle non-initialized
    virtqueue case.

v2 -> v3:
  - update commit message for the 
    "vhost: recheck dev state in the vhost_migration_log routine" commit
  - rename "started" field of the VhostUserBlk structure to
    "started_vu", so there will be no confustion with the VHOST started
    field
  - update vhost-user-test.c to always initialize nq local variable
    (spotted by patchew)

v1 -> v2:
  - add comments to connected/started fields in the header file
  - move the "s->started" logic from the vhost_user_blk_disconnect
    routine to the vhost_user_blk_stop routine

Reference e-mail threads:
  - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg01509.html
  - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg05241.html

If vhost-user daemon is used as a backend for the vhost device, then we
should consider a possibility of disconnect at any moment. There was a general
question here: should we consider it as an error or okay state for the vhost-user
devices during migration process?
I think the disconnect event for the vhost-user devices should not break the
migration process, because:
  - the device will be in the stopped state, so it will not be changed
    during migration
  - if reconnect will be made the migration log will be reinitialized as
    part of reconnect/init process:
    #0  vhost_log_global_start (listener=0x563989cf7be0)
    at hw/virtio/vhost.c:920
    #1  0x000056398603d8bc in listener_add_address_space (listener=0x563989cf7be0,
        as=0x563986ea4340 <address_space_memory>)
    at softmmu/memory.c:2664
    #2  0x000056398603dd30 in memory_listener_register (listener=0x563989cf7be0,
        as=0x563986ea4340 <address_space_memory>)
    at softmmu/memory.c:2740
    #3  0x0000563985fd6956 in vhost_dev_init (hdev=0x563989cf7bd8,
        opaque=0x563989cf7e30, backend_type=VHOST_BACKEND_TYPE_USER,
        busyloop_timeout=0)
    at hw/virtio/vhost.c:1385
    #4  0x0000563985f7d0b8 in vhost_user_blk_connect (dev=0x563989cf7990)
    at hw/block/vhost-user-blk.c:315
    #5  0x0000563985f7d3f6 in vhost_user_blk_event (opaque=0x563989cf7990,
        event=CHR_EVENT_OPENED)
    at hw/block/vhost-user-blk.c:379
The first patch in the patchset fixes this issue by setting vhost device to the
stopped state in the disconnect handler and check it the vhost_migration_log()
routine before returning from the function.
qtest framework was updated to test vhost-user-blk functionality. The
vhost-user-blk/vhost-user-blk-tests/migrate_reconnect test was added to reproduce
the original issue found.

Dima Stepanov (7):
  vhost: recheck dev state in the vhost_migration_log routine
  vhost: check queue state in the vhost_dev_set_log routine
  tests/qtest/vhost-user-test: prepare the tests for adding new dev
    class
  tests/qtest/libqos/virtio-blk: add support for vhost-user-blk
  tests/qtest/vhost-user-test: add support for the vhost-user-blk device
  tests/qtest/vhost-user-test: add migrate_reconnect test
  tests/qtest/vhost-user-test: enable the reconnect tests

 hw/block/vhost-user-blk.c          |  19 ++-
 hw/virtio/vhost.c                  |  39 ++++-
 include/hw/virtio/vhost-user-blk.h |  10 ++
 tests/qtest/libqos/virtio-blk.c    |  14 +-
 tests/qtest/vhost-user-test.c      | 290 +++++++++++++++++++++++++++++++------
 5 files changed, 322 insertions(+), 50 deletions(-)

-- 
2.7.4


