Received: from eggs.gnu.org ([2001:4830:134:3::10]:49563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fD9nH-000303-76
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:28:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fD9nC-0002Uh-Vm
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:28:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fD9nC-0002UP-Mi
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:28:38 -0400
Date: Mon, 30 Apr 2018 08:28:35 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180430082835.32835889@w520.home>
In-Reply-To: <CAFEAcA9R5Ycq0aT3pCe1mdrmqAM2dVUjJ=MSJuN5+a+crvxzMw@mail.gmail.com>
References: <20180430122404.10741-1-peter.maydell@linaro.org>
	<c1c3c88f-75c6-44f2-684c-d9d179bb128c@redhat.com>
	<CAFEAcA-frhSPZePsQJy8DJTpFX0iFw52ND_VK8Z=hGz-v1A_jA@mail.gmail.com>
	<6c90618c-ec1b-7a73-5a76-b98fe5df589a@redhat.com>
	<CAFEAcA9R5Ycq0aT3pCe1mdrmqAM2dVUjJ=MSJuN5+a+crvxzMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory.h: Improve IOMMU related
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On Mon, 30 Apr 2018 14:35:20 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 30 April 2018 at 14:08, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > On 30/04/2018 14:57, Peter Maydell wrote:  
> >> On 30 April 2018 at 13:54, Paolo Bonzini <pbonzini@redhat.com> wrote:  
> >>> On 30/04/2018 14:24, Peter Maydell wrote:  
> >>>> -    /* Set this up to provide customized IOMMU replay function */
> >>>> +    /* Set this up to provide customized IOMMU replay function.
> >>>> +     * Optional method.
> >>>> +     */
> >>>>      void (*replay)(IOMMUMemoryRegion *iommu, IOMMUNotifier *notifier);  
> >>>
> >>> replay is needed if you want to support IOMMU notifiers.  After
> >>> memory_region_register_iommu_notifier you're only notified about future
> >>> changes to the mappings; memory_region_iommu_replay calls the replay
> >>> method so that the IOMMUNotifier is called for each existing mapping.  
> >>
> >> Is it then unrelated to record-and-replay ? That's what I guessed
> >> it was for... Also, some IOMMUs (eg spapr_iommu.c) seem to support
> >> notifiers but don't implement it.  
> >
> > Yes, it's completely unrelated.  I have no idea why spapr_iommu.c
> > doesn't need it, so I am CCing the sPAPR and VFIO experts...  
> 
> There does seem to be a default implementation in
> memory_region_iommu_replay(), maybe that is sufficient for spapr?

AIUI, the default implementation is used by spapr, it was added here:

commit a788f227ef7bd2912fcaacdfe13d13ece2998149
Author: David Gibson <david@gibson.dropbear.id.au>
Date:   Wed Sep 30 12:13:55 2015 +1000

    memory: Allow replay of IOMMU mapping notifications
    
    When we have guest visible IOMMUs, we allow notifiers to be registered
    which will be informed of all changes to IOMMU mappings.  This is used by
    vfio to keep the host IOMMU mappings in sync with guest IOMMU mappings.
    
    However, unlike with a memory region listener, an iommu notifier won't be
    told about any mappings which already exist in the (guest) IOMMU at the
    time it is registered.  This can cause problems if hotplugging a VFIO
    device onto a guest bus which had existing guest IOMMU mappings, but didn't
    previously have an VFIO devices (and hence no host IOMMU mappings).
    
    This adds a memory_region_iommu_replay() function to handle this case.  It
    replays any existing mappings in an IOMMU memory region to a specified
    notifier.  Because the IOMMU memory region doesn't internally remember the
    granularity of the guest IOMMU it has a small hack where the caller must
    specify a granularity at which to replay mappings.
    
    If there are finer mappings in the guest IOMMU these will be reported in
    the iotlb structures passed to the notifier which it must handle (probably
    causing it to flag an error).  This isn't new - the VFIO iommu notifier
    must already handle notifications about guest IOMMU mappings too short
    for it to represent in the host IOMMU.
    
    Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
    Reviewed-by: Laurent Vivier <lvivier@redhat.com>
    Acked-by: Paolo Bonzini <pbonzini@redhat.com>
    Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

VT-d emulation then needed its own replay and that hook was later added
here:

commit faa362e3cc94bf739a89b457693e3fbd7a4b95c4
Author: Peter Xu <peterx@redhat.com>
Date:   Fri Apr 7 18:59:11 2017 +0800

    memory: add MemoryRegionIOMMUOps.replay() callback
    
    Originally we have one memory_region_iommu_replay() function, which is
    the default behavior to replay the translations of the whole IOMMU
    region. However, on some platform like x86, we may want our own replay
    logic for IOMMU regions. This patch adds one more hook for IOMMUOps for
    the callback, and it'll override the default if set.
    
    Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
    Reviewed-by: Eric Auger <eric.auger@redhat.com>
    Reviewed-by: \"Michael S. Tsirkin\" <mst@redhat.com>
    Signed-off-by: Peter Xu <peterx@redhat.com>
    Message-Id: <1491562755-23867-6-git-send-email-peterx@redhat.com>
    Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Thanks,
Alex
