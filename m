Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A1CC4741F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 12:21:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C67C823718
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 12:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="mIUWYV6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67C823718
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMVgS-0005LC-P8
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 08:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <e45214e28a9aacf59bc0d0793bedfb18d7520c1f@lizzy.crudebyte.com>)
 id 1kMVfM-0004V7-HL
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 08:20:32 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:47299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <e45214e28a9aacf59bc0d0793bedfb18d7520c1f@lizzy.crudebyte.com>)
 id 1kMVfK-0006sn-4H
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 08:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=OCNQiyIpjk4CX+0bRYMlY1jnQeedcvytJU+K2tR9xgA=; b=mIUWY
 V6UEvQPaBdRz/QeBgG+5I/NTFTE3YfPX2oW1lgQNEXys3MpQw0UHMCdf9l12cCO5kQ6e1engAUl9s
 7ZwMK9xHIlGWkTLfY464v5g+J2ARbMUM4eevwqy0a15MbvzVVYb0PKpICXFV5xpe/JHbkWvvSfvJG
 ucaiq1Oa893bQO6VBsrSr2fdAb2UwpFDko0IllseydkHiVv+2adTiolbyVq3KSiOZGO8ZgrDhX50A
 ZByKj7kH/QzleAfljZhQGF9mnHZb+Drfe6ROsTCg2OhOYHkGvQGobTXsQJ6zT5mt1vL4EkyWmuxKA
 SPrnbYFifRkGRyIxyBJaBcXkOCbXw==;
Message-Id: <cover.1601203436.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 27 Sep 2020 12:43:56 +0200
Subject: [PATCH 00/12] 9pfs: add tests using local fs driver
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=e45214e28a9aacf59bc0d0793bedfb18d7520c1f@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 07:42:27
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

The currently existing 9pfs test cases are all solely using the 9pfs 'synth'
fileystem driver, which is a very simple and purely simulated (in RAM only)
filesystem. There are issues though where the 'synth' fs driver is not
sufficient. For example the following two bugs need test cases running the
9pfs 'local' fs driver:

https://bugs.launchpad.net/qemu/+bug/1336794
https://bugs.launchpad.net/qemu/+bug/1877384

This patch set for that reason introduces 9pfs test cases using the 9pfs
'local' filesystem driver along to the already existing tests on 'synth'.
It consists of 3 parts:

1. Mandatory qos patches 1 and 2 lay the ground by removing a limitation of
   the qtest/qos subsystem: support for more than one device using the same
   (official) QEMU device name.

2. Optional qos patches 3 to 6 were used for debugging the qtest framework.
   I found them very useful to get insight how the qos graph is built, how
   the generated QEMU commands looks like, and what environemnt variables are
   already available in qtests. I thought they might helpful for other people
   as well, either in suggested or some modified form. Especially as it's not
   obvious sometimes why certain tests are simply ignored by the qtest
   framework (e.g. because of a missing link in qos path from test node to
   qos root node, or certain devices been auto marked as 'unavailable' after
   QMP negotiation with QEMU). I introduced several new QTEST_* environment
   variables for the individual debugging aspects; maybe they could simply
   use one and the same variable like QTEST_DEBUG instead.
   Note: patch 3 uses coloured output to mark the individual graph nodes as
   either available or unavailable. It does not check for tty color support
   right now. I'm not sure if there is already some QEMU util function that
   could be used for that check.

3. Patches 7 to 12 actually introduce 9pfs 'local' test cases using the qtest
   framework. They only work in conjunction with qos patches 1 and 2. These
   'local' tests are adding a test directory 'qtest-9p-local' inside the
   current working directory (using get_current_dir()), which is typically the
   build directory, before running the tests. That test directory is
   automatically recreated next time the test suite is run again, to ensure
   the 9pfs 'local' tests always run consistently on a clean test directory.
   The test directory is used by the 'local' driver as root of its export
   path. So it will add/read/write/delete real files and directories inside
   that test directory.
   Note: I was adding a bunch of basic util functions like split(),
   concat_path() and strpr(). I am not sure if there are already public QEMU
   util functions that I could instead of them.

Christian Schoenebeck (12):
  tests/qtest/qgraph: add qemu_name to QOSGraphNode
  tests/qtest/qgraph: add qos_node_create_driver_named()
  tests/qtest/qos: add qos_dump_graph()
  tests/qtest/qos-test: new QTEST_DUMP_GRAPH environment variable
  tests/qtest/qos-test: add QTEST_DUMP_ENV environment variable
  tests/qtest/qos-test: add environment variable QTEST_DEBUG
  test/9pfs: change export tag name to qtest-synth
  tests/9pfs: refactor test names and test devices
  tests/9pfs: introduce local tests
  tests/9pfs: wipe local 9pfs test directory
  tests/9pfs: add virtio_9p_test_path()
  tests/9pfs: add local Tmkdir test

 tests/qtest/libqos/qgraph.c          | 108 ++++++++++++++-
 tests/qtest/libqos/qgraph.h          |  36 +++++
 tests/qtest/libqos/qgraph_internal.h |   1 +
 tests/qtest/libqos/virtio-9p.c       | 147 ++++++++++++++++++---
 tests/qtest/libqos/virtio-9p.h       |   8 +-
 tests/qtest/qos-test.c               |  15 ++-
 tests/qtest/virtio-9p-test.c         | 188 ++++++++++++++++++++++++---
 7 files changed, 463 insertions(+), 40 deletions(-)

-- 
2.20.1


