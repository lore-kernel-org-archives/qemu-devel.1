Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89CBC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 19:17:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49867208C7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 19:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="PTO7DplB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49867208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQbQ8-0002HV-8D
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 15:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <be342f236842272275f65dbe05587f0a5409ad77@lizzy.crudebyte.com>)
 id 1kQbLe-0004o2-2o
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 15:13:06 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:38193)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <be342f236842272275f65dbe05587f0a5409ad77@lizzy.crudebyte.com>)
 id 1kQbLa-0005Em-RN
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 15:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=3gdsJ6pjvCU0FrWJrVN6xDBTz3l1XPfDosQSPb3Og7M=; b=PTO7D
 plBYOxAhYQwHpG5UVMKLzt7PrGsAL0qeQ/CRlbM8/U4Pux7Zmz8LSvPCxi5icrzeWP0pYv9+sJDvd
 6aIwaLNr3VNruk1maIYzd/HucZ+BHZRk/dXzRJSm/pLjUPslyA6kVf+RM7LIGCg6mnu4bQ5e5fFny
 4qstxH8e5vG4sUcjj8Puu01PcNHDbq2nPCqseMWtljg3bUr/mLYv48caA6Zvyy6QB10+ZCxPbEJXf
 +pLb78BHAKHLmMqxTeIAlgGoKEliAeU3l0+qXtbNGXM0fweyDzzgJI8rYDA7wo6PwXngicShPZwf6
 vxMcg05a1cQTplNgCm3uUC/hmq0FQ==;
Message-Id: <cover.1602182956.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 8 Oct 2020 20:49:16 +0200
Subject: [PATCH v4 00/12] 9pfs: add tests using local fs driver
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
    Laurent Vivier <lvivier@redhat.com>,
    Paolo Bonzini <pbonzini@redhat.com>,
    Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
    Greg Kurz <groug@kaod.org>,
    "Daniel P. Berrangé" <berrange@redhat.com>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=be342f236842272275f65dbe05587f0a5409ad77@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 15:12:00
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

1. libqos patches 1 and 2 remove a limitation of the qtest/libqos subsystem:
   support for more than one device using the same (official) QEMU device
   name.

2. Patches 3 to 7 enhance debugging issues with the qtest framework.

3. Patches 8 to 12 actually introduce 9pfs 'local' test cases using the qtest
   framework. These 'local' tests are adding a test directory 'qtest-9p-local'
   inside the current working directory (using get_current_dir()), which is
   typically the build directory, before running the tests. That test
   directory is automatically recreated next time the test suite is run again,
   to ensure the 9pfs 'local' tests always run consistently on a clean test
   directory. The test directory is used by the 'local' driver as root of its
   export path. So it will add/read/write/delete real files and directories
   inside that test directory.

v3->v4:

  * Added qos_printf() and qos_printf_literal() (NEW patch 3).

  * Use qos_printf() and qos_printf_literal() instead of printf() for not
    breaking TAP output (patch 4, 6, 7).

  * Added private function regex_replace() to simplify and deduplicate code
    (patch 9).

  * RegEx pattern hardening in virtio_9p_assign_local_driver() to avoid
    potential issues with future changes (patch 9).

  * Updated commit log comments.

v2->v3:

  * concat_path() is now just a wrapper for g_build_filename() (patch 8).

  * Dropped function strpr(), using g_strdup_printf() instead (patch 8, 9).

  * Fixed incorrect size for array allocation in split() function
    (patch 11).

v1->v2:

  * The libqos debugging features are now turned on by command line argument
    '--verbose' instead of using environment variables (patches 4, 5, 6).

  * The new 9pfs 'local' tests no longer depend on patches 1 and 2 by no
    longer using a libqos multi-device approach, but rather modifying the
    final QEMU command line for each test instead; see discussion of v1
    for reason (patches 7 to 11).

  * Use GCC_FMT_ATTR on helper function strpr() (patch 8).

  * Updated commit log comments.

Christian Schoenebeck (12):
  libqos/qgraph: add qemu_name to QOSGraphNode
  libqos/qgraph: add qos_node_create_driver_named()
  libqos/qgraph_internal: add qos_printf() and qos_printf_literal()
  libqos/qgraph: add qos_dump_graph()
  tests/qtest/qos-test: dump qos graph if verbose
  tests/qtest/qos-test: dump environment variables if verbose
  tests/qtest/qos-test: dump QEMU command if verbose
  tests/9pfs: change qtest name prefix to synth
  tests/9pfs: introduce local tests
  tests/9pfs: wipe local 9pfs test directory
  tests/9pfs: add virtio_9p_test_path()
  tests/9pfs: add local Tmkdir test

 tests/qtest/libqos/qgraph.c          | 110 ++++++++++++++-
 tests/qtest/libqos/qgraph.h          |  36 +++++
 tests/qtest/libqos/qgraph_internal.h |  12 ++
 tests/qtest/libqos/virtio-9p.c       | 100 ++++++++++++++
 tests/qtest/libqos/virtio-9p.h       |  10 ++
 tests/qtest/qos-test.c               |  15 +-
 tests/qtest/virtio-9p-test.c         | 197 ++++++++++++++++++++++++---
 7 files changed, 455 insertions(+), 25 deletions(-)

-- 
2.20.1


