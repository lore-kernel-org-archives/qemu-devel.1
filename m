Received: from eggs.gnu.org ([2001:4830:134:3::10]:49916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQBes-0006QL-L3
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:05:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQBer-00076a-Et
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:05:54 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:33509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQBer-00076M-7g
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:05:53 -0400
Received: by mail-ot0-x244.google.com with SMTP id h6-v6so2706276otj.0
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 06:05:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180605125245.32612-1-kraxel@redhat.com>
References: <20180605125245.32612-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Jun 2018 14:05:32 +0100
Message-ID: <CAFEAcA_OBtsYoBe_hSb3mbjQRiBcW2tx0rigWkQEUNX_ESdkZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] usb: update docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On 5 June 2018 at 13:52, Gerd Hoffmann <kraxel@redhat.com> wrote:
> xhci is rock solid meanwhile.  So move it up in the docs and feature it
> as prefered usb host adapter, instead of the old shy version saying "you
> might want try ...".
>
> While being at it rework the text on ehci and companion controllers too.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  docs/usb2.txt | 80 ++++++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 46 insertions(+), 34 deletions(-)


This is good; I did a quick pass-through for typos and the like.

> diff --git a/docs/usb2.txt b/docs/usb2.txt
> index 09df45b5b1..30055a2258 100644
> --- a/docs/usb2.txt
> +++ b/docs/usb2.txt
> @@ -1,16 +1,42 @@
>
> -USB 2.0 Quick Start
> -===================
> +USB Quick Start
> +===============
>
> -The QEMU EHCI Adapter can be used with and without companion
> -controllers.  See below for the companion controller mode.
> +xhci controller support
> +-----------------------
>
> -When not running in companion controller mode there are two completely
> -separate USB busses: One USB 1.1 bus driven by the UHCI controller and
> -one USB 2.0 bus driven by the EHCI controller.  Devices must be
> -attached to the correct controller manually.
> +Qemu has xhci host adapter support.  The xhci hardware design is much

"QEMU" should be all upper-case.

We also seem to be inconsistent about whether to uppercase UHCI,
EHCI and XHCI. I'd suggest using all-upper-case (except obviously
in QEMU device names like 'qemu-xhci').

> +more virtualization-friendly when compared to ehci and uhci, thus xhci
> +emulation uses less resources (especially cpu).  So if your guest
> +supports xhci (which should be the case for any operating system
> +released around 2010 or later) I recommend using it:

I think we should phrase our documentation from a project point
of view, so "we recommend" rather than "I".

>
> -The '-usb' switch will make qemu create the UHCI controller as part of
> +    qemu -device qemu-xhci
> +
> +xhci supports USB 1.1, USB 2.0 and USB 3.0 devices, so this is the
> +only controller you need.  With only a single usb controller (and
> +therefore only a single usb bus) being present in the system there is

s/being//

> +no need to use the bus= parameter when adding usb devices.
> +
> +
> +ehci controller support
> +-----------------------
> +
> +The QEMU EHCI Adapter supports USB 2.0 devices.  It can be used either
> +standalone or with companion controllers (UHCI, OHCI) for USB 1.1
> +devices.  The companion controller setup is more convinient to use

"convenient".

> +because it provides a single usb bus supporting both USB 2.0 and USB
> +1.1 devices.  See next section for details.
> +
> +When running EHCI in standalone mode you can add UHCI or OHCI
> +controllers for USB 1.1 devices too.  Each controller creates its own
> +bus though, so there are two completely separate USB busses: One USB

"buses". (the double-s spelling is a valid but less-used variant;
our docs mostly use the single-s spelling though, so we should
go with that for consistency.)

> +1.1 bus driven by the UHCI controller and one USB 2.0 bus driven by
> +the EHCI controller.  Devices must be attached to the correct
> +controller manually.
> +
> +The easiest way to add a UHCI controller to a 'pc' machine is the
> +'-usb' switch, qemu will create the UHCI controller as function of

s/, qemu/. QEMU/.

>  the PIIX3 chipset.  The USB 1.1 bus will carry the name "usb-bus.0".
>
>  You can use the standard -device switch to add a EHCI controller to
> @@ -37,37 +63,23 @@ device to the EHCI adapter.
>  Companion controller support
>  ----------------------------
>
> -Companion controller support has been added recently.  The operational
> -model described above with two completely separate busses still works
> -fine.  Additionally the UHCI and OHCI controllers got the ability to
> -attach to a usb bus created by EHCI as companion controllers.  This is
> -done by specifying the masterbus and firstport properties.  masterbus
> -specifies the bus name the controller should attach to.  firstport
> -specifies the first port the controller should attach to, which is
> -needed as usually one ehci controller with six ports has three uhci
> -companion controllers with two ports each.
> +The UHCI and OHCI controllers can attach to a usb bus created by EHCI
> +as companion controllers.  This is done by specifying the masterbus
> +and firstport properties.  masterbus specifies the bus name the
> +controller should attach to.  firstport specifies the first port the
> +controller should attach to, which is needed as usually one ehci
> +controller with six ports has three uhci companion controllers with
> +two ports each.
>
> -There is a config file in docs which will do all this for you, just
> -try ...
> +There is a config file in docs which will do all this for
> +you, just try ...
>
>      qemu -readconfig docs/config/ich9-ehci-uhci.cfg
>
>  ... then use "bus=ehci.0" to assign your usb devices to that bus.
>
> -
> -xhci controller support
> ------------------------
> -
> -There is also xhci host controller support available.  It got a lot
> -less testing than ehci and there are a bunch of known limitations, so
> -ehci may work better for you.  On the other hand the xhci hardware
> -design is much more virtualization-friendly, thus xhci emulation uses
> -less resources (especially cpu).  If you want to give xhci a try
> -use this to add the host controller ...
> -
> -    qemu -device nec-usb-xhci,id=xhci
> -
> -... then use "bus=xhci.0" when assigning usb devices.
> +Using the '-usb' switch for 'q35' machines will create a simliar

"similar".

> +usb controller configuration.
>

thanks
-- PMM
