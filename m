Received: from eggs.gnu.org ([2001:4830:134:3::10]:35717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <steven.seeger@flightsystems.net>) id 1eglIW-0003Dc-Ql
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 00:51:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <steven.seeger@flightsystems.net>) id 1eglIT-0007BF-NS
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 00:51:04 -0500
Received: from p3plsmtpa12-09.prod.phx3.secureserver.net
	([68.178.252.238]:39584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <steven.seeger@flightsystems.net>)
	id 1eglIT-0007AU-H9
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 00:51:01 -0500
From: Steven Seeger <steven.seeger@flightsystems.net>
Reply-To: steven.seeger@flightsystems.net
Date: Wed, 31 Jan 2018 00:50:57 -0500
Message-ID: <1811748.Ax3oce7GDK@wirbelwind>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: [Qemu-devel] deterministic qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

I wanted to update the list on my progress and a follow-up of the "ppc and 
icount" thread.

The issue I was seeing is the case where an io memory write triggers a timer 
value to be set. In single-thread TCG, timers are run in 
handle_icount_deadline() and once that's done, TBs are executed. Since cpu-
>icount_budget is 5000000 (icount==3), a timer being set to 88 microseconds 
will fire way late. This caused the tremendous slowdown I was seeing during 
the start of my binary when the vxWorks bootup banner came up. I have a simple 
fix for this (set cpu->exit_request=1 in qemu_start_warp_timer, a total hack) 
but I'm sure that's not "correct."

The other thing is -icount 3,align=on makes it run correctly assuming the host 
can keep up.

The end result is every time I run my executable I get the same virtual clock 
value for some given event. I'm very happy.

I still don't have a fix for the issue in commit 
044897ef4a22af89aecb8df509477beba0a2e0ce but I reverted it and things are 
working for me.

Steven
