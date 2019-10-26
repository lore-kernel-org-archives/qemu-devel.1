Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D39CA9EA0
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 01:24:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 087F121D7B
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 01:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087F121D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOAox-0006TV-Vy
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 21:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iOADB-0002Yn-17
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 20:45:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iOAD9-0004kM-Sh
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 20:45:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:9324)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iOAD9-0004ju-LH
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 20:45:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 17:45:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400"; d="scan'208";a="210476032"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga001.fm.intel.com with ESMTP; 25 Oct 2019 17:45:40 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Subject: [PATCH v2 0/6] migration/multifd: a new mechanism for send thread sync
Date: Sat, 26 Oct 2019 08:45:14 +0800
Message-Id: <20191026004520.5515-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
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
Cc: qemu-devel@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Current send thread could work while the sync mechanism has some problem:

  * has spuriously wakeup
  * number of channels_ready will *overflow* the number of real channels

The reason is:

  * if MULTIFD_FLAG_SYNC is set in the middle of send thread running, there
    is one more spurious wakeup
  * if MULTIFD_FLAG_SYNC is set when send thread is not running, there is one
    more channels_ready be triggered

To solve this situation, one new mechanism is introduced to synchronize send
threads. The idea is simple, a new field *sync* is introduced to indicate a
synchronization is required.

---
v2: rebase on latest code

Wei Yang (6):
  migration/multifd: move Params update and pages cleanup into
    multifd_send_fill_packet()
  migration/multifd: notify channels_ready when send thread starts
  migration/multifd: use sync field to synchronize send threads
  migration/multifd: used must not be 0 for a pending job
  migration/multifd: use boolean for pending_job is enough
  migration/multifd: there is no spurious wakeup now

 migration/ram.c | 74 +++++++++++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 27 deletions(-)

-- 
2.17.1


