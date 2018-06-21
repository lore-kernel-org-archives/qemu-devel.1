Received: from eggs.gnu.org ([2001:4830:134:3::10]:53227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fVwjD-0002jz-Li
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fVwjC-0001dJ-L3
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:22:11 -0400
Received: from mail-qk0-x22f.google.com ([2607:f8b0:400d:c09::22f]:34584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1fVwjC-0001d6-Gd
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:22:10 -0400
Received: by mail-qk0-x22f.google.com with SMTP id q70-v6so1430066qke.1
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 03:22:10 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 21 Jun 2018 07:21:47 -0300
Message-Id: <20180621102153.28443-1-danielhb413@gmail.com>
Subject: [Qemu-devel] [PATCH v2 0/6] QGA: systemd
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
Cc: mdroth@linux.vnet.ibm.com, armbru@redhat.com, marcandre.lureau@gmail.com, Daniel Henrique Barboza <danielhb413@gmail.com>

changes in v2 from Marc-Andre Lureau review:
- use error_free() accordingly
- use g_spawn_sync() instead of fork() in run_process_child()
- previous version link:
https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg05499.html


This series adds systemd suspend support for QGA. Some newer
guests don't have pmutils anymore, leaving us with just the
Linux state file mechanism to suspend the guest OS, which does
not support hybrid-sleep. With this implementation, QGA is
now able to hybrid suspend newer guests again.

Most of the patches are cleanups in the existing suspend code,
aiming at both simplifying it and making it easier to extend
it with systemd.


Daniel Henrique Barboza (6):
  qga: refactoring qmp_guest_suspend_* functions
  qga: bios_supports_mode: decoupling pm-utils and sys logic
  qga: guest_suspend: decoupling pm-utils and sys logic
  qga: removing switch statements, adding run_process_child
  qga: systemd hibernate/suspend/hybrid-sleep support
  qga: removing bios_supports_mode

 qga/commands-posix.c | 316 ++++++++++++++++++++++++++++---------------
 1 file changed, 208 insertions(+), 108 deletions(-)

-- 
2.17.1
