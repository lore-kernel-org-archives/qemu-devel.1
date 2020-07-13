Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88DDC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9283020758
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2A58Zq7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9283020758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juw8n-0001XG-Qv
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 06:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1juw7a-0008ON-Tn
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:55:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35284
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1juw7Z-0003u4-7E
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594637740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tGquHxtFuSXq+AU65Hurlz6mj72jWsZ7WGJO8I1Hb+M=;
 b=F2A58Zq70qhUebg/ksMFpzMrlPqI7mYkJuThvdSombczMT5/9BfWLdM3kmTfGTAYU1wTMs
 1T5ajIpMEdYC/2KwmK2Jo8aHYH91IypURrMzQ4g04ERbyjjhk+6EL41FsG/tOzW7deT+fH
 15SxUy4pBnXv5PthBVAZbMGaxS4y5uA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-OhJne29OMVq8HSEJZLGURw-1; Mon, 13 Jul 2020 06:55:38 -0400
X-MC-Unique: OhJne29OMVq8HSEJZLGURw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41A70107ACCA;
 Mon, 13 Jul 2020 10:55:37 +0000 (UTC)
Received: from thuth.com (ovpn-112-125.ams2.redhat.com [10.36.112.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4FACA27CCC;
 Mon, 13 Jul 2020 10:55:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 0/9] Fuzzer, configure, gitlab and misc patches
Date: Mon, 13 Jul 2020 12:55:25 +0200
Message-Id: <20200713105534.10872-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

 Hi Peter,

the following changes since commit 9f526fce49c6ac48114ed04914b5a76e4db75785:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-and-misc-110720-2' into staging (2020-07-12 15:32:05 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2020-07-13

for you to fetch changes up to 2a84f48c2b387877422ee85f6425d2c1b25bace0:

  docs/system/s390x: Improve the 3270 documentation (2020-07-13 11:40:52 +0200)

----------------------------------------------------------------
* Some fuzzer related fixes
* Fixes / improvements for the "configure" script
* Doc updates
* Gitlab pipeline-status script
----------------------------------------------------------------

Alexander Bulekov (2):
      configure: do not clobber CFLAGS with --enable-fuzzing
      fuzz: add missing header for rcu_enable_atfork

Cleber Rosa (1):
      GitLab Gating CI: introduce pipeline-status contrib script

Olaf Hering (1):
      configure: fix malloc check

Thomas Huth (5):
      tests/qtest/fuzz: Add missing spaces in description
      docs/devel/fuzzing: Fix bugs in documentation
      Remove the CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE switch
      disas/sh4: Add missing fallthrough annotations
      docs/system/s390x: Improve the 3270 documentation

 configure                           |  32 +-------
 disas/sh4.c                         |   2 +
 docs/devel/fuzzing.txt              |   6 +-
 docs/system/s390x/3270.rst          |  43 ++++++++--
 include/ui/gtk.h                    |   4 -
 include/ui/qemu-pixman.h            |   4 -
 scripts/ci/gitlab-pipeline-status   | 157 ++++++++++++++++++++++++++++++++++++
 scripts/decodetree.py               |  12 +--
 tests/qtest/fuzz/fuzz.c             |   1 +
 tests/qtest/fuzz/virtio_scsi_fuzz.c |   4 +-
 ui/gtk.c                            |   4 -
 util/coroutine-ucontext.c           |   4 +-
 12 files changed, 210 insertions(+), 63 deletions(-)
 create mode 100755 scripts/ci/gitlab-pipeline-status


