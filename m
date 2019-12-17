Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE23C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 12:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F22B20663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 12:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F22B20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihCP7-0003vO-Nk
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 07:56:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1ihCMV-0000OT-2q
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 07:54:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1ihCMT-0001DP-U5
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 07:54:03 -0500
Received: from mga18.intel.com ([134.134.136.126]:49321)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1ihCMT-0000yr-Ka
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 07:54:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Dec 2019 04:53:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; d="scan'208";a="209689609"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by orsmga008.jf.intel.com with ESMTP; 17 Dec 2019 04:53:52 -0800
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>
Subject: [PATCH V4 0/5] Introduce Advanced Watch Dog module
Date: Tue, 17 Dec 2019 20:45:49 +0800
Message-Id: <20191217124554.30818-1-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
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
Cc: Zhang Chen <chen.zhang@intel.com>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

Advanced Watch Dog is an universal monitoring module on VMM side, it can be used
to detect network down(VMM to guest, VMM to VMM, VMM to another remote server)
and do previously set operation. Current AWD patch just accept any input as the
signal to refresh the watchdog timer, and we can also make a certain interactive
protocol here. For the outputs, user can pre-write some command or some messages
in the AWD opt-script. We noticed that there is no way for VMM communicate
directly, maybe some people think we don't need such things(up layer
software like openstack can handle it). so we engaged with real customer found
that they need a lightweight and efficient mechanism to solve some practical problems,

For example Edge Computing cases(they think high level software is too heavy
to use in Edge or it is hard to manage and combine with VM instance).
It make user have basic VM/Host network monitoring tools and basic false
tolerance and recovery solution..

Please see the detail documentation in the last patch.

V4:
 - Add more introduction in qemu-options.hx
 - Addressed Paolo's comments add docs/awd.txt for the AWD module detail.

V3:
 - Rebased on Qemu 4.2.0-rc1 code.
 - Fix commit message issue.

V2:
 - Addressed Philippe comments add configure selector for AWD.

Initial:
 - Initial version.


Zhang Chen (5):
  net/awd.c: Introduce Advanced Watch Dog module framework
  net/awd.c: Initailize input/output chardev
  net/awd.c: Load advanced watch dog worker thread job
  vl.c: Make Advanced Watch Dog delayed initialization
  docs/awd.txt: Add doc to introduce Advanced WatchDog(AWD) module

 configure         |   9 +
 docs/awd.txt      |  88 +++++++++
 net/Makefile.objs |   1 +
 net/awd.c         | 491 ++++++++++++++++++++++++++++++++++++++++++++++
 qemu-options.hx   |  20 ++
 vl.c              |   7 +
 6 files changed, 616 insertions(+)
 create mode 100644 docs/awd.txt
 create mode 100644 net/awd.c

-- 
2.17.1


