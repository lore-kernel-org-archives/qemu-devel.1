Received: from eggs.gnu.org ([209.51.188.92]:58432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hD7ep-0002Np-LS
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 09:16:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hD7eo-0002Rr-HD
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 09:16:23 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hD7em-0002Ng-Jc
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 09:16:20 -0400
Received: by mail-oi1-x244.google.com with SMTP id a6so8407294oie.5
	for <qemu-devel@nongnu.org>; Sun, 07 Apr 2019 06:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <1554624893-8363-1-git-send-email-guoheyi@huawei.com>
In-Reply-To: <1554624893-8363-1-git-send-email-guoheyi@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 7 Apr 2019 14:16:08 +0100
Message-ID: <CAFEAcA-N=y3k41oexvYaQ+tKj1d2tCZh8MhPvdq8Uz7dh-eWWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC] arm/virt: add one more uart for UEFI runtime
 debug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Heyi Guo <guoheyi@huawei.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, wanghaibin.wang@huawei.com, Laszlo Ersek <lersek@redhat.com>

On Sun, 7 Apr 2019 at 09:19, Heyi Guo <guoheyi@huawei.com> wrote:
>
> This patch is based on the discussion in TianoCore edk2-devel mailing
> list:
> https://lists.01.org/pipermail/edk2-devel/2019-March/037986.html
>
> The conclusion is that we need an individual UART for UEFI runtime
> services to print debug message at runtime, to avoid conflicting with
> the system UART. We cannot use the secure UART either, for we may both
> have Trusted Firmware and UEFI runtime services running on the VM, and
> it is not easy to keep synchronization between the two components.

I don't think it makes much sense to keep adding UARTs for every
bit of the system software stack. We don't have an infinite
supply of UARTs on real hardware either -- how is this handled
there ?

Also adding new UARTs to this board is awkward because of
the weird choices various bits of software have made in
reading the dtb and picking a UART if there's more than one
listed.

> @@ -713,13 +715,23 @@ static void create_uart(const VirtMachineState *vms, qemu_irq *pic, int uart,
>      if (uart == VIRT_UART) {
>          qemu_fdt_setprop_string(vms->fdt, "/chosen", "stdout-path", nodename);
>      } else {
> +        const char *status_string;
> +
> +        if (uart == VIRT_SECURE_UART) {
> +            status_string = "secure-status";
> +        } else {
> +            status_string = "uefi-status";

Where does this status string come from? The "secure-status" one
is documented in the device tree spec and has a well defined
meaning.

thanks
-- PMM
