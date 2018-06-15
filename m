Received: from eggs.gnu.org ([2001:4830:134:3::10]:45844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fTrrl-0004Ir-LG
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:46:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fTrrk-0004xI-Jc
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:46:25 -0400
References: <20180613122948.18149-1-kraxel@redhat.com>
	<20180613122948.18149-2-kraxel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <2ba29a71-5d92-cb66-6893-a4b9d017ed0b@redhat.com>
Date: Fri, 15 Jun 2018 18:45:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180613122948.18149-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 1/4] hw/display: add ramfb,
 a simple boot framebuffer living in guest ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 06/13/18 14:29, Gerd Hoffmann wrote:
> The boot framebuffer is expected to be configured by the firmware, so it
> uses fw_cfg as interface.  Initialization goes as follows:
> 
>   (1) Check whenever etc/ramfb is present.
>   (2) Allocate framebuffer from RAM.
>   (3) Fill struct RAMFBCfg, write it to etc/ramfb.
> 
> Done.  You can write stuff to the framebuffer now, and it should appear
> automagically on the screen.
> 
> Note that this isn't very efficient because it does a full display
> update on each refresh.  No dirty tracking.  Dirty tracking would have
> to be active for the whole ram slot, so that wouldn't be very efficient
> either.  For a boot display which is active for a short time only this
> isn't a big deal.  As permanent guest display something better should be
> used (if possible).
> 
> This is the ramfb core code.  Some windup is needed for display devices
> which want have a ramfb boot display.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/hw/display/ramfb.h |  9 +++++
>  hw/display/ramfb.c         | 95 ++++++++++++++++++++++++++++++++++++++++++++++
>  hw/display/Makefile.objs   |  2 +
>  3 files changed, 106 insertions(+)
>  create mode 100644 include/hw/display/ramfb.h
>  create mode 100644 hw/display/ramfb.c

I tested this on KVM, built from Gerd's sirius/ramfb branch @ 778450b87275. Works fine with Gerd's corresponding edk2 QemuRamfbDxe driver (already merged):

  [edk2] [PATCH v3 0/4] Add QemuRamfbDxe driver
  http://mid.mail-archive.com/20180613072936.12480-1-kraxel@redhat.com

It also works fine with Ard's efifb patches:

  [PATCH 0/2] efi: add support for cacheable efifb mappings
  http://mid.mail-archive.com/20180615104818.23013-1-ard.biesheuvel@linaro.org

So, for this patch (not the series):

Tested-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
Laszlo
