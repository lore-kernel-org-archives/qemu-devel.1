Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4B0C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 12:57:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A89222BA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 12:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="L2LY0Esc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A89222BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUUj3-0001MX-DK
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 08:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <653daf38978d101d8810f96b9337ebc6b7b1423f@lizzy.crudebyte.com>)
 id 1kUUi8-0000iD-Jb
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 08:56:24 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:50479)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <653daf38978d101d8810f96b9337ebc6b7b1423f@lizzy.crudebyte.com>)
 id 1kUUi6-00014h-MC
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 08:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=xqJLBv0ucdbR2NGc6xhWauuN6E5NSiUPirYiL9Dh4os=; b=L2LY0
 EscjIRyaYwdRODuzb3k0aLN7Muy2dd2Cq+/HwmtVBZBg89ao2N4DZU0DBRDMFdC3YYvq+k0A5XEO6
 CHBafqIIe0bUpTXRLIv/gEu7NLLSGqAAgIOZb61FYp/O1giGFMvptNI6nU+JHwWwPmkZolqJH+R7y
 26vHjOQsRz7n2YTCI3Ale10475qQ6sxfYEx3rG+dPwwnh0V3kmAhH/YKpID+jwRT+jt1sXwRdVfgz
 +lFxXNw6keNi2sqsa0hIW5GDx37bYn4j70t4Sef/zabOMT4Nwv2GmdUGo3L9h5sZwmch3rp4sxQXJ
 sWe2YlcN+BYVBaqv2uaBwBb6XQ07w==;
Message-Id: <cover.1603111175.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 19 Oct 2020 14:39:35 +0200
Subject: [PULL v3 0/6] 9p queue (previous 2020-10-17)
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=653daf38978d101d8810f96b9337ebc6b7b1423f@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 06:27:23
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

The following changes since commit ba2a9a9e6318bfd93a2306dec40137e198205b86:

  Merge remote-tracking branch 'remotes/mcayland/tags/qemu-macppc-20201019' into staging (2020-10-19 11:46:03 +0100)

are available in the Git repository at:

  https://github.com/cschoenebeck/qemu.git tags/pull-9p-20201019

for you to fetch changes up to 653daf38978d101d8810f96b9337ebc6b7b1423f:

  tests/9pfs: add local Tmkdir test (2020-10-19 14:25:40 +0200)

----------------------------------------------------------------
9pfs: add tests using local fs driver

The currently existing 9pfs test cases are all solely using the 9pfs 'synth'
fileystem driver, which is a very simple and purely simulated (in RAM only)
filesystem. There are issues though where the 'synth' fs driver is not
sufficient. For example the following two bugs need test cases running the
9pfs 'local' fs driver:

https://bugs.launchpad.net/qemu/+bug/1336794
https://bugs.launchpad.net/qemu/+bug/1877384

This patch set for that reason introduces 9pfs test cases using the 9pfs
'local' filesystem driver along to the already existing tests on 'synth'.

----------------------------------------------------------------
Christian Schoenebeck (6):
      9pfs: suppress performance warnings on qtest runs
      tests/9pfs: change qtest name prefix to synth
      tests/9pfs: introduce local tests
      tests/9pfs: wipe local 9pfs test directory
      tests/9pfs: add virtio_9p_test_path()
      tests/9pfs: add local Tmkdir test

 hw/9pfs/9p-synth.c             |   2 -
 hw/9pfs/virtio-9p-device.c     |   6 ++
 tests/qtest/libqos/virtio-9p.c | 100 +++++++++++++++++++++
 tests/qtest/libqos/virtio-9p.h |  10 +++
 tests/qtest/virtio-9p-test.c   | 197 ++++++++++++++++++++++++++++++++++++-----
 5 files changed, 292 insertions(+), 23 deletions(-)

