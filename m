Received: from eggs.gnu.org ([2001:4830:134:3::10]:54024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQuW6-0003fq-HG
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQuW3-00070r-Dm
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:59:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60808 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fQuW3-00070X-8a
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:59:47 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180603050546.6827-1-zhangckid@gmail.com>
	<20180603050546.6827-12-zhangckid@gmail.com>
Date: Thu, 07 Jun 2018 14:59:45 +0200
In-Reply-To: <20180603050546.6827-12-zhangckid@gmail.com> (Zhang Chen's
	message of "Sun, 3 Jun 2018 13:05:40 +0800")
Message-ID: <87efhiwy4e.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH V8 11/17] qapi: Add new command to query
 colo status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

Zhang Chen <zhangckid@gmail.com> writes:

> Libvirt or other high level software can use this command query colo status.
> You can test this command like that:
> {'execute':'query-colo-status'}
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  migration/colo.c    | 39 +++++++++++++++++++++++++++++++++++++++
>  qapi/migration.json | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 73 insertions(+)
>
> diff --git a/migration/colo.c b/migration/colo.c
> index bedb677788..8c6b8e9a4e 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -29,6 +29,7 @@
>  #include "net/colo.h"
>  #include "block/block.h"
>  #include "qapi/qapi-events-migration.h"
> +#include "qapi/qmp/qerror.h"
>  
>  static bool vmstate_loading;
>  static Notifier packets_compare_notifier;
> @@ -237,6 +238,44 @@ void qmp_xen_colo_do_checkpoint(Error **errp)
>  #endif
>  }
>  
> +COLOStatus *qmp_query_colo_status(Error **errp)
> +{
> +    int state;
> +    COLOStatus *s = g_new0(COLOStatus, 1);
> +
> +    s->mode = get_colo_mode();
> +
> +    switch (s->mode) {
> +    case COLO_MODE_UNKNOWN:
> +        error_setg(errp, "COLO is disabled");
> +        state = MIGRATION_STATUS_NONE;
> +        break;
> +    case COLO_MODE_PRIMARY:
> +        state = migrate_get_current()->state;
> +        break;
> +    case COLO_MODE_SECONDARY:
> +        state = migration_incoming_get_current()->state;
> +        break;
> +    default:
> +        abort();
> +    }
> +
> +    s->colo_running = state == MIGRATION_STATUS_COLO;
> +
> +    switch (failover_get_state()) {
> +    case FAILOVER_STATUS_NONE:
> +        s->reason = COLO_EXIT_REASON_NONE;
> +        break;
> +    case FAILOVER_STATUS_REQUIRE:
> +        s->reason = COLO_EXIT_REASON_REQUEST;
> +        break;
> +    default:
> +        s->reason = COLO_EXIT_REASON_ERROR;
> +    }
> +
> +    return s;
> +}
> +
>  static void colo_send_message(QEMUFile *f, COLOMessage msg,
>                                Error **errp)
>  {
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 93136ce5a0..356a370949 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1231,6 +1231,40 @@
>  ##
>  { 'command': 'xen-colo-do-checkpoint' }
>  
> +##
> +# @COLOStatus:
> +#
> +# The result format for 'query-colo-status'.
> +#
> +# @mode: COLO running mode. If COLO is running, this field will return
> +#        'primary' or 'secodary'.
> +#
> +# @colo-running: true if COLO is running.
> +#
> +# @reason: describes the reason for the COLO exit.

What's the value of @reason before a "COLO exit"?

> +#
> +# Since: 2.13
> +##
> +{ 'struct': 'COLOStatus',
> +  'data': { 'mode': 'COLOMode', 'colo-running': 'bool', 'reason': 'COLOExitReason' } }
> +
> +##
> +# @query-colo-status:
> +#
> +# Query COLO status while the vm is running.
> +#
> +# Returns: A @COLOStatus object showing the status.
> +#
> +# Example:
> +#
> +# -> { "execute": "query-colo-status" }
> +# <- { "return": { "mode": "primary", "colo-running": true, "reason": "request" } }
> +#
> +# Since: 2.13
> +##
> +{ 'command': 'query-colo-status',
> +  'returns': 'COLOStatus' }
> +
>  ##
>  # @migrate-recover:
>  #
