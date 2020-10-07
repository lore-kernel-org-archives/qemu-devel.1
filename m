Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69250C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B198C216C4
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MgA68b9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B198C216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQBwS-0006q1-Hm
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kQBnc-0001Cc-RG
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 11:56:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kQBna-0000F0-6O
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 11:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602086172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KkHEj8jmk45TqPAjqKynHPSqVw2rKaJ/0+EBNaN2O28=;
 b=MgA68b9nJOeTU2vGClVa7MhfIMLQ5m/0HiCBHObL6FBqXjPouyN7pslqTFigAzdxrnIU4H
 LG0kUBCmomObv++Ri+zl3lSyW11ZQfGhWixAJuoV8Qd4JbQZvgALyyGAUcbmGEhWi8pD+C
 rKrUXdiacmb+F9QIFFK//HWXEQvqAzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-cnioxLUdMgyaU832IUuiug-1; Wed, 07 Oct 2020 11:56:10 -0400
X-MC-Unique: cnioxLUdMgyaU832IUuiug-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE47318C5201;
 Wed,  7 Oct 2020 15:56:09 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-112-50.ams2.redhat.com
 [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 370BF10021AA;
 Wed,  7 Oct 2020 15:56:02 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, zhengchuan@huawei.com,
 stefanha@redhat.com, peterx@redhat.com
Subject: [PULL 00/10] migration queue
Date: Wed,  7 Oct 2020 16:55:50 +0100
Message-Id: <20201007155600.337316-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
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

The following changes since commit f2687fdb7571a444b5af3509574b659d35ddd601:

  Merge remote-tracking branch 'remotes/bonzini-gitlab/tags/for-upstream' into staging (2020-10-06 15:04:10 +0100)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20201007b

for you to fetch changes up to 1df31b8aca2aa4f83d5827d74700eeb6d711bbdf:

  migration/dirtyrate: present dirty rate only when querying the rate has completed (2020-10-07 16:49:26 +0100)

----------------------------------------------------------------
Migration and virtiofs pull 2020-07-10

Migration:
  Dirtyrate measurement API cleanup
  Postcopy recovery fixes

Virtiofsd:
  Missing qemu_init_exec_dir call
  Support for setting the group on socket creation
  Stop a gcc warning
  Avoid tempdir in sandboxing

----------------------------------------------------------------
Alex Bennée (1):
      tools/virtiofsd: add support for --socket-group

Chuan Zheng (2):
      migration/dirtyrate: record start_time and calc_time while at the measuring state
      migration/dirtyrate: present dirty rate only when querying the rate has completed

Dr. David Alan Gilbert (2):
      virtiofsd: Silence gcc warning
      virtiofsd: Call qemu_init_exec_dir

Peter Xu (4):
      migration: Pass incoming state into qemu_ufd_copy_ioctl()
      migration: Introduce migrate_send_rp_message_req_pages()
      migration: Maintain postcopy faulted addresses
      migration: Sync requested pages after postcopy recovery

Stefan Hajnoczi (1):
      virtiofsd: avoid /proc/self/fd tempdir

 docs/tools/virtiofsd.rst         |  4 +++
 migration/dirtyrate.c            | 16 ++++++-----
 migration/migration.c            | 49 ++++++++++++++++++++++++++++++++--
 migration/migration.h            | 21 ++++++++++++++-
 migration/postcopy-ram.c         | 25 +++++++++++++-----
 migration/savevm.c               | 57 ++++++++++++++++++++++++++++++++++++++++
 migration/trace-events           |  3 +++
 qapi/migration.json              |  8 +++---
 tools/virtiofsd/fuse_i.h         |  1 +
 tools/virtiofsd/fuse_lowlevel.c  |  6 +++++
 tools/virtiofsd/fuse_virtio.c    | 21 +++++++++++++--
 tools/virtiofsd/passthrough_ll.c | 38 ++++++++++-----------------
 12 files changed, 203 insertions(+), 46 deletions(-)


