Received: from eggs.gnu.org ([2001:4830:134:3::10]:35303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gJb6B-0000yT-8x
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 04:23:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gJb66-00047z-8n
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 04:23:07 -0500
References: <20180927115454.31471-1-geert+renesas@glider.be>
	<20180927115454.31471-3-geert+renesas@glider.be>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2f7f45ec-c689-2cd4-e44f-90c82b47d151@redhat.com>
Date: Mon, 5 Nov 2018 10:17:06 +0100
MIME-Version: 1.0
In-Reply-To: <20180927115454.31471-3-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] New crash (was: Re: [PATCH qemu v5 2/3]
 hw/arm/sysbus-fdt: Allow device matching with DT compatible value)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Peter Maydell <peter.maydell@linaro.org>, Alex Williamson <alex.williamson@redhat.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Magnus Damm <damm+renesas@opensource.se>, qemu-devel@nongnu.org, linux-renesas-soc@vger.kernel.org, Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

On 2018-09-27 13:54, Geert Uytterhoeven wrote:
> From: Auger Eric <eric.auger@redhat.com>
> 
> Up to now we have relied on the device type to identify a device tree
> node creation function.  Since we would like the vfio-platform device to
> be instantiable with different compatible strings we introduce the
> capability to specialize the node creation depending on actual
> compatible value.
> 
> NodeCreationPair is renamed into BindingEntry. The struct is enhanced
> with compat and match_fn() fields.  We introduce a new matching function
> adapted to the vfio-platform generic device.
> 
> Soon, the AMD XGBE can be instantiated with either manner, i.e.:
> 
>     -device vfio-amd-xgbe,host=e0900000.xgmac
> 
> or using the new option line:
> 
>     -device vfio-platform,host=e0900000.xgmac
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> [geert: Match using compatible values in sysfs instead of user-supplied
> 	manufacturer/model options, reword]
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>

scripts/device-crash-test reports a new "crash" with current QEMU master
branch, where QEMU aborts like this:

aarch64-softmmu/qemu-system-aarch64 -S -machine virt-2.9,accel=tcg
-device ramfb
hw/arm/sysbus-fdt.c:422:vfio_platform_match: Object 0x564cf9ae8f80 is
not an instance of type vfio-platform
Aborted (core dumped)

I think it is likely due to this patch here ... any chance that you
could make this a little bit more user friendly instead of aborting the
hard way here?

 Thanks,
  Thomas
