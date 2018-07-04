Received: from eggs.gnu.org ([2001:4830:134:3::10]:41732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fagr8-0001wp-Mo
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fagr7-0005fN-5t
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:25:58 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:50240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fagr6-0005f0-RI
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:25:57 -0400
Received: by mail-wm0-x22a.google.com with SMTP id v25-v6so5644184wmc.0
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 05:25:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87po04d18b.fsf@dusky.pond.sub.org>
References: <20180627204136.4177-1-zhangckid@gmail.com>
	<20180627204136.4177-13-zhangckid@gmail.com>
	<87po04d18b.fsf@dusky.pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Wed, 4 Jul 2018 20:25:54 +0800
Message-ID: <CAK3tnvJECLWx3H8wBTax+jEiObcq9gX0X8oqx94zXfY0jqbjbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

On Tue, Jul 3, 2018 at 7:09 PM, Markus Armbruster <armbru@redhat.com> wrote:

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
> > index 8fdb79ac73..eb21978bff 100644
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
> > +    case COLO_MODE_NONE:
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
> > +    s->active = state == MIGRATION_STATUS_COLO;
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
> > index c24f114104..73c64686ec 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -1248,6 +1248,40 @@
> >  ##
> >  { 'command': 'xen-colo-do-checkpoint' }
> >
> > +##
> > +# @COLOStatus:
> > +#
> > +# The result format for 'query-colo-status'.
> > +#
> > +# @mode: COLO running mode. If COLO is running, this field will return
> > +#        'primary' or 'secondary'.
>
> Please mention that @mode is "none" when COLO is not running.
>

OK.


>
> > +#
> > +# @active: true if COLO is active.
>
> Please use consistent terminology: pick one of "COLO is running", "COLO
> is active" and stick to it.  v8 had that here, v9 regressed.  Also use
> this wording for the comment improvement I requested for PATCH 11.
>
> However, isn't @active redundant with @mode?
>
>
I re-think about this and review the codes.
The 'none' mode can cover this field, I will remove the @active in next
version.
By the way, can you review the diagram patch as your comments?
(have some action not related to qmp, so I just drew a general diagram.)

Thanks
Zhang Chen



> > +#
> > +# @reason: describes the reason for the COLO exit.
> > +#
> > +# Since: 3.0
> > +##
> > +{ 'struct': 'COLOStatus',
> > +  'data': { 'mode': 'COLOMode', 'active': 'bool', 'reason':
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
> > +# <- { "return": { "mode": "primary", "active": true, "reason":
> "request" } }
> > +#
> > +# Since: 3.0
> > +##
> > +{ 'command': 'query-colo-status',
> > +  'returns': 'COLOStatus' }
> > +
> >  ##
> >  # @migrate-recover:
> >  #
>
