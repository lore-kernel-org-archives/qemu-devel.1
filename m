Received: from eggs.gnu.org ([2001:4830:134:3::10]:53755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eoRUC-0004hp-0T
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 05:19:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eoRUA-0001Wa-1Z
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 05:18:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52288 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eoRU9-0001WS-Tm
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 05:18:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96CF69BB57
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 10:18:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 21 Feb 2018 11:18:33 +0100
Message-Id: <1519208316-18812-5-git-send-email-thuth@redhat.com>
In-Reply-To: <1519208316-18812-1-git-send-email-thuth@redhat.com>
References: <1519208316-18812-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/7] net: Make net_client_init() static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

The function is only used within net.c, so there's no need that
this is a global function.

While we're at it, also remove the unused prototype compute_mcast_idx()
(the function has been removed in commit d9caeb09b107e91122d10ba4a08a).

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/net/net.h | 2 --
 net/net.c         | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index bdd4d9f..cd1708c 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -204,7 +204,6 @@ extern const char *host_net_devices[];
 extern const char *legacy_tftp_prefix;
 extern const char *legacy_bootp_filename;
 
-int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp);
 int net_client_parse(QemuOptsList *opts_list, const char *str);
 int net_init_clients(Error **errp);
 void net_check_clients(void);
@@ -228,7 +227,6 @@ void qdev_set_nic_properties(DeviceState *dev, NICInfo *nd);
 #define POLYNOMIAL_LE 0xedb88320
 uint32_t net_crc32(const uint8_t *p, int len);
 uint32_t net_crc32_le(const uint8_t *p, int len);
-unsigned compute_mcast_idx(const uint8_t *ep);
 
 #define vmstate_offset_macaddr(_state, _field)                       \
     vmstate_offset_array(_state, _field.a, uint8_t,                \
diff --git a/net/net.c b/net/net.c
index cf07e15..dd80f1b 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1119,7 +1119,7 @@ static void show_netdevs(void)
     }
 }
 
-int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp)
+static int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp)
 {
     void *object = NULL;
     Error *err = NULL;
-- 
1.8.3.1
