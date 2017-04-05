Received: from eggs.gnu.org ([2001:4830:134:3::10]:44547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cvhHE-0005F9-Of
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 05:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cvhHA-000681-Ms
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 05:30:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cvhHA-00067n-Eq
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 05:30:52 -0400
References: <20170405081209.26814-1-pbonzini@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <10ed2863-e925-a0cc-46a2-52f752f37218@redhat.com>
Date: Wed, 5 Apr 2017 11:30:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170405081209.26814-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9] tco: do not generate an NMI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Paulo Alcantara <pcacjr@gmail.com>, Paulo Alcantara <pcacjr@zytor.com>

CC Paulo

On 04/05/17 10:12, Paolo Bonzini wrote:
> This behavior is not indicated in the datasheet and can confuse the OS.

* The message of commit 920557971b60 ("ich9: add TCO interface
emulation", 2015-06-28) says

> ... This patch adds support to TCO watchdog logic and few other
> features like mapping NMIs to SMIs (NMI2SMI_EN bit), system intruder
> detection, etc. are not implemented yet.

(Terrible punctuation -- "and" should have been replaced by a full stop
-- but the intent is clear.)

Looking at the ICH9 spec,

- TCO1_STS has a bit called NMI2SMI_STS, where value 1 means "Set by the
ICH9 when an SMI# occurs because an event occurred that would
otherwise have caused an NMI (because NMI2SMI_EN is set)."

- TCO1_CNT contains the bit called NMI2SMI_EN, where value 0 corresponds
to "Normal NMI functionality."

These do appear to suggest that the normal timeout action for the
watchdog is to inject and NMI, don't they?

* Does this patch keep "tests/tco-test.c" in working shape?

* Would blacklisting the iTCO_wdt module in the guest be a suitable
counter-measure? Should OS installers be modified to blacklist
"iTCO_wdt" by default if they detect a KVM guest?

(Idea taken from "Documentation/sysctl/kernel.txt", near "nmi_watchdog"
-- "The NMI watchdog is disabled by default if the kernel is running as
a guest in a KVM virtual machine.")

Thanks,
Laszlo

> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/acpi/tco.c          | 2 --
>  hw/isa/lpc_ich9.c      | 5 -----
>  include/hw/i386/ich9.h | 1 -
>  3 files changed, 8 deletions(-)
> 
> diff --git a/hw/acpi/tco.c b/hw/acpi/tco.c
> index b4adac8..05b9d7b 100644
> --- a/hw/acpi/tco.c
> +++ b/hw/acpi/tco.c
> @@ -75,8 +75,6 @@ static void tco_timer_expired(void *opaque)
>  
>      if (pm->smi_en & ICH9_PMIO_SMI_EN_TCO_EN) {
>          ich9_generate_smi();
> -    } else {
> -        ich9_generate_nmi();
>      }
>      tr->tco.rld = tr->tco.tmr;
>      tco_timer_reload(tr);
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index 59930dd..a0866c3 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -312,11 +312,6 @@ void ich9_generate_smi(void)
>      cpu_interrupt(first_cpu, CPU_INTERRUPT_SMI);
>  }
>  
> -void ich9_generate_nmi(void)
> -{
> -    cpu_interrupt(first_cpu, CPU_INTERRUPT_NMI);
> -}
> -
>  static int ich9_lpc_sci_irq(ICH9LPCState *lpc)
>  {
>      switch (lpc->d.config[ICH9_LPC_ACPI_CTRL] &
> diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
> index 18dcca7..673d13d 100644
> --- a/include/hw/i386/ich9.h
> +++ b/include/hw/i386/ich9.h
> @@ -21,7 +21,6 @@ void ich9_lpc_pm_init(PCIDevice *pci_lpc, bool smm_enabled);
>  I2CBus *ich9_smb_init(PCIBus *bus, int devfn, uint32_t smb_io_base);
>  
>  void ich9_generate_smi(void);
> -void ich9_generate_nmi(void);
>  
>  #define ICH9_CC_SIZE (16 * 1024) /* 16KB. Chipset configuration registers */
>  
> 
