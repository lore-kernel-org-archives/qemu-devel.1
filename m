Received: from eggs.gnu.org ([2001:4830:134:3::10]:52174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eyJiw-0001Tu-9M
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eyJiq-0003aK-9o
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:02:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46236 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eyJiq-0003a0-4c
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:02:48 -0400
Date: Tue, 20 Mar 2018 16:02:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180320160243.GZ4530@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180320093135.26422-1-fl@n621.de>
	<d5ad61b8-1570-0234-fd2a-97dfb174de59@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d5ad61b8-1570-0234-fd2a-97dfb174de59@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12] os: truncate pidfile on creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Florian Larysch <fl@n621.de>, qemu-devel@nongnu.org, sw@weilnetz.de

On Tue, Mar 20, 2018 at 09:50:19AM -0500, Eric Blake wrote:
> On 03/20/2018 04:31 AM, Florian Larysch wrote:
> > qemu_create_pidfile does not truncate the pidfile when it creates it,
> > but rather overwrites its contents with the new pid. This works fine as
> > long as the length of the pid doesn't decrease, but this might happen in
> > case of wraparounds, causing pidfiles to contain trailing garbage which
> > breaks operations such as 'kill $(cat pidfile)'.
> 
> Ouch.  Good analysis.
> 
> However, I have to wonder if we have the opposite problem - when the file
> exists (truncated) but has not yet been written, how often do we have a race
> where someone can see the empty file?
> 
> Should we be going even further and writing the pid into a temporary file
> and then rename(2)ing that file onto the real destination, so that if the
> pid file exists at all, it has stable contents that can't cause confusion?
> 
> > 
> > Instead, always truncate the file before writing it.
> > 
> > Signed-off-by: Florian Larysch <fl@n621.de>
> > ---
> >   os-posix.c | 2 +-
> >   os-win32.c | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/os-posix.c b/os-posix.c
> > index b9c2343b1e..9a6b874180 100644
> > --- a/os-posix.c
> > +++ b/os-posix.c
> > @@ -301,7 +301,7 @@ int qemu_create_pidfile(const char *filename)
> >       int len;
> >       int fd;
> > -    fd = qemu_open(filename, O_RDWR | O_CREAT, 0600);
> > +    fd = qemu_open(filename, O_RDWR | O_CREAT | O_TRUNC, 0600);
> 
> This part is right, if we don't care about the race with someone reading an
> empty file.

No, it is unsafe - we rely on lockf() to get the mutual exclusion.
If a QEMU is running with pidfile locked, and its pid written into
it, then a 2nd QEMU comes along it will truncate the pidfile owned
by the original QEMU because the truncation happens before it has
tried to acquire the lock. The 2nd QEMU will still exit, but the
original QEMU's pid has now been lost.

We must call ftruncate() after lockf(), but before writing the new
pid into the file. That ensures there is no window in which it is
possible to see the new & old pids mixed together.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
