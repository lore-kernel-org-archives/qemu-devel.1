Received: from eggs.gnu.org ([2001:4830:134:3::10]:41759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQFEx-0006lF-JS
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQFEw-0007YU-N5
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:50:51 -0400
Date: Wed, 28 Jun 2017 17:50:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170628155042.GJ5378@noname.redhat.com>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-6-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170623124700.1389-6-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH RFC v3 5/8] block: add
 BlockDevOptionsThrottle to QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>

Am 23.06.2017 um 14:46 hat Manos Pitsidianakis geschrieben:
> This is needed to configure throttle filter driver nodes with QAPI.
> 
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  qapi/block-core.json | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index f85c2235c7..1d4afafe8c 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2119,7 +2119,7 @@
>              'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'nfs',
>              'null-aio', 'null-co', 'parallels', 'qcow', 'qcow2', 'qed',
>              'quorum', 'raw', 'rbd', 'replication', 'sheepdog', 'ssh',
> -            'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
> +            'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
>  
>  ##
>  # @BlockdevOptionsFile:
> @@ -2984,6 +2984,7 @@
>        'replication':'BlockdevOptionsReplication',
>        'sheepdog':   'BlockdevOptionsSheepdog',
>        'ssh':        'BlockdevOptionsSsh',
> +      'throttle':   'BlockdevOptionsThrottle',
>        'vdi':        'BlockdevOptionsGenericFormat',
>        'vhdx':       'BlockdevOptionsGenericFormat',
>        'vmdk':       'BlockdevOptionsGenericCOWFormat',
> @@ -3723,3 +3724,19 @@
>    'data' : { 'parent': 'str',
>               '*child': 'str',
>               '*node': 'str' } }
> +
> +##
> +# @BlockdevOptionsThrottle:
> +#
> +# Driver specific block device options for Throttle
> +#
> +# @throttling-group: the name of the throttling group to use
> +#
> +# @options:        BlockIOThrottle options

Missing #optional marker.

> +# Since: 2.9
> +##
> +{ 'struct': 'BlockdevOptionsThrottle',
> +  'data': { 'throttling-group': 'str',
> +            'file' : 'BlockdevRef',
> +            '*options' : 'BlockIOThrottle'
> +             } }

Didn't we intend to make 'throttling-group' optional, too?

If we don't, then the question of anonymous ThrottleGroup objects is
kind of moot (not completely because -drive isn't bound to the schema,
but in that case we should just error out there too if it's missing).

Kevin
