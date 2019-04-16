Received: from eggs.gnu.org ([209.51.188.92]:52909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.streetman@canonical.com>) id 1hGT6V-0001fc-7F
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:46:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.streetman@canonical.com>) id 1hGT6U-0005dp-6B
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:46:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dan.streetman@canonical.com>)
	id 1hGT6T-0005Zp-Tf
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:46:46 -0400
Received: from mail-yw1-f72.google.com ([209.85.161.72])
	by youngberry.canonical.com with esmtps
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <dan.streetman@canonical.com>) id 1hGT6S-00007J-TV
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 18:46:45 +0000
Received: by mail-yw1-f72.google.com with SMTP id g140so16214059ywb.12
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 11:46:44 -0700 (PDT)
From: Dan Streetman <dan.streetman@canonical.com>
Date: Tue, 16 Apr 2019 14:46:24 -0400
Message-Id: <20190416184624.15397-3-dan.streetman@canonical.com>
In-Reply-To: <20190416184624.15397-1-dan.streetman@canonical.com>
References: <20190416184624.15397-1-dan.streetman@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/2] do not call vhost_net_cleanup() on running
 net from char user event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org

From: Dan Streetman <ddstreet@canonical.com>

Buglink: https://launchpad.net/bugs/1823458

Currently, a user CHR_EVENT_CLOSED event will cause net_vhost_user_event()
to call vhost_user_cleanup(), which calls vhost_net_cleanup() for all
its queues.  However, vhost_net_cleanup() must never be called like
this for fully-initialized nets; when other code later calls
vhost_net_stop() - such as from virtio_net_vhost_status() - it will try
to access the already-cleaned-up fields and fail with assertion errors
or segfaults.

The vhost_net_cleanup() will eventually be called from
qemu_cleanup_net_client().

Signed-off-by: Dan Streetman <ddstreet@canonical.com>
---
 net/vhost-user.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/vhost-user.c b/net/vhost-user.c
index 5a26a24708..51921de443 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -236,7 +236,6 @@ static void chr_closed_bh(void *opaque)
     s = DO_UPCAST(NetVhostUserState, nc, ncs[0]);
 
     qmp_set_link(name, false, &err);
-    vhost_user_stop(queues, ncs);
 
     qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, net_vhost_user_event,
                              NULL, opaque, NULL, true);
-- 
2.20.1
