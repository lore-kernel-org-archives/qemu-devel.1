Received: from eggs.gnu.org ([2001:4830:134:3::10]:57829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ffhH8-0005yc-Ub
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ffhH7-000338-Kl
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:53:31 -0400
References: <20180629124052.331406-1-dplotnikov@virtuozzo.com>
	<4eca96cf-5520-fb82-2e23-afff3ba35077@virtuozzo.com>
	<c6f924f2-b70d-a460-f96c-7d40b9d06e22@redhat.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <f81ca741-8f74-8b40-78a9-1d5b8d672e49@virtuozzo.com>
Date: Wed, 18 Jul 2018 10:53:14 +0300
MIME-Version: 1.0
In-Reply-To: <c6f924f2-b70d-a460-f96c-7d40b9d06e22@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block]  [PATCH v0 0/2] Postponed actions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org



On 16.07.2018 21:59, John Snow wrote:
>=20
>=20
> On 07/16/2018 11:01 AM, Denis Plotnikov wrote:
>> Ping!
>>
>=20
> I never saw a reply to Stefan's question on July 2nd, did you reply
> off-list?
For some reason, there are no Stefan's replies on my server. Found it in=20
the web. Will respond to it shortly.

Thanks!

Denis
>=20
> --js
>=20
>> On 29.06.2018 15:40, Denis Plotnikov wrote:
>>> There are cases when a request to a block driver state shouldn't have
>>> appeared producing dangerous race conditions.
>>> This misbehaviour is usually happens with storage devices emulated
>>> without eventfd for guest to host notifications like IDE.
>>>
>>> The issue arises when the context is in the "drained" section
>>> and doesn't expect the request to come, but request comes from the
>>> device not using iothread and which context is processed by the main
>>> loop.
>>>
>>> The main loop apart of the iothread event loop isn't blocked by the
>>> "drained" section.
>>> The request coming and processing while in "drained" section can spoil
>>> the
>>> block driver state consistency.
>>>
>>> This behavior can be observed in the following KVM-based case:
>>>
>>> 1. Setup a VM with an IDE disk.
>>> 2. Inside a VM start a disk writing load for the IDE device
>>>  =C2=A0=C2=A0 e.g: dd if=3D<file> of=3D<file> bs=3DX count=3DY oflag=3D=
direct
>>> 3. On the host create a mirroring block job for the IDE device
>>>  =C2=A0=C2=A0 e.g: drive_mirror <your_IDE> <your_path>
>>> 4. On the host finish the block job
>>>  =C2=A0=C2=A0 e.g: block_job_complete <your_IDE>
>>>  =C2=A0 Having done the 4th action, you could get an assert:
>>> assert(QLIST_EMPTY(&bs->tracked_requests)) from mirror_run.
>>> On my setup, the assert is 1/3 reproducible.
>>>
>>> The patch series introduces the mechanism to postpone the requests
>>> until the BDS leaves "drained" section for the devices not using
>>> iothreads.
>>> Also, it modifies the asynchronous block backend infrastructure to use
>>> that mechanism to release the assert bug for IDE devices.
>>>
>>> Denis Plotnikov (2):
>>>  =C2=A0=C2=A0 async: add infrastructure for postponed actions
>>>  =C2=A0=C2=A0 block: postpone the coroutine executing if the BDS's is d=
rained
>>>
>>>  =C2=A0 block/block-backend.c | 58 ++++++++++++++++++++++++++++++------=
---
>>>  =C2=A0 include/block/aio.h=C2=A0=C2=A0 | 63 ++++++++++++++++++++++++++=
+++++++++++++++++
>>>  =C2=A0 util/async.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 33 +++++++++++++++++++++++
>>>  =C2=A0 3 files changed, 142 insertions(+), 12 deletions(-)
>>>
>>

--=20
Best,
Denis
