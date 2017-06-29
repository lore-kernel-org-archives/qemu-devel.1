Received: from eggs.gnu.org ([2001:4830:134:3::10]:33124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dQa14-0002kh-Hl
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dQa10-0003Um-Lq
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:01:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dQa10-0003U3-Du
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:01:50 -0400
Date: Thu, 29 Jun 2017 15:01:42 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170629140142.GE32167@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170613165313.20954-1-ehabkost@redhat.com>
	<87o9t8qy7d.fsf@dusky.pond.sub.org>
	<20170628174158.GG12152@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170628174158.GG12152@localhost.localdomain>
Subject: Re: [Qemu-devel] [RFC 00/15] Error API: Flag errors in *errp even
 if errors are being ignored
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

On Wed, Jun 28, 2017 at 02:41:58PM -0300, Eduardo Habkost wrote:
> On Wed, Jun 28, 2017 at 11:05:26AM +0200, Markus Armbruster wrote:

> > > Ensuring errp is never NULL
> > > ---------------------------
> > >
> > > The last patch on this series changes the (Error **errp)
> > > parameters in functions to (Error *errp[static 1]), just to help
> > > validate the existing code, as clang warns about NULL arguments
> > > on that case.  I don't think we should apply that patch, though,
> > > because the "[static 1]" syntax confuses Coccinelle.
> > >
> > > I have a branch where I experimented with the idea of replacing
> > > (Error **errp) parameters with an opaque type (void*, or a struct
> > > type).  I gave up when I noticed it would require touching all
> > > callers to replace &err with a wrapper macro to convert to the
> > > right type.  Suggestions to make NULL errp easier to detect at
> > > build time are welcome.
> > >
> > > (Probably the easiest solution for that is to add assert(errp)
> > > lines to the ERR_IS_*() macros.)
> > 
> > We'll obviously struggle with null arguments until all the developers
> > adjusted to the new interface.  Possibly with occasional mistakes
> > forever.  Compile-time checking would really, really help.
> 
> True.  I'm investigating the possibility of using
> __attribute__((nonull(...))) with Coccinelle's help.

Beware that '__attribute__((nonnull))' has two distinct effects,
one of which is a potentially nasty trap which leads to crashes....

The useful part is that it allows compilers & analysis tools
like coverity to warn if you accidentally pass NULL into
a method. These warnings, particularly from gcc, only catch
a fraction of scenarios where you pass NULL in though.

The less useful part is that if GCC sees a nonnull annotation
on a parameter, then in the body of the method, it will silently
remove any code which does  "if (!paramname)". So if you added
a check for the parameter being NULL to avoid a crash, gcc will
remove that protection, so you'll once again get a crash at
runtime if passing NULL.

So if you use the nonnull annotation, they you probably want
to make sure to pass  -fno-delete-null-pointer-checks to
GCC to stop it removing your protection code, or you need to
be very confident that nothing will mistakenly pass NULL into
the methods annotated nonnull.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
