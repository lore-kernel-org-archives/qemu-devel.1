Received: from eggs.gnu.org ([2001:4830:134:3::10]:40176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1df3v4-0004jR-2c
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1df3v2-0003Ay-BD
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:47:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1df3v1-00039w-Q2
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:47:32 -0400
References: <20170713190116.21608-1-dgilbert@redhat.com>
	<20170717101703.GH7163@stefanha-x1.localdomain>
	<20170717102642.GG2106@work-vm>
	<c6161e7a-9b03-16bf-fb20-86df6f3fd9bc@redhat.com>
	<CAJSP0QWd7gtV21Hpr3noA0odAMhdriNkaqJtLJvbSNzoErvFdQ@mail.gmail.com>
	<9e79cd50-c23a-2b96-4206-f505993179f5@redhat.com>
	<20170808100243.GG4850@dhcp-200-186.str.redhat.com>
	<5a5542b7-bc68-c032-24ea-12821b8b6a1a@redhat.com>
	<20170808115652.GH4850@dhcp-200-186.str.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4d03893e-9c10-4191-19c0-6e2d5f84ad84@redhat.com>
Date: Tue, 8 Aug 2017 14:47:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170808115652.GH4850@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vl.c/exit: pause cpus before closing block
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, John Snow <jsnow@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Prasad Pandit <ppandit@redhat.com>

On 08/08/2017 13:56, Kevin Wolf wrote:
> Am 08.08.2017 um 13:04 hat Paolo Bonzini geschrieben:
>> On 08/08/2017 12:02, Kevin Wolf wrote:
>>> Am 04.08.2017 um 13:46 hat Paolo Bonzini geschrieben:
>>>> On 04/08/2017 11:58, Stefan Hajnoczi wrote:
>>>>>> the root cause of this bug is related to this as well:
>>>>>> https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg02945.htm=
l
>>>>>>
>>>>>> From commit 99723548 we started assuming (incorrectly?) that blk_
>>>>>> functions always WILL have an attached BDS, but this is not always=
 true,
>>>>>> for instance, flushing the cache from an empty CDROM.
>>>>>>
>>>>>> Paolo, can we move the flight counter increment outside of the
>>>>>> block-backend layer, is that safe?
>>>>> I think the bdrv_inc_in_flight(blk_bs(blk)) needs to be fixed
>>>>> regardless of the throttling timer issue discussed below.  BB canno=
t
>>>>> assume that the BDS graph is non-empty.
>>>>
>>>> Can we make bdrv_aio_* return NULL (even temporarily) if there is no
>>>> attached BDS?  That would make it much easier to fix.
>>>
>>> Would the proper fix be much more complicated than the following? I m=
ust
>>> admit that I don't fully understand the current state of affairs with
>>> respect to threading, AioContext etc. so I may well be missing
>>> something.
>>
>> Not much, but it's not complete either.  The issues I see are that: 1)
>> blk_drain_all does not take the new counter into account;
>=20
> Ok, I think this does the trick:
>=20
> void blk_drain_all(void)
> {
>     BlockBackend *blk =3D NULL;
>=20
>     bdrv_drain_all_begin();
>     while ((blk =3D blk_all_next(blk)) !=3D NULL) {
>         blk_drain(blk);
>     }
>     bdrv_drain_all_end();
> }

Small note: blk_drain_all is called while no AioContext has been
acquired, while blk_drain requires you to acquire blk's AioContext.

And this of course should be split in blk_drain_all_begin/blk_drain_all_e=
nd.

>> 2) bdrv_drain_all callers need to be audited to see if they should be
>> blk_drain_all (or more likely, only device BlockBackends should be dra=
ined).
>=20
> qmp_transaction() is unclear to me. It should be changed in some way
> anyway because it uses bdrv_drain_all() rather than a begin/end pair.

I think every ->prepare should do drained_begin and ->clean should end
the section.  Most of them are doing it already.

> do_vm_stop() and vm_stop_force_state() probably want blk_drain_all().

Or just all devices.  From the October 2016 discussion, "qdev
drive properties would install a vmstate notifier to quiesce their own
BlockBackend rather than relying on a blind bdrv_drain_all from vm_stop"
(though there'll surely be some non-qdevified straggler).

> xen_invalidate_map_cache() - wtf? Looks like the wrong layer to do this=
,
> but I guess blk_drain_all(), too.

It seems to be an advisory operation triggered by balloon deflation.
Whatever.

> block_migration_cleanup() is just lazy and really means a blk_drain()
> for its own BlockBackends. blk_drain_all() as the simple conversion.
>=20
> migration/savevm: Migration wants blk_drain_all() to get the devices
> quiesced.

It already does vm_stop though.  It doesn't seem to be necessary at all.

> qemu-io: blk_drain_all(), too.

Or just blk_drain(qemuio_blk).

> Hm, looks like there won't be many callers of bdrv_drain_all() left. :-=
)

Not many blk_drain_all(), and that's not a bad thing.

You missed bdrv_reopen_multiple.  Maybe it also should not do anything,
and the caller should do begin/end instead.

>>> Note that my blk_drain() implementation doesn't necessarily drain
>>> blk_bs(blk) completely, but only those requests that came from the
>>> specific BlockBackend. I think this is what the callers want, but
>>> if otherwise, it shouldn't be hard to change.
>>
>> Yes, this should be what they want.
>=20
> Apparently not; block jobs don't complete with it any more. I haven't
> checked in detail, but it makes sense that they can have a BH (e.g. for
> block_job_defer_to_main_loop) without a request being in flight.

That BH should be handled here:

    while (!job->completed) {
        aio_poll(qemu_get_aio_context(), true);
    }

so that should be okay.  (Block jobs have been a huge pain every time I
touched bdrv_drain, indeed...).

> So I'm including an unconditional bdrv_drain() again. Or I guess,
> calling aio_poll() unconditionally and including its return value
> in the loop condition would be the cleaner approach?

Note that if you have no block device then you don't have an AioContext
for aio_poll() to use.  In fact, we're really close to removing the
AioContext dependency for submitting I/O requests (AioContext remains
only as a place for network drivers to register their sockets' I/O
handlers), so you shouldn't use it from block-backend.c.

That's why I suggested returning NULL from AIO operations if there is no
blk_bs(blk).  It may be a little less tidy (I'm more worried about
static analysis lossage than anything else), but it does make some
sense.  Most callers are checking blk_is_available or blk_is_inserted
already, which explains why we're not seeing more crashes in
block-backend.c.

If you can set aside the blk_bs(blk) =3D=3D NULL case, you're basically
reinventing BDRV_POLL_WHILE at this point.  If you add a bdrv_wakeup to
blk_dec_in_flight, and use BDRV_POLL_WHILE in blk_drain, then things
should in theory just work (though most likely they won't for some
reason that takes hours to debug).

Paolo
