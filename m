Received: from eggs.gnu.org ([2001:4830:134:3::10]:48380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fT0nX-00057v-NK
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:06:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fT0nW-0002Da-T1
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:06:31 -0400
Date: Wed, 13 Jun 2018 10:06:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180613080621.GA4356@dhcp-200-186.str.redhat.com>
References: <20180613074655.16289-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613074655.16289-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] nvme: Support image creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 13.06.2018 um 09:46 hat Fam Zheng geschrieben:
> Similar to the host_device's implementation, we check the requested
> length against the namespace size.
> 
> Truncation is necessary to make qcow2 creation work.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

> +static int coroutine_fn nvme_co_create_opts(const char *filename, QemuOpts *opts,
> +                                            Error **errp)
> +{
> +    int ret = 0;
> +    BlockDriverState *bs = NULL;
> +    int64_t size;
> +
> +    if (strncmp(filename, "nvme://", strlen("nvme://"))) {
> +        error_setg(errp, "Invalid filename (must start with \"nvme://\")");
> +        ret = -EINVAL;
> +        goto out;
> +    }
> +
> +    bs = bdrv_open(filename, NULL, NULL, BDRV_O_RDWR | BDRV_O_PROTOCOL, errp);
> +    if (!bs) {
> +        ret = -EINVAL;
> +        goto out;
> +    }
> +
> +    size = qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0);
> +
> +    if (size < 0 || bdrv_getlength(bs) < size) {
> +        error_setg(errp, "Invalid image size");
> +        ret = -EINVAL;
> +    }
> +
> +out:
> +    bdrv_unref(bs);
> +    /* Hold breath for a little while before letting image format creation run.
> +     * The problem is when testing with Intel P3700, the controller doesn't
> +     * like the immediate open after close, as a result, nvme_init() will fail.
> +     * This works around that.
> +     **/
> +    g_usleep(2000000);

This suggests that nbd_init() is buggy.

If we need to sleep here (for two whole seconds?!), I'm sure there are
other cases that would have to sleep as well. So even if we can't find a
solution other than sleeping - which feels horribly wrong - the sleep
should probably be in nvme_init() rather than here.

What kind of error are you running into without the sleep?

Kevin
