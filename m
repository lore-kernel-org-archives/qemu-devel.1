Received: from eggs.gnu.org ([2001:4830:134:3::10]:50333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fW07u-0001CO-Mb
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 09:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fW07r-0002BH-KC
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 09:59:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fW07r-0002Ao-BS
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 09:59:51 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5LDxkxH062030
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 09:59:49 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jrc94kf3k-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 09:59:47 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 21 Jun 2018 09:59:33 -0400
References: <20180515121433.6112-1-marcandre.lureau@redhat.com>
	<20180515121433.6112-5-marcandre.lureau@redhat.com>
	<20180621150203.2c985ed2@redhat.com>
	<CAJ+F1CJHraqeM2q5G-ooVfp771r_K4g=osJG=J6PTH4aV0BprQ@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 21 Jun 2018 09:59:29 -0400
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJHraqeM2q5G-ooVfp771r_K4g=osJG=J6PTH4aV0BprQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <e753b747-4e33-500b-6e58-b45dc8f4171c@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/4] tpm: add a fake ACPI memory clear
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 06/21/2018 09:24 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Thu, Jun 21, 2018 at 3:02 PM, Igor Mammedov <imammedo@redhat.com> wr=
ote:
>> On Tue, 15 May 2018 14:14:33 +0200
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>>
>>> This allows to pass the last failing test from the Windows HLK TPM 2.=
0
>>> TCG PPI 1.3 tests.
>>>
>>> The interface is described in the "TCG Platform Reset Attack
>>> Mitigation Specification", chapter 6 "ACPI _DSM Function". Whether or
>>> not we should have a real implementation remains an open question to =
me.
>> might it cause security issues?
> Good question. If the guest assumes success of this operation perhaps.
> I'll check the spec.
We could reserve a flag in the PPI interface where the firmware can=20
indicate that it supports it. ACPI would read that flag and it hide this=20
interface if not supported.

>
>> What are implications of faking it and how hard it's to implement thin=
g
>> per spec?
> Laszlo answerd that in "[Qemu-devel] investigating TPM for
> OVMF-on-QEMU"  2f2b) TCG Memory Clear Interface
>
>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>   hw/i386/acpi-build.c | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>> index 95be4f0710..392a1e50bd 100644
>>> --- a/hw/i386/acpi-build.c
>>> +++ b/hw/i386/acpi-build.c
>>> @@ -2072,6 +2072,15 @@ build_tpm_ppi(Aml *dev)
>>>               aml_append(ifctx, aml_return(aml_buffer(1, zerobyte)));
>>>           }
>>>           aml_append(method, ifctx);
>>> +
>>> +       /* dummy MOR Memory Clear for the sake of WLK PPI test */
>>> +        ifctx =3D aml_if(
>>> +            aml_equal(aml_arg(0),
>>> +                      aml_touuid("376054ED-CC13-4675-901C-4756D7F2D4=
5D")));
>>> +        {
>>> +            aml_append(ifctx, aml_return(aml_int(0)));
>>> +        }
>>> +        aml_append(method, ifctx);
>>>       }
>>>       aml_append(dev, method);
>>>   }
>>
>
>
