Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AEAC433F7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:05:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33CF8204EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rhj4Q5Pd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33CF8204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0RAj-0007bx-Cm
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 11:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0R9Q-000645-VO
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:04:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39647
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0R9N-0006rw-Fk
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595948656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ScCYqy8uUK5pB2EjTcqRd0Gbvh0tlrN14HtimrH+b6E=;
 b=Rhj4Q5Pds/vF7h2juFFE8pSKe+yxHjJaLLu8uKaYlhtwu0Dy74zGa7rao0mTfWdkVs837z
 fqHD0T03ISaKydkN/sZEJDqIE7y/j1Gx6SXIR7oQYUpsars+pylxqXRpJfElTx5yH3EzFI
 YBDTer+1SSHF8GMmcxC5UxATnjx5J6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-JweMDda8PWKfRoE1XkgQvg-1; Tue, 28 Jul 2020 11:04:11 -0400
X-MC-Unique: JweMDda8PWKfRoE1XkgQvg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88BBA8DD242
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 15:04:10 +0000 (UTC)
Received: from blue.redhat.com (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F58C1992D
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 15:04:09 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] nbd patches for -rc2, 2020-07-28
Date: Tue, 28 Jul 2020 10:03:58 -0500
Message-Id: <20200728150408.291299-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:31:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 1b242c3b1ec7c6011901b4f3b4b0876e31746afb:

  Merge remote-tracking branch 'remotes/mcayland/tags/qemu-openbios-20200727' into staging (2020-07-28 13:46:31 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2020-07-28

for you to fetch changes up to 12c75e20a269ac917f4a76936d7142264e522233:

  block/nbd: nbd_co_reconnect_loop(): don't sleep if drained (2020-07-28 09:54:43 -0500)

Sorry this is down to the wire, Nir's patches were a pretty recent
discovery, but still counts as a bug fix worthy of having in -rc2.

----------------------------------------------------------------
nbd patches for 2020-07-28

- fix NBD handling of trim/zero requests larger than 2G
- allow no-op resizes on NBD (in turn fixing qemu-img convert -c into NBD)
- several deadlock fixes when using NBD reconnect

----------------------------------------------------------------
Eric Blake (1):
      nbd: Fix large trim/zero requests

Nir Soffer (4):
      block: nbd: Fix convert qcow2 compressed to nbd
      iotests: Make qemu_nbd_popen() a contextmanager
      iotests: Add more qemu_img helpers
      iotests: Test convert to qcow2 compressed to NBD

Vladimir Sementsov-Ogievskiy (4):
      block/nbd: split nbd_establish_connection out of nbd_client_connect
      block/nbd: allow drain during reconnect attempt
      block/nbd: on shutdown terminate connection attempt
      block/nbd: nbd_co_reconnect_loop(): don't sleep if drained

 block/nbd.c                   | 126 ++++++++++++++++++++++++++++++-----------
 nbd/server.c                  |  28 ++++++++--
 qemu-io-cmds.c                |   2 +-
 block/trace-events            |   4 +-
 tests/qemu-iotests/264        |  72 +++++++++---------------
 tests/qemu-iotests/264.out    |   2 +
 tests/qemu-iotests/302        | 127 ++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/302.out    |  31 +++++++++++
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |  34 ++++++++++-
 10 files changed, 340 insertions(+), 87 deletions(-)
 create mode 100755 tests/qemu-iotests/302
 create mode 100644 tests/qemu-iotests/302.out

-- 
2.27.0


