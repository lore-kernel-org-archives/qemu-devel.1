Received: from eggs.gnu.org ([209.51.188.92]:57836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1ghqSB-0002eu-RB
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 01:38:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1ghqS9-0007gK-NH
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 01:38:03 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:46000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1ghqS9-0007dk-9i
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 01:38:01 -0500
Received: by mail-pl1-x634.google.com with SMTP id a14so6316509plm.12
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 22:37:57 -0800 (PST)
From: guangrong.xiao@gmail.com
Date: Fri, 11 Jan 2019 14:37:31 +0800
Message-Id: <20190111063732.10484-3-xiaoguangrong@tencent.com>
In-Reply-To: <20190111063732.10484-1-xiaoguangrong@tencent.com>
References: <20190111063732.10484-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v2 2/3] migration: fix memory leak when
 updating tls-creds and tls-hostname
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, eblake@redhat.com, quintela@redhat.com, cota@braap.org, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

If we update parameter, tls-creds and tls-hostname, these string
values are duplicated to local variables in migrate_params_test_apply()
by using g_strdup(), however these new allocated memory are missed to
be freed

Actually, they are not used to check anything, we can directly skip
them

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/migration.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index a82d594f29..fb39d7bec1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1145,16 +1145,6 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
         dest->cpu_throttle_increment = params->cpu_throttle_increment;
     }
 
-    if (params->has_tls_creds) {
-        assert(params->tls_creds->type == QTYPE_QSTRING);
-        dest->tls_creds = g_strdup(params->tls_creds->u.s);
-    }
-
-    if (params->has_tls_hostname) {
-        assert(params->tls_hostname->type == QTYPE_QSTRING);
-        dest->tls_hostname = g_strdup(params->tls_hostname->u.s);
-    }
-
     if (params->has_max_bandwidth) {
         dest->max_bandwidth = params->max_bandwidth;
     }
-- 
2.14.5
