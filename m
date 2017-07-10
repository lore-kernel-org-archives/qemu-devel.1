Received: from eggs.gnu.org ([2001:4830:134:3::10]:40433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dUcPf-0004DW-41
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dUcPb-0006y9-Qe
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:23:59 -0400
Received: from mail-he1eur01on0126.outbound.protection.outlook.com
	([104.47.0.126]:32319
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbutsykin@virtuozzo.com>)
	id 1dUcPa-0006ws-T0
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:23:55 -0400
References: <20170707142138.411-1-pbutsykin@virtuozzo.com>
	<0464adf0-801b-7083-6c3c-d8dae7ddb037@redhat.com>
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <94284c08-ba36-73ba-88be-246ed5c84eb4@virtuozzo.com>
Date: Mon, 10 Jul 2017 20:23:26 +0300
MIME-Version: 1.0
In-Reply-To: <0464adf0-801b-7083-6c3c-d8dae7ddb037@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtio-serial: add enable_backend callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, dgilbert@redhat.com, amit@kernel.org, pbonzini@redhat.com, den@openvz.org

On 10.07.2017 17:13, Laurent Vivier wrote:
> On 07/07/2017 16:21, Pavel Butsykin wrote:
>> We should guarantee that RAM will not be modified while VM has a stopped
>> state, otherwise it can lead to negative consequences during post-copy
>> migration. In RUN_STATE_FINISH_MIGRATE step, it's expected that RAM on
>> source side will not be modified as this could lead to non-consistent vm state
>> on the destination side. Also RAM access during postcopy-ram migration with
>> enabled release-ram capability can lead to sad consequences.
>>
>> Let's add enable_backend() callback to avoid undesirable virtioqueue changes
>> in the guest memory.
>>
>> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
>> ---
>>   hw/char/virtio-console.c          | 21 +++++++++++++++++++++
>>   hw/char/virtio-serial-bus.c       |  7 +++++++
>>   include/hw/virtio/virtio-serial.h |  3 +++
>>   3 files changed, 31 insertions(+)
>>
>> diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
>> index 0cb1668c8a..b55905892e 100644
>> --- a/hw/char/virtio-console.c
>> +++ b/hw/char/virtio-console.c
>> @@ -163,6 +163,26 @@ static void chr_event(void *opaque, int event)
>>       }
>>   }
>>   
>> +static void virtconsole_enable_backend(VirtIOSerialPort *port, bool enable)
>> +{
>> +    VirtConsole *vcon = VIRTIO_CONSOLE(port);
>> +
>> +    if (!qemu_chr_fe_get_driver(&vcon->chr)) {
>> +        return;
>> +    }
>> +
>> +    if (enable) {
>> +        VirtIOSerialPortClass *k = VIRTIO_SERIAL_PORT_GET_CLASS(port);
>> +
>> +        qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
>> +                                 k->is_console ? NULL : chr_event,
>> +                                 vcon, NULL, false);
>> +    } else {
>> +        qemu_chr_fe_set_handlers(&vcon->chr, NULL, NULL,
>> +                                 NULL, NULL, NULL, false);
>> +    }
>> +}
> 
> I think you can also factorize the code in virtconsole_realize() to call
> this new function.
> 
>>   static void virtconsole_realize(DeviceState *dev, Error **errp)
>>   {
>>       VirtIOSerialPort *port = VIRTIO_SERIAL_PORT(dev);
>> @@ -233,6 +253,7 @@ static void virtserialport_class_init(ObjectClass *klass, void *data)
>>       k->unrealize = virtconsole_unrealize;
>>       k->have_data = flush_buf;
>>       k->set_guest_connected = set_guest_connected;
>> +    k->enable_backend = virtconsole_enable_backend;
> 
> Why don't you register a  vm_state change handler to change the state of
> the virtconsole according to the state of the machine instead of adding
> a new function in the VirtIOSerialPortClass?
> 
> See a23a6d1 ("virtio-rng: stop virtqueue while the CPU is stopped")

I tried to follow the existing approach. Look at vhost_net or
virtio-input. This is similar to the hierarchical structure, we have the
root device which notifies the virtio devices at the levels above
(virtio-device -> virtio-bus -> virtio_*_device ). It ensures the
state of devices will be modified consistently, the first is a bus, then
the device on that bus. I'm not sure that following this order during
the device state changes is absolute necessity. But it looks nicer
than the registration of notifications for each device.

Although this is just a guess, I have no clear idea of how to do it
right, so I'm waiting for comments :)

> Thanks,
> Laurent
> 
