Received: from eggs.gnu.org ([2001:4830:134:3::10]:43640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dXMep-0004Hs-1W
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 03:11:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dXMek-0000d3-RC
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 03:10:58 -0400
Received: from [59.151.112.132] (port=2079 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dXMek-0000XC-46
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 03:10:54 -0400
References: <1500279971-13875-1-git-send-email-peterx@redhat.com>
	<1500279971-13875-9-git-send-email-peterx@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <e300ce3f-b8ed-8d71-4888-2e875e84bce7@cn.fujitsu.com>
Date: Tue, 18 Jul 2017 15:13:11 +0800
MIME-Version: 1.0
In-Reply-To: <1500279971-13875-9-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 08/11] migration: remove check against
 colo support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: zhangchen.fnst@cn.fujitsu.com, Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Hailiang Zhang <zhang.zhanghailiang@huawei.com>



On 07/17/2017 04:26 PM, Peter Xu wrote:
> Since commit a15215f3 ("build: remove --enable-colo/--disable-colo"),
> colo is always supported. We don't need any colo_supported() now since
> it is always true. Removing any extra code that depends on it.
>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

COLO running well.

Reviewed-by: Zhang Chen<zhangchen.fnst@cn.fujitsu.com>


Thanks
Zhang Chen

> ---
>   include/migration/colo.h |  1 -
>   migration/colo.c         |  5 -----
>   migration/migration.c    | 11 -----------
>   3 files changed, 17 deletions(-)
>
> diff --git a/include/migration/colo.h b/include/migration/colo.h
> index be6beba..ff9874e 100644
> --- a/include/migration/colo.h
> +++ b/include/migration/colo.h
> @@ -15,7 +15,6 @@
>   
>   #include "qemu-common.h"
>   
> -bool colo_supported(void);
>   void colo_info_init(void);
>   
>   void migrate_start_colo_process(MigrationState *s);
> diff --git a/migration/colo.c b/migration/colo.c
> index ef35f00..a425543 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -29,11 +29,6 @@ static bool vmstate_loading;
>   
>   #define COLO_BUFFER_BASE_SIZE (4 * 1024 * 1024)
>   
> -bool colo_supported(void)
> -{
> -    return true;
> -}
> -
>   bool migration_in_colo_state(void)
>   {
>       MigrationState *s = migrate_get_current();
> diff --git a/migration/migration.c b/migration/migration.c
> index 5a7f22c..eb750c5 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -403,9 +403,6 @@ MigrationCapabilityStatusList *qmp_query_migrate_capabilities(Error **errp)
>               continue;
>           }
>   #endif
> -        if (i == MIGRATION_CAPABILITY_X_COLO && !colo_supported()) {
> -            continue;
> -        }
>           if (head == NULL) {
>               head = g_malloc0(sizeof(*caps));
>               caps = head;
> @@ -604,14 +601,6 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
>               continue;
>           }
>   #endif
> -        if (cap->value->capability == MIGRATION_CAPABILITY_X_COLO) {
> -            if (!colo_supported()) {
> -                error_setg(errp, "COLO is not currently supported, please"
> -                             " configure with --enable-colo option in order to"
> -                             " support COLO feature");
> -                continue;
> -            }
> -        }
>           s->enabled_capabilities[cap->value->capability] = cap->value->state;
>       }
>   

-- 
Thanks
Zhang Chen
