Received: from eggs.gnu.org ([2001:4830:134:3::10]:41937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ekAaN-0004Er-Bf
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:27:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ekAaM-0000p5-C9
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:27:35 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:39878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ekAaM-0000oO-5z
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:27:34 -0500
Received: by mail-oi0-x244.google.com with SMTP id j188so6361194oib.6
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 07:27:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1518189456-2873-4-git-send-email-geert+renesas@glider.be>
References: <1518189456-2873-1-git-send-email-geert+renesas@glider.be>
	<1518189456-2873-4-git-send-email-geert+renesas@glider.be>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Feb 2018 15:27:13 +0000
Message-ID: <CAFEAcA_Z1JH6RXp19g2N3rV3TGOTa7LzFctEScrENBYB8eAf3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH/RFC 3/5] hw/arm/virt: Allow dynamic sysbus
 devices again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Alex Williamson <alex.williamson@redhat.com>, Auger Eric <eric.auger@redhat.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Alexander Graf <agraf@suse.de>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, linux-renesas-soc@vger.kernel.org

On 9 February 2018 at 15:17, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> Allow the instantation of generic dynamic sysbus devices again, without
> the need to create a new device-specific vfio type.
>
> This is a partial revert of commit  6f2062b9758ebc64 ("hw/arm/virt:
> Allow only supported dynamic sysbus devices").
>
> Not-Yet-Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  hw/arm/virt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index b334c82edae9fb1f..fa83784fc08ed076 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1596,6 +1596,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>      mc->max_cpus = 255;
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_CALXEDA_XGMAC);
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_AMD_XGBE);
> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SYS_BUS_DEVICE);
>      mc->block_default_type = IF_VIRTIO;
>      mc->no_cdrom = 1;
>      mc->pci_allow_0_address = true;

This needs a lot of justification. Dynamic sysbus is not supposed
to be for plugging any random sysbus device in, it's for vfio,
which needs special casing anyway to work right. (Overall it's
a terrible hack -- in an ideal world all vfio would use pci
or another probeable bus.)

thanks
-- PMM
