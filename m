Received: from eggs.gnu.org ([2001:4830:134:3::10]:36074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1et9Py-0000Dp-Bj
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:02:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1et9Pr-0000dn-D9
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:01:58 -0500
References: <1519746259-27710-1-git-send-email-akrowiak@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d4d35d0e-b8a4-f30f-f9ad-71c405e80d18@redhat.com>
Date: Tue, 6 Mar 2018 11:01:35 +0100
MIME-Version: 1.0
In-Reply-To: <1519746259-27710-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/5] s390x: vfio-ap: guest dedicated
 crypto adapters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 27.02.2018 16:44, Tony Krowiak wrote:
> This patch series is the QEMU counterpart to the KVM/kernel support for=
=20
> guest dedicated crypto adapters. The KVM/kernel model is built on the=20
> VFIO mediated device framework and provides the infrastructure for=20
> granting exclusive guest access to crypto devices installed on the linu=
x=20
> host. This patch series introduces a new QEMU command line option, QEMU=
=20
> object model and CPU model features to exploit the KVM/kernel model.
>=20
> See the detailed specifications for AP virtualization provided by this=20
> patch set in docs/vfio-ap.txt for a more complete discussion of the=20
> design introduced by this patch series.
>=20
> v1 -> v2 Change log:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> * Removed unnecessary S390APMatrixDevice, S390APMatrixDeviceClass=20
> * Removed ioctl to configure the AP matrix for the guest: letting the
>   vfio_ap device driver's 'open' callback configure the AP matrix
>   for the guest
> * Removed masks from object model: Unnecessary at this point because th=
ey=20
>   are not currently used=20
> * Renamed:
>   * VFIOAPMatrixDevice to VFIOAPDevice
>   * VFIOAPMatrixDeviceClass to VFIOAPDeviceClass
>   * APMatrixDevice to APDevice
>   * APMatrixDeviceClass to APDeviceClass
>   * ap-matrix.c to ap.c (in hw/vfio)
>   * ap-matrix-device.c to ap-device.c (in hw/s390x)
>   * ap-matrix-device.h to ap-device.h (in include/hw/s390x)
> * Added CPU model feature for AP facilities installed on guest and=20
>   facilities features for QCI Instructions Available (STFLE.12) and AP=20
>   Facilities Test facility installed (STFLE.15).
>=20
> Tony Krowiak (5):
>   s390x/ap: base Adjunct Processor (AP) object
>   s390x/vfio: ap: VFIO: linux header updates
>   s390x/vfio: ap: Introduce VFIO AP device
>   s390x/cpumodel: Set up CPU model for AP device support
>   s390: doc: detailed specifications for AP virtualization
>=20

I'm going to highlight an issue that stems from bad HW design: The lack
of an AP interpretation facility (indication). We e.g. have something
like that for zPCI (and all other I/O besides AP as far as I remember).

Let's assume L1 provides AP to L2.
Let's assume L2 provides AP to L3.

L2 can blindly forward APs to L3 because it sees the AP facility. This
requires AP vSIE support. We have no separate way of indicating that
support, it comes with the AP feature. So let's assume L2 does not
emulate devices but uses interpretation for L3.

Everything is fine as long as L1 does not emulate AP
devices/instructions for L2. All instructions are interpreted by HW.

But what happens if L1 emulates AP devices for L2? intepretation is
disabled. QEMU handles it.

However L2 can simply forward AP devices to L3. At this point, we must
also intercept and emulate AP instructions issued by L3 in _L1_.

This is what we call the nightmare of nested virtualization (see x86),
because we have to emulate L3 instructions in L1 - but even worse, not
even in L1 kernel space but in L1 user space.


Long story short:

Making this scenario work would require a _huge_ effort (going to user
space with nested guest state - or communicating with the user space
part using some other mechanism).

So we could never provide the AP feature reliably with the SIE feature.
We want to avoid interdependence between CPU features. (because
everything else makes CPU feature detection ugly - CMMA is a good
example and the only exception so far)


Long story even shorter:

No emulated AP devices with KVM.

--=20

Thanks,

David / dhildenb
