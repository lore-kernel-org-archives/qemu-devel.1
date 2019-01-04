Received: from eggs.gnu.org ([208.118.235.92]:59095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gfPpd-0001bU-L3
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:48:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gfPpX-0004WE-SJ
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:48:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:26183)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gfPpW-0004Vw-MA
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:48:07 -0500
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-11-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2a2562bd-addc-d507-f2a1-b90e2a22200e@redhat.com>
Date: Fri, 4 Jan 2019 14:48:03 +0100
MIME-Version: 1.0
In-Reply-To: <20181227063419.12981-11-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 10/25] build: convert pci.mak to Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com, peter.maydell@linaro.org

On 2018-12-27 07:34, Yang Zhong wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Instead of including the same list of devices for each target,
> set CONFIG_PCI to true, and make the devices default to present
> whenever PCI is available.
> 
> Done mostly with the following script:
> 
>   while read i; do
>      i=${i%=y}; i=${i#CONFIG_}
>      sed -i -e'/^config '$i'$/!b' -en \
>             -e'a\' -e'    default y\' -e'    depends on PCI' \
>           `grep -lw $i hw/*/Kconfig`
>   done < default-configs/pci.mak
> 
> followed by replacing a few "depends on" clauses with "select"
> whenever the symbol is not really related to PCI.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  default-configs/i386-softmmu.mak |  2 +-
>  default-configs/pci.mak          | 47 --------------------------------
>  hw/audio/Kconfig                 |  6 ++++
>  hw/block/Kconfig                 |  2 ++
>  hw/char/Kconfig                  |  2 ++
>  hw/display/Kconfig               | 12 +++++++-
>  hw/ide/Kconfig                   |  6 ++++
>  hw/ipack/Kconfig                 |  2 ++
>  hw/misc/Kconfig                  |  4 +++
>  hw/net/Kconfig                   | 19 +++++++++++++
>  hw/scsi/Kconfig                  | 11 ++++++++
>  hw/sd/Kconfig                    |  3 ++
>  hw/usb/Kconfig                   | 10 +++++++
>  hw/virtio/Kconfig                |  3 ++
>  hw/watchdog/Kconfig              |  2 ++
>  15 files changed, 82 insertions(+), 49 deletions(-)
>  delete mode 100644 default-configs/pci.mak
[...]
> diff --git a/hw/char/Kconfig b/hw/char/Kconfig
> index 26c13243cf..1ed6f0dbce 100644
> --- a/hw/char/Kconfig
> +++ b/hw/char/Kconfig
> @@ -15,6 +15,8 @@ config SERIAL_ISA
>  
>  config SERIAL_PCI
>      bool
> +    default y
> +    depends on PCI

I think this likely needs a "select SERIAL", too? At least the
SERIAL_ISA switch gets a "select SERIAL" in patch 15/25, so it sounds
logical if the SERIAL_PCI would get this, too...

 Thomas
