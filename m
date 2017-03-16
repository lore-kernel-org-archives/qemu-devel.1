Received: from eggs.gnu.org ([2001:4830:134:3::10]:60570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1coXp8-0006b4-JT
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:00:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1coXp4-0007VH-Ap
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:00:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1coXp4-0007V8-2n
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:00:18 -0400
Date: Thu, 16 Mar 2017 16:00:12 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170316160012.GX15193@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
	<20170316154643.GT15193@redhat.com>
	<CAFEAcA9WdjkAr0eWNApWQGZAw4_67sci3LtY8=9pzYDcDXiLmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9WdjkAr0eWNApWQGZAw4_67sci3LtY8=9pzYDcDXiLmg@mail.gmail.com>
Subject: Re: [Qemu-devel] Proposal for deprecating unsupported host OSes &
 architecutures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, Mar 16, 2017 at 03:55:13PM +0000, Peter Maydell wrote:
> On 16 March 2017 at 15:46, Daniel P. Berrange <berrange@redhat.com> wrote:
> > On Thu, Mar 16, 2017 at 03:23:45PM +0000, Peter Maydell wrote:
> >> OK, here's a concrete proposal for deprecating/dropping out of
> >> date host OS and architecture support.
> >>
> >> We'll put this in the ChangeLog 'Future incompatible changes'
> >> section:
> >> -----
> >> * Removal of support for untested host OS and architectures:
> >>
> >> The QEMU Project intends to drop support in a future release for any
> >> host OS or architecture which we do not have access to a build and test
> >> machine for. This affects the following host OSes:
> >>  * Native CYGWIN building
> >>  * GNU/kFreeBSD
> >>  * FreeBSD
> >>  * DragonFly BSD
> >>  * NetBSD
> >>  * OpenBSD
> >>  * Solaris
> >>  * AIX
> >>  * Haiku
> >> and the following host CPU architectures:
> >>  * ia64
> >>  * sparc
> >>
> >> Specifically, if we do not have a build and test system available
> >> to us by the time we release QEMU 2.10, we will remove support in the
> >> release that follows 2.10.
> >> -----
> >>
> >> I'm not sure here if we want to just have this as a bald list,
> >> or to have some kind of two tier setup with OSes we expect to
> >> dump in one tier and OSes where we're really trolling for a build
> >> machine in the other tier (the "unlikely to dump" category would
> >> get most of the BSD variants in it). Putting out a changelog
> >> that says "we're gonna drop all the BSDs" seems like it might
> >> produce a lot of yelling?
> >
> > I think it depends on the level of bit-rot we are aware of, and
> > whether we expect anyone is likely to fix the bit-rot should it
> > be discovered.
> >
> > Simply not having a build machine for QEMU CI doesn't imply that
> > it is totally broken, and even if some pieces are broken, it
> > doesn't imply that QEMU is unusable.
> 
> No, but it does imply that our CI is missing a big chunk.
> Realistically, for the BSDs where I want to get to is "we
> have BSD coverage in our CI setup". The problem at the moment
> is that we (presumably) have BSD users but we have basically
> no BSD developers active upstream, which in my view is not
> a very long-term satisfactory situation.
> 
> > IOW, I think there is a reasonable 3 tier set here
> >
> >  1. Stuff we actively test builds & thus guarantee will work for
> >     any QEMU release going forward.
> >
> >  2. Stuff we don't actively test, but generally assume is mostly
> >     working, and likely to be fixed if & when problems are found
> >
> >  3. Stuff we don't actively test,  assume is probably broken
> >     and unlikely to be fixed if reported
> >
> > Stuff in tier 3 should be candidate for deletion. Stuff in tier
> > 2 shouldn't be removed, but it might drop into tier 3 at some
> > point if people stop caring about fixing problems when found.
> > Conversely tier 2 might rise to tier 1 if CI turns up.
> 
> I don't really want a tier 2. Either we support it enough
> to at least be able to run "make && make check" on some
> representative system, or we don't support it at all.
> Code which we have but are really reluctant to touch because
> we don't even test it builds (like bsd-user/) is really bad
> for preventing cleanups.

IMHO we should not be afraid of cleaning up code in such cases.
If bsd-user accidentally breaks because we clean up some other
parts of QEMU, so be it. If someone cares they'll step forward,
if not, it'll be a sign that it its material for tier 3 & thus
eventual removal.

I'm just pretty wary of gratuitously deleting stuff that still
has a reasonable chance of being functional, simply because
we lack CI testing.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
