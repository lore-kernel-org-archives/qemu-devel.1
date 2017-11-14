Received: from eggs.gnu.org ([2001:4830:134:3::10]:49779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eEck0-0007EN-NU
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:03:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eEcjv-0002G3-O7
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:03:08 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171110203111.7666-5-mreitz@redhat.com>
References: <20171110203111.7666-1-mreitz@redhat.com>
	<20171110203111.7666-5-mreitz@redhat.com>
Date: Tue, 14 Nov 2017 16:02:49 +0100
Message-ID: <w511sl0299i.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.11 4/5] qcow2: Add bounds check to
 get_refblock_offset()
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

On Fri 10 Nov 2017 09:31:10 PM CET, Max Reitz wrote:
> +static int64_t get_refblock_offset(BlockDriverState *bs, uint64_t offset)
> +{
> +    BDRVQcow2State *s = bs->opaque;
> +    uint32_t index = offset_to_reftable_index(s, offset);
> +    int64_t covering_refblock_offset = 0;
> +
> +    if (index < s->refcount_table_size) {
> +        covering_refblock_offset = s->refcount_table[index] & REFT_OFFSET_MASK;
> +    }
> +    if (!covering_refblock_offset) {
> +        qcow2_signal_corruption(bs, true, -1, -1, "Refblock at %#" PRIx64 " is "
> +                                "not covered by the refcount structures",
> +                                offset);
> +        return -EIO;
> +    }
> +
> +    return covering_refblock_offset;
> +}

Isn't it simpler to do something like this instead?

   if (index >= s->refcount_table_size) {
       qcow2_signal_corruption(...);
       return -EIO;
   }
   return s->refcount_table[index] & REFT_OFFSET_MASK;

Berto
