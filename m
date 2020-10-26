Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9FDC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 594D722284
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3tf9uga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594D722284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX5KM-0004QN-AA
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 12:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kX5E9-000412-6x
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:20:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21051)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kX5E7-0008UE-1k
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603729204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=L6auF/o22WyR3BrczqMYaKW2V/rRIVDhIZZKeALHLVI=;
 b=P3tf9ugaYQU+Mj+RUBxc6g6ycqUI1T6qCwGWIeNI6PHIHwFyRQ2ViCZ5hobDsZbPH2rrX2
 7qSbj8c1Fi71Ol8hT9UXbksj6VEOYIPrSxns7EppBdHeKgSsKP0h1XFWZJJHnhoD+A6roz
 s7x7utsltPYco9zxc7V1xrtxaz0udjk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-pj8pG5XGPPWXPI9VTDPehg-1; Mon, 26 Oct 2020 12:20:00 -0400
X-MC-Unique: pj8pG5XGPPWXPI9VTDPehg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD38E8064B2;
 Mon, 26 Oct 2020 16:19:58 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-112-208.ams2.redhat.com
 [10.36.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A782A5D9E4;
 Mon, 26 Oct 2020 16:19:54 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, yubihong@huawei.com, peterx@redhat.com,
 peter.maydell@linaro.org
Subject: [PULL 00/16] migration queue
Date: Mon, 26 Oct 2020 16:19:36 +0000
Message-Id: <20201026161952.149188-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit a46e72710566eea0f90f9c673a0f02da0064acce:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20201026' into staging (2020-10-26 14:50:03 +0000)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20201026a

for you to fetch changes up to a47295014de56e108f359ec859d5499b851f62b8:

  migration-test: Only hide error if !QTEST_LOG (2020-10-26 16:15:04 +0000)

----------------------------------------------------------------
migration pull: 2020-10-26

Another go at Peter's postcopy fixes

Cleanups from Bihong Yu and Peter Maydell.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

----------------------------------------------------------------
Bihong Yu (9):
      migration: Do not use C99 // comments
      migration: Don't use '#' flag of printf format
      migration: Add spaces around operator
      migration: Open brace '{' following struct go on the same line
      migration: Add braces {} for if statement
      migration: Do not initialise statics and globals to 0 or NULL
      migration: Open brace '{' following function declarations go on the next line
      migration: Delete redundant spaces
      migration: using trace_ to replace DPRINTF

Peter Maydell (1):
      migration: Drop unused VMSTATE_FLOAT64 support

Peter Xu (6):
      migration: Pass incoming state into qemu_ufd_copy_ioctl()
      migration: Introduce migrate_send_rp_message_req_pages()
      migration: Maintain postcopy faulted addresses
      migration: Sync requested pages after postcopy recovery
      migration/postcopy: Release fd before going into 'postcopy-pause'
      migration-test: Only hide error if !QTEST_LOG

 include/migration/vmstate.h  | 13 ----------
 migration/block.c            | 40 ++++++++++++++---------------
 migration/migration.c        | 59 +++++++++++++++++++++++++++++++++++++-----
 migration/migration.h        | 24 ++++++++++++++---
 migration/page_cache.c       | 13 +++-------
 migration/postcopy-ram.c     | 27 +++++++++++++++-----
 migration/ram.c              | 14 +++++-----
 migration/rdma.c             |  7 ++---
 migration/savevm.c           | 61 ++++++++++++++++++++++++++++++++++++++++++--
 migration/trace-events       | 16 ++++++++++++
 migration/vmstate-types.c    | 26 -------------------
 migration/vmstate.c          | 10 ++++----
 tests/qtest/migration-test.c |  6 ++++-
 13 files changed, 213 insertions(+), 103 deletions(-)


