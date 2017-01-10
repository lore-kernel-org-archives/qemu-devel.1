Received: from eggs.gnu.org ([2001:4830:134:3::10]:56844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cQzdh-0001ew-Nd
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:51:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cQzde-0002Hm-0J
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:51:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cQzdd-0002Hc-QK
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:51:09 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DD67464DB8
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 16:51:09 +0000 (UTC)
Date: Tue, 10 Jan 2017 16:51:05 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170110165105.GR27720@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
	<20170106155543.12827-3-berrange@redhat.com>
	<20170110163713.GA19869@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170110163713.GA19869@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 02/47] trace: switch io/ directory to
 modular trace.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Jan 10, 2017 at 04:37:13PM +0000, Stefan Hajnoczi wrote:
> On Fri, Jan 06, 2017 at 03:54:58PM +0000, Daniel P. Berrange wrote:
> > diff --git a/io/channel-buffer.c b/io/channel-buffer.c
> > index 43d7959..b4e50d6 100644
> > --- a/io/channel-buffer.c
> > +++ b/io/channel-buffer.c
> > @@ -22,7 +22,7 @@
> >  #include "io/channel-buffer.h"
> >  #include "io/channel-watch.h"
> >  #include "qemu/sockets.h"
> > -#include "trace.h"
> > +#include "io/trace.h"
> 
> Is this change necessary?
> 
> I think the per-subdir trace.h file should be generated in
> $BUILD_DIR/<sub-dir>/trace.h and gcc -I. can locate that file.

It doesn't work with builddir != srcdir builds, because -I. is resolved
to the srcdir, but the trace.h is in builddir. The -I$BUILDDIR<sub-dir>
is also added to the compiler search path, but it is after pretty much
all other search paths. The end result is that if you simply use
"trace.h" instad of "io/trace.h" you'll end up finding the trace.h
from the top level source directory, instead of from your subdir.

I think the include path should probably be changed such that the
-IBUILDDIR/<subdir> is immediately after -I., and I tried to make
such a change, but failed to come up with a simple patch that worked.

In the end I thought it would be clearer to be explicit about the
subdir we're pulling trace.h from anyway, since it is fairly common
practice  in QEMU to have the <subdir> in the #include filename.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
