Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AB1ECE58C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 03:15:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FCDD21848
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 03:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FCDD21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKDIo-0006Wn-4U
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 23:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iKDI7-00063V-SE
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 23:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iKDI7-0006Zr-1c
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 23:14:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:26479)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iKDI4-0006WL-Pa; Mon, 14 Oct 2019 23:14:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Oct 2019 20:14:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,297,1566889200"; d="scan'208";a="195159998"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga007.fm.intel.com with ESMTP; 14 Oct 2019 20:14:20 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: kwolf@redhat.com, mreitz@redhat.com, jasowang@redhat.com,
 alex.bennee@linaro.org, dgilbert@redhat.com, richard.henderson@linaro.org
Subject: [PATCH 0/2] replace sysconf(_SC_PAGESIZE) with
 qemu_real_host_page_size
Date: Tue, 15 Oct 2019 11:13:48 +0800
Message-Id: <20191015031350.4345-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a following up patch to cleanup page size, suggested by
"Dr. David Alan Gilbert" <dgilbert@redhat.com>.

Patch 2 does the job, while during the cleanup I found test-mmap.c has quite a
lot code style problem. To make the code looks good, patch 1 is introduced to
make checkpatch.pl happy a little.

Wei Yang (2):
  tests/tcg/multiarch: fix code style in function main of test-mmap.c
  core: replace sysconf(_SC_PAGESIZE) with qemu_real_host_page_size

 block/file-posix.c              |  2 +-
 net/l2tpv3.c                    |  2 +-
 tests/tcg/multiarch/test-mmap.c | 67 ++++++++++++++++++---------------
 3 files changed, 38 insertions(+), 33 deletions(-)

-- 
2.17.1


