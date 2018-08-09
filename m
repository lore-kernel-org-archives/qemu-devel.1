Received: from eggs.gnu.org ([2001:4830:134:3::10]:50577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fnmQH-0005IU-20
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 11:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fnmQD-00070S-OO
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 11:00:21 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:35607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fnmQD-000708-Gc
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 11:00:17 -0400
Received: by mail-ed1-x541.google.com with SMTP id e6-v6so3033939edr.2
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 08:00:17 -0700 (PDT)
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<20180806143412.27722-14-e.emanuelegiuseppe@gmail.com>
	<d0252c8c-801e-5e20-67ef-a36e9819cd59@redhat.com>
From: Emanuele <e.emanuelegiuseppe@gmail.com>
Message-ID: <e75065b3-2d5b-1e3a-4d47-bf20eae89b31@gmail.com>
Date: Thu, 9 Aug 2018 17:00:14 +0200
MIME-Version: 1.0
In-Reply-To: <d0252c8c-801e-5e20-67ef-a36e9819cd59@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 13/34] test/qgraph: virtio_start_device
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>



On 08/09/2018 03:39 PM, Laurent Vivier wrote:
> On 06/08/2018 16:33, Emanuele Giuseppe Esposito wrote:
>> This function is intended to group all the qvirtio_* functions that
>> start the qvirtio devices.
>> Applied in all tests using this combination of functions.
>>
>> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
>> ---
>>   tests/libqos/virtio.c    |  8 ++++++++
>>   tests/libqos/virtio.h    |  1 +
>>   tests/vhost-user-test.c  |  5 +----
>>   tests/virtio-9p-test.c   |  6 +-----
>>   tests/virtio-blk-test.c  | 18 ++----------------
>>   tests/virtio-net-test.c  |  6 +-----
>>   tests/virtio-scsi-test.c |  4 +---
>>   7 files changed, 15 insertions(+), 33 deletions(-)
>>
>> diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
>> index 0dad5c19ac..56007ef11b 100644
>> --- a/tests/libqos/virtio.c
>> +++ b/tests/libqos/virtio.c
>> @@ -365,3 +365,11 @@ const char *qvirtio_get_dev_type(void)
>>           return "pci";
>>       }
>>   }
>> +
>> +void qvirtio_start_device(QVirtioDevice *vdev)
>> +{
>> +    qvirtio_reset(vdev);
>> +    qvirtio_set_acknowledge(vdev);
>> +    qvirtio_set_driver(vdev);
>> +    qvirtio_set_driver_ok(vdev);
> I'm not sure you can put qvirtio_set_driver_ok() here.
>
> qvirtio_set_driver_ok() must be called when the driver is OK, it means
> that the virtio device must be fully initialized before (features,
> virtqueue, MSI, ...).
>
> http://docs.oasis-open.org/virtio/virtio/v1.0/virtio-v1.0.pdf
>
> 3.1.1 Driver Requirements: Device Initialization
>
> The driver MUST follow this sequence to initialize a device:
>
> 1. Reset the device.
>
> 2. Set the ACKNOWLEDGE status bit: the guest OS has notice the device.
>
> 3. Set the DRIVER status bit: the guest OS knows how to drive the device.
>
> 4. Read device feature bits, and write the subset of feature bits
> understood by the OS and driver to the
> device. During this step the driver MAY read (but MUST NOT write) the
> device-specific configuration
> fields to check that it can support the device before accepting it.
>
> 5. Set the FEATURES_OK status bit. The driver MUST NOT accept new
> feature bits after this step.
>
> 6. Re-read device status to ensure the FEATURES_OK bit is still set:
> otherwise, the device does not
> support our subset of features and the device is unusable.
>
> 7. Perform device-specific setup, including discovery of virtqueues for
> the device, optional per-bus setup,
> reading and possibly writing the device’s virtio configuration space,
> and population of virtqueues.
>
> 8. Set the DRIVER_OK status bit. At this point the device is “live”.
>
> Thanks,
> Laurent
You're right, I removed qvirtio_set_driver_ok from qvirtio_start_device 
and put it back where it was before.
I noticed that while virtqueues need to have features set before they 
are setup, the device still works even though features are set after the ok.

Thank you,
Emanuele
