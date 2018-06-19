Received: from eggs.gnu.org ([2001:4830:134:3::10]:52677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fVMSV-0001hd-Co
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 15:38:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fVMSU-0002sz-IE
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 15:38:31 -0400
Received: from mail-qt0-x229.google.com ([2607:f8b0:400d:c0d::229]:43395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1fVMSU-0002s6-B3
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 15:38:30 -0400
Received: by mail-qt0-x229.google.com with SMTP id y89-v6so858493qtd.10
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 12:38:29 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Tue, 19 Jun 2018 16:38:00 -0300
Message-Id: <20180619193806.17419-1-danielhb413@gmail.com>
Subject: [Qemu-devel] [PATCH v1 0/6] QGA: systemd
 hibernate/suspend/hybrid-sleep
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, mdroth@linux.vnet.ibm.com, Daniel Henrique Barboza <danielhb413@gmail.com>

This series adds systemd suspend support for QGA. Some newer
guests don't have pmutils anymore, leaving us with just the
Linux state file mechanism to suspend the guest OS, which does
not support hybrid-sleep. With this implementation, QGA is
now able to hybrid suspend newer guests again.

Most of the patches are cleanups in the existing suspend code,
aiming at both simplifying it and making it easier to extend
it with systemd.


Note: checkpatch.pl complains about patch 3:

ERROR: "(foo* const*)" should be "(foo * const*)"
#94: FILE: qga/commands-posix.c:1467:
+        execve(cmd_path, (char* const*)command, environ);

ERROR: space required before that '*' (ctx:VxB)
#94: FILE: qga/commands-posix.c:1467:
+        execve(cmd_path, (char* const*)command, environ);


Not sure how to make it know that this is a cast instead
of a math operation. Suggestions welcome

Daniel Henrique Barboza (6):
  qga: refactoring qmp_guest_suspend_* functions
  qga: bios_supports_mode: decoupling pm-utils and sys logic
  qga: guest_suspend: decoupling pm-utils and sys logic
  qga: removing switch statements, adding run_process_child
  qga: adding systemd hibernate/suspend/hybrid-sleep support
  qga: removing bios_supports_mode

 qga/commands-posix.c | 315 ++++++++++++++++++++++++++++---------------
 1 file changed, 210 insertions(+), 105 deletions(-)

-- 
2.17.1
