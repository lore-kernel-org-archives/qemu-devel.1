Received: from eggs.gnu.org ([2001:4830:134:3::10]:55065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fW3W4-00017q-C9
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fW3W1-0004Ry-6v
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:37:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fW3W0-0004RS-U1
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:37:01 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5LHZiNe127049
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 13:36:58 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jregvwj53-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 13:36:58 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 21 Jun 2018 13:36:56 -0400
References: <20180515121433.6112-1-marcandre.lureau@redhat.com>
	<20180515121433.6112-4-marcandre.lureau@redhat.com>
	<20180621145405.197d5106@redhat.com>
	<CAJ+F1CKFq5=Afoqg8YZGw-TO8vJqTPwjpW_UAMh6G8LPp4ZztA@mail.gmail.com>
	<20180621162333.293f1a2c@redhat.com>
	<CAJ+F1CLHtrx0hC9AUQ_JvvGGMx5D-X6=hy3A1c+MC0P-5Q3QAg@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 21 Jun 2018 13:36:51 -0400
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLHtrx0hC9AUQ_JvvGGMx5D-X6=hy3A1c+MC0P-5Q3QAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <d9c2a9b5-4dd8-2f2c-86db-53bbad62efac@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/4] acpi: build TPM Physical Presence
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 06/21/2018 01:10 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Thu, Jun 21, 2018 at 4:23 PM, Igor Mammedov <imammedo@redhat.com> wr=
ote:
>> On Thu, 21 Jun 2018 15:21:02 +0200
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
>>
>>> Hi
>>>
>>> On Thu, Jun 21, 2018 at 2:54 PM, Igor Mammedov <imammedo@redhat.com> =
wrote:
>>>> On Tue, 15 May 2018 14:14:32 +0200
>>>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>>>>
>>>>> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>>>>
>>>>> The TPM Physical Presence interface consists of an ACPI part, a sha=
red
>>>>> memory part, and code in the firmware. Users can send messages to t=
he
>>>>> firmware by writing a code into the shared memory through invoking =
the
>>>>> ACPI code. When a reboot happens, the firmware looks for the code a=
nd
>>>>> acts on it by sending sequences of commands to the TPM.
>>>>>
>>>>> This patch adds the ACPI code. It is similar to the one in EDK2 but=
 doesn't
>>>>> assume that SMIs are necessary to use. It uses a similar datastruct=
ure for
>>>>> the shared memory as EDK2 does so that EDK2 and SeaBIOS could both =
make use
>>>>> of it. I extended the shared memory data structure with an array of=
 256
>>>>> bytes, one for each code that could be implemented. The array conta=
ins
>>>>> flags describing the individual codes. This decouples the ACPI impl=
ementation
>>>>> from the firmware implementation.
>>>>>
>>>>> The underlying TCG specification is accessible from the following p=
age.
>>>>>
>>>>> https://trustedcomputinggroup.org/tcg-physical-presence-interface-s=
pecification/
>>>>>
>>>>> This patch implements version 1.30.
>>>>>
>>>>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>>>>
>>>>> ---
>>>>>
>>>>> v4 (Marc-Andr=C3=A9):
>>>>>   - replace 'DerefOf (FUNC [N])' with a function, to fix Windows AC=
PI
>>>>>      handling.
>>>>>   - replace 'return Package (..) {} ' with scoped variables, to fix
>>>>>     Windows ACPI handling.
>>>>>
>>>>> v3:
>>>>>   - add support for PPI to CRB
>>>>>   - split up OperationRegion TPPI into two parts, one containing
>>>>>     the registers (TPP1) and the other one the flags (TPP2); switch=
ed
>>>>>     the order of the flags versus registers in the code
>>>>>   - adapted ACPI code to small changes to the array of flags where
>>>>>     previous flag 0 was removed and now shifting right wasn't alway=
s
>>>>>     necessary anymore
>>>>>
>>>>> v2:
>>>>>   - get rid of FAIL variable; function 5 was using it and always
>>>>>     returns 0; the value is related to the ACPI function call not
>>>>>     a possible failure of the TPM function call.
>>>>>   - extend shared memory data structure with per-opcode entries
>>>>>     holding flags and use those flags to determine what to return
>>>>>     to caller
>>>>>   - implement interface version 1.3
>>>>> ---
>>>>>   include/hw/acpi/tpm.h |  21 +++
>>>>>   hw/i386/acpi-build.c  | 294 +++++++++++++++++++++++++++++++++++++=
++++-
>>>>>   2 files changed, 314 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
>>>>> index f79d68a77a..fc53f08827 100644
>>>>> --- a/include/hw/acpi/tpm.h
>>>>> +++ b/include/hw/acpi/tpm.h
>>>>> @@ -196,4 +196,25 @@ REG32(CRB_DATA_BUFFER, 0x80)
>>>>>   #define TPM_PPI_VERSION_NONE        0
>>>>>   #define TPM_PPI_VERSION_1_30        1
>>>>>
>>>>> +struct tpm_ppi {
>>>>> +    uint8_t  func[256];      /* 0x000: per TPM function implementa=
tion flags;
>>>>> +                                       set by BIOS */
>>>>> +/* whether function is blocked by BIOS settings; bits 0, 1, 2 */
>>>>> +#define TPM_PPI_FUNC_NOT_IMPLEMENTED     (0 << 0)
>>>>> +#define TPM_PPI_FUNC_BIOS_ONLY           (1 << 0)
>>>>> +#define TPM_PPI_FUNC_BLOCKED             (2 << 0)
>>>>> +#define TPM_PPI_FUNC_ALLOWED_USR_REQ     (3 << 0)
>>>>> +#define TPM_PPI_FUNC_ALLOWED_USR_NOT_REQ (4 << 0)
>>>>> +#define TPM_PPI_FUNC_MASK                (7 << 0)
>>>>> +    uint8_t ppin;            /* 0x100 : set by BIOS */
>>>>> +    uint32_t ppip;           /* 0x101 : set by ACPI; not used */
>>>>> +    uint32_t pprp;           /* 0x105 : response from TPM; set by =
BIOS */
>>>>> +    uint32_t pprq;           /* 0x109 : opcode; set by ACPI */
>>>>> +    uint32_t pprm;           /* 0x10d : parameter for opcode; set =
by ACPI */
>>>>> +    uint32_t lppr;           /* 0x111 : last opcode; set by BIOS *=
/
>>>>> +    uint32_t fret;           /* 0x115 : set by ACPI; not used */
>>>>> +    uint8_t res1[0x40];      /* 0x119 : reserved for future use */
>>>>> +    uint8_t next_step;       /* 0x159 : next step after reboot; se=
t by BIOS */
>>>>> +} QEMU_PACKED;
>>>> is this structure plant to be used for accessing data from within QE=
MU
>>>> or it is just used for convenience of calculating offsets/sizes for =
AML?
>>>>
>>>>
>>> For convenience (and it can be useful for debugging).
>> we are gradually getting rid of usage "struct foo" in ACPI code
>> (i.e. when I have time to convert old struct based approach
>> to build_append_int() table based format).
>> and for new code I usually require ACPI parts be struct less
>> (if there is no previous struct baggage to back it up).
>>
> The tpm_ppi struct is not an ACPI table, it's a fixed memory region /
> layout to exchange between guest/os and firmware.
>
>> Hence my request to drop dummy struct and document layout
>> properly in related spec doc (that's where FW should look for
>> documentation and not into struct definition somewhere in
>> the header). So I'd strongly prefer it be done this way.
> There is not much more than the field description for me ;). Stefan,
> would you like to develop the structure usage?

Will do.
