Received: from eggs.gnu.org ([209.51.188.92]:46689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hAzi8-0003ys-K1
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 12:23:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hAzi6-0007It-UN
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 12:23:00 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190328182810.21497-1-kwolf@redhat.com>
	<20190328182810.21497-2-kwolf@redhat.com>
	<2fc10494-0f79-8d18-610d-be21cfc6c30b@redhat.com>
	<87ftr5iy8i.fsf@dusky.pond.sub.org>
	<c233c2b4-5257-2df7-3c1a-06bcf269d657@redhat.com>
	<20190329170439.GK5081@localhost.localdomain>
	<87o95sa40r.fsf@dusky.pond.sub.org>
	<87y34v42z0.fsf_-_@dusky.pond.sub.org>
	<20190401122054.GA2686@andariel.pipo.sk>
	<87mul9n5ah.fsf@dusky.pond.sub.org>
	<20190401160755.GB2686@andariel.pipo.sk>
Date: Mon, 01 Apr 2019 18:22:45 +0200
In-Reply-To: <20190401160755.GB2686@andariel.pipo.sk> (Peter Krempa's message
	of "Mon, 1 Apr 2019 18:07:55 +0200")
Message-ID: <87a7h9lmp6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Options for 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, stefanha@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

Peter Krempa <pkrempa@redhat.com> writes:

> On Mon, Apr 01, 2019 at 16:55:50 +0200, Markus Armbruster wrote:
>> Peter Krempa <pkrempa@redhat.com> writes:
>> 
>> > On Sun, Mar 31, 2019 at 14:56:19 +0200, Markus Armbruster wrote:
>> >> Let's review our options for 4.0.
>> >> 
>> >> Please note my analysis is handicapped by incomplete information, in
>> >> particular on libvirt's needs.
>> >
>> > Libvirt's needs are "simple" we need to do block-commit. It has a few
>> > caveats though. The selinux labels for backing images don't allow write
>> > operation when starting qemu. When doing block-commit libvirt relabels
>> > the backing chain prior to using block-commit.
>> 
>> Paraphrasing, to make sure I got you.
>> 
>> Consider the common read/write COW image with a backing image.
>> 
>> Libvirt wants to grant QEMU read/write access to the COW and read-only
>> access to the backing image.  It does that with SELinux.  QEMU has to
>> open the backing image read-only (read/write would fail).
>> 
>> But libvirt also wants to do block-commit.  Libvirt first relabels to
>> grant QEMU read/write access to the backing image, then $something makes
>> QEMU reopen the backing image read/write, block-commit does its job,
>> $something makes QEMU reopen the backing image read-only, libvirt
>> relabels to revoke read/write access.
>> 
>> Correct?
>
> Yes.

Thank you.

>> With dynamic read-only, $something is the block commit job (a writer)
>> attaching and detaching to the backing image node.
>> 
>> > That works with -drive as qemu reopens the files internally, but does
>> > not work when using -blockdev.
>> 
>> Happy to take your word for it.
>> 
>> > Since we need to keep the images RO until doing  the blockjob there
>> > needs to be a way when either qemu automagically does what libvirt needs
>> > even if the image did not have the write permission originally.
>> >
>> > auto-read-only was a naive impl when qemu attempted to keep the storage
>> > access nodes RW. At the point when I was testing it I didn't enable
>> > s-virt as it's a hassle when you want to run git versions of libvirt and
>> > qemu and thus didn't see the problem with missing permissions.
>> 
>> Yes, fallback read-only is useless for the scenario above.
>> 
>> Kevin wrote "libvirt requires dynamic read-only for file-posix. It
>> prefers dynamic read-only for other drivers, but can live with fallback
>> read-only there."  I'm not sure how it can live with fallback read-only.
>> Is it because only *files* can labelled with SELinux?
>> 
>> If yes, then my next question is how libvirt makes use of fallback
>> read-only for non-files.  Can you give me an example?
>
> For non-files libvirt usually does not have means to modify the access
> permissions.
>
> A simple example may be a NBD export. If the NBD server exports the
> image readonly libvirt can't do much about it. Arguably you can consider
> a situation where the user modifies the access to read-write manually
> and then invokes the libvirt virDomainBlockCommit API and thus still
> expects the automagic reopen to happen correctly. At this point I'm not
> really certain to which extend this would work currently with -drive as
> there are known issues when attempting to point to a non-file image by
> path rather than node-name.

Both automagic reopen and explicit reopen work here.  Both succeed when
the user has granted access manually.  Libvirt would have to try the
explicit reopen even in cases where it can't grant access itself.

Sounds like you don't have a use case for fallback read-only.  Correct?

>> > The dynamic version attempts to fix that. That is still the automagic
>> > approach. I don't really mind also doing a hands-on approach where we'd
>> > need to tell qemu to reopen given nodes.
>> 
>> Aha!  You just corrected my overly narrow idea of the solution space.
>> 
>> > I'm not sure what ends up being less work.
>> 
>> "Less work" is an important consideration.
>> 
>> We may be able to accept some extra work to get a saner interface.
>> Depends on how much saner and how much extra exactly, and on who needs
>> to do the work.
>
> I agree. While the 'explicit reopen' approach may be more work for
> libvirt I'll happily accept that solution.

Would x-blockdev-reopen do?

What exactly is hold it in x-space?

I guess a specialized blockdev-set-read-only would do as well.

>> >> Terminology:
>> >> 
>> >> * "Hard read-write" semantics: open read/write.
>> >> 
>> >> * "Hard read-only" semantics: open read-only.
>> >> 
>> >> * "Dynamic read-only" semantics: open read-only, reopen read/write when
>> >>   a writer attaches, reopen read-only when the last writer detaches.
>
> [...]
>
>> >> * When libvirt sees a driver providing a dynamic-read-only parameter, it
>> >>   knows it can rely on the driver providing dynamic read-only semantics.
>> >> 
>> >> * Adding dynamic read-only capability to drivers creates no
>> >>   introspection problems: we simply add dynamic-read-only to their
>> >>   parameters.
>> >
>> > In the end libvirt does not care that much if the storage is open read
>> > only or read write. We need the format node or guest frontend to deny
>> > writes if the disk is declared as read-only. We also need to be able to
>> > do blockjobs. The requirement is that images may not be accessible in
>> > R/W mode when qemu is starting but later may become. Then it's expected
>> > that block-commit will succeed.
>> 
>> Fallback read-only can't help there.
>> 
>> Dynamic read-only should work.  Explicit reopen triggers could also
>> work.
>
> The explicit trigger would work. With the tighter control of blockjobs
> we should be able to control the lifecycle properly.

Good to know, thanks!
