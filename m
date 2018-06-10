Received: from eggs.gnu.org ([2001:4830:134:3::10]:54642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fS44a-0005py-W8
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 13:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fS44Z-0002jp-Nh
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 13:24:12 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:36192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fS44Z-0002j1-CZ
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 13:24:11 -0400
Received: by mail-wm0-x236.google.com with SMTP id v131-v6so12168277wma.1
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 10:24:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87in6uwydk.fsf@dusky.pond.sub.org>
References: <20180603050546.6827-1-zhangckid@gmail.com>
	<20180603050546.6827-11-zhangckid@gmail.com>
	<514033a5-9504-efc2-a208-d38bcff36075@redhat.com>
	<87in6uwydk.fsf@dusky.pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 11 Jun 2018 01:24:09 +0800
Message-ID: <CAK3tnvLBcK9tSnTf_5VctxAZ9hm3K528_FGuZYNyFAV2xS3DUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V8 10/17] qmp event: Add COLO_EXIT event to
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
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

On Thu, Jun 7, 2018 at 8:54 PM, Markus Armbruster <armbru@redhat.com> wrote:

> Eric Blake <eblake@redhat.com> writes:
>
> > On 06/03/2018 12:05 AM, Zhang Chen wrote:
> >> From: zhanghailiang <zhang.zhanghailiang@huawei.com>
> >>
> >> If some errors happen during VM's COLO FT stage, it's important to
> >> notify the users of this event. Together with 'x-colo-lost-heartbeat',
> >> Users can intervene in COLO's failover work immediately.
> >> If users don't want to get involved in COLO's failover verdict,
> >> it is still necessary to notify users that we exited COLO mode.
> >>
> >> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> >> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> >> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> >> Reviewed-by: Eric Blake <eblake@redhat.com>
> >> ---
> >>   migration/colo.c    | 31 +++++++++++++++++++++++++++++++
> >>   qapi/migration.json | 38 ++++++++++++++++++++++++++++++++++++++
> >>   2 files changed, 69 insertions(+)
> >>
> >> diff --git a/migration/colo.c b/migration/colo.c
> >> index c083d3696f..bedb677788 100644
> >> --- a/migration/colo.c
> >
> >>   +    /*
> >> +     * There are only two reasons we can go here, some error happened.
> >> +     * Or the user triggered failover.
> >
> > s/go here/get here/
> > s/happened. Or/happened, or/
> >
> >> +++ b/qapi/migration.json
> >> @@ -880,6 +880,44 @@
> >>   { 'enum': 'FailoverStatus',
> >>     'data': [ 'none', 'require', 'active', 'completed', 'relaunch' ] }
> >> +##
> >> +# @COLO_EXIT:
> >> +#
> >> +# Emitted when VM finishes COLO mode due to some errors happening or
> >> +# at the request of users.
> >> +#
> >> +# @mode: report COLO mode when COLO exited.
> >> +#
> >> +# @reason: describes the reason for the COLO exit.
> >> +#
> >> +# Since: 2.13
> >
> > s/2.13/3.0/
> >
> >> +#
> >> +# Example:
> >> +#
> >> +# <- { "timestamp": {"seconds": 2032141960, "microseconds": 417172},
> >> +#      "event": "COLO_EXIT", "data": {"mode": "primary", "reason":
> "request" } }
> >> +#
> >> +##
> >> +{ 'event': 'COLO_EXIT',
> >> +  'data': {'mode': 'COLOMode', 'reason': 'COLOExitReason' } }
> >> +
> >> +##
> >> +# @COLOExitReason:
> >> +#
> >> +# The reason for a COLO exit
> >> +#
> >> +# @none: no failover has ever happened, This can't occur in the
> COLO_EXIT event,
> >
> > s/happened,/happened./
>
> While there, wrap the line around column 70, please.
>
> >> +# only in the result of query-colo-status.
> >> +#
> >> +# @request: COLO exit is due to an external request
> >> +#
> >> +# @error: COLO exit is due to an internal error
> >> +#
> >> +# Since: 2.13
> >
> > s/2.13/3.0/
> >
> >> +##
> >> +{ 'enum': 'COLOExitReason',
> >> +  'data': [ 'none', 'request', 'error' ] }
> >> +
> >>   ##
> >>   # @x-colo-lost-heartbeat:
> >>   #
> >>
>
> With these touch-ups:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>


I will fixed the typo and addressed comments in next version.
Thanks Markus and Eric.

Thanks
Zhang Chen
