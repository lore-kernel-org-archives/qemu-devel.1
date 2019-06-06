Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5B2C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 08:49:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F19AE20684
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 08:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F19AE20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56638 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYo54-0000Qi-3P
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 04:49:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hYnyg-0003m0-3h
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 04:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hYnsG-0003Tf-Vv
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 04:35:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:52085)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hYnsG-0003SS-LW
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 04:35:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	06 Jun 2019 01:35:50 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga002.jf.intel.com with ESMTP; 06 Jun 2019 01:35:49 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 16:34:55 +0800
Message-Id: <20190606083501.2087-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.126
Subject: [Qemu-devel] [PATCH 0/6] multifd: a new mechanism for send thread
 sync
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Wei Yang <richardw.yang@linux.intel.com>, dgilbert@redhat.com,
	quintela@redhat.com
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

Wei Yang (6):
  migration/multifd: move MultiFDSendParams handling into
    multifd_send_fill_packet()
  migration/multifd: notify channels_ready when send thread starts
  migration/multifd: use sync field to synchronize send threads
  migration/multifd: used must not be 0 for a pending job
  migration/multifd: use boolean for pending_job is enough
  migration/multifd: there is no spurious wakeup now

 migration/ram.c | 62 +++++++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 23 deletions(-)

-- 
2.19.1


