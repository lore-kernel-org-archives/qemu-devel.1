Received: from eggs.gnu.org ([2001:4830:134:3::10]:57889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXkPk-000234-Bg
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:33:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXkPj-0007jQ-2r
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:33:00 -0400
Date: Wed, 19 Jul 2017 09:32:40 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170719083240.GB30084@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-11-git-send-email-armbru@redhat.com>
	<20170718175229.GF2106@work-vm> <878tjlh7l3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878tjlh7l3.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH for-2.10 10/10] migration: Use JSON null
 instead of "" to reset parameter to default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, quintela@redhat.com

On Tue, Jul 18, 2017 at 09:24:08PM +0200, Markus Armbruster wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> 
> > * Markus Armbruster (armbru@redhat.com) wrote:
> >> migrate-set-parameters sets migration parameters according to is
> >> arguments like this:
> >> 
> >> * Present means "set the parameter to this value"
> >> 
> >> * Absent means "leave the parameter unchanged"
> >> 
> >> * Except for parameters tls_creds and tls_hostname, "" means "reset
> >>   the parameter to its default value
> >
> > Is this really what's happening? IMHO the tls_creds and tls_hostname
> > behaviour isn't that "" resets to the default, it just is the default.
> > I don't think there's anything special cased for tls_creds and
> > tls_hostname in the existing code.    It's this patch that's
> > adding more special casing.
> >
> > (I'm not going to nack this, but I just don't get why it's such a big
> > deal)
> 
> It wouldn't call it a big deal.  In fact, I called it a "minor QMP
> interface design flaw".
> 
> The implementation encodes "no TLS credentials, do not use TLS" and "no
> host name, fall back to the one in the migration URI" as "".  Works
> because "" is neither a valid TLS credentials ID, nor a valid host name.
> 
> Until commit 4af245d (v2.9.0), the implementation used NULL / optional
> absent rather than "".  Cleaner, because it doesn't rely on "" being
> invalid.
> 
> The reason why commit 4af245d changed it to "" was that
> migrate-set-parameters can't do NULL / optional absent.  It can't,
> because it already uses optional absent for "do not change this
> parameter".
> 
> Replacing NULL by "" side-stepped this problem.  I dislike that because
> it's not general (only works as long as "" is not a valid value), and
> ugly.
> 
> Instead of side-stepping the problem, I proposed to tackle it: make JSON
> null mean NULL in migrate-set-parameters.  However, the freeze was
> literally the other day, we needed *some* solution, and only the one
> making "" special was ready.  So I let it pass.
> 
> Related: NULL used to be shown as "" in query-migrate-parameters.
> Commit de63ab6 (v2.8.0) fixed that oddity, but commit 4af245d (v2.9.0)
> regressed the fix, probably unintentionally.

>From libvirt POV we considered de63ab6 to be the regression (from the
original 2.6.0 behaviour), and 4af245d to be the fix for that regression.
Libvirt expected to see "" for tls-hostname in the output - without that
it doesn't know that tls-hostname is even a valida parameter.

> I'm open to fixing the query-migrate-parameters regression during
> freeze.

No please don't. That will break libvirt yet again.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
