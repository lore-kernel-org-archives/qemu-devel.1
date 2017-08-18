Received: from eggs.gnu.org ([2001:4830:134:3::10]:38481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1digy6-0007VX-U2
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:05:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1digy0-0005iN-3f
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:05:42 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170818031019.3723-5-el13635@mail.ntua.gr>
References: <20170818031019.3723-1-el13635@mail.ntua.gr>
	<20170818031019.3723-5-el13635@mail.ntua.gr>
Date: Fri, 18 Aug 2017 15:05:31 +0200
Message-ID: <w51r2w958mc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 4/6] block: convert ThrottleGroup to
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

On Fri 18 Aug 2017 05:10:17 AM CEST, Manos Pitsidianakis wrote:

>   * If no ThrottleGroup is found with the given name a new one is
>   * created.
>   *
> - * @name: the name of the ThrottleGroup
> + * This function edits throttle_groups and must be called under the global
> + * mutex.
> + *
> + * @name: the name of the ThrottleGroup, NULL means a new anonymous group will
> + *        be created.
>   * @ret:  the ThrottleState member of the ThrottleGroup
>   */
>  ThrottleState *throttle_group_incref(const char *name)

If we're not going to have anonymous groups in the end this patch needs
changes (name == NULL is no longer allowed).

> +/* This function edits throttle_groups and must be called under the global
> + * mutex */
> +static void throttle_group_obj_complete(UserCreatable *obj, Error **errp)
> +{
> +    ThrottleGroup *tg = THROTTLE_GROUP(obj), *iter;
> +    ThrottleConfig *cfg = &tg->ts.cfg;
> +
> +    /* set group name to object id if it exists */
> +    if (!tg->name && tg->parent_obj.parent) {
> +        tg->name = object_get_canonical_path_component(OBJECT(obj));
> +    }
> +
> +    if (tg->name) {
> +        /* error if name is duplicate */
> +        QTAILQ_FOREACH(iter, &throttle_groups, list) {
> +            if (!g_strcmp0(tg->name, iter->name) && tg != iter) {

I'm just nitpicking here :) but if you change this and put 'tg != iter'
first you'll save one unnecessary string comparison.

> +                error_setg(errp, "A group with this name already exists");
> +                return;
> +            }
> +        }
> +    }
> +
> +    /* unfix buckets to check validity */
> +    throttle_get_config(&tg->ts, cfg);
> +    if (!throttle_is_valid(cfg, errp)) {
> +        return;
> +    }
> +    /* fix buckets again */
> +    throttle_config(&tg->ts, tg->clock_type, cfg);

throttle_get_config(ts, cfg) makes a copy of the existing configuration,
but the cfg pointer that you are passing already points to the existing
configuration, so in practice you are doing

    *(ts->cfg) = *(ts->cfg);
    throttle_unfix_bucket(...);

and since you "unfixed" the configuration, then you need undo the whole
thing by setting the config again:

    *(ts->cfg) = *(ts->cfg);
    throttle_fix_bucket(...);

You should declare a local ThrottleConfig variable, copy the config
there, and run throttle_is_valid() on that copy. The final
throttle_config() call is unnecessary.

Once the patches I sent yesterday are merged we'll be able to skip the
throttle_get_config() call and do throttle_is_valid(&tg->ts.cfg, errp)
directly.

> +static void throttle_group_set(Object *obj, Visitor *v, const char * name,
> +                               void *opaque, Error **errp)
> +
> +{
> +    ThrottleGroup *tg = THROTTLE_GROUP(obj);
> +    ThrottleConfig cfg;
> +    ThrottleParamInfo *info = opaque;
> +    Error *local_err = NULL;
> +    int64_t value;
> +
> +    /* If we have finished initialization, don't accept individual property
> +     * changes through QOM. Throttle configuration limits must be set in one
> +     * transaction, as certain combinations are invalid.
> +     */
> +    if (tg->is_initialized) {
> +        error_setg(&local_err, "Property cannot be set after initialization");
> +        goto ret;
> +    }
> +
> +    visit_type_int64(v, name, &value, &local_err);
> +    if (local_err) {
> +        goto ret;
> +    }
> +    if (value < 0) {
> +        error_setg(&local_err, "Property values cannot be negative");
> +        goto ret;
> +    }
> +
> +    cfg = tg->ts.cfg;
> +    switch (info->data_type) {
> +    case UINT64:
> +        {
> +            uint64_t *field = (void *)&cfg.buckets[info->type] + info->offset;
> +            *field = value;
> +        }
> +        break;
> +    case DOUBLE:
> +        {
> +            double *field = (void *)&cfg.buckets[info->type] + info->offset;
> +            *field = value;
> +        }
> +        break;
> +    case UNSIGNED:
> +        {
> +            if (value > UINT_MAX) {
> +                error_setg(&local_err, "%s value must be in the"
> +                                       "range [0, %u]", info->name, UINT_MAX);
> +                goto ret;
> +            }
> +            unsigned *field = (void *)&cfg.buckets[info->type] + info->offset;
> +            *field = value;
> +        }
> +    }
> +
> +    tg->ts.cfg = cfg;

There's a bit of black magic here :) you have a user-defined enumeration
(UNSIGNED, DOUBLE, UINT64) to identify C types and I'm worried about
what happens if the data types of LeakyBucket change, will we be able to
detect the problem?

Out of the blue I can think of the following alternative:

   - There's 6 different buckets (we have BucketType listing them)

   - There's 3 values we can set in each bucket (max, avg,
     burst_length). For those we can have an internal enumeration
     (probably with one additional value for iops-size).

   - In the 'properties' array, for each property we know its category
     (and I mean: avg, max, burst-lenght, iops-size) and the bucket
     where they belong.

   - In throttle_group_set() the switch could be something like this:

     switch (info->category) {
        case THROTTLE_VALUE_AVG:
           cfg->buckets[info->bkt_type].avg = value;
           break;
        case THROTTLE_VALUE_MAX:
           cfg->buckets[info->bkt_type].max = value;
           break;
        case THROTTLE_VALUE_BURST_LENGTH:
           /* Code here to check that value <= UINT_MAX */
           cfg->buckets[info->bkt_type].iops_length = value;
           break;
        case THROTTLE_VALUE_IOPS_SIZE:
           cfg->op_size = value;
     } 

> +static void throttle_group_get(Object *obj, Visitor *v, const char *name,
> +                               void *opaque, Error **errp)

And the same approach here, of course.

> +static void throttle_group_set_limits(Object *obj, Visitor *v,
> +                                      const char *name, void *opaque,
> +                                      Error **errp)
> +
> +{
> +    ThrottleGroup *tg = THROTTLE_GROUP(obj);
> +    ThrottleConfig cfg;
> +    ThrottleLimits *arg = NULL;
> +    Error *local_err = NULL;
> +
> +    arg = g_new0(ThrottleLimits, 1);

Do you need to allocate ThrottleLimits in the heap?

> +static void throttle_group_get_limits(Object *obj, Visitor *v,
> +                                      const char *name, void *opaque,
> +                                      Error **errp)
> +{
> +    ThrottleGroup *tg = THROTTLE_GROUP(obj);
> +    ThrottleConfig cfg;
> +    ThrottleLimits *arg = NULL;
> +
> +    qemu_mutex_lock(&tg->lock);
> +    throttle_get_config(&tg->ts, &cfg);
> +    qemu_mutex_unlock(&tg->lock);
> +
> +    arg = g_new0(ThrottleLimits, 1);
> +    throttle_config_to_limits(&cfg, arg);
> +
> +    visit_type_ThrottleLimits(v, name, &arg, errp);
> +    g_free(arg);

Same question here.

Berto
