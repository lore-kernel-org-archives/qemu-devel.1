Received: from eggs.gnu.org ([209.51.188.92]:58776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gz1ZW-0001xU-Qo
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:56:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gz1ZV-0004cb-O7
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:56:38 -0500
Date: Wed, 27 Feb 2019 15:56:27 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190227155627.GN31688@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190226153549.17867-1-stefanha@redhat.com>
	<8a8d76d1-1280-f3d9-3d72-1c662d1ad666@redhat.com>
	<20190227153311.GH22539@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190227153311.GH22539@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH] file-posix: add drop-cache=on|off option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Neil Skrypuch <neil@tembosocial.com>

On Wed, Feb 27, 2019 at 03:33:11PM +0000, Stefan Hajnoczi wrote:
> On Tue, Feb 26, 2019 at 10:54:55AM -0600, Eric Blake wrote:
> > On 2/26/19 9:35 AM, Stefan Hajnoczi wrote:
> > > Commit dd577a26ff03b6829721b1ffbbf9e7c411b72378 ("block/file-posix:
> > > implement bdrv_co_invalidate_cache() on Linux") introduced page cache
> > > invalidation so that cache.direct=off live migration is safe on Linux.
> > > 
> > > The invalidation takes a significant amount of time when the file is
> > > large and present in the page cache.  Normally this is not the case for
> > > cross-host live migration but it can happen when migrating between QEMU
> > > processes on the same host.
> > > 
> > > On same-host migration we don't need to invalidate pages for correctness
> > > anyway, so an option to skip page cache invalidation is useful.  I
> > > investigated optimizing invalidation and detecting same-host migration,
> > > but both are hard to achieve so a user-visible option will suffice.
> > > 
> > > As a bonus this option means that the cache invalidation feature will
> > > now be detectable by libvirt via QMP schema introspection.
> > 
> > Do you still want to pursue the QMP query-qemu-features command, or does
> > this delay that for another day?
> 
> The presence of this new option doesn't guarantee that dropping caches
> works.  It is currently only implemented on Linux.
> 
> We still need query-qemu-features so that libvirt can detect whether
> this QEMU binary can drop caches (e.g. on Linux vs FreeBSD).

The commit message said that libvirt would use this new option to
detect availability of the cache drop feature. That should probably
be removed from the commit message, as this caveat about non-portable
impl means libvirt can't actually rely on it.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
