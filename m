Received: from eggs.gnu.org ([2001:4830:134:3::10]:39158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dk9yt-0002Tj-N6
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:16:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dk9yn-0000gt-TB
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:16:35 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170822101535.4695-6-el13635@mail.ntua.gr>
References: <20170822101535.4695-1-el13635@mail.ntua.gr>
	<20170822101535.4695-6-el13635@mail.ntua.gr>
Date: Tue, 22 Aug 2017 16:16:26 +0200
Message-ID: <w51tw0zg01x.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 5/6] block: add throttle block filter
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Tue 22 Aug 2017 12:15:34 PM CEST, Manos Pitsidianakis wrote:
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
> +            'file' : 'BlockdevRef'
> +             } }
> +##

I guess throttle-group is not optional here anymore ?

> @@ -548,6 +548,11 @@ void throttle_group_unregister_tgm(ThrottleGroupMember *tgm)
>      ThrottleGroupMember *token;
>      int i;
>  
> +    if (!ts) {
> +        /* Discard uninitialized tgm */
> +        return;
> +    }
> +

Is this change needed in case throttle_configure_tgm() fails?

> +static int throttle_configure_tgm(BlockDriverState *bs,
> +                                  ThrottleGroupMember *tgm,
> +                                  QDict *options, Error **errp)
> +{
> +    int ret;
> +    const char *group_name;
> +    Error *local_err = NULL;
> +    QemuOpts *opts = qemu_opts_create(&throttle_opts, NULL, 0, &error_abort);
> +
> +    qemu_opts_absorb_qdict(opts, options, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        ret = -EINVAL;
> +        goto fin;
> +    }
> +
> +    group_name = qemu_opt_get(opts, QEMU_OPT_THROTTLE_GROUP_NAME);
> +    if (!group_name) {
> +        error_setg(errp, "Please specify a throttle group.");
> +        ret = EINVAL;
> +        goto fin;
> +    } else if (!throttle_group_exists(group_name)) {
> +        error_setg(errp, "Throttle group '%s' does not exist.", group_name);
> +        ret = EINVAL;
> +        goto fin;
> +    }

It should be -EINVAL (negative value) in both cases.

Berto
