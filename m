Received: from eggs.gnu.org ([2001:4830:134:3::10]:48696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gYzhj-00005K-JZ
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 15:41:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gYzTa-0005FA-IM
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 15:26:58 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:45310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1gYzTa-0005By-2M
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 15:26:54 -0500
Received: from localhost (unknown [127.0.0.1])
	by mta-01.yadro.com (Postfix) with ESMTP id E67C34193F
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 20:26:50 +0000 (UTC)
Received: from mta-01.yadro.com ([127.0.0.1])
	by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NTwVaPT72DsL for <qemu-devel@nongnu.org>;
	Mon, 17 Dec 2018 23:26:50 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
	[172.17.10.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by mta-01.yadro.com (Postfix) with ESMTPS id 174674193A
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 23:26:49 +0300 (MSK)
From: Roman Bolshakov <r.bolshakov@yadro.com>
Date: Mon, 17 Dec 2018 23:26:00 +0300
Message-ID: <20181217202602.31113-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 0/2] Improve qemu-thread support on macOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <r.bolshakov@yadro.com>

Hello,

I've hit a case where QEMU hangs not responding to anything except
SIGKILL. It turned out to be a SIGSEGV in vCPU thread that was lost by
masking all signals.

By blocking too many signals QEMU relies on undefined behaviour that
seems to work on Linux. It's documented in POSIX reference and
sigprocmask(2). Indeed signalfd(2) on Linux notes that it can't be used
to receive SIGSEGV and SIGFPE.

It's not clear what do with SIGBUS on macOS. We can't blindly unblock it
as it's used for memory preallocation.

Also the RFC adds support for thread naming on macOS. Some threads
(signalfd_compat and rcu_call) are created before debug-threads=3Don is
parsed and don't get their names though.

Thank you,
Roman

Roman Bolshakov (2):
  util: Implement debug-threads for macOS
  qemu-thread: Don't block SEGV, ILL and FPE

 configure                | 32 ++++++++++++++++++++++++++------
 qemu-options.hx          |  4 ++--
 util/qemu-thread-posix.c | 11 ++++++++++-
 3 files changed, 38 insertions(+), 9 deletions(-)

--=20
2.19.1
