Received: from eggs.gnu.org ([2001:4830:134:3::10]:59338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1fuBbV-0001FP-GM
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1fuBbQ-0001VV-HQ
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:06:25 -0400
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
References: <20180629124052.331406-1-dplotnikov@virtuozzo.com>
	<4eca96cf-5520-fb82-2e23-afff3ba35077@virtuozzo.com>
	<c6f924f2-b70d-a460-f96c-7d40b9d06e22@redhat.com>
	<7da20590-58d7-4ef0-92b9-fcb955f28c9b@virtuozzo.com>
	<20180813163048.GO4323@localhost.localdomain>
	<ae864bb4-257e-240c-eeab-3c9c13462c0d@virtuozzo.com>
Message-ID: <4dcf31f4-b2e0-e3cf-47ac-a9e745a9e2d8@virtuozzo.com>
Date: Mon, 27 Aug 2018 10:05:54 +0300
MIME-Version: 1.0
In-Reply-To: <ae864bb4-257e-240c-eeab-3c9c13462c0d@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v0 0/2] Postponed actions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: famz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org, stefanha@redhat.com, mreitz@redhat.com, John Snow <jsnow@redhat.com>

PING! PING!

On 14.08.2018 10:08, Denis Plotnikov wrote:
>=20
>=20
> On 13.08.2018 19:30, Kevin Wolf wrote:
>> Am 13.08.2018 um 10:32 hat Denis Plotnikov geschrieben:
>>> Ping ping!
>>>
>>> On 16.07.2018 21:59, John Snow wrote:
>>>>
>>>>
>>>> On 07/16/2018 11:01 AM, Denis Plotnikov wrote:
>>>>> Ping!
>>>>>
>>>>
>>>> I never saw a reply to Stefan's question on July 2nd, did you reply
>>>> off-list?
>>>>
>>>> --js
>>> Yes, I did. I talked to Stefan why the patch set appeared.
>>
>> The rest of us still don't know the answer. I had the same question.
>>
>> Kevin
> Yes, that's my fault. I should have post it earlier.
>=20
> I reviewed the problem once again and come up with the following=20
> explanation.
> Indeed, if the global lock has been taken by the main thread the vCPU=20
> threads won't be able to execute mmio ide.
> But, if the main thread will release the lock then nothing will prevent
> vCPU threads form execution what they want, e.g writing to the block=20
> device.
>=20
> In case of running the mirroring it is possible. Let's take a look
> at the following snippet of mirror_run. This is a part the mirroring=20
> completion part.
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_=
drained_begin(bs);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cnt =
=3D bdrv_get_dirty_count(s->dirty_bitmap);
>  >>>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cnt > 0 || mirror_flush(s) < 0)=
 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bdrv_drained_end(bs);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 continue;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> (X) >>>>=C2=A0=C2=A0=C2=A0 assert(QLIST_EMPTY(&bs->tracked_requests));
>=20
> mirror_flush here can yield the current coroutine so nothing more can be=
=20
> executed.
> We could end up with the situation when the main loop have to revolve to=
=20
> poll for another timer/bh to process. While revolving it releases the=20
> global lock. If the global lock is waited for by a vCPU (any other)=20
> thread, the waiting thread will get the lock and make what it intends.
>=20
> This is something that I can observe:
>=20
> mirror_flush yields coroutine, the main thread revolves and locks=20
> because a vCPU was waiting for the lock. Now the vCPU thread owns the=20
> lock and the main thread waits for the lock releasing.
> The vCPU thread does cmd_write_dma and releases the lock. Then, the main
> thread gets the lock and continues to run eventually proceeding with the=
=20
> coroutine yeiled.
> If the vCPU requests aren't completed by the moment we will assert at=20
> (X). If the vCPU requests are completed we won't even notice that we had=
=20
> some writes while in the drained section.
>=20
> Denis
>>
>>>>> On 29.06.2018 15:40, Denis Plotnikov wrote:
>>>>>> There are cases when a request to a block driver state shouldn't hav=
e
>>>>>> appeared producing dangerous race conditions.
>>>>>> This misbehaviour is usually happens with storage devices emulated
>>>>>> without eventfd for guest to host notifications like IDE.
>>>>>>
>>>>>> The issue arises when the context is in the "drained" section
>>>>>> and doesn't expect the request to come, but request comes from the
>>>>>> device not using iothread and which context is processed by the main
>>>>>> loop.
>>>>>>
>>>>>> The main loop apart of the iothread event loop isn't blocked by the
>>>>>> "drained" section.
>>>>>> The request coming and processing while in "drained" section can=20
>>>>>> spoil
>>>>>> the
>>>>>> block driver state consistency.
>>>>>>
>>>>>> This behavior can be observed in the following KVM-based case:
>>>>>>
>>>>>> 1. Setup a VM with an IDE disk.
>>>>>> 2. Inside a VM start a disk writing load for the IDE device
>>>>>> =C2=A0 =C2=A0=C2=A0 e.g: dd if=3D<file> of=3D<file> bs=3DX count=3DY=
 oflag=3Ddirect
>>>>>> 3. On the host create a mirroring block job for the IDE device
>>>>>> =C2=A0 =C2=A0=C2=A0 e.g: drive_mirror <your_IDE> <your_path>
>>>>>> 4. On the host finish the block job
>>>>>> =C2=A0 =C2=A0=C2=A0 e.g: block_job_complete <your_IDE>
>>>>>> =C2=A0 =C2=A0 Having done the 4th action, you could get an assert:
>>>>>> assert(QLIST_EMPTY(&bs->tracked_requests)) from mirror_run.
>>>>>> On my setup, the assert is 1/3 reproducible.
>>>>>>
>>>>>> The patch series introduces the mechanism to postpone the requests
>>>>>> until the BDS leaves "drained" section for the devices not using
>>>>>> iothreads.
>>>>>> Also, it modifies the asynchronous block backend infrastructure to=20
>>>>>> use
>>>>>> that mechanism to release the assert bug for IDE devices.
>>>>>>
>>>>>> Denis Plotnikov (2):
>>>>>> =C2=A0 =C2=A0=C2=A0 async: add infrastructure for postponed actions
>>>>>> =C2=A0 =C2=A0=C2=A0 block: postpone the coroutine executing if the B=
DS's is drained
>>>>>>
>>>>>> =C2=A0 =C2=A0 block/block-backend.c | 58=20
>>>>>> ++++++++++++++++++++++++++++++---------
>>>>>> =C2=A0 =C2=A0 include/block/aio.h=C2=A0=C2=A0 | 63=20
>>>>>> +++++++++++++++++++++++++++++++++++++++++++
>>>>>> =C2=A0 =C2=A0 util/async.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 33 +++++++++++++++++++++++
>>>>>> =C2=A0 =C2=A0 3 files changed, 142 insertions(+), 12 deletions(-)
>>>>>>
>>>>>
>>>
>>> --=20
>>> Best,
>>> Denis
>=20

--=20
Best,
Denis
