Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7A5C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:48:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F015B20870
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="yAxcDIuZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F015B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU9Y4-0007GJ-2A
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 09:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dimastep@yandex-team.ru>) id 1jU9R8-0006Id-6G
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dimastep@yandex-team.ru>) id 1jU9Qb-0008ET-5Z
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:41:09 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:57906)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jU9N4-0001DM-PJ; Thu, 30 Apr 2020 09:36:59 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 6A2312E151A;
 Thu, 30 Apr 2020 16:36:50 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net
 (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
 by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 jykYvKPdUn-akbu44Eq; Thu, 30 Apr 2020 16:36:50 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1588253810; bh=inPO6os+e9vX7M3fH2q01EN7eUk39AKi07Ywo3fdZ/M=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=yAxcDIuZWgZ8bGete6J2gTUGb995x3RFSDVh5nl/Yk0G85eHUmnL3XQiuGvhm/9T5
 1epbJCTgQfRYd9Nzcq88HSO/cTiludSxOllVtZUrLc5wIICU27Fha+Ilmwlqv0LUaz
 7tBLH0a3sTERf4izVD4BSrx2QyWXOJHJPuag3LOw=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:7108::1:9])
 by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 tZ29y7t6r8-akWKcOOw; Thu, 30 Apr 2020 16:36:46 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Dima Stepanov <dimastep@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] vhost-user reconnect issues during vhost initialization
Date: Thu, 30 Apr 2020 16:36:15 +0300
Message-Id: <cover.1588252861.git.dimastep@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
Received-SPF: pass client-ip=77.88.29.217;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 09:36:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 77.88.29.217
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
Cc: fam@euphon.net, kwolf@redhat.com, yc-core@yandex-team.ru,
 qemu-block@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, arei.gonglei@huawei.com,
 fengli@smartx.com, stefanha@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, raphael.norwitz@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes in v2:
- Add to CC list: Li Feng <fengli@smartx.com>, since it looks like that we
are working on pretty similar issues
- Remove [RFC PATCH v1 1/7] contrib/vhost-user-blk: add option to simulate
disconnect on init. Going to send this functionality in the separate
patch, with the LIBVHOST_USER_DEBUG rework. Need to think how to reuse
this option and silence the messages first.
- Remove [RFC PATCH v1 3/7] char-socket: initialize reconnect timer only if
close is emitted. This will be handled in the separate patchset:
[PATCH 3/4] char-socket: avoid double call tcp_chr_free_connection by Li
Feng

v1:

During vhost-user reconnect functionality we hit several issues, if
vhost-user-blk daemon is "crashed" or made disconnect during vhost
initialization. The general scenario is as follows:
  - vhost start routine is called
  - vhost write failed due to SIGPIPE
  - this call the disconnect routine and vhost_dev_cleanup routine
    which set to 0 all the field of the vhost_dev structure
  - return back to vhost start routine with the error
  - on the fail path vhost start routine tries to rollback the changes
    by using vhost_dev struct fields which were already reset
  - sometimes this leads to SIGSEGV, sometimes to SIGABRT
Before revising the vhost-user initialization code, we suggest adding
the sanity checks to be aware of the possible disconnect event and that
the vhost_dev structure can be in "uninitialized" state.

The vhost-user-blk daemon is updated with the additional
"--simulate-disconnect-stage=CASENUM" argument to simulate disconnect during
VHOST device initialization. For instance:
  1. $ ./vhost-user-blk -s ./vhost.sock -b test-img.raw --simulate-disconnect-stage=1
     This command will simulate disconnect in the SET_VRING_CALL handler.
     In this case the vhost device in QEMU is not set the started field to
     true.
  2. $ ./vhost-user-blk -s ./vhost.sock -b test-img.raw --simulate-disconnect-stage=2
     This command will simulate disconnect in the SET_VRING_NUM handler.
     In this case the started field is set to true.
These two cases test different QEMU parts. Also to trigger different code paths
disconnect should be simulated in two ways:
  - before any successful initialization
  - make successful initialization once and try to simulate disconnects
Also we catch SIGABRT on the migration start if vhost-user daemon disconnected
during vhost-user set log commands communication.
*** BLURB HERE ***

Dima Stepanov (5):
  char-socket: return -1 in case of disconnect during tcp_chr_write
  vhost: introduce wrappers to set guest notifiers for virtio device
  vhost-user-blk: add mechanism to track the guest notifiers init state
  vhost: check vring address before calling unmap
  vhost: add device started check in migration set log

 backends/cryptodev-vhost.c  |  26 +++++-----
 backends/vhost-user.c       |  16 ++----
 chardev/char-socket.c       |   8 +--
 hw/block/vhost-user-blk.c   |  23 ++++-----
 hw/net/vhost_net.c          |  30 +++++++-----
 hw/scsi/vhost-scsi-common.c |  15 ++----
 hw/virtio/vhost-user-fs.c   |  17 +++----
 hw/virtio/vhost-vsock.c     |  18 +++----
 hw/virtio/vhost.c           | 115 ++++++++++++++++++++++++++++++++++++++++----
 hw/virtio/virtio.c          |  13 +++++
 include/hw/virtio/vhost.h   |   5 ++
 include/hw/virtio/virtio.h  |   1 +
 12 files changed, 195 insertions(+), 92 deletions(-)

-- 
2.7.4


