Received: from eggs.gnu.org ([2001:4830:134:3::10]:60803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eXDJV-0004Oz-4j
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 16:44:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eXDJS-0002Rp-Dl
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 16:44:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35104
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eXDJS-0002R2-8N
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 16:44:34 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	w04LhgZi023256
	for <qemu-devel@nongnu.org>; Thu, 4 Jan 2018 16:44:33 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2f9pe0fx4r-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 16:44:32 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 4 Jan 2018 16:44:32 -0500
References: <20171222145518.24733-1-marcandre.lureau@redhat.com>
	<5c86648e-d12f-cea6-cc70-5ea309e770c1@linux.vnet.ibm.com>
	<92932242.3593577.1515081724417.JavaMail.zimbra@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 4 Jan 2018 16:44:29 -0500
MIME-Version: 1.0
In-Reply-To: <92932242.3593577.1515081724417.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <163f235c-cb78-ec82-4ae6-8ef9aa3f8eef@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] TPM: add CRB device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: amarnath valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org, ehabkost@redhat.com

On 01/04/2018 11:02 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> ----- Original Message -----
>> On 12/22/2017 09:55 AM, Marc-Andr=C3=A9 Lureau wrote:
>>> tpm_crb is a device for TPM 2.0 Command Response Buffer (CRB)
>>> Interface as defined in TCG PC Client Platform TPM Profile (PTP)
>>> Specification Family =E2=80=9C2.0=E2=80=9D Level 00 Revision 01.03 v2=
2.
>>>
>>> The PTP allows device implementation to switch between TIS and CRB
>>> model at run time, but given that CRB is a simpler device to
>>> implement, I chose to implement it as a different device.
>>>
>>> The device doesn't implement other locality than 0 for now (my laptop
>>> TPM doesn't either, so I assume this isn't so bad)
>>>
>>> The command/reply memory region is statically allocated after the CRB
>>> registers address TPM_CRB_ADDR_BASE + sizeof(struct crb_regs) (I
>>> wonder if the BIOS could or should allocate it instead, or what size
>>> to use, again this seems to fit well expectations)
>>>
>>> The PTP doesn't specify a particular bus to put the device. So I adde=
d
>>> it on the system bus directly, so it could hopefully be used easily o=
n
>>> a different platform than x86. Currently, it fails to init on piix,
>>> because error_on_sysbus_device() check. The check may be changed in a
>>> near future, see discussion on the qemu-devel ML.
>>>
>>> Tested with some success with Linux upstream and Windows 10, seabios =
&
>>> modified ovmf. The device is recognized and correctly transmit
>>> command/response with passthrough & emu.
>> When you say 'some success', you mean that a test suite wasn't passing
>> all tests, right? I didn't run the test suite so far, but what I teste=
d
>> looks good to me so far.
> I don't have a test suite, and I don't have much clue how to use a TPM =
for real on Linux.
>
>> We have one ACPI part missing in the implementation and that's this
>> mailbox thing that allows one to send a code to the firmware that the
>> firmware then reads and acts upon and reconfigures the TPM during the
>> next warm-boot.
>>
>> https://trustedcomputinggroup.org/wp-content/uploads/Physical-Presence=
-Interface_1-30_0-52.pdf
>>
>> It was challenging to implement this interface 'back then' using ACPI'=
s
>> AML, but now it's even more low level with the programming interface.
>>
>> I know we have to wait for that other patch. Nevertheless ...
> Oh, so PPI is mandatory for CRB devices? Are you going to implement it?

Not sure whether it is mandatory. At some point we should have an=20
implementation for it. Since the ACPI will be generated by QEMU, the=20
firmwares reacting to the codes need to understand it. All firmwares=20
running x86 VMs need to be in sync with that ACPI or at least be able to=20
recognize it. There are SeaBIOS and UEFI (Tianocore) from what I know.=20
SeaBIOS doesn't have an implementation (besides a previously posted=20
prototype). I don't know about Tianocore...

   Stefan
