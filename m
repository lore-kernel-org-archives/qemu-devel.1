Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC490C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E2720672
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aU//MHM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E2720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqyh-0006ZJ-RF
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 13:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsqoH-0003lD-7f
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:51:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51523
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsqoF-0006jJ-5n
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594140666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=10CNakQ3NgheZX/vjI8iYykwppKbLWYe9EuKJd8Y9yA=;
 b=aU//MHM6Ucn6juLqpNhfkLuo/9vFOdr1vza3ZQ28CY5EdaaT4Y+KSh06nbozhIm6J0Ba8a
 XacwEP1QkiIC+EALGNhXYFxlJ9pGBsiosLnxZQ1e7xs6mWm92DCjzrcxRNb2wsTn2rRIH2
 VK1rQc9qJMPDuEGi/ewVYXgyLWdkXY4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-dQR7_YpFNua-zqFIhuDs5w-1; Tue, 07 Jul 2020 12:50:50 -0400
X-MC-Unique: dQR7_YpFNua-zqFIhuDs5w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2A12461;
 Tue,  7 Jul 2020 16:50:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DE0F5D9F3;
 Tue,  7 Jul 2020 16:50:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1B50B1132FD2; Tue,  7 Jul 2020 18:50:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v12 0/8] error: auto propagated local_err part I
Date: Tue,  7 Jul 2020 18:50:29 +0200
Message-Id: <20200707165037.1026246-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:04:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Laszlo Ersek <lersek@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, groug@kaod.org,
 Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To speed things up, I'm taking the liberty to respin Vladimir's series
with my documentation amendments.

After my documentation work, I'm very much inclined to rename
ERRP_AUTO_PROPAGATE() to ERRP_GUARD().  The fact that it propagates
below the hood is detail.  What matters to its users is that it lets
them use @errp more freely.  Thoughts?

Based-on: Message-Id: <20200707160613.848843-1-armbru@redhat.com>

Available from my public repository https://repo.or.cz/qemu/armbru.git
on branch error-auto.

v12: (based on "[PATCH v4 00/45] Less clumsy error checking")
01: Comments merged properly with recent commit "error: Document Error
API usage rules", and edited for clarity.  Put ERRP_AUTO_PROPAGATE()
before its helpers, and touch up style.
01-08: Commit messages tweaked

Vladimir's cover letter for v11:

v11: (based-on "[PATCH v2 00/44] Less clumsy error checking")
01: minor rebase of documentation, keep r-bs
02: - minor comment tweaks [Markus]
    - use explicit file name in MAINTAINERS instead of pattern
    - add Markus's r-b
03,07,08: rabase changes, drop r-bs


v11 is available at
 https://src.openvz.org/scm/~vsementsov/qemu.git #tag up-auto-local-err-partI-v11
v10 is available at
 https://src.openvz.org/scm/~vsementsov/qemu.git #tag up-auto-local-err-partI-v10

In these series, there is no commit-per-subsystem script, each generated
commit is generated in separate.

Still, generating commands are very similar, and looks like

    sed -n '/^<Subsystem name>$/,/^$/{s/^F: //p}' MAINTAINERS | \
    xargs git ls-files | grep '\.[hc]$' | \
    xargs spatch \
        --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
        --macro-file scripts/cocci-macro-file.h \
        --in-place --no-show-diff --max-width 80

Note, that in each generated commit, generation command is the only
text, indented by 8 spaces in 'git log -1' output, so, to regenerate all
commits (for example, after rebase, or change in coccinelle script), you
may use the following command:

git rebase -x "sh -c \"git show --pretty= --name-only | xargs git checkout HEAD^ -- ; git reset; git log -1 | grep '^        ' | sh\"" HEAD~6

Which will start automated interactive rebase for generated patches,
which will stop if generated patch changed
(you may do git commit --amend to apply updated generated changes).

Note:
  git show --pretty= --name-only   - lists files, changed in HEAD
  git log -1 | grep '^        ' | sh   - rerun generation command of HEAD


Check for compilation of changed .c files
git rebase -x "sh -c \"git show --pretty= --name-only | sed -n 's/\.c$/.o/p' | xargs make -j9\"" HEAD~6

Vladimir Sementsov-Ogievskiy (8):
  error: New macro ERRP_AUTO_PROPAGATE()
  scripts: Coccinelle script to use ERRP_AUTO_PROPAGATE()
  sd: Use ERRP_AUTO_PROPAGATE()
  pflash: Use ERRP_AUTO_PROPAGATE()
  fw_cfg: Use ERRP_AUTO_PROPAGATE()
  virtio-9p: Use ERRP_AUTO_PROPAGATE()
  nbd: Use ERRP_AUTO_PROPAGATE()
  xen: Use ERRP_AUTO_PROPAGATE()

 scripts/coccinelle/auto-propagated-errp.cocci | 337 ++++++++++++++++++
 include/block/nbd.h                           |   1 +
 include/qapi/error.h                          | 163 ++++++++-
 block/nbd.c                                   |   7 +-
 hw/9pfs/9p-local.c                            |  12 +-
 hw/9pfs/9p.c                                  |   1 +
 hw/block/dataplane/xen-block.c                |  17 +-
 hw/block/pflash_cfi01.c                       |   7 +-
 hw/block/pflash_cfi02.c                       |   7 +-
 hw/block/xen-block.c                          | 102 +++---
 hw/nvram/fw_cfg.c                             |  14 +-
 hw/pci-host/xen_igd_pt.c                      |   7 +-
 hw/sd/sdhci-pci.c                             |   7 +-
 hw/sd/sdhci.c                                 |  21 +-
 hw/sd/ssi-sd.c                                |  10 +-
 hw/xen/xen-backend.c                          |   7 +-
 hw/xen/xen-bus.c                              |  92 ++---
 hw/xen/xen-host-pci-device.c                  |  27 +-
 hw/xen/xen_pt.c                               |  25 +-
 hw/xen/xen_pt_config_init.c                   |  17 +-
 nbd/client.c                                  |   5 +
 nbd/server.c                                  |   5 +
 MAINTAINERS                                   |   1 +
 23 files changed, 659 insertions(+), 233 deletions(-)
 create mode 100644 scripts/coccinelle/auto-propagated-errp.cocci

-- 
2.26.2


