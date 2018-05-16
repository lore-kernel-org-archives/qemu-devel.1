Received: from eggs.gnu.org ([2001:4830:134:3::10]:34945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fIwwE-0006WN-4d
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fIww9-0005jM-9M
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:57:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51150 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fIww9-0005j2-48
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:57:49 -0400
References: <20180504030811.28111-1-peterx@redhat.com>
	<20180516063009.GG9089@xz-mi>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ab9ca375-76e3-baa8-9e60-40a73e9a354a@redhat.com>
Date: Wed, 16 May 2018 21:57:40 +0800
MIME-Version: 1.0
In-Reply-To: <20180516063009.GG9089@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/10] intel-iommu: nested vIOMMU,
 cleanups, bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Tian Kevin <kevin.tian@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>



On 2018=E5=B9=B405=E6=9C=8816=E6=97=A5 14:30, Peter Xu wrote:
> On Fri, May 04, 2018 at 11:08:01AM +0800, Peter Xu wrote:
>> v2:
>> - fix patchew code style warnings
>> - interval tree: postpone malloc when inserting; simplify node remove
>>    a bit where proper [Jason]
>> - fix up comment and commit message for iommu lock patch [Kevin]
>> - protect context cache too using the iommu lock [Kevin, Jason]
>> - add vast comment in patch 8 to explain the modify-PTE problem
>>    [Jason, Kevin]
> We can hold a bit on reviewing this series.  Jintack reported a scp
> DMAR issue that might happen even with L1 guest with this series, and
> the scp can stall after copied tens or hundreds of MBs randomly.  I'm
> still investigating the problem.  This problem should be related to
> deferred flushing of VT-d kernel driver, since the problem will go
> away if we use "intel_iommu=3Don,strict".  However I'm still trying to
> figure out what's the thing behind the scene even with that deferred
> flushing feature.

I vaguely remember recent upstream vfio support delayed flush, maybe=20
it's related.

>
> Meanwhile, during the investigation I found another "possibly valid"
> use case about the modify-PTE problem that Jason has mentioned when
> with deferred flushing:
>
>           vcpu1                        vcpu2
>        map page A
>    explicitly send PSI for A
>     queue unmap page A [1]
>                                   map the same page A [2]
>                                  explcitly send PSI for A [3]
>     flush unmap page A [4]
>
> Due to deferred flushing, the UNMAP PSI might be postponed (or it can
> be finally a DSI) from step [1] to step [4].  If we allocate the same
> page somewhere else, we might trigger this modify-PTE at [2] since we
> haven't yet received the deferred PSI to unmap A from vcpu1.
>
> Note that this will not happen with latest upstream Linux, since the
> IOVA allocation algorithm in current Linux kernel made sure that the
> IOVA range won't be freed until [4], so we can't really allocate the
> same page address at [2].

Yes, so the vfio + vIOMMU work will probably uncover more bugs in the=20
IOMMU driver (especially CM mode). I suspect CM mode does not have=20
sufficient test (since it probably wasn't used in any production=20
environment before the vfio + vIOMMU work).

>    However this let me tend to agree with
> Jason and Kevin's worry on future potential issues if that can be
> triggered easily by common guest kernel bugs.  So now I'm considering
> to drop my mergable interval tree but just use a simpler tree to cache
> everything including translated addresses.  The metadata will possibly
> take 2% of managed memory if with that.
>

Good to know this, we can start from the way we know correct for sure=20
then optimizations on top.

Thanks
