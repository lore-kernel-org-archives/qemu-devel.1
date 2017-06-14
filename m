Received: from eggs.gnu.org ([2001:4830:134:3::10]:48546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dL3J2-0002hP-GR
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dL3Iz-0005EB-BM
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:05:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dL3Iz-0005E1-24
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:05:33 -0400
Date: Wed, 14 Jun 2017 09:05:24 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170614080524.GA2715@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
	<1496320911-51305-23-git-send-email-pbonzini@redhat.com>
	<CAFEAcA8-wN6_LmMCf=73jGmJbpMmQACiUKiUi-b4J0y-P6-YUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8-wN6_LmMCf=73jGmJbpMmQACiUKiUi-b4J0y-P6-YUw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 22/33] sockets: improve error reporting if
 UNIX socket path is too long
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Jun 13, 2017 at 05:10:00PM +0100, Peter Maydell wrote:
> On 1 June 2017 at 13:41, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > From: "Daniel P. Berrange" <berrange@redhat.com>
> >
> > The 'struct sockaddr_un' only allows 108 bytes for the socket
> > path.
> >
> > If the user supplies a path, QEMU uses snprintf() to silently
> > truncate it when too long. This is undesirable because the user
> > will then be unable to connect to the path they asked for.
> >
> > If the user doesn't supply a path, QEMU builds one based on
> > TMPDIR, but if that leads to an overlong path, it mistakenly
> > uses error_setg_errno() with a stale errno value, because
> > snprintf() does not set errno on truncation.
> >
> > In solving this the code needed some refactoring to ensure we
> > don't pass 'un.sun_path' directly to any APIs which expect
> > NUL-terminated strings, because the path is not required to
> > be terminated.
> >
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > Message-Id: <20170525155300.22743-1-berrange@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  util/qemu-sockets.c | 68 ++++++++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 46 insertions(+), 22 deletions(-)
> 
> It looks like we missed a case where we should have changed
> an un.sun_path usage to something else:
> 
> > @@ -873,24 +877,25 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
> >           * to unlink first and thus re-open the race window.  The
> >           * worst case possible is bind() failing, i.e. a DoS attack.
> >           */
> > -        fd = mkstemp(un.sun_path);
> > +        fd = mkstemp(pathbuf);
> >          if (fd < 0) {
> >              error_setg_errno(errp, errno,
> > -                             "Failed to make a temporary socket name in %s", tmpdir);
> > +                             "Failed to make a temporary socket %s", pathbuf);
> >              goto err;
> >          }
> >          close(fd);
> > -        if (update_addr) {
> > -            g_free(saddr->path);
> > -            saddr->path = g_strdup(un.sun_path);
> > -        }
> >      }
> >
> > -    if (unlink(un.sun_path) < 0 && errno != ENOENT) {
> > +    if (unlink(path) < 0 && errno != ENOENT) {
> >          error_setg_errno(errp, errno,
> > -                         "Failed to unlink socket %s", un.sun_path);
> > +                         "Failed to unlink socket %s", path);
> >          goto err;
> >      }
> > +
> > +    memset(&un, 0, sizeof(un));
> > +    un.sun_family = AF_UNIX;
> > +    strncpy(un.sun_path, path, sizeof(un.sun_path));
> > +
> >      if (bind(sock, (struct sockaddr*) &un, sizeof(un)) < 0) {
> >          error_setg_errno(errp, errno, "Failed to bind socket to %s", un.sun_path);
> 
> ...you can see it in this bit of the context: this should be passing
> "path" to the %s format string, shouldn't it?

Yes, you are correct - we must use  "path"

> 
> Spotted looking at coverity issues, though unfortunately coverity
> just always reports the "buffer not nul terminated" error rather
> than only the cases where we don't nul terminate and then hand
> the buffer to a function which consumes a nul-terminated string,
> so we just have to mark the issue 'ignore' and don't get the
> benefit of static checking :-(

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
