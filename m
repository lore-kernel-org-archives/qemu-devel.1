Received: from eggs.gnu.org ([2001:4830:134:3::10]:52225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dk9Bl-0001H1-PB
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dk9Bi-0001jv-BK
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:25:49 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170822101535.4695-5-el13635@mail.ntua.gr>
References: <20170822101535.4695-1-el13635@mail.ntua.gr>
	<20170822101535.4695-5-el13635@mail.ntua.gr>
Date: Tue, 22 Aug 2017 15:25:41 +0200
Message-ID: <w51ziarg2ei.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 4/6] block: convert ThrottleGroup to
 object with QOM
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

On Tue 22 Aug 2017 12:15:33 PM CEST, Manos Pitsidianakis wrote:

> +static ThrottleGroup *throttle_group_by_name(const char *name)
> +{
> +    ThrottleGroup *iter;
> +
> +    /* Look for an existing group with that name */
> +    QTAILQ_FOREACH(iter, &throttle_groups, list) {
> +        if (!g_strcmp0(name, iter->name)) {
> +            return iter;
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
> +static bool throttle_group_exists(const char *name)
> +{
> +    return throttle_group_by_name(name) ? true : false;
> +}

 "foo ? true : false" is redundant, it means
 "if foo is true, then true; if foo is false, then false"

I'd leave it as 'throttle_group_by_name(name) != NULL'.

Or you can simply remove the function and put that expression in
throttle_group_obj_complete(), where you call it.

> +#undef THROTTLE_OPT_PREFIX
> +#define THROTTLE_OPT_PREFIX "x-"
> +
> +/* Helper struct and array for QOM property setter/getter */
> +typedef struct {
> +    const char *name;
> +    BucketType type;
> +    enum LeakyBucketField {
> +        AVG,
> +        MAX,
> +        BURST_LENGTH,
> +        IOPS_SIZE,
> +    } category;
> +} ThrottleParamInfo;

I think it looks much nicer now :) I don't think you need to name the
enum (LeakyBucketField) by the way.

> +/* This function edits throttle_groups and must be called under the global
> + * mutex */
> +static void throttle_group_obj_complete(UserCreatable *obj, Error **errp)
> +{
> +    ThrottleGroup *tg = THROTTLE_GROUP(obj);
> +    ThrottleConfig cfg;
> +
> +    /* set group name to object id if it exists */
> +    if (!tg->name && tg->parent_obj.parent) {
> +        tg->name = object_get_canonical_path_component(OBJECT(obj));
> +    }
> +    /* We must have a group name at this point */
> +    assert(tg->name);
> +
> +    /* error if name is duplicate */
> +    if (throttle_group_exists(tg->name)) {
> +            error_setg(errp, "A group with this name already exists");
> +            return;
> +    }
> +
> +    /* check validity */
> +    throttle_get_config(&tg->ts, &cfg);
> +    if (!throttle_is_valid(&cfg, errp)) {
> +        return;
> +    }

My fault here because I suggested its removal, but I actually think we
still need to call throttle_config() here so bkt->max is initialized in
throttle_fix_bucket(). I'll take care of updating this call once my
patches to remove throttle_fix_bucket() are applied, but for now we
still need it.

> +    cfg = tg->ts.cfg;
> +    switch (info->category) {
> +    case AVG:
> +        cfg.buckets[info->type].avg = value;
> +        break;
> +    case MAX:
> +        cfg.buckets[info->type].max = value;
> +        break;
> +    case BURST_LENGTH:
> +        if (value > UINT_MAX) {
> +            error_setg(&local_err, "%s value must be in the"
> +                    "range [0, %u]", info->name, UINT_MAX);
> +            goto ret;
> +        }
> +        cfg.buckets[info->type].burst_length = value;
> +        break;
> +    case IOPS_SIZE:
> +        cfg.op_size = value;
> +    }
> +
> +    tg->ts.cfg = cfg;

I like how this looks now. Perhaps we can get rid of the local cfg
variable and use a pointer instead, there's no need to copy the config
back and forth.

Berto
