Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72513C3815B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 03:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C832084D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 03:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C832084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOYvM-0003Hr-CX
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 23:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jingqi.liu@intel.com>) id 1jOYuW-00029D-1v
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 23:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jingqi.liu@intel.com>) id 1jOYuU-0000ka-E3
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 23:40:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:4319)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
 id 1jOYuT-0000iK-Td
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 23:40:22 -0400
IronPort-SDR: zT0w4WMRyOau8I1ZOeKl8vmVeJB9j/VgBIlxNcf/ImoVSNAwqt26Et6XJkh8VSySRBsPE+el1D
 5D1u8h818zaA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2020 20:40:13 -0700
IronPort-SDR: uOzz4fbosFTiEcGLwt3h5TEuKxutwr1a1BYWjc1358aio+o7L29h3DhkXoChhR33csBySnKgnR
 RhqVsNKWfq0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,385,1580803200"; d="scan'208";a="256729944"
Received: from dazhang1-mobile.sh.intel.com ([10.239.48.70])
 by orsmga006.jf.intel.com with ESMTP; 14 Apr 2020 20:40:11 -0700
From: Jingqi Liu <jingqi.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 0/3] fetch the alignment of device dax
Date: Wed, 15 Apr 2020 11:35:35 +0800
Message-Id: <20200415033538.43329-1-jingqi.liu@intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.88
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
Cc: Jingqi Liu <jingqi.liu@intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds libdaxctl support and fetchs the alignment of
device dax through libdaxctl [1] APIs.

QEMU uses mmap(2) to maps vNVDIMM backends and aligns the mapping
address to the page size (getpagesize(2)) by default. However, some
types of backends may require an alignment different than the page
size. The 'align' option is provided to memory-backend-file to allow
users to specify the proper alignment.

For device dax (e.g., /dev/dax0.0), the 'align' option needs to
match the alignment requirement of the device dax, which can be fetched
through the libdaxctl APIs.

[1] Libdaxctl is a part of ndctl project.
The project's repository is: https://github.com/pmem/ndctl

Changelog:
  v2: Per Paolo and Dan suggestions, fetch the alignment of device dax
      through libdaxctl APIs.

  v1: The initial version.
      Fetch the alignment through "/sys/dev/char/%d:%d/device/align".

Jingqi Liu (3):
  exec: fetch the alignment of Linux devdax pmem character device nodes
  docs/nvdimm: add description of alignment requirement of device dax
  configure: add libdaxctl support

 configure       | 30 +++++++++++++++++++++++++++
 docs/nvdimm.txt |  9 +++++++++
 exec.c          | 54 ++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 92 insertions(+), 1 deletion(-)

-- 
2.17.1


