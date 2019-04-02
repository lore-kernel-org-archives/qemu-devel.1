Received: from eggs.gnu.org ([209.51.188.92]:52921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBF8T-0000yw-4H
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 04:51:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBF8Q-00061n-E0
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 04:51:13 -0400
Date: Tue, 2 Apr 2019 10:50:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190402085047.GB5352@localhost.localdomain>
References: <2fc10494-0f79-8d18-610d-be21cfc6c30b@redhat.com>
	<87ftr5iy8i.fsf@dusky.pond.sub.org>
	<c233c2b4-5257-2df7-3c1a-06bcf269d657@redhat.com>
	<20190329170439.GK5081@localhost.localdomain>
	<87o95sa40r.fsf@dusky.pond.sub.org>
	<87y34v42z0.fsf_-_@dusky.pond.sub.org>
	<20190401122054.GA2686@andariel.pipo.sk>
	<87mul9n5ah.fsf@dusky.pond.sub.org>
	<20190401160755.GB2686@andariel.pipo.sk>
	<87a7h9lmp6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7h9lmp6.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] Options for 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, stefanha@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

Am 01.04.2019 um 18:22 hat Markus Armbruster geschrieben:
> Peter Krempa <pkrempa@redhat.com> writes:
> > On Mon, Apr 01, 2019 at 16:55:50 +0200, Markus Armbruster wrote:
> >> Peter Krempa <pkrempa@redhat.com> writes:
> >> > That works with -drive as qemu reopens the files internally, but does
> >> > not work when using -blockdev.
> >> 
> >> Happy to take your word for it.

The difference is actually not -blockdev vs. -drive, but whether you
define the 'file' node separately in its own -blockdev option or whether
you create it in the context of the format node (using file.* dotted
syntax for its options).

Effectively this doesn't change what Peter says because -drive only
supports the latter, and for -blockdev we only want to use the former.

> >> > Since we need to keep the images RO until doing  the blockjob there
> >> > needs to be a way when either qemu automagically does what libvirt needs
> >> > even if the image did not have the write permission originally.
> >> >
> >> > auto-read-only was a naive impl when qemu attempted to keep the storage
> >> > access nodes RW. At the point when I was testing it I didn't enable
> >> > s-virt as it's a hassle when you want to run git versions of libvirt and
> >> > qemu and thus didn't see the problem with missing permissions.
> >> 
> >> Yes, fallback read-only is useless for the scenario above.
> >> 
> >> Kevin wrote "libvirt requires dynamic read-only for file-posix. It
> >> prefers dynamic read-only for other drivers, but can live with fallback
> >> read-only there."  I'm not sure how it can live with fallback read-only.
> >> Is it because only *files* can labelled with SELinux?
> >> 
> >> If yes, then my next question is how libvirt makes use of fallback
> >> read-only for non-files.  Can you give me an example?
> >
> > For non-files libvirt usually does not have means to modify the access
> > permissions.
> >
> > A simple example may be a NBD export. If the NBD server exports the
> > image readonly libvirt can't do much about it. Arguably you can consider
> > a situation where the user modifies the access to read-write manually
> > and then invokes the libvirt virDomainBlockCommit API and thus still
> > expects the automagic reopen to happen correctly. At this point I'm not
> > really certain to which extend this would work currently with -drive as
> > there are known issues when attempting to point to a non-file image by
> > path rather than node-name.
> 
> Both automagic reopen and explicit reopen work here.  Both succeed when
> the user has granted access manually.  Libvirt would have to try the
> explicit reopen even in cases where it can't grant access itself.
> 
> Sounds like you don't have a use case for fallback read-only.  Correct?

If everything supports dynamic read-only, I don't think anyone would
have a use for fallback read-only. The long-term vision was that we
would remove the read-only option and add a new force-read-only option
that would allow selecting between "force read-only" and "do whatever is
needed to support what the attached parents requested". This should be
all we really need. I don't think there is even a use case for a hard
read-write option.

It's just that dynamic read-only is a bit harder to implement, so we
started with fallback read-only as "good enough for libvirt" (seemingly,
turned out to be wrong for file-posix).

The definition of the option was kept intentionally vague so that it
would allow switching to dynamic read-only. The idea was that it only
turns an error into working cases, so we can safely do the switch and
libvirt would automatically be upgraded from an error case to a working
case, too.

Of course, in this reasoning we forgot that libvirt might want to just
switch back to -drive in the cases that would error out instead of
actually receiving that error.

> >> > The dynamic version attempts to fix that. That is still the automagic
> >> > approach. I don't really mind also doing a hands-on approach where we'd
> >> > need to tell qemu to reopen given nodes.
> >> 
> >> Aha!  You just corrected my overly narrow idea of the solution space.
> >> 
> >> > I'm not sure what ends up being less work.
> >> 
> >> "Less work" is an important consideration.
> >> 
> >> We may be able to accept some extra work to get a saner interface.
> >> Depends on how much saner and how much extra exactly, and on who needs
> >> to do the work.
> >
> > I agree. While the 'explicit reopen' approach may be more work for
> > libvirt I'll happily accept that solution.
> 
> Would x-blockdev-reopen do?
> 
> What exactly is hold it in x-space?
> 
> I guess a specialized blockdev-set-read-only would do as well.

x-blockdev-reopen was only just added. It provides the same options as
blockdev-add, so a first estimation would be that it's roughly the same
complexity. Experience from blockdev-add tells us that getting it stable
the next release was completely unrealistic because we didn't even fully
understand the problems yet. I expect the same for x-blockdev-reopen.

Maybe what impresses you more is that x-blockdev-reopen doesn't only
change options like read-only, but also references to other nodes. So
it's the dynamic graph reconfiguration thing we've talking about for
years. This seems hard to get right in the first attempt.

But we also know a few more concrete shortcomings. For example, changing
child nodes doesn't work if iothreads are involved.

Also: Not all option that could theoretically be changed in
x-blockdev-reopen are actually supported yet. If we mark it stable
before everything is covered, we'll need some kind of schema annotations
again that describe in which version changing which option was added.
Maybe this time we'd better figure out how to do that before creating
the problem.

For blockdev-add, we decided to only mark it stable as soon as full
feature parity with -drive was achieved (except for options that we
_really_ don't want to have in QAPI).

So I'm very doubtful of marking x-blockdev-reopen stable in 4.1.

A specialised blockdev-set-read-only seems more realistic for 4.1, but
it still wouldn't solve the problem now in 4.0 and once we have a stable
blockdev-reopen, it's duplicated functionality.

Kevin
