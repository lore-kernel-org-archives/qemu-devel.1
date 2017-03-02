Received: from eggs.gnu.org ([2001:4830:134:3::10]:46439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cjHgt-0003Ze-S3
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 22:46:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cjHgp-00045i-4Q
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 22:46:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cjHgo-00045C-NF
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 22:46:03 -0500
Date: Thu, 2 Mar 2017 11:45:56 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170302034556.GL13926@pxdev.xzpeter.org>
References: <1487910561-17825-1-git-send-email-peterx@redhat.com>
	<e547f430-d078-27a5-7064-4fc5b9f738d1@redhat.com>
	<20170301023635.GE13926@pxdev.xzpeter.org>
	<20170301043802-mutt-send-email-mst@kernel.org>
	<05a23bbc-4ebc-769b-aa62-d3387af57cae@redhat.com>
	<a35dbe8f-770e-c792-e5ea-1f4f8ef8df37@redhat.com>
	<20170301091831.GF13926@pxdev.xzpeter.org>
	<4e757875-5b48-6eb6-3847-a27787dd6edd@redhat.com>
	<20170301095928.GG13926@pxdev.xzpeter.org>
	<237f48d3-20eb-af1e-30ad-16a855607cdc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <237f48d3-20eb-af1e-30ad-16a855607cdc@redhat.com>
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
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, yi.l.liu@intel.com, qemu-devel@nongnu.org, Jintack Lim <jintack@cs.columbia.edu>

On Wed, Mar 01, 2017 at 02:32:34PM +0200, Marcel Apfelbaum wrote:
> On 03/01/2017 11:59 AM, Peter Xu wrote:
> >On Wed, Mar 01, 2017 at 11:29:47AM +0200, Marcel Apfelbaum wrote:
> >>On 03/01/2017 11:18 AM, Peter Xu wrote:
> >>>On Wed, Mar 01, 2017 at 09:03:47AM +0200, Marcel Apfelbaum wrote:
> >>>>On 03/01/2017 06:14 AM, Jason Wang wrote:
> >>>
> >>>[...]
> >>>
> >>>>Hi Jason,
> >>>>
> >>>>I am not saying we don't need to create the IOMMU before some other device,
> >>>>I just don't think that the command line order should matter to user.
> >>>>
> >>>>BTW, are you working on a way to limit the IOMMU scope to a specific set of devices?
> >>>>If yes, this approach will also help you work.
> >>>
> >>>Marcel,
> >>>
> >>>Do you have any plan after 2.9 to re-arrange the init order thing a
> >>>bit? In general, maybe we need an ordering support for devices.
> >>
> >>I don;t know when I'll start it, but yes, I am thinking about
> >>taking this project. We need the ordering in order to be able
> >>to have less "built-in" devices.
> >
> >That'll be great!
> >
> >>
> >>>Besides that, I am thinking whether it would be wise that we just init
> >>>the IOMMUs during machine init just like before, but keep the
> >>>"-device" interface? After all, at least the root IOMMU device should
> >>>be with root complex, and it feels a little strange we just split the
> >>>init process apart (we delay the IOMMU init into device
> >>>initializations).
> >>>
> >>
> >>Keeping the IOMMU creation as part of the Root Complex is problematic.
> >>What happens if we want to limit the IOMMU scope to a subset of devices?
> >>How will the command line look? Also we may want/need multiple iommu
> >>devices per system. It will not happen tomorrow, but we don't want to loose
> >>this possibility.
> >
> >I think that won't be a big problem. E.g., I don't see big problem if
> >we just create all these vIOMMUs along with machine init. Is there?
> >
> 
> How would you assign them do devices?
> 
> The "normal" QEMU cmd line would look like I mentioned earlier:
> 
> -device iommu,id=iommu1 -device pcie-root,iommu=iommu1 \
> -device pcie-root \
> -device iommu,id=iommu2 -device pcie-root,iommu=iommu2 \
> 
> How do you propose to do it otherwise?

I totally agree that we can use the way above when we wants to bind
device with specific vIOMMU device. I was just wondering whether we
can move the init of "-device intel-iommu,..." to machine init phase,
no matter whether it's the vIOMMU on the root complex or not.

> 
> >IMHO we can just pick these vIOMMU "devices" out of the device list,
> >and we can avoid doing that again in general device_init_func().
> >
> >>
> >>The device re-ordering is not 2.9 material of course, and we need your patch.
> >>The only thing we can do better is to take out the "vfio-pci" in another header
> >>file and and have it in a array of devices that should be checked
> >>(in order to avoid polluting the IOMMU code with a not related device)
> >>
> >>I can try and send a patch for it if you prefer.
> >
> >IMHO it'll be okay we "pollute" vtd code for a short while. We can
> >revert my patch (or any workarounds, like Jason's just posted one)
> 
> Can you please send me a link to Jason's patch?

Sorry for the unclearness! This one:

  https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg07844.html

I just posted v3 for this patch to co-op with Jason's patch.

Thanks,

-- peterx
