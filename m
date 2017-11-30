Received: from eggs.gnu.org ([2001:4830:134:3::10]:42361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eKEH4-0006ud-Nn
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 21:08:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eKEH1-00069f-HH
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 21:08:26 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:38304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eKEH1-00067P-8n
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 21:08:23 -0500
Received: by mail-pg0-x244.google.com with SMTP id f12so2360124pgo.5
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 18:08:23 -0800 (PST)
References: <20171122051649.3599-1-aik@ozlabs.ru>
	<20171129083347.1b6c0859@t450s.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <d1a7a7f6-867b-292a-84e8-b5fb459325df@ozlabs.ru>
Date: Thu, 30 Nov 2017 13:08:17 +1100
MIME-Version: 1.0
In-Reply-To: <20171129083347.1b6c0859@t450s.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] vfio: Allow configuration without INTx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 30/11/17 02:33, Alex Williamson wrote:
> On Wed, 22 Nov 2017 16:16:49 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> On some platforms INTx may not be enabled on a KVM host (one such
>> example is IBM pHyp hypervisor and this is intentional). However
>> the PCI_INTERRUPT_PIN is not 0 so QEMU tries initializing INTx, fails as
>> (!vdev->pdev->irq) in the VFIO's vfio_intx_enable() and this is
>> a fatal error.
>>
>> This adds a debug switch - "x-no-intx" - in order to allow broken INTx
>> configuration.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>
>> In practice, test teams run PR KVM under HV KVM and there INTx is enabled
>> on all levels so having this as a debug switch is enough.
>> ---
>>  hw/vfio/pci.h | 1 +
>>  hw/vfio/pci.c | 8 +++++++-
>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index 502a575..c5e168e 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -141,6 +141,7 @@ typedef struct VFIOPCIDevice {
>>      bool has_flr;
>>      bool has_pm_reset;
>>      bool rom_read_failed;
>> +    bool no_intx;
>>      bool no_kvm_intx;
>>      bool no_kvm_msi;
>>      bool no_kvm_msix;
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index c977ee3..c9caf6a 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2869,7 +2869,12 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>          pci_device_set_intx_routing_notifier(&vdev->pdev, vfio_intx_update);
>>          ret = vfio_intx_enable(vdev, errp);
>>          if (ret) {
>> -            goto out_teardown;
>> +            if (vdev->no_intx) {
>> +                error_report_err(*errp);
>> +                *errp = NULL;
>> +            } else {
>> +                goto out_teardown;
>> +            }
> 
> Why do we try to setup INTx and let it fail, potentially with errors to
> the log, if the user has specified x-no-intx?

Fair enough, could just avoid the whole intx logic in this case.

> Why does the kernel
> advertise INTx is available via the pin register if it's not
> supported? 

It is a host under phyp (the other IBM hypervisor) so it takes the
interrupt configuragion from the device tree or RTAS services (for MSI),
not from the config space so if there is some inconsistency - then it is
pHyp to blame.

> I'm not opposed to a debug flag to disable INTx, but by
> definition, "x-" prefix flags are not supported and it seems like you
> have a configuration that needs a supported mechanism of turning this
> off.  Thanks,

Well, running VFIO under PR KVM under pHyp is not supported, I am the only
person actually trying this and mostly to make sure that we get all these
guest/host PTEs right. What we could consider supporting is DPDK in the
pHyps guest but it does not care about this INTx business.


> 
> Alex
> 
>>          }
>>      }
>>  
>> @@ -2986,6 +2991,7 @@ static Property vfio_pci_dev_properties[] = {
>>      DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
>>                      VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>>      DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
>> +    DEFINE_PROP_BOOL("x-no-intx", VFIOPCIDevice, no_intx, false),
>>      DEFINE_PROP_BOOL("x-no-kvm-intx", VFIOPCIDevice, no_kvm_intx, false),
>>      DEFINE_PROP_BOOL("x-no-kvm-msi", VFIOPCIDevice, no_kvm_msi, false),
>>      DEFINE_PROP_BOOL("x-no-kvm-msix", VFIOPCIDevice, no_kvm_msix, false),
> 


-- 
Alexey
