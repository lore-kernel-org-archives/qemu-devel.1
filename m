Received: from eggs.gnu.org ([209.51.188.92]:45616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3PCp-0007Es-RT
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3OzR-0003og-Tu
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:45:31 -0400
References: <20190308131445.17502-1-armbru@redhat.com>
	<87ftrtux81.fsf@dusky.pond.sub.org> <875zspux2c.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dfa8c033-e2d8-28ea-7404-a0c1edfc5b84@redhat.com>
Date: Mon, 11 Mar 2019 18:45:03 +0100
MIME-Version: 1.0
In-Reply-To: <875zspux2c.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 11/12] pc: Support firmware
 configuration with -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, pkrempa@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, marcandre.lureau@redhat.com, philmd@redhat.com

On 11/03/19 18:42, Markus Armbruster wrote:
> Incremental diff since v3:

Ack, thanks.

Paolo

> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index ccf2221acb..c628540774 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -82,13 +82,19 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
>      memory_region_set_readonly(isa_bios, true);
>  }
>  
> -static PFlashCFI01 *pc_pflash_create(const char *name)
> +static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
> +                                     const char *name,
> +                                     const char *alias_prop_name)
>  {
>      DeviceState *dev = qdev_create(NULL, TYPE_PFLASH_CFI01);
>  
>      qdev_prop_set_uint64(dev, "sector-length", FLASH_SECTOR_SIZE);
>      qdev_prop_set_uint8(dev, "width", 1);
>      qdev_prop_set_string(dev, "name", name);
> +    object_property_add_child(OBJECT(pcms), name, OBJECT(dev),
> +                              &error_abort);
> +    object_property_add_alias(OBJECT(pcms), alias_prop_name,
> +                              OBJECT(dev), "drive", &error_abort);
>      return PFLASH_CFI01(dev);
>  }
>  
> @@ -97,14 +103,10 @@ void pc_system_flash_create(PCMachineState *pcms)
>      PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>  
>      if (pcmc->pci_enabled) {
> -        pcms->flash[0] = pc_pflash_create("system.flash0");
> -        pcms->flash[1] = pc_pflash_create("system.flash1");
> -        object_property_add_alias(OBJECT(pcms), "pflash0",
> -                                  OBJECT(pcms->flash[0]), "drive",
> -                                  &error_abort);
> -        object_property_add_alias(OBJECT(pcms), "pflash1",
> -                                  OBJECT(pcms->flash[1]), "drive",
> -                                  &error_abort);
> +        pcms->flash[0] = pc_pflash_create(pcms, "system.flash0",
> +                                          "pflash0");
> +        pcms->flash[1] = pc_pflash_create(pcms, "system.flash1",
> +                                          "pflash1");
>      }
>  }
>  
> @@ -122,19 +124,7 @@ static void pc_system_flash_cleanup_unused(PCMachineState *pcms)
>              prop_name = g_strdup_printf("pflash%d", i);
>              object_property_del(OBJECT(pcms), prop_name, &error_abort);
>              g_free(prop_name);
> -            /*
> -             * Delete @dev_obj.  Straight object_unref() is wrong,
> -             * since it leaves dangling references in the parent bus
> -             * behind.  object_unparent() doesn't work, either: since
> -             * @dev_obj hasn't been realized, dev_obj->parent is null,
> -             * and object_unparent() does nothing.  DeviceClass method
> -             * device_unparent() works, but we have to take a
> -             * temporary reference, or else device_unparent() commits
> -             * a use-after-free error.
> -             */
> -            object_ref(dev_obj);
> -            object_get_class(dev_obj)->unparent(dev_obj);
> -            object_unref(dev_obj);
> +            object_unparent(dev_obj);
>              pcms->flash[i] = NULL;
>          }
>      }
> 
