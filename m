Received: from eggs.gnu.org ([209.51.188.92]:44690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ghYiL-0002TO-MH
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 06:41:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ghYiJ-0000Vl-RH
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 06:41:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ghYiI-00005L-19
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 06:41:31 -0500
Date: Thu, 10 Jan 2019 11:41:13 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190110114113.GC2589@work-vm>
References: <20180906111107.30684-1-danielhb413@gmail.com>
	<47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
	<a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
	<200ecea3-1ef4-3ecf-6b37-f6e45fef3849@redhat.com>
	<20190109172023.GK4867@localhost.localdomain>
	<be8ac551-4cfd-db62-aa3d-0ca9b79e3e4f@redhat.com>
	<40ef0a8d-3a25-4cc3-95f8-82bc4513776c@redhat.com>
	<20190109185154.GL4867@localhost.localdomain>
	<56880d06-a214-2486-2e80-c565b33461b3@redhat.com>
	<20190110112508.GA6361@linux.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110112508.GA6361@linux.fritz.box>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use
 ID anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, armbru@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org, muriloo@linux.ibm.com

* Kevin Wolf (kwolf@redhat.com) wrote:
> Am 09.01.2019 um 20:02 hat Eric Blake geschrieben:
> > On 1/9/19 12:51 PM, Kevin Wolf wrote:
> > 
> > >> Indeed, and libvirt IS using 'savevm' via HMP via QMP's
> > >> human-monitor-command, since there is no QMP counterpart for internal
> > >> snapshot.  Even though lately we consistently tell people that internal
> > >> snapshots are underdeveloped and you should use external snapshots, it
> > >> does not get away from the fact that libvirt has been using 'savevm' to
> > >> drive internal snapshots for years now, and that we MUST consider
> > >> back-compat and/or add an introspectible QMP interface before making
> > >> changes that would break libvirt.
> > > 
> > > Okay, so what does libvirt do when you request a snapshot with a
> > > numerical name? Without having looked at the code, the best case I would
> > > expect that it forbids them, and more realistically I suspect that we
> > > may actually fix a bug for libvirt by changing the semantics.
> > > 
> > > Or does libvirt really use snapshot IDs rather than names?
> > 
> > At the moment, libvirt does not place any restriction on internal
> > snapshot names, but passes the user's name through without thought of
> > whether it is an id or a name.
> > 
> > So yes, arguably tightening the semantics fixes a libvirt bug for
> > libvirt having allowed internal snapshots to get into an inconsistent
> > state.
> 
> So there are two scenarios to consider with respect to breaking
> backwards compatibility:
> 
> 1. There may be code out there that relies on numeric arguments being
>    interpreted as IDs. This code will break if we make this change and
>    numeric snapshot names exist. That such code exists is speculation
>    (even though plausible) and we don't know how widespread it is.
> 
> 2. There may be code out there that blindly assumes that whatever it
>    passes is interpreted as a name. Nobody considered that with a
>    numeric snapshot name, it maybe misinterpreted as an ID. We know that
>    this is true for libvirt, the single most used management tool for
>    QEMU. More code like this may (and probably does) exist.
> 
> Essentially the same two categories exist for human users: those who
> somehow found out that QEMU accepts IDs as monitor command arguments and
> are using those (mitigated by not displaying IDs any more), and those
> who are trapped because they wanted to access a numeric name, but
> surprisingly got it interpreted as an ID. Both are speculation to some
> degree, but my guess is that the latter group is larger.
> 
> Given all this, this is a no-brainer for me. We simplify the interface,
> we simplify the code, we make things less confusing for manual users and
> we fix the management tool that everybody uses. How could we not make
> this change?
> 
> > But again, it falls in the category of "properly fixing this
> > requires a lot of auditing, time, mental power, and unit tests", which
> > makes it a rather daunting task to state for certain.
> 
> Fix the world before we can fix anything?

Can't we break this loop for the savevm command fairly easily; it's
currently documnted as:

savevm [tag|id] 

If we made that:

savevm [-t] [-i] [tag|id]

then:
  a) with neither -t or -i  it would behave in the same roulette way
     as it does in the moment, and it might be a tag or id

  b) with -t we'd explicitly treat the parameter as a tag and it
     would error if it wasn't found

  c) With -i we'd explicitly treat the parameter as an id and
     it would error if it wasn't found

Since we still allow (a) it doesn't break any existing code.

Dave


> Kevin


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
