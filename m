Received: from eggs.gnu.org ([2001:4830:134:3::10]:44046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eKPJB-0005IV-Nm
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 08:55:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eKPJ5-0007BL-NF
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 08:55:21 -0500
Date: Thu, 30 Nov 2017 14:54:46 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171130145446.3d47b906.cohuck@redhat.com>
In-Reply-To: <20171130134159.9697-4-eblake@redhat.com>
References: <20171130134159.9697-1-eblake@redhat.com>
	<20171130134159.9697-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] maint: Fix macros with broken
 'do/while(0); ' usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@suse.de>, Jason Wang <jasowang@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, "open list:Xilinx Zynq" <qemu-arm@nongnu.org>, "open
	list:New World" <qemu-ppc@nongnu.org>, "open list:S390" <qemu-s390x@nongnu.org>

On Thu, 30 Nov 2017 07:41:59 -0600
Eric Blake <eblake@redhat.com> wrote:

> The point of writing a macro embedded in a 'do { ... } while (0)'
> loop is so that the macro can be used as a drop-in statement with
> the caller supplying the trailing ';'.  Although our coding style
> frowns on brace-less 'if':
>   if (cond)
>     statement;
>   else
>     something else;
> the use of do/while (0) in a macro is absolutely essential for the
> purpose of avoiding a syntax error on the 'else' - but it only works
> if there is no trailing ';' in the macro (as the ';' in the code
> calling the macro would then be a second statement and cause the
> 'else' to not pair to the 'if').
> 
> Many of the places touched in this code are examples of the ugly
> bit-rotting debug print statements; cleaning those up is left as
> a bite-sized task for another day.
> 
> Found mechanically via: $ git grep -B1 'while (0);' | grep -A1 \\\\
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/acpi-utils.h         | 8 ++++----
>  ui/sdl_zoom_template.h     | 8 ++++----
>  audio/paaudio.c            | 4 ++--
>  hw/adc/stm32f2xx_adc.c     | 2 +-
>  hw/block/m25p80.c          | 2 +-
>  hw/char/cadence_uart.c     | 2 +-
>  hw/char/stm32f2xx_usart.c  | 2 +-
>  hw/display/cg3.c           | 2 +-
>  hw/display/dpcd.c          | 2 +-
>  hw/display/xlnx_dp.c       | 2 +-
>  hw/dma/pl330.c             | 2 +-
>  hw/dma/xlnx-zynq-devcfg.c  | 2 +-
>  hw/dma/xlnx_dpdma.c        | 2 +-
>  hw/i2c/i2c-ddc.c           | 2 +-
>  hw/misc/auxbus.c           | 2 +-
>  hw/misc/macio/mac_dbdma.c  | 4 ++--
>  hw/misc/mmio_interface.c   | 2 +-
>  hw/misc/stm32f2xx_syscfg.c | 2 +-
>  hw/misc/zynq_slcr.c        | 2 +-
>  hw/net/cadence_gem.c       | 2 +-
>  hw/ssi/mss-spi.c           | 2 +-
>  hw/ssi/stm32f2xx_spi.c     | 2 +-
>  hw/ssi/xilinx_spi.c        | 2 +-
>  hw/ssi/xilinx_spips.c      | 2 +-
>  hw/timer/a9gtimer.c        | 2 +-
>  hw/timer/cadence_ttc.c     | 2 +-
>  hw/timer/mss-timer.c       | 2 +-
>  hw/timer/stm32f2xx_timer.c | 2 +-
>  hw/tpm/tpm_passthrough.c   | 2 +-
>  hw/tpm/tpm_tis.c           | 2 +-
>  migration/rdma.c           | 2 +-
>  target/arm/translate-a64.c | 2 +-
>  target/s390x/kvm.c         | 2 +-
>  tests/tcg/test-mmap.c      | 2 +-
>  34 files changed, 42 insertions(+), 42 deletions(-)

> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index b03f583032..06d06010a4 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -58,7 +58,7 @@
>      if (DEBUG_KVM) {                          \
>          fprintf(stderr, fmt, ## __VA_ARGS__); \
>      }                                         \
> -} while (0);
> +} while (0)
> 
>  #define kvm_vm_check_mem_attr(s, attr) \
>      kvm_vm_check_attr(s, KVM_S390_VM_MEM_CTRL, attr)

Acked-by: Cornelia Huck <cohuck@redhat.com>
