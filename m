Received: from eggs.gnu.org ([2001:4830:134:3::10]:35382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eUDBr-00011C-Hm
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 10:00:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eUDBn-0001hA-VM
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 10:00:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eUDBn-0001f9-NL
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 10:00:15 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBRExRTm027300
	for <qemu-devel@nongnu.org>; Wed, 27 Dec 2017 10:00:14 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2f4au79nka-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 27 Dec 2017 10:00:13 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 27 Dec 2017 08:00:12 -0700
References: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CKbAETPvHXVEB36UZFeyDum71_oVQbWFcWwG9Q6h0+aWw@mail.gmail.com>
	<27beee7c-e263-aa6d-69a2-a5eb0f82a5b5@linux.vnet.ibm.com>
	<CAJ+F1CLVpNg8dezRA6wDTAC1dt0pzqEApAhHp+r0B1Rxdoj7yQ@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 27 Dec 2017 10:00:08 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLVpNg8dezRA6wDTAC1dt0pzqEApAhHp+r0B1Rxdoj7yQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <55571e6c-a332-bb3a-2770-e9cb68a0f1fb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/13] tpm: Extend TPM with state
 migration support (not 2.11)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Amarnath Valluri <amarnath.valluri@intel.com>

On 12/22/2017 11:13 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Fri, Dec 22, 2017 at 4:59 PM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> On 12/22/2017 07:49 AM, Marc-Andr=C3=A9 Lureau wrote:
>>> Hi
>>>
>>> On Fri, Nov 10, 2017 at 3:11 PM, Stefan Berger
>>> <stefanb@linux.vnet.ibm.com> wrote:
>>>> This set of patches implements support for migrating the state of th=
e
>>>> external 'swtpm' TPM emulator as well as that of the emulated device
>>>> interfaces. I have primarily tested this with the TIS and TPM 1.2 so
>>>> far, but it also seems to work with TPM 2.
>>>>
>>>> The TIS is simplified first by reducing the number of buffers and re=
ad
>>>> and write offsets into these buffers. Following the state machine of=
 the
>>>> TIS, a single buffer and r/w offset is enough for all localities sin=
ce
>>>> only one locality can ever be active.
>>>>
>>>> This series applies on top of my tpm-next branch.
>>>>
>>>> One of the challenges that is addressed by this set of patches is th=
e
>>>> fact
>>>> that the TPM emulator may be processing a command while the state
>>>> serialization of the devices is supposed to happen. A necessary firs=
t
>>>> step
>>>> has been implemented here that ensures that a response has been rece=
ived
>>>> from the exernal emulator and the bottom half function, which delive=
rs
>>>> the
>>>> response and adjusts device registers (TIS or CRB), has been execute=
d,
>>>> before the device's state is serialized.
>>>>
>>>> A subsequent extension may need to address the live migration loop a=
nd
>>>> delay
>>>> the serialization of devices until the response from the external TP=
M has
>>>> been received. Though the likelihood that someone executes a long-la=
sting
>>>> TPM command while this is occurring is certainly rare.
>>>>
>>>>      Stefan
>>>>
>>>> Stefan Berger (13):
>>>>     tpm_tis: convert uint32_t to size_t
>>>>     tpm_tis: limit size of buffer from backend
>>>>     tpm_tis: remove TPMSizeBuffer usage
>>>>     tpm_tis: move buffers from localities into common location
>>>>     tpm_tis: merge read and write buffer into single buffer
>>>>     tpm_tis: move r/w_offsets to TPMState
>>>>     tpm_tis: merge r/w_offset into rw_offset
>>>>     tpm: Implement tpm_sized_buffer_reset
>>> ok for the above (you could queue/pull-req this now)
>>>
>>>>     tpm: Introduce condition to notify waiters of completed command
>>>>     tpm: Introduce condition in TPM backend for notification
>>>>     tpm: implement tpm_backend_wait_cmd_completed
>>>>     tpm: extend TPM emulator with state migration support
>>>>     tpm_tis: extend TPM TIS with state migration support
>>> Much of the complexity from this migration series comes with the
>>> handling & synchronization of the IO thread.
>>>
>>> I think having a seperate thread doesn't bring much today TPM thread.
>>> it is a workaround for the chardev API being mostly synchronous. Am I
>>> wrong? (yes, passthrough doesn't use chardev, but it should probably
>>> use qio or chardev internally)
>>>
>>> Other kind of devices using a seperate process suffer the same
>>> problem. Just grep for qemu_chr_fe_write and look for the preceding
>>> comment, it's a common flaw in qemu code base. Code use the
>>> synchronous API, and sometime use non-blocking write
>>> (hw/usb/redirect.c seems quite better!)
>>>
>>> I would like to get rid of the seperate thread in TPM before we add
>>> migration support. We should try to improve the chardev API to make i=
t
>>> easier to do non-blocking IO. This should considerably simplify the
>>> above patches and benefit the rest of qemu (instead of having everyon=
e
>>> doing its own thing with seperate thread or other kind of continuatio=
n
>>> state).
>>>
>>> What do you think?
>>
>> I am wondering whether it will help us to get rid of the
>> conditions/notifications, like patches 9-11 of this series. I doubt 12=
 and
