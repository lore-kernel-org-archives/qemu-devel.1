Received: from eggs.gnu.org ([209.51.188.92]:42203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bmeng.cn@gmail.com>) id 1h3Mvp-0005vg-Fm
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bmeng.cn@gmail.com>) id 1h3Mqh-0001EV-LY
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:28:21 -0400
MIME-Version: 1.0
References: <20190210201726.3567-1-lukas.auer@aisec.fraunhofer.de>
	<CAEUhbmUtSAeznt1DCwJ7tS=YFeqwnYBemS6278=QQ60qs_MthA@mail.gmail.com>
	<c9f69861058412a1f71418a9c892daf0821a9e33.camel@aisec.fraunhofer.de>
	<CAEUhbmXjCqRRtNDqq5E5y60sDz+4=WqMuxFhaLndot7TSJuUiQ@mail.gmail.com>
	<e131b4b0eb9109547ce0ed0993665206d6bf983a.camel@aisec.fraunhofer.de>
In-Reply-To: <e131b4b0eb9109547ce0ed0993665206d6bf983a.camel@aisec.fraunhofer.de>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 11 Mar 2019 23:28:01 +0800
Message-ID: <CAEUhbmX=PT-46nqtMqSaGn5xu2tRJ50Sm6kK7b97Xc_Y+6stPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/riscv/virt: re-add machine-specific
 compatible string to /soc/ node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Auer, Lukas" <lukas.auer@aisec.fraunhofer.de>
Cc: "palmer@sifive.com" <palmer@sifive.com>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kbastian@mail.uni-paderborn.de" <kbastian@mail.uni-paderborn.de>, "sagark@eecs.berkeley.edu" <sagark@eecs.berkeley.edu>, "Alistair.Francis@wdc.com" <Alistair.Francis@wdc.com>

Hi Lukas,

On Mon, Mar 11, 2019 at 2:03 AM Auer, Lukas
<lukas.auer@aisec.fraunhofer.de> wrote:
>
> Hi Bin,
>
> On Sun, 2019-03-10 at 22:57 +0800, Bin Meng wrote:
> > Hi Lukas,
> >
> > On Sun, Mar 10, 2019 at 9:44 PM Auer, Lukas
> > <lukas.auer@aisec.fraunhofer.de> wrote:
> > > Hi Bin,
> > >
> > > On Sun, 2019-03-10 at 09:07 +0800, Bin Meng wrote:
> > > > Hi Lukas,
> > > >
> > > > On Mon, Feb 11, 2019 at 6:13 AM Lukas Auer
> > > > <lukas.auer@aisec.fraunhofer.de> wrote:
> > > > > Re-add the previous compatible string "riscv-virtio-soc" to the
> > > > > soc
> > > > > device tree node to allow U-Boot and Linux to bind machine-
> > > > > specific
> > > > > drivers to it. The current compatible string "simple-bus" is
> > > > > retained.
> > > > >
> > > > > This is required by U-Boot to bind devices early, as part of
> > > > > the
> > > > > pre-relocation driver model.
> > > > >
> > > >
> > > > I see no problem with U-Boot working with current compatible
> > > > string
> > > > "simple-bus". In fact I had planned to remove the compatible
> > > > string
> > > > "riscv-virtio-soc" in U-Boot but did not get time to work on it.
> > > >
> > >
> > > It is only required if U-Boot is running in machine-mode. For
> > > relocation it needs to use the CLINT driver to send appropriate
> > > IPIs to
> > > the other harts. To be able to probe the driver, the device and its
> > > parent device tree node (soc) must therefore be available in the
> > > pre-
> > > relocation device model.
> > > This patch was the easiest way I could think of for achieving this.
> > > It
> > > could be that there is a better way of solving this.
> > >
> >
> > I tested your SMP U-Boot series in both M-mode and S-mode, using a 4
> > core 'virt' target. Works fine. I am using QEMU 3.1.0 so it is
> > "simple-bus".
> >
>
> That is actually my fault, it should not work.
> What is happening is that U-Boot fails to relocate the secondary harts,
> because the CLINT driver cannot get the memory address of the CLINT
> device. This error is currently silently ignored.

I still don't understand. Why does the CLINT driver fail to get the
memory address? U-Boot has been supporting "simpile-bus" for a long
time. It was because QEMU 3.0.0 generated the /soc node with
"riscv-virtio-soc" compatible string, U-Boot was taught to treat such
compatible string as a "simple-bus" too (that was the U-Boot commit
27dc2c130e29)

> The secondary harts are still waiting to receive IPIs, so booting Linux
> works fine, because U-Boot can now send IPIs. This will however break
> if U-Boot overwrites the code the secondary harts are running, which
> could happen when loading an image.
>
> I will update my SMP U-Boot series to print a warning if sending an IPI
> fails.
>

Regards,
Bin
