Received: from eggs.gnu.org ([2001:4830:134:3::10]:56059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eSSqE-0006r6-3z
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 14:18:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eSSq6-000876-IC
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 14:18:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35014
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eSSq6-00086d-88
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 14:18:38 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBMJEiWM142842
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 14:18:35 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2f15r0xdr7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 14:18:35 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 22 Dec 2017 14:18:34 -0500
References: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CKbAETPvHXVEB36UZFeyDum71_oVQbWFcWwG9Q6h0+aWw@mail.gmail.com>
	<27beee7c-e263-aa6d-69a2-a5eb0f82a5b5@linux.vnet.ibm.com>
	<CAJ+F1CLVpNg8dezRA6wDTAC1dt0pzqEApAhHp+r0B1Rxdoj7yQ@mail.gmail.com>
	<2d4ed601-262f-2fd7-fe50-7c517f7fe172@linux.vnet.ibm.com>
	<CAJ+F1CLuv-QQHLqZYPMJJHNhvobgrDF76j+a7smqux98tN4Tqg@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 22 Dec 2017 14:18:32 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLuv-QQHLqZYPMJJHNhvobgrDF76j+a7smqux98tN4Tqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d58ce3de-a10a-abda-671d-9aeb0da45e4a@linux.vnet.ibm.com>
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
Cc: Amarnath Valluri <amarnath.valluri@intel.com>, QEMU <qemu-devel@nongnu.org>

On 12/22/2017 12:52 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Fri, Dec 22, 2017 at 6:47 PM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> On 12/22/2017 11:13 AM, Marc-Andr=C3=A9 Lureau wrote:
>>> Hi
>>>
>>> On Fri, Dec 22, 2017 at 4:59 PM, Stefan Berger
>>> <stefanb@linux.vnet.ibm.com> wrote:
>>>> On 12/22/2017 07:49 AM, Marc-Andr=C3=A9 Lureau wrote:
>>>>> Hi
>>>>>
>>>>> On Fri, Nov 10, 2017 at 3:11 PM, Stefan Berger
>>>>> <stefanb@linux.vnet.ibm.com> wrote:
>>>>>> This set of patches implements support for migrating the state of =
the
>>>>>> external 'swtpm' TPM emulator as well as that of the emulated devi=
ce
>>>>>> interfaces. I have primarily tested this with the TIS and TPM 1.2 =
so
>>>>>> far, but it also seems to work with TPM 2.
>>>>>>
>>>>>> The TIS is simplified first by reducing the number of buffers and =
read
>>>>>> and write offsets into these buffers. Following the state machine =
of
>>>>>> the
>>>>>> TIS, a single buffer and r/w offset is enough for all localities s=
ince
>>>>>> only one locality can ever be active.
>>>>>>
>>>>>> This series applies on top of my tpm-next branch.
>>>>>>
>>>>>> One of the challenges that is addressed by this set of patches is =
the
>>>>>> fact
>>>>>> that the TPM emulator may be processing a command while the state
>>>>>> serialization of the devices is supposed to happen. A necessary fi=
rst
>>>>>> step
>>>>>> has been implemented here that ensures that a response has been
>>>>>> received
>>>>>> from the exernal emulator and the bottom half function, which deli=
vers
>>>>>> the
>>>>>> response and adjusts device registers (TIS or CRB), has been execu=
ted,
>>>>>> before the device's state is serialized.
>>>>>>
>>>>>> A subsequent extension may need to address the live migration loop=
 and
>>>>>> delay
>>>>>> the serialization of devices until the response from the external =
TPM
>>>>>> has
>>>>>> been received. Though the likelihood that someone executes a
>>>>>> long-lasting
>>>>>> TPM command while this is occurring is certainly rare.
>>>>>>
>>>>>>       Stefan
>>>>>>
>>>>>> Stefan Berger (13):
>>>>>>      tpm_tis: convert uint32_t to size_t
>>>>>>      tpm_tis: limit size of buffer from backend
>>>>>>      tpm_tis: remove TPMSizeBuffer usage
>>>>>>      tpm_tis: move buffers from localities into common location
>>>>>>      tpm_tis: merge read and write buffer into single buffer
>>>>>>      tpm_tis: move r/w_offsets to TPMState
>>>>>>      tpm_tis: merge r/w_offset into rw_offset
>>>>>>      tpm: Implement tpm_sized_buffer_reset
>>>>> ok for the above (you could queue/pull-req this now)
>>>>>
>>>>>>      tpm: Introduce condition to notify waiters of completed comma=
nd
>>>>>>      tpm: Introduce condition in TPM backend for notification
>>>>>>      tpm: implement tpm_backend_wait_cmd_completed
>>>>>>      tpm: extend TPM emulator with state migration support
>>>>>>      tpm_tis: extend TPM TIS with state migration support
>>>>> Much of the complexity from this migration series comes with the
>>>>> handling & synchronization of the IO thread.
>>>>>
>>>>> I think having a seperate thread doesn't bring much today TPM threa=
d.
>>>>> it is a workaround for the chardev API being mostly synchronous. Am=
 I
>>>>> wrong? (yes, passthrough doesn't use chardev, but it should probabl=
y
>>>>> use qio or chardev internally)
>>>>>
>>>>> Other kind of devices using a seperate process suffer the same
>>>>> problem. Just grep for qemu_chr_fe_write and look for the preceding
>>>>> comment, it's a common flaw in qemu code base. Code use the
>>>>> synchronous API, and sometime use non-blocking write
>>>>> (hw/usb/redirect.c seems quite better!)
>>>>>
>>>>> I would like to get rid of the seperate thread in TPM before we add
>>>>> migration support. We should try to improve the chardev API to make=
 it
>>>>> easier to do non-blocking IO. This should considerably simplify the
>>>>> above patches and benefit the rest of qemu (instead of having every=
one
>>>>> doing its own thing with seperate thread or other kind of continuat=
ion
>>>>> state).
>>>>>
>>>>> What do you think?
>>>>
>>>> I am wondering whether it will help us to get rid of the
>>>> conditions/notifications, like patches 9-11 of this series. I doubt =
12
>>>> and
>>>> 13 will change. At some point device state is supposed to be written=
 out
>>>> and
>>>> in case of the TPM we have to wait for the response to have come bac=
k
>>>> into
>>>> the backend. We won't start listening on the file descriptor for an
>>>> outstanding response, so I guess we will still wait for a notificati=
on in
>>>> that case as well. So I am not sure which parts are going to be
>>>> simpler...
>>> Why would qemu need to wait for completion of emulator? Couldn't qemu
>>> & emulator save the current state, including in-flights commands?
>>> That's apparently what usbredir does.
>>
>> How could we make sure whether the PCRExtend has internally completed =
the
>> extensions of the PCR but we haven't received the response yet and wou=
ld
>> just send the same command again? In general, the TPM cannot be sent t=
he
>> same commands twice due to (sevaral) commands (cryptographically) alte=
ring
>> the internal state of the TPM.
>>
> Why would it send the same command again? If the commands is still
> in-flight on emulator side, ex:
>
> - send PCRExtend cmd
> - send SaveState cmd
> - receive SaveState reply
>
> Then the received state should be able to restore the emulator so that
> PCRExtend reply is received after migration.
>
> Wouldn't that work?

If the command has completed entirely, we can also just wait for the=20
response to come back. Otherwise commands could be in the middle of=20
processing and what would we do then? Freeze the CPU state of the=20
process that's executing the swtpm? No, I think we need to wait for the=20
response to come back and then retrieve the state blobs of the TPM.
