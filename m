Received: from eggs.gnu.org ([2001:4830:134:3::10]:37590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eEdBV-00047A-GL
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:31:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eEdBU-0005rb-Nr
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:31:33 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <6b0680e6-e934-ac2c-659f-8e22ac2c3480@redhat.com>
References: <20171110203111.7666-1-mreitz@redhat.com>
	<20171110203111.7666-6-mreitz@redhat.com>
	<w51y3n8zypa.fsf@maestria.local.igalia.com>
	<6b0680e6-e934-ac2c-659f-8e22ac2c3480@redhat.com>
Date: Tue, 14 Nov 2017 16:31:23 +0100
Message-ID: <w51shdgzxkk.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.11 5/5] qcow2: Refuse to get
 unaligned offsets from cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

On Tue 14 Nov 2017 04:09:16 PM CET, Max Reitz wrote:
>>> +static inline const char *qcow2_cache_get_name(BDRVQcow2State *s, Qcow2Cache *c)
>>> +{
>>> +    if (c == s->refcount_block_cache) {
>>> +        return "refcount block";
>>> +    } else if (c == s->l2_table_cache) {
>>> +        return "L2 table";
>>> +    } else {
>>> +        /* Do not abort, because this is not critical */
>>> +        return "unknown";
>>> +    }
>>> +}
>> 
>> Why is an unknown cache not critical?
>
> Because this is debugging information.

Ah, right, this is only used for qcow2_signal_corruption().

> I know others disagree with my opinion that I'd rather not abort qemu
> just because someone forgot to add a 'return "foo";' here when adding
> a new cache, but that's my opinion so I wanted to at least be told by
> someone that we should abort here before doing it.

I just checked the code and at least qcow2_cache_entry_flush() assumes
that there can be other caches, so this problem is not new.

Perhaps we should rethink this in the future and add a stronger
assertion somewhere else instead of having dead code, but for now this
is OK I guess.

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
