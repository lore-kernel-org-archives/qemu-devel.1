Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0451CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 21:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF93C2075A
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 21:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5ebNAL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF93C2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je3kn-0000Br-Tm
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 17:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1je3jw-0007Ud-IX
 for qemu-devel@nongnu.org; Wed, 27 May 2020 17:37:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30835)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1je3jv-0002k2-6t
 for qemu-devel@nongnu.org; Wed, 27 May 2020 17:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590615449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mGDlDuaiN8/MQI5SmVztOLdkd4OuvoPWCZOnfhDToMw=;
 b=Q5ebNAL+LtkV9sXDtLNUqf3ZbXAn4YLvBNaIaqim0LFptNjP5GClwEQojPnmc962zkHik5
 F3u3p9+N5pcKXhCqCJ5NZfjIdNxtLeyHTTzqBD8a+ETZn7Qf2s8RBmOmRfOSQJybfxK1Fp
 6SduSOhqGyDeQw3tBH4m5NSStBofs/k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-emxsr9u-O3K3wgbKjzDRQQ-1; Wed, 27 May 2020 17:37:13 -0400
X-MC-Unique: emxsr9u-O3K3wgbKjzDRQQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED2D380183C
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 21:37:12 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BBBB25C1B0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 21:37:12 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/11] bitmaps patches for 2020-05-26
Date: Wed, 27 May 2020 16:36:57 -0500
Message-Id: <20200527213708.1783644-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:45:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

The following changes since commit 06539ebc76b8625587aa78d646a9d8d5fddf84f3:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/mips-hw-next-20200526' into staging (2020-05-26 20:25:06 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-bitmaps-2020-05-26-v2

for you to fetch changes up to 958796e47d3af10ece329294a7bb41d5853667db:

  iotests: Add test 291 to for qemu-img bitmap coverage (2020-05-27 16:19:59 -0500)

v2: fix iotest 190 to not be as sensitive to different sparseness of
qcow2 file on various filesystems, such as FreeBSD (sending only the
changed patch)

----------------------------------------------------------------
bitmaps patches for 2020-05-26

- fix non-blockdev migration of bitmaps when mirror job is in use
- add bitmap sizing to 'qemu-img measure'
- add 'qemu-img convert --bitmaps'

----------------------------------------------------------------
Eric Blake (5):
      iotests: Fix test 178
      qcow2: Expose bitmaps' size during measure
      qemu-img: Factor out code for merging bitmaps
      qemu-img: Add convert --bitmaps option
      iotests: Add test 291 to for qemu-img bitmap coverage

Vladimir Sementsov-Ogievskiy (6):
      migration: refactor init_dirty_bitmap_migration
      block/dirty-bitmap: add bdrv_has_named_bitmaps helper
      migration: fix bitmaps pre-blockdev migration with mirror job
      iotests: 194: test also migration of dirty bitmap
      migration: add_bitmaps_to_list: check disk name once
      migration: forbid bitmap migration by generated node-name

 docs/tools/qemu-img.rst          |  13 +++-
 qapi/block-core.json             |  16 +++--
 block/qcow2.h                    |   2 +
 include/block/dirty-bitmap.h     |   1 +
 block/crypto.c                   |   2 +-
 block/dirty-bitmap.c             |  13 ++++
 block/qcow2-bitmap.c             |  36 ++++++++++
 block/qcow2.c                    |  14 +++-
 block/raw-format.c               |   2 +-
 migration/block-dirty-bitmap.c   | 142 ++++++++++++++++++++++++++++-----------
 qemu-img.c                       | 107 ++++++++++++++++++++++++-----
 qemu-img-cmds.hx                 |   4 +-
 tests/qemu-iotests/178.out.qcow2 |  18 ++++-
 tests/qemu-iotests/178.out.raw   |   2 +-
 tests/qemu-iotests/190           |  47 ++++++++++++-
 tests/qemu-iotests/190.out       |  27 +++++++-
 tests/qemu-iotests/194           |  14 ++--
 tests/qemu-iotests/194.out       |   6 ++
 tests/qemu-iotests/291           | 112 ++++++++++++++++++++++++++++++
 tests/qemu-iotests/291.out       |  80 ++++++++++++++++++++++
 tests/qemu-iotests/group         |   1 +
 21 files changed, 582 insertions(+), 77 deletions(-)
 create mode 100755 tests/qemu-iotests/291
 create mode 100644 tests/qemu-iotests/291.out

-- 
2.26.2


