Received: from eggs.gnu.org ([2001:4830:134:3::10]:55229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fWNxb-0005K6-Qs
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fWNxa-00051h-UO
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:26:51 -0400
References: <20180622125814.345274-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0d9dc1a1-373b-1e21-1ff5-b24e59e0fbab@redhat.com>
Date: Fri, 22 Jun 2018 10:26:42 -0500
MIME-Version: 1.0
In-Reply-To: <20180622125814.345274-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nbd/server: Silence gcc false positive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "open list:Network Block Dev..." <qemu-block@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, John Snow <jsnow@redhat.com>

On 06/22/2018 07:58 AM, Eric Blake wrote:
> The code has a while() loop that always initialized 'end', and
> the loop always executes at least once (as evidenced by the assert()
> just prior to the loop).  But some versions of gcc still complain
> that 'end' is used uninitialized, so silence them.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> Peter, do you want to apply this directly as a build fix, or shall
> I submit a pull request?
> 

Phooey. I'm obviously under a lot of stress. In my rush to fix the build 
problem, I introduced a logic error that breaks NBD dirty bitmaps. :(

>   nbd/server.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index 274604609f4..50ac8bfafc6 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1937,7 +1937,7 @@ static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
>                                         unsigned int nb_extents,
>                                         bool dont_fragment)
>   {
> -    uint64_t begin = offset, end;
> +    uint64_t begin = offset, end = offset;
>       uint64_t overall_end = offset + *length;
>       unsigned int i = 0;
>       BdrvDirtyBitmapIter *it;
> @@ -1977,6 +1977,7 @@ static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
> 
>       bdrv_dirty_bitmap_unlock(bitmap);
> 
> +    assert(offset > end);
>       *length = end - offset;

The assertion is backwards; that should be 'offset < end'. :(

Sending another fix. And putting on the brown paper bag of shame.

And bummer that neither 'make check' nor iotests exposes the breakage. 
My RFC hack for adding x-block-status to the client would be useful for 
that purpose.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
