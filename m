Received: from eggs.gnu.org ([2001:4830:134:3::10]:40186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cvQG5-0007Dg-B7
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cvQG4-0005j1-Kn
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:20:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cvQG4-0005iT-EJ
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:20:36 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  4 Apr 2017 16:20:11 +0100
Message-Id: <20170404152011.16119-3-berrange@redhat.com>
In-Reply-To: <20170404152011.16119-1-berrange@redhat.com>
References: <20170404152011.16119-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 2/2] io: fix FD socket handling in DNS lookup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

The qio_dns_resolver_lookup_sync() method is required to be a no-op
for socket kinds that don't require name resolution. Thus the KIND_FD
handling should not return an error.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 io/dns-resolver.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/io/dns-resolver.c b/io/dns-resolver.c
index a407075..759d1b4 100644
--- a/io/dns-resolver.c
+++ b/io/dns-resolver.c
@@ -158,16 +158,13 @@ int qio_dns_resolver_lookup_sync(QIODNSResolver *resolver,
 
     case SOCKET_ADDRESS_KIND_UNIX:
     case SOCKET_ADDRESS_KIND_VSOCK:
+    case SOCKET_ADDRESS_KIND_FD:
         return qio_dns_resolver_lookup_sync_nop(resolver,
                                                 addr,
                                                 naddrs,
                                                 addrs,
                                                 errp);
 
-    case SOCKET_ADDRESS_KIND_FD:
-        error_setg(errp, "Unsupported socket address type 'fd'");
-        return -1;
-
     default:
         abort();
     }
-- 
2.9.3
