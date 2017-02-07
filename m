Received: from eggs.gnu.org ([2001:4830:134:3::10]:36797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1caz7s-0000b9-2c
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 01:19:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1caz7p-0005wA-0F
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 01:19:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1caz7o-0005vz-Qf
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 01:19:36 -0500
References: <1486110164-13797-1-git-send-email-peterx@redhat.com>
	<1486110164-13797-19-git-send-email-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d296ebef-cf88-3507-ad5f-818f73701b71@redhat.com>
Date: Tue, 7 Feb 2017 14:19:30 +0800
MIME-Version: 1.0
In-Reply-To: <1486110164-13797-19-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 18/18] intel_iommu: enable vfio devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, alex.williamson@redhat.com, bd.aviv@gmail.com, David Gibson <david@gibson.dropbear.id.au>



On 2017=E5=B9=B402=E6=9C=8803=E6=97=A5 16:22, Peter Xu wrote:
> This patch is based on Aviv Ben-David (<bd.aviv@gmail.com>)'s patch
> upstream:
>
>    "IOMMU: enable intel_iommu map and unmap notifiers"
>    https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg01453.html
>
> However I removed/fixed some content, and added my own codes.
>
> Instead of translate() every page for iotlb invalidations (which is
> slower), we walk the pages when needed and notify in a hook function.
>
> This patch enables vfio devices for VT-d emulation.
>
> And, since we already have vhost DMAR support via device-iotlb, a
> natural benefit that this patch brings is that vt-d enabled vhost can
> live even without ATS capability now. Though more tests are needed.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

[...]

> -        vtd_page_walk(&ce, 0, ~0, vtd_replay_hook, (void *)n);
> +        vtd_page_walk(&ce, 0, ~0, vtd_replay_hook, (void *)n, false);

Should be ~0ULL too, with this fixed.

Reviewed-by: Jason Wang <jasowang@redhat.com>
