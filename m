Received: from eggs.gnu.org ([2001:4830:134:3::10]:48827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dDtwd-0003bd-Ta
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dDtwa-0002xj-H1
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:40:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dDtwa-0002xb-6d
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:40:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12BA4624A9
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 14:40:51 +0000 (UTC)
Date: Thu, 25 May 2017 15:40:44 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170525144044.GF18049@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170525101900.15950-1-berrange@redhat.com>
	<3d090dbd-eb49-5e4e-6b7e-b52a3fdc1716@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3d090dbd-eb49-5e4e-6b7e-b52a3fdc1716@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] sockets: improve error reporting if
 UNIX socket path is too long
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Thu, May 25, 2017 at 09:28:31AM -0500, Eric Blake wrote:
> On 05/25/2017 05:19 AM, Daniel P. Berrange wrote:
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
> > ---
> > 
> 
> >      } else {
> >          const char *tmpdir = getenv("TMPDIR");
> >          tmpdir = tmpdir ? tmpdir : "/tmp";
> > -        if (snprintf(un.sun_path, sizeof(un.sun_path), "%s/qemu-socket-XXXXXX",
> > -                     tmpdir) >= sizeof(un.sun_path)) {
> > -            error_setg_errno(errp, errno,
> > -                             "TMPDIR environment variable (%s) too large", tmpdir);
> > -            goto err;
> 
> The old code fails early if the generated name is too long,...
> 
> > -        }
> > +        path = pathbuf = g_strdup_printf("%s/qemu-socket-XXXXXX", tmpdir);
> >  
> >          /*
> >           * This dummy fd usage silences the mktemp() unsecure warning.
> > @@ -873,24 +868,32 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
> >           * to unlink first and thus re-open the race window.  The
> >           * worst case possible is bind() failing, i.e. a DoS attack.
> >           */
> > -        fd = mkstemp(un.sun_path);
> > +        fd = mkstemp(pathbuf);
> 
> ...while the new code ends up creating a too-long name in the
> file-system anyways,...

Opps, yes, that's not good.

> 
> >          if (fd < 0) {
> >              error_setg_errno(errp, errno,
> >                               "Failed to make a temporary socket name in %s", tmpdir);
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
> > +    if (strlen(path) > sizeof(un.sun_path)) {
> > +        error_setg(errp, "UNIX socket path '%s' is too long", path);
> > +        error_append_hint(errp, "Path must be less than %zu bytes\n",
> > +                          sizeof(un.sun_path));
> 
> The old message mentioned the name that was too long, the new does not.
> That's a potential slight loss in error message quality, particularly
> since you are no longer mentioning a UNIX socket (which may give the
> user a clue why 108 is special), but I can probably live with it (it's
> still pretty obvious from the message that you should investigate what
> is too long).

I'm not sure why you are saying I don't mention the path or that it
is a UNIX socket - I do exactly that right there.

$ ./x86_64-softmmu/qemu-system-x86_64 -monitor unix:/home/berrange/src/virt/qemu/01234567890123456789012345678901234567890123456789012345678901234567890123456789,server
qemu-system-x86_64: -monitor unix:/home/berrange/src/virt/qemu/01234567890123456789012345678901234567890123456789012345678901234567890123456789,server: UNIX socket path '/home/berrange/src/virt/qemu/01234567890123456789012345678901234567890123456789012345678901234567890123456789' is too long
Path must be less than 108 bytes

> > +    if (unlink(path) < 0 && errno != ENOENT) {
> 
> ...but skip the unlink of the just-created too-long name.  Oops.

yeah will fix that too

> 
> >          error_setg_errno(errp, errno,
> > -                         "Failed to unlink socket %s", un.sun_path);
> > +                         "Failed to unlink socket %s", path);
> >          goto err;
> >      }
> 
> I think you're okay if you just swap the unlink() with the length check.
>  Although it seems rather sys-call heavy to mkstemp/unlink compared to
> just doing a length check first, I do like how your refactoring ended up
> with fewer conditionals rather than splitting the generated name code
> across multiple conditionals.
> 
> > @@ -932,9 +942,16 @@ static int unix_connect_saddr(UnixSocketAddress *saddr,
> >          qemu_set_nonblock(sock);
> >      }
> >  
> > +    if (strlen(saddr->path) > sizeof(un.sun_path)) {
> > +        error_setg(errp, "UNIX socket path '%s' is too long", saddr->path);
> > +        error_append_hint(errp, "Path must be less than %zu bytes\n",
> > +                          sizeof(un.sun_path));
> 
> Again, potential loss in error message quality.

I don't think so.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
