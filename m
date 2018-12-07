Received: from eggs.gnu.org ([2001:4830:134:3::10]:45619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVIwu-0007HC-5N
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:25:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVIwt-0007zX-4y
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:25:56 -0500
References: <20181206192544.3987-1-jsnow@redhat.com>
	<20181206192544.3987-3-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <59d3744f-8c61-724b-784d-43e5f2b0ae8e@redhat.com>
Date: Fri, 7 Dec 2018 10:25:49 -0600
MIME-Version: 1.0
In-Reply-To: <20181206192544.3987-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] blockdev: n-ary bitmap merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, vsementov@virtuozzo.com, Max Reitz <mreitz@redhat.com>

On 12/6/18 1:25 PM, John Snow wrote:
> Especially outside of transactions, it is helpful to provide
> all-or-nothing semantics for bitmap merges. This facilitates
> the coalescing of multiple bitmaps into a single target for
> the "checkpoint" interpretation when assembling bitmaps that
> represent arbitrary points in time from component bitmaps.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   blockdev.c           | 64 +++++++++++++++++++++++++++++---------------
>   qapi/block-core.json | 22 +++++++--------
>   2 files changed, 53 insertions(+), 33 deletions(-)
> 

> +++ b/qapi/block-core.json
> @@ -1818,14 +1818,14 @@
>   #
>   # @node: name of device/node which the bitmap is tracking
>   #
> -# @dst_name: name of the destination dirty bitmap
> +# @target: name of the destination dirty bitmap
>   #
> -# @src_name: name of the source dirty bitmap
> +# @bitmaps: name(s) of the source dirty bitmap(s)
>   #
>   # Since: 3.0
>   ##
>   { 'struct': 'BlockDirtyBitmapMerge',
> -  'data': { 'node': 'str', 'dst_name': 'str', 'src_name': 'str' } }
> +  'data': { 'node': 'str', 'target': 'str', 'bitmaps': ['str'] } }

Definitely worthwhile!

I'll update my pending libvirt patches to use this.

>   
>   ##
>   # @block-dirty-bitmap-add:
> @@ -1940,23 +1940,23 @@
>   ##
>   # @x-block-dirty-bitmap-merge:
>   #
> -# FIXME: Rename @src_name and @dst_name to src-name and dst-name.
> -#
> -# Merge @src_name dirty bitmap to @dst_name dirty bitmap. @src_name dirty
> -# bitmap is unchanged. On error, @dst_name is unchanged.
> +# Merge dirty bitmaps listed in @bitmaps to the @target dirty bitmap.
> +# The @bitmaps dirty bitmaps are unchanged.

Well, except in the corner case of when @bitmaps also lists the 
destination (I presume that merging a bitmap into itself silently 
succeeds with no further changes, but therefore the inclusion of the 
destination in the list of sources means that that particular source is 
changing due to merging in the other sources).  Not worth rewording this 
  sentence, but does make you want to consider ensuring that the 
testsuite covers merging a bitmap into itself.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
