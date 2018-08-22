Received: from eggs.gnu.org ([2001:4830:134:3::10]:54668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fsXKN-0001FC-6H
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 13:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fsXDr-0006n1-W2
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 13:47:17 -0400
Date: Wed, 22 Aug 2018 11:47:09 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180822114709.1710d6c5@t450s.home>
In-Reply-To: <482037fb-60d0-eb3b-a798-4ce5f478bd69@de.ibm.com>
References: <153452552631.13804.12031418293966530953.stgit@gimli.home>
	<153452570408.13804.6971118770752634964.stgit@gimli.home>
	<482037fb-60d0-eb3b-a798-4ce5f478bd69@de.ibm.com>
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
Cc: qemu-devel@nongnu.org, qemu-s390x <qemu-s390x@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

On Wed, 22 Aug 2018 17:56:12 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> This breaks qemu-io test for me.
> 
> #0  0x000003ff98f3e2d4 in raise () at /lib64/libc.so.6
> #1  0x000003ff98f239a8 in abort () at /lib64/libc.so.6
> #2  0x000003ff98f3632e in __assert_fail_base () at /lib64/libc.so.6
> #3  0x000003ff98f363ac in  () at /lib64/libc.so.6
> #4  0x000000000108301a in qemu_balloon_inhibit (state=state@entry=false) at /home/cborntra/REPOS/qemu/balloon.c:56
> #5  0x00000000012026f2 in postcopy_ram_incoming_cleanup (mis=mis@entry=0x163bc5c0) at /home/cborntra/REPOS/qemu/migration/postcopy-ram.c:542
> #6  0x00000000011eed5e in process_incoming_migration_co (opaque=<optimized out>) at /home/cborntra/REPOS/qemu/migration/migration.c:407
> #7  0x0000000001374000 in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at /home/cborntra/REPOS/qemu/util/coroutine-ucontext.c:116
> #8  0x000003ff98f53c02 in __makecontext_ret () at /lib64/libc.so.6
> 
> Cant see right now whats wrong.

I'd have to guess it's the assert added to verify increments and
decrements are balanced, which suggests postcopy is de-inhibiting more
than it's inhibiting :-\  Thanks,

Alex
