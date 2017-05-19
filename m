Received: from eggs.gnu.org ([2001:4830:134:3::10]:41274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dBmFu-0000VL-Vk
	for qemu-devel@nongnu.org; Fri, 19 May 2017 14:04:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dBmFu-0007QI-8G
	for qemu-devel@nongnu.org; Fri, 19 May 2017 14:04:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dBmFu-0007Q5-2W
	for qemu-devel@nongnu.org; Fri, 19 May 2017 14:04:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E90A80F6C
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 18:04:01 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 19 May 2017 19:03:39 +0100
Message-Id: <20170519180342.19618-3-berrange@redhat.com>
In-Reply-To: <20170519180342.19618-1-berrange@redhat.com>
References: <20170519180342.19618-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/5] sockets: don't block IPv4 clients when
 listening on "::"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

When inet_parse() parses the hostname, it is forcing the
has_ipv6 && ipv6 flags if the address contains a ":". This
means that if the user had set the ipv4=on flag, to try to
restrict the listener to just ipv4, an error would not have
been raised.  eg

   -incoming tcp:[::]:9000,ipv4

should have raised an error because listening for IPv4
on "::" is a non-sensical combination. With this removed,
we now call getaddrinfo() on "::" passing PF_INET and
so getaddrinfo reports an error about the hostname being
incompatible with the requested protocol.

Likewise it is explicitly setting the has_ipv4 & ipv4
flags when the address contains only digits + '.'. This
has no ill-effect, but also has no benefit, so is removed.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 util/qemu-sockets.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 397212b..b82412e 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -618,16 +618,12 @@ int inet_parse(InetSocketAddress *addr, const char *str, Error **errp)
             error_setg(errp, "error parsing IPv6 address '%s'", str);
             return -1;
         }
-        addr->ipv6 = addr->has_ipv6 = true;
     } else {
         /* hostname or IPv4 addr */
         if (sscanf(str, "%64[^:]:%32[^,]%n", host, port, &pos) != 2) {
             error_setg(errp, "error parsing address '%s'", str);
             return -1;
         }
-        if (host[strspn(host, "0123456789.")] == '\0') {
-            addr->ipv4 = addr->has_ipv4 = true;
-        }
     }
 
     addr->host = g_strdup(host);
-- 
2.9.3
