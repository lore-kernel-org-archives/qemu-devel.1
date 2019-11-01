Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B858CA9ECB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 02:58:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 715D72086D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 02:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715D72086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQN8m-0006xg-FE
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 22:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1iQN6O-0004uR-Pe
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 22:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1iQN6M-00012P-SZ
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 22:55:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:16100)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1iQN6M-0000Mm-KC
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 22:55:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Oct 2019 19:55:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,253,1569308400"; d="scan'208";a="199216658"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by fmsmga008.fm.intel.com with ESMTP; 31 Oct 2019 19:55:40 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>
Subject: [PATCH V2 0/4] Introduce Advanced Watch Dog module
Date: Fri,  1 Nov 2019 10:48:46 +0800
Message-Id: <20191101024850.20808-1-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
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

Advanced Watch Dog is an universal monitoring module on VMM side, it can be used to detect network down(VMM to guest, VMM to VMM, VMM to another remote server) and do previously set operation. Current AWD patch just accept any input as the signal to refresh the watchdog timer,
and we can also make a certain interactive protocol here. For the output user can pre-write
some command or some messages in the AWD opt-script. We noticed that there is no way
for VMM communicate directly, maybe some people think we don't need such things(up layer
software like openstack can handle it). But we engaged with real customer found that in some cases,they need a lightweight and efficient mechanism to solve some practical problems(openstack is too heavy).
for example: When it detects lost connection with the paired node,it will send message to admin, notify another VMM, send qmp command to qemu do some operation like restart the VM, build VMM heartbeat system, etc.
It make user have basic VM/Host network monitoring tools and basic false tolerance and recovery solution.

Demo usage(for COLO heartbeat service):

In primary node:

-chardev socket,id=h1,host=3.3.3.3,port=9009,server,nowait
-chardev socket,id=heartbeat0,host=3.3.3.3,port=4445
-object iothread,id=iothread2
-object advanced-watchdog,id=heart1,server=on,awd_node=h1,notification_node=heartbeat0,opt_script=colo_opt_script_path,iothread=iothread1,pulse_interval=1000,timeout=5000

In secondary node:

-monitor tcp::4445,server,nowait
-chardev socket,id=h1,host=3.3.3.3,port=9009,reconnect=1
-chardev socket,id=heart1,host=3.3.3.8,port=4445
-object iothread,id=iothread1
-object advanced-watchdog,id=heart1,server=off,awd_node=h1,notification_node=heart1,opt_script=colo_secondary_opt_script,iothread=iothread1,timeout=10000


V2:
 - Addressed Philippe comments add configure selector for AWD.

Initial:
 - Initial version.

Zhang Chen (4):
  net/awd.c: Introduce Advanced Watch Dog module framework
  net/awd.c: Initailize input/output chardev
  net/awd.c: Load advanced watch dog worker thread job
  vl.c: Make Advanced Watch Dog delayed initialization

 configure         |   9 +
 net/Makefile.objs |   1 +
 net/awd.c         | 491 ++++++++++++++++++++++++++++++++++++++++++++++
 qemu-options.hx   |   6 +
 vl.c              |   7 +
 5 files changed, 514 insertions(+)
 create mode 100644 net/awd.c

-- 
2.17.1


