Received: from eggs.gnu.org ([2001:4830:134:3::10]:59294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1foYoM-0007ai-OZ
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 14:40:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1foYoL-00062S-1j
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 14:40:26 -0400
References: <20180810062647.23211-1-lbloch@janustech.com>
	<20180810062647.23211-5-lbloch@janustech.com>
	<w51wosy748v.fsf@maestria.local.igalia.com>
From: Leonid Bloch <lbloch@janustech.com>
Message-ID: <dd8f8de4-4af8-e893-5243-fa3a2e0bc68c@janustech.com>
Date: Sat, 11 Aug 2018 21:40:02 +0300
MIME-Version: 1.0
In-Reply-To: <w51wosy748v.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 4/9] qcow2: Avoid duplication in setting
 the refcount cache size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On 8/10/18 4:14 PM, Alberto Garcia wrote:
> On Fri 10 Aug 2018 08:26:42 AM CEST, Leonid Bloch wrote:
>> The refcount cache size does not need to be set to its minimum value in
>> read_cache_sizes(), as it is set to at least its minimum value in
>> qcow2_update_options_prepare().
>>
>> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
> 
>> -    } else {
>> -        if (!l2_cache_size_set) {
>> -            *l2_cache_size = MAX(DEFAULT_L2_CACHE_SIZE,
>> -                                 (uint64_t)DEFAULT_L2_CACHE_CLUSTERS
>> -                                 * s->cluster_size);
>> -        }
>> -        if (!refcount_cache_size_set) {
>> -            *refcount_cache_size = min_refcount_cache;
>> -        }
> 
> Since you're getting rid of the rest of the code later anyway, I think
> it's cleaner to only remove these last three lines here and leave the
> rest untouched. It makes the patch shorter and easier to read.

But a correct formatting is important, I think. In every patch individually.

> 
>> +    /* If refcount-cache-size is not specified, it will be set to minimum
>> +     * in qcow2_update_options_prepare(). No need to set it here. */
> 
> This is not quite correct, because apart from the "not specified" case,
> refcount_cache_size is also overridden in other circumstances: (a) the
> value is specified but is too low, or (b) the value is set indirectly
> via "cache-size" but the end result is too low[*].

Yes, I'll fix the comment. But I think that it's important that it 
remains, because someone who looks at the code does not necessarily 
looks at the commit message, and it may be puzzling that a minimal size 
is not enforced there.

How about the following:
"l2_cache_size and refcount_cache_size are ensured to have at least 
their minimum values in qcow2_update_options_prepare()"

> 
> Also, the same thing happens to l2-cache-size: if you set it manually
> but it's too low then it will be overridden.
> 
> I'd personally remove the comment altogether, I think the explanation in
> the commit message is enough.
> 
> Berto
> 
> [*] Now that I think of it: if you set e.g. cache-size = 16M and
>      l2-cache-size = 16MB then you'll end up with refcount-cache-size =
>      16M - 16M = 0, which will be overridden and set to the minimum.
> 
>      But then refcount-cache-size + l2-cache-size > cache-size

Yes, I have noticed this behavior, and I think that it is OK: the errors 
should be a response to a wrong input of the user, who does not 
necessarily understands the internals. So if a user inputs l2-cache-size 
which is larger than cache-size, that's obviously a mistake. But if they 
are equal, it's totally OK if QEMU will use some 256 or 128 KB for the 
minimal caches transparently. This is really negligible relatively to 
the total QEMU overhead.

Now the error message is: "l2-cache-size may not exceed cache-size".
Is it reasonable to make it: "l2-cache-size may not exceed the size of 
cache-size minus the minimal refcount cache size" (or similar)? :)

> 
>      So perhaps this should produce an error, and it may make sense to
>      take the opportunity to move all the logic that ensures that
>      MIN_SIZE <= size <= INT_MAX to read_cache_sizes(). But that's a
>      possible task for the future and I wouldn't worry about it in this
>      series.
> 

Yeah, but it would be a good idea to move *all* the size-determining 
logic in one function.

Leonid.
