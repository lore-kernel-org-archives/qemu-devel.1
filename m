Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890C6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:47:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC118208D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KA2/Kvpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC118208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRwJ1-0003T0-Rw
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 07:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kRwG3-0000a5-7S
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 07:44:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57314)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kRwFt-0008A8-Up
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 07:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602503080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JHtZ4Z9DuZqTmFhlT6C83QJ6Wl1sQQupTf3YDzznZzs=;
 b=KA2/Kvpouz7HcnzrSnTB8YDemf6X49a3Nx4vFRYS8WVkJaHTIm9UtsBDzvCQdWsxARNiMP
 cwe9EI744osqGDDEvEeRMsMr6O5JK7oHBUrsSPc7H3fDti6bRQ/eGvtQmT01m122B0MIAO
 HScEogajJTS5620Sa2qT+Do2MxUHEWY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-dAuyUTtMMW-R5K11c9LNUg-1; Mon, 12 Oct 2020 07:44:36 -0400
X-MC-Unique: dAuyUTtMMW-R5K11c9LNUg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B8651084C80;
 Mon, 12 Oct 2020 11:44:35 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-113-244.ams2.redhat.com
 [10.36.113.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5213819C78;
 Mon, 12 Oct 2020 11:44:28 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, zhengchuan@huawei.com,
 stefanha@redhat.com, peterx@redhat.com
Subject: [PULL 0/6] migration queue
Date: Mon, 12 Oct 2020 12:44:19 +0100
Message-Id: <20201012114425.104765-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The following changes since commit 2387df497b4b4bcf754eb7398edca82889e2ef54:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2020-10-10' into staging (2020-10-12 11:29:42 +0100)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20201012a

for you to fetch changes up to b1a859cfb04db1d2b80dd9979ce6081cb9c00d75:

  migration/dirtyrate: present dirty rate only when querying the rate has completed (2020-10-12 12:39:38 +0100)

----------------------------------------------------------------
v3 Migration+ virtiofsd pull 2020-10-12

V3
  Remove the postcopy recovery changes

Migration:
  Dirtyrate measurement API cleanup

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

Stefan Hajnoczi (1):
      virtiofsd: avoid /proc/self/fd tempdir

 docs/tools/virtiofsd.rst         |  4 ++++
 migration/dirtyrate.c            | 16 ++++++++++------
 qapi/migration.json              |  8 +++-----
 tools/virtiofsd/fuse_i.h         |  1 +
 tools/virtiofsd/fuse_lowlevel.c  |  6 ++++++
 tools/virtiofsd/fuse_virtio.c    | 21 +++++++++++++++++++--
 tools/virtiofsd/passthrough_ll.c | 38 ++++++++++++++------------------------
 7 files changed, 57 insertions(+), 37 deletions(-)


