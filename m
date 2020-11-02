Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3453EC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 19:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9589522268
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 19:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Giojq6la"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9589522268
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZfyk-0004qD-JF
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 14:58:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kZfxF-0003ES-Bx
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 14:57:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54318)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kZfx9-0002GE-59
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 14:57:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604347032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fzycBra8mlhDh63R4ZAlgIbcsaqGA0OLwNPOh+WHyGo=;
 b=Giojq6labONjmuyjvwz45DPm/Wc+Sg8sKn0sVtjtKaLkgat+C5mSaUqk7brTWXBeAZj6YQ
 ro2daQqbFEeEy9nwK9fMT3ZJSrYAYDTObkltaDgwbKE8g/GksX1FGo1sJVXts1x9E3NFnm
 Dl0unbDMTE0svcbY/dvvVFJa0ZGzZhg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-Y5zV_siuPAa9LKh6tgxBwQ-1; Mon, 02 Nov 2020 14:57:08 -0500
X-MC-Unique: Y5zV_siuPAa9LKh6tgxBwQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 650411006CA3;
 Mon,  2 Nov 2020 19:57:07 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-142.ams2.redhat.com
 [10.36.114.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7154F1001281;
 Mon,  2 Nov 2020 19:56:59 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, peterx@redhat.com, philmd@redhat.com,
 zhangjiachen.jaycee@bytedance.com, mreitz@redhat.com
Subject: [PULL 00/12] migration queue
Date: Mon,  2 Nov 2020 19:56:45 +0000
Message-Id: <20201102195657.219501-1-dgilbert@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
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
Cc: stefanha@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit b139d11ae198aba0e009daddf7a3370ce84b2d09:

  Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20201102' into staging (2020-11-02 16:05:47 +0000)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20201102a

for you to fetch changes up to af1bb3fe7f146fafdaadb479975ca2b53b49df40:

  tests/acceptance: Add virtiofs_submounts.py (2020-11-02 19:23:48 +0000)

----------------------------------------------------------------
Migration and virtiofs fixes 2020-11-02

Fixes for postcopy migration test hang
A seccomp crash for virtiofsd on some !x86
Help message and minor CID fix

And another crack at Max's set.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      virtiofsd: Seccomp: Add 'send' for syslog

Jiachen Zhang (1):
      virtiofsd: Fix the help message of posix lock

Max Reitz (7):
      virtiofsd: Check FUSE_SUBMOUNTS
      virtiofsd: Add attr_flags to fuse_entry_param
      meson.build: Check for statx()
      virtiofsd: Add mount ID to the lo_inode key
      virtiofsd: Announce sub-mount points
      tests/acceptance/boot_linux: Accept SSH pubkey
      tests/acceptance: Add virtiofs_submounts.py

Peter Xu (2):
      migration: Unify reset of last_rb on destination node when recover
      migration: Postpone the kick of the fault thread after recover

Philippe Mathieu-Daudé (1):
      tools/virtiofsd: Check vu_init() return value (CID 1435958)

 meson.build                                        |  16 +
 migration/postcopy-ram.c                           |   2 -
 migration/savevm.c                                 |  17 +-
 tests/acceptance/boot_linux.py                     |  13 +-
 tests/acceptance/virtiofs_submounts.py             | 321 +++++++++++++++++++++
 .../virtiofs_submounts.py.data/cleanup.sh          |  46 +++
 .../virtiofs_submounts.py.data/guest-cleanup.sh    |  30 ++
 .../acceptance/virtiofs_submounts.py.data/guest.sh | 138 +++++++++
 .../acceptance/virtiofs_submounts.py.data/host.sh  | 127 ++++++++
 tools/virtiofsd/fuse_common.h                      |   7 +
 tools/virtiofsd/fuse_lowlevel.c                    |   5 +
 tools/virtiofsd/fuse_lowlevel.h                    |   5 +
 tools/virtiofsd/fuse_virtio.c                      |   7 +-
 tools/virtiofsd/helper.c                           |   3 +-
 tools/virtiofsd/passthrough_ll.c                   | 117 +++++++-
 tools/virtiofsd/passthrough_seccomp.c              |   2 +
 16 files changed, 832 insertions(+), 24 deletions(-)
 create mode 100644 tests/acceptance/virtiofs_submounts.py
 create mode 100644 tests/acceptance/virtiofs_submounts.py.data/cleanup.sh
 create mode 100644 tests/acceptance/virtiofs_submounts.py.data/guest-cleanup.sh
 create mode 100644 tests/acceptance/virtiofs_submounts.py.data/guest.sh
 create mode 100644 tests/acceptance/virtiofs_submounts.py.data/host.sh


