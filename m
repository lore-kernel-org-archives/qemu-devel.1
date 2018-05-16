Received: from eggs.gnu.org ([2001:4830:134:3::10]:58793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fIwge-0005sg-Db
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:41:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fIwgc-000661-Jk
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:41:48 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:42535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fIwgc-00065f-8U
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:41:46 -0400
Received: by mail-wr0-x244.google.com with SMTP id v5-v6so1238271wrf.9
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 06:41:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87603p6lgf.fsf@dusky.pond.sub.org>
References: <1526268228-27951-1-git-send-email-zhangckid@gmail.com>
	<1526268228-27951-11-git-send-email-zhangckid@gmail.com>
	<87603p6lgf.fsf@dusky.pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Wed, 16 May 2018 21:41:44 +0800
Message-ID: <CAK3tnvJe-+5uXvFp-83dfCrtyqrJpgkjv8HzEE8NNi0q0NJS6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V7 10/17] qmp event: Add COLO_EXIT event to
 notify users while exited COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, May 15, 2018 at 10:29 PM, Markus Armbruster <armbru@redhat.com>
wrote:

> Zhang Chen <zhangckid@gmail.com> writes:
>
> > From: zhanghailiang <zhang.zhanghailiang@huawei.com>
> >
> > If some errors happen during VM's COLO FT stage, it's important to
> > notify the users of this event. Together with 'x-colo-lost-heartbeat',
> > Users can intervene in COLO's failover work immediately.
> > If users don't want to get involved in COLO's failover verdict,
> > it is still necessary to notify users that we exited COLO mode.
> >
> > Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> > Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > ---
> >  migration/colo.c    | 20 ++++++++++++++++++++
> >  qapi/migration.json | 37 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 57 insertions(+)
> >
> > diff --git a/migration/colo.c b/migration/colo.c
> > index c083d36..8ca6381 100644
> > --- a/migration/colo.c
> > +++ b/migration/colo.c
> > @@ -28,6 +28,7 @@
> >  #include "net/colo-compare.h"
> >  #include "net/colo.h"
> >  #include "block/block.h"
> > +#include "qapi/qapi-events-migration.h"
> >
> >  static bool vmstate_loading;
> >  static Notifier packets_compare_notifier;
> > @@ -514,6 +515,18 @@ out:
> >          qemu_fclose(fb);
> >      }
> >
> > +    /*
> > +     * There are only two reasons we can go here, some error happened.
> > +     * Or the user triggered failover.
> > +     */
> > +    if (failover_get_state() == FAILOVER_STATUS_NONE) {
> > +        qapi_event_send_colo_exit(COLO_MODE_PRIMARY,
> > +                                  COLO_EXIT_REASON_ERROR, NULL);
> > +    } else {
> > +        qapi_event_send_colo_exit(COLO_MODE_PRIMARY,
> > +                                  COLO_EXIT_REASON_REQUEST, NULL);
> > +    }
>
> Your comment makes me suspect failover_get_state() can only be
> FAILOVER_STATUS_NONE or FAILOVER_STATUS_REQUIRE here.  Is that correct?
>
> If yes, I recommend to add a suitable assertion.
>

Yes, and what kinds of 'suitable assertion'? Just for the
'failover_get_state()' ?



>
> > +
> >      /* Hope this not to be too long to wait here */
> >      qemu_sem_wait(&s->colo_exit_sem);
> >      qemu_sem_destroy(&s->colo_exit_sem);
> > @@ -744,6 +757,13 @@ out:
> >      if (local_err) {
> >          error_report_err(local_err);
> >      }
> > +    if (failover_get_state() == FAILOVER_STATUS_NONE) {
> > +        qapi_event_send_colo_exit(COLO_MODE_SECONDARY,
> > +                                  COLO_EXIT_REASON_ERROR, NULL);
> > +    } else {
> > +        qapi_event_send_colo_exit(COLO_MODE_SECONDARY,
> > +                                  COLO_EXIT_REASON_REQUEST, NULL);
> > +    }
>
> Same question.
>
> >
> >      if (fb) {
> >          qemu_fclose(fb);
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index f3974c6..55dae48 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -875,6 +875,43 @@
> >    'data': [ 'none', 'require', 'active', 'completed', 'relaunch' ] }
> >
> >  ##
> > +# @COLO_EXIT:
> > +#
> > +# Emitted when VM finishes COLO mode due to some errors happening or
> > +# at the request of users.
> > +#
> > +# @mode: report COLO mode when COLO exited.
> > +#
> > +# @reason: describes the reason for the COLO exit.
> > +#
> > +# Since: 2.13
> > +#
> > +# Example:
> > +#
> > +# <- { "timestamp": {"seconds": 2032141960, "microseconds": 417172},
> > +#      "event": "COLO_EXIT", "data": {"mode": "primary", "reason":
> "request" } }
> > +#
> > +##
> > +{ 'event': 'COLO_EXIT',
> > +  'data': {'mode': 'COLOMode', 'reason': 'COLOExitReason' } }
>
> 'data' duplicates the next patch's ColoStatus, except it lacks
> @colo-running.  Factoring out the common part doesn't seem worth the
> bother.  Okay as is.
>
> > +
> > +##
> > +# @COLOExitReason:
> > +#
> > +# The reason for a COLO exit
> > +#
> > +# @none: no failover has ever happened.
>
> This can't occur in the COLO_EXIT event, only in the result of
> query-colo-status, can it?


Yes.


> Worth spelling that out in the documentation?
>
>
OK, I will add more comments here in next version.

Thanks
Zhang Chen



> > +#
> > +# @request: COLO exit is due to an external request
> > +#
> > +# @error: COLO exit is due to an internal error
> > +#
> > +# Since: 2.13
> > +##
> > +{ 'enum': 'COLOExitReason',
> > +  'data': [ 'none', 'request', 'error' ] }
> > +
> > +##
> >  # @x-colo-lost-heartbeat:
> >  #
> >  # Tell qemu that heartbeat is lost, request it to do takeover
> procedures.
>
