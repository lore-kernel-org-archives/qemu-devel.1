Received: from eggs.gnu.org ([2001:4830:134:3::10]:34690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dpENY-0006Qm-4x
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dpENT-00018l-Kn
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:59:00 -0400
Date: Tue, 5 Sep 2017 14:58:41 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170905135841.GP17449@stefanha-x1.localdomain>
References: <20170825132028.6184-1-el13635@mail.ntua.gr>
	<20170825132028.6184-6-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170825132028.6184-6-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v9 5/6] block: add throttle block filter
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

On Fri, Aug 25, 2017 at 04:20:27PM +0300, Manos Pitsidianakis wrote:
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

error_setg() messages do not end with punctuation:

  error_setg(errp, "Please specify a throttle group");

This is not worth respinning for though.

> +        ret = -EINVAL;
> +        goto fin;
> +    } else if (!throttle_group_exists(group_name)) {
> +        error_setg(errp, "Throttle group '%s' does not exist.", group_name);

Same here.

Anyway:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
