Received: from eggs.gnu.org ([2001:4830:134:3::10]:53006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cc2Ry-0001gO-A3
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 23:04:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cc2Rv-0004ZC-5q
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 23:04:46 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1486638881-17290-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1c330f16-23fb-e2a9-c1c1-0bac5e6023e5@amsat.org>
Date: Fri, 10 Feb 2017 01:04:38 -0300
MIME-Version: 1.0
In-Reply-To: <1486638881-17290-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/pci-host/prep: Do not use hw_error() in
 realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-devel@nongnu.org

On 02/09/2017 08:14 AM, Thomas Huth wrote:
> hw_error() is for CPU related errors only (it prints out a
> register dump and calls abort()), so we should not use it
> if we just failed to load the bios image. Apart from that,
> realize() functions should not exit directly but always set
> the errp with error_setg() in case of errors instead.
> Additionally, move some code around and delete the bios memory
> subregion again in case of such an error, so that we leave a
> clean state when returning to the caller.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/pci-host/prep.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
> index 5580293..260a119 100644
> --- a/hw/pci-host/prep.c
> +++ b/hw/pci-host/prep.c
> @@ -309,7 +309,6 @@ static void raven_realize(PCIDevice *d, Error **errp)
>      memory_region_set_readonly(&s->bios, true);
>      memory_region_add_subregion(get_system_memory(), (uint32_t)(-BIOS_SIZE),
>                                  &s->bios);
> -    vmstate_register_ram_global(&s->bios);
>      if (s->bios_name) {
>          filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, s->bios_name);
>          if (filename) {
> @@ -328,12 +327,15 @@ static void raven_realize(PCIDevice *d, Error **errp)
>                  }
>              }
>          }
> +        g_free(filename);
>          if (bios_size < 0 || bios_size > BIOS_SIZE) {
> -            /* FIXME should error_setg() */
> -            hw_error("qemu: could not load bios image '%s'\n", s->bios_name);
> +            memory_region_del_subregion(get_system_memory(), &s->bios);
> +            error_setg(errp, "Could not load bios image '%s'", s->bios_name);
> +            return;
>          }
> -        g_free(filename);
>      }
> +
> +    vmstate_register_ram_global(&s->bios);
>  }
>
>  static const VMStateDescription vmstate_raven = {
> @@ -361,7 +363,6 @@ static void raven_class_init(ObjectClass *klass, void *data)
>      /*
>       * Reason: PCI-facing part of the host bridge, not usable without
>       * the host-facing part, which can't be device_add'ed, yet.
> -     * Reason: realize() method uses hw_error().
>       */
>      dc->cannot_instantiate_with_device_add_yet = true;
>  }
>
