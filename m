Received: from eggs.gnu.org ([209.51.188.92]:33908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hAwo5-0004yA-4v
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 09:16:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hAwo0-0002oe-6W
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 09:16:57 -0400
Date: Mon, 1 Apr 2019 14:16:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190401131641.GJ3524@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190330150702.11687-1-eblake@redhat.com>
	<20190401130416.GC4935@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190401130416.GC4935@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Saner printing of large file
 sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, vsementsov@virtuozzo.com, qemu-block@nongnu.org, rjones@redhat.com, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, jsnow@redhat.com

On Mon, Apr 01, 2019 at 03:04:16PM +0200, Kevin Wolf wrote:
> Am 30.03.2019 um 16:07 hat Eric Blake geschrieben:
> > Disk sizes close to INT64_MAX cause overflow, for some pretty
> > ridiculous output:
> > 
> >   $ ./nbdkit -U - memory size=$((2**63 - 512)) --run 'qemu-img info $nbd'
> >   image: nbd+unix://?socket=/tmp/nbdkitHSAzNz/socket
> >   file format: raw
> >   virtual size: -8388607T (9223372036854775296 bytes)
> >   disk size: unavailable
> > 
> > But there's no reason to have two separate implementations of integer
> > to human-readable abbreviation, where one has overflow and stops at
> > 'T', while the other avoids overflow and goes all the way to 'E'. With
> > this patch, the output now claims 8EiB instead of -8388607T, which
> > really is the correct rounding of largest file size supported by qemu
> > (we could go 511 bytes larger if we used byte-accurate sizing instead
> > of rounding up to the next sector boundary, but that wouldn't change
> > the human-readable result).
> > 
> > Reported-by: Richard W.M. Jones <rjones@redhat.com>
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> This is quite obviously a bug fix for some cases. This suggests that we
> want it in 4.0.
> 
> It is also an output change for other cases, like going from "8M" to
> "8 MiB". We probably can't tell for sure whether some tools expect the
> spelling "8M" (even if this is supposed to be the human interface and
> tools should be using JSON) or feed the change back to qemu-img or
> qemu-io (which accept "8M", but not "8 MiB" as sizes in most places).
> This suggests that we shouldn't make this change as late as -rc2.

If it breaks our own tests, then it is possible to break other tools
too.

> So what is the conclusion?

The safe option is to do the minimal fix for the existing code and look at
the refactoring in the next dev cycle.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
