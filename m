Received: from eggs.gnu.org ([2001:4830:134:3::10]:36008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d8TAu-00074k-4R
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d8TAq-0004fp-66
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:05:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d8TAp-0004eV-U0
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:05:08 -0400
Date: Wed, 10 May 2017 16:04:52 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170510150452.GV31558@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1494398933-8366-1-git-send-email-thuth@redhat.com>
	<20170510090841.GF31558@redhat.com> <20170510145125.GE4230@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170510145125.GE4230@work-vm>
Subject: Re: [Qemu-devel] [PATCH] hw/i386: Deprecate the machines pc-0.10 to
 pc-0.15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, kraxel@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, May 10, 2017 at 03:51:25PM +0100, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrange (berrange@redhat.com) wrote:
> > If we deprecate in this release (~Aug/Sep 2017), and kill in the next
> > release  (Dec 2017), that means our oldest machine type pc-1.0 is still
> > going to be 6 years, or 18 major releases, old. This raises some questions
> > 
> >   - Do we really think that we still have users with VMs that are
> >     stuck on a 6 year old machine type from 18 major releases ago ?
> 
> Our RHEL6 users are still on a 0.12 derivative.

Yep, but not using upstream machine types. So we can kill machine
types without affecting RHEL-6.  The separate question is whether
we can kill the associated features that are needed for RHEL to
create its legacy machine types (eg the rombar setting mentioned)

> 
> >   - Is 6 years / 18 major releases going to be our cutoff point for
> >     machine types going forward ?
> > 
> >   - Do we have any confidence that pc-1.0 in QEMU 2.9.0 really is
> >     migration compatible with pc-1.0 from QEMU 1.0 ? I'm doubtful
> >     unless someone can show automated testing results that confirm
> >     it is compatible.
> 
> I'll give you a manual one; I just migrated:
>    /opt/qemu/v1.0.1/bin/qemu-system-x86_64 -M pc-1.0 -m 2G /home/vms/f23-serial-010.qcow2 -M pc-1.0 -nographic
> to
>    /opt/qemu/v2.9.0/bin/qemu-system-x86_64 -M pc-1.0 -m 2G /home/vms/f23-serial-010.qcow2 -M pc-1.0 -nographic -incoming tcp::4444
> 
> seems to have survived.
> Not exactly conclusive or heavy coverage, but it's not completely
> broken.
> 
> > FYI, I'm in favour of culling old machine types, but I think when we do
> > this it should not be a one-off ad-hoc culling.
> > 
> > It should be accompanied by changes to the documentation that clearly
> > state our official support policy for machine type lifetimes, so that
> > users know what to expect for future releases.
> > 
> > Also unless we're going to get more serious about automated testing to
> > validate machine type compatibility between *all* previously releases,
> > I think that 6 years / 18 releases is too long a time to have any
> > confidence in migration compatibility between versions.
> 
> The problem is we don't do that much testing; I know of more subtle
> things that have broken between 2.6 and 2.7 - so do you kill 2.6 machine
> type? No, but it's a question of how you choose what to kill.

You know of the breaks between 2.6 & 2.7 because those are modern versions
people are using & thus getting lots of attention & analysis from yourself
and other people. Arguably it just looks worse because no one is actively
using, testing or analysing 1.0 vs 2.7.

Ideally, we would only claim to support combinations that we have active
compatibility test coverage for. We lacking right now, but for the sake
of discussion, lets assume we did have some level of automated coverage.
Then there's still the question of how far back we want to be running the
testing for. I think the latter is the more important question, as it sets
us a clear process to follow, as well as a goal to reach for testing coverage.

IOW, we should be able to set ourselves a goal / process, even if we don't
yet achieve that in terms of testing.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
