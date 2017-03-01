Received: from eggs.gnu.org ([2001:4830:134:3::10]:54163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cj0aF-0002h5-NT
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:30:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cj0aB-0002SG-RD
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:30:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cj0aB-0002SB-Ki
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:30:03 -0500
References: <1487910561-17825-1-git-send-email-peterx@redhat.com>
	<e547f430-d078-27a5-7064-4fc5b9f738d1@redhat.com>
	<20170301023635.GE13926@pxdev.xzpeter.org>
	<20170301043802-mutt-send-email-mst@kernel.org>
	<05a23bbc-4ebc-769b-aa62-d3387af57cae@redhat.com>
	<a35dbe8f-770e-c792-e5ea-1f4f8ef8df37@redhat.com>
	<20170301091831.GF13926@pxdev.xzpeter.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <4e757875-5b48-6eb6-3847-a27787dd6edd@redhat.com>
Date: Wed, 1 Mar 2017 11:29:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170301091831.GF13926@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] intel_iommu: check misordered init when
 realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, yi.l.liu@intel.com, qemu-devel@nongnu.org, Jintack Lim <jintack@cs.columbia.edu>

On 03/01/2017 11:18 AM, Peter Xu wrote:
> On Wed, Mar 01, 2017 at 09:03:47AM +0200, Marcel Apfelbaum wrote:
>> On 03/01/2017 06:14 AM, Jason Wang wrote:
>
> [...]
>
>> Hi Jason,
>>
>> I am not saying we don't need to create the IOMMU before some other device,
>> I just don't think that the command line order should matter to user.
>>
>> BTW, are you working on a way to limit the IOMMU scope to a specific set of devices?
>> If yes, this approach will also help you work.
>
> Marcel,
>
> Do you have any plan after 2.9 to re-arrange the init order thing a
> bit? In general, maybe we need an ordering support for devices.

I don;t know when I'll start it, but yes, I am thinking about
taking this project. We need the ordering in order to be able
to have less "built-in" devices.

> Besides that, I am thinking whether it would be wise that we just init
> the IOMMUs during machine init just like before, but keep the
> "-device" interface? After all, at least the root IOMMU device should
> be with root complex, and it feels a little strange we just split the
> init process apart (we delay the IOMMU init into device
> initializations).
>

Keeping the IOMMU creation as part of the Root Complex is problematic.
What happens if we want to limit the IOMMU scope to a subset of devices?
How will the command line look? Also we may want/need multiple iommu
devices per system. It will not happen tomorrow, but we don't want to loose
this possibility.

The device re-ordering is not 2.9 material of course, and we need your patch.
The only thing we can do better is to take out the "vfio-pci" in another header
file and and have it in a array of devices that should be checked
(in order to avoid polluting the IOMMU code with a not related device)

I can try and send a patch for it if you prefer.

Thanks,
Marcel

> Not sure whether above makes sense though. Thanks,
>
> -- peterx
>
