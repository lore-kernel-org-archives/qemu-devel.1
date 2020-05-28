Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5CCC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13DBB208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="w6hZVeYN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13DBB208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeEbC-0006wQ-4g
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 05:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jeEZv-0005KQ-Ht; Thu, 28 May 2020 05:11:55 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:59226)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jeEZs-0000oA-7d; Thu, 28 May 2020 05:11:53 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::162])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 1418B2E1543;
 Thu, 28 May 2020 12:11:44 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net
 (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
 by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 VLR9zmobtR-BfFComZL; Thu, 28 May 2020 12:11:44 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1590657104; bh=1sdL2pQoq1gXfh8bV1HEloqUtNTxvA0Ifh85xlKG40k=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=w6hZVeYNcH4SyS+OzHb6dz+W67lHtAC+yKljPlpZJwa2YjAe1nxkrhYxoVHGwRsBF
 LKiCnT3kWpTSTU8bGwVJYX8qIdzpq+NV3Nn2SomL4+ubXTY4ma66zO1DZEB/R8o/Ua
 c0F73NvIKYPuvxhu7bwVkgk8ivoxRuXdWBmpJA60=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:8219::1:5])
 by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 YZCPcdHrH5-BfWqHRZg; Thu, 28 May 2020 12:11:41 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Dima Stepanov <dimastep@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/2] vhost-user reconnect issues during vhost initialization
Date: Thu, 28 May 2020 12:11:17 +0300
Message-Id: <cover.1590396396.git.dimastep@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:0:1619::183;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mst@redhat.com,
 jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, fengli@smartx.com,
 yc-core@yandex-team.ru, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 raphael.norwitz@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes is v4:
- Update the "[PATCH v4 2/2] vhost-user-blk: delay
  vhost_user_blk_disconnect" patch based on Raphael's comment and Li
  Feng previous commit:
  https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg02255.html
  Don't change the vhost_user_blk_device_realize() function. Update the
  comment for the CHR_EVENT_CLOSED event.

Changes in v3:
- "[PATCH v3 1/2] char-socket: return -1 in case of disconnect during
  tcp_chr_write" made a small cleanup suggested by Li Feng. Added
  "Reviewed-by: Marc-André Lureau"
- Rework the vhost_user_blk_disconnect call logic to delay it.
- Remove the migration patch from the patch set, since we are still
  having some discussion about it. In general the current idea is good,
  but need to make some more investigation of how to handle reconnect
  during migration properly

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

Dima Stepanov (2):
  char-socket: return -1 in case of disconnect during tcp_chr_write
  vhost-user-blk: delay vhost_user_blk_disconnect

 chardev/char-socket.c     |  7 ++++---
 hw/block/vhost-user-blk.c | 38 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 4 deletions(-)

-- 
2.7.4


