Received: from eggs.gnu.org ([2001:4830:134:3::10]:56874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fDmwL-00075x-D0
	for qemu-devel@nongnu.org; Wed, 02 May 2018 04:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fDmwH-0004Wi-Nj
	for qemu-devel@nongnu.org; Wed, 02 May 2018 04:16:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42216 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fDmwH-0004WF-Du
	for qemu-devel@nongnu.org; Wed, 02 May 2018 04:16:37 -0400
Date: Wed, 2 May 2018 09:16:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180502081632.GH3308@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<d50e3a40-d7f3-4c9b-e930-4c2f4d6c8a53@redhat.com>
	<CAFEAcA8wJuJ9464LadgjJOo-7ttdGYcfDQWALbkxBRJCr_knkg@mail.gmail.com>
	<87d0ye8qho.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87d0ye8qho.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, May 02, 2018 at 09:29:39AM +0200, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
> > On 27 April 2018 at 17:17, Thomas Huth <thuth@redhat.com> wrote:
> >> On 27.04.2018 17:51, Peter Maydell wrote:
> >>> Hi; I usually let people forget about releases for a month or
> >>> so before bringing this topic up, but:
> >>>
> >>> (1) do we want to call the next release 2.13, or something else?
> >>> There's no particular reason to bump to 3.0 except some combination of
> >>>  * if we keep going like this we'll get up to 2.42, which starts to
> >>>    get silly
> >>>  * Linus-style "avoid being too predictable"
> >>>  * triskaidekaphobia
> >>
> >> and maybe:
> >>
> >>  * Celebrate 15 years of QEMU
> >
> > Oh, hey, I hadn't noticed that. That's as good a reason as
> > any other!
> >
> >> By the way, just another crazy idea for v3.0 (i.e. feel free to turn it
> >> down immediately ;-)): Since compilation and testing time for QEMU is
> >> really huge, what do you think if we got rid of some QEMU binaries?
> >> qemu-system-aarch64 is a superset of qemu-system-arm, qemu-system-x86_64
> >> is a superset of qemu-system-i386 and qemu-system-ppc64 is a superset of
> >> qemu-system-ppc (and qemu-system-ppcemb). Would be feasible to get rid
> >> of the subset binaries with some work? (I think they were especially
> >> useful on 32-bit machines in the past, but most people are using 64-bit
> >> machines nowadays, aren't they?).
> >
> > I think Markus' backward-compatibility rubber chicken may prevent
> > us from removing those executables...
> 
> Nothing and nobody but ourselves can prevent us from breaking backward
> compatibility.
> 
> We *choose* to sacrifice the poor chickens to the idol of backward
> compatibility.  We *choose* to sacrifice to the idol whatever time and
> effort it demands[*].  We *choose* to let the idol smother other
> endeavors.
> 
> See also slide 35 "Must it be?" of
> https://www.linux-kvm.org/images/f/f2/Armbru-qapi-cmdline_1.pdf
> 
> Breaking backward compatibility without good reasons is stupid.
> Maintaining it at all costs is just as stupid.  There's no non-stupid
> way around facing the tradeoffs and making choices.
> 
> Our adoption of a deprecation policy has enabled us to make sensible
> choices in cases where providing old and new interface at the same time
> is inexpensive: we keep the old one around until the deprecation grace
> period expires.
> 
> What if we run into cases where that isn't practical?

Check the deprecation policy wording again :-)  All it says is that we
intend to give users 2 releases warning prior to making an incompatible
change.

Now, we've tried to nice and always provide the replacement functionality
at the same time that we introduce the deprecation warning, so there is a
period of overlap to let apps adapt, but we never actually documented that
as a hard requirement. That is perhaps an oversight when I wrote the
deprecation docs, but it does leave us wiggle room on how to intepret
what we need todo here.

  https://qemu.weilnetz.de/doc/qemu-doc.html#Deprecated-features

> How can I provide both the old command line in all its quirky glory and
> a QAPIfied command line?  Unless we can, the deprecation policy doesn't
> help one bit, it still wants us to replicate every mess we ever made in
> the old command line.  Would that be a smart choice?

I venture to suggest that the deprecation policy leaves us enough
ambiguity that we could issue a deprecation warning saying something
suitably vague like "various quirks of the cli may change in incompatible
ways in future", and then just do a big-bang conversion to QAPI'ified
version. If there are known quirks that we intend to break we could
call them out, but if we accidentally change a few quirks without
realizing it, so be it.

IOW, the big-bang conversion to QAPIified CLI is possible with our
deprecation policy, without having the maintain the existing code
in parallel with bug-for-bug compat. The main constraint is that
we would need to have a reasonable idea about when the QAPIified
CLI is likely to be ready to merge, so we have ability to warn
developers of forthcoming changes.

> [*] Curiously, the idol doesn't seem to demand effort to test backward
> compatibility.  The idol seems to be fine with us breaking it
> accidentally, only doing it knowingly incurs its wrath.

Testing is something we should have for everything we do, but no amount
of testing is ever going to have perfect coverage unless we spend x5
the dev time on testing, as in writing the feature. We just have to be
sensible about how we invest time in different areas to maximise benefit
for the user. We also have to accept the reality of our current codebase
which has very patchy test coverage - mandating everyone do something when
they'd be starting from (near) zero is not likely to yield happy devs.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
