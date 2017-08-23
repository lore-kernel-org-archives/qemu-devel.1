Received: from eggs.gnu.org ([2001:4830:134:3::10]:39862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dkZom-0000eO-2M
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dkZol-0006gA-0O
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:51:52 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:36464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dkZok-0006fa-Qh
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:51:50 -0400
Received: by mail-wr0-x232.google.com with SMTP id f8so2657584wrf.3
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 10:51:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170823172118.GQ19998@localhost.localdomain>
References: <1503416789-32080-1-git-send-email-thuth@redhat.com>
	<20170823172118.GQ19998@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 23 Aug 2017 18:51:28 +0100
Message-ID: <CAFEAcA-DoQtTwCBFq-_JKPRMxcGq8-2QNnEJBu9STxtPWkB0bw@mail.gmail.com>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Beniamino Galvani <b.galvani@gmail.com>

On 23 August 2017 at 18:21, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Tue, Aug 22, 2017 at 05:46:29PM +0200, Thomas Huth wrote:
>> QEMU currently exits unexpectedly when the user accidentially
>> tries to do something like this:
>>
>> $ aarch64-softmmu/qemu-system-aarch64 -S -M integratorcp -nographic
>> QEMU 2.9.93 monitor - type 'help' for more information
>> (qemu) device_add allwinner-a10
>> Unsupported NIC model: smc91c111
>>
>> Exiting just due to a "device_add" should not happen. Looking closer
>> at the the realize and instance_init function of this device also
>> reveals that it is using serial_hds and nd_table directly there, so
>> this device is clearly not creatable by the user and should be marked
>> accordingly.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  hw/arm/allwinner-a10.c    | 2 ++
>>  scripts/device-crash-test | 1 -
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
>> index f62a9a3..43a3f01 100644
>> --- a/hw/arm/allwinner-a10.c
>> +++ b/hw/arm/allwinner-a10.c
>> @@ -118,6 +118,8 @@ static void aw_a10_class_init(ObjectClass *oc, void *data)
>>      DeviceClass *dc = DEVICE_CLASS(oc);
>>
>>      dc->realize = aw_a10_realize;
>> +    /* Reason: Uses serial_hds in realize and nd_table in instance_init */
>> +    dc->user_creatable = false;
>
> I assume this patch will be replaced by one changing TYPE_DEVICE
> to default to user_creatable=false, based on the replies to the
> hw/misc/auxbus.c patch?

user-creatable and hotplug are different things -- most
devices are user-creatable, many fewer are hotpluggable.
So the tradeoff for the default doesn't *necessarily* go
the same way.

thanks
-- PMM
