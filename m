Received: from eggs.gnu.org ([2001:4830:134:3::10]:58623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erTlk-0000AX-Hh
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:21:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erTlj-0006S5-Kp
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:21:32 -0500
References: <cover.1519921268.git.berto@igalia.com>
	<a43af2b339e60ad2e97de86c7646d35ff7e7b7e1.1519921268.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6065c0da-41fa-f1a3-e3ba-d0509b275150@redhat.com>
Date: Thu, 1 Mar 2018 13:21:08 -0600
MIME-Version: 1.0
In-Reply-To: <a43af2b339e60ad2e97de86c7646d35ff7e7b7e1.1519921268.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/7] qcow2: Generalize
 validate_table_offset() into qcow2_validate_table()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On 03/01/2018 10:27 AM, Alberto Garcia wrote:
> This function checks that the offset and size of a table are valid.
> 
> While the offset checks are fine, the size check is too generic, since
> it only verifies that the total size in bytes fits in a 64-bit
> integer. In practice all tables used in qcow2 have much smaller size
> limits, so the size needs to be checked again for each table using its
> actual limit.
> 
> This patch generalizes this function by allowing the caller to specify
> the maximum size for that table. In addition to that it allows passing
> an Error variable.
> 
> The function is also renamed and made public since we're going to use
> it in other parts of the code.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---

> +int qcow2_validate_table(BlockDriverState *bs, uint64_t offset,
> +                         uint64_t entries, size_t entry_len,
> +                         int64_t max_size_bytes, const char *table_name,
> +                         Error **errp)
>   {
>       BDRVQcow2State *s = bs->opaque;
> -    uint64_t size;
> +
> +    if (entries > max_size_bytes / entry_len) {
> +        error_setg(errp, "%s too large", table_name);
> +        return -EFBIG;
> +    }

EFBIG "File too large".  Would EOVERFLOW "Value too large for defined 
data type" make any more sense?  But that's bikeshedding; I'm okay with 
your choice.


>   
>       /* read the level 1 table */
> -    if (header.l1_size > QCOW_MAX_L1_SIZE / sizeof(uint64_t)) {
> -        error_setg(errp, "Active L1 table too large");
> -        ret = -EFBIG;
> +    ret = qcow2_validate_table(bs, header.l1_table_offset,
> +                               header.l1_size, sizeof(uint64_t),
> +                               QCOW_MAX_L1_SIZE, "Active L1 table", errp);
> +    if (ret < 0) {

At any rate, it looks like we were already using EFBIG.

I also like that you consolidated more checking into the common function.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
