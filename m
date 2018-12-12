Received: from eggs.gnu.org ([2001:4830:134:3::10]:52772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6N9-0001NL-Jj
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6N6-0000h9-CX
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:27 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:40851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6N5-0000Yq-Vk
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:24 -0500
Received: by mail-wm1-x336.google.com with SMTP id q26so6346596wmf.5
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:24:11 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	u10sm15878859wrr.33.2018.12.12.07.24.09 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 12 Dec 2018 07:24:09 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:23:09 +0100
Message-Id: <1544628195-37728-49-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 48/54] vhost-user: support cross-endian vnet
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

vhost-user already has a way to communicate the endianness of the guest
via the vring endianness messages.  The vring endianness always matches
the vnet header endianness so there is no need to do anything else in
the backend.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1543851204-41186-9-git-send-email-pbonzini@redhat.com>
---
 net/vhost-user.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/vhost-user.c b/net/vhost-user.c
index a39f9c9..cd9659d 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -172,6 +172,17 @@ static void net_vhost_user_cleanup(NetClientState *nc)
     qemu_purge_queued_packets(nc);
 }
 
+static int vhost_user_set_vnet_endianness(NetClientState *nc,
+                                          bool enable)
+{
+    /* Nothing to do.  If the server supports
+     * VHOST_USER_PROTOCOL_F_CROSS_ENDIAN, it will get the
+     * vnet header endianness from there.  If it doesn't, negotiation
+     * fails.
+     */
+    return 0;
+}
+
 static bool vhost_user_has_vnet_hdr(NetClientState *nc)
 {
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_USER);
@@ -193,6 +204,8 @@ static NetClientInfo net_vhost_user_info = {
         .cleanup = net_vhost_user_cleanup,
         .has_vnet_hdr = vhost_user_has_vnet_hdr,
         .has_ufo = vhost_user_has_ufo,
+        .set_vnet_be = vhost_user_set_vnet_endianness,
+        .set_vnet_le = vhost_user_set_vnet_endianness,
 };
 
 static gboolean net_vhost_user_watch(GIOChannel *chan, GIOCondition cond,
-- 
1.8.3.1
