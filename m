Received: from eggs.gnu.org ([2001:4830:134:3::10]:59333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eSL1Q-0003HR-Ml
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 05:57:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eSL1P-0000b1-Fv
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 05:57:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eSL1P-0000YM-8l
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 05:57:47 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC4CA82100
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 10:57:43 +0000 (UTC)
Date: Fri, 22 Dec 2017 10:57:36 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171222105736.GL30605@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171221155905.3793-1-berrange@redhat.com>
	<20171221155905.3793-2-berrange@redhat.com>
	<cf30232b-8674-134a-38fa-0c6cb9f9af3e@redhat.com>
	<87o9mrrvjy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o9mrrvjy.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] io: move fd_is_socket() into common
 sockets code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Fri, Dec 22, 2017 at 09:55:29AM +0100, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
> > On 12/21/2017 09:59 AM, Daniel P. Berrange wrote:
> >> The fd_is_socket() helper method is useful in a few places, so put it in
> >> the common sockets code.
> >>
> >> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> >> ---
> >>   include/qemu/sockets.h |  1 +
> >>   io/channel-util.c      | 13 -------------
> >>   util/qemu-sockets.c    | 13 +++++++++++++
> >>   3 files changed, 14 insertions(+), 13 deletions(-)
> >
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> >
> > But while you are touching this...
> >
> >> +++ b/util/qemu-sockets.c
> >> @@ -91,6 +91,19 @@ NetworkAddressFamily inet_netfamily(int family)
> >>       return NETWORK_ADDRESS_FAMILY_UNKNOWN;
> >>   }
> >>   +bool fd_is_socket(int fd)
> >> +{
> >> +    int optval;
> >> +    socklen_t optlen;
> >> +    optlen = sizeof(optval);
> >> +    return qemu_getsockopt(fd,
> >> +                           SOL_SOCKET,
> >> +                           SO_TYPE,
> >> +                           (char *)&optval,
> >
> > This cast is pointless (although you are just moving it from the old
> > code).  qemu_getsockopt() already takes care of casting for mingw
> > (where the signature is not POSIX-compliant), and on all other
> > platforms, the argument is already prototyped as void*; and since
> > void* accepts anything, you don't have to go through an intermediate
> > char*.
> 
> If we're tweaking, then I'd like it tweaked so:
> 
>     bool fd_is_socket(int fd)
>     {
>         int optval;
>         socklen_t optlen = sizeof(optval);
> 
>         return !qemu_getsockopt(fd, SOL_SOCKET, SO_TYPE, &optval, &optlen);
>     }

Yes I'll do exactly that.

> 
> With or without such tweaks:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
