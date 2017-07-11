Received: from eggs.gnu.org ([2001:4830:134:3::10]:47547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dV2SB-0004bU-V1
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:12:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dV2SA-0001N2-S3
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:12:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dV2SA-0001Lo-It
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:12:18 -0400
Date: Tue, 11 Jul 2017 18:12:13 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170711211213.GE6020@localhost.localdomain>
References: <1499803333-9052-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1499803333-9052-3-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499803333-9052-3-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCHv8 2/3] fw_cfg: move qdev_init_nofail() from
 fw_cfg_init1() to callers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, lersek@redhat.com, somlo@cmu.edu, mst@redhat.com, pbonzini@redhat.com, rjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org

On Tue, Jul 11, 2017 at 09:02:12PM +0100, Mark Cave-Ayland wrote:
> When looking to instantiate a TYPE_FW_CFG_MEM or TYPE_FW_CFG_IO device to be
> able to wire it up differently, it is much more convenient for the caller to
> instantiate the device and have the fw_cfg default files already preloaded
> during realize.
> 
> Move fw_cfg_init1() to the end of both the fw_cfg_mem_realize() and
> fw_cfg_io_realize() functions so it no longer needs to be called manually
> when instantiating the device, and also rename it to fw_cfg_common_realize()
> which better describes its new purpose.
> 
> Since it is now the responsibility of the machine to wire up the fw_cfg device
> it is necessary to introduce a object_property_add_child() call into
> fw_cfg_init_io() and fw_cfg_init_mem() to link the fw_cfg device to the root
> machine object as before.
> 
> Finally with the previous change to fw_cfg_find() we can now remove the
> assert() preventing multiple fw_cfg devices being instantiated and replace
> them with a simple call to fw_cfg_find() at realize time instead. This allows
> us to remove FW_CFG_NAME and FW_CFG_PATH since they are no longer required.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
[...]
> @@ -1096,6 +1097,12 @@ static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
>                                &fw_cfg_dma_mem_ops, FW_CFG(s), "fwcfg.dma",
>                                sizeof(dma_addr_t));
>      }
> +
> +    fw_cfg_common_realize(dev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
>  }

"if (local_err)" is redundant, as error_propagate() does nothing
if local_err is NULL.  "return" is also unnecessary here.  You
also don't need local_err/error_propagate() if you are not
looking at the value of local_err at all.  This means those 5
lines can be simply written as:

    fw_cfg_common_realize(dev, errp);

(Sorry for not noticing that in v7)

>  
>  static void fw_cfg_io_class_init(ObjectClass *klass, void *data)
> @@ -1162,6 +1169,12 @@ static void fw_cfg_mem_realize(DeviceState *dev, Error **errp)
>                                sizeof(dma_addr_t));
>          sysbus_init_mmio(sbd, &FW_CFG(s)->dma_iomem);
>      }
> +
> +    fw_cfg_common_realize(dev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }

Same as above.


>  }
>  
>  static void fw_cfg_mem_class_init(ObjectClass *klass, void *data)
> -- 
> 1.7.10.4
> 

-- 
Eduardo
