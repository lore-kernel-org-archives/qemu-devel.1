Received: from eggs.gnu.org ([2001:4830:134:3::10]:50632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eager@eagerm.com>) id 1d50br-0004nj-37
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 21:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eager@eagerm.com>) id 1d50bo-0006V1-28
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 21:58:43 -0400
Received: from resqmta-po-11v.sys.comcast.net ([96.114.154.170]:53670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eager@eagerm.com>) id 1d50bn-0006Ul-Sg
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 21:58:39 -0400
From: Michael Eager <eager@eagerm.com>
Message-ID: <5906960F.2050305@eagerm.com>
Date: Sun, 30 Apr 2017 18:57:35 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] cpu_io_recompile, icount, and re-issued instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

I'm working with an emulation for a proprietary processor on an older QEMU source base.  It looks 
like the problem I am seeing in the old sources would still be present in the current source base.

I'm seeing incorrect values when there is a write to a memory-mapped I/O device when icount is set. 
  What I see happening is that a TB with ~20 instructions is executed which contains a write to the 
MM I/O address.  When it gets to the io_write routine, can_do_io is false, which results in a call 
to cpu_io_recompile.

cpu_io_recompile does what it (sort of) says it is supposed to do: it builds a new TB with the I/O 
instruction as the last instruction in the block, then re-issues the TB.  The problem is that the 
new TB contains the instructions before the I/O instruction, so they are executed a second time.

There is a note in cpu_io_recompile which mentions the situation where the I/O instruction is not 
the first in the TB has not been handled:

     /* TODO: If env->pc != tb->pc (i.e. the faulting instruction was not
      * the first in the TB) then we end up generating a whole new TB and
      *  repeating the fault, which is horribly inefficient.
      *  Better would be to execute just this insn uncached, or generate a
      *  second new TB.

I'm a bit unclear what this is saying.  A new TB is generated which is issued setting can_do_io, and 
which passes through io_write without a problem.  I'm not sure what fault is repeated.

It seems to me that what cpu_io_recompile should do is create a new TB with the n instructions which 
were already executed and cache it.  Then it should create a TB with only the I/O instruction, 
setting can_do_io, and re-issue this TB.

Am I understanding this correctly?

This code has been around for a long, long time.  Has anyone noticed this problem in the past?


-- 
Michael Eager	 eager@eagercon.com
1960 Park Blvd., Palo Alto, CA 94306  650-325-8077

-- 
Michael Eager	 eager@eagercon.com
1960 Park Blvd., Palo Alto, CA 94306  650-325-8077
