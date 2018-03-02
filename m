Received: from eggs.gnu.org ([2001:4830:134:3::10]:45726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1erm2Y-0002B8-2x
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:52:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1erm2V-0005qL-1V
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:52:06 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60068 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1erm2U-0005pZ-UA
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:52:02 -0500
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-13-git-send-email-yi.l.liu@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b87dbbf4-1fe5-babd-e5d3-366bb5beb396@redhat.com>
Date: Fri, 2 Mar 2018 15:51:53 +0100
MIME-Version: 1.0
In-Reply-To: <1519900415-30314-13-git-send-email-yi.l.liu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 12/12] intel_iommu: bind device to PASID
 tagged AddressSpace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>, qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au
Cc: alex.williamson@redhat.com, eric.auger.pro@gmail.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com

On 01/03/2018 11:33, Liu, Yi L wrote:
> +    IntelPASIDNode *node;
> +    char name[128];
> +
> +    QLIST_FOREACH(node, &(s->pasid_as_list), next) {
> +        vtd_pasid_as = node->pasid_as;
> +        if (pasid == vtd_pasid_as->sva_ctx.pasid) {
> +            return vtd_pasid_as;
> +        }
> +    }
> +
> +    vtd_pasid_as = g_malloc0(sizeof(*vtd_pasid_as));
> +    vtd_pasid_as->iommu_state = s;
> +    snprintf(name, sizeof(name), "intel_iommu_pasid_%d", pasid);
> +    address_space_init(&vtd_pasid_as->as, NULL, "pasid");

The name is unused here.  The call to address_space_init should probably
use it.

You also don't need the separate IntelPASIDNode, because the
QLIST_ENTRY can be placed directly in VTDPASIDAddressSpace.

Paolo
