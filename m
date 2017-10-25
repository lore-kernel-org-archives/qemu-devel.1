Received: from eggs.gnu.org ([2001:4830:134:3::10]:52659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1e7GOG-0008Ex-PN
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 03:46:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1e7GOD-0000Xa-M7
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 03:46:16 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:53618
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1e7GOD-0000Wg-D4
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 03:46:13 -0400
References: <7df70170550e3a10152a3571012f507dd035ba7c.1508885974.git.pisa@cmp.felk.cvut.cz>
	<cbfe4b03919c677d132971ed0c352b0d90de5015.1508885974.git.pisa@cmp.felk.cvut.cz>
	<083391ca-0827-fa22-92e3-7522e8722b0c@adacore.com>
	<201710250940.35415.pisa@cmp.felk.cvut.cz>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <b43864a1-b0c4-da1a-920b-82dc6cfe16c3@adacore.com>
Date: Wed, 25 Oct 2017 09:46:10 +0200
MIME-Version: 1.0
In-Reply-To: <201710250940.35415.pisa@cmp.felk.cvut.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/6] Fixed IRQ problem for CAN device
 can_pcm3680_pci.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: qemu-devel@nongnu.org, Marek Vasut <marex@denx.de>, Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>, Jan Kiszka <jan.kiszka@siemens.com>, Oliver Hartkopp <socketcan@hartkopp.net>

I usually do that with the 'Signed-off-by'.

eg:
Signed-off-by: A
Fix the irq stuff
Signed-off-by: B

Not sure if this is the right way?

Fred

On 10/25/2017 09:40 AM, Pavel Pisa wrote:
> On Wednesday 25 of October 2017 08:53:07 KONRAD Frederic wrote:
>> Can't this be merged in the previous patch?
> 
> Yes, my intention has been to keep other authors
> patches fully documenting their effort.
> 
> So I cleaned and keep in logical chunks mine patches
> and do only formating of others. But I am happy
> to collapse these to into single one.
> 
> If the rest goes OK, then if the core and standalone
> usable patches
> 
>    [PATCH 1/6] CAN bus simple SJA1000 PCI card emulation for QEMU
>    [PATCH 2/6] CAN bus Kvaser PCI CAN-S (single SJA1000 channel) emulation added.
> 
> are accepted I prepare updated series.
> 
> If review leads to need update whole series, I merge
> this to previous one before posting.
> 
> Thanks much for your time,
> 
> Pavel
> 
>> On 10/25/2017 01:29 AM, pisa@cmp.felk.cvut.cz wrote:
>>> From: Deniz Eren <deniz.eren@icloud.com>
>>>
>>> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
>>> ---
>>>    hw/can/can_pcm3680_pci.c | 11 +++++++++++
>>>    1 file changed, 11 insertions(+)
>>>
>>> diff --git a/hw/can/can_pcm3680_pci.c b/hw/can/can_pcm3680_pci.c
>>> index 77523f2ddb..bc6b164ea7 100644
>>> --- a/hw/can/can_pcm3680_pci.c
>>> +++ b/hw/can/can_pcm3680_pci.c
>>> @@ -61,6 +61,7 @@ typedef struct Pcm3680iPCIState {
>>>        MemoryRegion    sja_io[2];
>>>
>>>        CanSJA1000State sja_state[2];
>>> +    qemu_irq        irq;
>>>
>>>        char            *model; /* The model that support, only SJA1000
>>> now. */ char            *canbus[2];
>>> @@ -69,10 +70,16 @@ typedef struct Pcm3680iPCIState {
>>>
>>>    static void pcm3680i_pci_irq_raise(void *opaque)
>>>    {
>>> +    Pcm3680iPCIState *d = (Pcm3680iPCIState *)opaque;
>>> +
>>> +    qemu_irq_raise(d->irq);
>>>    }
>>>
>>>    static void pcm3680i_pci_irq_lower(void *opaque)
>>>    {
>>> +    Pcm3680iPCIState *d = (Pcm3680iPCIState *)opaque;
>>> +
>>> +    qemu_irq_lower(d->irq);
>>>    }
>>>
>>>    static void
>>> @@ -206,6 +213,8 @@ static int pcm3680i_pci_init(PCIDevice *pci_dev)
>>>        pci_conf = pci_dev->config;
>>>        pci_conf[PCI_INTERRUPT_PIN] = 0x01; /* interrupt pin A */
>>>
>>> +    d->irq = pci_allocate_irq(&d->dev);
>>> +
>>>        can_sja_init(s1, pcm3680i_pci_irq_raise, pcm3680i_pci_irq_lower,
>>> d); can_sja_init(s2, pcm3680i_pci_irq_raise, pcm3680i_pci_irq_lower, d);
>>>
>>> @@ -254,6 +263,8 @@ static void pcm3680i_pci_exit(PCIDevice *pci_dev)
>>>
>>>        can_sja_exit(s1);
>>>        can_sja_exit(s2);
>>> +
>>> +    qemu_free_irq(d->irq);
>>>    }
>>>
>>>    static const VMStateDescription vmstate_pcm3680i_pci = {
> 
