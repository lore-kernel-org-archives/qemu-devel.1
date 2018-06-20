Received: from eggs.gnu.org ([2001:4830:134:3::10]:58139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fVg78-0007aU-U2
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fVg75-0000jH-Hp
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:37:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33252
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fVg75-0000iU-CP
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:37:43 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5KGYDo7011531
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 12:37:42 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jqsbnuddc-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 12:37:42 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 20 Jun 2018 10:37:41 -0600
References: <20180515121433.6112-1-marcandre.lureau@redhat.com>
	<20180515121433.6112-4-marcandre.lureau@redhat.com>
	<20180620170330-mutt-send-email-mst@kernel.org>
	<CAJ+F1C+x6HhB_SV-wCHQRt2etWE=-ojg6ypSiB8BnxfY62ruQQ@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 20 Jun 2018 12:37:35 -0400
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+x6HhB_SV-wCHQRt2etWE=-ojg6ypSiB8BnxfY62ruQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <163e64ec-174f-400b-64c2-08af9acc421b@linux.vnet.ibm.com>
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
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 06/20/2018 10:35 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Wed, Jun 20, 2018 at 4:08 PM, Michael S. Tsirkin <mst@redhat.com> wr=
ote:
>> On Tue, May 15, 2018 at 02:14:32PM +0200, Marc-Andr=C3=A9 Lureau wrote=
:
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
>>>   include/hw/acpi/tpm.h |  21 +++
>>>   hw/i386/acpi-build.c  | 294 +++++++++++++++++++++++++++++++++++++++=
++-
>>>   2 files changed, 314 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
>>> index f79d68a77a..fc53f08827 100644
>>> --- a/include/hw/acpi/tpm.h
>>> +++ b/include/hw/acpi/tpm.h
>>> @@ -196,4 +196,25 @@ REG32(CRB_DATA_BUFFER, 0x80)
>>>   #define TPM_PPI_VERSION_NONE        0
>>>   #define TPM_PPI_VERSION_1_30        1
>>>
>>> +struct tpm_ppi {
>> The name violate the coding style.
> That's easy to change. Stefan could do it on commit if the rest of the
> patch is unchanged.

Call it TPMPPIData?
