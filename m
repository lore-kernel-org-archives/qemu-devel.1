Received: from eggs.gnu.org ([2001:4830:134:3::10]:34936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cv0BB-0005YG-4J
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cv0B7-0003AM-A4
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:29:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cv0B7-000391-49
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:29:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B74480467
	for <qemu-devel@nongnu.org>; Mon,  3 Apr 2017 11:29:39 +0000 (UTC)
Date: Mon, 3 Apr 2017 12:29:30 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170403112930.GQ2768@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <87var0c5ww.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87var0c5ww.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] qio_dns_resolver_lookup_sync() and
 SOCKET_ADDRESS_KIND_FD?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, Mar 23, 2017 at 05:30:07PM +0100, Markus Armbruster wrote:
> Ignorant question: does qio_dns_resolver_lookup_sync() do the right
> thing for SOCKET_ADDRESS_KIND_FD?  The switch doesn't have a case for
> it, and it's unclear whether the default case is really meant for
> SOCKET_ADDRESS_KIND_FD in addition to impossible enumeration values.

No, it is wrong - it should do a 'no op' resolution, not return an
error - ie KIND_FD handling should match KIND_UNIX/KIND_VSOCK.

> Aside: impossible value means your program state is fatally
> compromised.  I'd rather assert then.

Sure.

> 
> 
> int qio_dns_resolver_lookup_sync(QIODNSResolver *resolver,
>                                  SocketAddress *addr,
>                                  size_t *naddrs,
>                                  SocketAddress ***addrs,
>                                  Error **errp)
> {
>     switch (addr->type) {
>     case SOCKET_ADDRESS_KIND_INET:
>         return qio_dns_resolver_lookup_sync_inet(resolver,
>                                                  addr,
>                                                  naddrs,
>                                                  addrs,
>                                                  errp);
> 
>     case SOCKET_ADDRESS_KIND_UNIX:
>     case SOCKET_ADDRESS_KIND_VSOCK:
>         return qio_dns_resolver_lookup_sync_nop(resolver,
>                                                 addr,
>                                                 naddrs,
>                                                 addrs,
>                                                 errp);
> 
>     default:
>         error_setg(errp, "Unknown socket address kind");
>         return -1;
>     }
> }

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
