Received: from eggs.gnu.org ([2001:4830:134:3::10]:57031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpG5y-0006tv-2r
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpG5t-0007qF-C8
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:48:58 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:33243)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpG5t-0007oW-6a
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:48:53 -0400
Received: by mail-wr0-x233.google.com with SMTP id a43so9688897wrc.0
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 08:48:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <95775774-64e8-0008-5e8e-2fb05e1aba40@redhat.com>
References: <1503416789-32080-1-git-send-email-thuth@redhat.com>
	<20170823172118.GQ19998@localhost.localdomain>
	<CAFEAcA-DoQtTwCBFq-_JKPRMxcGq8-2QNnEJBu9STxtPWkB0bw@mail.gmail.com>
	<20170823180037.GU19998@localhost.localdomain>
	<95775774-64e8-0008-5e8e-2fb05e1aba40@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 16:48:31 +0100
Message-ID: <CAFEAcA870jZr_Vk3+szcZXt77wfM0_bZ3voDNE9r2bAaojcFFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/allwinner-a10: Mark the
 allwinner-a10 device with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On 5 September 2017 at 14:57, Thomas Huth <thuth@redhat.com> wrote:
> On 23.08.2017 20:00, Eduardo Habkost wrote:
>> On Wed, Aug 23, 2017 at 06:51:28PM +0100, Peter Maydell wrote:
>>> On 23 August 2017 at 18:21, Eduardo Habkost <ehabkost@redhat.com> wrote:
>>>> On Tue, Aug 22, 2017 at 05:46:29PM +0200, Thomas Huth wrote:
>>>>> QEMU currently exits unexpectedly when the user accidentially
>>>>> tries to do something like this:
>>>>>
>>>>> $ aarch64-softmmu/qemu-system-aarch64 -S -M integratorcp -nographic
>>>>> QEMU 2.9.93 monitor - type 'help' for more information
>>>>> (qemu) device_add allwinner-a10
>>>>> Unsupported NIC model: smc91c111
>>>>>
>>>>> Exiting just due to a "device_add" should not happen. Looking closer
>>>>> at the the realize and instance_init function of this device also
>>>>> reveals that it is using serial_hds and nd_table directly there, so
>>>>> this device is clearly not creatable by the user and should be marked
>>>>> accordingly.
>>>>>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>  hw/arm/allwinner-a10.c    | 2 ++
>>>>>  scripts/device-crash-test | 1 -
>>>>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
>>>>> index f62a9a3..43a3f01 100644
>>>>> --- a/hw/arm/allwinner-a10.c
>>>>> +++ b/hw/arm/allwinner-a10.c
>>>>> @@ -118,6 +118,8 @@ static void aw_a10_class_init(ObjectClass *oc, void *data)
>>>>>      DeviceClass *dc = DEVICE_CLASS(oc);
>>>>>
>>>>>      dc->realize = aw_a10_realize;
>>>>> +    /* Reason: Uses serial_hds in realize and nd_table in instance_init */
>>>>> +    dc->user_creatable = false;
>>>>
>>>> I assume this patch will be replaced by one changing TYPE_DEVICE
>>>> to default to user_creatable=false, based on the replies to the
>>>> hw/misc/auxbus.c patch?
>>>
>>> user-creatable and hotplug are different things -- most
>>> devices are user-creatable, many fewer are hotpluggable.
>>> So the tradeoff for the default doesn't *necessarily* go
>>> the same way.
>>
>> You're right, I mixed things up when reading this patch.
>>
>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>
> Peter, looking at your last PULL request, it looks like this felt
> through the cracks. Could you please pick it up for the next one?

Oops, yes it did. Applied to target-arm.next, thanks.

-- PMM
