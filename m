Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E818EC55191
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 18:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFB86205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 18:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="x49Wa++E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB86205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRgnS-0002wE-Kh
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 14:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dimastep@yandex-team.ru>) id 1jRglu-00014i-EG
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 14:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dimastep@yandex-team.ru>) id 1jRglu-00043O-0I
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 14:40:26 -0400
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:46730)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jRglq-0003fs-8R; Thu, 23 Apr 2020 14:40:22 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id EC2A02E14B9;
 Thu, 23 Apr 2020 21:40:13 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net
 (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
 by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 vUYIJ9wYTp-eAJKdAF1; Thu, 23 Apr 2020 21:40:13 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1587667213; bh=ZaBwB72CLvi112lt4BeCdDiyv+131Kk2SnWC3/I46hE=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=x49Wa++ErtAPlK60Bu428nh6nvegbwRm+CnEN7J18KIMXrhKFtKoN0ERbcfMH7+Ni
 Ce/LvuXG7vyrfxONZmDyOqZyHcn8duvVH3FeXUrTQA1iC6Mg0al4hAEkkMVPAOYRYI
 AvY/23UU7rspMdaE5i0Dk6Qj5JZbhjFNUNXKtWoY=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:1313::1:e])
 by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 7hClKENKMK-eAXe7IkW; Thu, 23 Apr 2020 21:40:10 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Dima Stepanov <dimastep@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v1 0/7] vhost-user reconnect issues during vhost
 initialization
Date: Thu, 23 Apr 2020 21:39:31 +0300
Message-Id: <cover.1587667007.git.dimastep@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
Received-SPF: pass client-ip=2a02:6b8:0:1472:2741:0:8b6:217;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 14:40:14
X-ACL-Warn: Detected OS   = ???
X-Received-From: 2a02:6b8:0:1472:2741:0:8b6:217
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
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 raphael.norwitz@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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

Dima Stepanov (7):
  contrib/vhost-user-blk: add option to simulate disconnect on init
  char-socket: return -1 in case of disconnect during tcp_chr_write
  char-socket: initialize reconnect timer only if close is emitted
  vhost: introduce wrappers to set guest notifiers for virtio device
  vhost-user-blk: add mechanism to track the guest notifiers init state
  vhost: check vring address before calling unmap
  vhost: add device started check in migration set log

 backends/cryptodev-vhost.c              |  26 +++++---
 backends/vhost-user.c                   |  16 ++---
 chardev/char-socket.c                   |  18 ++---
 contrib/libvhost-user/libvhost-user.c   |  30 +++++++++
 contrib/libvhost-user/libvhost-user.h   |  13 ++++
 contrib/vhost-user-blk/vhost-user-blk.c |  14 +++-
 hw/block/vhost-user-blk.c               |  23 +++----
 hw/net/vhost_net.c                      |  30 +++++----
 hw/scsi/vhost-scsi-common.c             |  15 ++---
 hw/virtio/vhost-user-fs.c               |  17 ++---
 hw/virtio/vhost-vsock.c                 |  18 +++--
 hw/virtio/vhost.c                       | 115 +++++++++++++++++++++++++++++---
 hw/virtio/virtio.c                      |  13 ++++
 include/hw/virtio/vhost.h               |   5 ++
 include/hw/virtio/virtio.h              |   1 +
 15 files changed, 256 insertions(+), 98 deletions(-)

-- 
2.7.4


