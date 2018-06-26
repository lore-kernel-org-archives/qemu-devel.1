Received: from eggs.gnu.org ([2001:4830:134:3::10]:50341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fXnNj-0007fu-GE
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fXnNf-0001t2-J8
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:47:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39224 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fXnNf-0001sp-CW
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:47:35 -0400
References: <20180515121433.6112-1-marcandre.lureau@redhat.com>
	<20180515121433.6112-5-marcandre.lureau@redhat.com>
	<20180621150203.2c985ed2@redhat.com>
	<CAJ+F1CJHraqeM2q5G-ooVfp771r_K4g=osJG=J6PTH4aV0BprQ@mail.gmail.com>
	<20180621163335.19010217@redhat.com>
	<CAJ+F1C+pYQ-7e-8KqNNwRb4Jtq_HmZUowtiGPjFWV7AE3JL_TA@mail.gmail.com>
	<20180626143404.2ee79c69@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <03a9b99d-6824-ae36-d8d0-4c0434974b6c@redhat.com>
Date: Tue, 26 Jun 2018 14:47:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180626143404.2ee79c69@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 06/26/18 14:34, Igor Mammedov wrote:
> On Tue, 26 Jun 2018 11:22:26 +0200
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
>=20
>> On Thu, Jun 21, 2018 at 4:33 PM, Igor Mammedov <imammedo@redhat.com> w=
rote:
>>> On Thu, 21 Jun 2018 15:24:44 +0200
>>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
>>> =20
>>>> Hi
>>>>
>>>> On Thu, Jun 21, 2018 at 3:02 PM, Igor Mammedov <imammedo@redhat.com>=
 wrote: =20
>>>>> On Tue, 15 May 2018 14:14:33 +0200
>>>>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>>>>> =20
>>>>>> This allows to pass the last failing test from the Windows HLK TPM=
 2.0
>>>>>> TCG PPI 1.3 tests.
>>>>>>
>>>>>> The interface is described in the "TCG Platform Reset Attack
>>>>>> Mitigation Specification", chapter 6 "ACPI _DSM Function". Whether=
 or
>>>>>> not we should have a real implementation remains an open question =
to me. =20
>>>>> might it cause security issues? =20
>>>>
>>>> Good question. If the guest assumes success of this operation perhap=
s.
>>>> I'll check the spec.
>>>> =20
>>>>> What are implications of faking it and how hard it's to implement t=
hing
>>>>> per spec? =20
>>>>
>>>> Laszlo answerd that in "[Qemu-devel] investigating TPM for
>>>> OVMF-on-QEMU"  2f2b) TCG Memory Clear Interface =20
>>> I get that it's optional, but we probably shouldn't advertise/fake
>>> feature if it's not supported. =20
>>
>> As said in the commit message, the objective was to pass the Windows
>> HLK test. If we don't want to advertize a fake interface, I am fine
>> droping this patch. We'll have to revisit with Laszlo the work needed
>> in the firmware to support it.
> I think it would be safer to drop this patch.

This is BTW a feature that's very difficult for OVMF to implement, but
(I think) near trivial for QEMU to implement. The feature is about
clearing all of the guest RAM to zero at reboot.

For the firmware, it's difficult to solve, because in the 32-bit PEI
phase, we don't map DRAM beyond 4GB, so we can't re-set memory to zero
via normal addressing. (For physical platforms, this is different,
because their PEI phases have PEI modules that initialize the memory
controller(s), so they have platform-specific means to clear RAM.) For
QEMU, on the other hand, the feature "shouldn't be hard (TM)", just
implement a reset handler that clears all RAMBlocks on the host side (or
some such :) ).

Thanks,
Laszlo

>=20
>=20
>>> =20
>>>> =20
>>>>>
>>>>> =20
>>>>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com=
>
>>>>>> ---
>>>>>>  hw/i386/acpi-build.c | 9 +++++++++
>>>>>>  1 file changed, 9 insertions(+)
>>>>>>
>>>>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>>>>> index 95be4f0710..392a1e50bd 100644
>>>>>> --- a/hw/i386/acpi-build.c
>>>>>> +++ b/hw/i386/acpi-build.c
>>>>>> @@ -2072,6 +2072,15 @@ build_tpm_ppi(Aml *dev)
>>>>>>              aml_append(ifctx, aml_return(aml_buffer(1, zerobyte))=
);
>>>>>>          }
>>>>>>          aml_append(method, ifctx);
>>>>>> +
>>>>>> +       /* dummy MOR Memory Clear for the sake of WLK PPI test */
>>>>>> +        ifctx =3D aml_if(
>>>>>> +            aml_equal(aml_arg(0),
>>>>>> +                      aml_touuid("376054ED-CC13-4675-901C-4756D7F=
2D45D")));
>>>>>> +        {
>>>>>> +            aml_append(ifctx, aml_return(aml_int(0)));
>>>>>> +        }
>>>>>> +        aml_append(method, ifctx);
>>>>>>      }
>>>>>>      aml_append(dev, method);
>>>>>>  } =20
>>>>>
>>>>> =20
>>>>
>>>>
>>>> =20
>>> =20
>>
>>
>>
>=20
