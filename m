Received: from eggs.gnu.org ([2001:4830:134:3::10]:39209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eMadn-0003Wy-LS
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 09:25:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eMadj-0000fc-Nh
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 09:25:39 -0500
Date: Wed, 6 Dec 2017 14:25:13 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171206142513.GD18296@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171206115726.5237-1-berrange@redhat.com>
	<171741b3-39b8-7c37-8e07-4a9dd590e4c9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <171741b3-39b8-7c37-8e07-4a9dd590e4c9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-io: fix EOF Ctrl-D handling in
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
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed, Dec 06, 2017 at 08:22:35AM -0600, Eric Blake wrote:
> On 12/06/2017 05:57 AM, Daniel P. Berrange wrote:
> > qemu-io puts the TTY into non-canonical mode, which means no EOF processing is
> > done and thus getchar() will never return the EOF constant. Instead we have to
> > check for an explicit Ctrl-D, aka  0x4, to detect EOF and exit the qemu-io
> > shell. This fixes the regression that prevented Ctrl-D from triggering an exit
> > of qemu-io that has existed since readline was first added in
> > 
> >   commit 0cf17e181798063c3824c8200ba46f25f54faa1a
> >   Author: Stefan Hajnoczi <stefanha@redhat.com>
> >   Date:   Thu Nov 14 11:54:17 2013 +0100
> > 
> >     qemu-io: use readline.c
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  qemu-io.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> >      while (!line) {
> >          int ch = getchar();
> > -        if (ch == EOF) {
> > +        /* In non-canon tty mode we get 0x4 (Ctrl-D), not the stdio "EOF"
> > +         * constant */
> > +        if (ch == 0x4) {
> 
> Should we instead be looking for a match against the current termios()
> c_cc[VEOF] setting, in case the user prefers something other than ^D via
> stty?  Does readline provide any functionality for automating this?

I was afraid someone was going to suggest doing that. I was being lazy by
hardcoding Ctrl-D, but yes the real readline() library will honour the
VEOF value.  QEMU though is using a home-grown reimpl of readline...

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
