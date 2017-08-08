Received: from eggs.gnu.org ([2001:4830:134:3::10]:50141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1df0cD-0003qR-AE
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 05:15:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1df0c9-0001yU-3V
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 05:15:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1df0c8-0001yB-Qv
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 05:15:49 -0400
Date: Tue, 8 Aug 2017 11:15:42 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170808111542.16422571@gondolin>
In-Reply-To: <20170804165934.4d6fb98f@gondolin>
References: <20170804112946.5247-1-cohuck@redhat.com>
	<20170804165934.4d6fb98f@gondolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/9] s390x: zPCI detangling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

On Fri, 4 Aug 2017 16:59:34 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri,  4 Aug 2017 13:29:37 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>=20
> > Next version, not so many changes from v3.
> >=20
> > As you might have guessed, the goals are still the same:
> > - Being able to disable PCI support in a build completely.
> > - Properly fencing off PCI if the relevant facility bit is not provided.
> >=20
> > Changes v3->v4:
> > - introduce pci_available boolean
> > - use pci_available to fence off setting the zcpi facility bit
> > - collected tags
> >=20
> > Branch is still git://github.com/cohuck/qemu no-zpci-cpumodel =20
>=20
> make check on a build with pci disabled revealed an interesting
> inconsistency: We create a virtio-9p-ccw device, but the base
> virtio-9p-device is in code that is not built for !pci.
>=20
> If I remove the pci dependency for hw/9pfs/ and fsdev/, things look
> fine (at least on s390x). We probably need a different dependency,
> though.
>=20
> virtio-9p maintainers, any suggestions?

I have the patch below, which is ugly, but seems to work for me. Better
ideas welcome :)

=46rom 0ba6427e7ac7cef38b487d28c9dce653d8cb9a71 Mon Sep 17 00:00:00 2001
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 8 Aug 2017 11:03:38 +0200
Subject: [PATCH] 9pfs: fix dependencies

Nothing in fsdev/ or hw/9pfs/ depends on pci; it should rather depend
on CONFIG_VIRTFS and on the presence of an appropriate virtio transport
device.

Let's introduce CONFIG_VIRTIO_CCW to cover s390x and check for
CONFIG_VIRTFS && (CONFIG_VIRTIO_PCI || CONFIG_VIRTIO_CCW).

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 default-configs/s390x-softmmu.mak | 1 +
 fsdev/Makefile.objs               | 9 +++------
 hw/Makefile.objs                  | 2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-soft=
mmu.mak
index 6ab2bc65ac..7f15ab68b1 100644
--- a/default-configs/s390x-softmmu.mak
+++ b/default-configs/s390x-softmmu.mak
@@ -8,3 +8,4 @@ CONFIG_S390_FLIC=3Dy
 CONFIG_S390_FLIC_KVM=3D$(CONFIG_KVM)
 CONFIG_VFIO_CCW=3D$(CONFIG_LINUX)
 CONFIG_WDT_DIAG288=3Dy
+CONFIG_VIRTIO_CCW=3Dy
diff --git a/fsdev/Makefile.objs b/fsdev/Makefile.objs
index 659df6e187..10d8caa291 100644
--- a/fsdev/Makefile.objs
+++ b/fsdev/Makefile.objs
@@ -1,10 +1,7 @@
-ifeq ($(CONFIG_VIRTIO)$(CONFIG_VIRTFS)$(CONFIG_PCI),yyy)
 # Lots of the fsdev/9pcode is pulled in by vl.c via qemu_fsdev_add.
-# only pull in the actual virtio-9p device if we also enabled virtio.
-common-obj-y =3D qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o
-else
-common-obj-y =3D qemu-fsdev-dummy.o
-endif
+# only pull in the actual virtio-9p device if we also enabled a virtio bac=
kend.
+common-obj-$(call land, $(CONFIG_VIRTFS),$(call lor, $(CONFIG_VIRTIO_PCI),=
$(CONFIG_VIRTIO_CCW)))=3D qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o
+common-obj-$(call lnot, $(call land, $(CONFIG_VIRTFS),$(call lor, $(CONFIG=
_VIRTIO_PCI),$(CONFIG_VIRTIO_CCW)))) =3D qemu-fsdev-dummy.o
 common-obj-y +=3D qemu-fsdev-opts.o qemu-fsdev-throttle.o
=20
 # Toplevel always builds this; targets without virtio will put it in
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index a2c61f6b09..10942fe0b4 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -1,4 +1,4 @@
-devices-dirs-$(call land, $(CONFIG_VIRTIO),$(call land,$(CONFIG_VIRTFS),$(=
CONFIG_PCI))) +=3D 9pfs/
+devices-dirs-$(call land, $(CONFIG_VIRTFS),$(call lor,$(CONFIG_VIRTIO_PCI)=
,$(CONFIG_VIRTIO_CCW))) +=3D 9pfs/
 devices-dirs-$(CONFIG_SOFTMMU) +=3D acpi/
 devices-dirs-$(CONFIG_SOFTMMU) +=3D adc/
 devices-dirs-$(CONFIG_SOFTMMU) +=3D audio/
--=20
2.13.4
