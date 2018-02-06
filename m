Received: from eggs.gnu.org ([2001:4830:134:3::10]:55909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eithl-0001tj-FA
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 22:14:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eithk-0004V8-07
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 22:13:57 -0500
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:39552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1eithj-0004Tb-Lu
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 22:13:55 -0500
Received: by mail-wr0-x235.google.com with SMTP id f6so406705wra.6
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 19:13:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87zi4qf4yi.fsf@dusky.pond.sub.org>
References: <1516369485-5374-1-git-send-email-zhangckid@gmail.com>
	<1516369485-5374-11-git-send-email-zhangckid@gmail.com>
	<87zi4qf4yi.fsf@dusky.pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 6 Feb 2018 03:13:53 +0000
Message-ID: <CAK3tnvLsUp8CdpThNMSXR62JRSd1D+wGGZowixJF04CQ6e858g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V4 10/16] qmp event: Add COLO_EXIT event to
 notify users while exited COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Sat, Feb 3, 2018 at 3:49 PM, Markus Armbruster <armbru@redhat.com> wrote:

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
> [...]
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 70e7b67..6fc95b7 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -869,6 +869,41 @@
> >    'data': [ 'none', 'require', 'active', 'completed', 'relaunch' ] }
> >
> >  ##
> > +# @COLO_EXIT:
> > +#
> > +# Emitted when VM finishes COLO mode due to some errors happening or
> > +# at the request of users.
> > +#
> > +# @mode: which COLO mode the VM was in when it exited.
> > +#
> > +# @reason: describes the reason for the COLO exit.
> > +#
> > +# Since: 2.12
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
> Standard question when I see a new event: is there a way to poll for the
> event's information?  If not, why don't we need one?
>
>
Your means is we'd better print the information to a log file or something
like that for all qemu events?
CC  Eric Blake <eblake@redhat.com>
any idea about this?

Thanks
Zhang Chen


> Remember, management applications might miss events when they lose the
> connection and have to reconnect, say because the management application
> needs to be restarted.
>
> > +
> > +##
> > +# @COLOExitReason:
> > +#
> > +# The reason for a COLO exit
> > +#
> > +# @request: COLO exit is due to an external request
> > +#
> > +# @error: COLO exit is due to an internal error
> > +#
> > +# Since: 2.12
> > +##
> > +{ 'enum': 'COLOExitReason',
> > +  'data': [ 'request', 'error' ] }
> > +
> > +##
> >  # @x-colo-lost-heartbeat:
> >  #
> >  # Tell qemu that heartbeat is lost, request it to do takeover
> procedures.
>
