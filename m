Received: from eggs.gnu.org ([2001:4830:134:3::10]:41393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dk2Db-00064w-DJ
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 01:59:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dk2DY-0005Tt-As
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 01:59:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dk2DY-0005TO-2d
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 01:59:12 -0400
Date: Tue, 22 Aug 2017 13:59:03 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170822055903.GF30356@pxdev.xzpeter.org>
References: <1503301464-27886-1-git-send-email-peterx@redhat.com>
	<20170821085851.GA4371@lemon>
	<20170821100555.GC30356@pxdev.xzpeter.org>
	<20170821135743.GC4371@lemon> <20170821153622.GG2231@work-vm>
	<20170821165450.GE4371@lemon> <20170821172852.GA3236@work-vm>
	<20170822021556.GA2146@lemon>
	<20170822025654.GE30356@pxdev.xzpeter.org>
	<20170822041519.GC2146@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170822041519.GC2146@lemon>
Subject: Re: [Qemu-devel] [RFC 0/6] monitor: allow per-monitor thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Aug 22, 2017 at 12:15:19PM +0800, Fam Zheng wrote:
> On Tue, 08/22 10:56, Peter Xu wrote:
> > I haven't really encountered (c), but I think it's the migrate_cancel
> > command that matters, which should not need BQL as well.
> 
> There is bdrv_invalidate_cache_all() in migrate_cancel which clearly isn't safe.
> Is that if block unreachable in this case? If so we should assert, otherwise
> this command is not okay to run without BQL.

Ah. I see.  Even if so, if that is the only usage of BQL, IMHO we can
still mark migrate_cancel as "without-bql=true", instead we take the
BQL before calling bdrv_invalidate_cache_all().  Then migrate_cancel
can be BQL-free at least when block migration is not active.

> 
> Generically, what guarantee the thread-safety of a qmp command when you decide
> BQL is not needed? In other words, how do you prove commands are safe without
> BQL? I think almost every command accesses global state, but lock-free data
> structures are rare AFAICT.

I would suggest we split the problem into at least three parts.  IMHO
we need to answer below questions one by one to know what we should do
next:

1. whether we can handle monitor commands outside iothread, or say, in
   an isolated thread?

   This is basically what patch 2 does, the "per-monitor threads".

   IMHO this is the very first question to ask.  So now I know that at
   least current code cannot do it.  We need to at least do something
   to remove/replace the assertion to make this happen.  Can we?  I
   don't really know the answer yet.  If this is undoable, we can skip
   question 2/3 below and may need to rethink on how to solve the
   problem that postcopy recovery encounters.

2. whether there is any monitor commands can run without BQL?

   This is basically what patch 3/5 does, one for QMP, one for HMP.

   If we can settle question 1, then we can possibly start consider
   this question.  This step does not really allow any command to run
   without BQL, but we need to know whether it's possible in general,
   and if possible, we provide a framework to allow QMP/HMP developers
   to specify that.  If you see patch 3/5, the default behavior is
   still taking the BQL for all commands.

   IMHO doing this whole thing is generally good in the sense that
   this is actually forcing ourselves to break the BQL into smaller
   locks.  Take the migration commands for example: migrate_incoming
   do not need BQL, and when we write codes around it we know that we
   don't need to think about thread-safety.  That's not good IMHO.  I
   think it's time we should start consider thread-safety always.
   Again, for migrate_incoming to do this, actually we'll possibly at
   least need a migration management lock (the smaller lock) to make
   sure e.g. the user is not running two migrate_incoming commands in
   parallel (after per-monitor threads, it can happen).  But it's
   better than BQL, because BQL is for sure too big, so even a guest
   page access (as long as it held the BQL) can block migration
   commands.

3. which monitor commands can be run without BQL?

   This is what patch 4/6 was doing.  It tries to move
   migrate_incoming command out as the first candidate BQL-free
   command.

   Yes it's hard to say which command can be run without BQL.  So we
   need to investigate, possibly modify existing codes to make sure
   it's thread-safe, prove validity, then we can add the new ones into
   the BQL-free list.

   If after evaluating the pros and cons, we found that one command
   can be put into BQL-free but not worth the time for working on it,
   we can also keep those commands under BQL.

I assume question 3 is the one you were asking, and I'd say we may
need to solve question 1/2 first.  If we are done with 1/2, we just
need to spend time on each command to prove whether it is doable to
let that command run without BQL, and whether it worths itself to move
the command out of BQL.  Then we decide.  Thanks,

-- 
Peter Xu
