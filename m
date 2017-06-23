Received: from eggs.gnu.org ([2001:4830:134:3::10]:49140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dONAo-0001Ld-6V
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 07:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dONAk-0008Gj-9Z
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 07:54:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dONAk-0008Gc-0C
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 07:54:46 -0400
Date: Fri, 23 Jun 2017 12:54:38 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170623115438.GH28635@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170606110556.12922-1-berrange@redhat.com>
	<20170606110556.12922-3-berrange@redhat.com>
	<874lv6gc19.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874lv6gc19.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] docs: document support lifetime for
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, Jun 23, 2017 at 01:48:34PM +0200, Markus Armbruster wrote:
> "Daniel P. Berrange" <berrange@redhat.com> writes:
> 
> > There is currently no explicit guidance on the duration of support
> > for features such as versioned machine types, which have a finite
> > useful lifespan. Thus apps / users cannot predict how much time
> > they might be able to use a feature for, before it is removed (if
> > ever).
> >
> > This adds a new appendix that lists items which have finite lifecycles,
> > such as machine types. For items which are generally expected to be
> > supported indefinitely, it sets out the policy around deprecation
> > and removal, should it be needed.
> >
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  qemu-doc.texi | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/qemu-doc.texi b/qemu-doc.texi
> > index 29f89d8..e3c6400 100644
> > --- a/qemu-doc.texi
> > +++ b/qemu-doc.texi
> > @@ -37,6 +37,7 @@
> >  * QEMU Guest Agent::
> >  * QEMU User space emulator::
> >  * Implementation notes::
> > +* Support lifetime::
> >  * Deprecations::
> >  * License::
> >  * Index::
> > @@ -3017,6 +3018,39 @@ Run the emulation in single step mode.
> >  
> >  @include qemu-tech.texi
> >  
> > +@node Support lifetime
> > +@appendix Support lifetime
> > +
> > +Features provided by QEMU are subject to varying support lifetimes.
> > +
> > +In general features are intended to be supported indefinitely once
> > +introduced. In the event that a feature needs to be removed, there
> > +will be some period in which it will be marked as deprecated before
> > +eventual removal. All deprecated features will be listed in the
> > +``Deprecations'' appendix of this document. They may also generate
> > +warnings on the console when QEMU starts up, or if activated via
> > +a monitor command.
> > +
> > +Certain features will have an inherently finite lifetime, and thus
> > +will be removed on a fixed schedule.
> > +
> > +@node Machine types
> > +@section Machine types
> > +
> > +For architectures which aim to support live migration compatibility
> > +across releases, each release will introduce a new versioned machine
> > +type. For example, the 2.8.0 release introduced machine types
> > +``pc-i440fx-2.8'' and ``pc-q35-2.8' 'for the x86_64/i686 architectures.
> > +
> > +To allow live migration of a guest running on a 2.8.0 release to a
> > +2.9.0, the QEMU 2.9.0 version must support the ``pc-i440fx-2.8'' and
> > +``pc-q35-2.8''.  To allow users live migrating VMs to skip multiple
> 
> "the ``pc-i440fx-2.8'' and ``pc-q35-2.8'' machine types".
> 
> > +intermediate releases when upgrading, new releases of QEMU will
> > +support machine types from many previous versions.
> 
> Suggest s/many/several/
> 
> > +
> > +The supported lifetime for machine types is 12 releases, which is
> > +equivalent to 4 years worth of previous QEMU releases.
> > +
> 
> Do we have consensus on this?  Peter?

FWIW, this was a fairly arbitrary time frame I picked, to stimulate
discussion. 4 years is long time for community supported distros, but
for enterprise distros like RHEL, where there's a long gap between
major versions, 4 years is probably close to the minimum practical
to enable upgrades. eg RHEL7.0 shipped 1.5.3 version (date 2013/08)
wanted to enable machine type compat with RHEL6's 0.12 version
(date 2009/12).

The flip side though is that enterprise distros don't typically use
the machine types "as is", then define custom downstream only versions.
They just need the underlying features to still exist.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
