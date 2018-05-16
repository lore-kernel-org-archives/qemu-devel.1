Received: from eggs.gnu.org ([2001:4830:134:3::10]:60601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJ47O-0003iJ-Lb
	for qemu-devel@nongnu.org; Wed, 16 May 2018 17:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJ47N-0002WZ-QD
	for qemu-devel@nongnu.org; Wed, 16 May 2018 17:37:54 -0400
References: <20180512012537.22478-1-jsnow@redhat.com>
	<20180512012537.22478-10-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <70d0df96-1d41-4687-4b55-fcfdb42adb0c@redhat.com>
Date: Wed, 16 May 2018 16:37:47 -0500
MIME-Version: 1.0
In-Reply-To: <20180512012537.22478-10-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 09/12] qapi/block-core: add
 BitmapMapping and BitmapEntry structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On 05/11/2018 08:25 PM, John Snow wrote:
> Add two new structures for detailing the marked regions of bitmaps as
> saved in e.g. qcow2 files.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   qapi/block-core.json | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 8f33f41ce7..de8ad73a78 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -298,6 +298,38 @@
>              'zero': 'bool', 'depth': 'int', '*offset': 'int',
>              '*filename': 'str' } }
>   
> +##
> +# @BitmapEntry:
> +#
> +# Dirty Bitmap region information for a virtual block range
> +#
> +# @offset: the start byte of the dirty virtual range
> +#
> +# @length: the number of bytes of the dirty virtual range
> +#
> +# Since: 2.13
> +#
> +##
> +{ 'struct': 'BitmapEntry',
> +  'data': { 'offset': 'int', 'length': 'int' } }
> +
> +##
> +# @BitmapMapping:
> +#
> +# List of described regions correlated to a named bitmap.
> +#
> +# @name: The name of the bitmap whose range is described here
> +#
> +# @entries: A list of zero or more @BitmapEntry elements representing
> +#           the range(s) described by the bitmap.

Is it also worth documenting that the list will be in ascending order, 
with no overlaps (no two entries covering the same offset); and in fact 
with a gap between all entries (as otherwise those two consecutive 
entries could have been consolidated to one)?

> +#
> +# Since: 2.13
> +#
> +##
> +{ 'struct': 'BitmapMapping',
> +  'data': { 'name': 'str',
> +            'entries': [ 'BitmapEntry' ] } }
> +
>   ##
>   # @BlockdevCacheInfo:
>   #
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
