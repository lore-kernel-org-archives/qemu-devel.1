Received: from eggs.gnu.org ([2001:4830:134:3::10]:47311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eydot-0000Xc-7G
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:30:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eydos-0001Ad-CR
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:30:23 -0400
References: <20180320135515.16823-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <78205471-01fc-9d60-590e-feab0df79439@redhat.com>
Date: Wed, 21 Mar 2018 08:30:11 -0500
MIME-Version: 1.0
In-Reply-To: <20180320135515.16823-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qcow2: Reset free_cluster_index when
 allocating a new refcount block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 03/20/2018 08:55 AM, Alberto Garcia wrote:
> When we try to allocate new clusters we first look for available ones
> starting from s->free_cluster_index and once we find them we increase
> their reference counts. Before we get to call update_refcount() to do
> this last step s->free_cluster_index is already pointing to the next
> cluster after the ones we are trying to allocate.
> 

> This can be reproduced easily:
> 
>       qemu-img create -f qcow2 -o cluster_size=512 hd.qcow2 1M
>       qemu-io -c 'write 0 124k' hd.qcow2

This reproduction fails if you use non-default refcount_order...

> +++ b/tests/qemu-iotests/121
> @@ -93,6 +93,26 @@ $QEMU_IO -c 'write 63M 130K' "$TEST_IMG" | _filter_qemu_io
>   
>   _check_test_img
>   
> +echo
> +echo '=== Allocating a new refcount block must not leave holes in the image ==='
> +echo
> +
> +IMGOPTS='cluster_size=512' _make_test_img 1M

...so here, I think IMGOPTS also has to include refcount_bits=4, so that 
calling iotests './check -o refcount_bits=3' or similar doesn't fail the 
test.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
