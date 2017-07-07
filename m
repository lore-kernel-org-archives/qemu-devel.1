Received: from eggs.gnu.org ([2001:4830:134:3::10]:37061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dTOGg-0007iP-Hq
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 04:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dTOGf-0001Dx-8U
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 04:05:38 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
	<20170628120530.31251-26-vsementsov@virtuozzo.com>
Date: Fri, 07 Jul 2017 10:05:22 +0200
In-Reply-To: <20170628120530.31251-26-vsementsov@virtuozzo.com> (Vladimir
	Sementsov-Ogievskiy's message of "Wed, 28 Jun 2017 15:05:25 +0300")
Message-ID: <87r2xs65a5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v22 25/30] qmp: add
 x-debug-block-dirty-bitmap-sha256
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org, jsnow@redhat.com

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/dirty-bitmap.c         |  5 +++++
>  blockdev.c                   | 25 +++++++++++++++++++++++++
>  include/block/dirty-bitmap.h |  1 +
>  include/qemu/hbitmap.h       |  8 ++++++++
>  qapi/block-core.json         | 27 +++++++++++++++++++++++++++
>  tests/Makefile.include       |  2 +-
>  util/hbitmap.c               | 11 +++++++++++
>  7 files changed, 78 insertions(+), 1 deletion(-)
[...]
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 5c42cc7790..6ad8585400 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1644,6 +1644,33 @@
>    'data': 'BlockDirtyBitmap' }
>  
>  ##
> +# @BlockDirtyBitmapSha256:
> +#
> +# SHA256 hash of dirty bitmap data
> +#
> +# @sha256: ASCII representation of SHA256 bitmap hash

Spell it SHA-256, please.  The member name @sha256 can stay.

SHA-256 is 256 binary bits.  Please specify how they are represented in
ASCII.  It better be base64 (RFC 4648), because we use that elsewhere.

> +#
> +# Since: 2.10
> +##
> +  { 'struct': 'BlockDirtyBitmapSha256',
> +    'data': {'sha256': 'str'} }
> +
> +##
> +# @x-debug-block-dirty-bitmap-sha256:
> +#
> +# Get bitmap SHA256
> +#
> +# Returns: BlockDirtyBitmapSha256 on success
> +#          If @node is not a valid block device, DeviceNotFound
> +#          If @name is not found or if hashing has failed, GenericError with an
> +#          explanation

Please wrap your comment lines around column 70.

> +#
> +# Since: 2.10
> +##
> +  { 'command': 'x-debug-block-dirty-bitmap-sha256',
> +    'data': 'BlockDirtyBitmap', 'returns': 'BlockDirtyBitmapSha256' }
> +
> +##
>  # @blockdev-mirror:
>  #
>  # Start mirroring a block device's writes to a new destination.
[...]
