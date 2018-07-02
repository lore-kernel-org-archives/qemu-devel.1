Received: from eggs.gnu.org ([2001:4830:134:3::10]:41772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fa0Di-0007VM-Sa
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fa0Df-0007Md-PH
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:54:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fa0Df-0007LJ-G6
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:54:23 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w62EkAKa046076
	for <qemu-devel@nongnu.org>; Mon, 2 Jul 2018 10:54:20 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jyksdpe16-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 10:54:20 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 2 Jul 2018 10:54:19 -0400
References: <20180628172657.11646-1-marcandre.lureau@redhat.com>
	<89c2a128-3679-8b44-f00a-7f94bd3bdf0d@linux.vnet.ibm.com>
	<20180702135746.717e668d@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 2 Jul 2018 10:54:13 -0400
MIME-Version: 1.0
In-Reply-To: <20180702135746.717e668d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <aa7d4472-195d-0d40-4447-494cd4f537c4@linux.vnet.ibm.com>
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 07/02/2018 07:57 AM, Igor Mammedov wrote:
> On Fri, 29 Jun 2018 08:20:38 -0400
> Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
>
>> On 06/28/2018 01:26 PM, Marc-Andr=C3=A9 Lureau wrote:
>>> Hi,
>>>
>>> The following patches implement the TPM Physical Presence Interface
>>> that allows a user to set a command via ACPI (sysfs entry in Linux)
>>> that, upon the next reboot, the firmware looks for and acts upon by
>>> sending sequences of commands to the TPM.
>>>
>>> A dedicated memory region is added to the TPM CRB & TIS devices, at
>>> address/size 0xFED45000/0x400. A new "etc/tpm/config" fw_cfg entry
>>> holds the location for that PPI region and some version details, to
>>> allow for future flexibility.
>>>
>>> With the associated edk2/ovmf firmware, the Windows HLK "PPI 1.3" tes=
t
>>> now runs successfully.
>>>
>>> It is based on previous work from Stefan Berger ("[PATCH v2 0/4]
>>> Implement Physical Presence interface for TPM 1.2 and 2")
>>>
>>> The edk2 support is merged upstream.
>> The least I could do now is test this... So, I tested this now with th=
e
>> SeaBIOS support I have for this series. It's here:
>>
>> https://github.com/stefanberger/seabios-tpm/tree/qemu-ppi.v6
>>
>> It works fine with at least an attached TPM 1.2. I haven't tried TPM 2
>> yet but would not expect complications from QEMU level. A operation
>> request value put into Linux's PPI interface can be read back also aft=
er
>> a VM suspend / resume operation. The list of supported operations is
>> shown correctly (needs Linux extensions for TPM 2 operation values
>> beyond a certain number iirc). The request operation is executed
>> correctly and the response shows the last operation and its result. So
>> it seems to work fine.
>>
>>
>>   =C2=A0=C2=A0 Stefan
>>
> Are there any instructions how to test it?
>
1) You need to get swtpm running on a machine.

Build libtpms from the 'TPM 2 preview' branch here:

https://github.com/stefanberger/libtpms/tree/tpm2-preview.rev146.v2

Instructions are here: https://github.com/stefanberger/libtpms/wiki


Build swtpm from the TPM 2 preview branch here:

https://github.com/stefanberger/swtpm/tree/tpm2-preview.v2

Instructions are here: https://github.com/stefanberger/swtpm/wiki


2) Compile and install my branch of SeaBIOS with the PPI support:

branch is here: https://github.com/stefanberger/seabios-tpm/tree/qemu-ppi=
.v6


3) Follow the QEMU instructions for running the swtpm or start one using=20
latest libvirt + latest virt-manager:

 From QEMU tree: docs/specs/tpm.txt=C2=A0 (starting line 255; this will s=
tart=20
a TPM 1.2)


4) Inside the VM install 'trousers' and tpm-tools packages for using the=20
TPM 1.2.


5) Find the TPM devices ppi directory and cd into it:

# find /sys/devices | grep ppi$

# cd /sys/device/pnp0/00:04/tpm/tpm0/ppi=C2=A0=C2=A0=C2=A0 # this is the =
location on my=20
installation


6) Display the tcg_operations, PPI version, pending request, last=20
response from firmware

# cat tcg_operations

0 4: User not required

1 4: User not required

2 4: User not required

3 4: User not required

[...]

# cat version

1.3

# cat request

0

# cat response

0: No Recent Request


7) Take ownership of the TPM

# tcsd

# tpm_takeownership -y -z


8) Check the state of the TPM:

# cat ../enabled ../active ../own

1

1

1


9) Request PPI to give up ownership of the TPM and activate and enable=20
the TPM again; this is operation request '14' per table 1 of PPI 1.30=20
specification.

# echo 14 > request
# cat request
14
# reboot

10) cd into the ppi directory after the reboot and check the state of=20
the TPM

# cd /sys/device/pnp0/00:04/tpm/tpm0/ppi=C2=A0=C2=A0=C2=A0 # this is the =
location on my=20
installation
# response
14 0: Success

# cat ../enabled ../active ../owned
1
1
0

I hope this helps.

Regards,
 =C2=A0=C2=A0 Stefan
