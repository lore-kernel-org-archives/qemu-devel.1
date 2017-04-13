Received: from eggs.gnu.org ([2001:4830:134:3::10]:53850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cygjC-0004qk-QS
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 11:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cygjB-0002Zc-Qh
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 11:32:10 -0400
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<2b915695-29b5-df8d-4d89-080eeaaaff13@openvz.org>
	<w51shlcv7sb.fsf@maestria.local.igalia.com>
	<565c1e1b-b9e1-e9c5-790e-283d04afc747@openvz.org>
	<w51poggv3xh.fsf@maestria.local.igalia.com>
	<ec4f6034-0c94-658c-6b2a-e0aecea173f4@openvz.org>
	<w51h91suz53.fsf@maestria.local.igalia.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <e1ae017b-a832-0e52-02d0-eaeb882a2b4d@openvz.org>
Date: Thu, 13 Apr 2017 18:17:21 +0300
MIME-Version: 1.0
In-Reply-To: <w51h91suz53.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] Proposed qcow2 extension: subcluster
 allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 04/13/2017 06:04 PM, Alberto Garcia wrote:
> On Thu 13 Apr 2017 03:30:43 PM CEST, Denis V. Lunev wrote:
>> Yes, block size should be increased. I perfectly in agreement with
>> your.  But I think that we could do that by plain increase of the
>> cluster size without any further dances. Sub-clusters as sub-clusters
>> will help if we are able to avoid COW. With COW I do not see much
>> difference.
> I'm trying to summarize your position, tell me if I got everything
> correctly:
>
> 1. We should try to reduce data fragmentation on the qcow2 file,
>    because it will have a long term effect on the I/O performance (as
>    opposed to an effect on the initial operations on the empty image).
yes

> 2. The way to do that is to increase the cluster size (to 1MB or
>    more).
yes

> 3. Benefit: increasing the cluster size also decreases the amount of
>    metadata (L2 and refcount).
yes

> 4. Problem: L2 tables become too big and fill up the cache more
>    easily. To solve this the cache code should do partial reads
>    instead of complete L2 clusters.
yes. We can read full cluster as originally if L2 cache is empty.

> 5. Problem: larger cluster sizes also mean more data to copy when
>    there's a COW. To solve this the COW code should be modified so it
>    goes from 5 OPs (read head, write head, read tail, write tail,
>    write data) to 2 OPs (read cluster, write modified cluster).
yes, with small tweak if head and tail are in different clusters. In
this case we
will end up with 3 OPs.

> 6. Having subclusters adds incompatible changes to the file format,
>    and they offer no benefit after allocation.
yes

> 7. Subclusters are only really useful if they match the guest fs block
>    size (because you would avoid doing COW on allocation). Otherwise
>    the only thing that you get is a faster COW (because you move less
>    data), but the improvement is not dramatic and it's better if we do
>    what's proposed in point 5.
yes

> 8. Even if the subcluster size matches the guest block size, you'll
>    get very fast initial allocation but also more chances to end up
>    with a very fragmented qcow2 image, which is worse in the long run.
yes

> 9. Problem: larger clusters make a less efficient use of disk space,
>    but that's a drawback you're fine with considering all of the
>    above.
yes

> Is that a fair summary of what you're trying to say? Anything else
> missing?
yes.

5a. Problem: initial cluster allocation without COW. Could be made
      cluster-size agnostic with the help of fallocate() call. Big
clusters are even
      better as the amount of such allocations is reduced.

Thank you very much for this cool summary! I am too tongue-tied.

Den
