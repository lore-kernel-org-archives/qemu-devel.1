Received: from eggs.gnu.org ([2001:4830:134:3::10]:45627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1f9wda-00041C-Ay
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 13:49:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1f9wdY-0007Mj-Qe
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 13:49:26 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:39508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1f9wdY-0007K4-E0
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 13:49:24 -0400
Received: by mail-wr0-x234.google.com with SMTP id q3-v6so20558981wrj.6
	for <qemu-devel@nongnu.org>; Sat, 21 Apr 2018 10:49:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87lgdmdmqh.fsf@dusky.pond.sub.org>
References: <1520754314-5969-1-git-send-email-zhangckid@gmail.com>
	<1520754314-5969-13-git-send-email-zhangckid@gmail.com>
	<87lgdmdmqh.fsf@dusky.pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun, 22 Apr 2018 01:49:22 +0800
Message-ID: <CAK3tnv+TZLhHiXpQjPibxHQuBh-+cP23jSK_9+yVNZ+ftaciEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Apr 17, 2018 at 8:46 PM, Markus Armbruster <armbru@redhat.com>
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
> >  migration/colo.c    | 31 +++++++++++++++++++++++++++++++
> >  qapi/migration.json | 33 +++++++++++++++++++++++++++++++++
> >  2 files changed, 64 insertions(+)
> >
> > diff --git a/migration/colo.c b/migration/colo.c
> > index 8ca6381..127db3c 100644
> > --- a/migration/colo.c
> > +++ b/migration/colo.c
> > @@ -237,6 +237,37 @@ void qmp_xen_colo_do_checkpoint(Error **errp)
> >  #endif
> >  }
> >
> > +COLOStatus *qmp_query_colo_status(Error **errp)
> > +{
> > +    MigrationState *m;
> > +    MigrationIncomingState *mis;
> > +    COLOStatus *s = g_new0(COLOStatus, 1);
> > +
> > +    if (get_colo_mode() == COLO_MODE_PRIMARY) {
> > +        m = migrate_get_current();
> > +
> > +        if (m->state == MIGRATION_STATUS_COLO) {
> > +            s->colo_running = true;
> > +        } else {
> > +            s->colo_running = false;
> > +        }
> > +        s->mode = COLO_MODE_PRIMARY;
> > +    } else {
>
> Can get_colo_mode() == COLO_MODE_UNKNOWN happen here?  If not, why not?
>

Good catch, I will check it in next version.


>
> > +        mis = migration_incoming_get_current();
> > +
> > +        if (mis->state == MIGRATION_STATUS_COLO) {
> > +            s->colo_running = true;
> > +        } else {
> > +            s->colo_running = false;
> > +        }
> > +        s->mode = COLO_MODE_SECONDARY;
> > +    }
>
> Simpler:
>
>        if (get_colo_mode() == COLO_MODE_PRIMARY) {
>            state = migrate_get_current()->state;
>        } else {
>            state = migration_incoming_get_current()->state;
>        }
>        s->colo_running = state == MIGRATION_STATUS_COLO;
>        s->mode = get_colo_mode();
>

Good idea. I will use this codes in next version.
By the way, do I need add your SOB?


>
> > +
> > +    s->reason = failover_get_state();
>
> COLOStatus member @reason is COLOExitReason, but failover_get_state()
> returns FailoverStatus, a different enum.  Am I confused?
>

No, here I want to reused the FailoverStatus, but missed something in
rebase progress.
I will make FailoverStatus's @none = COLOExitReason's @none,
                  FailoverStatus's @requre = COLOExitReason's @request
                  FailoverStatus's other status = COLOExitReason's @error.
in next version.



>
> > +
> > +    return s;
> > +}
> > +
> >  static void colo_send_message(QEMUFile *f, COLOMessage msg,
> >                                Error **errp)
> >  {
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 6c6c50e..8ccdd21 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -1201,3 +1201,36 @@
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
> This documents the meaning of @mode "when it exited".  Two questions:
>
> 1. What's "it"?  The VM?  COLO?
>

COLO.


>
> 2. What's the meaning of @mode when "it" hasn't exited, yet?
>

Just return the COLO running mode(primary, secondary or unknown) when COLO
hasn't exited.


>
> > +#
> > +# @colo-running: if true means COLO running well, otherwise COLO have
> done.
>
> Suggest
>
>    # @colo-running: true if COLO is running
>
> > +#
> > +# @reason: describes the reason for the COLO exit.
>
> If there has been no COLO exit, there can't be a reason for one.  What's
> the value of @reason then?  Hmm, peeking at FailoverStatus makes me
> guess its @none.  Correct?
>

Yes, you are right. I will fix it in next version.

Thanks your comments.
Zhang Chen



>
> > +#
> > +# Since: 2.12
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
> > +# Since: 2.12
> > +##
> > +{ 'command': 'query-colo-status',
> > +  'returns': 'COLOStatus' }
>
