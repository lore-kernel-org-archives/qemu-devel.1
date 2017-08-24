Received: from eggs.gnu.org ([2001:4830:134:3::10]:42076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dkx2T-00030N-15
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 14:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dkx2P-0006Fm-3K
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 14:39:33 -0400
Date: Thu, 24 Aug 2017 19:39:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170824183925.GC4368@stefanha-x1.localdomain>
References: <20170822101535.4695-1-el13635@mail.ntua.gr>
	<20170822101535.4695-6-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170822101535.4695-6-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v7 5/6] block: add throttle
 block filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>

On Tue, Aug 22, 2017 at 01:15:34PM +0300, Manos Pitsidianakis wrote:
> @@ -3095,6 +3096,20 @@
>              '*tls-creds': 'str' } }
>  
>  ##
> +# @BlockdevOptionsThrottle:
> +#
> +# Driver specific block device options for the throttle driver
> +#
> +# @throttle-group:   the name of the throttle-group object to use. It
> +#                    must already exist.
> +# @file:             reference to or definition of the data source block device
> +# Since: 2.11
> +##
> +{ 'struct': 'BlockdevOptionsThrottle',
> +  'data': { '*throttle-group': 'str',

This field is optional but:

  group_name = qemu_opt_get(opts, QEMU_OPT_THROTTLE_GROUP_NAME);
  if (!group_name) {
      error_setg(errp, "Please specify a throttle group.");
      ret = EINVAL;
      goto fin;

Should it be mandatory?

> +            'file' : 'BlockdevRef'
> +             } }
> +##
>  # @BlockdevOptions:
>  #
>  # Options for creating a block device.  Many options are available for all
> @@ -3155,6 +3170,7 @@
>        'replication':'BlockdevOptionsReplication',
>        'sheepdog':   'BlockdevOptionsSheepdog',
>        'ssh':        'BlockdevOptionsSsh',
> +      'throttle':   'BlockdevOptionsThrottle',
>        'vdi':        'BlockdevOptionsGenericFormat',
>        'vhdx':       'BlockdevOptionsGenericFormat',
>        'vmdk':       'BlockdevOptionsGenericCOWFormat',
> diff --git a/include/block/throttle-groups.h b/include/block/throttle-groups.h
> index 82f030523f..ec969e84fe 100644
> --- a/include/block/throttle-groups.h
> +++ b/include/block/throttle-groups.h
> @@ -76,5 +76,6 @@ void coroutine_fn throttle_group_co_io_limits_intercept(ThrottleGroupMember *tgm
>  void throttle_group_attach_aio_context(ThrottleGroupMember *tgm,
>                                         AioContext *new_context);
>  void throttle_group_detach_aio_context(ThrottleGroupMember *tgm);
> +bool throttle_group_exists(const char *name);
>  
>  #endif
> diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-options.h
> index 182b7896e1..3528a8f4a2 100644
> --- a/include/qemu/throttle-options.h
> +++ b/include/qemu/throttle-options.h
> @@ -29,6 +29,7 @@
>  #define QEMU_OPT_BPS_WRITE_MAX "bps-write-max"
>  #define QEMU_OPT_BPS_WRITE_MAX_LENGTH "bps-write-max-length"
>  #define QEMU_OPT_IOPS_SIZE "iops-size"
> +#define QEMU_OPT_THROTTLE_GROUP_NAME "throttle-group"
>  
>  #define THROTTLE_OPT_PREFIX "throttling."
>  #define THROTTLE_OPTS \
> diff --git a/block/throttle-groups.c b/block/throttle-groups.c
> index a4268a954e..4b483a16d4 100644
> --- a/block/throttle-groups.c
> +++ b/block/throttle-groups.c
> @@ -101,7 +101,7 @@ static ThrottleGroup *throttle_group_by_name(const char *name)
>      return NULL;
>  }
>  

/* Must be called with the global mutex held */
> -static bool throttle_group_exists(const char *name)
> +bool throttle_group_exists(const char *name)
>  {
>      return throttle_group_by_name(name) ? true : false;
>  }
