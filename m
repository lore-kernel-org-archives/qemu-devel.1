Received: from eggs.gnu.org ([2001:4830:134:3::10]:53203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f8Q0U-0006jp-Oe
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 08:46:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f8Q0P-0001vx-OP
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 08:46:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47982 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f8Q0P-0001ve-JC
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 08:46:41 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1520754314-5969-1-git-send-email-zhangckid@gmail.com>
	<1520754314-5969-13-git-send-email-zhangckid@gmail.com>
Date: Tue, 17 Apr 2018 14:46:30 +0200
In-Reply-To: <1520754314-5969-13-git-send-email-zhangckid@gmail.com> (Zhang
	Chen's message of "Sun, 11 Mar 2018 15:45:08 +0800")
Message-ID: <87lgdmdmqh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH V6 11/17] qapi: Add new command to query
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
Cc: qemu-devel@nongnu.org, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Zhang Chen <zhangckid@gmail.com> writes:

> Libvirt or other high level software can use this command query colo status.
> You can test this command like that:
> {'execute':'query-colo-status'}
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  migration/colo.c    | 31 +++++++++++++++++++++++++++++++
>  qapi/migration.json | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
>
> diff --git a/migration/colo.c b/migration/colo.c
> index 8ca6381..127db3c 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -237,6 +237,37 @@ void qmp_xen_colo_do_checkpoint(Error **errp)
>  #endif
>  }
>  
> +COLOStatus *qmp_query_colo_status(Error **errp)
> +{
> +    MigrationState *m;
> +    MigrationIncomingState *mis;
> +    COLOStatus *s = g_new0(COLOStatus, 1);
> +
> +    if (get_colo_mode() == COLO_MODE_PRIMARY) {
> +        m = migrate_get_current();
> +
> +        if (m->state == MIGRATION_STATUS_COLO) {
> +            s->colo_running = true;
> +        } else {
> +            s->colo_running = false;
> +        }
> +        s->mode = COLO_MODE_PRIMARY;
> +    } else {

Can get_colo_mode() == COLO_MODE_UNKNOWN happen here?  If not, why not?

> +        mis = migration_incoming_get_current();
> +
> +        if (mis->state == MIGRATION_STATUS_COLO) {
> +            s->colo_running = true;
> +        } else {
> +            s->colo_running = false;
> +        }
> +        s->mode = COLO_MODE_SECONDARY;
> +    }

Simpler:

       if (get_colo_mode() == COLO_MODE_PRIMARY) {
           state = migrate_get_current()->state;
       } else {
           state = migration_incoming_get_current()->state;
       }
       s->colo_running = state == MIGRATION_STATUS_COLO;
       s->mode = get_colo_mode();

> +
> +    s->reason = failover_get_state();

COLOStatus member @reason is COLOExitReason, but failover_get_state()
returns FailoverStatus, a different enum.  Am I confused?

> +
> +    return s;
> +}
> +
>  static void colo_send_message(QEMUFile *f, COLOMessage msg,
>                                Error **errp)
>  {
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 6c6c50e..8ccdd21 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1201,3 +1201,36 @@
>  # Since: 2.9
>  ##
>  { 'command': 'xen-colo-do-checkpoint' }
> +
> +##
> +# @COLOStatus:
> +#
> +# The result format for 'query-colo-status'.
> +#
> +# @mode: which COLO mode the VM was in when it exited.

This documents the meaning of @mode "when it exited".  Two questions:

1. What's "it"?  The VM?  COLO?

2. What's the meaning of @mode when "it" hasn't exited, yet?

> +#
> +# @colo-running: if true means COLO running well, otherwise COLO have done.

Suggest

   # @colo-running: true if COLO is running

> +#
> +# @reason: describes the reason for the COLO exit.

If there has been no COLO exit, there can't be a reason for one.  What's
the value of @reason then?  Hmm, peeking at FailoverStatus makes me
guess its @none.  Correct?

> +#
> +# Since: 2.12
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
> +# Since: 2.12
> +##
> +{ 'command': 'query-colo-status',
> +  'returns': 'COLOStatus' }
