Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED48C388F9
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 339DE22277
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Az3SYCwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 339DE22277
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZWUq-00035N-5W
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 04:51:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <4d0746e2135f56c59c6e61ef42d700b7139065b4@lizzy.crudebyte.com>)
 id 1kZWT7-0001HZ-Eu
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:49:41 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:49793)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <4d0746e2135f56c59c6e61ef42d700b7139065b4@lizzy.crudebyte.com>)
 id 1kZWT4-0006XC-7T
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=YLX4Vv/lyd5BrIs3STwr7sZA8LEKe6YWaw7KS1Bu1Bo=; b=Az3SY
 CwKNvdj6wElA4/yYa/nQuSOjTebXqN923/enQCJ5W50Qw2O/qepLJhPGUIpWJArcSG/vtae5U5meC
 uVRBTKW+l2Qj6i1Yi7QUClJi9serAyYwjVTqILJek7yWnZt6vUn5HQmh+uJebUVZEBYC2Jveea7ic
 QMXM2PpXclyAC/2BtXgdCLH4hjUuUsFjiW/WEqZo7YzbdPIVIwev66HWQrhf7NgcVc1U5vDOI6K++
 lcfy+YdeZBCKx1oL+yTuCVI3GEEOg1HhhdF4E5I7s/Q4esOTEpOs3wPPDD8Rg4IC8bJNgtMnArEpZ
 hDQTEl1T8F1f70LtPwhcDw2NvtabA==;
Message-Id: <cover.1604309512.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 2 Nov 2020 10:31:52 +0100
Subject: [PULL v3 00/17] 9p queue (previous 2020-10-30)
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=4d0746e2135f56c59c6e61ef42d700b7139065b4@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 04:48:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 2ab6c494339652e69ec405dc779d83c46c8faf98:

  Merge remote-tracking branch 'remotes/kraxel/tags/modules-20201029-pull-request' into staging (2020-10-31 20:32:56 +0000)

are available in the Git repository at:

  https://github.com/cschoenebeck/qemu.git tags/pull-9p-20201102

for you to fetch changes up to 4d0746e2135f56c59c6e61ef42d700b7139065b4:

  tests/9pfs: add local Tunlinkat hard link test (2020-11-01 19:44:29 +0100)

----------------------------------------------------------------
9pfs: only test case changes this time

* Fix occasional test failures with parallel tests.

* Fix coverity error in test code.

* Avoid error when auto removing test directory if it disappeared
  for some reason.

* Refactor: Rename functions to make top-level test functions fs_*()
  easily distinguishable from utility test functions do_*().

* Refactor: Drop unnecessary function arguments in utility test
  functions.

* More test cases using the 9pfs 'local' filesystem driver backend,
  namely for the following 9p requests: Tunlinkat, Tlcreate, Tsymlink
  and Tlink.

----------------------------------------------------------------
Christian Schoenebeck (11):
      tests/9pfs: make create/remove test dir public
      tests/9pfs: fix test dir for parallel tests
      tests/9pfs: fix coverity error in create_local_test_dir()
      tests/9pfs: simplify do_mkdir()
      tests/9pfs: add local Tunlinkat directory test
      tests/9pfs: add local Tlcreate test
      tests/9pfs: add local Tunlinkat file test
      tests/9pfs: add local Tsymlink test
      tests/9pfs: add local Tunlinkat symlink test
      tests/9pfs: add local Tlink test
      tests/9pfs: add local Tunlinkat hard link test

Greg Kurz (6):
      tests/9pfs: Force removing of local 9pfs test directory
      tests/9pfs: Factor out do_version() helper
      tests/9pfs: Set alloc in fs_create_dir()
      tests/9pfs: Factor out do_attach() helper
      tests/9pfs: Turn fs_readdir_split() into a helper
      tests/9pfs: Turn fs_mkdir() into a helper

 tests/qtest/libqos/virtio-9p.c |  29 +--
 tests/qtest/libqos/virtio-9p.h |  10 +
 tests/qtest/virtio-9p-test.c   | 479 +++++++++++++++++++++++++++++++++++++----
 3 files changed, 470 insertions(+), 48 deletions(-)

