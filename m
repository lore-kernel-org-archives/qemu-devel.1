Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13B8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 18:38:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ADF7206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 18:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFw43HYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADF7206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlcxV-0004ft-KI
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 14:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jlcwY-0003Nn-QM
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 14:37:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31717
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jlcwX-00088Q-39
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 14:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592419068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=soeJ5WOST+0w167MLAV5NBerXrg9sHfe0jleJ/NzEy4=;
 b=FFw43HYZba5kPrfgUZKR6Eu3frhtq8E0dfsL5uq7jkk3cLTM66o1old9h2sLbU3bTnnZmP
 NDQtcUReIoLxI2uk3hkir7koifnx1v/CX5c2+FLfy7jwkUHCHmqIpTJkZlkVd8iXdq6aGo
 RSJzmYJvW/TPnN6kHPVDUfIor3XuySw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-4YZnv29-NlmXBUEoPgVALw-1; Wed, 17 Jun 2020 14:37:43 -0400
X-MC-Unique: 4YZnv29-NlmXBUEoPgVALw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F406B1005513;
 Wed, 17 Jun 2020 18:37:41 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-115-47.ams2.redhat.com
 [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 366AE768B4;
 Wed, 17 Jun 2020 18:37:34 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, david@redhat.com, lvivier@redhat.com,
 maozhongyi@cmss.chinamobile.com, mreitz@redhat.com, pannengyuan@huawei.com
Subject: [PULL 00/12] migration, HMP and virtiofs queue
Date: Wed, 17 Jun 2020 19:37:21 +0100
Message-Id: <20200617183733.186168-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: stefanha@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 26bf4a29213b432eb390726c698a1915550a9cf9:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20200617-pull-request' into staging (2020-06-17 16:24:24 +0100)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20200617a

for you to fetch changes up to 7e89a1401a9674c9882948f05f4d17ea7be1c4eb:

  migration: fix multifd_send_pages() next channel (2020-06-17 17:48:39 +0100)

----------------------------------------------------------------
Migration (and HMP and virtiofs) pull 2020-06-17

Migration:
   HMP/migration and test changes from Mao Zhongyi
   multifd fix from Laurent Vivier
HMP
   qom-set partial reversion/change from David Hildenbrand
      now you need -j to pass json format, but it's regained the
      old 100M type format.
  Memory leak fix from Pan Nengyuan

Virtiofs
  fchmod seccomp fix from Max Reitz

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

----------------------------------------------------------------
David Hildenbrand (1):
      hmp: Make json format optional for qom-set

Laurent Vivier (1):
      migration: fix multifd_send_pages() next channel

Mao Zhongyi (8):
      tests/migration: mem leak fix
      tests/migration: fix unreachable path in stress test
      monitor/hmp-cmds: add units for migrate_parameters
      monitor/hmp-cmds: don't silently output when running 'migrate_set_downtime' fails
      monitor/hmp-cmds: delete redundant Error check before invoke hmp_handle_error()
      monitor/hmp-cmds: add 'goto end' to reduce duplicate code.
      monitor/hmp-cmds: improvements for the 'info migrate'
      docs/xbzrle: update 'cache miss rate' and 'encoding rate' to docs

Max Reitz (1):
      virtiofsd: Whitelist fchmod

Pan Nengyuan (1):
      qom-hmp-cmds: fix a memleak in hmp_qom_get

 docs/xbzrle.txt           |  8 +++++---
 hmp-commands.hx           |  7 ++++---
 migration/multifd.c       |  6 ++++++
 monitor/hmp-cmds.c        | 30 ++++++++++++++++--------------
 qom/qom-hmp-cmds.c        | 21 +++++++++++++++++----
 tests/migration/stress.c  | 34 +++++++---------------------------
 tools/virtiofsd/seccomp.c |  1 +
 7 files changed, 56 insertions(+), 51 deletions(-)


