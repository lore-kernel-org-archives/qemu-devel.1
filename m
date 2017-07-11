Received: from eggs.gnu.org ([2001:4830:134:3::10]:44564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dUrVs-0003mn-Ae
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:31:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dUrVr-0007lH-JE
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:31:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1dUrVr-0007kn-Cg
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:31:23 -0400
References: <20170707142138.411-1-pbutsykin@virtuozzo.com>
	<0464adf0-801b-7083-6c3c-d8dae7ddb037@redhat.com>
	<20170710193708-mutt-send-email-mst@kernel.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <f810ff94-edaf-4919-6650-9afc0c65f6a3@redhat.com>
Date: Tue, 11 Jul 2017 11:31:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170710193708-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, amit@kernel.org, pbonzini@redhat.com, den@openvz.org

On 10/07/2017 18:39, Michael S. Tsirkin wrote:
> On Mon, Jul 10, 2017 at 04:13:54PM +0200, Laurent Vivier wrote:
>>>  static void virtconsole_realize(DeviceState *dev, Error **errp)
>>>  {
>>>      VirtIOSerialPort *port = VIRTIO_SERIAL_PORT(dev);
>>> @@ -233,6 +253,7 @@ static void virtserialport_class_init(ObjectClass *klass, void *data)
>>>      k->unrealize = virtconsole_unrealize;
>>>      k->have_data = flush_buf;
>>>      k->set_guest_connected = set_guest_connected;
>>> +    k->enable_backend = virtconsole_enable_backend;
>>
>> Why don't you register a  vm_state change handler to change the state of
>> the virtconsole according to the state of the machine instead of adding
>> a new function in the VirtIOSerialPortClass?
>>
>> See a23a6d1 ("virtio-rng: stop virtqueue while the CPU is stopped")
>>
>> Thanks,
>> Laurent
> 
> 
> In fact that commit does it the wrong way IMHO.
> 
> The order of this call wrt other virtio calls is not
> guaranteed.
> 
> IMHO the right way is to set a vm state change handler in VirtioBusClass
> or status change handler in VirtioDeviceClass.
> 

OK, so I guess Pavel's solution is the good one as it calls his handler
from virtio-serial-bus set_status() handler which is called by
virtio_vmstate_change() function, which is registered with
qemu_add_vm_change_state_handler() by virtio_init()...

Thanks,
Laurent
