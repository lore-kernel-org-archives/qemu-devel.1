Received: from eggs.gnu.org ([2001:4830:134:3::10]:40484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cik7p-0003qc-GO
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:55:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cik7o-0003RT-P2
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:55:41 -0500
Date: Tue, 28 Feb 2017 16:55:33 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170228165533.690366cf@Igors-MacBook-Pro.local>
In-Reply-To: <1488293711-14195-2-git-send-email-peter.maydell@linaro.org>
References: <1488293711-14195-1-git-send-email-peter.maydell@linaro.org>
	<1488293711-14195-2-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] qdev: Have qdev_set_parent_bus()
 handle devices already on a bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Clement Deschamps <clement.deschamps@antfield.fr>, patches@linaro.org

On Tue, 28 Feb 2017 14:55:08 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> Instead of qdev_set_parent_bus() silently doing the wrong
> thing if it's handed a device that's already on a bus,
> have it remove the device from the old bus and add it to
> the new one. This is useful for the raspi2 sdcard.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/core/qdev.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 06ba02e..923e626 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -102,9 +102,23 @@ static void bus_add_child(BusState *bus, DeviceState *child)
>  
>  void qdev_set_parent_bus(DeviceState *dev, BusState *bus)
>  {
> +    bool replugging = dev->parent_bus != NULL;
> +
> +    if (replugging) {
> +        /* Keep a reference to the device while it's not plugged into
> +         * any bus, to avoid it potentially evaporating when it is
> +         * dereffed in bus_remove_child().
> +         */
> +        object_ref(OBJECT(dev));
> +        bus_remove_child(dev->parent_bus, dev);
> +        object_unref(OBJECT(dev->parent_bus));
> +    }
>      dev->parent_bus = bus;
>      object_ref(OBJECT(bus));
>      bus_add_child(bus, dev);
> +    if (replugging) {
> +        object_unref(OBJECT(dev));
> +    }
>  }
>  
>  /* Create a new device.  This only initializes the device state
