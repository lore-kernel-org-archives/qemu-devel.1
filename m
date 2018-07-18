Received: from eggs.gnu.org ([2001:4830:134:3::10]:59071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1ffrCu-0003MH-8b
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 14:29:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1ffrCr-0008CL-42
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 14:29:48 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:37437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1ffrCq-0008BZ-Nk
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 14:29:45 -0400
Received: by mail-ed1-x542.google.com with SMTP id b10-v6so5048165eds.4
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 11:29:44 -0700 (PDT)
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
	<20180709091136.28849-3-e.emanuelegiuseppe@gmail.com>
	<20180711144920.GN31228@stefanha-x1.localdomain>
	<494e6b18-a5e9-0521-4ace-dca2160ea191@redhat.com>
	<20180718142927.GN21825@stefanha-x1.localdomain>
From: Emanuele <e.emanuelegiuseppe@gmail.com>
Message-ID: <2d822611-d227-1e9e-bfb4-d119f78a0282@gmail.com>
Date: Wed, 18 Jul 2018 20:29:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180718142927.GN21825@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 2/7] tests/qgraph: pci-pc driver and
 interface nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org



On 07/18/2018 04:29 PM, Stefan Hajnoczi wrote:
> On Wed, Jul 11, 2018 at 05:18:03PM +0200, Paolo Bonzini wrote:
>> On 11/07/2018 16:49, Stefan Hajnoczi wrote:
>>> On Mon, Jul 09, 2018 at 11:11:31AM +0200, Emanuele Giuseppe Esposito wrote:
>>>> -QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc)
>>>> +static void *qpci_get_driver(void *obj, const char *interface)
>>>>   {
>>>> -    QPCIBusPC *ret = g_new0(QPCIBusPC, 1);
>>>> +    QPCIBusPC *qpci = obj;
>>>> +    if (!g_strcmp0(interface, "pci-bus")) {
>>>> +        return &qpci->bus;
>>>> +    }
>>>> +    printf("%s not present in pci-bus-pc", interface);
>>>> +    abort();
>>>> +}
>>> At this point I wonder if it makes sense to use the QEMU Object Model
>>> (QOM), which has interfaces and inheritance.  qgraph duplicates part of
>>> the object model.
>> Replying for Emanuele on this point since we didn't really go through
>> QOM yet; I'll let him answer the comments that are more related to the code.
>>
>> QOM is much heavier weight than qgraph, and adds a lot more boilerplate:
>>
>> - QOM properties interact with QAPI and bring in a lot of baggage;
>> qgraph would only use "child" properties to implement containment.
>>
>> - QOM objects are long-lived, qgraph objects only last for the duration
>> of a single test.  qgraph doesn't need reference counting or complex
>> two-phase initialization like "realize" or "user_complete"
>>
>> - QOM's hierarchy is shallow, but qgraph doesn't really need _any_
>> hierarchy.  Because it focuses on interface rather than hierarchy,
>> everything can be expressed simply through structs contained into one
>> another.
>>
>> Consider that qgraph is 1/4th the size of QOM, and a large part of it is
>> the graph data structure that (as you said) would not be provided by QOM.
>>
>> There are two things where using QOM would save a little bit of
>> duplicated concepts, namely the get_driver (get interface, what you
>> quote above) and get_device (get contained object) callbacks.  However,
>> it wouldn't simplify the code at all, because it would require the
>> introduction of separate instance and class structs.  We didn't want to
>> add all too much boilerplate for people that want to write qtest, as you
>> pointed out in the review of patch 4.
> Yes, I think these are good points.  QOM does involve a lot of
> boilerplate for defining objects.
>
>>>> +void qpci_set_pc(QPCIBusPC *ret, QTestState *qts, QGuestAllocator *alloc)
>>> It's not clear to me what the purpose of this function is - at least the
>>> name is a bit cryptic since it seems more like an initialization
>>> function than 'setting pc' on QPCIBusPC.  How about inlining this in
>>> qpci_init_pc() instead of keeping a separate function?
>> I agree about the naming.  Perhaps we can rename the existing
>> qpci_init_pc to qpci_pc_new, and qpci_set_pc to qpci_pc_init.
>>
>> Would you prefer if the split was done in the patch that introduces the
>> user for qpci_set_pc (patch 5)?  We did it here because this patch
>> prepares qpci-pc
> Either way is fine.  I suggested inlining mainly because it avoids the
> need to pick a good name :).
I had to put this patch here because it also introduces 
qpci_device_init, used by sdhci (patch 3).

For the next version I plan to have a patch X where I rename all 
occurrences of qpci_init_pc in qpci_pc_new, and a patch X+1 that 
introduces qpci_init_pc (was qpci_set_pc) and the other changes.

Should I only introduce qpci_device_init in patch 3 and the remaining 
things in patch 5?

I think the general problem here is that in some patches I create 
functions that are planned to only be used only in next patches (of the 
current series).
> Stefan
