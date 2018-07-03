Received: from eggs.gnu.org ([2001:4830:134:3::10]:52097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1faCVm-0000X8-FQ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 00:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1faCVi-0006n1-W9
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 00:01:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41018 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1faCVi-0006mT-Qm
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 00:01:50 -0400
References: <bfb309be-3ef4-bd01-b4f8-3ebdeaa64374@web.de>
	<6b6e45bf-362f-1305-6991-69749d5f02f9@web.de>
	<a5f14cd7-1334-e3f8-c3c8-e40443351372@redhat.com>
	<031118b4-5dc7-c5a0-e69c-955ae90e2760@web.de>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <81d82c63-0dbb-3132-df04-8101c618baec@redhat.com>
Date: Tue, 3 Jul 2018 12:01:45 +0800
MIME-Version: 1.0
In-Reply-To: <031118b4-5dc7-c5a0-e69c-955ae90e2760@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] e1000e: Prevent MSI/MSI-X storms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel <qemu-devel@nongnu.org>



On 2018=E5=B9=B407=E6=9C=8802=E6=97=A5 13:14, Jan Kiszka wrote:
> On 2018-07-02 05:40, Jason Wang wrote:
>>
>> On 2018=E5=B9=B406=E6=9C=8830=E6=97=A5 14:13, Jan Kiszka wrote:
>>> On 2018-04-05 19:41, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> Only signal MSI/MSI-X events on rising edges. So far we re-triggered=
 the
>>>> interrupt sources even if the guest did no consumed the pending one,
>>>> easily causing interrupt storms.
>>>>
>>>> Issue was observable with Linux 4.16 e1000e driver when MSI-X was us=
ed.
>>>> Vector 2 was causing interrupt storms after the driver activated the
>>>> device.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>
>>>> Changes in v2:
>>>>  =C2=A0 - also update msi_causes_pending after EIAC changes (require=
d because
>>>>  =C2=A0=C2=A0=C2=A0 there is no e1000e_update_interrupt_state after =
that
>>>>
>>>>  =C2=A0 hw/net/e1000e_core.c | 11 +++++++++++
>>>>  =C2=A0 hw/net/e1000e_core.h |=C2=A0 2 ++
>>>>  =C2=A0 2 files changed, 13 insertions(+)
>>>>
>>>> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
>>>> index c93c4661ed..d6ddd59986 100644
>>>> --- a/hw/net/e1000e_core.c
>>>> +++ b/hw/net/e1000e_core.c
>>>> @@ -2027,6 +2027,7 @@ e1000e_msix_notify_one(E1000ECore *core,
>>>> uint32_t cause, uint32_t int_cfg)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 core->mac[ICR] &=3D ~effectiv=
e_eiac;
>>>> +=C2=A0=C2=A0=C2=A0 core->msi_causes_pending &=3D ~effective_eiac;
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(core->mac[CTRL_EXT] & E=
1000_CTRL_EXT_IAME)) {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 core->mac[IM=
S] &=3D ~effective_eiac;
>>>> @@ -2123,6 +2124,13 @@ e1000e_send_msi(E1000ECore *core, bool msix)
>>>>  =C2=A0 {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t causes =3D core->mac[ICR] &=
 core->mac[IMS] &
>>>> ~E1000_ICR_ASSERTED;
>>>>  =C2=A0 +=C2=A0=C2=A0=C2=A0 core->msi_causes_pending &=3D causes;
>>>> +=C2=A0=C2=A0=C2=A0 causes ^=3D core->msi_causes_pending;
>>>> +=C2=A0=C2=A0=C2=A0 if (causes =3D=3D 0) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 core->msi_causes_pending |=3D causes;
>>>> +
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (msix) {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e1000e_msix_=
notify(core, causes);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>>> @@ -2160,6 +2168,9 @@ e1000e_update_interrupt_state(E1000ECore *core=
)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 core->mac[ICS] =3D core->mac[ICR];
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupts_pending =3D (core-=
>mac[IMS] & core->mac[ICR]) ? true
>>>> : false;
>>>> +=C2=A0=C2=A0=C2=A0 if (!interrupts_pending) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 core->msi_causes_pending=
 =3D 0;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_e1000e_irq_pending_inte=
rrupts(core->mac[ICR] &
>>>> core->mac[IMS],
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 core->mac[ICR],
>>>> core->mac[IMS]);
>>>> diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
>>>> index 7d8ff41890..63a15510cc 100644
>>>> --- a/hw/net/e1000e_core.h
>>>> +++ b/hw/net/e1000e_core.h
>>>> @@ -109,6 +109,8 @@ struct E1000Core {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NICState *owner_nic;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PCIDevice *owner;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void (*owner_start_recv)(PCIDevice *=
d);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 uint32_t msi_causes_pending;
>>>>  =C2=A0 };
>>>>  =C2=A0 =C2=A0 void
>>>>
>>> Ping again, this one is still open.
>>>
>>> Jan
>> Sorry for the late.
>>
>> Just one thing to confirm, I think the reason that we don't need to
>> migrate msi_cause_pending is that it can only lead at most one more
>> signal of MSI on destination?
> Right, a cleared msi_causes_pending on the destination may lead to one
> spurious interrupt injects per vector. That should be tolerable.
>
> Jan
>

Applied.

Thanks
