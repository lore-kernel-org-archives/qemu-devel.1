Received: from eggs.gnu.org ([2001:4830:134:3::10]:48208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fVzxB-0004vX-Vj
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 09:48:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fVzx8-000342-Qb
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 09:48:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45680
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fVzx8-00033H-Lf
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 09:48:46 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5LDiOYu104126
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 09:48:45 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jrb765trj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 09:48:45 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 21 Jun 2018 09:48:45 -0400
References: <20180515121433.6112-1-marcandre.lureau@redhat.com>
	<20180515121433.6112-4-marcandre.lureau@redhat.com>
	<20180621145405.197d5106@redhat.com>
	<CAJ+F1CKFq5=Afoqg8YZGw-TO8vJqTPwjpW_UAMh6G8LPp4ZztA@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 21 Jun 2018 09:48:40 -0400
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKFq5=Afoqg8YZGw-TO8vJqTPwjpW_UAMh6G8LPp4ZztA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <fc01752d-28f5-28a8-54b5-aef719085122@linux.vnet.ibm.com>
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

On 06/21/2018 09:21 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Thu, Jun 21, 2018 at 2:54 PM, Igor Mammedov <imammedo@redhat.com> wr=
ote:
>> On Tue, 15 May 2018 14:14:32 +0200
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>>
>>> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>>
>>> The TPM Physical Presence interface consists of an ACPI part, a share=
d
>>> memory part, and code in the firmware. Users can send messages to the
>>> firmware by writing a code into the shared memory through invoking th=
e
>>> ACPI code. When a reboot happens, the firmware looks for the code and
>>> acts on it by sending sequences of commands to the TPM.
>>>
>>> This patch adds the ACPI code. It is similar to the one in EDK2 but d=
oesn't
>>> assume that SMIs are necessary to use. It uses a similar datastructur=
e for
>>> the shared memory as EDK2 does so that EDK2 and SeaBIOS could both ma=
ke use
>>> of it. I extended the shared memory data structure with an array of 2=
56
>>> bytes, one for each code that could be implemented. The array contain=
s
>>> flags describing the individual codes. This decouples the ACPI implem=
entation
>>> from the firmware implementation.
>>>
>>> The underlying TCG specification is accessible from the following pag=
e.
>>>
>>> https://trustedcomputinggroup.org/tcg-physical-presence-interface-spe=
cification/
>>>
>>> This patch implements version 1.30.
>>>
>>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>>
>>> ---
>>>
>>> v4 (Marc-Andr=C3=A9):
>>>   - replace 'DerefOf (FUNC [N])' with a function, to fix Windows ACPI
>>>      handling.
>>>   - replace 'return Package (..) {} ' with scoped variables, to fix
>>>     Windows ACPI handling.
>>>
>>> v3:
>>>   - add support for PPI to CRB
>>>   - split up OperationRegion TPPI into two parts, one containing
>>>     the registers (TPP1) and the other one the flags (TPP2); switched
>>>     the order of the flags versus registers in the code
>>>   - adapted ACPI code to small changes to the array of flags where
>>>     previous flag 0 was removed and now shifting right wasn't always
>>>     necessary anymore
>>>
>>> v2:
>>>   - get rid of FAIL variable; function 5 was using it and always
>>>     returns 0; the value is related to the ACPI function call not
>>>     a possible failure of the TPM function call.
>>>   - extend shared memory data structure with per-opcode entries
>>>     holding flags and use those flags to determine what to return
>>>     to caller
>>>   - implement interface version 1.3
>>> ---
>>>
>>>
>>  From ACPI pov I'd prefer PPI table documented somewhere in spec docs
>> (similar docs/specs/acpi_mem_hotplug.txt) and would look like in
>> other use-cases:
>>
>>     aml_append(field, aml_named_field("PPIN", 8)
>>
>> and drop "struct tpm_ppi" altogether replacing places it was used by
>> explicit constants.
> I have a slight preference for the tpm_ppi structure. But ok with
> replacing it with constant. Stefan, do you agree?

The PPI structure will appear in the firmware code and if it is the same=20
and is correctly used we know that both are in sync. So I wouldn't get=20
rid of it based on just that. If we have to changed all=20
sizeof(uint32_t/uint8_t) to correctly use that shared structure, I'd=20
prefer that.

 =C2=A0=C2=A0=C2=A0 Stefan
