Received: from eggs.gnu.org ([2001:4830:134:3::10]:40377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1et9nx-0002wn-Bc
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:26:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1et9nu-0002qx-9B
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:26:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52160 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1et9nu-0002qb-5J
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:26:42 -0500
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-12-git-send-email-yi.l.liu@linux.intel.com>
	<a899b75f-5a0b-2a0f-f995-5a3c21eeab8c@redhat.com>
	<20180305091119.GH2482@sky-dev>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <afb9cbb9-3b05-7677-5707-6deb540daf26@redhat.com>
Date: Tue, 6 Mar 2018 11:26:30 +0100
MIME-Version: 1.0
In-Reply-To: <20180305091119.GH2482@sky-dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 11/12] intel_iommu: add framework for
 PASID AddressSpace management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au, kevin.tian@intel.com, yi.l.liu@intel.com, jasowang@redhat.com, peterx@redhat.com, alex.williamson@redhat.com, eric.auger.pro@gmail.com

On 05/03/2018 10:11, Liu, Yi L wrote:
>> Do you really need VTDDeviceNode?  I think can you simply put the
>> QLIST_ENTRY in VTDAddressSpace (named e.g. next_by_pasid), since
>> VTDAddressSpace already includes a (bus, devfn).
> Existing VTDAddressSpace is actaully per-device. While for PASID tagged
> address space, it is possible to have multiple devices tied to a single
> PASID tagged address space.

Yes, that's the purpose of VTDPASIDAddressSpace.

> Reuse VTDAddressSpace could be a choice since
> it is a per-device structure, but it may be missleading since there is
> other fileds in VTDAddressSpace. This is why I proposed to have VTDDevi=
ceNode.

I think it's okay to put all per-device setup in VTDAddressSpace.  Later
if it makes sense VTDAddressSpace could become a union, according to
whether the IOMMU is configured for PASID or requester ID operation, and
could be renamed to VTDDeviceInfo.  But for now it's not needed.

Paolo

> But consolidation is possible here.
