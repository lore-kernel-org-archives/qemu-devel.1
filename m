Received: from eggs.gnu.org ([2001:4830:134:3::10]:45905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cgUab-0007Fo-Q9
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cgUaW-00075s-Up
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:56:05 -0500
Received: from 16.mo3.mail-out.ovh.net ([188.165.56.217]:60668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cgUaW-00071K-Kw
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:56:00 -0500
Received: from player797.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 691F79C635
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 11:55:51 +0100 (CET)
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<20170222033423.GK12577@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e58f7cfa-c03c-ca25-a973-7894253d2dcc@kaod.org>
Date: Wed, 22 Feb 2017 11:55:40 +0100
MIME-Version: 1.0
In-Reply-To: <20170222033423.GK12577@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/22] ppc/xics: simplify ICS and ICP
 creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 02/22/2017 04:34 AM, David Gibson wrote:
> On Thu, Feb 16, 2017 at 02:47:23PM +0100, C=E9dric Le Goater wrote:
>> Hello,
>>
>> The goal behind this series is to simplify the XICS interface by
>> moving back in the machine the way the ICS and ICP objects interact
>> together. It's up to the machine to implement this "fabric" logic by
>> providing a set of handlers of a QOM interface. These handlers are
>> used to grab an ICS or an ICP object and also do irq resends. This
>> idea was suggested by David Gibson.
>>
>> The patchset is organised as follow. It starts with a preliminary
>> cleanup to get rid of the set_nr_irqs() and set_nr_servers()
>> handlers. It also moves the creation of the ICS and ICP objects from
>> the XICS object to the sPAPR machine. This simplifies the code
>> significantly and prepares ground for future changes.
>>
>> As the sPAPR machine only makes use of a single ICS, we can store it
>> at the machine level. This lets us remove dependencies on the list of
>> ICS of the XICS object and simplify even more the code for the
>> following changes.
>>
>> The QOM interface to interact with the ICS and ICP objects is then
>> introduced. These are moved under the machine and cleanups are done
>> accordingly.
>>
>> Finally, the XICSState classes are removed as they have been
>> deprecated by the QOM interface.
>>
>>
>> After the initial cleanups, which are rather big, I have tried to keep
>> the each patch small enough to ease the review and to spot any
>> problem. Each should be bisectable. The tree is available here :
>>
>> 	   https://github.com/legoater/qemu/tree/ppc-2.9
>=20
> So, after you posted this, I discover the patch I sent the other day -
> changing XICS away from a SysBusDevice breaks the postcopy migration
> test on KVM.  I haven't had a chance to debug this yet, so for the
> time being I've pulled my patch from ppc-for-2.9.  I've moved it into
> a new 'xics-cleanup' branch.

It is even worse than that, the kernel does not start. This is because
the ICS and ICP objects are not reseted  anymore and so the mfrr and
irq priority values are incorrect : 0x0 instead of 0xFF.=20

Before that patch, the reset was implicit because the device was a=20
SysBusDevice and all the devices were reseted when the bus was. =20

Other devices (not on a bus or/and QOM objects) need to register on=20
SysBus to be reseted :
 =20
	qdev_set_parent_bus(dev, sysbus_get_default());

or use a handler for :

	qemu_register_reset()

which will be called by qemu_devices_reset()

I fell into this trap a few times with PowerNV and I should have=20
spotted it before adding my Reviewed-by. Sorry about that.


So, to move on, we can use the fix below (You can merge it in your=20
patch). I also updated my branch with it :=20

	https://github.com/legoater/qemu/commits/ppc-2.9

I have checked that KVM and TCG migration still worked with the=20
patchset and also rebased PowerNV on it. All seem to work. Tell
me if you want a resend. The patchset needs some review any how=20
and there should be some comment to address so it might be a bit=20
too early for a resend.=20



FYI, the xics-cleanup branch has some issue with migration :

qemu-system-ppc64: VQ 0 size 0x80 < last_avail_idx 0x9f9 - used_idx 0x0
qemu-system-ppc64: Failed to load virtio-blk:virtio
qemu-system-ppc64: error while loading state for instance 0x0 of device '=
pci@800000020000000:01.0/virtio-blk'

This is most probably a temporary regression, unrelated to XICS=20
though.=20
=20
Thanks,

C.

>From f01dd87954b818096e4fb8c85265ea71a0075975 Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?C=3DC3=3DA9dric=3D20Le=3D20Goater?=3D <clg@kaod.org>
Date: Wed, 22 Feb 2017 10:50:25 +0100
Subject: [PATCH] ppc/xics: fix ICP and ICS reset
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

commit 5b17c7207938 ("xics: XICS should not be a SysBusDevice")
changed the nature of the XICS object to be a descendent of
TYPE_DEVICE. By doing so, the object is not on a bus and its reset
handler is not called anymore. The direct consequence is that the ICP
and ICS objects are not correctly initialized and so the IRQ subsystem
is broken in the guest.

Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c        | 1 +
 include/hw/ppc/xics.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8af54494f166..fa6a2947c791 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -104,6 +104,7 @@ static XICSState *try_create_xics(const char *type, i=
nt nr_servers,
     dev =3D DEVICE(object_new(type));
     qdev_prop_set_uint32(dev, "nr_servers", nr_servers);
     qdev_prop_set_uint32(dev, "nr_irqs", nr_irqs);
+    qdev_set_parent_bus(dev, sysbus_get_default());
     object_property_set_bool(OBJECT(dev), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 3f0c31610aa4..1aefd3d52257 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -80,7 +80,7 @@ struct XICSStateClass {
=20
 struct XICSState {
     /*< private >*/
-    SysBusDevice parent_obj;
+    DeviceState parent_obj;
     /*< public >*/
     uint32_t nr_servers;
     uint32_t nr_irqs;
--=20
2.7.4
