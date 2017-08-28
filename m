Received: from eggs.gnu.org ([2001:4830:134:3::10]:34155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmKSM-0003Ti-JE
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 09:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmKSJ-0005r9-Er
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 09:51:58 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170825132332.6734-6-el13635@mail.ntua.gr>
References: <20170825132332.6734-1-el13635@mail.ntua.gr>
	<20170825132332.6734-6-el13635@mail.ntua.gr>
Date: Mon, 28 Aug 2017 15:51:51 +0200
Message-ID: <w51h8wrvlzc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 5/7] block/throttle-groups.c: remove
 throttle-groups list
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

On Fri 25 Aug 2017 03:23:30 PM CEST, Manos Pitsidianakis wrote:
> @@ -1957,12 +1957,18 @@ void blk_io_limits_enable(BlockBackend *blk, const char *group,  Error **errp)
>      BlockDriverState *bs = blk_bs(blk), *throttle_node;
>      QDict *options = qdict_new();
>      Error *local_err = NULL;
> -    ThrottleState *ts;
> -
> -    bdrv_drained_begin(bs);
>  
>      /* Force creation of group in case it doesn't exist */
> -    ts = throttle_group_incref(group);
> +    if (!throttle_group_exists(group)) {
> +        throttle_group_new_legacy(group, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +    }

After this, the reference count of the new group is 2 (as is already
explained in throttle_group_new_legacy()).

> +    bdrv_drained_begin(bs);
> +
>      qdict_set_default_str(options, "file", bs->node_name);
>      qdict_set_default_str(options, QEMU_OPT_THROTTLE_GROUP_NAME, group);
>      throttle_node = bdrv_new_open_driver(bdrv_find_format("throttle"), NULL,

And the implicit throttle node will hold and extra reference, making it
3.

How do you delete the legacy throttle group then? block_set_io_throttle
with everything set to 0 disables I/O limits and destroys the node, but
the reference count is still 2 and the group is not destroyed.

> +static int query_throttle_groups_foreach(Object *obj, void *data)
> +{
> +    ThrottleGroup *tg;
> +    struct ThrottleGroupQuery *query = data;
> +
> +    tg = (ThrottleGroup *)object_dynamic_cast(obj, TYPE_THROTTLE_GROUP);
> +    if (!tg) {
> +        return 0;
> +    }
> +
> +    if (!g_strcmp0(query->name, tg->name)) {
> +        query->result = tg;
> +        return 1;
> +    }
> +
> +    return 0;
> +}

If you want you can make this a bit shorter if you merge both ifs:

   if (tg && !g_strcmp0(query->name, tg->name)) {
       query->result = tg;
       return 1;
   }

   return 0;

> +void throttle_group_new_legacy(const char *name, Error **errp)
> +{
> +    ThrottleGroup *tg = NULL;

No need to initialize tg here.

>  ThrottleState *throttle_group_incref(const char *name)
>  {

I think that you can make this one static and remove it from
throttle-groups.h (no one else is using it). Same with
throttle_group_unref.

Berto
