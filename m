Received: from eggs.gnu.org ([2001:4830:134:3::10]:46646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fKQ87-0001pM-B9
	for qemu-devel@nongnu.org; Sun, 20 May 2018 11:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fKQ85-0003Qd-PK
	for qemu-devel@nongnu.org; Sun, 20 May 2018 11:20:15 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:56291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fKQ85-0003QB-DW
	for qemu-devel@nongnu.org; Sun, 20 May 2018 11:20:13 -0400
Received: by mail-wm0-x241.google.com with SMTP id a8-v6so21271780wmg.5
	for <qemu-devel@nongnu.org>; Sun, 20 May 2018 08:20:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87bmdeofs7.fsf@dusky.pond.sub.org>
References: <1526268228-27951-1-git-send-email-zhangckid@gmail.com>
	<1526268228-27951-11-git-send-email-zhangckid@gmail.com>
	<87603p6lgf.fsf@dusky.pond.sub.org>
	<CAK3tnvJe-+5uXvFp-83dfCrtyqrJpgkjv8HzEE8NNi0q0NJS6A@mail.gmail.com>
	<87bmdeofs7.fsf@dusky.pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun, 20 May 2018 23:20:10 +0800
Message-ID: <CAK3tnvJ0K+6e1LfRpABGNRbr_EYCajEi5qXg2vwGEV0cLyX8ug@mail.gmail.com>
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Thu, May 17, 2018 at 4:19 PM, Markus Armbruster <armbru@redhat.com>
wrote:

> Zhang Chen <zhangckid@gmail.com> writes:
>
> > On Tue, May 15, 2018 at 10:29 PM, Markus Armbruster <armbru@redhat.com>
> > wrote:
> >
> >> Zhang Chen <zhangckid@gmail.com> writes:
> >>
> >> > From: zhanghailiang <zhang.zhanghailiang@huawei.com>
> >> >
> >> > If some errors happen during VM's COLO FT stage, it's important to
> >> > notify the users of this event. Together with 'x-colo-lost-heartbeat',
> >> > Users can intervene in COLO's failover work immediately.
> >> > If users don't want to get involved in COLO's failover verdict,
> >> > it is still necessary to notify users that we exited COLO mode.
> >> >
> >> > Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> >> > Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> >> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> >> > Reviewed-by: Eric Blake <eblake@redhat.com>
> >> > ---
> >> >  migration/colo.c    | 20 ++++++++++++++++++++
> >> >  qapi/migration.json | 37 +++++++++++++++++++++++++++++++++++++
> >> >  2 files changed, 57 insertions(+)
> >> >
> >> > diff --git a/migration/colo.c b/migration/colo.c
> >> > index c083d36..8ca6381 100644
> >> > --- a/migration/colo.c
> >> > +++ b/migration/colo.c
> >> > @@ -28,6 +28,7 @@
> >> >  #include "net/colo-compare.h"
> >> >  #include "net/colo.h"
> >> >  #include "block/block.h"
> >> > +#include "qapi/qapi-events-migration.h"
> >> >
> >> >  static bool vmstate_loading;
> >> >  static Notifier packets_compare_notifier;
> >> > @@ -514,6 +515,18 @@ out:
> >> >          qemu_fclose(fb);
> >> >      }
> >> >
> >> > +    /*
> >> > +     * There are only two reasons we can go here, some error
> happened.
> >> > +     * Or the user triggered failover.
> >> > +     */
> >> > +    if (failover_get_state() == FAILOVER_STATUS_NONE) {
> >> > +        qapi_event_send_colo_exit(COLO_MODE_PRIMARY,
> >> > +                                  COLO_EXIT_REASON_ERROR, NULL);
> >> > +    } else {
> >> > +        qapi_event_send_colo_exit(COLO_MODE_PRIMARY,
> >> > +                                  COLO_EXIT_REASON_REQUEST, NULL);
> >> > +    }
> >>
> >> Your comment makes me suspect failover_get_state() can only be
> >> FAILOVER_STATUS_NONE or FAILOVER_STATUS_REQUIRE here.  Is that correct?
> >>
> >> If yes, I recommend to add a suitable assertion.
>
> ... to make the possible states immediately obvious.  The fact that you
> felt a need for a comment is further evidence of non-obviousness.
>
> >
> > Yes, and what kinds of 'suitable assertion'? Just for the
> > 'failover_get_state()' ?
>
> Here's one way to skin this cat:
>
>           failover_state = failover_get_state();
>           if (failover_state == FAILOVER_STATUS_NONE) {
>               qapi_event_send_colo_exit(COLO_MODE_PRIMARY,
>                                         COLO_EXIT_REASON_ERROR, NULL);
>           } else {
>               assert(failover_state == FAILOVER_STATUS_REQUIRE);
>               qapi_event_send_colo_exit(COLO_MODE_PRIMARY,
>                                         COLO_EXIT_REASON_REQUEST, NULL);
>           }
>
> Another one:
>
>           switch (failover_get_state() {
>           case FAILOVER_STATUS_NONE:
>               qapi_event_send_colo_exit(COLO_MODE_PRIMARY,
>                                         COLO_EXIT_REASON_ERROR, NULL);
>               break;
>           case FAILOVER_STATUS_REQUIRE:
>               qapi_event_send_colo_exit(COLO_MODE_PRIMARY,
>                                         COLO_EXIT_REASON_REQUEST, NULL);
>               break;
>           default:
>               abort();
>           }
>
> Either way, the possible states are immediately obvious.  The run time
> check is a nice bonus.
>
> With just your comment, the reader still has to make the connection from
> the comment's prose to states, i.e. from "some error happened" to
> FAILOVER_STATUS_NONE, and from "user triggered failover" to
> FAILOVER_STATUS_REQUIRE.
>
> [...]
>


I got it, thanks for your detailed reply.
I will fix it in next version.

Thanks
Zhang Chen
