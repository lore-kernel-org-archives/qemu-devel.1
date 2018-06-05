Received: from eggs.gnu.org ([2001:4830:134:3::10]:36187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQCWf-0000dC-QQ
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQCWa-0002S0-8M
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:01:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37916 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fQCWa-0002Rl-3e
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:01:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 69D69402346D
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 14:01:23 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue,  5 Jun 2018 16:00:41 +0200
Message-Id: <1528207243-268226-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/2] fix -nodefaults and -daemonize
 regressions caused by --preconfig introduction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com, ldoktor@redhat.com


Commit 047f7038f586d2150f16c6d9ba9cfd0479f0f6ac broke iotests that were u=
sing
 -nodefault option, which lead to hang in the early main_loop_wait().
1/2 fixes it by not calling main_loop_wait() unless --preconfig option wa=
s on CLI.
1/2 also fixes issue where libvirt starting qemu as daemon waits on qemu =
parent
process to exit which doens't happen at the early main_loop().
2/2 fixes the same deamon issue but with --preconfig option on CLI

With this QEMU passes make check, make check-block and manual testing wit=
h
-daemonize

CC: berrange@redhat.com
CC: mreitz@redhat.com
CC: pbonzini@redhat.com
CC: ehabkost@redhat.com
CC: ldoktor@redhat.com

Igor Mammedov (2):
  cli: Don't run early event loop if no  --preconfig was specified
  vl: fix use of --daemonize with --preconfig

 os-posix.c | 6 ++++++
 vl.c       | 6 +++---
 2 files changed, 9 insertions(+), 3 deletions(-)

--=20
2.7.4
