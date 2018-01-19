Received: from eggs.gnu.org ([2001:4830:134:3::10]:33670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eceeR-0005q0-Uy
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 16:56:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eceeN-000356-1c
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 16:56:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37818
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eceeM-00034m-Rt
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 16:56:38 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0JLsT11076970
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 16:56:37 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fkkhc5gag-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 16:56:37 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 19 Jan 2018 16:56:36 -0500
References: <20180119141105.29095-1-marcandre.lureau@redhat.com>
	<20180119141105.29095-5-marcandre.lureau@redhat.com>
	<f95bf39c-f989-0044-b072-954aa1fd5f13@linux.vnet.ibm.com>
	<20180119184216.GE5292@localhost.localdomain>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 19 Jan 2018 16:56:31 -0500
MIME-Version: 1.0
In-Reply-To: <20180119184216.GE5292@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <ddb9d984-03b8-9ae6-fb3e-e85dd648e9c5@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/5] tpm: add CRB device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 01/19/2018 01:42 PM, Eduardo Habkost wrote:
> On Fri, Jan 19, 2018 at 12:10:03PM -0500, Stefan Berger wrote:
>> On 01/19/2018 09:11 AM, Marc-Andr=C3=A9 Lureau wrote:
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
>> I removed this last sentence now. It's at the right location.
>>
>>> The PTP doesn't specify a particular bus to put the device. So I adde=
d
>>> it on the system bus directly, so it could hopefully be used easily o=
n
>>> a different platform than x86. Currently, it fails to init on piix,
>>> because error_on_sysbus_device() check. The check may be changed in a
>>> near future, see discussion on the qemu-devel ML.
>> I think this has to be solved. So I remove these last 2 sentences. I'l=
l have
>> to wait until that other patch series from Eduard is merged since it d=
oesn't
>> start yet.
> The series was just merged to master.  It's possible to make a
> machine accept the new device using
> machine_class_allow_dynamic_sysbus_dev(), now.

I saw that.
>
> However, is it really necessary to make it a sysbus device?
> Having bus-less devices was not possible in the past, but it is
> possible today.
>
What I don't like about it is the fact that I would have to use q35 if=20
we only extend that machine type to allow this sysbus device. What is=20
the reason that dynamic sysbus devices have to explicitly be allowed? If=20
we don't need to limit this device to a certain machine type that may be=20
more user friendly.
