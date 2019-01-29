Received: from eggs.gnu.org ([209.51.188.92]:56639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1goQuN-0008Iy-Px
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:46:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1goQuH-0003Vr-ET
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:46:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1goQuF-0003UG-Ar
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:46:17 -0500
Date: Tue, 29 Jan 2019 10:36:02 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190129103602.GB16847@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAFEAcA-4r8_K0=WTaK+A_KvO93ni+3==+a5FRvGTFJ3av0GPFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-4r8_K0=WTaK+A_KvO93ni+3==+a5FRvGTFJ3av0GPFw@mail.gmail.com>
Subject: Re: [Qemu-devel] building rst docs with sphinx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Jan 24, 2019 at 06:56:09PM +0000, Peter Maydell wrote:
> I had another look this afternoon at building our rST docs
> with sphinx-build. In particular, we currently have some
> docs in rst format, but we're not building them into HTML
> or shipping them. (Predictably, this means a few errors and
> warnings have crept in...)
> 
> I had a play about with adding some makefile runes, but
> I'm not sure entirely what I should be aiming for.
> 
> (1) configure: My thought is that we should just make
> sphinx-build a requirement for the existing --enable-docs
> switch (as texinfo and pod2man are currently). The
> disadvantage is that we won't support a "build the half
> of the docs you have the tools for and leave the others"
> setup. The advantage, which I think is significant, is that
> distros will naturally be directed to the missing build
> dependency (either they're building with --enable-docs
> and will get the configure message, or they aren't and
> then their build will fail later because of missing docs
> files when they try to put the built files into the package).

Currently in Fedora RPMs we ship the man pages and the
qemu-doc.html, qemu-ga-ref.html & qemu-qmp-ref.html files.
I'm not really seeing stuff in docs/ that grabs me as very
important to ship to users in Fedora RPMs. In fact I rather
doubt anyone even looks at the HTML files we currently
ship in the RPMs, as opposed to just looking in QEMU git.
Aside from man pages, I imagine most users just turn to
Google and/or qemu.org to find QEMU docs, not look inside
the distro packages. 

IOW from a distro POV I think I'd probably find sphinx-build
to be an undesirable mandatory dep.

Of course I do agree that we should be a enabling sphinx-build
during any of our CI builds so that we catch badly formatted
.rst docs. In addition I think much of docs/ could be useful
published on qemu.org.

> (2) What do we actually want to ship?
> That is, what do we want 'make install-doc' to copy into
> the installation directory?
> https://wiki.qemu.org/Features/Documentation
> has a good suggested breakdown of docs for where we
> eventually want to be. I think we probably don't want
> to install the "developer's guide" (docs/devel) on
> end-user systems. The others are presumably OK.
> Currently, we seem to only install manpages and a
> few other things in the 'install-doc' makefile target
> (we don't install a bunch of plain-text user-facing
> docs) so this would be a significant expansion.

I think 'make install-doc' should ship stuff that is useful
to end users of QEMU. This would be man pages, usage guides,
application developer information, etc.

It would not include anything that's related to the internals
of QEMU, as that's targetted at QEMU's developers themselves.

In Fedora we would not care to ship any docs that are targetting
QEMU developers, since those people would not be likely to be
using distro packaged QEMU.

> 
> (3) Indexes, table-of-contents pages, etc
> Are we aiming to ship these?
> I think that we probably want to have what from
> Sphinx's point of view are multiple separate documents,
> so that they each get their own ToC and index. This
> means we can for instance ship the ToC/index for
> the user docs but not have it contain index entries
> for developer docs.
> 
> Overall what I'm hoping for is to be able to get some
> basic structure/building commands into master so we
> have a framework and something we can iterate on to
> move forward.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
