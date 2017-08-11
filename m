Received: from eggs.gnu.org ([2001:4830:134:3::10]:35643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dg69x-0001Zu-Dc
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 05:23:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dg69v-0000Ig-Tv
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 05:23:13 -0400
Date: Fri, 11 Aug 2017 10:22:52 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170811092252.GF2554@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170810160451.32723-1-berrange@redhat.com>
	<20170810160451.32723-9-berrange@redhat.com>
	<a9553758-f0b3-f8c8-2457-41c389203602@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9553758-f0b3-f8c8-2457-41c389203602@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 8/8] sockets: fix parsing of ipv4/ipv6 opts
 in parse_socket_addr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org

On Thu, Aug 10, 2017 at 01:35:15PM -0500, Eric Blake wrote:
> On 08/10/2017 11:04 AM, Daniel P. Berrange wrote:
> > The inet_parse() function looks for 'ipv4' and 'ipv6'
> > flags, but only treats them as bare bool flags. The normal
> > QemuOpts parsing would allow on/off values to be set too.
> > 
> > This updated inet_parse() so that its handling of the
> 
> s/updated/updates/ ?
> 
> > 'ipv4' and 'ipv6' flags matches that done by QemuOpts.
> 
> Do we have a regression compared to any previous version, such that this
> patch might be considered 2.10 material?  Offhand, though, I think it's
> fine as the end of your series, waiting for 2.11.

Well this code has been like this for years, so waiting to fix
it in 2.11 isn't making our life any worse than it already
us.

The original code merely looks for a prefix so treats

   ,ipv6
   ,ipv6dumpsterfire
   ,ipv6=off
   ,ipv6=fishfood
   ,ipv6<anything>

as all meaning 'true'. The new code only treats ,ipv6 and ,ipv6=on
as meaning true, or ipv6=off as false, rejecting all others.

So yes, that is technically a regression, but IMHO it is a desirable
regression :-)

> 
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  tests/test-sockets-proto.c | 13 -------------
> >  util/qemu-sockets.c        | 36 ++++++++++++++++++++++++++++++++----
> >  2 files changed, 32 insertions(+), 17 deletions(-)
> > 
> 
> > +++ b/util/qemu-sockets.c
> > @@ -616,6 +616,25 @@ err:
> >  }
> >  
> >  /* compatibility wrapper */
> > +static int inet_parse_flag(const char *flagname, const char *optstr, bool *val,
> > +                           Error **errp)
> > +{
> > +    char *end;
> > +    size_t len;
> > +
> > +    end = strstr(optstr, ",");
> 
> Do we need to check that we are not landing on a ',,' escape that would
> make QemuOpts behave differently?  [That is, ipv4=on,,garbage should be
> parsed as setting ipv4 to 'on,garbage' (which is not valid), and NOT
> setting 'ipv4=on' followed by the 'garbage' or ',garbage' key - while
> the key named 'garbage' would fail, there might be other key names where
> the distinction matters for catching command line typos]
> 
> But if this is unrelated to QemuOpts escape parsing, it seems okay.

Ultimately this code should probably be converted to actually use
QemuOpts. The existing code already allows ipv4=on,,garbage but as
you point out I've not detected that case here. Should be easye
enough to fix though.

> 
> Reviewed-by: Eric Blake <eblake@redhat.com>



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
