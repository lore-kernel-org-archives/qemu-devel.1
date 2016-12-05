Received: from eggs.gnu.org ([2001:4830:134:3::10]:35425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cDxJO-0005NT-1o
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:44:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cDxJJ-0004Hg-At
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:44:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cDxJJ-0004H5-55
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:44:17 -0500
Message-ID: <1480959854.28320.21.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 05 Dec 2016 18:44:14 +0100
In-Reply-To: <580DB32F.8040806@intel.com>
References: <1476739332-4911-1-git-send-email-kwankhede@nvidia.com>
	<580DB32F.8040806@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v9 00/12] Add Mediated device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jike Song <jike.song@intel.com>
Cc: Kirti Wankhede <kwankhede@nvidia.com>, alex.williamson@redhat.com, cjia@nvidia.com, pbonzini@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, kevin.tian@intel.com, bjsdjshi@linux.vnet.ibm.com, linux-kernel@vger.kernel.org

  Hi,

> Just want to share that we have published a KVMGT implementation
> based on this v9 patchset, to:
>=20
> 	https://github.com/01org/gvt-linux/tree/gvt-next-kvmgt
>=20
> It doesn't utilize common routines introduced by 05+ patches yet.
> The complete intel vGPU device-model is contained.

Tried to use this implementation.  Used the
topic/gvt-next-kvmgt-mdev-2016-11-18 branch which looked like the most
recent one.  Setup:

  * Everything compiled as modules.
  * iommu turned off for the igd (intel_iommu=3Don,igfx_off).
  * Blacklisted i915 so dracut initrd doesn't load it
    (rd.driver.blacklist=3Di915)
  * tweaked module config so kvmgt is loaded before i915,
    also enable gvt:

      # cat /etc/modprobe.d/kraxel-gvt.conf=20
      options i915 enable_gvt=3D1
      softdep i915 pre: kvmgt

Everything seems to load fine.  Sysfs files are there, and I can create
vgpus.

Trying to assign a vgpu this way:

  -device vfio-pci,sysfsdev=3D/sys/class/mdev_bus/0000:00:02.0/<uuid>

fails though and gives this message in the kernel log:

  [  402.560350] [drm:intel_vgpu_open [kvmgt]] *ERROR* gvt: KVM is
required to use Intel vGPU

Trying the same with a mtty sample device works and I can see the pci
serial device in the guest.

Any clues what is going wrong?

Has this version any support for exporting the guest display as dma-buf,
so qemu can show it?  Or is this a headless vgpu?

thanks,
  Gerd
