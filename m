Received: from eggs.gnu.org ([2001:4830:134:3::10]:35285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWMC2-0007aX-PO
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 06:56:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWMBx-000554-Vb
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 06:56:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cWMBx-00054v-Pg
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 06:56:45 -0500
References: <20170124071654.4572.41407.stgit@PASHA-ISP>
	<20170124071713.4572.36636.stgit@PASHA-ISP>
	<96675d3f-9d53-bde1-f6da-7cb0b1f41316@redhat.com>
	<000501d276fb$fbcde7d0$f369b770$@ru>
	<1683a32c-4ea8-c343-e972-095593819121@redhat.com>
	<000601d276fe$e71b9140$b552b3c0$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <10ac3f7d-6ae8-4657-7135-d9a05b5a3d39@redhat.com>
Date: Wed, 25 Jan 2017 12:56:40 +0100
MIME-Version: 1.0
In-Reply-To: <000601d276fe$e71b9140$b552b3c0$@ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 03/14] replay: exception replay fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, kraxel@redhat.com



On 25/01/2017 12:33, Pavel Dovgalyuk wrote:
>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>> On 25/01/2017 12:12, Pavel Dovgalyuk wrote:
>>>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>>>> On 24/01/2017 08:17, Pavel Dovgalyuk wrote:
>>>>> @@ -451,6 +451,10 @@ static inline bool cpu_handle_exception(CPUSta=
te *cpu, int *ret)
>>>>>  #ifndef CONFIG_USER_ONLY
>>>>>      } else if (replay_has_exception()
>>>>>                 && cpu->icount_decr.u16.low + cpu->icount_extra =3D=
=3D 0) {
>>>>> +        /* Break the execution loop in case of running out of TB c=
ache.
>>>>> +           This is needed to make flushing of the TB cache, becaus=
e
>>>>> +           real flush is queued to be executed outside the cpu loo=
p. */
>>>>> +        cpu->exception_index =3D EXCP_INTERRUPT;
>>>>>          /* try to cause an exception pending in the log */
>>>>>          cpu_exec_nocache(cpu, 1, tb_find(cpu, NULL, 0), true);
>>>>>          *ret =3D -1;
>>>>
>>>> Why is replay_has_exception() related to be running out of TB cache?
>>>
>>> It doesn't.
>>> Calling tb_find when there is not space in cache causes tb_flush and =
cpu_loop_exit.
>>> But execution loop will continue, because there is no reason to break=
 it
>>> (like setting exception_index).
>>
>> What about setting cpu->exit_request?  queue_work_on_cpu calls
>> qemu_cpu_kick.
>=20
> cpu->exit_request does not checked in this loop.
> We have to add this checking somewhere then?

It's checked by cpu_handle_interrupt.  Are you not reaching
cpu_handle_interrupt then?  Why?

Or perhaps cpu_handle_interrupt should not be testing cpu->exit_request,
but cpu->exception_index !=3D -1 (and cpu_exit can cmpxchg
cpu->exception_index from -1 to EXCP_INTERRUPT)?

Again, it's hard to follow without knowing the invariants. :(

Paolo
