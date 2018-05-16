Received: from eggs.gnu.org ([2001:4830:134:3::10]:51916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fIwFx-0005Kq-PK
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:14:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fIwFv-0007yN-PY
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:14:13 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:41269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fIwFv-0007xu-Et
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:14:11 -0400
Received: by mail-wr0-x242.google.com with SMTP id g21-v6so1067065wrb.8
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 06:14:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <877eo56lmn.fsf@dusky.pond.sub.org>
References: <1526268228-27951-1-git-send-email-zhangckid@gmail.com>
	<1526268228-27951-12-git-send-email-zhangckid@gmail.com>
	<877eo56lmn.fsf@dusky.pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Wed, 16 May 2018 21:14:08 +0800
Message-ID: <CAK3tnvKzxwUGDvHL1u1csJ+gCJS8zxxQzEh6+dVM809z7PwgBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V7 11/17] qapi: Add new command to query
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
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, May 15, 2018 at 10:26 PM, Markus Armbruster <armbru@redhat.com>
wrote:

> Zhang Chen <zhangckid@gmail.com> writes:
>
> > Libvirt or other high level software can use this command query colo
> status.
> > You can test this command like that:
> > {'execute':'query-colo-status'}
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  migration/colo.c    | 34 ++++++++++++++++++++++++++++++++++
> >  qapi/migration.json | 33 +++++++++++++++++++++++++++++++++
> >  2 files changed, 67 insertions(+)
> >
> > diff --git a/migration/colo.c b/migration/colo.c
> > index 8ca6381..314344c 100644
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
> > @@ -237,6 +238,39 @@ void qmp_xen_colo_do_checkpoint(Error **errp)
> >  #endif
> >  }
> >
> > +COLOStatus *qmp_query_colo_status(Error **errp)
> > +{
> > +    int state;
> > +    COLOStatus *s = g_new0(COLOStatus, 1);
> > +
> > +    if (get_colo_mode() == COLO_MODE_UNKNOWN) {
> > +        error_setg(errp, QERR_FEATURE_DISABLED, "colo");
> > +        s->colo_running = false;
> > +        goto out;
> > +    } else if (get_colo_mode() == COLO_MODE_PRIMARY) {
> > +         state = migrate_get_current()->state;
> > +    } else {
> > +         state = migration_incoming_get_current()->state;
> > +    }
>
> Indentation's off, as patchew pointed out.  Perhaps the maintainer could
> fix that for you.
>

I have sent the "RESEND" version fix this problem.


>
> > +    s->colo_running = state == MIGRATION_STATUS_COLO;
> > +
> > +out:
> > +    s->mode = get_colo_mode();
>
> I'm okay with this.
>
> If you need to respin anyway, consider whether you like this better:
>
>        s->mode = get_colo_mode();
>        switch (s->mode) {
>        case COLO_MODE_UNKNOWN:
>            error_setg(errp, "COLO is disabled");
>            state = MIGRATION_STATUS_NONE;
>            break;
>        case COLO_MODE_PRIMARY:
>            state = migrate_get_current()->state;
>            break;
>        case COLO_MODE_SECONDARY:
>            state = migration_incoming_get_current()->state;
>            break;
>        default:
>            abort();
>        }
>        s->colo_running = state == MIGRATION_STATUS_COLO;
>
> Aside: we should really finish off the QERR_ macros.
>

OK, I will remove the QERR_macros and change to this style in next version.


>
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
> > index 55dae48..13589ba 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -1220,3 +1220,36 @@
> >  # Since: 2.9
> >  ##
> >  { 'command': 'xen-colo-do-checkpoint' }
> > +
> > +##
> > +# @COLOStatus:
> > +#
> > +# The result format for 'query-colo-status'.
> > +#
> > +# @mode: which COLO mode the VM was in when it exited.
>
> Pardon my COLO-ignorance...
>
> What does "when it exited" mean?
>

Sorry, this is a typo, change the 'exited' to 'exist'.


>
> What's the value of @mode before "it exited"?
>
> > +# @colo-running: true if COLO is running.
>
> If COLO is running, has "it exited", yet?
>

If COLO running, this field will return 'primary' or 'secondary' mode.


>
> > +#
> > +# @reason: describes the reason for the COLO exit.
>
> What's the value of @reason before a "COLO exit"?
>
> Remember, while a COLO_EXIT event is tied to an exit, a
> query-colo-status can be executed at any time, in particular before any
> "COLO exit".
>

Yes, you are right.

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
>
> Almost ready :)
>
