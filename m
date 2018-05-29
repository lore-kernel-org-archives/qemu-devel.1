Received: from eggs.gnu.org ([2001:4830:134:3::10]:59053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fNgfX-0001ac-9A
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fNgfW-0008W8-BT
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:36:15 -0400
References: <20180528150128.31500-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a4527393-c6b8-3c09-f562-2f30569b3f21@redhat.com>
Date: Tue, 29 May 2018 10:36:07 -0500
MIME-Version: 1.0
In-Reply-To: <20180528150128.31500-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qcow2: Fix Coverity warning when
 calculating the refcount cache size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org

On 05/28/2018 10:01 AM, Alberto Garcia wrote:
> MIN_REFCOUNT_CACHE_SIZE is 4 and the cluster size is guaranteed to be
> at most 2MB, so the minimum refcount cache size (in bytes) is always
> going to fit in a 32-bit integer.
> 
> Coverity doesn't know that, and since we're storing the result in a
> uint64_t (*refcount_cache_size) it thinks that we need the 64 bits and
> that we probably want to do a 64-bit multiplication to prevent the
> result from being truncated.
> 
> This is a false positive in this case, but it's a fair warning.
> We could do a 64-bit multiplication to get rid of it, but since we
> know that a 32-bit variable is enough to store this value let's simply
> reuse min_refcount_cache, make it a normal int and stop doing casts.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   block/qcow2.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
