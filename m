Received: from eggs.gnu.org ([2001:4830:134:3::10]:41526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fRL2Z-0005bC-He
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fRL2W-00057C-BM
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:19:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59436 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fRL2W-00056r-4Z
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:19:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C0A6540122A1
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 17:19:03 +0000 (UTC)
Date: Fri, 8 Jun 2018 18:18:57 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180608171857.GK2671@work-vm>
References: <20180605122636.33654-1-dgilbert@redhat.com>
	<20180605122636.33654-5-dgilbert@redhat.com>
	<20180607084933.GH750@xz-mi> <87muw6wzud.fsf@dusky.pond.sub.org>
	<20180607134529.GL2522@work-vm> <87sh5yr5pv.fsf@dusky.pond.sub.org>
	<20180607152832.GR2522@work-vm> <87sh5xom7g.fsf@dusky.pond.sub.org>
	<20180608081846.GB2671@work-vm> <87d0x1p6go.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0x1p6go.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 4/6] hmp: Add info commands for preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: imammedo@redhat.com, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>

* Markus Armbruster (armbru@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> 
> > * Markus Armbruster (armbru@redhat.com) wrote:
> >> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> >> 
> >> > * Markus Armbruster (armbru@redhat.com) wrote:
> >> >> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> >> >> 
> >> >> > * Markus Armbruster (armbru@redhat.com) wrote:
> >> >> >> Peter Xu <peterx@redhat.com> writes:
> >> >> >> 
> >> >> >> > On Tue, Jun 05, 2018 at 01:26:34PM +0100, Dr. David Alan Gilbert (git) wrote:
> >> >> >> >> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >> >> >> >> 
> >> >> >> >> Allow a bunch of the info commands to be used in preconfig.
> >> >> >> >> Could probably add most of them.
> >> >> >> >
> >> >> >> > I guess some of them may not work yet during preconfig.  E.g.:
> >> >> >> >
> >> >> >> > $ ./x86_64-softmmu/qemu-system-x86_64 -preconfig -monitor stdio
> >> >> >> > QEMU 2.12.50 monitor - type 'help' for more information
> >> >> >> > (qemu) info mtree
> >> >> >> > address-space: memory
> >> >> >> >   0000000000000000-ffffffffffffffff (prio 0, i/o): system
> >> >> >> >
> >> >> >> > address-space: I/O
> >> >> >> >   0000000000000000-000000000000ffff (prio 0, i/o): io
> >> >> >> >
> >> >> >> > But it's fine to enable that I guess.
> >> >> >> >
> >> >> >> > (Which "info" command would you want to use during preconfig?)
> >> >> >> >
> >> >> >> >> 
> >> >> >> >> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >> >> >> >
> >> >> >> > Reviewed-by: Peter Xu <peterx@redhat.com>
> >> >> >> 
> >> >> >> The reason for having -preconfig is us despairing of making -S do the
> >> >> >> right thing.  We'd have to *understand* the tangled mess that is our
> >> >> >> startup, and rearrange it so QMP becomes available early enough for
> >> >> >> configuring NUMA (and other things), yet late enough for everything to
> >> >> >> work.
> >> >> >> 
> >> >> >> -preconfig is a cheap hack to avoid this headache, by bypassing almost
> >> >> >> all of "everything".
> >> >> >> 
> >> >> >> Now you bring back some of "everything".  Dangerous.  You better show it
> >> >> >> actually works.  Until you do:
> >> >> >> 
> >> >> >> NAK
> >> >> >
> >> >> > Well I did test each command in here to make sure it didn't
> >> >> > crash/produce complete junk; but here's the output with the v2 of this
> >> >> > patch that Igor R-b:
> >> >> [...]
> >> >> 
> >> >> For the sake of the argument, let's assume these commands all work in
> >> >> preconfig state.  Are their QMP equivalents all available in preconfig
> >> >> state?
> >> >
> >> > That I don't know; I was happy to fix my list to the ones
> >> > Igor recommended.  If you object to some particular entries I'll
> >> > be happy to change them.
> >> 
> >> HMP must not provide more functionality than QMP.  Specifically, we may
> >> provide "info FOO" only when we also provide query-FOO.
> >>
> >> There are exceptions to this rule.  I don't think they apply here.  I'm
> >> prepared to discuss them, of course.
> >
> > No, that's strictly not true;  HMP can provide anything that helps
> > a human debug stuff.
> 
> Yes, but...
> 
> >                       The requirement is that if a tool needs it then it
> > must be provided in QMP.
> 
> ... it must not do that at the expense of QMP's completeness.
> Permitting that would be a break from how we worked since QMP became
> supported in 0.14 or so.  Seven years, time flies.
> 
> The hard requirement for QMP from day one was "provide everything
> machine clients need".  To avoid speculation and endless arguments about
> what might be needed / not needed, we resolved to approximate this by
> "provide everything, except stuff that's *clearly* of no use to
> machines".  This has been spelled out on this list several times.
> Here are two relatively recent iterations:
> 
> Message-ID: <8737cngvq6.fsf@dusky.pond.sub.org>
> https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05309.html
> 
> Message-ID: <8760hrxtcn.fsf@dusky.pond.sub.org>
> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg00247.html
> 
> Quoting the latter:
> 
> In general, functionality available in HMP should also available in QMP.
> Exceptions include functionality that makes no sense in QMP, or is of
> use only for human users.  If you think your command is an exception,
> please explain why in the commit message.
> 
> If it isn't, you need to implement it for QMP (including suitable test
> cases), then rewrite the HMP version to reuse either the QMP command or
> a common core.
> 
> Example for "makes no sense in QMP": setting the current CPU[1], because
> a QMP monitor doesn't have a current CPU.
> 
> Examples for "is of use only for human users": HMP command "help", the
> integrated pocket calculator[2].
> 
> End quote.
> 
> But we're not even arguing about a new HMP command, we're arguing about
> making existing commands available in preconfig state.  I assume that if
> an HMP command is useful in preconfig state, then its QMP buddy is also
> useful there.  I therefore asked you whether their QMP equivalents are
> all available in preconfig state.  The answer I expected was a short
> table of three columns: HMP command you propose to enable, QMP buddy if
> any, whether the QMP buddy is available in preconfig state yes/no.
> Estimated effort: minutes.  What I got instead of this data was an
> argument about fundamental design decisions.  Fine, reexaminating
> fundamentals once in a while isn't a bad idea.  But may I have my data
> now?

I believe that table is in the v3 version patch 5.

Dave

> [...]
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
