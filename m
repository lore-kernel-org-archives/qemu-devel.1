Received: from eggs.gnu.org ([2001:4830:134:3::10]:54761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dfnvA-0004QI-Lo
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 09:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dfnv7-0006Bj-Ib
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 09:54:44 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170809100734.17540-6-el13635@mail.ntua.gr>
References: <20170809100734.17540-1-el13635@mail.ntua.gr>
	<20170809100734.17540-6-el13635@mail.ntua.gr>
Date: Thu, 10 Aug 2017 15:54:02 +0200
Message-ID: <w511sojy1dx.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 5/7] block: add throttle block filter
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

On Wed 09 Aug 2017 12:07:32 PM CEST, Manos Pitsidianakis wrote:
> +/* Extract ThrottleConfig options. Assumes cfg is initialized and will be
> + * checked for validity.
> + *
> + * Returns -1 and sets errp if a burst_length value is over UINT_MAX.
> + */
> +static int throttle_extract_options(QemuOpts *opts, ThrottleConfig *cfg,
> +                                    Error **errp)
> +{
> +#define IF_OPT_SET(rvalue, opt_name) \
> +    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX opt_name)) { \
> +        rvalue = qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX opt_name, 0); }
> +
> +    IF_OPT_SET(cfg->buckets[THROTTLE_BPS_TOTAL].avg, QEMU_OPT_BPS_TOTAL);
> +    IF_OPT_SET(cfg->buckets[THROTTLE_BPS_READ].avg, QEMU_OPT_BPS_READ);
> +    IF_OPT_SET(cfg->buckets[THROTTLE_BPS_WRITE].avg, QEMU_OPT_BPS_WRITE);
> +    IF_OPT_SET(cfg->buckets[THROTTLE_OPS_TOTAL].avg, QEMU_OPT_IOPS_TOTAL);
> +    IF_OPT_SET(cfg->buckets[THROTTLE_OPS_READ].avg, QEMU_OPT_IOPS_READ);
> +    IF_OPT_SET(cfg->buckets[THROTTLE_OPS_WRITE].avg, QEMU_OPT_IOPS_WRITE);
> +    IF_OPT_SET(cfg->buckets[THROTTLE_BPS_TOTAL].max, QEMU_OPT_BPS_TOTAL_MAX);
  [...]

This is all the code that I was saying that we'd save if we don't allow
setting limits here.

> +static int throttle_configure_tgm(BlockDriverState *bs,
> +                                  ThrottleGroupMember *tgm,
> +                                  QDict *options, Error **errp)
> +{
> +    int ret;
> +    ThrottleConfig cfg;
> +    const char *group_name = NULL;

No need to set it to NULL here.

> +    Error *local_err = NULL;
> +    QemuOpts *opts = qemu_opts_create(&throttle_opts, NULL, 0, &error_abort);
> +
> +    qemu_opts_absorb_qdict(opts, options, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        goto err;
> +    }
> +
> +    /* If group_name is NULL, an anonymous group will be created */
> +    group_name = qemu_opt_get(opts, QEMU_OPT_THROTTLE_GROUP_NAME);
> +
> +    /* Register membership to group with name group_name */
> +    throttle_group_register_tgm(tgm, group_name, bdrv_get_aio_context(bs));
> +
> +    /* Copy previous configuration */
> +    throttle_group_get_config(tgm, &cfg);
> +
> +    /* Change limits if user has specified them */
> +    if (throttle_extract_options(opts, &cfg, errp) ||
> +        !throttle_is_valid(&cfg, errp)) {
> +        throttle_group_unregister_tgm(tgm);
> +        goto err;
> +    }
> +    /* Update group configuration */
> +    throttle_group_config(tgm, &cfg);

We'd also spare this, and this function would remain much simpler.

> +
> +    ret = 0;
> +    goto fin;
> +
> +err:
> +    ret = -EINVAL;
> +fin:
> +    qemu_opts_del(opts);
> +    return ret;
> +}

If you set ret = -EINVAL before calling goto err you can simplify this
part as well, but feel free to ignore this suggestion.

> +static int throttle_reopen_prepare(BDRVReopenState *reopen_state,
> +                                   BlockReopenQueue *queue, Error **errp)
> +{
> +    ThrottleGroupMember *tgm = NULL;
> +
> +    assert(reopen_state != NULL);
> +    assert(reopen_state->bs != NULL);
> +
> +    reopen_state->opaque = g_new0(ThrottleGroupMember, 1);
> +    tgm = reopen_state->opaque;
> +
> +    return throttle_configure_tgm(reopen_state->bs, tgm, reopen_state->options,
> +            errp);
> +}

I would rename 'reopen_state' as 'state' for consistency with the other
two functions.

> +static void throttle_reopen_commit(BDRVReopenState *state)
> +{
> +    ThrottleGroupMember *tgm = state->bs->opaque;
> +
> +    throttle_group_unregister_tgm(tgm);
> +    g_free(state->bs->opaque);
> +    state->bs->opaque = state->opaque;
> +    state->opaque = NULL;
> +}

I also find the mixing of state->bs->opaque and tgm a bit confusing.
Here's a suggestion, but feel free to ignore it:

    ThrottleGroupMember *old_tgm = state->bs->opaque;
    ThrottleGroupMember *new_tgm = state->opaque;

    throttle_group_unregister_tgm(old_tgm);
    g_free(old_tgm);

    state->bs->opaque = new_tgm;
    state->opaque = NULL;

> +static void throttle_reopen_abort(BDRVReopenState *state)
> +{
> +    ThrottleGroupMember *tgm = state->opaque;
> +
> +    throttle_group_unregister_tgm(tgm);
> +    g_free(state->opaque);
> +    state->opaque = NULL;
> +}

Similar problem here (this one is simpler though).

Apart from the general question of whether we're parsing the limits in
this driver, the rest are just comments about the style. Otherwise the
code looks good, thanks!

Berto
