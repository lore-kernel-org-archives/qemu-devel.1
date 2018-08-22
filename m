Received: from eggs.gnu.org ([2001:4830:134:3::10]:43655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fsYO0-0000L4-Ua
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 15:01:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fsYNx-00044K-MC
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 15:01:44 -0400
Date: Wed, 22 Aug 2018 13:01:39 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180822130139.60db0cc1@t450s.home>
In-Reply-To: <20180822114709.1710d6c5@t450s.home>
References: <153452552631.13804.12031418293966530953.stgit@gimli.home>
	<153452570408.13804.6971118770752634964.stgit@gimli.home>
	<482037fb-60d0-eb3b-a798-4ce5f478bd69@de.ibm.com>
	<20180822114709.1710d6c5@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 1/4] balloon: Allow multiple inhibit users
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x <qemu-s390x@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Wed, 22 Aug 2018 11:47:09 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Wed, 22 Aug 2018 17:56:12 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
> > This breaks qemu-io test for me.
> > 
> > #0  0x000003ff98f3e2d4 in raise () at /lib64/libc.so.6
> > #1  0x000003ff98f239a8 in abort () at /lib64/libc.so.6
> > #2  0x000003ff98f3632e in __assert_fail_base () at /lib64/libc.so.6
> > #3  0x000003ff98f363ac in  () at /lib64/libc.so.6
> > #4  0x000000000108301a in qemu_balloon_inhibit (state=state@entry=false) at /home/cborntra/REPOS/qemu/balloon.c:56
> > #5  0x00000000012026f2 in postcopy_ram_incoming_cleanup (mis=mis@entry=0x163bc5c0) at /home/cborntra/REPOS/qemu/migration/postcopy-ram.c:542
> > #6  0x00000000011eed5e in process_incoming_migration_co (opaque=<optimized out>) at /home/cborntra/REPOS/qemu/migration/migration.c:407
> > #7  0x0000000001374000 in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at /home/cborntra/REPOS/qemu/util/coroutine-ucontext.c:116
> > #8  0x000003ff98f53c02 in __makecontext_ret () at /lib64/libc.so.6
> > 
> > Cant see right now whats wrong.  
> 
> I'd have to guess it's the assert added to verify increments and
> decrements are balanced, which suggests postcopy is de-inhibiting more
> than it's inhibiting :-\  Thanks,

When postcopy inhibits ballooning, it does so from the migration stream
at loaddvm_process_command().  If the command is
MIG_CMD_POSTCOPY_LISTEN, this calls loadvm_postcopy_handle_listen().
If postcopy RAM is enabled, this calls postcopy_ram_enable_notify(),
which is where the balloon inhibitor is triggered.  I think the
postcopy_ram_listen_thread, which is created at the end of
loadvm_postcopy_handle_listen(), is intended to be where the inhibit
would be lifted, but I note a couple error paths before that where the
inhibit is not released.

postcopy_ram_listen_thread() calls postcopy_ram_incoming_cleanup(),
which always releases the balloon inhibit, regardless of the postcopy
RAM capability, and of course there are some error cases in advance of
this that would again leave the inhibit in place.

We also have the coroutine process_incoming_migration_co, launched from
migration_incoming_process() which seems to do a gratuitous call to
postcopy_ram_incoming_cleanup() and will release the inhibit regardless
of whether it was activated previous.

So apparently I assumed too much about the existing balloon inhibitor
use case, it's clearly not as general as the interface would lead one
to believe.  The immediate solution is probably to make a postcopy
specific wrapper around qemu_balloon_inhibit() that keeps a static
internal state to avoid over incrementing or decrementing.  That should
resolve this and then we can move on to whether we want to change the
overall internal interface or fixup some of the other cases noted
above.  Thanks,

Alex
