Received: from eggs.gnu.org ([2001:4830:134:3::10]:47519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1cnlv7-0006Rp-8p
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:51:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1cnlv4-0003dQ-5a
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:51:21 -0400
Received: from [59.151.112.132] (port=34560 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1cnlv3-0003cq-Of
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:51:18 -0400
Date: Tue, 14 Mar 2017 20:50:45 +0800
From: Chao Fan <fanc.fnst@cn.fujitsu.com>
Message-ID: <20170314125045.GA2473@localhost.localdomain>
References: <20170314123841.2415-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20170314123841.2415-1-fanc.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH] Add dirty-bytes-rate to output in 'info
 migrate'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com, quintela@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org, berrange@redhat.com
Cc: caoj.fnst@cn.fujitsu.com, douly.fnst@cn.fujitsu.com, maozy.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>

Daniel and Juan,

Sorry for this patch, cause I did not see your reply.
So Nack this patch.

And thank you very much.

Thanks,
Chao Fan

On Tue, Mar 14, 2017 at 08:38:41PM +0800, Chao Fan wrote:
>Because 'dirty-bytes-rate' is in 'bytes/s', so it's better for other
>tools to determine the cpu throttle value in different architecture.
>
>Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>---
> hmp.c                 | 6 +++++-
> migration/migration.c | 1 +
> qapi-schema.json      | 5 ++++-
> 3 files changed, 10 insertions(+), 2 deletions(-)
>
>diff --git a/hmp.c b/hmp.c
>index 261843f..c50d7aa 100644
>--- a/hmp.c
>+++ b/hmp.c
>@@ -216,9 +216,13 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>         monitor_printf(mon, "dirty sync count: %" PRIu64 "\n",
>                        info->ram->dirty_sync_count);
>         if (info->ram->dirty_pages_rate) {
>-            monitor_printf(mon, "dirty pages rate: %" PRIu64 " pages\n",
>+            monitor_printf(mon, "dirty pages rate: %" PRIu64 " pages/s\n",
>                            info->ram->dirty_pages_rate);
>         }
>+        if (info->ram->dirty_bytes_rate) {
>+            monitor_printf(mon, "dirty bytes rate: %" PRIu64 " bytes/s\n",
>+                           info->ram->dirty_bytes_rate);
>+        }
>         if (info->ram->postcopy_requests) {
>             monitor_printf(mon, "postcopy request count: %" PRIu64 "\n",
>                            info->ram->postcopy_requests);
>diff --git a/migration/migration.c b/migration/migration.c
>index 3dab684..27f13c7 100644
>--- a/migration/migration.c
>+++ b/migration/migration.c
>@@ -649,6 +649,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
>     if (s->state != MIGRATION_STATUS_COMPLETED) {
>         info->ram->remaining = ram_bytes_remaining();
>         info->ram->dirty_pages_rate = s->dirty_pages_rate;
>+        info->ram->dirty_bytes_rate = s->dirty_bytes_rate;
>     }
> }
> 
>diff --git a/qapi-schema.json b/qapi-schema.json
>index 32b4a4b..0d5ec8e 100644
>--- a/qapi-schema.json
>+++ b/qapi-schema.json
>@@ -575,6 +575,9 @@
> # @postcopy-requests: The number of page requests received from the destination
> #        (since 2.7)
> #
>+# @dirty-bytes-rate: how many bytes dirtied by second by the
>+#        guest (since 2.9)
>+#
> # Since: 0.14.0
> ##
> { 'struct': 'MigrationStats',
>@@ -582,7 +585,7 @@
>            'duplicate': 'int', 'skipped': 'int', 'normal': 'int',
>            'normal-bytes': 'int', 'dirty-pages-rate' : 'int',
>            'mbps' : 'number', 'dirty-sync-count' : 'int',
>-           'postcopy-requests' : 'int' } }
>+           'postcopy-requests' : 'int', 'dirty-bytes-rate' : 'int' } }
> 
> ##
> # @XBZRLECacheStats:
>-- 
>2.9.3
>
