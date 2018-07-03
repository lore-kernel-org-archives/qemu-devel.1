Received: from eggs.gnu.org ([2001:4830:134:3::10]:57780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faJC5-0002sl-JR
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 07:10:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faJC2-0005zO-Ex
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 07:10:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54070 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faJC2-0005yx-9j
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 07:09:58 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180627204136.4177-1-zhangckid@gmail.com>
	<20180627204136.4177-13-zhangckid@gmail.com>
Date: Tue, 03 Jul 2018 13:09:56 +0200
In-Reply-To: <20180627204136.4177-13-zhangckid@gmail.com> (Zhang Chen's
	message of "Thu, 28 Jun 2018 04:41:28 +0800")
Message-ID: <87po04d18b.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH V9 12/20] qapi: Add new command to query
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

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
> index 8fdb79ac73..eb21978bff 100644
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
> +    case COLO_MODE_NONE:
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
> +    s->active = state == MIGRATION_STATUS_COLO;
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
> index c24f114104..73c64686ec 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1248,6 +1248,40 @@
>  ##
>  { 'command': 'xen-colo-do-checkpoint' }
>  
> +##
> +# @COLOStatus:
> +#
> +# The result format for 'query-colo-status'.
> +#
> +# @mode: COLO running mode. If COLO is running, this field will return
> +#        'primary' or 'secondary'.

Please mention that @mode is "none" when COLO is not running.

> +#
> +# @active: true if COLO is active.

Please use consistent terminology: pick one of "COLO is running", "COLO
is active" and stick to it.  v8 had that here, v9 regressed.  Also use
this wording for the comment improvement I requested for PATCH 11.

However, isn't @active redundant with @mode?

> +#
> +# @reason: describes the reason for the COLO exit.
> +#
> +# Since: 3.0
> +##
> +{ 'struct': 'COLOStatus',
> +  'data': { 'mode': 'COLOMode', 'active': 'bool', 'reason': 'COLOExitReason' } }
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
> +# <- { "return": { "mode": "primary", "active": true, "reason": "request" } }
> +#
> +# Since: 3.0
> +##
> +{ 'command': 'query-colo-status',
> +  'returns': 'COLOStatus' }
> +
>  ##
>  # @migrate-recover:
>  #
