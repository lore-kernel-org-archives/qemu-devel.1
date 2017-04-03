Received: from eggs.gnu.org ([2001:4830:134:3::10]:39758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cv0U7-0001d4-Tq
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:49:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cv0U5-0007Ex-7O
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:49:23 -0400
Date: Mon, 3 Apr 2017 12:48:55 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170403114855.GV2768@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
	<1490879707-6060-4-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1490879707-6060-4-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 for-2.9 03/10] io vnc sockets: Clean up
 SocketAddressKind switches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, namei.unix@gmail.com

On Thu, Mar 30, 2017 at 03:15:00PM +0200, Markus Armbruster wrote:
> We have quite a few switches over SocketAddressKind.  Some have case
> labels for all enumeration values, others rely on a default label.
> Some abort when the value isn't a valid SocketAddressKind, others
> report an error then.
> 
> Unify as follows.  Always provide case labels for all enumeration
> values, to clarify intent.  Abort when the value isn't a valid
> SocketAddressKind, because the program state is messed up then.
> 
> Improve a few error messages while there.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  io/dns-resolver.c   |  7 +++++--
>  ui/vnc.c            | 18 ++++++++++++------
>  util/qemu-sockets.c |  4 +---
>  3 files changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/io/dns-resolver.c b/io/dns-resolver.c
> index 0ac6b23..a407075 100644
> --- a/io/dns-resolver.c
> +++ b/io/dns-resolver.c
> @@ -164,9 +164,12 @@ int qio_dns_resolver_lookup_sync(QIODNSResolver *resolver,
>                                                  addrs,
>                                                  errp);
>  
> +    case SOCKET_ADDRESS_KIND_FD:
> +        error_setg(errp, "Unsupported socket address type 'fd'");
> +        return -1;
> +
>      default:
> -        error_setg(errp, "Unknown socket address kind");
> -        return -1;
> +        abort();
>      }
>  }

Just repeating my v1 comments - this needs to be treating KIND_FD as a no-op,
rather than raising an error.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
