Received: from eggs.gnu.org ([2001:4830:134:3::10]:34887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cRMW8-0006DX-0C
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:16:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cRMW4-00016G-Na
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:16:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cRMW4-00014x-Hs
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:16:52 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 01BBDA464B
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 17:16:52 +0000 (UTC)
Date: Wed, 11 Jan 2017 17:16:46 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170111171646.GR12072@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
	<20170106155543.12827-3-berrange@redhat.com>
	<20170110163713.GA19869@stefanha-x1.localdomain>
	<eabc1ecd-439c-69cc-facb-281699a4d26e@redhat.com>
	<20170111171202.GG9269@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170111171202.GG9269@stefanha-x1.localdomain>
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
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

On Wed, Jan 11, 2017 at 05:12:02PM +0000, Stefan Hajnoczi wrote:
> On Tue, Jan 10, 2017 at 10:51:29AM -0600, Eric Blake wrote:
> > On 01/10/2017 10:37 AM, Stefan Hajnoczi wrote:
> > > On Fri, Jan 06, 2017 at 03:54:58PM +0000, Daniel P. Berrange wrote:
> > >> diff --git a/io/channel-buffer.c b/io/channel-buffer.c
> > >> index 43d7959..b4e50d6 100644
> > >> --- a/io/channel-buffer.c
> > >> +++ b/io/channel-buffer.c
> > >> @@ -22,7 +22,7 @@
> > >>  #include "io/channel-buffer.h"
> > >>  #include "io/channel-watch.h"
> > >>  #include "qemu/sockets.h"
> > >> -#include "trace.h"
> > >> +#include "io/trace.h"
> > > 
> > > Is this change necessary?
> > 
> > Yes - now that there are more than one trace.h files spread across
> > multiple directories, you need a prefix to ensure the correct one gets
> > included.  In this particular case, it also matches consistency in
> > including "io/channel-buffer.h" rather than just "channel-buffer.h".
> 
> "io/channel-buffer.h" is no more consistent or clear than
> "channel-buffer.h".
> 
> Does it mean include/io/channel-buffer.h or
> ./include/io/channel-buffer.h?  You don't know unless you know the
> compiler include paths and which directories have a channel-buffer.h
> file.
> 
> IMO a simple "foo.h" is clearest for ./foo.h.

I've been trying to get such relative includes to work most of today
and not having much luck. The problem is that while it works in 95%
of the time, there are some source files and header files which need
to include trace.h files not in their local directory and we can't
use relative includes for that, since the relative include gets
resolved wrt the source file doing the #include, but the trace.h
file is in $BUILD_DIR.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
