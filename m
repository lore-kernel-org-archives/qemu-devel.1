Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D543AC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 13:55:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7A7F21E6E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 13:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A7F21E6E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvMPO-0001Uf-UO
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 09:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60796)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dion@linutronix.de>) id 1hvMLi-0006Ni-OQ
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:51:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dion@linutronix.de>) id 1hvMLh-0000wf-Tv
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:51:30 -0400
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1]:42931)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dion@linutronix.de>) id 1hvMLh-0000ns-OM
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:51:29 -0400
Received: from [5.158.153.55] (helo=clara.guests.linutronix.de)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.80) (envelope-from <dion@linutronix.de>)
 id 1hvMLX-0002b2-Ap; Wed, 07 Aug 2019 15:51:19 +0200
From: dion@linutronix.de
To: qemu-devel@nongnu.org
Date: Wed,  7 Aug 2019 15:54:57 +0200
Message-Id: <20190807135458.32440-1-dion@linutronix.de>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 2a0a:51c0:0:12e:550::1
X-Mailman-Approved-At: Wed, 07 Aug 2019 09:54:14 -0400
Subject: [Qemu-devel] [PATCH 0/1] Handle /proc/self/exe in execve
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
Cc: Olivier Dion <dion@linutronix.de>, john.ogness@linutronix.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Olivier Dion <dion@linutronix.de>

When the emulated process try to execve itself through /proc/self/exe,
QEMU user will be executed instead of the process.

The following short program demonstrated that:
----------------------------------------------------------------------
#include <stdio.h>
#include <string.h>
#include <unistd.h>


static char *ARGV0 = "STOP";
static char *ARGV1 = "-this-is-not-an-option";


int main(int argc, char *argv[], char *environ[])
{
        (void)argc;
        if (strcmp(argv[0], ARGV0) == 0)
                return 0;
        argv[0] = ARGV0;
        argv[1] = ARGV1;
        execve("/proc/self/exe", (char **const)argv,
               (char **const)environ);
        perror("execve");
        return 1;
}
----------------------------------------------------------------------

Will output:
----------------------------------------------------------------------
qemu: unknown option 'this-is-not-an-option'
----------------------------------------------------------------------

Olivier Dion (1):
  linux-user:  Handle /proc/self/exe in syscall execve

 linux-user/syscall.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

-- 
2.22.0


