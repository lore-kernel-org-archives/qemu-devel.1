Received: from eggs.gnu.org ([2001:4830:134:3::10]:40002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dkwuW-0006Ce-9r
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 14:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dkwuQ-0001JZ-FT
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 14:31:20 -0400
Date: Thu, 24 Aug 2017 19:31:10 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170824183110.GB4368@stefanha-x1.localdomain>
References: <20170822101535.4695-1-el13635@mail.ntua.gr>
	<20170822101535.4695-5-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170822101535.4695-5-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v7 4/6] block: convert
 ThrottleGroup to object with QOM
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

On Tue, Aug 22, 2017 at 01:15:33PM +0300, Manos Pitsidianakis wrote:
>  /* Increments the reference count of a ThrottleGroup given its name.
>   *
>   * If no ThrottleGroup is found with the given name a new one is
>   * created.
>   *
> + * This function edits throttle_groups and must be called under the global
> + * mutex.
> + *
>   * @name: the name of the ThrottleGroup
>   * @ret:  the ThrottleState member of the ThrottleGroup
>   */
>  ThrottleState *throttle_group_incref(const char *name)
>  {
>      ThrottleGroup *tg = NULL;
> -    ThrottleGroup *iter;
> -
> -    qemu_mutex_lock(&throttle_groups_lock);
>  
>      /* Look for an existing group with that name */
> -    QTAILQ_FOREACH(iter, &throttle_groups, list) {
> -        if (!strcmp(name, iter->name)) {
> -            tg = iter;
> -            break;
> -        }
> -    }
> +    tg = throttle_group_by_name(name);
>  
> -    /* Create a new one if not found */
> -    if (!tg) {
> -        tg = g_new0(ThrottleGroup, 1);
> +    if (tg) {
> +        object_ref(OBJECT(tg));
> +    } else {
> +        /* Create a new one if not found */
> +        /* new ThrottleGroup obj will have a refcnt = 1 */
> +        tg = THROTTLE_GROUP(object_new(TYPE_THROTTLE_GROUP));
>          tg->name = g_strdup(name);
> -        tg->clock_type = QEMU_CLOCK_REALTIME;
> -
> -        if (qtest_enabled()) {
> -            /* For testing block IO throttling only */
> -            tg->clock_type = QEMU_CLOCK_VIRTUAL;
> -        }
> -        qemu_mutex_init(&tg->lock);
> -        throttle_init(&tg->ts);
> -        QLIST_INIT(&tg->head);
> -
> -        QTAILQ_INSERT_TAIL(&throttle_groups, tg, list);

This is where the ThrottleGroup needs to be added to the QOM tree:

    object_property_add_child(object_get_objects_root(),
                              id, obj, &local_err);

> +        throttle_group_obj_complete((UserCreatable *)tg, &error_abort);

This cast is risky - if UserCreatable ever adds fields it can break.
Please use a QOM cast: USER_CREATABLE(tg).  It uses the type information
and finds the interface.

> +static ThrottleParamInfo properties[] = {

This array can be const.

> +{

Missing indentation.  Seems unusual but I guess you're trying to avoid
reaching 80 chars?  If checkpatch.pl doesn't complain then you can get
away with it but normal indentation would be best.

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

Please use break statements even for the last case.  If another case is
added later it might accidentally fall through without a break
statement.
