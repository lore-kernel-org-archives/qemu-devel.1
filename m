Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A60FC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:49:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B95B2085B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evPQT+o/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B95B2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX7Z2-0007Yt-4d
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 14:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kX7TC-0001kG-HI
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48425)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kX7TA-0003XT-8P
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603737826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7YLFtDkIxGgmwv/+wf5Z7mYWmvTQPTZe/NRfOMCafLE=;
 b=evPQT+o/ATyJOhESplwgNMj7q9ZP9oKXXMPKASz5kbiq54wws2HEMiuNc16EN40tyXsMHf
 XZz0cmfiHDq+BaeJGq9i3G3B2s96lCW7cWBB8LX2rAfvuAhFoX62RuLBoA4RqYPlbIkEW1
 pVxAjMrK5p9gofJj3IUlpfm0TEQ9HOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-Ds-mYBF1O46muvJ_gPCBmw-1; Mon, 26 Oct 2020 14:43:42 -0400
X-MC-Unique: Ds-mYBF1O46muvJ_gPCBmw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8139A1074655;
 Mon, 26 Oct 2020 18:43:41 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-112-208.ams2.redhat.com
 [10.36.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1D015D9CA;
 Mon, 26 Oct 2020 18:43:33 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com,
 misono.tomohiro@jp.fujitsu.com
Subject: [PULL 00/16] virtiofs queue
Date: Mon, 26 Oct 2020 18:43:15 +0000
Message-Id: <20201026184331.272953-1-dgilbert@redhat.com>
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
Cc: virtio-fs@redhat.com, vgoyal@Redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit a95e0396c805735c491a049b01de6f5a713fb91b:

  Merge remote-tracking branch 'remotes/bonzini-gitlab/tags/for-upstream' into staging (2020-10-26 15:49:11 +0000)

are available in the Git repository at:

  https://gitlab.com/dagrh/qemu.git tags/pull-virtiofs-20201026

for you to fetch changes up to c93a656f7b6585d9b6f8639d1fbb74dd944be239:

  tests/acceptance: Add virtiofs_submounts.py (2020-10-26 18:35:32 +0000)

----------------------------------------------------------------
virtiofsd pull 2020-10-26

Misono
   Set default log level to info
   Explicit build option for virtiofsd

Me
   xattr name mapping

Stefan
  Alternative chroot sandbox method

Max
  Submount mechanism

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

----------------------------------------------------------------
Dr. David Alan Gilbert (5):
      tools/virtiofsd: xattr name mappings: Add option
      tools/virtiofsd: xattr name mappings: Map client xattr names
      tools/virtiofsd: xattr name mappings: Map server xattr names
      tools/virtiofsd: xattr name mapping examples
      tools/virtiofsd: xattr name mappings: Simple 'map'

Max Reitz (8):
      linux/fuse.h: Pull in from Linux
      virtiofsd: Announce FUSE_ATTR_FLAGS
      virtiofsd: Add attr_flags to fuse_entry_param
      virtiofsd: Add fuse_reply_attr_with_flags()
      virtiofsd: Store every lo_inode's parent_dev
      virtiofsd: Announce sub-mount points
      tests/acceptance/boot_linux: Accept SSH pubkey
      tests/acceptance: Add virtiofs_submounts.py

Misono Tomohiro (2):
      configure: add option for virtiofsd
      virtiofsd: passthrough_ll: set FUSE_LOG_INFO as default log_level

Stefan Hajnoczi (1):
      virtiofsd: add container-friendly -o sandbox=chroot option

 configure                                          |   8 +-
 docs/tools/virtiofsd.rst                           | 193 ++++++-
 include/standard-headers/linux/fuse.h              |  11 +-
 meson.build                                        |   1 +
 meson_options.txt                                  |   2 +
 tests/acceptance/boot_linux.py                     |  13 +-
 tests/acceptance/virtiofs_submounts.py             | 289 ++++++++++
 .../virtiofs_submounts.py.data/cleanup.sh          |  46 ++
 .../virtiofs_submounts.py.data/guest-cleanup.sh    |  30 +
 .../acceptance/virtiofs_submounts.py.data/guest.sh | 138 +++++
 .../acceptance/virtiofs_submounts.py.data/host.sh  | 127 +++++
 tools/meson.build                                  |  17 +-
 tools/virtiofsd/fuse_common.h                      |   8 +
 tools/virtiofsd/fuse_lowlevel.c                    |  34 +-
 tools/virtiofsd/fuse_lowlevel.h                    |  20 +
 tools/virtiofsd/helper.c                           |   9 +
 tools/virtiofsd/passthrough_ll.c                   | 622 ++++++++++++++++++++-
 17 files changed, 1528 insertions(+), 40 deletions(-)
 create mode 100644 tests/acceptance/virtiofs_submounts.py
 create mode 100644 tests/acceptance/virtiofs_submounts.py.data/cleanup.sh
 create mode 100644 tests/acceptance/virtiofs_submounts.py.data/guest-cleanup.sh
 create mode 100644 tests/acceptance/virtiofs_submounts.py.data/guest.sh
 create mode 100644 tests/acceptance/virtiofs_submounts.py.data/host.sh


