Received: from eggs.gnu.org ([2001:4830:134:3::10]:32889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1csXL0-0007rN-Cc
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:17:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1csXKv-0002z4-CC
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:17:46 -0400
Received: from mail-db5eur01on0114.outbound.protection.outlook.com
	([104.47.2.114]:52352
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1csXKu-0002sS-O2
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:17:41 -0400
References: <1490628915-19459-1-git-send-email-den@openvz.org>
	<accb1519-45c3-e287-0408-7c02c9714ed2@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <c15d21d5-71ea-2454-d4fc-48e4cec9408a@openvz.org>
Date: Mon, 27 Mar 2017 19:17:28 +0300
MIME-Version: 1.0
In-Reply-To: <accb1519-45c3-e287-0408-7c02c9714ed2@redhat.com>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC for 2.9 1/1] block: add missed
 aio_context_acquire into blk_unref
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 03/27/2017 06:45 PM, Max Reitz wrote:
> @Subject: Do you mean "PATCH for-2.9?"? Because "RFC" to me means
> "please do not merge". ;-)
>
> I wouldn't mind a change like this to go into 2.9.
I am quite sure that problem is here but unsure about the place.
Here I use term 'RFC' as 'Can we start the discussion'?


> On 27.03.2017 17:35, Denis V. Lunev wrote:
>> Recently we expirience hang with iothreads enabled with the following
>> call trace:
>> Thread 1 (Thread 0x7fa95efebc80 (LWP 177117)):
>> 0  ppoll () from /lib64/libc.so.6
>> 2  qemu_poll_ns () at qemu-timer.c:313
>> 3  aio_poll () at aio-posix.c:457
>> 4  bdrv_flush () at block/io.c:2641
>> 5  bdrv_close () at block.c:2143
>> 6  bdrv_delete () at block.c:2352
>> 7  bdrv_unref () at block.c:3429
>> 8  blk_remove_bs () at block/block-backend.c:427
>> 9  blk_delete () at block/block-backend.c:178
>> 10 blk_unref () at block/block-backend.c:226
>> 11 object_property_del_all () at qom/object.c:399
>> 12 object_finalize () at qom/object.c:461
>> 13 object_unref () at qom/object.c:898
>> 14 object_property_del_child () at qom/object.c:422
>> 15 qmp_marshal_device_del () at qmp-marshal.c:1145
>> 16 handle_qmp_command () at /usr/src/debug/qemu-2.6.0/monitor.c:3929
>>
>> Technically bdrv_flush() stucks in
>>     while (rwco.ret =3D=3D NOT_DONE) {
>>         aio_poll(aio_context, true);
>>     }
>> but rwco.ret is equal to 0 thus we have missed wakeup. Code investigat=
ion
>> reveals that we do not have performed aio_context_acquire() on this ca=
ll
>> stack.
>>
>> This patch adds missed lock.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Max Reitz <mreitz@redhat.com>
>> CC: Eric Blake <eblake@redhat.com>
>> CC: Markus Armbruster <armbru@redhat.com>
>> ---
>>  block/block-backend.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/block/block-backend.c b/block/block-backend.c
>> index 5742c09..65d5da9 100644
>> --- a/block/block-backend.c
>> +++ b/block/block-backend.c
>> @@ -273,7 +273,11 @@ void blk_unref(BlockBackend *blk)
>>      if (blk) {
>>          assert(blk->refcnt > 0);
>>          if (!--blk->refcnt) {
>> +            AioContext *ctx =3D blk_get_aio_context(blk);
>> +
>> +            aio_context_acquire(ctx);
>>              blk_delete(blk);
>> +            aio_context_release(ctx);
> But I don't think this is quite the correct place. The caller of
> blk_unref() should have acquired the AioContext already. As far as I ca=
n
> tell in this case that would be originally release_drive() in
> hw/core/qdev-properties-system.c and then blk_detach_dev().
>
> I think the former would be the somehow more correct place but I can
> imagine the latter to be more useful in reality. I'll leave it to you.
>
> (As an alternative, you may of course convince me that this patch is
> indeed correct and should be taken as-is. :-))
ha-ha ;) no, I not going to try to convince you and that is why the
patch was
marked as RFC. I like release_drive() place. This should solve the proble=
m
for me.

Thank you for the quick answer and good proposal.

Den
