Received: from eggs.gnu.org ([2001:4830:134:3::10]:41425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ddZNe-00065j-7u
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ddZNd-00013H-Cj
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:58:54 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ddZNd-000132-72
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:58:53 -0400
Received: by mail-wm0-x244.google.com with SMTP id d40so5097497wma.3
	for <qemu-devel@nongnu.org>; Fri, 04 Aug 2017 02:58:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c6161e7a-9b03-16bf-fb20-86df6f3fd9bc@redhat.com>
References: <20170713190116.21608-1-dgilbert@redhat.com>
	<20170717101703.GH7163@stefanha-x1.localdomain>
	<20170717102642.GG2106@work-vm>
	<c6161e7a-9b03-16bf-fb20-86df6f3fd9bc@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 4 Aug 2017 10:58:51 +0100
Message-ID: <CAJSP0QWd7gtV21Hpr3noA0odAMhdriNkaqJtLJvbSNzoErvFdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] vl.c/exit: pause cpus before closing block
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Prasad Pandit <ppandit@redhat.com>

On Mon, Jul 17, 2017 at 5:43 PM, John Snow <jsnow@redhat.com> wrote:
> On 07/17/2017 06:26 AM, Dr. David Alan Gilbert wrote:
>> * Stefan Hajnoczi (stefanha@gmail.com) wrote:
>>> On Thu, Jul 13, 2017 at 08:01:16PM +0100, Dr. David Alan Gilbert (git) wrote:
>>>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>>>
>>>> There's a rare exit seg if the guest is accessing
>>>> IO during exit.
>>>> It's always hitting the atomic_inc(&bs->in_flight) with a NULL
>>>> bs. This was added recently in 99723548  but I don't see it
>>>> as the cause.
>>>>
>>>> Flip vl.c around so we pause the cpus before closing the block devices,
>>>> that way we shouldn't have anything trying to access them when
>>>> they're gone.
>>>>
>>>> This was originally Red Hat bz https://bugzilla.redhat.com/show_bug.cgi?id=1451015
>>>>
>>>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>>> Reported-by: Cong Li <coli@redhat.com>
>>>>
>>>> --
>>>> This is a very rare race, I'll leave it running in a loop to see if
>>>> we hit anything else and to check this really fixes it.
>>>>
>>>> I do worry if there are other cases that can trigger this - e.g.
>>>> hot-unplug or ejecting a CD.
>>>>
>>>> ---
>>>>  vl.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>
>> Thanks;  and the test I left running seems solid - ~12k runs
>> over the weekend with no seg.
>>
>> Dave
>>
>> --
>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>
>
> the root cause of this bug is related to this as well:
> https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg02945.html
>
> From commit 99723548 we started assuming (incorrectly?) that blk_
> functions always WILL have an attached BDS, but this is not always true,
> for instance, flushing the cache from an empty CDROM.
>
> Paolo, can we move the flight counter increment outside of the
> block-backend layer, is that safe?

I think the bdrv_inc_in_flight(blk_bs(blk)) needs to be fixed
regardless of the throttling timer issue discussed below.  BB cannot
assume that the BDS graph is non-empty.

Stefan