>> 13 will change. At some point device state is supposed to be written o=
ut and
>> in case of the TPM we have to wait for the response to have come back =
into
>> the backend. We won't start listening on the file descriptor for an
>> outstanding response, so I guess we will still wait for a notification=
 in
>> that case as well. So I am not sure which parts are going to be simple=
r...
> Why would qemu need to wait for completion of emulator? Couldn't qemu
> & emulator save the current state, including in-flights commands?
> That's apparently what usbredir does.

The thread is sending the commands to the external emulator and waits=20
for the reception of the response. Once the response is received, the=20
delivery of the response is handed off to the bottom half. Using the=20
bottom half avoids synchronization primitives since we know that no=20
other thread is in the device emulator when it runs (except for our=20
thread sending to and receiving from the emulator).

This series of patches introduces a tpm_busy flag that the device=20
emulation thread sets once it hands off a command to the thread for=20
processing. It does this in tpm_backend_deliver_request(). It resets=20
that flag once it has scheduled the bottom half to run for delivering=20
the response to the device emulator (TIS, CRB etc.). This in turn is=20
happening in tpm_backend_worker_thread().

For the migration we have the following cases once the device (frontend=20
or backend) is supposed to write out its state:
[Once the state of the device is supposed to be written out we know what=20
the OS is paused and no further TIS registers will be written to after=20
that and no further thread is busy emulating writes to TIS registers.=20
TIS being an example here for 'device emulation'].

- no TPM command is currently processed: the tpm_busy flag is false and=20
we can write out the state immediately. The .pre_save function does=20
nothing in this case.

- a TPM command is currently processed: we have to wait for the response=20
to come back and the thread to set the tpm_busy flag to false. This is=20
what tpm_backend_wait_cmd_completed() is good for. Once that has=20
happened, the bottom half will have been scheduled by the thread but the=20
bottom half will not run at this point, so we have to do what the bottom=20
half is supposed to do. All this is happening in the .pre_save function.=20
Here we call tpm_backend_wait_cmd_completed() which returns once the=20
response has been received back. We then check a state variable that=20
indicates whether the front-end is executing a command and run the=20
bottom half's function. (Improvement: we could also return true in case=20
we had to wait for the response to come back and avoid the check on the=20
state variable and just run the bottom half's function due to the=20
preceding wait)

Your refactoring has actually helped a lot in simplifying this and=20
pushed a lot of the code into the common tpm_backend_* functions. The=20
code to suspend/resume looks rather simple at this point. It mostly=20
comes down to refactoring the function the bottom half is supposed to=20
run so it can be run from the .pre_save function as well.

TIS:=20
https://github.com/stefanberger/qemu-tpm/commit/3b0689619be9a1f3fbbea2aa2=
f98802512f96099
CRB:=20
https://github.com/stefanberger/qemu-tpm/commit/62db4ace06e77c8e5f8274e8c=
b9240e5f8d663ab
SPAPR:=20
https://github.com/stefanberger/qemu-tpm/commit/1f31cd8b7f690f750405d9119=
23f624b5f856a04

I may now modify tpm_backend_wait_cmd_completed() to 'bool=20
run_bh_function =3D tpm_backend_wait_cmd_completed(s)'. This should help=20
the cause and make the 3 devices' suspend code even look more similar.

Regards,
   Stefan
