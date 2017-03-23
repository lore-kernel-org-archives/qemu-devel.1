Received: from eggs.gnu.org ([2001:4830:134:3::10]:34498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cr5cs-0003Wj-I2
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:30:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cr5cp-00028z-Ds
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:30:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cr5cp-00028i-96
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:30:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41CDB4E34C
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 16:30:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Mar 2017 17:30:07 +0100
Message-ID: <87var0c5ww.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] qio_dns_resolver_lookup_sync() and
 SOCKET_ADDRESS_KIND_FD?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

Ignorant question: does qio_dns_resolver_lookup_sync() do the right
thing for SOCKET_ADDRESS_KIND_FD?  The switch doesn't have a case for
it, and it's unclear whether the default case is really meant for
SOCKET_ADDRESS_KIND_FD in addition to impossible enumeration values.

Aside: impossible value means your program state is fatally
compromised.  I'd rather assert then.


int qio_dns_resolver_lookup_sync(QIODNSResolver *resolver,
                                 SocketAddress *addr,
                                 size_t *naddrs,
                                 SocketAddress ***addrs,
                                 Error **errp)
{
    switch (addr->type) {
    case SOCKET_ADDRESS_KIND_INET:
        return qio_dns_resolver_lookup_sync_inet(resolver,
                                                 addr,
                                                 naddrs,
                                                 addrs,
                                                 errp);

    case SOCKET_ADDRESS_KIND_UNIX:
    case SOCKET_ADDRESS_KIND_VSOCK:
        return qio_dns_resolver_lookup_sync_nop(resolver,
                                                addr,
                                                naddrs,
                                                addrs,
                                                errp);

    default:
        error_setg(errp, "Unknown socket address kind");
        return -1;
    }
}
