Received: from eggs.gnu.org ([2001:4830:134:3::10]:47086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eNLRa-0003xL-0R
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:24:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eNLRY-0002zx-Rg
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:24:10 -0500
Date: Fri, 8 Dec 2017 16:23:58 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171208162358.GJ11767@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171208133416.28978-1-berrange@redhat.com>
	<73ad7473-67e5-0e2c-908e-9e3349ac87bb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73ad7473-67e5-0e2c-908e-9e3349ac87bb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] qemu-io: fix EOF Ctrl-D handling in
 qemu-io readline code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Dec 08, 2017 at 10:21:35AM -0600, Eric Blake wrote:
> On 12/08/2017 07:34 AM, Daniel P. Berrange wrote:
> > qemu-io puts the TTY into non-canonical mode, which means no EOF processing is
> > done and thus getchar() will never return the EOF constant. Instead we have to
> > query the TTY attributes to determine the configured EOF character (usually
> > Ctrl-D / 0x4), and then explicitly check for that value. This fixes the
> > regression that prevented Ctrl-D from triggering an exit of qemu-io that has
> > existed since readline was first added in
> > 
> >   commit 0cf17e181798063c3824c8200ba46f25f54faa1a
> >   Author: Stefan Hajnoczi <stefanha@redhat.com>
> >   Date:   Thu Nov 14 11:54:17 2013 +0100
> > 
> >     qemu-io: use readline.c
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> > Changed in v2:
> 
> > +++ b/qemu-io.c
> > @@ -10,6 +10,9 @@
> >  #include "qemu/osdep.h"
> >  #include <getopt.h>
> >  #include <libgen.h>
> > +#ifndef _WIN32
> > +#include <termios.h>
> > +#endif
> 
> Wouldn't a configure probe for the existence of <termios.h> be more
> reliable than just hard-coding the list of platforms where it is
> currently not found?
> 
> >  
> >  #include "qapi/error.h"
> >  #include "qemu-io.h"
> > @@ -41,6 +44,26 @@ static bool imageOpts;
> >  
> >  static ReadLineState *readline_state;
> >  
> > +static int ttyEOF;
> > +
> > +static int get_eof_char(void)
> > +{
> > +#ifdef _WIN32
> 
> in which case this also should be #if HAVE_TERMIOS_H
> 
> But I guess unless someone complains, all other platforms that we care
> about have termios.h, so a weak:

FYI, vl.c already includes termios.h, with merely  #ifndef _WIN32
protection, so that shows this is sufficient for our immediate
needs.

> Reviewed-by: Eric Blake <eblake@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
