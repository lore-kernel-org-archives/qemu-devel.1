Received: from eggs.gnu.org ([2001:4830:134:3::10]:56549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eager@eagerm.com>) id 1d5c6f-0007VE-Sw
	for qemu-devel@nongnu.org; Tue, 02 May 2017 14:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eager@eagerm.com>) id 1d5c6c-0003Ak-NB
	for qemu-devel@nongnu.org; Tue, 02 May 2017 14:01:01 -0400
Received: from resqmta-po-09v.sys.comcast.net ([96.114.154.168]:34062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eager@eagerm.com>) id 1d5c6c-00035K-Go
	for qemu-devel@nongnu.org; Tue, 02 May 2017 14:00:58 -0400
References: <5906960F.2050305@eagerm.com>
	<3a7aa06d-a419-69d7-a54a-e963d4ba748f@redhat.com>
From: Michael Eager <eager@eagerm.com>
Message-ID: <5908C911.9090908@eagerm.com>
Date: Tue, 2 May 2017 10:59:45 -0700
MIME-Version: 1.0
In-Reply-To: <3a7aa06d-a419-69d7-a54a-e963d4ba748f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] cpu_io_recompile, icount,
 and re-issued instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On 05/02/2017 12:59 AM, Paolo Bonzini wrote:
>
>
> On 01/05/2017 03:57, Michael Eager wrote:
>>
>>
>> I'm seeing incorrect values when there is a write to a memory-mapped I/O
>> device when icount is set.  What I see happening is that a TB with ~20
>> instructions is executed which contains a write to the MM I/O address.
>> When it gets to the io_write routine, can_do_io is false, which results
>> in a call to cpu_io_recompile.
>>
>> cpu_io_recompile does what it (sort of) says it is supposed to do: it
>> builds a new TB with the I/O instruction as the last instruction in the
>> block, then re-issues the TB.  The problem is that the new TB contains
>> the instructions before the I/O instruction, so they are executed a
>> second time.
>
> They shouldn't.  When called from cpu_io_recompile,
> cpu_restore_state_from_tb should compute the I/O instruction's target PC
> from the host PC (stored in retaddr).
>
> Then what happens is the following:
>
> - cpu_io_recompile generates a new TB ending with the I/O instruction.
> This new TB has a hash table conflict with the old TB (same
> PC/cs_base/flags) the old TB is implicitly removed
>
> - cpu_io_recompile calls cpu_loop_exit_noexc, which goes back to the
> execution loop with updated PC
>
> - because the PC is different, a new TB is looked up for the I/O
> instruction's PC.  The TB probably is not there and translation starts
> again, this time at the I/O instruction
>
> - the new TB, when executed, causes cpu_io_recompile to fire again.
> This is the inefficient part mentioned in cpu_io_recompile
>
> - cpu_io_recompile now compiles a one-instruction TB and goes back to
> the execution loop
>
> - finally the execution loop executes the one-instruction TB for the I/O
> instruction, then it can go on

Thanks for the explanation.

The old QEMU source base I'm working with predates the refactoring of cpu_restore_state
by a couple months (sigh).  It also doesn't have the patches which changed the argument
from env to cpu.  I tried to cherry-pick the patches but there are too many conflicts.

I patched the old code to do what I suggested: a new TB for the already executed
instructions and a TB for the I/O instruction.  It works and has the small advantage
of not requiring a second trip through cpu_io_recompile.  But it will be a merge
conflict when we (eventually) upgrade to more recent QEMU sources.


-- 
Michael Eager	 eager@eagercon.com
1960 Park Blvd., Palo Alto, CA 94306  650-325-8077
