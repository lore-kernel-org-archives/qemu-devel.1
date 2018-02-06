Received: from eggs.gnu.org ([2001:4830:134:3::10]:52818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eixfX-0005Vy-Nc
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 02:27:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eixfU-0001Oz-GJ
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 02:27:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eixfU-0001NY-8r
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 02:27:52 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1516369485-5374-1-git-send-email-zhangckid@gmail.com>
	<1516369485-5374-11-git-send-email-zhangckid@gmail.com>
	<87zi4qf4yi.fsf@dusky.pond.sub.org>
	<CAK3tnvLsUp8CdpThNMSXR62JRSd1D+wGGZowixJF04CQ6e858g@mail.gmail.com>
Date: Tue, 06 Feb 2018 08:27:48 +0100
In-Reply-To: <CAK3tnvLsUp8CdpThNMSXR62JRSd1D+wGGZowixJF04CQ6e858g@mail.gmail.com>
	(Zhang Chen's message of "Tue, 6 Feb 2018 03:13:53 +0000")
Message-ID: <87po5ifuh7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Zhang Chen <zhangckid@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

Zhang Chen <zhangckid@gmail.com> writes:

> On Sat, Feb 3, 2018 at 3:49 PM, Markus Armbruster <armbru@redhat.com> wrote:
>
>> Zhang Chen <zhangckid@gmail.com> writes:
>>
>> > From: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> >
>> > If some errors happen during VM's COLO FT stage, it's important to
>> > notify the users of this event. Together with 'x-colo-lost-heartbeat',
>> > Users can intervene in COLO's failover work immediately.
>> > If users don't want to get involved in COLO's failover verdict,
>> > it is still necessary to notify users that we exited COLO mode.
>> >
>> > Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> > Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>> > Reviewed-by: Eric Blake <eblake@redhat.com>
>> [...]
>> > diff --git a/qapi/migration.json b/qapi/migration.json
>> > index 70e7b67..6fc95b7 100644
>> > --- a/qapi/migration.json
>> > +++ b/qapi/migration.json
>> > @@ -869,6 +869,41 @@
>> >    'data': [ 'none', 'require', 'active', 'completed', 'relaunch' ] }
>> >
>> >  ##
>> > +# @COLO_EXIT:
>> > +#
>> > +# Emitted when VM finishes COLO mode due to some errors happening or
>> > +# at the request of users.
>> > +#
>> > +# @mode: which COLO mode the VM was in when it exited.
>> > +#
>> > +# @reason: describes the reason for the COLO exit.
>> > +#
>> > +# Since: 2.12
>> > +#
>> > +# Example:
>> > +#
>> > +# <- { "timestamp": {"seconds": 2032141960, "microseconds": 417172},
>> > +#      "event": "COLO_EXIT", "data": {"mode": "primary", "reason": "request" } }
>> > +#
>> > +##
>> > +{ 'event': 'COLO_EXIT',
>> > +  'data': {'mode': 'COLOMode', 'reason': 'COLOExitReason' } }
>>
>> Standard question when I see a new event: is there a way to poll for the
>> event's information?  If not, why don't we need one?
>>
>>
> Your means is we'd better print the information to a log file or something
> like that for all qemu events?
> CC  Eric Blake <eblake@redhat.com>
> any idea about this?

Events carrying state change information management applications want to
track are generally paired with a query- command.  While the management
application is connected, it can track by passively listening for state
change events.  After (re)connect, it has to actively query the current
state.

Questions?

>> Remember, management applications might miss events when they lose the
>> connection and have to reconnect, say because the management application
>> needs to be restarted.
>>
>> > +
>> > +##
>> > +# @COLOExitReason:
>> > +#
>> > +# The reason for a COLO exit
>> > +#
>> > +# @request: COLO exit is due to an external request
>> > +#
>> > +# @error: COLO exit is due to an internal error
>> > +#
>> > +# Since: 2.12
>> > +##
>> > +{ 'enum': 'COLOExitReason',
>> > +  'data': [ 'request', 'error' ] }
>> > +
>> > +##
>> >  # @x-colo-lost-heartbeat:
>> >  #
>> >  # Tell qemu that heartbeat is lost, request it to do takeover procedures.
