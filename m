Received: from eggs.gnu.org ([2001:4830:134:3::10]:51752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fcWpZ-0008Bx-6B
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 10:08:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fcWpV-00057w-Um
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 10:07:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52588
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fcWpV-00057S-P7
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 10:07:53 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w69E169w111651
	for <qemu-devel@nongnu.org>; Mon, 9 Jul 2018 10:07:52 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k484qv8dm-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 10:07:52 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 9 Jul 2018 10:07:51 -0400
References: <20180628172657.11646-1-marcandre.lureau@redhat.com>
	<89c2a128-3679-8b44-f00a-7f94bd3bdf0d@linux.vnet.ibm.com>
	<20180702135746.717e668d@redhat.com>
	<aa7d4472-195d-0d40-4447-494cd4f537c4@linux.vnet.ibm.com>
	<20180709160551.26d07849@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 9 Jul 2018 10:07:46 -0400
MIME-Version: 1.0
In-Reply-To: <20180709160551.26d07849@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <e2aa66de-f559-abaa-979f-1ea3459cd0b5@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 0/4] Add support for TPM Physical
 Presence interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Richard Henderson <rth@twiddle.net>

On 07/09/2018 10:05 AM, Igor Mammedov wrote:
> On Mon, 2 Jul 2018 10:54:13 -0400
> Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
>
>> On 07/02/2018 07:57 AM, Igor Mammedov wrote:
>>> On Fri, 29 Jun 2018 08:20:38 -0400
>>> Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
>>>  =20
>>>> On 06/28/2018 01:26 PM, Marc-Andr=C3=A9 Lureau wrote:
>>>>> Hi,
>>>>>
>>>>> The following patches implement the TPM Physical Presence Interface
>>>>> that allows a user to set a command via ACPI (sysfs entry in Linux)
>>>>> that, upon the next reboot, the firmware looks for and acts upon by
>>>>> sending sequences of commands to the TPM.
>>>>>
>>>>> A dedicated memory region is added to the TPM CRB & TIS devices, at
>>>>> address/size 0xFED45000/0x400. A new "etc/tpm/config" fw_cfg entry
>>>>> holds the location for that PPI region and some version details, to
>>>>> allow for future flexibility.
>>>>>
>>>>> With the associated edk2/ovmf firmware, the Windows HLK "PPI 1.3" t=
est
>>>>> now runs successfully.
>>>>>
>>>>> It is based on previous work from Stefan Berger ("[PATCH v2 0/4]
>>>>> Implement Physical Presence interface for TPM 1.2 and 2")
>>>>>
>>>>> The edk2 support is merged upstream.
>>>> The least I could do now is test this... So, I tested this now with =
the
>>>> SeaBIOS support I have for this series. It's here:
>>>>
>>>> https://github.com/stefanberger/seabios-tpm/tree/qemu-ppi.v6
>>>>
>>>> It works fine with at least an attached TPM 1.2. I haven't tried TPM=
 2
>>>> yet but would not expect complications from QEMU level. A operation
>>>> request value put into Linux's PPI interface can be read back also a=
fter
>>>> a VM suspend / resume operation. The list of supported operations is
>>>> shown correctly (needs Linux extensions for TPM 2 operation values
>>>> beyond a certain number iirc). The request operation is executed
>>>> correctly and the response shows the last operation and its result. =
So
>>>> it seems to work fine.
>>>>
>>>>
>>>>    =C2=A0=C2=A0 Stefan
>>>>  =20
>>> Are there any instructions how to test it?
>>>  =20
>> 1) You need to get swtpm running on a machine.
>>
>> Build libtpms from the 'TPM 2 preview' branch here:
>>
>> https://github.com/stefanberger/libtpms/tree/tpm2-preview.rev146.v2
>>
>> Instructions are here: https://github.com/stefanberger/libtpms/wiki
>>
>>
>> Build swtpm from the TPM 2 preview branch here:
>>
>> https://github.com/stefanberger/swtpm/tree/tpm2-preview.v2
>>
>> Instructions are here: https://github.com/stefanberger/swtpm/wiki
>>
>>
>> 2) Compile and install my branch of SeaBIOS with the PPI support:
>>
>> branch is here: https://github.com/stefanberger/seabios-tpm/tree/qemu-=
ppi.v6
> it looks like repo is gone, is it merged upstream?
>
>
It's the following repo with the branch qemu-ppi.v6.


https://github.com/stefanberger/seabios-tpm


 =C2=A0=C2=A0 Stefan
