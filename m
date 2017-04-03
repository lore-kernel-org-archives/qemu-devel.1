Received: from eggs.gnu.org ([2001:4830:134:3::10]:39268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cv0SD-0000zI-4V
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cv0SB-0006LG-VZ
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:47:25 -0400
Date: Mon, 3 Apr 2017 12:47:13 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170403114713.GU2768@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-4-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1490805920-17029-4-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [for-2.9 3/8] io vnc sockets: Clean up
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

On Wed, Mar 29, 2017 at 06:45:15PM +0200, Markus Armbruster wrote:
> We have quite a few switches over SocketAddressKind.  Some have case
> labels for all enumeration values, others rely on a default label.
> Some abort when the value isn't a valid SocketAddressKind, others
> report an error then.
> 
> Unify as follows.  Always provide case labels for all enumeration
> values, to clarify intent.  Abort when the value isn't a valid
> SocketAddressKind, because the program state is messed up then.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  io/dns-resolver.c   |  6 ++++--
>  ui/vnc.c            | 10 ++++++++--
>  util/qemu-sockets.c |  4 +---
>  3 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/io/dns-resolver.c b/io/dns-resolver.c
> index 0ac6b23..00fb575 100644
> --- a/io/dns-resolver.c
> +++ b/io/dns-resolver.c
> @@ -164,9 +164,11 @@ int qio_dns_resolver_lookup_sync(QIODNSResolver *resolver,
>                                                  addrs,
>                                                  errp);
>  
> +    case SOCKET_ADDRESS_KIND_FD:
> +        error_setg(errp, "Unsupported socket address type 'fd'");
> +        return -1;
>      default:
> -        error_setg(errp, "Unknown socket address kind");
> -        return -1;
> +        abort();
>      }
>  }

KIND_FD needs to be handled the same way as KIND_UNIX/VSOCK - ie a no-op,
not an error.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
