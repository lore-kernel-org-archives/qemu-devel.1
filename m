Received: from eggs.gnu.org ([2001:4830:134:3::10]:57604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dLnvY-0007XT-87
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dLnvS-0004FJ-OS
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:52:28 -0400
Received: from chuckie.co.uk ([82.165.15.123]:52489
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dLnvS-0004Dg-HF
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:52:22 -0400
References: <1497302470-10776-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497302470-10776-4-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1e8933c2-c64e-9b2f-3eae-8c5664c4a5a6@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <fbbd7d37-ecc2-54a2-876c-9682c6c34756@ilande.co.uk>
Date: Fri, 16 Jun 2017 10:52:00 +0100
MIME-Version: 1.0
In-Reply-To: <1e8933c2-c64e-9b2f-3eae-8c5664c4a5a6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv2 3/4] fw_cfg: move qdev_init_nofail() from
 fw_cfg_init1() to callers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, imammedo@redhat.com, somlo@cmu.edu, ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com, rjones@redhat.com, peter.maydell@linaro.org

On 12/06/17 23:50, Laszlo Ersek wrote:

> On 06/12/17 23:21, Mark Cave-Ayland wrote:
>> When looking to instantiate a TYPE_FW_CFG_MEM or TYPE_FW_CFG_IO device to be
>> able to wire it up differently, it is much more convenient for the caller to
>> instantiate the device and have the fw_cfg default files already preloaded
>> during realize.
>>
>> Move fw_cfg_init1() to the end of both the fw_cfg_mem_realize() and
>> fw_cfg_io_realize() functions so it no longer needs to be called manually
>> when instantiating the device.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  hw/nvram/fw_cfg.c |   10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>> index e1aa4fc..6c21e43 100644
>> --- a/hw/nvram/fw_cfg.c
>> +++ b/hw/nvram/fw_cfg.c
>> @@ -920,8 +920,6 @@ static void fw_cfg_init1(DeviceState *dev)
>>  
>>      object_property_add_child(OBJECT(machine), FW_CFG_NAME, OBJECT(s), NULL);
>>  
>> -    qdev_init_nofail(dev);
>> -
>>      fw_cfg_add_bytes(s, FW_CFG_SIGNATURE, (char *)"QEMU", 4);
>>      fw_cfg_add_bytes(s, FW_CFG_UUID, &qemu_uuid, 16);
>>      fw_cfg_add_i16(s, FW_CFG_NOGRAPHIC, (uint16_t)!machine->enable_graphics);
>> @@ -954,7 +952,7 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>>          qdev_prop_set_bit(dev, "dma_enabled", false);
>>      }
>>  
>> -    fw_cfg_init1(dev);
>> +    qdev_init_nofail(dev);
>>  
>>      sbd = SYS_BUS_DEVICE(dev);
>>      sysbus_add_io(sbd, iobase, sysbus_mmio_get_region(sbd, 0));
>> @@ -991,7 +989,7 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
>>          qdev_prop_set_bit(dev, "dma_enabled", false);
>>      }
>>  
>> -    fw_cfg_init1(dev);
>> +    qdev_init_nofail(dev);
>>  
>>      sbd = SYS_BUS_DEVICE(dev);
>>      sysbus_mmio_map(sbd, 0, ctl_addr);
>> @@ -1097,6 +1095,8 @@ static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
>>                                sizeof(dma_addr_t));
>>          sysbus_init_mmio(sbd, &FW_CFG(s)->dma_iomem);
>>      }
>> +
>> +    fw_cfg_init1(dev);
>>  }
>>  
>>  static void fw_cfg_io_class_init(ObjectClass *klass, void *data)
>> @@ -1163,6 +1163,8 @@ static void fw_cfg_mem_realize(DeviceState *dev, Error **errp)
>>                                sizeof(dma_addr_t));
>>          sysbus_init_mmio(sbd, &FW_CFG(s)->dma_iomem);
>>      }
>> +
>> +    fw_cfg_init1(dev);
>>  }
>>  
>>  static void fw_cfg_mem_class_init(ObjectClass *klass, void *data)
>>
> 
> This looks good to me generally, but I'm concerned about the part of
> fw_cfg_init1() that precedes the original qdev_init_nofail() call, namely
> 
>     assert(!object_resolve_path(FW_CFG_PATH, NULL));
> 
>     object_property_add_child(OBJECT(machine), FW_CFG_NAME, OBJECT(s),
> NULL);
> 
> The object_property_add_child() call creates a machine-global link to
> the sole fw-cfg device, so that *other* code can find the fw-cfg device
> by calling object_resolve_path(). (The same way that we assert fails
> right before the creation, i.e. we don't try to create several fw_cfg
> devices.)
> 
> I feel that this link creation does not belong in device realize
> methods, but to board code. I feel that these two steps should be
> factored out to a separate helper function, and then called from:
> 
> - fw_cfg_init_io_dma(), just before the new qdev_init_nofail() call site,
> - fw_cfg_init_mem_wide(), just before the new qdev_init_nofail() call site,
> - before any similar qdev_init_nofail() call sites, such as in
> <https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg02658.html>.
> 
> Again this is just a gut feeling, comments / opinions welcome.

After testing the assert() in a few different scenarios, I much prefer
the existing approach with a fixed fw_cfg path at /machine/fw_cfg.

The reason for this is that with existing code, any attempt to init a
second fw_cfg device will assert immediately, whereas if the board is
responsible for wiring up the fw_cfg device then it's possible that a
caller will either a) forget to call a helper function or b) wire up 2
fw_cfg in different places in the object tree, e.g. one calling
fw_cfg_init_io() and another instantiated directly via QOM as per what
I'm trying to do with sun4u.

Taking all this into account, I'm working on a v3 patchset that I hope
to post to the list later today.


ATB,

Mark.
