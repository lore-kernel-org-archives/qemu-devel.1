Received: from eggs.gnu.org ([2001:4830:134:3::10]:34729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dAZXI-0003XW-RG
	for qemu-devel@nongnu.org; Tue, 16 May 2017 06:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dAZXD-0001xm-Q2
	for qemu-devel@nongnu.org; Tue, 16 May 2017 06:17:00 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:43244 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dAZXD-0001wH-EW
	for qemu-devel@nongnu.org; Tue, 16 May 2017 06:16:55 -0400
References: <20170512141702.12423-1-vsementsov@virtuozzo.com>
	<8c231084-8eaa-fe66-43cd-4c85f1e45272@redhat.com>
	<005ea4a3-6565-6a56-75de-b6464bcae8fd@virtuozzo.com>
	<0fcdd582-47d1-0206-1c66-d8db615f1174@redhat.com>
	<858a4c56-1f9c-b7a3-fd73-34e4c8b59953@virtuozzo.com>
	<e86ebf22-66ac-759c-c726-390daa2933c2@virtuozzo.com>
	<75da073d-62e8-81ac-990c-aa60aa88dc54@virtuozzo.com>
	<a6f0288b-fe7f-3439-e3e0-5fcf1812201c@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a746364c-2c7c-9cb6-b7e2-b27d42e035b3@virtuozzo.com>
Date: Tue, 16 May 2017 13:16:51 +0300
MIME-Version: 1.0
In-Reply-To: <a6f0288b-fe7f-3439-e3e0-5fcf1812201c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nbd: strict nbd_wr_syncv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: den@openvz.org

16.05.2017 12:51, Paolo Bonzini wrote:
>
> On 16/05/2017 11:32, Vladimir Sementsov-Ogievskiy wrote:
>> 16.05.2017 12:10, Vladimir Sementsov-Ogievskiy wrote:
>>> 15.05.2017 12:43, Vladimir Sementsov-Ogievskiy wrote:
>>>> I mean, make negotiation behave like normal nbd communication,
>>>> non-blocking socket + yield.. So, some other coroutines may do their
>>>> work, while nbd-negotiation coroutine waits for io..
> Some callers of bdrv_open may not allow reentrancy.  For example:
>
> 	handle_qmp_command
> 	-> qmp_dispatch
> 	-> do_qmp_dispatch
> 	-> qmp_marshal_blockdev_add
> 	-> qmp_blockdev_add
> 	-> bds_tree_init
> 	-> bdrv_open
>
> You cannot return to the monitor before qmp_blockdev_add is done,
> otherwise you don't have a return value for handle_qmp_command to pass
> to monitor_json_emitter.

Hmm. What about something like bdrv_pread (finally, bdrv_prwv_co) for 
non-coroutine, ie, calling aio_poll in a while loop, until coroutine 
finishes?

>
>>> Also, one more question here: in nbd_negotiate_write(), why do we need
>>> qio_channel_add_watch? write_sync will yield with qio_channel_yield()
>>> until io complete, why to use 2 mechanisms to wake up a coroutine?
>> Hmm, these nbd_negotiate_* functions was introduced in 1a6245a5b, when
>> nbd_wr_syncv was working through qemu_co_sendv_recvv, which just yields,
>> without setting any handlers. But now, nbd_wr_syncv works through
>> qio_channel_yield() which sets handlers, so the code with extra watchers
>> looks wrong.
> Yes, I think you're right about that.

Ok, I'll make a patch for it and finish LOG->errp conversion.

>
> Paolo


-- 
Best regards,
Vladimir
