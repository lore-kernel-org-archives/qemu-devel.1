Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E960C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:09:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3E562083B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbK2PZbT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E562083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLmX5-0004UA-Ny
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLmVO-0002Ag-EW
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:07:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48221)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLmVJ-0004CI-So
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:07:14 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601035628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LVFMvPIwxJm0uQkWAMfr5CZDG1AjtzCGXz1lEFqfOUk=;
 b=JbK2PZbTSsym4eGGVNqbXoQ4BGQ8MHS3NWReDeM8fee5jUBNgGu61pvbATzfXUZKIATWhd
 QqfWK6orEPZB5ZQEPPz0vGArPcYMDq2rAlBMSPBgCl/Bvi58CSDbqUhfFG3dvlr9WWAuBS
 WrKRyBq76KNdjokQQZr+EF6pAbHGa2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-lHv7rMwQNI2utjS0tWz8LQ-1; Fri, 25 Sep 2020 08:07:06 -0400
X-MC-Unique: lHv7rMwQNI2utjS0tWz8LQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44E512FD09;
 Fri, 25 Sep 2020 12:07:05 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-177.ams2.redhat.com
 [10.36.114.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FA4D73692;
 Fri, 25 Sep 2020 12:06:57 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, zhengchuan@huawei.com, dovmurik@linux.vnet.ibm.com,
 hgcoin@gmail.com, zhangjiachen.jaycee@bytedance.com, lvivier@redhat.com,
 peterx@redhat.com, stefanha@redhat.com, vgoyal@redhat.com,
 jinyan12@huawei.com, ann.zhuangyanying@huawei.com
Subject: [PULL 00/26] migration and friends queue
Date: Fri, 25 Sep 2020 13:06:29 +0100
Message-Id: <20200925120655.295142-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 8c1c07929feae876202ba26f07a540c5115c18cd:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2020-09-24 18:48:45 +0100)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20200925a

for you to fetch changes up to e12a0edafeb5019aac74114b62a4703f79c5c693:

  virtiofsd: Add -o allow_direct_io|no_allow_direct_io options (2020-09-25 12:45:58 +0100)

----------------------------------------------------------------
Migration and virtiofsd pull

Chuan Zheng's Dirtyrate and TLS changes, with small fixes from Dov and
Luarent and Peter.
Small virtiofs changes from Harry, Stefan, Vivek and Jiachen.
One HMP/monitor rework from me.

----------------------------------------------------------------
Chuan Zheng (18):
      migration/dirtyrate: setup up query-dirtyrate framwork
      migration/dirtyrate: add DirtyRateStatus to denote calculation status
      migration/dirtyrate: Add RamblockDirtyInfo to store sampled page info
      migration/dirtyrate: Add dirtyrate statistics series functions
      migration/dirtyrate: move RAMBLOCK_FOREACH_MIGRATABLE into ram.h
      migration/dirtyrate: Record hash results for each sampled page
      migration/dirtyrate: Compare page hash results for recorded sampled page
      migration/dirtyrate: skip sampling ramblock with size below MIN_RAMBLOCK_SIZE
      migration/dirtyrate: Implement set_sample_page_period() and is_sample_period_valid()
      migration/dirtyrate: Implement calculate_dirtyrate() function
      migration/dirtyrate: Implement qmp_cal_dirty_rate()/qmp_get_dirty_rate() function
      migration/dirtyrate: Add trace_calls to make it easier to debug
      migration/tls: save hostname into MigrationState
      migration/tls: extract migration_tls_client_create for common-use
      migration/tls: add tls_hostname into MultiFDSendParams
      migration/tls: extract cleanup function for common-use
      migration/tls: add support for multifd tls-handshake
      migration/tls: add trace points for multifd-tls

Dov Murik (1):
      migration: Truncate state file in xen-save-devices-state

Dr. David Alan Gilbert (1):
      monitor: Use LOCK_GUARD macros

Harry G. Coin (1):
      virtiofsd: document cache=auto default

Jiachen Zhang (1):
      virtiofsd: Add -o allow_direct_io|no_allow_direct_io options

Laurent Vivier (1):
      migration: increase max-bandwidth to 128 MiB/s (1 Gib/s)

Peter Xu (2):
      migration: Properly destroy variables on incoming side
      migration: Rework migrate_send_rp_req_pages() function

Vivek Goyal (1):
      virtiofsd: Used glib "shared" thread pool

 docs/tools/virtiofsd.rst              |   1 +
 migration/channel.c                   |   1 +
 migration/dirtyrate.c                 | 426 ++++++++++++++++++++++++++++++++++
 migration/dirtyrate.h                 |  69 ++++++
 migration/meson.build                 |   2 +-
 migration/migration.c                 |  36 ++-
 migration/migration.h                 |   9 +-
 migration/multifd.c                   | 124 ++++++++--
 migration/multifd.h                   |   2 +
 migration/postcopy-ram.c              |  24 +-
 migration/ram.c                       |  11 +-
 migration/ram.h                       |  10 +
 migration/savevm.c                    |   3 +-
 migration/tls.c                       |  28 ++-
 migration/tls.h                       |   6 +
 migration/trace-events                |  12 +
 monitor/misc.c                        |  44 ++--
 qapi/migration.json                   |  67 ++++++
 tools/virtiofsd/fuse_virtio.c         |   2 +-
 tools/virtiofsd/helper.c              |   4 +
 tools/virtiofsd/passthrough_ll.c      |  20 +-
 tools/virtiofsd/passthrough_seccomp.c |   2 +
 22 files changed, 797 insertions(+), 106 deletions(-)
 create mode 100644 migration/dirtyrate.c
 create mode 100644 migration/dirtyrate.h


