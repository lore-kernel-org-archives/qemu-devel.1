Received: from eggs.gnu.org ([2001:4830:134:3::10]:41336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dBmG1-0000aq-2W
	for qemu-devel@nongnu.org; Fri, 19 May 2017 14:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dBmFy-0007Rr-Pu
	for qemu-devel@nongnu.org; Fri, 19 May 2017 14:04:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dBmFy-0007Rj-KI
	for qemu-devel@nongnu.org; Fri, 19 May 2017 14:04:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 95070C057FAD
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 18:04:05 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 19 May 2017 19:03:41 +0100
Message-Id: <20170519180342.19618-5-berrange@redhat.com>
In-Reply-To: <20170519180342.19618-1-berrange@redhat.com>
References: <20170519180342.19618-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/5] io: preserve ipv4/ipv6 flags when
 resolving InetSocketAddress
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

The original InetSocketAddress struct may have has_ipv4 and
has_ipv6 fields set, which will control both the ai_family
used during DNS resolution, and later use of the V6ONLY
flag.

Currently the standalone DNS resolver code drops the
has_ipv4 & has_ipv6 flags after resolving, which means
the later bind() code won't correctly set V6ONLY.

This fixes the following scenarios

  -vnc :0,ipv4=off
  -vnc :0,ipv6=on
  -vnc :::0,ipv4=off
  -vnc :::0,ipv6=on

which all mistakenly accepted IPv4 clients

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 io/dns-resolver.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/io/dns-resolver.c b/io/dns-resolver.c
index 57a8896..c072d12 100644
--- a/io/dns-resolver.c
+++ b/io/dns-resolver.c
@@ -116,8 +116,10 @@ static int qio_dns_resolver_lookup_sync_inet(QIODNSResolver *resolver,
             .numeric = true,
             .has_to = iaddr->has_to,
             .to = iaddr->to,
-            .has_ipv4 = false,
-            .has_ipv6 = false,
+            .has_ipv4 = iaddr->has_ipv4,
+            .ipv4 = iaddr->ipv4,
+            .has_ipv6 = iaddr->has_ipv6,
+            .ipv6 = iaddr->ipv6,
         };
 
         (*addrs)[i] = newaddr;
-- 
2.9.3
