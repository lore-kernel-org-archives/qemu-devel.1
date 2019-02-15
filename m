Received: from eggs.gnu.org ([209.51.188.92]:44197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <v.maffione@gmail.com>) id 1guhZv-0006hl-5D
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:47:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <v.maffione@gmail.com>) id 1guhZu-0002uA-DV
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:47:11 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <v.maffione@gmail.com>)
	id 1guhZu-0002sf-7V
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:47:10 -0500
Received: by mail-wr1-x443.google.com with SMTP id w17so11184192wrn.12
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 09:47:10 -0800 (PST)
From: Vincenzo Maffione <v.maffione@gmail.com>
Date: Fri, 15 Feb 2019 18:46:59 +0100
Message-Id: <20190215174659.4007-2-v.maffione@gmail.com>
In-Reply-To: <20190215174659.4007-1-v.maffione@gmail.com>
References: <20190215174659.4007-1-v.maffione@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 1/1] net: tap: allow net frontends to
 un-negotiate virtio-net header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, Vincenzo Maffione <v.maffione@gmail.com>

The implementation of the TAP net backend already supports the case
(s->host_vnet_hdr_len && !s->using_vnet_hdr), which means that
the TAP device is expecting the header, while the net frontend
(emulated device) is not aware of it. This case is handled by
stripping or prepending the (zeroed) header on the fly.
However, the function tap_using_vnet_hdr() has an assert() that
explicitly prevents this situation to happen.
This patch removes the assert(), so that net frontends are
free to un-negotiate the header.

Signed-off-by: Vincenzo Maffione <v.maffione@gmail.com>
---
 net/tap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/tap.c b/net/tap.c
index cc8525f154..6f2aca0396 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -264,7 +264,6 @@ static void tap_using_vnet_hdr(NetClientState *nc, bool using_vnet_hdr)
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
 
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
-    assert(!!s->host_vnet_hdr_len == using_vnet_hdr);
 
     s->using_vnet_hdr = using_vnet_hdr;
 }
-- 
2.20.1
