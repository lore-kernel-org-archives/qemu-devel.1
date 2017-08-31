Received: from eggs.gnu.org ([2001:4830:134:3::10]:45266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnN0K-00043e-5K
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnN0G-00027b-7W
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:47:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20117)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dnN0F-00025i-UD
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:47:16 -0400
Date: Thu, 31 Aug 2017 11:47:10 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170831104710.GG17315@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <87r2w6eq5n.fsf@gmail.com> <87h8x1yox3.fsf@dusky.pond.sub.org>
	<20170830170941.GB24565@stefanha-x1.localdomain>
	<87bmmwi6r6.fsf@dusky.pond.sub.org>
	<CAFEAcA8r-EqOjZDvP=0mYG7QQ83MU-54RL9Bu8Eb_wPzQo1M7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8r-EqOjZDvP=0mYG7QQ83MU-54RL9Bu8Eb_wPzQo1M7Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] scripts: Support building with Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, David Michael <fedora.dm0@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Aug 31, 2017 at 11:27:15AM +0100, Peter Maydell wrote:
> On 31 August 2017 at 07:35, Markus Armbruster <armbru@redhat.com> wrote:
> > So, first we'll invest in work-arounds to make both 2 and 3 work.  Once
> > 2 is gone, we can invest some more to clean them up.  Which probably
> > won't happen, so we'll continue to carry work-arounds that no longer
> > make sense.
> >
> > I maintain roughly one fourth of all Python code in qemu, and I'm not
> > looking forward to this hoop-jumping at all.
> >
> > Are we really, really sure we want to go this way?  What exactly are we
> > hoping to accomplish by it?
> 
> My take is that we have the following goals we want to achieve:
> 
> (1) We need to continue to build and run on older (long-term-support)
> distros that still ship only Python 2.x (alas even back to 2.6)
> (2) We need to be able to build and run on newer distros that
> have dropped Python 2 altogether in favour of Python 3
> (I don't know if there are any such today, but presumably by
> 2020 there will be)

Fedora has dropped Python 2 in the default install now, so needs to
be manually pulled in. While python 2 won't be dropped entirely in
the near future, its days are definitely numbered and so once
upstream officially dedclares it dead, I'd expect Fedora to follow.
 
> Unless we can confidently say that either (1) or (2) is the
> empty set, we need to handle both 2 and 3 in the same codebase.
> This is a pain, but unfortunately Python upstream have forced
> us into it by breaking source code compatibility.
> 
> I think (1) is pretty clearly not (yet) an empty set, so the
> only alternative I see to "support 2 and 3 now" is "keep supporting
> only 2 for the moment and hope that no distro drops 2 support
> before all the LTS 2-only distro versions vanish into history".

If we can update to python 2.7 as our minimum, then supporting py2
and py3 gets simpler, avoiding some of the nastier hacks, even
without that though it isn't too hard.


>From QEMU pov, I don't think supporting py2 and py3 at the same time
is actually as bad as you might expect from reading about the pain
in the broader community. We're lucky that pretty much all our python
code is self-contained not relying on 3rd party modules, and it
doesn't use particularly advanced features of python either.

I worked on OpenStack Nova during the conversion to support py2 & py3
in parallel, and the resulting code was not really any harder to
maintain than the original code. The hard bit was Nova's use of 3rd
party modules whose maintainers hadn't converted.

So, IMHO, provided we make sure our CI system is giving us test coverage
across the various py2 & py3 versions, the burden on us will not be
significant. Writing code that's py2 & py3 compatible is not hard as
long as you have good testing. So we just have a lump for the initial
conversion, then CI will take care of avoiding regressions going forward.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
