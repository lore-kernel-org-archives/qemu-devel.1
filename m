Received: from eggs.gnu.org ([2001:4830:134:3::10]:60260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZvtR-0000HR-FP
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:44:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZvtQ-0000V6-Fs
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:44:57 -0500
Date: Fri, 12 Jan 2018 09:44:29 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180112094429.GA7356@stefanha-x1.localdomain>
References: <20180112085555.14447-1-famz@redhat.com>
	<20180112085555.14447-4-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20180112085555.14447-4-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 3/9] block: Add VFIO based NVMe driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, alex.williamson@redhat.com, Markus Armbruster <armbru@redhat.com>, Karl Rister <krister@redhat.com>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 12, 2018 at 04:55:49PM +0800, Fam Zheng wrote:
> +    if (progress) {
> +        /* Notify the device so it can post more completions. */
> +        smp_mb_release();
> +        *q->cq.doorbell = cpu_to_le32(q->cq.head);
> +        if (!qemu_co_queue_empty(&q->free_req_queue)) {
> +            aio_bh_schedule_oneshot(s->aio_context, nvme_free_req_queue_cb, q);
> +        }

This is not thread-safe because the queue producer does:

1   qemu_mutex_unlock(&q->lock);
2   qemu_co_queue_wait(&q->free_req_queue, NULL);
3   qemu_mutex_lock(&q->lock);

We fail to call nvme_free_req_queue_cb() when if
(!qemu_co_queue_empty(&q->free_req_queue)) runs after 1 but before 2.

This is only an issue if one thread runs the queue producer and another
runs the consumer code.  I don't know if that will ever be the case,
even with multiqueue, but I wanted to point this out so you and Paolo
can decide.

> +static int nvme_file_open(BlockDriverState *bs, QDict *options, int flags,
> +                          Error **errp)
> +{
> +    const char *device;
> +    QemuOpts *opts;
> +    int namespace;
> +
> +    opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
> +    qemu_opts_absorb_qdict(opts, options, &error_abort);
> +    device = qemu_opt_get(opts, NVME_BLOCK_OPT_DEVICE);
> +    if (!device) {
> +        error_setg(errp, "'" NVME_BLOCK_OPT_DEVICE "' option is required");
> +        qemu_opts_del(opts);
> +        return -EINVAL;
> +    }
> +
> +    namespace = qemu_opt_get_number(opts, NVME_BLOCK_OPT_NAMESPACE, 1);
> +    nvme_init(bs, device, namespace, errp);
> +
> +    qemu_opts_del(opts);
> +    bs->supported_write_flags = BDRV_REQ_FUA;
> +    if (nvme_enable_disable_write_cache(bs, !(flags & BDRV_O_NOCACHE), errp)) {
> +        return -EINVAL;

Everything allocated in nvme_init() is leaked.

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaWIN9AAoJEJykq7OBq3PIA9IH/j2DmcZ1c7vbIb3EvTFa4Bec
F/bgFrBJvTGP2h9D8NWn0W0isQ5V8/6xrbr2BNWs0DQirN4Qnh2ObcIhpmCaqKzB
LaoIMsRBNAFc7GDbalWeT+iEbd/NGFUHJcZLjCRjPYdQyhSLr72KkEXnX5pSWbjY
ZbqGJnDnXfZ0VbdnLUuNWUJOIOf3DCjDYMCRGtNLGPnjJl4M7iKJ9A4by2Qf041L
vk6ARBUB4HF21OlFHkb/sybcNhxbJmQservxiWsuAiXKyKEYLlUe/g8CSyBPLh97
+MzEhoAkeU+9N5NuAwoAZzhdArzwFEmmhwrvrWoMTgKlgyix0poGm+5eB/pgz7s=
=D813
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
