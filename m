Received: from eggs.gnu.org ([2001:4830:134:3::10]:37684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f84dY-0006Ti-TE
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 09:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f84dV-0000LA-0A
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 09:57:40 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <b9df06c2-0116-8e5c-6725-a59b6d03ed6b@redhat.com>
References: <cover.1521016003.git.berto@igalia.com>
	<14bbd13c5c93211ed4e36188624f429087a6a273.1521016003.git.berto@igalia.com>
	<b9df06c2-0116-8e5c-6725-a59b6d03ed6b@redhat.com>
Date: Mon, 16 Apr 2018 15:56:58 +0200
Message-ID: <w51d0yzgsph.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qcow2: Give the refcount cache the
 minimum possible size by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Fri 13 Apr 2018 05:00:48 PM CEST, Max Reitz wrote:
> On 2018-03-14 09:29, Alberto Garcia wrote:
>> The L2 and refcount caches have default sizes that can be overridden
>> using the l2-cache-size and refcount-cache-size (an additional
>> parameter named cache-size sets the combined size of both caches).
>> 
>> Unless forced by one of the aforementioned parameters, QEMU will set
>> the unspecified sizes so that the L2 cache is 4 times larger than the
>> refcount cache.
>> 
>> This is based on the premise that the refcount metadata needs to be
>> only a fourth of the L2 metadata to cover the same amount of disk
>> space. This is incorrect for two reasons:
>> 
>>  a) The amount of disk covered by an L2 table depends solely on the
>>     cluster size, but in the case of a refcount block it depends on
>>     the cluster size *and* the width of each refcount entry.
>>     The 4/1 ratio is only valid with 16-bit entries (the default).
>> 
>>  b) When we talk about disk space and L2 tables we are talking about
>>     guest space (L2 tables map guest clusters to host clusters),
>>     whereas refcount blocks are used for host clusters (including
>>     L1/L2 tables and the refcount blocks themselves). On a fully
>>     populated (and uncompressed) qcow2 file, image size > virtual size
>>     so there are more refcount entries than L2 entries.
>> 
>> Problem (a) could be fixed by adjusting the algorithm to take into
>> account the refcount entry width. Problem (b) could be fixed by
>> increasing a bit the refcount cache size to account for the clusters
>> used for qcow2 metadata.
>
> Yeah, well, but I wouldn't give too much thought to (b).  In case of
> internal snapshots, you won't write to them, so those clusters don't
> matter.  So, yes, you get a bit of overhead for the metadata, but come
> on, that's not really much.

With that text I just wanted to point out that the calculation mixes
host clusters and guest clusters. I agree that the ratio we're using is
a good approximation (apart from the refcount width issue).

>> However this patch takes a completely different approach and instead
>> of keeping a ratio between both cache sizes it assigns as much as
>> possible to the L2 cache and the remainder to the refcount cache.
>
> Seems reasonable in a sense, but I'm wary still.  I especially don't
> like that it just changes the default when nothing has been specified.
>
> I can see that we want to limit the refcount cache size, so if you
> want to give really much RAM to the L2 tables, then you don't want a
> 25 % overhead for the refcount cache, but do we really need to limit
> it to the minimum size?
>
> OTOH, four clusters doesn't seem extremely limited...  Did you do your
> benchmark on an HDD?

I tried, I see no difference, and I don't see why there would be any.

Refcount entries are used to reference host clusters, and host clusters
are always(*) allocated sequentially, so caching refcount blocks doesn't
do much. You're always loading the same refcount block until it's full,
then you move on to the next one. As I mentioned in a previous e-mail,
having a very large refcount cache would even be detrimental because it
would make cache hits slower (noticeable under tmpfs).

(*) when a cluster gets deallocated (e.g. when the refcount table needs
to grow) then there's a hole in the file and QEMU starts looking for
free clusters again from the beginning of the file. In that case old
refcount blocks are loaded again, but the cache wouldn't help here
either (unless we would have all refcount blocks cached).

Berto
