Received: from eggs.gnu.org ([2001:4830:134:3::10]:48965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dZeee-0005IO-Fi
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:48:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dZeea-0003kK-Fr
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:48:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dZeea-0003jk-6f
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:48:12 -0400
Date: Mon, 24 Jul 2017 15:47:59 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170724144759.GD11443@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170719100802.14094-1-berrange@redhat.com>
	<20170719100802.14094-2-berrange@redhat.com>
	<d659c0cb-0cb2-3af7-b97f-05ad15aa3550@redhat.com>
	<ee0b3e06-7037-f2c9-18e9-1fb1dcb0784a@redhat.com>
	<20170724141108.GA11443@redhat.com>
	<d4f1f1c7-ca1f-904b-d23b-f9897b1ee29e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d4f1f1c7-ca1f-904b-d23b-f9897b1ee29e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/2 (for 2.10)] docs: document support
 lifetime for features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Mon, Jul 24, 2017 at 04:26:24PM +0200, Paolo Bonzini wrote:
> On 24/07/2017 16:11, Daniel P. Berrange wrote:
> >>> +
> >>> +The supported lifetime for versioned machine types is 12 releases,
> >>> +which is equivalent to 4 years worth of previous QEMU releases.
> >> I think there's still no consensus on this.
> > 
> > Indeed, which is exactly why I sent this patch - we need to come up
> > with a sensible policy here, so we can stop repeating the same debate
> > over & over & over each time some proposes a patch to kill off some
> > random old machine type.
> > 
> > The 12 release / 4 year figure was a fairly arbitrary starting
> > point to which I'd be hoping to see critical reviewer feedback
> > on (with possible counterproposals) so we can try to get something
> > documented, to put an end to the repeated debates in this area
> > each time someone proposes a patch.
> 
> I agree.  At the moment, the status is "machine types never die".
> 
> We can change it, but I think that we should also make a decision on
> whether removing machine types implies removing properties that only
> exist for backwards-compatibility reasons.
> 
> 4 year seems like a long time, but it can actually be pretty taxing for
> RHEL.  I'm pretty sure that around RHEL 8.4 (some time between
> 2020-2022) we'll need a 1.5-ish machine type (2016).

QEMU 1.5 was 2013, so that's saying RHEL 8 will want support for QEMU
machine types (and all their properties) that are ~10 years old from
upstream QEMU POV.  Possibly longer, as RHEL lifetime seems to only
ever increase

Generally I see the following choices:

 1. Upstream never removes machine types or properties they use

 2. Upstream removes machine types after N releases / Y years,
    but keeps properties related to them forever

 3. Upstream removes machine types after N releases / Y years,
    & removes some associated properties at same time.

 4. Upstream removes machine types after N releases / Y years,
    & optionally marks associated properties as deprecated,
    removing them in accordance with deprecation policy.

Option 1 is current state of play, leaving burden on upstream
forever, and letting machine list grow without bound.

Option 2 stops the '-M ?' list growing without bound, but aside from
that is the same as option 1. Not much difference from option 1, since
supporting the properties is what adds the core maint burden, not the
machine types themselves.

Options 3/4 reduce burden on QEMU upstream, at cost of requiring the
downstream vendor(s) to un-delete properties that upstream decides to
remove and deal with any fallout that entails.  The work involved in
undeleting stuff is larger than the work involved in keeping it alive
in upstream, because downstream has to undelete it, resolve conflicts,
and then do all the same work upstream would have been doing had it
not delete it & deal with further merge conflicts.


Downstreams may not care about difference betweeen option 1 & 2 if
they define their own custom machine types (RHEL & Ubuntu both do)

Effectively it comes down to who should have the maint burden,
upstream or downstream.



If it takes more work downstream to undelete & maintain machine
types in the downstream fork, that means downstream maintainers
less free time to improve QEMU upstream. From that POV, deleting
machine types & props upstream is actually counterproductive to
upstream on balance. The rational thing would thus be to stick
with status quo, and explicitly cdeclare that upstream will *never*
delete machine types, or make their lifetime long enough for the
longest lived downstream (10 years min & by the time we get to
10 years, it might even be 15 years). 


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
