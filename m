Received: from eggs.gnu.org ([2001:4830:134:3::10]:56433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1coXc5-0001tQ-Bx
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 11:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1coXc2-0001iV-5n
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 11:46:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1coXc1-0001gm-UK
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 11:46:50 -0400
Date: Thu, 16 Mar 2017 15:46:43 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170316154643.GT15193@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
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

On Thu, Mar 16, 2017 at 03:23:45PM +0000, Peter Maydell wrote:
> OK, here's a concrete proposal for deprecating/dropping out of
> date host OS and architecture support.
> 
> We'll put this in the ChangeLog 'Future incompatible changes'
> section:
> -----
> * Removal of support for untested host OS and architectures:
> 
> The QEMU Project intends to drop support in a future release for any
> host OS or architecture which we do not have access to a build and test
> machine for. This affects the following host OSes:
>  * Native CYGWIN building
>  * GNU/kFreeBSD
>  * FreeBSD
>  * DragonFly BSD
>  * NetBSD
>  * OpenBSD
>  * Solaris
>  * AIX
>  * Haiku
> and the following host CPU architectures:
>  * ia64
>  * sparc
> 
> Specifically, if we do not have a build and test system available
> to us by the time we release QEMU 2.10, we will remove support in the
> release that follows 2.10.
> -----
> 
> I'm not sure here if we want to just have this as a bald list,
> or to have some kind of two tier setup with OSes we expect to
> dump in one tier and OSes where we're really trolling for a build
> machine in the other tier (the "unlikely to dump" category would
> get most of the BSD variants in it). Putting out a changelog
> that says "we're gonna drop all the BSDs" seems like it might
> produce a lot of yelling?

I think it depends on the level of bit-rot we are aware of, and
whether we expect anyone is likely to fix the bit-rot should it
be discovered.

Simply not having a build machine for QEMU CI doesn't imply that
it is totally broken, and even if some pieces are broken, it
doesn't imply that QEMU is unusable.

e.g. if (hypothetically) QEMU fails to build when GNUTLS is enabled
on FreeBSD, that doesn't mean QEMU is unusable on FreeBSD - you
simply can't enable GNUTLS on that platform. If such breakage were
discovered, then I would also strive to fix it, despite not using
FreeBSD myself regularly.

In such a case ripping out all FreeBSD conditionals from the host
would be gratuitously unpleasant to our users. It is reasonable to
expect that someone will fix FreeBSD builds if & when bit-rot is
discovered. We're simply not able to guarantee the same level of
quality as our main tested platforms, at time of release.


Now, something like ia64 or sparc is probably a different matter.
While QEMU might again still be partially usable, even if some
bits are broken on ia64, the realistic likelihood of someone
caring enough to fix the ia64 builds at this point is effectively
zero.

IOW, I think there is a reasonable 3 tier set here

 1. Stuff we actively test builds & thus guarantee will work for
    any QEMU release going forward.

 2. Stuff we don't actively test, but generally assume is mostly
    working, and likely to be fixed if & when problems are found

 3. Stuff we don't actively test,  assume is probably broken
    and unlikely to be fixed if reported

Stuff in tier 3 should be candidate for deletion. Stuff in tier
2 shouldn't be removed, but it might drop into tier 3 at some
point if people stop caring about fixing problems when found.
Conversely tier 2 might rise to tier 1 if CI turns up.

> Should "native CYGWIN" be in the drop list? I only test
> mingw cross compile, but configure has a separate section for
> CYGWIN in its $targetos case statement.

Cygwin is different enough from mingw that I'd basically call
it a completely separate platform. IOW, successfull mingw
builds don't offer a strong guarantee of a succesfull cygwin
build.

> It would also not be too difficult to make configure warn when it
> is run on the deprecated OS or architecture, so we should probably
> sneak that into 2.9.

Good idea.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
