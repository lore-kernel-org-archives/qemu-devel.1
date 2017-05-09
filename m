Received: from eggs.gnu.org ([2001:4830:134:3::10]:43004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d828c-0008DL-Eq
	for qemu-devel@nongnu.org; Tue, 09 May 2017 06:13:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d828b-0004kv-7Z
	for qemu-devel@nongnu.org; Tue, 09 May 2017 06:13:02 -0400
Date: Tue, 9 May 2017 12:12:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170509101249.GC5243@noname.str.redhat.com>
References: <20170506124314.23354-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170506124314.23354-1-aurelien@aurel32.net>
Subject: Re: [Qemu-devel] [PATCH 1/3] hw/block: Introduce rotational qdev
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 06.05.2017 um 14:43 hat Aurelien Jarno geschrieben:
> The Linux kernel uses different I/O scheduler depending if the block
> device is a rotational device or not. Also it uses rotational devices
> to add entropy to the random pool.
> 
> This patch add a rotational qdev property so that the block device can
> be configured as a rotational device or a non-rotational device. Default
> to true to not change the default behavior.
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  blockdev.c               | 4 ++++
>  include/hw/block/block.h | 4 +++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/blockdev.c b/blockdev.c
> index 4d8cdedd54..c914420641 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -4037,6 +4037,10 @@ QemuOptsList qemu_common_drive_opts = {
>              .name = BDRV_OPT_READ_ONLY,
>              .type = QEMU_OPT_BOOL,
>              .help = "open drive file as read-only",
> +        },{
> +            .name = "rotational",
> +            .type = QEMU_OPT_BOOL,
> +            .help = "rotational drive (off, on)",
>          },
>  

This hunk is wrong (and unnecessary). It makes the -drive parser parse
rotational=... options without doing anything with them, so instead of
correctly producing an error that this isn't a block driver option, it
would be silently ignored.

-drive has a few legacy options that affect qdev devices, but we don't
want to add anything new there; people can just use -device. So the fix
for your patch is simply dropping this hunk.

> diff --git a/include/hw/block/block.h b/include/hw/block/block.h
> index f3f6e8ef02..304a579eca 100644
> --- a/include/hw/block/block.h
> +++ b/include/hw/block/block.h
> @@ -27,6 +27,7 @@ typedef struct BlockConf {
>      uint32_t cyls, heads, secs;
>      OnOffAuto wce;
>      bool share_rw;
> +    bool rotational;
>      BlockdevOnError rerror;
>      BlockdevOnError werror;
>  } BlockConf;
> @@ -56,7 +57,8 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
>                         _conf.discard_granularity, -1), \
>      DEFINE_PROP_ON_OFF_AUTO("write-cache", _state, _conf.wce, \
>                              ON_OFF_AUTO_AUTO), \
> -    DEFINE_PROP_BOOL("share-rw", _state, _conf.share_rw, false)
> +    DEFINE_PROP_BOOL("share-rw", _state, _conf.share_rw, false), \
> +    DEFINE_PROP_BOOL("rotational", _state, _conf.rotational, true)
>  
>  #define DEFINE_BLOCK_CHS_PROPERTIES(_state, _conf)      \
>      DEFINE_PROP_UINT32("cyls", _state, _conf.cyls, 0),  \

Also not sure about this one. It adds the property to all block devices,
but only IDE and SCSI will actually look at it. Maybe it would be better
to add this property only to the individual devices that actually
support it.

Kevin
