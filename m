Received: from eggs.gnu.org ([209.51.188.92]:59413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1h3M1Q-000438-3I
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:35:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1h3M1M-0006Er-Ds
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:35:20 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:54754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1h3M1L-0006DG-0f
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:35:16 -0400
Received: by mail-wm1-f44.google.com with SMTP id f3so4799889wmj.4
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 07:35:14 -0700 (PDT)
References: <871s3dg3si.fsf@redhat.com>
	<3fd4f68a-9ce4-7e54-a763-ccdcf844890e@redhat.com>
	<87zhq1ed33.fsf@redhat.com>
	<21d96d05-b600-b115-3649-8d488aeec82b@redhat.com>
From: Sergio Lopez <slp@redhat.com>
In-reply-to: <21d96d05-b600-b115-3649-8d488aeec82b@redhat.com>
Date: Mon, 11 Mar 2019 15:35:11 +0100
Message-ID: <87y35leaxs.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Flatview rendering scalability issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>


Paolo Bonzini writes:

> On 11/03/19 14:48, Sergio Lopez wrote:
>>> The initialization is O(n^2) because the guest initializes one device at
>>> a time, so you rebuild the FlatView first with 0 devices, then 1, then
>>> 2, etc.  This is very hard to fix, if at all possible.
>>>
>>> However, each FlatView creation should be O(n) where n is the number of
>>> devices currently configured.  Please check with "info mtree -f" that
>>> you only have a fixed number of FlatViews.  Old versions had one per device.
>> I'm seeing 9 FVs with 1 PCI, and 119 with 100 PCIs.
>
> With
>
> $ eval qemu-system-x86_64 -M q35 \
>     -device\ e1000,id=n{1,2,3,4,5,6,7,8}{1,2,3}
>
> I only see 4 flat views ("system", "io", "memory", "(none)").
>
> Probably you are using intel-iommu?  Peter, it should be possible to
> reorganize the VT-d memory regions like this:

You're right, the number of FVs goes down drastically after removing
intel-iommu, and the slowness during Guest PCI initialization disappears
with it.

Thanks,
Sergio.
