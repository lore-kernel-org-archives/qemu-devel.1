Received: from eggs.gnu.org ([2001:4830:134:3::10]:49490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dgD3e-0003Ra-6y
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 12:45:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dgD3a-0003la-9s
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 12:45:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dgD3a-0003kv-3r
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 12:45:06 -0400
Date: Fri, 11 Aug 2017 17:44:55 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170811164455.GA2554@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170614203000.19984-1-ehabkost@redhat.com>
	<20170811163300.GA29509@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170811163300.GA29509@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH 0/5] hostmem-file: Add "persistent" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Zack Cornelius <zack.cornelius@kove.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Fri, Aug 11, 2017 at 01:33:00PM -0300, Eduardo Habkost wrote:
> CCing Zack Cornelius.
> 
> On Wed, Jun 14, 2017 at 05:29:55PM -0300, Eduardo Habkost wrote:
> > This series adds a new "persistent" option to
> > memory-backend-file.  The new option it will be useful if
> > somebody is sharing RAM contents on a file using share=on, but
> > don't need it to be flushed to disk when QEMU exits.
> > 
> > Internally, it will trigger a madvise(MADV_REMOVE) or
> > fallocate(FALLOC_FL_PUNCH_HOLE) call when the memory backend is
> > destroyed.
> > 
> > To make we actually trigger the new code when QEMU exits, the
> > first patch in the series ensures we destroy all user-created
> > objects when exiting QEMU.
> 
> So, before sending a new version of this, we need to clarify one
> thing: why exactly unlink()+close() wouldn't be enough to avoid
> having data unnecessarily flushed to the backing store and make
> the new option unnecessary?

If the backend file is shared between processes, unlinking
it feels bad - you're assuming no /future/ process wants to
attach to the file. Also if QEMU aborts for any reason, the
cleanup code is never going to run

> I would expect close() to not write any data unnecessarily if
> there are no remaining references to the file.  Why/when this is
> not the case?

Isn't the unlink() delayed until such time as *all* open handles
on that file are closed. If so, it seems that if 2 processes
have the file open, and one closes it, it is still valid for the
kernel to want to flush data out to the backing store if it needs
to free up working memory consumed by i/o cache.

If this wasn't the case, then one process could write 20 GB of data,
unlink + close the file, and that 20 GB would never be able to be
purge from I/O cache for as long as another process had that FD
open. That would be pretty bad denial of sevice for memory management
system.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
