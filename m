Received: from eggs.gnu.org ([2001:4830:134:3::10]:34137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fT1uY-0002Zw-24
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fT1uX-0001DG-1j
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:17:50 -0400
Date: Wed, 13 Jun 2018 17:17:40 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180613091740.GA15251@lemon.usersys.redhat.com>
References: <20180613074655.16289-1-famz@redhat.com>
	<20180613080621.GA4356@dhcp-200-186.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613080621.GA4356@dhcp-200-186.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] nvme: Support image creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On Wed, 06/13 10:06, Kevin Wolf wrote:
> Am 13.06.2018 um 09:46 hat Fam Zheng geschrieben:
> > Similar to the host_device's implementation, we check the requested
> > length against the namespace size.
> > 
> > Truncation is necessary to make qcow2 creation work.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> > +static int coroutine_fn nvme_co_create_opts(const char *filename, QemuOpts *opts,
> > +                                            Error **errp)
> > +{
> > +    int ret = 0;
> > +    BlockDriverState *bs = NULL;
> > +    int64_t size;
> > +
> > +    if (strncmp(filename, "nvme://", strlen("nvme://"))) {
> > +        error_setg(errp, "Invalid filename (must start with \"nvme://\")");
> > +        ret = -EINVAL;
> > +        goto out;
> > +    }
> > +
> > +    bs = bdrv_open(filename, NULL, NULL, BDRV_O_RDWR | BDRV_O_PROTOCOL, errp);
> > +    if (!bs) {
> > +        ret = -EINVAL;
> > +        goto out;
> > +    }
> > +
> > +    size = qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0);
> > +
> > +    if (size < 0 || bdrv_getlength(bs) < size) {
> > +        error_setg(errp, "Invalid image size");
> > +        ret = -EINVAL;
> > +    }
> > +
> > +out:
> > +    bdrv_unref(bs);
> > +    /* Hold breath for a little while before letting image format creation run.
> > +     * The problem is when testing with Intel P3700, the controller doesn't
> > +     * like the immediate open after close, as a result, nvme_init() will fail.
> > +     * This works around that.
> > +     **/
> > +    g_usleep(2000000);
> 
> This suggests that nbd_init() is buggy.
> 
> If we need to sleep here (for two whole seconds?!), I'm sure there are
> other cases that would have to sleep as well. So even if we can't find a
> solution other than sleeping - which feels horribly wrong - the sleep
> should probably be in nvme_init() rather than here.
> 
> What kind of error are you running into without the sleep?

The error would be the "Timeout while waiting for device to start..." in
nvme_init(), which happens after waiting for 20 seconds after setting the
device's enable bit.

If we put a sleep in nvme_init() it will hurt the blockdev-add command and QEMU
launch badly, whereas being here it hurts x-blockdev-create, qemu-img create,
etc.  Both are really bad, but the first is worse.

BTW nvme_init() already has to spin for a few seconds waiting for bit 0 in this
loop:

    while (!(le32_to_cpu(s->regs->csts) & 0x1)) {
        if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
            error_setg(errp, "Timeout while waiting for device to start (%"
                             PRId64 " ms)",
                       timeout_ms);
            ret = -ETIMEDOUT;
            goto fail_queue;
        }
    }

(we should probably insert a g_usleep(100) in the loop body, but it doesn't make
nvme_init return any faster.)

My wild guess is that the controller doesn't respond to the setting of CC.EN
(device enable) bit correctly when it is still internally busy due after a
previous reset in nvme_close(). But perhaps it probably the cleanup in
nvme_close() which is lame in the first place, compared to the complex de-init
procedure we have in vfio_pci_reset(), and that unbinding the device from Linux
nvme.ko coincidentally takes exactly 2 seconds when nvme_close() takes near 0.
What this suggests is that cleanly shutting down the device does take about two
seconds, but with the simplistic nvme_close(), the work is left asynchrously to
the controller or kernel.  I'll see if I can figure out what is missing.

Fam
