Received: from eggs.gnu.org ([2001:4830:134:3::10]:55336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMEC0-00072I-8G
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:32:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMEBx-00020y-H2
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:32:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gMEBx-00020C-1w
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:31:57 -0500
Date: Mon, 12 Nov 2018 15:31:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181112153149.GS3602@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <7b5279e8946325b7f3c22a4a51ab02777202ce77.1541573846.git.artem.k.pisarenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7b5279e8946325b7f3c22a4a51ab02777202ce77.1541573846.git.artem.k.pisarenko@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] netdev: fix socket backend implementation
 and docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Wed, Nov 07, 2018 at 12:57:30PM +0600, Artem Pisarenko wrote:
> Changes:
> - user documentation and QAPI 'NetdevSocketOptions' comments updated
> to match current implementation ('udp' type description added, 'fd'
> option separated to exclusive type and described, 'localaddr'-related
> description for 'mcast' type fixed, hostname parts in "[host]:port"
> options updated to match optional/required syntax, various fixes and
> improvements in options breakdown and wording);
> - 'fd' type backend: requirement for socket handle being already
> binded and connected made explicit and documented;
> - 'fd' type backend: fix broken SOCK_DGRAM support;
> - 'fd' type backend: removed multicast support and cleaned up broken
> workaround for it (never called);
> - fix possible broken multicasting in win32 platform;
> - fix parsing of "[host]:port" options (added error handling for cases
> where "host" part is documented as required but isn't provided);
> - some error messages improved;
> - other small fixes and refactoring in code.
> 
> Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
> ---
> 
> Notes:
>     (Since these changes are closely related, I've combined them in one patch.)

This is really not a desirable thing todo. While you are changing 
one area of code, but you've got a number of independent bugs
or improvements you are making. These should be done as a patch
series, one distinct fix/change per patch. Refactoring should
especially always be done separately from any functional changes
to reviewers can clearly see no accidental behaviour changes are
introduced by the refactoring.


> diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
> index 8140fea..3fad004 100644
> --- a/include/qemu/sockets.h
> +++ b/include/qemu/sockets.h
> @@ -46,7 +46,7 @@ void socket_listen_cleanup(int fd, Error **errp);
>  int socket_dgram(SocketAddress *remote, SocketAddress *local, Error **errp);
>  
>  /* Old, ipv4 only bits.  Don't use for new code. */
> -int parse_host_port(struct sockaddr_in *saddr, const char *str,
> +int parse_host_port(struct sockaddr_in *saddr, const char *str, bool h_addr_opt,
>                      Error **errp);

Incidentally this method should not even be part of this header
files.  qemu/sockets.h is for code that lives in util/qemu-sockets.c

The parse_host_port declaration and impl should better live in
net/util.{c,h}, so I'd recommend moving that as the first patch
in a series.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
