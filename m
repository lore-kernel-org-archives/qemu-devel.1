Received: from eggs.gnu.org ([2001:4830:134:3::10]:45389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eMW9T-0003gf-Th
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:38:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eMW9P-0006Rx-0k
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:38:03 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:43552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eMW9O-0006Rm-SO
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:37:58 -0500
Received: by mail-ua0-f196.google.com with SMTP id e10so2363474uah.10
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 01:37:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <60c91bd3021b2e98e2a6c24d28509476@ispras.ru>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
	<151127345586.6888.4109654104815822158.stgit@Misha-PC.lan02.inno>
	<CABdb736HfN5GK1QZX4vsDKSUr_fGHXX9SA-gd85PdA20Duys3Q@mail.gmail.com>
	<60c91bd3021b2e98e2a6c24d28509476@ispras.ru>
From: Ladi Prosek <lprosek@redhat.com>
Date: Wed, 6 Dec 2017 10:37:57 +0100
Message-ID: <CABdb7347AvjOUQHGhyOpzx3p8rNmBiTkuH+=UjMc2EaD8WzsEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 39/45] windbg: implemented
 kd_api_get_version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, sw@weilnetz.de, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On Wed, Dec 6, 2017 at 10:00 AM, Mihail Abakumov
<mikhail.abakumov@ispras.ru> wrote:
> Ladi Prosek =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2017-11-29 11:14:
>
>> On Tue, Nov 21, 2017 at 3:10 PM, Mihail Abakumov
>> <mikhail.abakumov@ispras.ru> wrote:
>>>
>>> Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
>>> Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
>>> Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
>>> ---
>>>  include/exec/windbgstub-utils.h |    1 +
>>>  windbgstub-utils.c              |   22 ++++++++++++++++++++++
>>>  windbgstub.c                    |    4 ++++
>>>  3 files changed, 27 insertions(+)
>>>
>>> diff --git a/include/exec/windbgstub-utils.h
>>> b/include/exec/windbgstub-utils.h
>>> index be48f69f40..bc5b6a8468 100755
>>> --- a/include/exec/windbgstub-utils.h
>>> +++ b/include/exec/windbgstub-utils.h
>>> @@ -99,6 +99,7 @@ void kd_api_read_io_space(CPUState *cpu, PacketData
>>> *pd);
>>>  void kd_api_write_io_space(CPUState *cpu, PacketData *pd);
>>>  void kd_api_read_physical_memory(CPUState *cpu, PacketData *pd);
>>>  void kd_api_write_physical_memory(CPUState *cpu, PacketData *pd);
>>> +void kd_api_get_version(CPUState *cpu, PacketData *pd);
>>>  void kd_api_unsupported(CPUState *cpu, PacketData *pd);
>>>
>>>  SizedBuf kd_gen_exception_sc(CPUState *cpu);
>>> diff --git a/windbgstub-utils.c b/windbgstub-utils.c
>>> index 6708e62798..7ef301bac7 100755
>>> --- a/windbgstub-utils.c
>>> +++ b/windbgstub-utils.c
>>> @@ -239,6 +239,28 @@ void kd_api_write_physical_memory(CPUState *cpu,
>>> PacketData *pd)
>>>      stl_p(&mem->ActualBytesWritten, len);
>>>  }
>>>
>>> +void kd_api_get_version(CPUState *cpu, PacketData *pd)
>>> +{
>>> +    DBGKD_GET_VERSION64 *kdver;
>>> +    int err =3D cpu_memory_rw_debug(cpu, version.addr, PTR(pd->m64) +
>>> 0x10,
>>> +                                  sizeof(DBGKD_MANIPULATE_STATE64) -
>>> 0x10, 0);
>>> +    if (!err) {
>>> +        kdver =3D (DBGKD_GET_VERSION64 *) (PTR(pd->m64) + 0x10);
>>> +
>>> +        stw_p(&kdver->MajorVersion, kdver->MajorVersion);
>>> +        stw_p(&kdver->MinorVersion, kdver->MinorVersion);
>>> +        stw_p(&kdver->Flags, kdver->Flags);
>>> +        stw_p(&kdver->MachineType, kdver->MachineType);
>>> +        stw_p(&kdver->Unused[0], kdver->Unused[0]);
>>> +        sttul_p(&kdver->KernBase, kdver->KernBase);
>>> +        sttul_p(&kdver->PsLoadedModuleList, kdver->PsLoadedModuleList)=
;
>>> +        sttul_p(&kdver->DebuggerDataList, kdver->DebuggerDataList);
>>> +    } else {
>>> +        pd->m64.ReturnStatus =3D STATUS_UNSUCCESSFUL;
>>
>>
>> The ReturnStatus field must be written using st* as well. You have
>> this direct write in many functions.
>>
>
> I'm doing stl_p for status before sending of packet in the
> 'windbg_process_manipulate_packet',
> because this is a global field of structure. Is that bad?

I see. Technically it's probably ok, as long as you make sure that the
field is always aligned. But having the field hold two representations
of the value depending on where exactly in the program you are is not
good style. Imagine debugging it, looking at the contents of the
structure, and not being sure if you're looking at the host or guest
byte order. Plus everybody reading the code will be confused just like
me :)

>>> +        WINDBG_ERROR("get_version: " FMT_ERR, err);
>>> +    }
>>> +}
>>> +
>>>  void kd_api_unsupported(CPUState *cpu, PacketData *pd)
>>>  {
>>>      WINDBG_ERROR("Caught unimplemented api %s",
>>> diff --git a/windbgstub.c b/windbgstub.c
>>> index 72324ae53d..ddca290694 100755
>>> --- a/windbgstub.c
>>> +++ b/windbgstub.c
>>> @@ -197,6 +197,10 @@ static void
>>> windbg_process_manipulate_packet(ParsingContext *ctx)
>>>          kd_api_write_physical_memory(cpu, &ctx->data);
>>>          break;
>>>
>>> +    case DbgKdGetVersionApi:
>>> +        kd_api_get_version(cpu, &ctx->data);
>>> +        break;
>>> +
>>>      case DbgKdClearAllInternalBreakpointsApi:
>>>          return;
>>>
>>>
>
