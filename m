Received: from eggs.gnu.org ([209.51.188.92]:60942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hDRnX-0001tf-Vx
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hDRnW-0004XB-Vw
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:46:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hDRnW-0004VS-Ev
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:46:42 -0400
References: <20190407092314.11066-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5c1d5f0b-3845-dce3-a50a-d28f2560397e@redhat.com>
Date: Mon, 8 Apr 2019 12:46:33 +0200
MIME-Version: 1.0
In-Reply-To: <20190407092314.11066-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0] hw/i386/pc: Fix crash when
 hot-plugging nvdimm on older machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>

On 07/04/19 11:23, Thomas Huth wrote:
> QEMU currently crashes when you try to hot-plug an "nvdimm" device
> on older machine types:
> 
> $ qemu-system-x86_64 -monitor stdio -M pc-1.1
> QEMU 3.1.92 monitor - type 'help' for more information
> (qemu) device_add nvdimm,id=nvdimmn1
> qemu-system-x86_64: /home/thuth/devel/qemu/util/error.c:57: error_setv:
>  Assertion `*errp == ((void *)0)' failed.
> Aborted (core dumped)
> 
> The call to hotplug_handler_pre_plug() in pc_memory_pre_plug() has been
> added recently before the check whether nvdimm is enabled. It should
> be done after the check. And while we're at it, also check the errp
> after the hotplug_handler_pre_plug(), otherwise errors are silently
> ignored here.
> 
> Fixes: 9040e6dfa8c3fed87695a3de555d2c775727bb51
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/i386/pc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 6077d27361..f2c15bf1f2 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2078,6 +2078,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>      const MachineState *ms = MACHINE(hotplug_dev);
>      const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>      const uint64_t legacy_align = TARGET_PAGE_SIZE;
> +    Error *local_err = NULL;
>  
>      /*
>       * When -no-acpi is used with Q35 machine type, no ACPI is built,
> @@ -2090,13 +2091,17 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>          return;
>      }
>  
> -    hotplug_handler_pre_plug(pcms->acpi_dev, dev, errp);
> -
>      if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
>          error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
>          return;
>      }
>  
> +    hotplug_handler_pre_plug(pcms->acpi_dev, dev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
>      pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev),
>                       pcmc->enforce_aligned_dimm ? NULL : &legacy_align, errp);
>  }
> 

Queued, thanks.

Paolo
