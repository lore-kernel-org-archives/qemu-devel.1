Received: from eggs.gnu.org ([2001:4830:134:3::10]:49831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cyw0x-0007nn-WA
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 03:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cyw0t-0006qZ-3u
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 03:51:32 -0400
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<b55603db-5215-ac30-29e4-f4764f17c14e@openvz.org>
	<d77e0178-8898-3583-ca2c-adf43bf9e0f4@redhat.com>
	<e00ab029-cf9f-5aca-9786-581915dd5189@openvz.org>
	<20170413094454.GB5095@noname.redhat.com>
	<1cc754f6-6718-edbc-96ef-ab0e0e10fd56@openvz.org>
	<d34a20e9-8cb7-3b83-e96f-4631f91045cd@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <6727667f-5422-13d7-be70-b8515f3ff589@openvz.org>
Date: Fri, 14 Apr 2017 07:17:52 +0300
MIME-Version: 1.0
In-Reply-To: <d34a20e9-8cb7-3b83-e96f-4631f91045cd@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [RFC] Proposed qcow2 extension:
 subcluster allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

[skipped...]

> Hi Denis,
>
> I've read this entire thread now and I really like Berto's summary whic=
h
> I think is one of the best recaps of existing qcow2 problems and this
> discussion so far.
>
> I understand your opinion that we should focus on compatible changes
> before incompatible ones, and I also understand that you are very
> concerned about physical fragmentation for reducing long-term IO.
>
> What I don't understand is why you think that subclusters will increase=

> fragmentation. If we admit that fragmentation is a problem now, surely
> increasing cluster sizes to 1 or 2 MB will only help to *reduce*
> physical fragmentation, right?
>
> Subclusters as far as I am understanding them will not actually allow
> subclusters to be located at virtually disparate locations, we will
> continue to allocate clusters as normal -- we'll just keep track of
> which portions of the cluster we've written to to help us optimize COW*=
=2E
>
> So if we have a 1MB cluster with 64k subclusters as a hypothetical, if
> we write just the first subcluster, we'll have a map like:
>
> X---------------
>
> Whatever actually happens to exist in this space, whether it be a hole
> we punched via fallocate or literal zeroes, this space is known to the
> filesystem to be contiguous.
>
> If we write to the last subcluster, we'll get:
>
> X--------------X
>
> And again, maybe the dashes are a fallocate hole, maybe they're zeroes.=

> but the last subcluster is located virtually exactly 15 subclusters
> behind the first, they're not physically contiguous. We've saved the
> space between them. Future out-of-order writes won't contribute to any
> fragmentation, at least at this level.
>
> You might be able to reduce COW from 5 IOPs to 3 IOPs, but if we tune
> the subclusters right, we'll have *zero*, won't we?
>
> As far as I can tell, this lets us do a lot of good things all at once:=

>
> (1) We get some COW optimizations (for reasons Berto and Kevin have
> detailed)
Yes. We are fine with COW. Let us assume that we will have issued read
entire cluster command after the COW, in the situation

X--------------X

with a backing store. This is possible even with 1-2 Mb cluster size.
I have seen 4-5 Mb requests from the guest in the real life. In this
case we will have 3 IOP:
    read left X area, read backing, read right X.
This is the real drawback of the approach, if sub-cluster size is really
small enough, which should be the case for optimal COW. Thus we
will have random IO in the host instead of sequential one in guest.
Thus we have optimized COW at the cost of long term reads. This
is what I am worrying about as we can have a lot of such reads before
any further data change.

With real holes the situation is even worse. If we have real hole
(obtained with truncate), we are in the case mentioned by Roman.
Virtually the space is continuous, but we have host fragmentation,
equal to sub-cluster size.

We are in the tough position even with COW. If sub-cluster is
not equals to the size of the guest filesystem block, we still need
to do COW. The only win is the amount of data copied, but the loss
in the amount of IOPSes is the same. On the other hand, to get
real win, we should have properly aligned guest partitions, know
exactly guest filesystem block size etc etc etc. This is not that
easy as can seen.

> (2) We can increase our cluster size
> (3) L2 cache can cover bigger files with less memory
> (4) Fragmentation decreases.
yes. I like (2)-(4) a lot. But at my opinion we could stick to 1 Mb
without sub-clusters and still get (2)-(4).

>
> Is this not a win all around? We can improve throughput for a lot of
> different reasons all at once, here. Have I misunderstood the discussio=
n
> so far, anyone?
>
> Please correct me where I am wrong and _ELI5_.
Have tried that, sorry for my illiteracy ;)

Den
