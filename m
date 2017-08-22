Received: from eggs.gnu.org ([2001:4830:134:3::10]:55029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dkAre-0001u2-RY
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dkArZ-0007wC-6Z
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:13:10 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:38883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dkArY-0007vM-UR
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:13:05 -0400
Received: by mail-wm0-x22c.google.com with SMTP id l19so28483105wmi.1
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 08:13:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1503414375-21009-1-git-send-email-thuth@redhat.com>
References: <1503414375-21009-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2017 16:12:43 +0100
Message-ID: <CAFEAcA-92Jjz2uCC387oX2u0NWfijPwB_8zGaagC1m=sKD8zhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/misc/auxbus.c: Mark the
 aux-to-i2c-bridge device as non-hotpluggable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, KONRAD Frederic <frederic.konrad@adacore.com>, QEMU Trivial <qemu-trivial@nongnu.org>

On 22 August 2017 at 16:06, Thomas Huth <thuth@redhat.com> wrote:
> QEMU currently aborts if the user tries to do something like this:
>
> $ aarch64-softmmu/qemu-system-aarch64 -S -M integratorcp -nographic
> QEMU 2.9.93 monitor - type 'help' for more information
> (qemu) device_add aux-to-i2c-bridge,id=x
> (qemu) device_del x
> **
> ERROR:qemu/qdev-monitor.c:872:qdev_unplug: assertion failed: (hotplug_ctrl)
> Aborted (core dumped)
>
> Looks like the device is not hot-pluggable, so let's mark it
> accordingly.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/misc/auxbus.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
> index 8a90ddd..2c62515 100644
> --- a/hw/misc/auxbus.c
> +++ b/hw/misc/auxbus.c
> @@ -222,9 +222,17 @@ static inline I2CBus *aux_bridge_get_i2c_bus(AUXTOI2CState *bridge)
>      return bridge->i2c_bus;
>  }
>
> +static void aux_bridge_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    dc->hotpluggable = false;
> +}

Why is our default "hotpluggable" rather than "not hotpluggable" ?
We must have way more non-hotpluggable devices than hotpluggable
ones, and it takes active effort to make a hotpluggable device
model, so it seems like it would be much less bug-prone to
require hotpluggable devices to set dc->hotpluggable true
rather than all the non-hotpluggable ones to set it false...

thanks
-- PMM
