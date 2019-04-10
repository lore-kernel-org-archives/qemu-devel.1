Received: from eggs.gnu.org ([209.51.188.92]:39511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1hE7RU-0008L3-OG
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 03:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1hE7RT-00022I-9c
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 03:14:44 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2429 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ann.zhuangyanying@huawei.com>)
	id 1hE7RL-0001uw-Lm
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 03:14:38 -0400
From: Zhuangyanying <ann.zhuangyanying@huawei.com>
Date: Wed, 10 Apr 2019 07:14:17 +0000
Message-ID: <EC9759BC1E3E98429B5DE9A03DF86D8B59ED165F@DGGEML523-MBX.china.huawei.com>
References: <1554819296-14960-1-git-send-email-ann.zhuangyanying@huawei.com>
	<20190409110149-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190409110149-mutt-send-email-mst@kernel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] msix: fix interrupt aggregation problem at
 the passthrough of NVMe SSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Gonglei (Arei)" <arei.gonglei@huawei.com>



> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Tuesday, April 09, 2019 11:04 PM
> To: Zhuangyanying <ann.zhuangyanying@huawei.com>
> Cc: marcel.apfelbaum@gmail.com; qemu-devel@nongnu.org; Gonglei (Arei)
> <arei.gonglei@huawei.com>
> Subject: Re: [PATCH] msix: fix interrupt aggregation problem at the
> passthrough of NVMe SSD
>=20
> On Tue, Apr 09, 2019 at 02:14:56PM +0000, Zhuangyanying wrote:
> > From: Zhuang Yanying <ann.zhuangyanying@huawei.com>
> >
> > Recently I tested the performance of NVMe SSD passthrough and found
> > that interrupts were aggregated on vcpu0(or the first vcpu of each
> > numa) by /proc/interrupts,when GuestOS was upgraded to sles12sp3 (or
> > redhat7.6). But /proc/irq/X/smp_affinity_list shows that the interrupt =
is
> spread out, such as 0-10, 11-21,.... and so on.
> > This problem cannot be resolved by "echo X >
> > /proc/irq/X/smp_affinity_list", because the NVMe SSD interrupt is
> > requested by the API pci_alloc_irq_vectors(), so the interrupt has the
> IRQD_AFFINITY_MANAGED flag.
> >
> > GuestOS sles12sp3 backport "automatic interrupt affinity for MSI/MSI-X
> > capable devices", but the implementation of __setup_irq has no
> > corresponding modification. It is still irq_startup(), then
> > setup_affinity(), that is sending an affinity message when the interrup=
t is
> unmasked.
>=20
> So does latest upstream still change data/address of an unmasked vector?
>=20
The latest upstream works fine. Affinity configuration is successful.

The original order at my understanding is
nvme_setup_io_queues()
 \     \
  \     --->pci_alloc_irq_vectors_affinity()
   \        \
    \        -> msi_domain_alloc_irqs()
     \         \     /* if IRQD_AFFINITY_MANAGED, then "mask =3D affinity "=
 */
      \         -> ...-> __irq_alloc_descs()
       \             \  /* cpumask_copy(desc->irq_common_data.affinity, aff=
inity); */
        \             -> ...-> desc_smp_init()
         ->request_threaded_irq()
            \
             ->__setup_irq()
               \  \
                \  ->irq_startup()->msi_domain_activate()
                 \      \
                  \      ->irq_enable()->pci_msi_unmask_irq()
                   \
                    -->setup_affinity()
                       \    \
                        \    -->if (irqd_affinity_is_managed(&desc->irq_dat=
a))=20
                         \           set =3D desc->irq_common_data.affinity=
;
                          \          cpumask_and(mask, cpu_online_mask, set=
);
                           \
                            -->irq_do_set_affinity()
                                   \
                                    -->msi_domain_set_affinity()
                                          \   /* Actual setting affinity*/
                                           -->__pci_write_msi_msg()

Afetr commit e43b3b58:" genirq/cpuhotplug: Enforce affinity setting on star=
tup of managed irqs "
@@ -265,8 +265,8 @@ int irq_startup(struct irq_desc *desc, bool resend, boo=
l force)
 			irq_setup_affinity(desc);
 			break;
 		case IRQ_STARTUP_MANAGED:
+			irq_do_set_affinity(d, aff, false);
 			ret =3D __irq_startup (desc);
-			irq_set_affinity_locked(d, aff, false);
 			break;
First irq_do_set_affinity(), then __irq_startup(),that is unmask irq.

> > The bare metal configuration is successful, but qemu will not trigger
> > the msix update, and the affinity configuration fails.
> > The affinity is configured by /proc/irq/X/smp_affinity_list,
> > implemented at apic_ack_edge(), the bitmap is stored in pending_mask,
> > mask->__pci_write_msi_msg()->unmask,
> > and the timing is guaranteed, and the configuration takes effect.
> >
> > The GuestOS linux-master incorporates the "genirq/cpuhotplug: Enforce
> > affinity setting on startup of managed irqs" to ensure that the
> > affinity is first issued and then __irq_startup(), for the managerred
> > interrupt. So configuration is successful.
> >
> > It now looks like sles12sp3 (up to sles15sp1, linux-4.12.x), redhat7.6
> > (3.10.0-957.10.1) does not have backport the patch yet.
>=20
> Sorry - which patch?
genirq/cpuhotplug: Enforce affinity setting on startup of managed irqs
commit e43b3b58
>=20
> > "if (is_masked =3D=3D was_masked) return;" can it be removed at qemu?
> > What is the reason for this check?
> >
> > Signed-off-by: Zhuang Yanying <ann.zhuangyanying@huawei.com>
> > ---
> >  hw/pci/msix.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/hw/pci/msix.c b/hw/pci/msix.c index 4e33641..e1ff533
> > 100644
> > --- a/hw/pci/msix.c
> > +++ b/hw/pci/msix.c
> > @@ -119,10 +119,6 @@ static void msix_handle_mask_update(PCIDevice
> > *dev, int vector, bool was_masked)  {
> >      bool is_masked =3D msix_is_masked(dev, vector);
> >
> > -    if (is_masked =3D=3D was_masked) {
> > -        return;
> > -    }
> > -
> >      msix_fire_vector_notifier(dev, vector, is_masked);
> >
> >      if (!is_masked && msix_is_pending(dev, vector)) {
>=20
>=20
> To add to that, notifiers generally assume that updates come in pairs, un=
mask
> followed by mask.
>=20
>=20
>=20
> > --
> > 1.8.3.1
> >
