Received: from eggs.gnu.org ([2001:4830:134:3::10]:56234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fS4J3-0007i3-NP
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 13:39:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fS4J2-0007yn-Ay
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 13:39:09 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:39286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fS4J1-0007y0-Vb
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 13:39:08 -0400
Received: by mail-wr0-x22f.google.com with SMTP id w7-v6so18004294wrn.6
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 10:39:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87efhiwy4e.fsf@dusky.pond.sub.org>
References: <20180603050546.6827-1-zhangckid@gmail.com>
	<20180603050546.6827-12-zhangckid@gmail.com>
	<87efhiwy4e.fsf@dusky.pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 11 Jun 2018 01:39:06 +0800
Message-ID: <CAK3tnvJ9W7fUxYBDYLcwhtDwruSh28HVo96dHyXfrBhYB9QB9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

On Thu, Jun 7, 2018 at 8:59 PM, Markus Armbruster <armbru@redhat.com> wrote:

> Zhang Chen <zhangckid@gmail.com> writes:
>
> > Libvirt or other high level software can use this command query colo
> status.
> > You can test this command like that:
> > {'execute':'query-colo-status'}
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  migration/colo.c    | 39 +++++++++++++++++++++++++++++++++++++++
> >  qapi/migration.json | 34 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 73 insertions(+)
> >
> > diff --git a/migration/colo.c b/migration/colo.c
> > index bedb677788..8c6b8e9a4e 100644
> > --- a/migration/colo.c
> > +++ b/migration/colo.c
> > @@ -29,6 +29,7 @@
> >  #include "net/colo.h"
> >  #include "block/block.h"
> >  #include "qapi/qapi-events-migration.h"
> > +#include "qapi/qmp/qerror.h"
> >
> >  static bool vmstate_loading;
> >  static Notifier packets_compare_notifier;
> > @@ -237,6 +238,44 @@ void qmp_xen_colo_do_checkpoint(Error **errp)
> >  #endif
> >  }
> >
> > +COLOStatus *qmp_query_colo_status(Error **errp)
> > +{
> > +    int state;
> > +    COLOStatus *s = g_new0(COLOStatus, 1);
> > +
> > +    s->mode = get_colo_mode();
> > +
> > +    switch (s->mode) {
> > +    case COLO_MODE_UNKNOWN:
> > +        error_setg(errp, "COLO is disabled");
> > +        state = MIGRATION_STATUS_NONE;
> > +        break;
> > +    case COLO_MODE_PRIMARY:
> > +        state = migrate_get_current()->state;
> > +        break;
> > +    case COLO_MODE_SECONDARY:
> > +        state = migration_incoming_get_current()->state;
> > +        break;
> > +    default:
> > +        abort();
> > +    }
> > +
> > +    s->colo_running = state == MIGRATION_STATUS_COLO;
> > +
> > +    switch (failover_get_state()) {
> > +    case FAILOVER_STATUS_NONE:
> > +        s->reason = COLO_EXIT_REASON_NONE;
> > +        break;
> > +    case FAILOVER_STATUS_REQUIRE:
> > +        s->reason = COLO_EXIT_REASON_REQUEST;
> > +        break;
> > +    default:
> > +        s->reason = COLO_EXIT_REASON_ERROR;
> > +    }
> > +
> > +    return s;
> > +}
> > +
> >  static void colo_send_message(QEMUFile *f, COLOMessage msg,
> >                                Error **errp)
> >  {
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 93136ce5a0..356a370949 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -1231,6 +1231,40 @@
> >  ##
> >  { 'command': 'xen-colo-do-checkpoint' }
> >
> > +##
> > +# @COLOStatus:
> > +#
> > +# The result format for 'query-colo-status'.
> > +#
> > +# @mode: COLO running mode. If COLO is running, this field will return
> > +#        'primary' or 'secodary'.
> > +#
> > +# @colo-running: true if COLO is running.
> > +#
> > +# @reason: describes the reason for the COLO exit.
>
> What's the value of @reason before a "COLO exit"?
>

Before a "COLO exit", we just return 'none' in this field.

Thanks
Zhang Chen


>
> > +#
> > +# Since: 2.13
> > +##
> > +{ 'struct': 'COLOStatus',
> > +  'data': { 'mode': 'COLOMode', 'colo-running': 'bool', 'reason':
> 'COLOExitReason' } }
> > +
> > +##
> > +# @query-colo-status:
> > +#
> > +# Query COLO status while the vm is running.
> > +#
> > +# Returns: A @COLOStatus object showing the status.
> > +#
> > +# Example:
> > +#
> > +# -> { "execute": "query-colo-status" }
> > +# <- { "return": { "mode": "primary", "colo-running": true, "reason":
> "request" } }
> > +#
> > +# Since: 2.13
> > +##
> > +{ 'command': 'query-colo-status',
> > +  'returns': 'COLOStatus' }
> > +
> >  ##
> >  # @migrate-recover:
> >  #
>
