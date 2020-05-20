Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C30BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 15:55:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E718B20671
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 15:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="l7IeiH0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E718B20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbR4K-0002hi-2j
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 11:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jbR2c-0007kz-LS; Wed, 20 May 2020 11:53:58 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:50106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jbR2Y-0001GE-Jw; Wed, 20 May 2020 11:53:56 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::162])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id B5F842E137B;
 Wed, 20 May 2020 18:53:48 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net
 (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
 by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 tQypq4BnLA-rjTO2s0l; Wed, 20 May 2020 18:53:48 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1589990028; bh=+m0IyyEEuSXRB2V4Z5jxzLnq/GEgvmB9lUsOdbywHWY=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=l7IeiH0D3UNZL1XUqnVz2zd4e2oH7swAcdZetfVz49ozt27Y+PFeZf8bTqU6zekvW
 wE35t7N5RMapurmsrhcRVt4wySPNNU1SBZ687eUtxgaOJP7a8OVfCGGFItEr0pX69j
 HEJ19zKjKc0NrqROEioAcfj3+wiBW1qx4fllwBwA=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:1221::1:11])
 by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 wLIWnjIOwO-rjXeB3hM; Wed, 20 May 2020 18:53:45 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Dima Stepanov <dimastep@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] vhost-user reconnect issues during vhost initialization
Date: Wed, 20 May 2020 18:53:11 +0300
Message-Id: <cover.1589989075.git.dimastep@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.45.199.163;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 11:53:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_PASS=-0.001,
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
 hw/block/vhost-user-blk.c | 49 +++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 47 insertions(+), 9 deletions(-)

-- 
2.7.4


