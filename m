Received: from eggs.gnu.org ([2001:4830:134:3::10]:47955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fZpho-0001eK-Vo
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 23:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fZphk-00042v-V7
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 23:40:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34080 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fZphk-00040i-PD
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 23:40:44 -0400
References: <bfb309be-3ef4-bd01-b4f8-3ebdeaa64374@web.de>
	<6b6e45bf-362f-1305-6991-69749d5f02f9@web.de>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a5f14cd7-1334-e3f8-c3c8-e40443351372@redhat.com>
Date: Mon, 2 Jul 2018 11:40:37 +0800
MIME-Version: 1.0
In-Reply-To: <6b6e45bf-362f-1305-6991-69749d5f02f9@web.de>
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



On 2018=E5=B9=B406=E6=9C=8830=E6=97=A5 14:13, Jan Kiszka wrote:
> On 2018-04-05 19:41, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Only signal MSI/MSI-X events on rising edges. So far we re-triggered t=
he
>> interrupt sources even if the guest did no consumed the pending one,
>> easily causing interrupt storms.
>>
>> Issue was observable with Linux 4.16 e1000e driver when MSI-X was used=
.
>> Vector 2 was causing interrupt storms after the driver activated the
>> device.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> Changes in v2:
>>   - also update msi_causes_pending after EIAC changes (required becaus=
e
>>     there is no e1000e_update_interrupt_state after that
>>
>>   hw/net/e1000e_core.c | 11 +++++++++++
>>   hw/net/e1000e_core.h |  2 ++
>>   2 files changed, 13 insertions(+)
>>
>> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
>> index c93c4661ed..d6ddd59986 100644
>> --- a/hw/net/e1000e_core.c
>> +++ b/hw/net/e1000e_core.c
>> @@ -2027,6 +2027,7 @@ e1000e_msix_notify_one(E1000ECore *core, uint32_=
t cause, uint32_t int_cfg)
>>       }
>>  =20
>>       core->mac[ICR] &=3D ~effective_eiac;
>> +    core->msi_causes_pending &=3D ~effective_eiac;
>>  =20
>>       if (!(core->mac[CTRL_EXT] & E1000_CTRL_EXT_IAME)) {
>>           core->mac[IMS] &=3D ~effective_eiac;
>> @@ -2123,6 +2124,13 @@ e1000e_send_msi(E1000ECore *core, bool msix)
>>   {
>>       uint32_t causes =3D core->mac[ICR] & core->mac[IMS] & ~E1000_ICR=
_ASSERTED;
>>  =20
>> +    core->msi_causes_pending &=3D causes;
>> +    causes ^=3D core->msi_causes_pending;
>> +    if (causes =3D=3D 0) {
>> +        return;
>> +    }
>> +    core->msi_causes_pending |=3D causes;
>> +
>>       if (msix) {
>>           e1000e_msix_notify(core, causes);
>>       } else {
>> @@ -2160,6 +2168,9 @@ e1000e_update_interrupt_state(E1000ECore *core)
>>       core->mac[ICS] =3D core->mac[ICR];
>>  =20
>>       interrupts_pending =3D (core->mac[IMS] & core->mac[ICR]) ? true =
: false;
>> +    if (!interrupts_pending) {
>> +        core->msi_causes_pending =3D 0;
>> +    }
>>  =20
>>       trace_e1000e_irq_pending_interrupts(core->mac[ICR] & core->mac[I=
MS],
>>                                           core->mac[ICR], core->mac[IM=
S]);
>> diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
>> index 7d8ff41890..63a15510cc 100644
>> --- a/hw/net/e1000e_core.h
>> +++ b/hw/net/e1000e_core.h
>> @@ -109,6 +109,8 @@ struct E1000Core {
>>       NICState *owner_nic;
>>       PCIDevice *owner;
>>       void (*owner_start_recv)(PCIDevice *d);
>> +
>> +    uint32_t msi_causes_pending;
>>   };
>>  =20
>>   void
>>
> Ping again, this one is still open.
>
> Jan

Sorry for the late.

Just one thing to confirm, I think the reason that we don't need to=20
migrate msi_cause_pending is that it can only lead at most one more=20
signal of MSI on destination?

Thanks
