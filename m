Received: from eggs.gnu.org ([2001:4830:134:3::10]:51966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dWmqZ-0003xt-Un
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 12:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dWmqV-0003a2-29
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 12:56:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dWmqU-0003Zb-Or
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 12:56:38 -0400
References: <20170716082917.720-1-dmitry@daynix.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <09ea0b99-783f-263c-fd47-801c933fb398@redhat.com>
Date: Sun, 16 Jul 2017 19:56:31 +0300
MIME-Version: 1.0
In-Reply-To: <20170716082917.720-1-dmitry@daynix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pci: honor PCI_COMMAND_MEMORY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dmitry Fleytman <dmitry@daynix.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Sameeh Jubran <sameeh@daynix.com>

On 16/07/2017 11:29, Dmitry Fleytman wrote:
> According to PCI spec. bit 1 of command
> register (PCI_COMMAND_MEMORY) controls
> a device's response to memory space accesses.
> A value of 0 disables the device response.
> A value of 1 allows the device to respond
> to memory space accesses.
>

Hi Dmitry,


> Current behavior introduced by commit
> 
>    commit 1c380f9460522f32c8dd2577b2a53d518ec91c6d
>    Author: Avi Kivity <avi@redhat.com>
>    Date:   Wed Oct 3 17:42:58 2012 +0200
> 
>        pci: honor PCI_COMMAND_MASTER
> 
> is to ignore device memory space accesses unless
> bit 2 (PCI_COMMAND_MASTER) is set.
> 
> Aforementioned commit introduced regression of
> Windows hibernation (S4) functionality support
> because on resume Windows kernel sets bits 0 and 1
> (PCI_COMMAND_MEMORY | PCI_COMMAND_IO) of boot
> device's (piix3-ide in our specific case) command
> register and tries to work with the device.
> > Since PCI_COMMAND_MASTER bit is not set, device
> does not answer and Windows fails to resume from
> hibernation.
> 

As far as I am aware "Bus master" is needed for a device
to start PCI transactions, while PCI_COMMAND_MEMORY/IO
controls the device ability to respond to memory/IO accesses,
not to start them.
If "Bus master" is needed for DMA access or MSI, the OS should
explicitly set the  PCI_COMMAND_MASTER, right?



> As a result following BSOD happens:
> 
>    BugCheck A0, {10e, a, aa00, 418}
> 
>    Probably caused by : ntkrnlmp.exe ( nt!PopHiberChecksumHiberFileData+b346 )
> 
>    Followup:     MachineOwner
>    ---------
> 
>    0: kd> !analyze -v
>    *******************************************************************************
>    *                                                                             *
>    *                        Bugcheck Analysis                                    *
>    *                                                                             *
>    *******************************************************************************
> 
>    INTERNAL_POWER_ERROR (a0)
>    The power policy manager experienced a fatal error.
>    Arguments:
>    Arg1: 000000000000010e, The disk subsystem returned corrupt data while reading from the
>        hibernation file.
>    Arg2: 000000000000000a
>    Arg3: 000000000000aa00, Incorrect checksum
>    Arg4: 0000000000000418, Previous disk read's checksum
> 

Does piix3-ide fail to respond to IO/MEM accesses if
PCI_COMMAND_MASTER is not set? Or is it a DMA issue?


Thanks,
Marcel

> According to our tests this problem happens at least on
> Windows 8/8.1/2012/2012R2/10/2016.
> 
> This patch solves https://bugzilla.redhat.com/show_bug.cgi?id=988351
> 
> Signed-off-by: Dmitry Fleytman <dmitry@daynix.com>
> ---
>   hw/pci/pci.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 0c6f74a..10af82f 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -480,7 +480,7 @@ static int get_pci_config_device(QEMUFile *f, void *pv, size_t size,
>   
>       memory_region_set_enabled(&s->bus_master_enable_region,
>                                 pci_get_word(s->config + PCI_COMMAND)
> -                              & PCI_COMMAND_MASTER);
> +                              & (PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY));
>   
>       g_free(config);
>       return 0;
> @@ -1356,7 +1356,7 @@ void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int
>           pci_update_irq_disabled(d, was_irq_disabled);
>           memory_region_set_enabled(&d->bus_master_enable_region,
>                                     pci_get_word(d->config + PCI_COMMAND)
> -                                    & PCI_COMMAND_MASTER);
> +                                  & (PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY));
>       }
>   
>       msi_write_config(d, addr, val_in, l);
> 
